{-# LANGUAGE BangPatterns #-}
module PGF.Parsing.FCFG.Incremental
          ( ParseState
          , initState
          , nextState
          , getCompletions
          , extractExps
          , parse
          ) where

import Data.Array
import Data.Array.Base (unsafeAt)
import Data.List (isPrefixOf, foldl')
import Data.Maybe (fromMaybe)
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import qualified Data.Set as Set
import Control.Monad

import GF.Data.Assoc
import GF.Data.SortedList
import qualified GF.Data.MultiMap as MM
import PGF.CId
import PGF.Data
import PGF.Parsing.FCFG.Utilities
import Debug.Trace

parse :: ParserInfo -> CId -> [FToken] -> [Exp]
parse pinfo start toks = extractExps (foldl' nextState (initState pinfo start) toks) start

initState :: ParserInfo -> CId -> ParseState
initState pinfo start = 
  let items = do
        c <- Map.findWithDefault [] start (startupCats pinfo)
        ruleid <- topdownRules pinfo ? c
        let (FRule fn _ args cat lins) = allRules pinfo ! ruleid
        lbl <- indices lins
        return (Active 0 lbl 0 ruleid args cat)
        
      forest = IntMap.fromListWith Set.union [(cat, Set.singleton (Passive ruleid args)) | (ruleid, FRule _ _ args cat _) <- assocs (allRules pinfo)]

      max_fid = case IntMap.maxViewWithKey forest of
                  Just ((fid,_), _) -> fid+1
                  Nothing           -> 0

  in State pinfo
           (Chart MM.empty [] Map.empty forest max_fid 0)
           (Set.fromList items)

-- | From the current state and the next token
-- 'nextState' computes a new state where the token
-- is consumed and the current position shifted by one.
nextState :: ParseState -> String -> ParseState
nextState (State pinfo chart items) t =
  let (items1,chart1) = process add (allRules pinfo) (Set.toList items) (Set.empty,chart)
      chart2 = chart1{ active =MM.empty
                     , actives=active chart1 : actives chart1
                     , passive=Map.empty
                     , offset =offset chart1+1
                     }
  in State pinfo chart2 items1
  where
    add tok item set
      | tok == t  = Set.insert item set
      | otherwise = set

-- | If the next token is not known but only its prefix (possible empty prefix)
-- then the 'getCompletions' function can be used to calculate the possible
-- next words and the consequent states. This is used for word completions in
-- the GF interpreter.
getCompletions :: ParseState -> String -> Map.Map String ParseState
getCompletions (State pinfo chart items) w =
  let (map',chart1) = process add (allRules pinfo) (Set.toList items) (MM.empty,chart)
      chart2 = chart1{ active =MM.empty
                     , actives=active chart1 : actives chart1
                     , passive=Map.empty
                     , offset =offset chart1+1
                     }
  in fmap (State pinfo chart2) map'
  where
    add tok item map
      | isPrefixOf w tok = fromMaybe map (MM.insert' tok item map)
      | otherwise        = map

extractExps :: ParseState -> CId -> [Exp]
extractExps (State pinfo chart items) start = exps
  where
    (_,st) = process (\_ _ -> id) (allRules pinfo) (Set.toList items) ((),chart)

    exps = nubsort $ do
      c <- Map.findWithDefault [] start (startupCats pinfo)
      ruleid <- topdownRules pinfo ? c
      let (FRule fn _ args cat lins) = allRules pinfo ! ruleid
      lbl <- indices lins
      fid <- Map.lookup (PK c lbl 0) (passive st)
      go fid

    go fid = do
      set <- IntMap.lookup fid (forest st)
      Passive ruleid args <- Set.toList set
      let (FRule fn _ _ cat lins) = allRules pinfo ! ruleid
      args <- mapM go args
      return (EApp fn args)

process fn !rules []           acc_chart = acc_chart
process fn !rules (item:items) acc_chart = process fn rules items $! univRule item acc_chart
  where
    univRule (Active j lbl ppos ruleid args fid0) acc_chart@(acc,chart)
      | inRange (bounds lin) ppos =
          case unsafeAt lin ppos of
            FSymCat r d -> let !fid = args !! d
                           in case MM.insert' (AK fid r) item (active chart) of
                                Nothing     -> acc_chart
                                Just actCat -> (case Map.lookup (PK fid r k) (passive chart) of
                                                  Nothing -> id
                                                  Just id -> process fn rules [Active j lbl (ppos+1) ruleid (updateAt d id args) fid0]) $
                                               (case IntMap.lookup fid (forest chart) of
                                                  Nothing  -> id
                                                  Just set -> process fn rules (Set.fold (\(Passive ruleid args) -> (:) (Active k r 0 ruleid args fid)) [] set)) $
                                               (acc,chart{active=actCat})
      	    FSymTok tok   -> (fn tok (Active j lbl (ppos+1) ruleid args fid0) acc,chart)
      | otherwise = case Map.lookup (PK fid0 lbl j) (passive chart) of
                      Nothing -> let fid = nextId chart
	                         in process fn rules [Active j' lbl (ppos+1) ruleid (updateAt d fid args) fidc
	                                                | Active j' lbl ppos ruleid args fidc <- ((active chart:actives chart) !! (k-j)) MM.! (AK fid0 lbl),
	                                                  let FSymCat _ d = unsafeAt (rhs ruleid lbl) ppos] $
	                            (acc,chart{passive=Map.insert (PK fid0 lbl j) fid (passive chart)
                                              ,forest =IntMap.insert fid (Set.singleton (Passive ruleid args)) (forest chart)
                                              ,nextId =nextId chart+1
                                              })
                      Just id -> (acc,chart{forest = IntMap.insertWith Set.union id (Set.singleton (Passive ruleid args)) (forest chart)})
      where
        !lin = rhs ruleid lbl
        !k   = offset chart

    rhs ruleid lbl = unsafeAt lins lbl
      where
        (FRule _ _ _ cat lins) = unsafeAt rules ruleid

    updateAt :: Int -> a -> [a] -> [a]
    updateAt nr x xs = [if i == nr then x else y | (i,y) <- zip [0..] xs]


data Active
  = Active {-# UNPACK #-} !Int
           {-# UNPACK #-} !FIndex
           {-# UNPACK #-} !FPointPos
           {-# UNPACK #-} !RuleId
                           [FCat]
           {-# UNPACK #-} !FCat
  deriving (Eq,Show,Ord)
data Passive
  = Passive {-# UNPACK #-} !RuleId
                            [FCat]
  deriving (Eq,Ord,Show)

data ActiveKey
  = AK {-# UNPACK #-} !FCat
       {-# UNPACK #-} !FIndex
  deriving (Eq,Ord,Show)
data PassiveKey
  = PK {-# UNPACK #-} !FCat
       {-# UNPACK #-} !FIndex
       {-# UNPACK #-} !Int
  deriving (Eq,Ord,Show)


-- | An abstract data type whose values represent
-- the current state in an incremental parser.
data ParseState = State ParserInfo Chart (Set.Set Active)

data Chart
  = Chart
      { active  :: MM.MultiMap ActiveKey Active
      , actives :: [MM.MultiMap ActiveKey Active]
      , passive :: Map.Map PassiveKey FCat
      , forest  :: IntMap.IntMap (Set.Set Passive)
      , nextId  :: {-# UNPACK #-} !FCat
      , offset  :: {-# UNPACK #-} !Int
      }
