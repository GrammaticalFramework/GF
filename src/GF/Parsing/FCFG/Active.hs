----------------------------------------------------------------------
-- |
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-- MCFG parsing, the active algorithm
-----------------------------------------------------------------------------

module GF.Parsing.FCFG.Active (parse) where

import GF.Data.GeneralDeduction
import GF.Data.Assoc
import GF.Data.Utilities

import GF.Formalism.GCFG
import GF.Formalism.FCFG
import GF.Formalism.MCFG(Lin(..))
import GF.Formalism.Utilities

import GF.Infra.Ident

import GF.Parsing.FCFG.Range
import GF.Parsing.FCFG.PInfo

import GF.System.Tracing

import Control.Monad (guard)

import GF.Infra.Print

import qualified Data.List as List
import qualified Data.Map  as Map
import qualified Data.Set  as Set
import Data.Array

----------------------------------------------------------------------
-- * parsing

parse :: (Ord c, Print n, Ord n, Ord t) => String -> FCFParser c n t
parse strategy pinfo starts toks =
    [ Abs (cat, found) (zip rhs rrecs) fun |
      Final ruleid found rrecs <- listXChartFinal chart,
      let FRule (Abs cat rhs fun) _ = allRules pinfo ! ruleid ]
    where chart = process strategy pinfo toks axioms emptyXChart
    
          axioms | isBU  strategy = terminal pinfo toks ++ initialScan pinfo toks
		 | isTD  strategy = initial pinfo starts toks

isBU  s = s=="b"
isTD  s = s=="t"

-- used in prediction
emptyChildren :: Abstract c n -> [RangeRec]
emptyChildren (Abs _ rhs _) = replicate (length rhs) []

updateChildren :: [RangeRec] -> Int -> RangeRec -> [[RangeRec]]
updateChildren recs i rec = updateNthM update i recs
    where update rec' = do guard (null rec' || rec' == rec)
                           return rec

makeMaxRange (Range _ j) = Range j j
makeMaxRange EmptyRange  = EmptyRange

process :: (Ord c, Ord n, Ord t) => String -> FCFPInfo c n t -> Input t -> [Item] -> XChart c -> XChart c
process strategy pinfo toks []           chart = chart
process strategy pinfo toks (item:items) chart = process strategy pinfo toks items $! univRule item chart
  where
    univRule item@(Active ruleid found rng lbl ppos recs) chart
      | inRange (bounds lin) ppos =
           case lin ! ppos of
             FSymCat c r d -> case insertXChart chart item c of
	                        Nothing    -> chart
	                        Just chart -> let items = do Final _ found' _ <- lookupXChartFinal chart c
	         			                     rng'  <- concatRange rng (found' !! r)
	         			                     recs' <- updateChildren recs d found'
	     			                             return (Active ruleid found rng' lbl (ppos+1) recs')
	     			                          ++
	     			                          do guard (isTD strategy)
	     			                             ruleid <- topdownRules pinfo ? c
	     			                             let FRule abs lins = allRules pinfo ! ruleid
	     			                             return (Active ruleid [] EmptyRange 0 0 (emptyChildren abs))
	     			              in process strategy pinfo toks items chart
	     FSymTok tok   -> let items = do (i,j) <- inputToken toks ? tok
	                                     rng' <- concatRange rng (makeRange i j)
	                                     return (Active ruleid found rng' lbl (ppos+1) recs)
                              in process strategy pinfo toks items chart
      | otherwise =
           if inRange (bounds lins) (lbl+1)
             then univRule (Active ruleid (rng:found)           EmptyRange (lbl+1) 0 recs) chart
             else univRule (Final  ruleid (reverse (rng:found))                      recs) chart
      where
        (FRule (Abs cat _ fn) lins) = allRules pinfo ! ruleid
        lin            = lins ! lbl
    univRule item@(Final ruleid found' recs) chart =
      case insertXChart chart item cat of
        Nothing    -> chart
        Just chart -> let items = do (Active ruleid found rng l ppos recs) <- lookupXChartAct chart cat
                                     let FRule _ lins    = allRules pinfo ! ruleid
                                         FSymCat cat r d = lins ! l ! ppos
                                     rng'  <- concatRange rng (found' !! r)
                                     recs' <- updateChildren recs d found'
                                     return (Active ruleid found rng' l (ppos+1) recs')
                                  ++
    			          do guard (isBU strategy)
			             ruleid <- leftcornerCats pinfo ? cat
			             let FRule abs lins = allRules pinfo ! ruleid
			                 FSymCat cat r d = lins ! 0 ! 0
                                     return (Active ruleid [] (found' !! r) 0 1 (updateNth (const found') d (emptyChildren abs)))
                      in process strategy pinfo toks items chart
      where
        (FRule (Abs cat _ fn) _) = allRules pinfo ! ruleid

