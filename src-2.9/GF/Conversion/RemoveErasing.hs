----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/09 09:28:44 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.3 $
--
-- Removing erasingness from MCFG grammars (as in Ljunglöf 2004, sec 4.5.1)
-----------------------------------------------------------------------------


module GF.Conversion.RemoveErasing
    (convertGrammar) where

import GF.System.Tracing
import GF.Infra.Print

import Control.Monad 
import Data.List (mapAccumL)
import Data.Maybe (mapMaybe)
import GF.Formalism.Utilities
import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Conversion.Types
import GF.Data.Assoc
import GF.Data.SortedList
import GF.Data.GeneralDeduction

convertGrammar :: EGrammar -> [SCat] -> MGrammar
convertGrammar grammar starts = newGrammar
    where newGrammar  = tracePrt "RemoveErasing - nonerasing rules" (prt . length) $
			[ rule | NR rule <- chartLookup finalChart True ]
	  finalChart  = tracePrt "RemoveErasing - nonerasing cats" 
			(prt . length . flip chartLookup False) $
			buildChart keyof [newRules rulesByCat] $
			tracePrt "RemoveErasing - initial ne-cats" (prt . length) $
			initialCats
	  initialCats = trace2 "RemoveErasing - starting categories" (prt starts) $
			if null starts 
			  then trace2 "RemoveErasing" "initialCatsBU" $
			       initialCatsBU rulesByCat
			  else trace2 "RemoveErasing" ("initialCatsTD: " ++ prt starts) $
			       initialCatsTD rulesByCat starts
	  rulesByCat  = trace2 "RemoveErasing - erasing rules" (prt $ length grammar) $
			accumAssoc id [ (cat, rule) | rule@(Rule (Abs cat _ _) _) <- grammar ]

data Item r c = NR r | NC c deriving (Eq, Ord, Show)

keyof (NR _) = True
keyof (NC _) = False

newRules grammar chart (NR (Rule (Abs _ cats _) _))
    = [ NC cat | cat@(MCat _ lbls) <- cats, not (null lbls) ]
newRules grammar chart (NC newCat@(MCat cat lbls))
    = do Rule (Abs _ args (Name fun profile)) (Cnc _ _ lins0) <- grammar ? cat

         lins <- selectLins lins0 lbls 
	 -- let lins = [ lin | lin@(Lin lbl _) <- lins0, 
	 -- 	      lbl `elem` lbls ]

	 let argsInLin = listAssoc $
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
	     newName = -- tracePrt "newName" (prtNewName profile newProfile) $
                       Name fun (profile `composeProfiles` newProfile)

         guard $ all (not . null) argLbls
	 return $ NR (Rule (Abs newCat newArgs newName) (Cnc lbls argLbls newLins))

selectLins lins0 = mapM selectLbl
    where selectLbl lbl = [ lin | lin@(Lin lbl' _) <- lins0, lbl == lbl' ] 


prtNewName :: [Profile (SyntaxForest Fun)] -> [Profile (SyntaxForest Fun)] -> Name -> String
prtNewName p p' n = prt p ++ " .o. " ++ prt p' ++ " : " ++ prt n


initialCatsTD grammar starts =
    [ cat | cat@(NC (MCat (ECat start _) _)) <- initialCatsBU grammar,
      start `elem` starts ]

initialCatsBU grammar 
    = [ NC (MCat cat [lbl]) | (cat, rules) <- aAssocs grammar, 
	let Rule _ (Cnc lbls _ _) = head rules,
	lbl <- lbls ]







