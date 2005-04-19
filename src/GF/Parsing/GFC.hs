----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/19 10:46:07 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.4 $
--
-- The main parsing module, parsing GFC grammars
-- by translating to simpler formats, such as PMCFG and CFG
----------------------------------------------------------------------

module GF.NewParsing.GFC
    (parse, PInfo(..), buildPInfo) where

import GF.System.Tracing 
import GF.Infra.Print
import qualified PrGrammar

import Monad

import qualified Grammar 
-- import Values
import qualified Macros 
-- import qualified Modules 
import qualified AbsGFC
import qualified Ident
import Operations
import CFIdent (CFCat, cfCat2Ident, CFTok, prCFTok)

import GF.Data.SortedList 
import GF.Data.Assoc
import GF.Formalism.Utilities
import GF.Conversion.Types
import GF.Formalism.GCFG
import GF.Formalism.SimpleGFC
import qualified GF.Formalism.MCFG as M
import qualified GF.Formalism.CFG as C
import qualified GF.NewParsing.MCFG as PM
import qualified GF.NewParsing.CFG as PC
--import qualified GF.Conversion.FromGFC as From

----------------------------------------------------------------------
-- parsing information

data PInfo = PInfo { mcfPInfo :: MCFPInfo,
		     cfPInfo  :: CFPInfo }

type MCFPInfo = MGrammar
type CFPInfo  = PC.CFPInfo CCat Name Token

buildPInfo :: MGrammar -> CGrammar -> PInfo
buildPInfo mcfg cfg = PInfo { mcfPInfo = mcfg,
			      cfPInfo  = PC.buildCFPInfo cfg }


----------------------------------------------------------------------
-- main parsing function

parse :: String         -- ^ parsing strategy
      -> PInfo          -- ^ compiled grammars (mcfg and cfg) 
      -> Ident.Ident    -- ^ abstract module name
      -> CFCat          -- ^ starting category
      -> [CFTok]        -- ^ input tokens
      -> [Grammar.Term] -- ^ resulting GF terms

-- parsing via CFG
parse (c:strategy) pinfo abs startCat
    | c=='c' || c=='C' = map (tree2term abs) .
			 parseCFG strategy cfpi startCats . 
			 map prCFTok
    where startCats = tracePrt "Parsing.GFC - starting categories" prt $
		      filter isStartCat $ map fst $ aAssocs $ PC.topdownRules cfpi
	  isStartCat (CCat (ECat cat _) _) = cat == cfCat2Ident startCat
	  cfpi = cfPInfo pinfo

-- parsing via MCFG
parse (c:strategy) pinfo abs startCat
    | c=='m' || c=='M' = map (tree2term abs) .
			 parseMCFG strategy mcfpi startCats . 
			 map prCFTok
    where startCats = tracePrt "Parsing.GFC - starting categories" prt $
		      filter isStartCat $ nubsort [ c | Rule (Abs c _ _) _ <- mcfpi ]
	  isStartCat (MCat (ECat cat _) _) = cat == cfCat2Ident startCat
	  mcfpi = mcfPInfo pinfo

-- default parser
parse strategy pinfo abs start = parse ('c':strategy) pinfo abs start

----------------------------------------------------------------------

parseCFG :: String -> CFPInfo -> [CCat] -> [Token] -> [SyntaxTree Fun]
parseCFG strategy pinfo startCats inString = trace2 "Parsing.GFC - selected algorithm" "CFG" $
					     trees
    where trees    = tracePrt "Parsing.GFC - nr. trees" (prt . length) $
		     nubsort $ forests >>= forest2trees
		     -- compactFs >>= forest2trees

	  -- compactFs  = tracePrt "#compactForests" (prt . length) $
	  -- 	       tracePrt "compactForests" (prtBefore "\n") $
	  -- 	       compactForests forests

	  forests  = tracePrt "Parsing.GFC - nr. forests" (prt . length) $
		     cfForests >>= convertFromCFForest
	  cfForests= tracePrt "Parsing.GFC - nr. context-free forests" (prt . length) $
		     chart2forests chart (const False) finalEdges

	  finalEdges = tracePrt "Parsing.GFC - final chart edges" prt $
		       map (uncurry Edge (inputBounds inTokens)) startCats
	  chart    = --tracePrt "finalChartEdges" (prt . (? finalEdge)) $
		     tracePrt "Parsing.GFC - size of chart" (prt . map (length.snd) . aAssocs) $
		     C.grammar2chart cfChart
	  cfChart  = --tracePrt "finalEdges" 
		     --(prt . filter (\(Edge i j _) -> (i,j)==inputBounds inTokens)) $
		     tracePrt "Parsing.GFC - size of context-free chart" (prt . length) $
		     PC.parseCF strategy pinfo startCats inTokens

	  inTokens = input inString

----------------------------------------------------------------------

parseMCFG :: String -> MCFPInfo -> [MCat] -> [Token] -> [SyntaxTree Fun]
parseMCFG strategy pinfo startCats inString = trace2 "Parsing.GFC - selected algorithm" "MCFG" $
					      trees
    where trees   = tracePrt "Parsing.GFC - nr. trees" (prt . length) $
		    forests >>= forest2trees

	  forests  = tracePrt "Parsing.GFC - nr. forests" (prt . length) $
		     cfForests >>= convertFromCFForest
	  cfForests= tracePrt "Parsing.GFC - nr. context-free forests" (prt . length) $
		     chart2forests chart (const False) finalEdges

	  chart   = tracePrt "Parsing.GFC - size of chart" (prt . map (length.snd) . aAssocs) $
		    PM.parseMCF strategy pinfo inString -- inTokens

	  finalEdges = tracePrt "Parsing.GFC - final chart edges" prt $
		       [ PM.makeFinalEdge cat lbl (inputBounds inTokens) | 
			  cat@(MCat _ [lbl]) <- startCats ]

	  inTokens = input inString


----------------------------------------------------------------------
-- parse trees to GF terms

tree2term :: Ident.Ident -> SyntaxTree Fun -> Grammar.Term
tree2term abs (TNode f ts) = Macros.mkApp (Macros.qq (abs,f)) (map (tree2term abs) ts)
tree2term abs (TMeta)      = Macros.mkMeta 0


----------------------------------------------------------------------
-- conversion and unification of forests

convertFromCFForest :: SyntaxForest Name -> [SyntaxForest Fun]

-- simplest implementation
convertFromCFForest (FNode name@(Name fun profile) children) 
    | isCoercion name = concat chForests
    | otherwise       = [ FNode fun chForests | not (null chForests) ]
    where chForests   = concat [ applyProfileM unifyManyForests profile forests |
				 forests0 <- children,
				 forests <- mapM convertFromCFForest forests0 ]

{-
-- more intelligent(?) implementation
convertFromCFForest (FNode (Name name profile) children) 
    | isCoercion name = concat chForests
    | otherwise       = [ FNode name chForests | not (null chForests) ]
    where chForests   = concat [ mapM (checkProfile forests) profile |
				 forests0 <- children,
				 forests <- mapM convertFromCFForest forests0 ]
-}

{-
----------------------------------------------------------------------
-- conversion and unification for parse trees instead of forests
-- OBSOLETE!

convertFromCFTree :: SyntaxTree Name -> [SyntaxTree Fun]
convertFromCFTree (TNode name@(Name fun profile) children0) 
    | isCoercion name = concat chTrees
    | otherwise       = map (TNode fun) chTrees
    where chTrees = [ children |
		      children1 <- mapM convertFromCFTree children0,
		      children <- applyProfileM unifyManyTrees profile children1 ]
-}
