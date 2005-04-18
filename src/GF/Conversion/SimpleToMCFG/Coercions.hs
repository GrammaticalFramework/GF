----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/18 14:55:32 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.3 $
--
-- Adding coercion functions to a MCFG if necessary.
-----------------------------------------------------------------------------


module GF.Conversion.SimpleToMCFG.Coercions
    (addCoercions) where

import GF.System.Tracing
import GF.Infra.Print

import GF.Formalism.Utilities
import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Conversion.Types 
import GF.Data.SortedList
import List (groupBy)

----------------------------------------------------------------------

addCoercions :: EGrammar -> EGrammar
addCoercions rules = coercions ++ rules
    where (allHeads, allArgs) = unzip [ ((head, lbls), nubsort args) | 
					Rule (Abs head args _) (Cnc lbls _ _) <- rules ]
	  allHeadSet = nubsort allHeads
	  allArgSet  = union   allArgs <\\> map fst allHeadSet
	  coercions = tracePrt "SimpleToMCFG.Coercions - nr. MCFG coercions" (prt . length) $
		      concat $
		      tracePrt "SimpleToMCFG.Coerciions - nr. MCFG coercions per category" 
				   (prtList . map length) $
		      combineCoercions 
		        (groupBy sameECatFst allHeadSet) 
			(groupBy sameECat    allArgSet)
	  sameECatFst a b = sameECat (fst a) (fst b)


combineCoercions [] _ = []
combineCoercions _ [] = []
combineCoercions allHeads'@(heads:allHeads) allArgs'@(args:allArgs) 
    = case compare (ecat2scat $ fst $ head heads) (ecat2scat $ head args) of
        LT -> combineCoercions allHeads  allArgs'
	GT -> combineCoercions allHeads' allArgs
	EQ -> makeCoercion heads args : combineCoercions allHeads allArgs


makeCoercion heads args
    = [ Rule (Abs arg [head] coercionName) (Cnc lbls [lbls] lins)  |
	(head@(ECat _ headCns), lbls) <- heads, 
	let lins = [ Lin lbl [Cat (head, lbl, 0)] | lbl <- lbls ],
	arg@(ECat _ argCns) <- args,
	argCns `subset` headCns ]



