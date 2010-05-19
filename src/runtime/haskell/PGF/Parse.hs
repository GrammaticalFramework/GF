{-# LANGUAGE BangPatterns #-}
module PGF.Parse
          ( ParseState
          , ErrorState
          , initState
          , nextState
          , getCompletions
          , recoveryStates
          , ParseResult(..), getParseResult
          , parse
          , parseWithRecovery
          ) where

import Data.Array.IArray
import Data.Array.Base (unsafeAt)
import Data.List (isPrefixOf, foldl')
import Data.Maybe (fromMaybe, maybe, maybeToList)
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
import PGF.Forest(Forest(Forest), linearizeWithBrackets)

-- | This data type encodes the different outcomes which you could get from the parser.
data ParseResult
  = ParseFailed Int                -- ^ The integer is the position in number of tokens where the parser failed.
  | TypeError   FId [TcError]      -- ^ The parsing was successful but none of the trees is type correct. 
                                   -- The forest id ('FId') points to the bracketed string from the parser
                                   -- where the type checking failed. More than one error is returned
                                   -- if there are many analizes for some phrase but they all are not type correct.
  | ParseResult [Tree]             -- ^ If the parsing was successful we get a list of abstract syntax trees. The list should be non-empty.

parse :: PGF -> Language -> Type -> [String] -> (ParseResult,BracketedString)
parse pgf lang typ toks = loop (initState pgf lang typ) toks
  where
    loop ps []     = getParseResult ps typ
    loop ps (t:ts) = case nextState ps t of
                       Left  es -> case es of
                                     EState _ _ chart -> (ParseFailed (offset chart),snd (getParseResult ps typ))
                       Right ps -> loop ps ts

parseWithRecovery :: PGF -> Language -> Type -> [Type] -> [String] -> (ParseResult,BracketedString)
parseWithRecovery pgf lang typ open_typs toks = accept (initState pgf lang typ) toks
  where
    accept ps []     = getParseResult ps typ
    accept ps (t:ts) =
      case nextState ps t of
        Right ps -> accept ps ts
        Left  es -> skip (recoveryStates open_typs es) ts

    skip ps_map []     = getParseResult (fst ps_map) typ
    skip ps_map (t:ts) =
      case Map.lookup t (snd ps_map) of
        Just ps -> accept ps ts
        Nothing -> skip ps_map ts

-- | Creates an initial parsing state for a given language and
-- startup category.
initState :: PGF -> Language -> Type -> ParseState
initState pgf lang (DTyp _ start _) = 
  let items = case Map.lookup start (cnccats cnc) of
                Just (CncCat s e labels) -> do cat <- range (s,e)
                                               (funid,args) <- foldForest (\funid args -> (:) (funid,args)) (\_ _ args -> args)
                                                                          [] cat (pproductions cnc)
                                               let CncFun fn lins = cncfuns cnc ! funid
                                               (lbl,seqid) <- assocs lins
                                               return (Active 0 0 funid seqid args (AK cat lbl))
                Nothing                  -> mzero

      cnc = lookConcrComplete pgf lang

  in PState pgf
            cnc
            (Chart emptyAC [] emptyPC (pproductions cnc) (totalCats cnc) 0)
            (TMap.singleton [] (Set.fromList items))

-- | From the current state and the next token
-- 'nextState' computes a new state, where the token
-- is consumed and the current position is shifted by one.
-- If the new token cannot be accepted then an error state 
-- is returned.
nextState :: ParseState -> String -> Either ErrorState ParseState
nextState (PState pgf cnc chart items) t =
  let (mb_agenda,map_items) = TMap.decompose items
      agenda = maybe [] Set.toList mb_agenda
      acc    = fromMaybe TMap.empty (Map.lookup t map_items)
      (acc1,chart1) = process (Just t) add (sequences cnc) (cncfuns cnc) agenda acc chart
      chart2 = chart1{ active =emptyAC
                     , actives=active chart1 : actives chart1
                     , passive=emptyPC
                     , offset =offset chart1+1
                     }
  in if TMap.null acc1
       then Left  (EState pgf cnc chart2)
       else Right (PState pgf cnc chart2 acc1)
  where
    add (tok:toks) item acc
      | tok == t            = TMap.insertWith Set.union toks (Set.singleton item) acc
    add _          item acc = acc

-- | If the next token is not known but only its prefix (possible empty prefix)
-- then the 'getCompletions' function can be used to calculate the possible
-- next words and the consequent states. This is used for word completions in
-- the GF interpreter.
getCompletions :: ParseState -> String -> Map.Map String ParseState
getCompletions (PState pgf cnc chart items) w =
  let (mb_agenda,map_items) = TMap.decompose items
      agenda = maybe [] Set.toList mb_agenda
      acc    = Map.filterWithKey (\tok _ -> isPrefixOf w tok) map_items
      (acc',chart1) = process Nothing add (sequences cnc) (cncfuns cnc) agenda acc chart
      chart2 = chart1{ active =emptyAC
                     , actives=active chart1 : actives chart1
                     , passive=emptyPC
                     , offset =offset chart1+1
                     }
  in fmap (PState pgf cnc chart2) acc'
  where
    add (tok:toks) item acc
      | isPrefixOf w tok    = Map.insertWith (TMap.unionWith Set.union) tok (TMap.singleton toks (Set.singleton item)) acc
    add _          item acc = acc

recoveryStates :: [Type] -> ErrorState -> (ParseState, Map.Map String ParseState)
recoveryStates open_types (EState pgf cnc chart) =
  let open_fcats = concatMap type2fcats open_types
      agenda = foldl (complete open_fcats) [] (actives chart)
      (acc,chart1) = process Nothing add (sequences cnc) (cncfuns cnc) agenda Map.empty chart
      chart2 = chart1{ active =emptyAC
                     , actives=active chart1 : actives chart1
                     , passive=emptyPC
                     , offset =offset chart1+1
                     }
  in (PState pgf cnc chart (TMap.singleton [] (Set.fromList agenda)), fmap (PState pgf cnc chart2) acc)
  where
    type2fcats (DTyp _ cat _) = case Map.lookup cat (cnccats cnc) of
                                  Just (CncCat s e labels) -> range (s,e)
                                  Nothing                  -> []

    complete open_fcats items ac = 
      foldl (Set.fold (\(Active j' ppos funid seqid args keyc) -> 
                           (:) (Active j' (ppos+1) funid seqid args keyc)))
            items
            [set | fcat <- open_fcats, set <- lookupACByFCat fcat ac]

    add (tok:toks) item acc = Map.insertWith (TMap.unionWith Set.union) tok (TMap.singleton toks (Set.singleton item)) acc

-- | This function extracts the list of all completed parse trees
-- that spans the whole input consumed so far. The trees are also
-- limited by the category specified, which is usually
-- the same as the startup category.
getParseResult :: ParseState -> Type -> (ParseResult,BracketedString)
getParseResult (PState pgf cnc chart items) ty@(DTyp _ start _) =
  let froots | null roots = getPartialSeq (sequences cnc) (reverse (active st : actives st)) acc1
             | otherwise  = [([SymCat 0 lbl],[fid]) | AK fid lbl <- roots]

      bs    = linearizeWithBrackets (Forest (abstract pgf) cnc (forest st) froots)
              
                
      exps  = nubsort $ do
                (AK fid lbl) <- roots
                (fvs,e) <- go Set.empty 0 (0,fid)
                guard (Set.null fvs)
                Right e1 <- [checkExpr pgf e ty]
                return e1

      res   = if null exps
                then ParseFailed (offset chart)
                else ParseResult exps

  in (res,bs)
  where
    (mb_agenda,acc) = TMap.decompose items
    agenda = maybe [] Set.toList mb_agenda
    (acc1,st) = process Nothing add (sequences cnc) (cncfuns cnc) agenda [] chart

    add _ (Active j ppos funid seqid args key) items = (j,lin,args,key) : items
      where
        lin  = take (ppos-1) (elems (unsafeAt (sequences cnc) seqid))

    roots = case Map.lookup start (cnccats cnc) of
              Just (CncCat s e lbls) -> do cat <- range (s,e)
                                           lbl <- indices lbls
                                           fid <- maybeToList (lookupPC (PK cat lbl 0) (passive st))
                                           return (AK fid lbl)
              Nothing                -> mzero

    go rec fcat' (d,fcat)
      | fcat < totalCats cnc = return (Set.empty,EMeta (fcat'*10+d))   -- FIXME: here we assume that every rule has at most 10 arguments
      | Set.member fcat rec  = mzero
      | otherwise            = foldForest (\funid args trees -> 
                                                  do let CncFun fn lins = cncfuns cnc ! funid
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

getPartialSeq seqs actives = expand Set.empty
  where
    expand acc [] = 
      [(lin,args) | (j,lin,args,key) <- Set.toList acc, j == 0]
    expand acc (item@(j,lin,args,key) : items)
      | item `Set.member` acc = expand acc  items
      | otherwise             = expand acc' items'
      where
        acc'   = Set.insert item acc
        items' = case lookupAC key (actives !! j) of
                   Nothing  -> items
                   Just set -> [if j' < j
                                  then let lin' = take ppos (elems (unsafeAt seqs seqid))
                                       in (j',lin'++map (inc (length args')) lin,args'++args,key')
                                  else (j',lin,args,key') | Active j' ppos funid seqid args' key' <- Set.toList set] ++ items

    inc n (SymCat d r) = SymCat (n+d) r
    inc n (SymLit d r) = SymLit (n+d) r
    inc n s            = s

process mbt fn !seqs !funs []                                                 acc chart = (acc,chart)
process mbt fn !seqs !funs (item@(Active j ppos funid seqid args key0):items) acc chart
  | inRange (bounds lin) ppos =
      case unsafeAt lin ppos of
        SymCat d r -> let !fid = args !! d
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
      	SymKS toks -> let !acc' = fn toks (Active j (ppos+1) funid seqid args key0) acc
                      in process mbt fn seqs funs items acc' chart
      	SymKP strs vars
      	           -> let !acc' = foldl (\acc toks -> fn toks (Active j (ppos+1) funid seqid args key0) acc) acc
                                   (strs:[strs' | Alt strs' _ <- vars])
                      in process mbt fn seqs funs items acc' chart
        SymLit d r -> let fid   = args !! d
                          key   = AK fid r
                          !fid' = case lookupPC (mkPK key k) (passive chart) of
                                    Nothing  -> fid
                                    Just fid -> fid

                      in case [ts | PConst _ _ ts <- maybe [] Set.toList (IntMap.lookup fid' (forest chart))] of
                           (toks:_) -> let !acc' = fn toks (Active j (ppos+1) funid seqid (updateAt d fid' args) key0) acc
                                       in process mbt fn seqs funs items acc' chart
                           []       -> case litCatMatch fid mbt of
                                         Just (cat,lit,toks) 
                                                     -> let fid'  = nextId chart
                                                            !acc' = fn toks (Active j (ppos+1) funid seqid (updateAt d fid' args) key0) acc
                                                        in process mbt fn seqs funs items acc' chart{passive=insertPC (mkPK key k) fid' (passive chart)
                                                                                                    ,forest =IntMap.insert fid' (Set.singleton (PConst cat lit toks)) (forest chart)
                                                                                                    ,nextId =nextId chart+1
                                                                                                    }
                                         Nothing     -> process mbt fn seqs funs items acc chart
  | otherwise =
      case lookupPC (mkPK key0 j) (passive chart) of
        Nothing -> let fid = nextId chart
                       
                       items2 = case lookupAC key0 ((active chart:actives chart) !! (k-j)) of
                                  Nothing  -> items
                                  Just set -> Set.fold (\(Active j' ppos funid seqid args keyc) -> 
                                                            let SymCat d _ = unsafeAt (unsafeAt seqs seqid) ppos
                                                            in (:) (Active j' (ppos+1) funid seqid (updateAt d fid args) keyc)) items set
                   in process mbt fn seqs funs items2 acc chart{passive=insertPC (mkPK key0 j) fid (passive chart)
                                                               ,forest =IntMap.insert fid (Set.singleton (PApply funid args)) (forest chart)
                                                               ,nextId =nextId chart+1
                                                               }
        Just id -> let items2 = [Active k 0 funid (rhs funid r) args (AK id r) | r <- labelsAC id (active chart)] ++ items
                   in process mbt fn seqs funs items2 acc chart{forest = IntMap.insertWith Set.union id (Set.singleton (PApply funid args)) (forest chart)}
  where
    !lin = unsafeAt seqs seqid
    !k   = offset chart

    mkPK (AK fid lbl) j = PK fid lbl j
    
    rhs funid lbl = unsafeAt lins lbl
      where
        CncFun _ lins = unsafeAt funs funid


updateAt :: Int -> a -> [a] -> [a]
updateAt nr x xs = [if i == nr then x else y | (i,y) <- zip [0..] xs]

litCatMatch fcat (Just t)
  | fcat == fcatString = Just (cidString,ELit (LStr t),[t])
  | fcat == fcatInt    = case reads t of {[(n,"")] -> Just (cidInt,ELit (LInt n),[t]);
                                         _         -> Nothing }
  | fcat == fcatFloat  = case reads t of {[(d,"")] -> Just (cidFloat,ELit (LFlt d),[t]);
                                         _         -> Nothing }
  | fcat == fcatVar    = Just (cidVar,EFun (mkCId t),[t])
litCatMatch _    _     = Nothing


----------------------------------------------------------------
-- Active Chart
----------------------------------------------------------------

data Active
  = Active {-# UNPACK #-} !Int
           {-# UNPACK #-} !DotPos
           {-# UNPACK #-} !FunId
           {-# UNPACK #-} !SeqId
                           [FId]
           {-# UNPACK #-} !ActiveKey
  deriving (Eq,Show,Ord)
data ActiveKey
  = AK {-# UNPACK #-} !FId
       {-# UNPACK #-} !LIndex
  deriving (Eq,Ord,Show)
type ActiveChart  = IntMap.IntMap (IntMap.IntMap (Set.Set Active))

emptyAC :: ActiveChart
emptyAC = IntMap.empty

lookupAC :: ActiveKey -> ActiveChart -> Maybe (Set.Set Active)
lookupAC (AK fcat l) chart = IntMap.lookup fcat chart >>= IntMap.lookup l

lookupACByFCat :: FId -> ActiveChart -> [Set.Set Active]
lookupACByFCat fcat chart =
  case IntMap.lookup fcat chart of
    Nothing  -> []
    Just map -> IntMap.elems map

labelsAC :: FId -> ActiveChart -> [LIndex]
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
  = PK {-# UNPACK #-} !FId
       {-# UNPACK #-} !LIndex
       {-# UNPACK #-} !Int
  deriving (Eq,Ord,Show)

type PassiveChart = Map.Map PassiveKey FId 

emptyPC :: PassiveChart
emptyPC = Map.empty

lookupPC :: PassiveKey -> PassiveChart -> Maybe FId
lookupPC key chart = Map.lookup key chart

insertPC :: PassiveKey -> FId -> PassiveChart -> PassiveChart
insertPC key fcat chart = Map.insert key fcat chart


----------------------------------------------------------------
-- Forest
----------------------------------------------------------------

foldForest :: (FunId -> [FId] -> b -> b) -> (Expr -> [String] -> b -> b) -> b -> FId -> IntMap.IntMap (Set.Set Production) -> b
foldForest f g b fcat forest =
  case IntMap.lookup fcat forest of
    Nothing  -> b
    Just set -> Set.fold foldProd b set
  where
    foldProd (PCoerce fcat)        b = foldForest f g b fcat forest
    foldProd (PApply funid args)   b = f funid args b
    foldProd (PConst _ const toks) b = g const toks b


----------------------------------------------------------------
-- Parse State
----------------------------------------------------------------

-- | An abstract data type whose values represent
-- the current state in an incremental parser.
data ParseState = PState PGF Concr Chart (TMap.TrieMap String (Set.Set Active))

data Chart
  = Chart
      { active  :: ActiveChart
      , actives :: [ActiveChart]
      , passive :: PassiveChart
      , forest  :: IntMap.IntMap (Set.Set Production)
      , nextId  :: {-# UNPACK #-} !FId
      , offset  :: {-# UNPACK #-} !Int
      }
      deriving Show

----------------------------------------------------------------
-- Error State
----------------------------------------------------------------

-- | An abstract data type whose values represent
-- the state in an incremental parser after an error.
data ErrorState = EState PGF Concr Chart
