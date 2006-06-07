----------------------------------------------------------------------
-- |
-- Maintainer  : Peter Ljunglöf
-- Stability   : (stable)
-- Portability : (portable)
--
-- MCFG parsing, the active algorithm, optimized version
-- structure stolen from Krasimir Angelov's GF.Parsing.FCFG.Active
-----------------------------------------------------------------------------

module GF.Parsing.MCFG.FastActive (parse) where

import GF.Data.GeneralDeduction
import GF.Data.Assoc
import GF.Data.Utilities

import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Formalism.Utilities

import GF.Infra.Ident

import GF.Parsing.MCFG.Range
import GF.Parsing.MCFG.PInfo

import GF.System.Tracing

import Control.Monad (guard)

import GF.Infra.Print

import qualified Data.List as List
import qualified Data.Map  as Map
import qualified Data.Set  as Set
import Data.Array

----------------------------------------------------------------------
-- * parsing

-- parse :: (Ord c, Ord n, Ord l, Ord t) => String -> MCFParser c n l t
parse strategy pinfo starts =
    [ Abs (cat, found) (zip rhs rrecs) fun |
      Final (Abs cat rhs fun) found rrecs <- listXChartFinal chart ]
    where chart = process strategy pinfo axioms emptyXChart
    
          -- axioms | isBU  strategy = terminal pinfo toks ++ initialScan pinfo toks
          axioms | isBU  strategy = initialBU pinfo
		 | isTD  strategy = initialTD pinfo starts

isBU  s = s=="b"
isTD  s = s=="t"

-- used in prediction
emptyChildren :: Abstract c n -> [RangeRec l]
emptyChildren (Abs _ rhs _) = replicate (length rhs) []

updateChildren :: Eq l => [RangeRec l] -> Int -> RangeRec l -> [[RangeRec l]]
updateChildren recs i rec = updateNthM update i recs
    where update rec' = do guard (null rec' || rec' == rec)
                           return rec

process :: (Ord c, Ord n, Ord l) => String -> MCFPInfo c n l Range -> [Item c n l] -> XChart c n l -> XChart c n l
process strategy pinfo []           chart = chart
process strategy pinfo (item:items) chart = process strategy pinfo items $! univRule item chart
  where
    univRule item@(Active abs found rng (Lin l syms) lins recs) chart 
        = case syms of
            Cat(c,r,d) : syms' -> 
                case insertXChart chart item c of
	          Nothing    -> chart
	          Just chart -> 
                      let items = -- predict topdown
                                  [ Active abs [] EmptyRange lin lins (emptyChildren abs) |
	     			    isTD strategy,
	     			    Rule abs (Cnc _ _ (lin:lins)) <- topdownRules pinfo ? c ] ++

                                  -- combine
                                  [ Active abs found rng'' (Lin l syms') lins recs' |
                                    Final _ found' _ <- lookupXChartFinal chart c,
                                    rng'  <- projection r found',
	         	            rng'' <- concatRange rng rng',
	         	            recs' <- updateChildren recs d found' ]
	     	      in process strategy pinfo items chart

            -- scan
	    Tok rng' : syms' -> 
                let items = [ Active abs found rng'' (Lin l syms') lins recs |
                              rng'' <- concatRange rng rng' ]
                in process strategy pinfo items chart

            -- complete
            [] -> case lins of
                    (lin':lins') -> univRule (Active abs ((l,rng):found) EmptyRange lin' lins' recs) chart
                    []           -> univRule (Final  abs (reverse ((l,rng):found))             recs) chart 

    univRule item@(Final abs@(Abs cat _ _) found' recs) chart =
      case insertXChart chart item cat of
        Nothing    -> chart
        Just chart -> 
            let items = -- predict bottomup
    			[ Active abs [] rng (Lin l syms') lins children |
                          isBU strategy,
			  Rule abs (Cnc _ _ (Lin l (Cat(c,r,d):syms') : lins)) <- leftcornerCats pinfo ? cat,
                          -- lin' : lins' <- rangeRestRec toks (Lin l syms' : lins),
                          rng <- projection r found',
                          children <- unifyRec (emptyChildren abs) d found' ] ++

                        -- combine
                        [ Active abs found rng'' (Lin l syms') lins recs' |
                          Active abs found rng (Lin l (Cat(c,r,d):syms')) lins recs <- lookupXChartAct chart cat,
                          rng'  <- projection r found',
                          rng'' <- concatRange rng rng',
                          recs' <- updateChildren recs d found' ] 
            in process strategy pinfo items chart

----------------------------------------------------------------------
-- * XChart

data XChart c n l = XChart !(AChart c n l) !(AChart c n l)
type AChart c n l = ParseChart (Item c n l) c

data Item   c n l = Active (Abstract c n) 
                           (RangeRec l)  
			   Range 
			   (Lin c l Range) 
			   (LinRec c l Range) 
			   [RangeRec l]
		  | Final (Abstract c n) (RangeRec l) [RangeRec l]
-- 		  | Passive c (RangeRec l)
		     deriving (Eq, Ord, Show)

emptyXChart :: (Ord c, Ord n, Ord l) => XChart c n l
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

-- called with all starting categories
initialTD :: (Ord c, Ord n, Ord l) => MCFPInfo c n l Range -> [c] -> [Item c n l]
initialTD pinfo starts = 
    [ Active abs [] (Range (0, 0)) lin' lins' (emptyChildren abs) |
      cat <- starts,
      Rule abs (Cnc _ _ (lin':lins')) <- topdownRules pinfo ? cat ]
       -- lin' : lins' <- rangeRestRec toks lins


----------------------------------------------------------------------
-- Kilbury --

initialBU :: (Ord c, Ord n, Ord l) => MCFPInfo c n l Range -> [Item c n l]
initialBU pinfo =
    [ Active abs [] EmptyRange lin' lins' (emptyChildren abs) |
      -- do tok <- aElems (inputToken toks)
      Rule abs (Cnc _ _ (lin':lins')) <- 
          concatMap snd (aAssocs (leftcornerTokens pinfo)) ++
          -- leftcornerTokens pinfo ? tok ++
          epsilonRules pinfo ]
       -- lin' : lins' <- rangeRestRec toks lins
