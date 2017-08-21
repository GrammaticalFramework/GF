{-# LANGUAGE BangPatterns, RankNTypes, FlexibleContexts #-}
module PGF.Parse
          ( ParseState
          , ErrorState
          , initState
          , nextState
          , getCompletions
          , recoveryStates
          , ParseInput(..),  simpleParseInput, mkParseInput
          , ParseOutput(..), getParseOutput
          , parse
          , parseWithRecovery
          , getContinuationInfo
          ) where

import Data.Array.IArray
import Data.Array.Base (unsafeAt)
import Data.List (isPrefixOf, foldl', intercalate)
import Data.Maybe (fromMaybe, maybeToList)
import qualified Data.Map as Map
import qualified PGF.TrieMap as TrieMap
import qualified Data.IntMap as IntMap
import qualified Data.IntSet as IntSet
import qualified Data.Set as Set
import Control.Monad

import PGF.CId
import PGF.Data
import PGF.Expr(Tree)
import PGF.Macros
import PGF.TypeCheck
import PGF.Forest(Forest(Forest), linearizeWithBrackets, getAbsTrees)

-- | The input to the parser is a pair of predicates. The first one
-- 'piToken' selects a token from a list of suggestions from the grammar,
-- actually appears at the current position in the input string.
-- The second one 'piLiteral' recognizes whether a literal with forest id 'FId'
-- could be matched at the current position.
data ParseInput
  = ParseInput
      { piToken   :: forall a . Map.Map Token a -> Maybe a
      , piLiteral :: FId -> Maybe (CId,Tree,[Token])
      }

-- | This data type encodes the different outcomes which you could get from the parser.
data ParseOutput
  = ParseFailed Int                -- ^ The integer is the position in number of tokens where the parser failed.
  | TypeError   [(FId,TcError)]    -- ^ The parsing was successful but none of the trees is type correct. 
                                   -- The forest id ('FId') points to the bracketed string from the parser
                                   -- where the type checking failed. More than one error is returned
                                   -- if there are many analizes for some phrase but they all are not type correct.
  | ParseOk [Tree]                 -- ^ If the parsing and the type checking are successful we get a list of abstract syntax trees.
                                   -- The list should be non-empty.
  | ParseIncomplete                -- ^ The sentence is not complete. Only partial output is produced

parse :: PGF -> Language -> Type -> Maybe Int -> [Token] -> (ParseOutput,BracketedString)
parse pgf lang typ dp toks = loop (initState pgf lang typ) toks
  where
    loop ps []     = getParseOutput ps typ dp
    loop ps (t:ts) = case nextState ps (simpleParseInput t) of
                       Left  es -> case es of
                                     EState _ _ chart -> (ParseFailed (offset chart),snd (getParseOutput ps typ dp))
                       Right ps -> loop ps ts

parseWithRecovery :: PGF -> Language -> Type -> [Type] -> Maybe Int -> [String] -> (ParseOutput,BracketedString)
parseWithRecovery pgf lang typ open_typs dp toks = accept (initState pgf lang typ) toks
  where
    accept ps []     = getParseOutput ps typ dp
    accept ps (t:ts) =
      case nextState ps (simpleParseInput t) of
        Right ps -> accept ps ts
        Left  es -> skip (recoveryStates open_typs es) ts

    skip ps_map []     = getParseOutput (fst ps_map) typ dp
    skip ps_map (t:ts) =
      case Map.lookup t (snd ps_map) of
        Just ps -> accept ps ts
        Nothing -> skip ps_map ts


-- | Creates an initial parsing state for a given language and
-- startup category.
initState :: PGF -> Language -> Type -> ParseState
initState pgf lang (DTyp _ start _) = 
  let items = case Map.lookup start (cnccats cnc) of
                Just (CncCat s e labels) -> 
                        do fid <- range (s,e)
                           funid <- fromMaybe [] (IntMap.lookup fid (linrefs cnc))
                           let lbl           = 0
                               CncFun _ lins = unsafeAt (cncfuns cnc) funid
                           return (Active 0 0 funid (unsafeAt lins lbl) [PArg [] fid] (AK fidStart lbl))
                Nothing -> []
  in PState abs
            cnc
            (Chart emptyAC [] emptyPC (pproductions cnc) (totalCats cnc) 0)
            (TrieMap.compose (Just (Set.fromList items)) Map.empty)
  where
    abs = abstract pgf
    cnc = lookConcrComplete pgf lang


-- | This function constructs the simplest possible parser input. 
-- It checks the tokens for exact matching and recognizes only @String@, @Int@ and @Float@ literals.
-- The @Int@ and @Float@ literals match only if the token passed is some number.
-- The @String@ literal always match but the length of the literal could be only one token.
simpleParseInput :: Token -> ParseInput
simpleParseInput t = ParseInput (Map.lookup t) (matchLit t)
  where
    matchLit t fid
      | fid == fidString = Just (cidString,ELit (LStr t),[t])
      | fid == fidInt    = case reads t of {[(n,"")] -> Just (cidInt,ELit (LInt n),[t]);
                                            _        -> Nothing }
      | fid == fidFloat  = case reads t of {[(d,"")] -> Just (cidFloat,ELit (LFlt d),[t]);
                                            _        -> Nothing }
      | fid == fidVar    = Just (wildCId,EFun (mkCId t),[t])
      | otherwise        = Nothing

mkParseInput :: PGF -> Language 
             -> (forall a . b -> Map.Map Token a -> Maybe a)
             -> [(CId,b -> Maybe (Tree,[Token]))]
             -> (b -> ParseInput)
mkParseInput pgf lang ftok flits = \x -> ParseInput (ftok x) (flit x)
  where
    flit = mk flits
    
    cnc = lookConcr pgf lang

    mk []               = \x fid -> Nothing
    mk ((c,flit):flits) = \x fid -> case Map.lookup c (cnccats cnc) of
                                      Just (CncCat s e _) | inRange (s,e) fid 
                                              -> fmap (\(tree,toks) -> (c,tree,toks)) (flit x)
                                      _       -> mk flits x fid

-- | From the current state and the next token
-- 'nextState' computes a new state, where the token
-- is consumed and the current position is shifted by one.
-- If the new token cannot be accepted then an error state 
-- is returned.
nextState :: ParseState -> ParseInput -> Either ErrorState ParseState
nextState (PState abs cnc chart cnt0) input =
  let (mb_agenda,map_items) = TrieMap.decompose cnt0
      agenda = maybe [] Set.toList mb_agenda
      cnt    = fromMaybe TrieMap.empty (piToken input map_items)
      (cnt1,chart1) = process flit ftok cnc agenda cnt chart
      chart2 = chart1{ active =emptyAC
                     , actives=active chart1 : actives chart1
                     , passive=emptyPC
                     , offset =offset chart1+1
                     }
  in if TrieMap.null cnt1
       then Left  (EState abs cnc chart2)
       else Right (PState abs cnc chart2 cnt1)
  where
    flit = piLiteral input

    ftok choices cnt =
      case piToken input choices of
        Just cnt' -> TrieMap.unionWith Set.union cnt' cnt
        Nothing   -> cnt

-- | If the next token is not known but only its prefix (possible empty prefix)
-- then the 'getCompletions' function can be used to calculate the possible
-- next words and the consequent states. This is used for word completions in
-- the GF interpreter.
getCompletions :: ParseState -> String -> Map.Map Token ParseState
getCompletions (PState abs cnc chart cnt0) w =
  let (mb_agenda,map_items) = TrieMap.decompose cnt0
      agenda = maybe [] Set.toList mb_agenda
      acc    = Map.filterWithKey (\tok _ -> isPrefixOf w tok) map_items
      (acc',chart1) = process flit ftok cnc agenda acc chart
      chart2 = chart1{ active =emptyAC
                     , actives=active chart1 : actives chart1
                     , passive=emptyPC
                     , offset =offset chart1+1
                     }
  in fmap (PState abs cnc chart2) acc'
  where
    flit _ = Nothing

    ftok choices =
      Map.unionWith (TrieMap.unionWith Set.union)
                    (Map.filterWithKey (\tok _ -> isPrefixOf w tok) choices)

recoveryStates :: [Type] -> ErrorState -> (ParseState, Map.Map Token ParseState)
recoveryStates open_types (EState abs cnc chart) =
  let open_fcats = concatMap type2fcats open_types
      agenda = foldl (complete open_fcats) [] (actives chart)
      (acc,chart1) = process flit ftok cnc agenda Map.empty chart
      chart2 = chart1{ active =emptyAC
                     , actives=active chart1 : actives chart1
                     , passive=emptyPC
                     , offset =offset chart1+1
                     }
  in (PState abs cnc chart (TrieMap.singleton [] (Set.fromList agenda)), fmap (PState abs cnc chart2) acc)
  where
    type2fcats (DTyp _ cat _) = case Map.lookup cat (cnccats cnc) of
                                  Just (CncCat s e labels) -> range (s,e)
                                  Nothing                  -> []

    complete open_fcats items ac = 
      foldl (Set.fold (\(Active j' ppos funid seqid args keyc) -> 
                           (:) (Active j' (ppos+1) funid seqid args keyc)))
            items
            [set | fcat <- open_fcats, (set,_) <- lookupACByFCat fcat ac]

    flit _ = Nothing
    ftok toks = Map.unionWith (TrieMap.unionWith Set.union) toks

-- | This function extracts the list of all completed parse trees
-- that spans the whole input consumed so far. The trees are also
-- limited by the category specified, which is usually
-- the same as the startup category.
getParseOutput :: ParseState -> Type -> Maybe Int -> (ParseOutput,BracketedString)
getParseOutput (PState abs cnc chart cnt) ty dp =
  let froots | null roots = getPartialSeq (sequences cnc) (reverse (active chart1 : actives chart1)) seq
             | otherwise  = [([SymCat 0 lbl],[PArg [] fid]) | AK fid lbl <- roots]

      f     = Forest abs cnc (forest chart1) froots
      
      bs    = linearizeWithBrackets dp f
                
      res   | not (null es)   = ParseOk es
            | not (null errs) = TypeError errs
            | otherwise       = ParseIncomplete
            where xs   = [getAbsTrees f (PArg [] fid) (Just ty) dp | (AK fid lbl) <- roots]
                  es   = concat [es   | Right es   <- xs]
                  errs = concat [errs | Left  errs <- xs]

  in (res,bs)
  where
    (mb_agenda,acc) = TrieMap.decompose cnt
    agenda = maybe [] Set.toList mb_agenda
    (acc',chart1) = process flit ftok cnc agenda (TrieMap.compose Nothing acc) chart
    seq = [(j,cutAt ppos toks seqid,args,key) | (toks,set) <- TrieMap.toList acc'
                                              , Active j ppos funid seqid args key <- Set.toList set]

    flit _    = Nothing
    ftok toks = TrieMap.unionWith Set.union (TrieMap.compose Nothing toks)

    cutAt ppos toks seqid =
      let seq  = unsafeAt (sequences cnc) seqid
          init = take (ppos-1) (elems seq)
          tail = case unsafeAt seq (ppos-1) of
                   SymKS t    -> drop (length toks) [SymKS t]
                   SymKP ts _ -> reverse (drop (length toks) (reverse ts))
                   sym        -> []
      in init ++ tail

    roots = do let lbl = 0
               fid <- maybeToList (lookupPC (PK fidStart lbl 0) (passive chart1))
               PApply _ [PArg _ fid] <- maybe [] Set.toList (IntMap.lookup fid (forest chart1))
               return (AK fid lbl)


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
                   Nothing      -> items
                   Just (set,_) -> [if j' < j
                                      then let lin' = take ppos (elems (unsafeAt seqs seqid))
                                           in (j',lin'++map (inc (length args')) lin,args'++args,key')
                                      else (j',lin,args,key') | Active j' ppos funid seqid args' key' <- Set.toList set] ++ items

    inc n (SymCat d r) = SymCat (n+d) r
    inc n (SymVar d r) = SymVar (n+d) r
    inc n (SymLit d r) = SymLit (n+d) r
    inc n s            = s

process flit ftok cnc []                                                 acc chart = (acc,chart)
process flit ftok cnc (item@(Active j ppos funid seqid args key0):items) acc chart
  | inRange (bounds lin) ppos =
      case unsafeAt lin ppos of
        SymCat d r -> let PArg hypos !fid = args !! d
                          key  = AK fid r

                          items2 = case lookupPC (mkPK key k) (passive chart) of
                                     Nothing -> items
                                     Just id -> (Active j (ppos+1) funid seqid (updateAt d (PArg hypos id) args) key0) : items
                          (acc',items4) = predict flit ftok cnc
                                                  (IntMap.unionWith Set.union new_sc (forest chart))
                                                  key key k
                                                  acc items2

                          new_sc    = foldl uu parent_sc hypos
                          parent_sc = case lookupAC key0 ((active chart : actives chart) !! (k-j)) of
                                        Nothing       -> IntMap.empty
                                        Just (set,sc) -> sc

                      in case lookupAC key (active chart) of
                           Nothing                             -> process flit ftok cnc items4 acc' chart{active=insertAC key (Set.singleton item,new_sc) (active chart)}
                           Just (set,sc) | Set.member item set -> process flit ftok cnc items  acc  chart
                                         | otherwise           -> process flit ftok cnc items2 acc  chart{active=insertAC key (Set.insert item set,IntMap.unionWith Set.union new_sc sc) (active chart)}
      	SymKS tok  -> let !acc' = ftok_ [tok] (Active j (ppos+1) funid seqid args key0) acc
      	              in process flit ftok cnc items acc' chart
      	SymNE      -> process flit ftok cnc items acc chart
      	SymBIND    -> let !acc' = ftok_ ["&+"] (Active j (ppos+1) funid seqid args key0) acc
      	              in process flit ftok cnc items acc' chart
      	SymSOFT_BIND->process flit ftok cnc ((Active j (ppos+1) funid seqid args key0):items) acc chart
      	SymSOFT_SPACE->process flit ftok cnc ((Active j (ppos+1) funid seqid args key0):items) acc chart
      	SymCAPIT   -> let !acc' = ftok_ ["&|"] (Active j (ppos+1) funid seqid args key0) acc
      	              in process flit ftok cnc items acc' chart
      	SymALL_CAPIT->let !acc' = ftok_ ["&|"] (Active j (ppos+1) funid seqid args key0) acc
      	              in process flit ftok cnc items acc' chart
      	SymKP syms vars
      	           -> let to_tok (SymKS t)    = [t]
      	                  to_tok SymBIND      = ["&+"]
      	                  to_tok SymSOFT_BIND = []
      	                  to_tok SymSOFT_SPACE= []
      	                  to_tok SymCAPIT     = ["&|"]
      	                  to_tok SymALL_CAPIT = ["&|"]
      	                  to_tok _            = []

      	                  !acc' = foldl (\acc syms -> ftok_ (concatMap to_tok syms) (Active j (ppos+1) funid seqid args key0) acc) acc
                                        (syms:[syms' | (syms',_) <- vars])
                      in process flit ftok cnc items acc' chart
        SymLit d r -> let PArg hypos fid = args !! d
                          key   = AK fid r
                          !fid' = case lookupPC (mkPK key k) (passive chart) of
                                    Nothing  -> fid
                                    Just fid -> fid

                      in case [ts | PConst _ _ ts <- maybe [] Set.toList (IntMap.lookup fid' (forest chart))] of
                           (toks:_) -> let !acc' = ftok_ toks (Active j (ppos+1) funid seqid (updateAt d (PArg hypos fid') args) key0) acc
                                       in process flit ftok cnc items acc' chart
                           []       -> case flit fid of
                                         Just (cat,lit,toks) 
                                                     -> let fid'  = nextId chart
                                                            !acc' = ftok_ toks (Active j (ppos+1) funid seqid (updateAt d (PArg hypos fid') args) key0) acc
                                                        in process flit ftok cnc items acc' chart{passive=insertPC (mkPK key k) fid' (passive chart)
                                                                                                 ,forest =IntMap.insert fid' (Set.singleton (PConst cat lit toks)) (forest chart)
                                                                                                 ,nextId =nextId chart+1
                                                                                                 }
                                         Nothing     -> process flit ftok cnc items acc chart
        SymVar d r -> let PArg hypos fid0 = args !! d
                          (fid1,fid2)     = hypos !! r
                          key   = AK fid1 0
                          !fid' = case lookupPC (mkPK key k) (passive chart) of
                                    Nothing  -> fid1
                                    Just fid -> fid

                      in case [ts | PConst _ _ ts <- maybe [] Set.toList (IntMap.lookup fid' (forest chart))] of
                           (toks:_) -> let !acc' = ftok_ toks (Active j (ppos+1) funid seqid (updateAt d (PArg (updateAt r (fid',fid2) hypos) fid0) args) key0) acc
                                       in process flit ftok cnc items acc' chart
                           []       -> case flit fid1 of
                                         Just (cat,lit,toks) 
                                                 -> let fid'  = nextId chart
                                                        !acc' = ftok_ toks (Active j (ppos+1) funid seqid (updateAt d (PArg (updateAt r (fid',fid2) hypos) fid0) args) key0) acc
                                                    in process flit ftok cnc items acc' chart{passive=insertPC (mkPK key k) fid' (passive chart)
                                                                                             ,forest =IntMap.insert fid' (Set.singleton (PConst cat lit toks)) (forest chart)
                                                                                             ,nextId =nextId chart+1
                                                                                             }
                                         Nothing -> process flit ftok cnc items acc chart
  | otherwise =
      case lookupPC (mkPK key0 j) (passive chart) of
        Nothing -> let fid = nextId chart
                       
                       items2 = case lookupAC key0 ((active chart:actives chart) !! (k-j)) of
                                  Nothing       -> items
                                  Just (set,sc) -> Set.fold (\(Active j' ppos funid seqid args keyc) -> 
                                                                let SymCat d _ = unsafeAt (unsafeAt (sequences cnc) seqid) ppos
                                                                    PArg hypos _ = args !! d
                                                                in (:) (Active j' (ppos+1) funid seqid (updateAt d (PArg hypos fid) args) keyc)) items set
                   in process flit ftok cnc items2 acc chart{passive=insertPC (mkPK key0 j) fid (passive chart)
                                                            ,forest =IntMap.insert fid (Set.singleton (PApply funid args)) (forest chart)
                                                            ,nextId =nextId chart+1
                                                            }
        Just id -> let items2 = [Active k 0 funid (rhs funid r) args (AK id r) | r <- labelsAC id (active chart)] ++ items
                   in process flit ftok cnc items2 acc chart{forest = IntMap.insertWith Set.union id (Set.singleton (PApply funid args)) (forest chart)}
  where
    !lin = unsafeAt (sequences cnc) seqid
    !k   = offset chart

    mkPK (AK fid lbl) j = PK fid lbl j
    
    rhs funid lbl = unsafeAt lins lbl
      where
        CncFun _ lins = unsafeAt (cncfuns cnc) funid

    uu forest (fid1,fid2) =
      case IntMap.lookup fid2 (lindefs cnc) of
        Just funs -> foldl (\forest funid -> IntMap.insertWith Set.union fid2 (Set.singleton (PApply funid [PArg [] fid1])) forest) forest funs
        Nothing   -> forest
        
    ftok_ [] item cnt         = ftok Map.empty cnt
    ftok_ (tok:toks) item cnt =
      ftok (Map.singleton tok (TrieMap.singleton toks (Set.singleton item))) cnt

    predict flit ftok cnc forest key0 key@(AK fid lbl) k acc items =
      let (acc1,items1) = case IntMap.lookup fid forest of
                            Nothing  -> (acc,items)
                            Just set -> Set.fold foldProd (acc,items) set

          (acc2,items2) = case IntMap.lookup fid (lexicon cnc) >>= IntMap.lookup lbl of
                            Just tmap -> let (mb_v,toks) = TrieMap.decompose (TrieMap.map (toItems key0 k) tmap)
                                             acc1'   = ftok toks acc1
                                             items1' = maybe [] Set.toList mb_v ++ items1
                                         in (acc1',items1')
                            Nothing   -> (acc1,items1)
      in (acc2,items2)
      where
        foldProd (PCoerce fid)         (acc,items) = predict flit ftok cnc forest key0 (AK fid lbl) k acc items
        foldProd (PApply funid args)   (acc,items) = (acc,Active k 0 funid (rhs funid lbl) args key0 : items)
        foldProd (PConst _ const toks) (acc,items) = (acc,items)

        toItems key@(AK fid lbl) k funids =
          Set.fromList [Active k 1 funid (rhs funid lbl) [] key | funid <- IntSet.toList funids]


updateAt :: Int -> a -> [a] -> [a]
updateAt nr x xs = [if i == nr then x else y | (i,y) <- zip [0..] xs]

----------------------------------------------------------------
-- Active Chart
----------------------------------------------------------------

data Active
  = Active {-# UNPACK #-} !Int
           {-# UNPACK #-} !DotPos
           {-# UNPACK #-} !FunId
           {-# UNPACK #-} !SeqId
                          [PArg]
           {-# UNPACK #-} !ActiveKey
  deriving (Eq,Show,Ord)
data ActiveKey
  = AK {-# UNPACK #-} !FId
       {-# UNPACK #-} !LIndex
  deriving (Eq,Ord,Show)
type ActiveSet   = Set.Set Active
type ActiveChart = IntMap.IntMap (IntMap.IntMap (ActiveSet, IntMap.IntMap (Set.Set Production)))

emptyAC :: ActiveChart
emptyAC = IntMap.empty

lookupAC :: ActiveKey -> ActiveChart -> Maybe (ActiveSet, IntMap.IntMap (Set.Set Production))
lookupAC (AK fid lbl) chart = IntMap.lookup fid chart >>= IntMap.lookup lbl

lookupACByFCat :: FId -> ActiveChart -> [(ActiveSet, IntMap.IntMap (Set.Set Production))]
lookupACByFCat fcat chart =
  case IntMap.lookup fcat chart of
    Nothing  -> []
    Just map -> IntMap.elems map

labelsAC :: FId -> ActiveChart -> [LIndex]
labelsAC fcat chart = 
  case IntMap.lookup fcat chart of
    Nothing  -> []
    Just map -> IntMap.keys map

insertAC :: ActiveKey -> (ActiveSet, IntMap.IntMap (Set.Set Production)) -> ActiveChart -> ActiveChart
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
-- Parse State
----------------------------------------------------------------

-- | An abstract data type whose values represent
-- the current state in an incremental parser.
data ParseState = PState Abstr Concr Chart Continuation

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

type Continuation = TrieMap.TrieMap Token ActiveSet

-- | Return the Continuation of a Parsestate with exportable types
--   Used by PGFService
getContinuationInfo :: ParseState -> Map.Map [Token] [(FunId, CId, String)]
getContinuationInfo pstate = Map.map (map f . Set.toList) contMap
  where
    PState _abstr concr _chart cont = pstate
    contMap = Map.fromList (TrieMap.toList cont) -- always get [([], _::ActiveSet)]
    f :: Active -> (FunId,CId,String)
    f (Active int dotpos funid seqid pargs ak) = (funid, cid, seq)
      where
        CncFun cid _ = cncfuns concr ! funid
        seq = showSeq dotpos (sequences concr ! seqid)
        
    showSeq :: DotPos -> Sequence -> String
    showSeq pos seq = intercalate " " $ scan (drop (pos-1) (elems seq))
      where
        -- Scan left-to-right, stop at first non-token
        scan :: [Symbol] -> [String]
        scan [] = []
        scan (sym:syms) = case sym of
          SymKS token -> token : scan syms
          _           -> []

----------------------------------------------------------------
-- Error State
----------------------------------------------------------------

-- | An abstract data type whose values represent
-- the state in an incremental parser after an error.
data ErrorState = EState Abstr Concr Chart
