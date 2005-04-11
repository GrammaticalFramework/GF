----------------------------------------------------------------------
-- |
-- Module      : ParseCF
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/11 13:52:54 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Chart parsing of grammars in CF format
-----------------------------------------------------------------------------

module GF.OldParsing.ParseCF (parse, alternatives) where

import GF.System.Tracing
import GF.Printing.PrintParser
import GF.Printing.PrintSimplifiedTerm

import GF.Data.SortedList (nubsort)
import GF.Data.Assoc
import qualified CF
import qualified CFIdent as CFI
import GF.OldParsing.Utilities
import GF.OldParsing.CFGrammar
import qualified GF.OldParsing.ParseCFG as P

type Token    = CFI.CFTok
type Name     = CFI.CFFun
type Category = CFI.CFCat

alternatives :: [(String, [String])]
alternatives = [ ("gb",  ["G","GB","_gen","_genBU"]),
		 ("gt",  ["GT","_genTD"]),
		 ("ibn", ["","I","B","IB","IBN","_inc","BU","_incBU"]),
		 ("ibb", ["BB","IBB","BU_BUF","_incBU_BUF"]),
		 ("ibt", ["BT","IBT","BU_TDF","_incBU_TDF"]),
		 ("iba", ["BA","IBA","BU_BTF","BU_TBF","_incBU_BTF","_incBU_TBF"]),
		 ("itn", ["T","IT","ITN","TD","_incTD"]),
		 ("itb", ["TB","ITB","TD_BUF","_incTD_BUF"])
	       ]

parse :: String -> CF.CF -> Category -> CF.CFParser
parse = buildParser . P.parse 

buildParser :: CFParser Name Category Token -> CF.CF -> Category -> CF.CFParser
buildParser parser cf start tokens = trace "ParseCF" $
				     (parseResults, parseInformation)
    where parseInformation = prtSep "\n" trees
	  parseResults     = {-take maxTake-} [ (tree2cfTree t, []) | t <- trees ]
	  theInput = input tokens
	  edges    = tracePrt "#edges" (prt.length) $
		     parser pInf [start] theInput
	  chart    = tracePrt "#chart" (prt . map (length.snd) . aAssocs) $
		     edges2chart theInput $ map (fmap addCategory) edges
	  forests  = tracePrt "#forests" (prt.length) $
		     chart2forests chart (const False) $ 
		     uncurry Edge (inputBounds theInput) start
	  trees    = tracePrt "#trees" (prt.length) $
		     concatMap forest2trees forests
	  pInf     = pInfo $ cf2grammar cf (nubsort tokens)
	  

addCategory (Rule cat rhs name) = Rule cat rhs (name, cat)

tree2cfTree (TNode (name, cat) trees) = CF.CFTree (name, (cat, map tree2cfTree trees))

cf2grammar :: CF.CF -> [Token] -> Grammar Name Category Token
cf2grammar cf tokens = [ Rule cat rhs name |
			 (name, (cat, rhs0)) <- cfRules, 
			 rhs <- mapM item2symbol rhs0 ] 
    where cfRules = concatMap (CF.predefRules (CF.predefOfCF cf)) tokens ++ 
		    CF.rulesOfCF cf 
	  item2symbol (CF.CFNonterm cat) = [Cat cat]
	  item2symbol item = map Tok $ filter (CF.matchCFTerm item) tokens

-- maxTake :: Int
-- maxTake = 500
-- maxTake = maxBound


