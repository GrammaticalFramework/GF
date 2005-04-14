----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/14 18:41:21 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Instantiating all types which only have one single element.
--
-- Should be merged into 'GF.Conversion.FiniteToSimple'
-----------------------------------------------------------------------------

module GF.Conversion.RemoveSingletons where

import GF.System.Tracing
import GF.Infra.Print

import GF.Formalism.Utilities
import GF.Formalism.GCFG
import GF.Formalism.SimpleGFC
import GF.Conversion.Types

import GF.Data.SortedList
import GF.Data.Assoc

import List (mapAccumL)

convertGrammar :: SGrammar -> SGrammar
convertGrammar grammar = if singles == emptyAssoc then grammar
			 else tracePrt "#singleton-removed rules" (prt . length) $
			      map (convertRule singles) grammar
    where singles = calcSingletons grammar

convertRule :: Assoc SCat (SyntaxForest Fun, Maybe STerm) -> SRule -> SRule
convertRule singles rule@(Rule (Abs _ decls _) _)
    = if all (Nothing ==) singleArgs then rule
      else instantiateSingles singleArgs rule
    where singleArgs = map (lookupAssoc singles . decl2cat) decls

instantiateSingles :: [Maybe (SyntaxForest Fun, Maybe STerm)] -> SRule -> SRule
instantiateSingles singleArgs (Rule (Abs decl decls (Name fun profile)) (Cnc lcat lcats lterm))
    = Rule (Abs decl decls' (Name fun profile')) (Cnc lcat lcats' lterm')
    where (decls', lcats') = unzip [ (d, l) | (Nothing, d, l) <- zip3 singleArgs decls lcats ]
	  profile'  = map (fmap fst) exProfile `composeProfiles` profile
	  newArgs   = map (fmap snd) exProfile
	  lterm'    = fmap (instantiateLin newArgs) lterm
	  exProfile = snd $ mapAccumL mkProfile 0 singleArgs
	  mkProfile nr (Just trm) = (nr, Constant trm)
	  mkProfile nr (Nothing)  = (nr+1, Unify [nr])

instantiateLin :: [Profile (Maybe STerm)] -> STerm -> STerm
instantiateLin newArgs = inst
    where inst (Arg nr cat path) 
	      = case newArgs !! nr of
		  Unify [nr']          -> Arg nr' cat path
		  Constant (Just term) -> termFollowPath path term
		  Constant Nothing     -> error "instantiateLin: argument has no linearization"
	  inst (cn :^ terms) = cn :^ map inst terms
	  inst (Rec rec)     = Rec [ (lbl, inst term) | (lbl, term) <- rec ]
	  inst (term :. lbl) = inst term +. lbl
	  inst (Tbl tbl)     = Tbl [ (pat, inst term) | (pat, term) <- tbl ]
	  inst (term :! sel) = inst term +! inst sel
	  inst (Variants ts) = variants (map inst ts)
	  inst (t1 :++ t2)   = inst t1 ?++ inst t2
	  inst term          = term

----------------------------------------------------------------------

calcSingletons :: SGrammar -> Assoc SCat (SyntaxForest Fun, Maybe STerm)
calcSingletons rules = listAssoc singleCats
    where singleCats = tracePrt "singleton cats" (prtSep " ") $
		       [ (cat, (constantNameToForest name, lin)) | 
			 (cat, [([], name, lin)]) <- rulesByCat ]
	  rulesByCat = groupPairs $ nubsort
		       [ (decl2cat cat, (args, name, lin)) | 
			 Rule (Abs cat args name) (Cnc _ _ lin) <- rules ]



