---------------------------------------------------------------------
-- |
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-- FCFG parsing, parser information
-----------------------------------------------------------------------------

module GF.Parsing.FCFG.PInfo where

import GF.Infra.PrintClass
import GF.Formalism.Utilities
import GF.Data.SortedList
import GF.Data.Assoc
import GF.GFCC.CId
import GF.GFCC.DataGFCC

import Data.Array
import Data.Maybe
import qualified Data.Map as Map
import qualified Data.Set as Set
import Debug.Trace

----------------------------------------------------------------------
-- type declarations

-- | the list of categories = possible starting categories
type FCFParser =  FCFPInfo
               -> [FCat]
               -> Input FToken
               -> SyntaxChart (CId,[Profile]) (FCat,RangeRec)

makeFinalEdge cat 0 0 = (cat, [EmptyRange])
makeFinalEdge cat i j = (cat, [makeRange i j])

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

buildFCFPInfo :: FGrammar -> FCFPInfo
buildFCFPInfo (grammar,startup) = -- trace (unlines [prt (x,Set.toList set) | (x,set) <- Map.toList leftcornFilter]) $
    FCFPInfo { allRules = allrules
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

fcfPInfoToFGrammar :: FCFPInfo -> FGrammar
fcfPInfoToFGrammar pinfo = (elems (allRules pinfo), startupCats pinfo)

----------------------------------------------------------------------
-- pretty-printing of statistics

instance Print FCFPInfo where
    prt pI = "[ allRules=" ++ sl (elems . allRules) ++
	     "; tdRules=" ++ sla topdownRules ++
	     -- "; emptyRules=" ++ sl emptyRules ++ 
	     "; epsilonRules=" ++ sl epsilonRules ++ 
	     "; lcCats=" ++ sla leftcornerCats ++
	     "; lcTokens=" ++ sla leftcornerTokens ++
	     "; categories=" ++ sl grammarCats ++ 
	     " ]"

	where sl  f = show $ length $ f pI
	      sla f = let (as, bs) = unzip $ aAssocs $ f pI
		       in show (length as) ++ "/" ++ show (length (concat bs))

