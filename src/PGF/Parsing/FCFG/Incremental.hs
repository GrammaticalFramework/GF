{-# LANGUAGE BangPatterns #-}
module PGF.Parsing.FCFG.Incremental
          ( ParseState
          , initState
          , nextState
          , getCompletions
          , extractTrees
          , parse
          ) where

import Data.Array.IArray
import Data.Array.Base (unsafeAt)
import Data.List (isPrefixOf, foldl')
import Data.Maybe (fromMaybe, maybe)
import qualified Data.Map as Map
import qualified GF.Data.TrieMap as TMap
import qualified Data.IntMap as IntMap
import qualified Data.Set as Set
import Control.Monad

import GF.Data.SortedList
import PGF.CId
import PGF.Data
import PGF.Expr(Tree)
import PGF.Macros
import PGF.TypeCheck
import Debug.Trace

parse :: PGF -> Language -> Type -> [String] -> [Expr]
parse pgf lang typ toks = maybe [] (\ps -> extractTrees ps typ) (foldM nextState (initState pgf lang typ) toks)

-- | Creates an initial parsing state for a given language and
-- startup category.
initState :: PGF -> Language -> Type -> ParseState
initState pgf lang (DTyp _ start _) = 
  let items = do
        cat <- fromMaybe [] (Map.lookup start (startCats pinfo))
        (funid,args) <- foldForest (\funid args -> (:) (funid,args)) (\_ _ args -> args)
                                   [] cat (productions pinfo)
        let FFun fn _ lins = functions pinfo ! funid
        (lbl,seqid) <- assocs lins
        return (Active 0 0 funid seqid args (AK cat lbl))
     
      pinfo =
        case lookParser pgf lang of
          Just pinfo -> pinfo
          _          -> error ("Unknown language: " ++ showCId lang)

  in State pgf
           pinfo
           (Chart emptyAC [] emptyPC (productions pinfo) (totalCats pinfo) 0)
           (TMap.singleton [] (Set.fromList items))

-- | From the current state and the next token
-- 'nextState' computes a new state where the token
-- is consumed and the current position shifted by one.
nextState :: ParseState -> String -> Maybe ParseState
nextState (State pgf pinfo chart items) t =
  let (mb_agenda,map_items) = TMap.decompose items
      agenda = maybe [] Set.toList mb_agenda
      acc    = fromMaybe TMap.empty (Map.lookup t map_items)
      (acc1,chart1) = process (Just t) add (sequences pinfo) (functions pinfo) agenda acc chart
      chart2 = chart1{ active =emptyAC
                     , actives=active chart1 : actives chart1
                     , passive=emptyPC
                     , offset =offset chart1+1
                     }
  in if TMap.null acc1
       then Nothing
       else Just (State pgf pinfo chart2 acc1)
  where
    add (tok:toks) item acc
      | tok == t            = TMap.insertWith Set.union toks (Set.singleton item) acc
    add _          item acc = acc

-- | If the next token is not known but only its prefix (possible empty prefix)
-- then the 'getCompletions' function can be used to calculate the possible
-- next words and the consequent states. This is used for word completions in
-- the GF interpreter.
getCompletions :: ParseState -> String -> Map.Map String ParseState
getCompletions (State pgf pinfo chart items) w =
  let (mb_agenda,map_items) = TMap.decompose items
      agenda = maybe [] Set.toList mb_agenda
      acc    = Map.filterWithKey (\tok _ -> isPrefixOf w tok) map_items
      (acc',chart1) = process Nothing add (sequences pinfo) (functions pinfo) agenda acc chart
      chart2 = chart1{ active =emptyAC
                     , actives=active chart1 : actives chart1
                     , passive=emptyPC
                     , offset =offset chart1+1
                     }
  in fmap (State pgf pinfo chart2) acc'
  where
    add (tok:toks) item acc
      | isPrefixOf w tok    = Map.insertWith (TMap.unionWith Set.union) tok (TMap.singleton toks (Set.singleton item)) acc
    add _          item acc = acc

-- | This function extracts the list of all completed parse trees
-- that spans the whole input consumed so far. The trees are also
-- limited by the category specified, which is usually
-- the same as the startup category.
extractTrees :: ParseState -> Type -> [Tree]
extractTrees (State pgf pinfo chart items) ty@(DTyp _ start _) = 
  nubsort [e1 | e <- exps, Right e1 <- [checkExpr pgf e ty]]
  where
    (mb_agenda,acc) = TMap.decompose items
    agenda = maybe [] Set.toList mb_agenda
    (_,st) = process Nothing (\_ _ -> id) (sequences pinfo) (functions pinfo) agenda () chart

    exps = do
      cat <- fromMaybe [] (Map.lookup start (startCats pinfo))
      (funid,args) <- foldForest (\funid args -> (:) (funid,args)) (\_ _ args -> args)
                                 [] cat (productions pinfo)
      let FFun fn _ lins = functions pinfo ! funid
      lbl <- indices lins
      Just fid <- [lookupPC (PK cat lbl 0) (passive st)]
      (fvs,tree) <- go Set.empty 0 (0,fid)
      guard (Set.null fvs)
      return tree

    go rec fcat' (d,fcat)
      | fcat < totalCats pinfo = return (Set.empty,EMeta (fcat'*10+d))   -- FIXME: here we assume that every rule has at most 10 arguments
      | Set.member fcat rec    = mzero
      | otherwise              = foldForest (\funid args trees -> 
                                                  do let FFun fn _ lins = functions pinfo ! funid
                                                     args <- mapM (go (Set.insert fcat rec) fcat) (zip [0..] args)
                                                     check_ho_fun fn args
                                                  `mplus`
                                                  trees)
                                            (\const _ trees ->
                                                  return (freeVar const,const)
                                                  `mplus`
                                                  trees)
                                            [] fcat (forest st)

    check_ho_fun fun args
      | fun == _V = return (head args)
      | fun == _B = return (foldl1 Set.difference (map fst args), foldr (\x e -> EAbs Explicit (mkVar (snd x)) e) (snd (head args)) (tail args))
      | otherwise = return (Set.unions (map fst args),foldl (\e x -> EApp e (snd x)) (EFun fun) args)
    
    mkVar (EFun  v) = v
    mkVar (EMeta _) = wildCId
    
    freeVar (EFun v) = Set.singleton v
    freeVar _        = Set.empty

_B = mkCId "_B"
_V = mkCId "_V"

process mbt fn !seqs !funs []                                                 acc chart = (acc,chart)
process mbt fn !seqs !funs (item@(Active j ppos funid seqid args key0):items) acc chart
  | inRange (bounds lin) ppos =
      case unsafeAt lin ppos of
        FSymCat d r -> let !fid = args !! d
                           key  = AK fid r
                                
                           items2 = case lookupPC (mkPK key k) (passive chart) of
                                      Nothing -> items
                                      Just id -> (Active j (ppos+1) funid seqid (updateAt d id args) key0) : items
                           items3 = foldForest (\funid args items -> Active k 0 funid (rhs funid r) args key : items)
                                               (\_ _ items -> items)
                                               items2 fid (forest chart)
                       in case lookupAC key (active chart) of
                            Nothing                        -> process mbt fn seqs funs items3 acc chart{active=insertAC key (Set.singleton item) (active chart)}
                            Just set | Set.member item set -> process mbt fn seqs funs items  acc chart
                                     | otherwise           -> process mbt fn seqs funs items2 acc chart{active=insertAC key (Set.insert item set) (active chart)}
      	FSymKS toks -> let !acc' = fn toks (Active j (ppos+1) funid seqid args key0) acc
                       in process mbt fn seqs funs items acc' chart
      	FSymKP strs vars
      	            -> let !acc' = foldl (\acc toks -> fn toks (Active j (ppos+1) funid seqid args key0) acc) acc
      	                             (strs:[strs' | Alt strs' _ <- vars])
                       in process mbt fn seqs funs items acc' chart
        FSymLit d r -> let !fid = args !! d
                       in case [ts | FConst _ ts <- maybe [] Set.toList (IntMap.lookup fid (forest chart))] of
                            (toks:_) -> let !acc' = fn toks (Active j (ppos+1) funid seqid args key0) acc
                                        in process mbt fn seqs funs items acc' chart
                            []       -> case litCatMatch fid mbt of
                                          Just (toks,lit) -> let fid'  = nextId chart
                                                                 !acc' = fn toks (Active j (ppos+1) funid seqid (updateAt d fid' args) key0) acc
                                                             in process mbt fn seqs funs items acc' chart{forest=IntMap.insert fid' (Set.singleton (FConst lit toks)) (forest chart)
                                                                                                         ,nextId=nextId chart+1
                                                                                                         }
                                          Nothing         -> process mbt fn seqs funs items acc chart
  | otherwise =
      case lookupPC (mkPK key0 j) (passive chart) of
        Nothing -> let fid = nextId chart
                       
                       items2 = case lookupAC key0 ((active chart:actives chart) !! (k-j)) of
                                  Nothing  -> items
                                  Just set -> Set.fold (\(Active j' ppos funid seqid args keyc) -> 
                                                            let FSymCat d _ = unsafeAt (unsafeAt seqs seqid) ppos
                                                            in (:) (Active j' (ppos+1) funid seqid (updateAt d fid args) keyc)) items set
	           in process mbt fn seqs funs items2 acc chart{passive=insertPC (mkPK key0 j) fid (passive chart)
                                                               ,forest =IntMap.insert fid (Set.singleton (FApply funid args)) (forest chart)
                                                               ,nextId =nextId chart+1
                                                               }
        Just id -> let items2 = [Active k 0 funid (rhs funid r) args (AK id r) | r <- labelsAC id (active chart)] ++ items
                   in process mbt fn seqs funs items2 acc chart{forest = IntMap.insertWith Set.union id (Set.singleton (FApply funid args)) (forest chart)}
  where
    !lin = unsafeAt seqs seqid
    !k   = offset chart

    mkPK (AK fid lbl) j = PK fid lbl j
    
    rhs funid lbl = unsafeAt lins lbl
      where
        FFun _ _ lins = unsafeAt funs funid


updateAt :: Int -> a -> [a] -> [a]
updateAt nr x xs = [if i == nr then x else y | (i,y) <- zip [0..] xs]

litCatMatch fcat (Just t)
  | fcat == fcatString = Just ([t],ELit (LStr t))
  | fcat == fcatInt    = case reads t of {[(n,"")] -> Just ([t],ELit (LInt n));
                                         _         -> Nothing }
  | fcat == fcatFloat  = case reads t of {[(d,"")] -> Just ([t],ELit (LFlt d));
                                         _         -> Nothing }
  | fcat == fcatVar    = Just ([t],EFun (mkCId t))
litCatMatch _    _     = Nothing


----------------------------------------------------------------
-- Active Chart
----------------------------------------------------------------

data Active
  = Active {-# UNPACK #-} !Int
           {-# UNPACK #-} !FPointPos
           {-# UNPACK #-} !FunId
           {-# UNPACK #-} !SeqId
                           [FCat]
           {-# UNPACK #-} !ActiveKey
  deriving (Eq,Show,Ord)
data ActiveKey
  = AK {-# UNPACK #-} !FCat
       {-# UNPACK #-} !FIndex
  deriving (Eq,Ord,Show)
type ActiveChart  = IntMap.IntMap (IntMap.IntMap (Set.Set Active))

emptyAC :: ActiveChart
emptyAC = IntMap.empty

lookupAC :: ActiveKey -> ActiveChart -> Maybe (Set.Set Active)
lookupAC (AK fcat l) chart = IntMap.lookup fcat chart >>= IntMap.lookup l

labelsAC :: FCat -> ActiveChart -> [FIndex]
labelsAC fcat chart = 
  case IntMap.lookup fcat chart of
    Nothing  -> []
    Just map -> IntMap.keys map

insertAC :: ActiveKey -> Set.Set Active -> ActiveChart -> ActiveChart
insertAC (AK fcat l) set chart = IntMap.insertWith IntMap.union fcat (IntMap.singleton l set) chart


----------------------------------------------------------------
-- Passive Chart
----------------------------------------------------------------

data PassiveKey
  = PK {-# UNPACK #-} !FCat
       {-# UNPACK #-} !FIndex
       {-# UNPACK #-} !Int
  deriving (Eq,Ord,Show)

type PassiveChart = Map.Map PassiveKey FCat 

emptyPC :: PassiveChart
emptyPC = Map.empty

lookupPC :: PassiveKey -> PassiveChart -> Maybe FCat
lookupPC key chart = Map.lookup key chart

insertPC :: PassiveKey -> FCat -> PassiveChart -> PassiveChart
insertPC key fcat chart = Map.insert key fcat chart


----------------------------------------------------------------
-- Forest
----------------------------------------------------------------

foldForest :: (FunId -> [FCat] -> b -> b) -> (Expr -> [String] -> b -> b) -> b -> FCat -> IntMap.IntMap (Set.Set Production) -> b
foldForest f g b fcat forest =
  case IntMap.lookup fcat forest of
    Nothing  -> b
    Just set -> Set.fold foldProd b set
  where
    foldProd (FCoerce fcat)      b = foldForest f g b fcat forest
    foldProd (FApply funid args) b = f funid args b
    foldProd (FConst const toks) b = g const toks b


----------------------------------------------------------------
-- Parse State
----------------------------------------------------------------

-- | An abstract data type whose values represent
-- the current state in an incremental parser.
data ParseState = State PGF ParserInfo Chart (TMap.TrieMap String (Set.Set Active))

data Chart
  = Chart
      { active  :: ActiveChart
      , actives :: [ActiveChart]
      , passive :: PassiveChart
      , forest  :: IntMap.IntMap (Set.Set Production)
      , nextId  :: {-# UNPACK #-} !FCat
      , offset  :: {-# UNPACK #-} !Int
      }
      deriving Show
