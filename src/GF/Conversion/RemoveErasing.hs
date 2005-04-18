----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/18 14:57:29 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Removing erasingness from MCFG grammars (as in Ljunglöf 2004, sec 4.5.1)
-----------------------------------------------------------------------------


module GF.Conversion.RemoveErasing
    (convertGrammar) where

import GF.System.Tracing
import GF.Infra.Print

import Monad
import List (mapAccumL)
import Maybe (mapMaybe)
import GF.Formalism.Utilities
import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Conversion.Types
import GF.Data.Assoc
import GF.Data.SortedList
import GF.NewParsing.GeneralChart

convertGrammar :: EGrammar -> MGrammar
convertGrammar grammar
    = tracePrt "RemoveErasing - nr. nonerasing rules" (prt . length) $
      traceCalcFirst finalChart $
      trace2 "RemoveErasing - nr. nonerasing cats" (prt $ length $ chartLookup finalChart False) $
      trace2 "RemoveErasing - nr. initial ne-cats" (prt $ length initialCats) $
      trace2 "RemoveErasing - nr. erasing rules" (prt $ length grammar) $
      newGrammar
    where newGrammar  = [ rule | NR rule <- chartLookup finalChart True ]
	  finalChart  = buildChart keyof [newRules rulesByCat] initialCats
	  initialCats = initialCatsBU rulesByCat
	  rulesByCat  = accumAssoc id [ (cat, rule) | rule@(Rule (Abs cat _ _) _) <- grammar ]

data Item r c = NR r | NC c deriving (Eq, Ord, Show)

keyof (NR _) = True
keyof (NC _) = False

newRules grammar chart (NR (Rule (Abs _ cats _) _))
    = [ NC cat | cat@(MCat _ lbls) <- cats, not (null lbls) ]
newRules grammar chart (NC newCat@(MCat cat lbls))
    = do Rule (Abs _ args (Name fun profile)) (Cnc _ _ lins0) <- grammar ? cat

	 let lins = [ lin | lin@(Lin lbl _) <- lins0, 
		      lbl `elem` lbls ]
	     argsInLin = listAssoc $
			 map (\((n,c),l) -> (n, MCat c l)) $
			 groupPairs $ nubsort $
			 [ ((nr, cat), lbl) | 
			   Lin _ lin <- lins, 
			   Cat (cat, lbl, nr) <- lin ] 

	     newArgs = mapMaybe (lookupAssoc argsInLin) [0 .. length args-1]
	     argLbls = [ lbls | MCat _ lbls <- newArgs ]

	     newLins = [ Lin lbl newLin | Lin lbl lin <- lins,
			 let newLin = map (mapSymbol cnvCat id) lin ]
	     cnvCat (cat, lbl, nr) = (mcat, lbl, nr')
		 where Just mcat = lookupAssoc argsInLin nr
		       Unify [nr'] = newProfile !! nr
	     nonEmptyCat (Cat (MCat _ [], _, _)) = False
	     nonEmptyCat _ = True

	     newProfile = snd $ mapAccumL accumProf 0 $
			  map (lookupAssoc argsInLin) [0 .. length args-1]
	     accumProf nr = maybe (nr, Unify []) $ const (nr+1, Unify [nr])
	     newName = Name fun (newProfile `composeProfiles` profile)

	 return $ NR (Rule (Abs newCat newArgs newName) (Cnc lbls argLbls newLins))

initialCatsBU grammar 
    = [ NC (MCat cat [lbl]) | (cat, rules) <- aAssocs grammar, 
	let Rule _ (Cnc lbls _ _) = head rules,
	lbl <- lbls ]







