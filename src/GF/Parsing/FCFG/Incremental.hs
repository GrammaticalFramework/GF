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

initState :: FCFPInfo -> CId -> Chart
initState pinfo start = 
  let items = do
        starts <- Map.lookup start (startupCats pinfo)
        c <- starts
        ruleid <- topdownRules pinfo ? c
        let (FRule fn args cat lins) = allRules pinfo ! ruleid
        lbl <- indices lins
        return (Active 0 0 lbl 0 0 (App ruleid [0 | arg <- args]))
  in process pinfo items (Chart emptyChart emptyChart emptyChart Map.empty IntMap.empty 1)

nextState :: FCFPInfo -> FToken -> Chart -> Chart
nextState pinfo t chart =
  let items = chartLookup (actTok chart) t
  in process pinfo [Active j (k+1) lbl (ppos+1) fid expr | Active j k lbl ppos fid expr <- items] chart{actTok=emptyChart}

getCompletions :: Chart -> FToken -> [FToken]
getCompletions chart w =
  [t | t <- chartKeys (actTok chart), take (length w) t == w]

process pinfo []            chart = chart
process pinfo (item:xitems) chart = univRule item chart
  where
    univRule item@(Active j k lbl ppos fid0 expr@(App ruleid args)) chart
      | inRange (bounds lin) ppos =
           case lin ! ppos of
             FSymCat c r d -> case args !! d of
                                0  -> case chartInsert (actCat chart) item (c,r,k) of
                                        Nothing     -> process pinfo xitems chart
                                        Just actCat -> let items = do ruleid <- topdownRules pinfo ? c
                                                                      let (FRule fn args cat lins) = allRules pinfo ! ruleid
                                                                      return (Active k k r 0 0 (App ruleid [0 | arg <- args]))
                                                                   `mplus`
                                                                   do endings <- Map.lookup (c,r,k) (passive chart)
                                                                      (k',id) <- Map.toList endings
						 	              return (Active j k' lbl (ppos+1) fid0 (App ruleid (updateAt d id args)))
                                                       in process pinfo (xitems++items) chart{actCat=actCat}
                                id -> case chartInsert (actTre chart) item (id,r,k) of
                                        Nothing     -> process pinfo xitems chart
                                        Just actTre -> let items = do exprs <- IntMap.lookup id (forest chart)
                                                                      App ruleid args <- Set.toList exprs
                                                                      return (Active k k r 0 id (App ruleid args))
                                                       in process pinfo (xitems++items) chart{actTre=actTre}
      	     FSymTok tok   -> case chartInsert (actTok chart) item tok of
                                Nothing     -> process pinfo xitems chart
                                Just actTok -> process pinfo xitems chart{actTok=actTok}
      | otherwise = let ffg fid chart = if fid0 == 0
                                          then let items = do Active j' k' lbl ppos fidc (App ruleid args) <- chartLookup (actCat chart) (cat,lbl,j)
	                                                      let (FRule fn _ cat lins) = allRules pinfo ! ruleid
	                                                          FSymCat c r d = lins ! lbl ! ppos
	                                                      return (Active j' k lbl (ppos+1) fidc (App ruleid (updateAt d fid args)))
	                                       in process pinfo (xitems++items) chart
	                                  else let items = do Active j' k' lbl ppos fidc (App ruleid args) <- chartLookup (actTre chart) (fid0,lbl,j)
	                                                      let (FRule fn _ cat lins) = allRules pinfo ! ruleid
	                                                          FSymCat c r d = lins ! lbl ! ppos
	                                                      return (Active j' k lbl (ppos+1) fidc (App ruleid (updateAt d fid args)))
	                                       in process pinfo (xitems++items) chart

                    in case Map.lookup (cat, lbl, j) (passive chart) of
                         Nothing      ->              ffg (nextId chart) $
                                                      chart{passive=Map.insert (cat, lbl, j) (Map.singleton k (nextId chart)) (passive chart)
                                                           ,forest =IntMap.insert (nextId chart) (Set.singleton expr) (forest chart)
                                                           ,nextId =nextId chart+1
                                                           }
                         Just endings -> case Map.lookup k endings of
                                           Nothing -> ffg (nextId chart) $
                                                      chart{passive=Map.insert (cat, lbl, j) (Map.insert k (nextId chart) endings) (passive chart)
                                                           ,forest =IntMap.insert (nextId chart) (Set.singleton expr) (forest chart)
                                                           ,nextId =nextId chart+1
                                                           }
                                           Just id -> process pinfo xitems chart{forest = IntMap.insertWith Set.union id (Set.singleton expr) (forest chart)}
      where
        (FRule fn _ cat lins) = allRules pinfo ! ruleid
        lin                   = lins ! lbl

        

updateAt nr x xs = [if i == nr then x else y | (i,y) <- zip [0..] xs]

data Active
  = Active Int Int FIndex FPointPos ForestId Expr
  deriving (Eq,Show,Ord)

data Chart
  = Chart
      { actCat  :: ParseChart Active  (FCat, FIndex, Int)
      , actTre  :: ParseChart Active  (ForestId, FIndex, Int)
      , actTok  :: ParseChart Active  FToken
      , passive :: Map.Map (FCat, FIndex, Int) (Map.Map Int ForestId)
      , forest  :: IntMap.IntMap (Set.Set Expr)
      , nextId  :: ForestId
      }
      deriving Show

type ForestId = Int
data Expr
  = App RuleId [ForestId]
  deriving (Eq,Ord,Show)