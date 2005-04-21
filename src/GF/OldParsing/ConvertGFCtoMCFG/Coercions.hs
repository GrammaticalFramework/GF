----------------------------------------------------------------------
-- |
-- Module      : ConvertGFCtoMCFG.Coercions
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:54 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- Adding coercion functions to a MCFG if necessary.
-----------------------------------------------------------------------------


module GF.OldParsing.ConvertGFCtoMCFG.Coercions (addCoercions) where

import GF.System.Tracing
import GF.Printing.PrintParser
import GF.Printing.PrintSimplifiedTerm
-- import PrintGFC
-- import qualified PrGrammar as PG

import qualified GF.Infra.Ident as Ident
import GF.OldParsing.Utilities
import GF.OldParsing.GrammarTypes 
import GF.OldParsing.MCFGrammar (Rule(..), Lin(..))
import GF.Data.SortedList
import Data.List (groupBy) -- , transpose)

----------------------------------------------------------------------

addCoercions :: MCFGrammar -> MCFGrammar
addCoercions rules = coercions ++ rules
    where (allHeads, allArgs) = unzip [ ((head, lbls), nubsort args) | 
					Rule head args lins _ <- rules, 
					let lbls = [ lbl | Lin lbl _ <- lins ] ]
	  allHeadSet = nubsort allHeads
	  allArgSet  = union   allArgs <\\> map fst allHeadSet
	  coercions = tracePrt "#coercions total" (prt . length) $
		      concat $
		      tracePrt "#coercions per cat" (prtList . map length) $
		      combineCoercions 
		        (groupBy sameCatFst allHeadSet) 
			(groupBy sameCat    allArgSet)
	  sameCatFst a b = sameCat (fst a) (fst b)


combineCoercions [] _ = []
combineCoercions _ [] = []
combineCoercions allHeads'@(heads:allHeads) allArgs'@(args:allArgs) 
    = case compare (mainCat $ fst $ head heads) (mainCat $ head args) of
        LT -> combineCoercions allHeads  allArgs'
	GT -> combineCoercions allHeads' allArgs
	EQ -> makeCoercion heads args : combineCoercions allHeads allArgs


makeCoercion heads args = [ Rule arg [head] lins coercionName |
			    (head@(MCFCat _ headCns), lbls) <- heads, 
			    let lins = [ Lin lbl [Cat (head, lbl, 0)] | lbl <- lbls ],
			    arg@(MCFCat _ argCns) <- args,
			    argCns `subset` headCns ]


coercionName = Ident.IW

mainCat (MCFCat c _) = c

sameCat mc1 mc2 = mainCat mc1 == mainCat mc2


