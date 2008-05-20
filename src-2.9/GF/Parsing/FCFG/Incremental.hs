module GF.Parsing.FCFG.Incremental where

import Data.Array
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import qualified Data.Set as Set
import Control.Monad

import GF.Data.Assoc
import GF.Data.GeneralDeduction
import GF.Formalism.FCFG
import GF.Formalism.Utilities 
import GF.Parsing.FCFG.PInfo
import GF.Parsing.FCFG.Range
import GF.GFCC.CId
import Debug.Trace

initState :: FCFPInfo -> CId -> State
initState pinfo start = 
  let items = do
        starts <- Map.lookup start (startupCats pinfo)
        c <- starts
        ruleid <- topdownRules pinfo ? c
        let (FRule fn args cat lins) = allRules pinfo ! ruleid
        lbl <- indices lins
        return (Active 0 lbl 0 ruleid args cat)
        
      forest = IntMap.fromListWith Set.union [(cat, Set.singleton (Passive ruleid args)) | (ruleid, FRule _ args cat _) <- assocs (allRules pinfo)]

      max_fid = case IntMap.maxViewWithKey forest of
                  Just ((fid,_), _) -> fid+1
                  Nothing           -> 0

  in process pinfo items (State emptyChart [] emptyChart Map.empty forest max_fid 0)

nextState :: FCFPInfo -> FToken -> State -> State
nextState pinfo t state =
  process pinfo (chartLookup (tokens state) t) state{ chart=emptyChart
                                                    , charts=chart state : charts state
                                                    , tokens=emptyChart
                                                    , passive=Map.empty
                                                    , currOffset=currOffset state+1
                                                    }

getCompletions :: State -> FToken -> [FToken]
getCompletions state w =
  [t | t <- chartKeys (tokens state), take (length w) t == w]

process pinfo []                                                 state = state
process pinfo (item@(Active j lbl ppos ruleid args fid0):xitems) state
  | inRange (bounds lin) ppos =
      case lin ! ppos of
        FSymCat _ r d -> let fid = args !! d
                         in case chartInsert (chart state) item (fid,r) of
                              Nothing     -> process pinfo xitems state
                              Just actCat -> let items = do exprs <- IntMap.lookup fid (forest state)
                                                            (Passive ruleid args) <- Set.toList exprs
                                                            return (Active k r 0 ruleid args fid)
                                                         `mplus`
                                                         do id <- Map.lookup (fid,r,k) (passive state)
		   		 	                    return (Active j lbl (ppos+1) ruleid (updateAt d id args) fid0)
                                             in process pinfo (xitems++items) state{chart=actCat}
      	FSymTok tok   -> case chartInsert (tokens state) (Active j lbl (ppos+1) ruleid args fid0) tok of
                           Nothing     -> process pinfo xitems state
                           Just actTok -> process pinfo xitems state{tokens=actTok}
  | otherwise = case Map.lookup (fid0, lbl, j) (passive state) of
                  Nothing -> let fid = nextId state
                                 items = do Active j' lbl ppos ruleid args fidc <- chartLookup ((chart state:charts state) !! (k-j)) (fid0,lbl)
	                                    let FSymCat _ _ d = rhs ruleid lbl ! ppos
	                                    return (Active j' lbl (ppos+1) ruleid (updateAt d fid args) fidc)
	                     in process pinfo (xitems++items) state{passive=Map.insert (fid0, lbl, j) fid (passive state)
                                                                   ,forest =IntMap.insert fid (Set.singleton (Passive ruleid args)) (forest state)
                                                                   ,nextId =nextId state+1
                                                                   }
                  Just id -> process pinfo xitems state{forest = IntMap.insertWith Set.union id (Set.singleton (Passive ruleid args)) (forest state)}
  where
   lin = rhs ruleid lbl
   k   = currOffset state

   rhs ruleid lbl = lins ! lbl
     where
       (FRule _ _ cat lins) = allRules pinfo ! ruleid

   updateAt nr x xs = [if i == nr then x else y | (i,y) <- zip [0..] xs]


data Active
  = Active Int FIndex FPointPos RuleId [FCat] FCat
  deriving (Eq,Show,Ord)
data Passive
  = Passive RuleId [FCat]
  deriving (Eq,Ord,Show)


data State
  = State
      { chart   :: Chart
      , charts  :: [Chart]
      , tokens  :: ParseChart Active  FToken
      , passive :: Map.Map (FCat, FIndex, Int) FCat
      , forest  :: IntMap.IntMap (Set.Set Passive)
      , nextId  :: FCat
      , currOffset :: Int
      }
      deriving Show

type Chart = ParseChart Active (FCat, FIndex)
