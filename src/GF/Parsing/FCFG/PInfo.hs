---------------------------------------------------------------------
-- |
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-- FCFG parsing, parser information
-----------------------------------------------------------------------------

module GF.Parsing.FCFG.PInfo where

import GF.System.Tracing
import GF.Infra.Print

import GF.Formalism.Utilities
import GF.Formalism.GCFG
import GF.Formalism.FCFG
import GF.Data.SortedList
import GF.Data.Assoc
import GF.Parsing.FCFG.Range

import Data.Array
import Data.Maybe

----------------------------------------------------------------------
-- type declarations

-- | the list of categories = possible starting categories
type FCFParser c n t = FCFPInfo c n t 
		     -> [c]
		     -> Input t
		     -> FCFChart c n

type FCFChart  c n   = [Abstract (c, RangeRec) n]

makeFinalEdge :: c -> Int -> Int -> (c, RangeRec)
makeFinalEdge cat i j = (cat, [makeRange i j])


------------------------------------------------------------
-- parser information

type RuleId = Int

data FCFPInfo c n t
    = FCFPInfo { allRules           :: Array RuleId (FCFRule c n t)
               , topdownRules       :: Assoc c (SList RuleId)
		 -- ^ used in 'GF.Parsing.MCFG.Active' (Earley):
	       , emptyRules         :: [RuleId]
	       , leftcornerCats     :: Assoc c (SList RuleId)
	       , leftcornerTokens   :: Assoc t (SList RuleId)
		 -- ^ used in 'GF.Parsing.MCFG.Active' (Kilbury):
	       , grammarCats        :: SList c
	       }


getLeftCornerTok lins
  | inRange (bounds syms) 0 = case syms ! 0 of
                                FSymTok tok -> Just tok
                                _           -> Nothing
  | otherwise               = Nothing
  where
    syms = lins ! 0

getLeftCornerCat lins
  | inRange (bounds syms) 0 = case syms ! 0 of
                                FSymCat c _ _ -> Just c
                                _             -> Nothing
  | otherwise               = Nothing
  where
    syms = lins ! 0

buildFCFPInfo :: (Ord c, Ord n, Ord t) => FCFGrammar c n t -> FCFPInfo c n t
buildFCFPInfo grammar = 
    traceCalcFirst grammar $
    tracePrt "MCFG.PInfo - parser info" (prt) $
    FCFPInfo { allRules = allrules
             , topdownRules = topdownrules
	     , emptyRules = emptyrules
	     , leftcornerCats = leftcorncats
	     , leftcornerTokens = leftcorntoks
	     , grammarCats = grammarcats
	     }

    where allrules = listArray (0,length grammar-1) grammar
	  topdownrules  = accumAssoc id [(cat,  ruleid) | (ruleid, FRule (Abs cat _ _)  _) <- assocs allrules]
	  emptyrules    = [ruleid | (ruleid, FRule (Abs _ [] _) _) <- assocs allrules]
	  leftcorncats  = accumAssoc id
			  [ (fromJust (getLeftCornerCat lins), ruleid) | 
			    (ruleid, FRule _ lins) <- assocs allrules, isJust (getLeftCornerCat lins) ]
	  leftcorntoks  = accumAssoc id 
			  [ (fromJust (getLeftCornerTok lins), ruleid) | 
			    (ruleid, FRule _ lins) <- assocs allrules, isJust (getLeftCornerTok lins) ]
	  grammarcats   = aElems topdownrules

----------------------------------------------------------------------
-- pretty-printing of statistics

instance (Ord c, Ord n, Ord t) => Print (FCFPInfo c n t) where
    prt pI = "[ allRules=" ++ sl (elems . allRules) ++
	     "; tdRules=" ++ sla topdownRules ++
	     "; emptyRules=" ++ sl emptyRules ++ 
	     "; lcCats=" ++ sla leftcornerCats ++
	     "; lcTokens=" ++ sla leftcornerTokens ++
	     "; categories=" ++ sl grammarCats ++ 
	     " ]"

	where sl  f = show $ length $ f pI
	      sla f = let (as, bs) = unzip $ aAssocs $ f pI
		       in show (length as) ++ "/" ++ show (length (concat bs))

