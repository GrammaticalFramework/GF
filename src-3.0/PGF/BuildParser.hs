---------------------------------------------------------------------
-- |
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-- FCFG parsing, parser information
-----------------------------------------------------------------------------

module PGF.BuildParser where

import GF.Data.SortedList
import GF.Data.Assoc
import PGF.CId
import PGF.Data
import PGF.Parsing.FCFG.Utilities

import Data.Array
import Data.Maybe
import qualified Data.Map as Map
import qualified Data.Set as Set
import Debug.Trace


------------------------------------------------------------
-- parser information

getLeftCornerTok (FRule _ _ _ _ lins)
  | inRange (bounds syms) 0 = case syms ! 0 of
                                FSymTok tok -> [tok]
                                _           -> []
  | otherwise               = []
  where
    syms = lins ! 0

getLeftCornerCat (FRule _ _ args _ lins)
  | inRange (bounds syms) 0 = case syms ! 0 of
                                FSymCat _ d -> [args !! d]
                                _           -> []
  | otherwise               = []
  where
    syms = lins ! 0

buildParserInfo :: FGrammar -> ParserInfo
buildParserInfo (grammar,startup) = -- trace (unlines [prt (x,Set.toList set) | (x,set) <- Map.toList leftcornFilter]) $
    ParserInfo { allRules = allrules
               , topdownRules = topdownrules
	       -- , emptyRules = emptyrules
	       , epsilonRules = epsilonrules
	       , leftcornerCats = leftcorncats
	       , leftcornerTokens = leftcorntoks
	       , grammarCats = grammarcats
	       , grammarToks = grammartoks
	       , startupCats = startup
	       }

    where allrules = listArray (0,length grammar-1) grammar
	  topdownrules  = accumAssoc id [(cat,  ruleid) | (ruleid, FRule _ _ _ cat _) <- assocs allrules]
	  epsilonrules  = [ ruleid | (ruleid, FRule _ _ _ _ lins) <- assocs allrules,
                            not (inRange (bounds (lins ! 0)) 0) ]
	  leftcorncats  = accumAssoc id [ (cat, ruleid) | (ruleid, rule) <- assocs allrules, cat <- getLeftCornerCat rule ]
	  leftcorntoks  = accumAssoc id [ (tok, ruleid) | (ruleid, rule) <- assocs allrules, tok <- getLeftCornerTok rule ]
	  grammarcats   = aElems topdownrules
	  grammartoks   = nubsort [t | (FRule _ _ _ _ lins) <- grammar, lin <- elems lins, FSymTok t <- elems lin]
