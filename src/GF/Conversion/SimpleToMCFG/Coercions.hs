----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/12 10:49:44 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
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

addCoercions :: MGrammar -> MGrammar
addCoercions rules = coercions ++ rules
    where (allHeads, allArgs) = unzip [ ((head, lbls), nubsort args) | 
					Rule (Abs head args _) (Cnc lbls _ _) <- rules ]
	  allHeadSet = nubsort allHeads
	  allArgSet  = union   allArgs <\\> map fst allHeadSet
	  coercions = tracePrt "#MCFG coercions" (prt . length) $
		      concat $
		      tracePrt "#MCFG coercions per category" (prtList . map length) $
		      combineCoercions 
		        (groupBy sameCatFst allHeadSet) 
			(groupBy sameCat    allArgSet)
	  sameCatFst a b = sameCat (fst a) (fst b)


combineCoercions [] _ = []
combineCoercions _ [] = []
combineCoercions allHeads'@(heads:allHeads) allArgs'@(args:allArgs) 
    = case compare (mcat2scat $ fst $ head heads) (mcat2scat $ head args) of
        LT -> combineCoercions allHeads  allArgs'
	GT -> combineCoercions allHeads' allArgs
	EQ -> makeCoercion heads args : combineCoercions allHeads allArgs


makeCoercion heads args
    = [ Rule (Abs arg [head] coercionName) (Cnc lbls [lbls] lins)  |
	(head@(MCat _ headCns), lbls) <- heads, 
	let lins = [ Lin lbl [Cat (head, lbl, 0)] | lbl <- lbls ],
	arg@(MCat _ argCns) <- args,
	argCns `subset` headCns ]