----------------------------------------------------------------------
-- * XChart

data Item
  = Active {-# UNPACK #-} !RuleId
           RangeRec
           Range
           {-# UNPACK #-} !FLabel
           {-# UNPACK #-} !FPointPos
           [RangeRec]
  | Final {-# UNPACK #-} !RuleId RangeRec [RangeRec]
  deriving (Eq, Ord)

data XChart c = XChart !(ParseChart Item c) !(ParseChart Item c)

emptyXChart :: Ord c => XChart c
emptyXChart = XChart emptyChart emptyChart

insertXChart (XChart actives finals) item@(Active _ _ _ _ _ _) c = 
  case chartInsert actives item c of
    Nothing      -> Nothing
    Just actives -> Just (XChart actives finals)

insertXChart (XChart actives finals) item@(Final _ _ _)       c =
  case chartInsert finals item c of
    Nothing     -> Nothing
    Just finals -> Just (XChart actives finals)

lookupXChartAct   (XChart actives finals) c = chartLookup actives c
lookupXChartFinal (XChart actives finals) c = chartLookup finals  c

listXChartAct   (XChart actives finals) = chartList actives
listXChartFinal (XChart actives finals) = chartList finals


----------------------------------------------------------------------
-- Earley --

-- anropas med alla startkategorier
initial :: (Ord c, Ord n, Ord t) => FCFPInfo c n t -> [c] -> Input t -> [Item]
initial pinfo starts toks = 
    tracePrt "MCFG.Active (Earley) - initial rules" (prt . length) $
    do cat <- starts
       ruleid <- topdownRules pinfo ? cat
       let FRule abs lins = allRules pinfo ! ruleid
       return $ Active ruleid [] (Range 0 0) 0 0 (emptyChildren abs)


----------------------------------------------------------------------
-- Kilbury --

terminal :: (Ord c, Ord n, Ord t) => FCFPInfo c n t -> Input t -> [Item]
terminal pinfo toks = 
    tracePrt "MCFG.Active (Kilbury) - initial terminal rules" (prt . length) $
    do ruleid <- emptyRules pinfo
       let FRule abs lins = allRules pinfo ! ruleid
       rrec <- mapM (rangeRestSyms toks EmptyRange . elems) (elems lins)
       return $ Final ruleid rrec []
    where
      rangeRestSyms toks rng []                 = return rng
      rangeRestSyms toks rng (FSymTok tok:syms) = do (i,j) <- inputToken toks ? tok
                                                     rng' <- concatRange rng (makeRange i j)
                                                     rangeRestSyms toks rng' syms

initialScan :: (Ord c, Ord n, Ord t) => FCFPInfo c n t -> Input t -> [Item]
initialScan pinfo toks =
    tracePrt "MCFG.Active (Kilbury) - initial scanned rules" (prt . length) $
    do tok <- aElems (inputToken toks)
       ruleid <- leftcornerTokens pinfo ? tok
       let FRule abs lins = allRules pinfo ! ruleid
       return $ Active ruleid [] EmptyRange 0 0 (emptyChildren abs)
