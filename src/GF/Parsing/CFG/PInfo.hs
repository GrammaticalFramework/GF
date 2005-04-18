---------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/18 14:55:33 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.3 $
--
-- CFG parsing, parser information
-----------------------------------------------------------------------------

module GF.NewParsing.CFG.PInfo
    (CFParser, CFPInfo(..), buildCFPInfo) where

import GF.System.Tracing
import GF.Infra.Print

import GF.Formalism.Utilities
import GF.Formalism.CFG
import GF.Data.SortedList
import GF.Data.Assoc

----------------------------------------------------------------------
-- type declarations

-- | the list of categories = possible starting categories
type CFParser c n t = CFPInfo c n t 
		    -> [c]
		    -> Input t
		    -> CFChart c n t

------------------------------------------------------------
-- parser information

data CFPInfo c n t
    = CFPInfo { grammarTokens        :: SList t,
		nameRules            :: Assoc n            (SList (CFRule c n t)),
		topdownRules         :: Assoc c            (SList (CFRule c n t)),
		bottomupRules        :: Assoc (Symbol c t) (SList (CFRule c n t)),
		emptyLeftcornerRules :: Assoc c            (SList (CFRule c n t)),
		emptyCategories      :: Set c,
		cyclicCategories     :: SList c,
		-- ^ ONLY FOR DIRECT CYCLIC RULES!!!
		leftcornerTokens     :: Assoc c (SList t)
		-- ^ DOES NOT WORK WITH EMPTY RULES!!!
	      }

buildCFPInfo :: (Ord n, Ord c, Ord t) => CFGrammar c n t -> CFPInfo c n t

-- this is not permanent...
buildCFPInfo grammar = traceCalcFirst grammar $
		       tracePrt "CFG.PInfo - parser info" (prt) $
		       pInfo' (filter (not . isCyclic) grammar)

pInfo' grammar = CFPInfo grToks nmRules tdRules buRules elcRules emptyCats cyclicCats leftToks 
    where grToks          = union [ nubsort [ tok | Tok tok <- rhs ] | 
				    CFRule _ rhs _ <- grammar ]
	  nmRules         = accumAssoc id [ (name, rule) | 
					    rule@(CFRule _ _ name) <- grammar ]
	  tdRules         = accumAssoc id [ (cat,  rule) | 
					    rule@(CFRule cat _ _) <- grammar ]
	  buRules         = accumAssoc id [ (next, rule) | 
					    rule@(CFRule _ (next:_) _) <- grammar ]
	  elcRules        = accumAssoc id $ limit lc emptyRules
	  leftToks        = accumAssoc id $ limit lc $ 
			    nubsort [ (cat, token) | 
				      CFRule cat (Tok token:_) _ <- grammar ]
	  lc (left, res)  = nubsort [ (cat, res)   | 
				      CFRule cat _ _ <- buRules ? Cat left ]
	  emptyRules      = nubsort [ (cat, rule)  | 
				      rule@(CFRule cat [] _) <- grammar ]
	  emptyCats       = listSet $ limitEmpties $ map fst emptyRules
	  limitEmpties es = if es==es' then es else limitEmpties es'
	      where es'   = nubsort [ cat | CFRule cat rhs _ <- grammar, 
				      all (symbol (\e -> e `elem` es) (const False)) rhs ]
	  cyclicCats      = nubsort [ cat | CFRule cat [Cat cat'] _ <- grammar, cat == cat' ]

isCyclic (CFRule cat [Cat cat'] _) = cat==cat'
isCyclic _ = False


----------------------------------------------------------------------

instance (Ord n, Ord c, Ord t) => Print (CFPInfo n c t) where
    prt pI = "[ nr. tokens=" ++ sl grammarTokens ++
	     "; nr. names=" ++ sla nameRules ++ 
	     "; nr. tdCats=" ++ sla topdownRules ++
	     "; nr. buCats=" ++ sla bottomupRules ++ 
	     "; nr. elcCats=" ++ sla emptyLeftcornerRules ++
	     "; nr. eCats=" ++ sla emptyCategories ++
	     "; nr. cCats=" ++ sl cyclicCategories ++
	     "; nr. lctokCats=" ++ sla leftcornerTokens ++ 
	     " ]"
	where sla f = show $ length $ aElems $ f pI
	      sl  f = show $ length $ f pI
