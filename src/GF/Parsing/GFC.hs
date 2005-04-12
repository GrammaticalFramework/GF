----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/12 10:49:45 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
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
import GF.Formalism.SimpleGFC
import qualified GF.Formalism.MCFG as M
import qualified GF.Formalism.CFG as C
-- import qualified GF.NewParsing.MCFG as PM
import qualified GF.NewParsing.CFG as PC
--import qualified GF.Conversion.FromGFC as From

----------------------------------------------------------------------
-- parsing information

data PInfo = PInfo { mcfPInfo :: (), -- ^ not implemented yet
		     cfPInfo  :: PC.CFPInfo CCat Name Token }

buildPInfo :: MGrammar -> CGrammar -> PInfo
buildPInfo mcfg cfg = PInfo { mcfPInfo = (),
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
			 parseCFG strategy pinfo startCats . 
			 map prCFTok
    where startCats = tracePrt "startCats" prt $
		      filter isStartCat $ map fst $ aAssocs $ PC.topdownRules $ cfPInfo pinfo
	  isStartCat (CCat (MCat cat _) _) = cat == cfCat2Ident startCat

-- default parser
parse strategy pinfo abs start = parse ('c':strategy) pinfo abs start


----------------------------------------------------------------------

parseCFG :: String -> PInfo -> [CCat] -> [Token] -> [SyntaxTree Fun]
parseCFG strategy pInfo startCats inString = trace2 "Parser" "CFG" $
					     trees
    where trees    = tracePrt "#trees" (prt . length) $
		     nubsort $ forests >>= forest2trees
		     -- compactFs >>= forest2trees

	  -- compactFs  = tracePrt "#compactForests" (prt . length) $
	  -- 	       tracePrt "compactForests" (prtBefore "\n") $
	  -- 	       compactForests forests

	  forests  = tracePrt "#forests" (prt . length) $
		     cfForests >>= convertFromCFForest
	  cfForests= tracePrt "#cfForests" (prt . length) $
		     chart2forests chart (const False) finalEdges

	  finalEdges = tracePrt "finalChartEdges" prt $
		       map (uncurry Edge (inputBounds inTokens)) startCats
	  chart    = --tracePrt "finalChartEdges" (prt . (? finalEdge)) $
		     tracePrt "#chart" (prt . map (length.snd) . aAssocs) $
		     C.grammar2chart cfChart
	  cfChart  = --tracePrt "finalEdges" 
		     --(prt . filter (\(Edge i j _) -> (i,j)==inputBounds inTokens)) $
		     tracePrt "#cfChart" (prt . length) $
		     PC.parseCF strategy (cfPInfo pInfo) startCats inTokens

	  inTokens = input inString


{-
-- parsing via MCFG
newParser (m:strategy) gr (_, startCat) inString 
    | m=='m' || m=='M' = trace2 "Parser" "MCFG" $ Ok terms
    where terms    = map (tree2term abstract) trees
	  trees    = --tracePrt "trees" (prtBefore "\n") $
		     tracePrt "#trees" (prt . length) $
		     concatMap forest2trees forests
	  forests  = --tracePrt "forests" (prtBefore "\n") $
		     tracePrt "#forests" (prt . length) $
		     concatMap (chart2forests chart isMeta) finalEdges
	  isMeta = null . snd
	  finalEdges = tracePrt "finalEdges" (prtBefore "\n") $
		       filter isFinalEdge $ aElems chart
-- 		       nubsort [ (cat, [(lbl, E.makeRange [(i,j)])]) | 
-- 				 let (i, j) = inputBounds inTokens,
-- 				 E.Rule cat _ [E.Lin lbl _] _ <- pInf,
-- 				 isStartCat cat ]
	  isFinalEdge (cat, rows) 
	      = isStartCat cat && 
		inputBounds inTokens `elem` concat [ rho | (_, M.Rng rho) <- rows ]
	  chart    = --tracePrt "chart" (prtBefore "\n" . aAssocs) $
		     tracePrt "#chart" (prt . map (length.snd) . aAssocs) $
		     PM.parse strategy pInf starters inTokens
	  inTokens = input $ map AbsGFC.KS $ words inString
	  pInf     = -- tracePrt "avg rec" (\gr -> show (sum [ length rec | E.Rule _ _ rec _ <- gr ] % length gr)) $
		     mcfPInfo $ SS.statePInfo gr
	  starters = tracePrt "startCats" prt $
		     filter isStartCat $ nubsort [ cat | M.Rule cat _ _ _ <- pInf ]
	  isStartCat (MCFCat cat _) = cat == startCat
	  abstract = tracePrt "abstract module" PrGrammar.prt $
		     SS.absId gr
-}


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
