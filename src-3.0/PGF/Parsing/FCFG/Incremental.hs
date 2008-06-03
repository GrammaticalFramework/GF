{-# OPTIONS -fbang-patterns #-}
module PGF.Parsing.FCFG.Incremental
          ( State
          , initState
          , nextState
          , getCompletions
          , extractExps
          , parse
          ) where

import Data.Array
import Data.Array.Base (unsafeAt)
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
parse pinfo start toks = go (initState pinfo start) toks
  where
    go st []     = extractExps pinfo start st
    go st (t:ts) = go (nextState pinfo t st) ts

initState :: ParserInfo -> CId -> State
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

  in process (allRules pinfo) items (State MM.empty [] MM.empty Map.empty forest max_fid 0)

nextState :: ParserInfo -> FToken -> State -> State
nextState pinfo t state =
  process (allRules pinfo) (tokens state MM.! t) state{ chart=MM.empty
                                                      , charts=chart state : charts state
                                                      , tokens=MM.empty
                                                      , passive=Map.empty
                                                      , currOffset=currOffset state+1
                                                      }

getCompletions :: State -> FToken -> [FToken]
getCompletions state w =
  [t | t <- MM.keys (tokens state), take (length w) t == w]

extractExps :: ParserInfo -> CId -> State -> [Exp]
extractExps pinfo start st = exps
  where
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

process !rules []           state = state
process !rules (item:items) state = process rules items $! univRule item state
  where
    univRule (Active j lbl ppos ruleid args fid0) state
      | inRange (bounds lin) ppos =
          case unsafeAt lin ppos of
            FSymCat r d -> {-# SCC "COND11" #-}
                           let !fid = args !! d
                           in case MM.insert' (AK fid r) item (chart state) of
                                Nothing     -> state
                                Just actCat -> (case Map.lookup (PK fid r k) (passive state) of
                                                  Nothing -> id
                                                  Just id -> process rules [Active j lbl (ppos+1) ruleid (updateAt d id args) fid0]) $
                                               (case IntMap.lookup fid (forest state) of
                                                  Nothing  -> id
                                                  Just set -> process rules (Set.fold (\(Passive ruleid args) -> (:) (Active k r 0 ruleid args fid)) [] set)) $
                                               state{chart=actCat}
      	    FSymTok tok   -> {-# SCC "COND12" #-}
      	                     case MM.insert' tok (Active j lbl (ppos+1) ruleid args fid0) (tokens state) of
                               Nothing     -> state
                               Just actTok -> state{tokens=actTok}
      | otherwise = {-# SCC "COND2" #-}
                    case Map.lookup (PK fid0 lbl j) (passive state) of
                      Nothing -> let fid = nextId state
	                         in process rules [Active j' lbl (ppos+1) ruleid (updateAt d fid args) fidc
	                                             | Active j' lbl ppos ruleid args fidc <- ((chart state:charts state) !! (k-j)) MM.! (AK fid0 lbl),
	                                               let FSymCat _ d = unsafeAt (rhs ruleid lbl) ppos] $
	                            state{passive=Map.insert (PK fid0 lbl j) fid (passive state)
                                         ,forest =IntMap.insert fid (Set.singleton (Passive ruleid args)) (forest state)
                                         ,nextId =nextId state+1
                                         }
                      Just id -> state{forest = IntMap.insertWith Set.union id (Set.singleton (Passive ruleid args)) (forest state)}
      where
        !lin = rhs ruleid lbl
        !k   = currOffset state

    rhs ruleid lbl = unsafeAt lins lbl
      where
        (FRule _ _ _ cat lins) = unsafeAt rules ruleid

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

data State
  = State
      { chart      :: MM.MultiMap ActiveKey Active
      , charts     :: [MM.MultiMap ActiveKey Active]
      , tokens     :: MM.MultiMap FToken Active
      , passive    :: Map.Map PassiveKey FCat
      , forest     :: IntMap.IntMap (Set.Set Passive)
      , nextId     :: {-# UNPACK #-} !FCat
      , currOffset :: {-# UNPACK #-} !Int
      }
      deriving Show
