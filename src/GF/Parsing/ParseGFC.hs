----------------------------------------------------------------------
-- |
-- Module      : ParseGFC
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/21 22:31:51 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
--
-- The main parsing module, parsing GFC grammars
-- by translating to simpler formats, such as PMCFG and CFG
----------------------------------------------------------------------

module GF.Parsing.ParseGFC (newParser) where

import Tracing 
import GF.Printing.PrintParser
import qualified PrGrammar

-- Haskell modules
import Monad
-- import Ratio ((%))
-- GF modules
import qualified Grammar as GF
import Values
import qualified Macros 
import qualified Modules as Mods
import qualified AbsGFC
import qualified Ident
import qualified ShellState as SS
import Operations
import GF.Data.SortedList 
-- Conversion and parser modules
import GF.Data.Assoc
import GF.Parsing.Utilities
-- import ConvertGrammar
import GF.Parsing.GrammarTypes
import qualified GF.Parsing.MCFGrammar as M
import qualified GF.Parsing.CFGrammar as C
import qualified GF.Parsing.ParseMCFG as PM
import qualified GF.Parsing.ParseCFG as PC
--import MCFRange

newParser :: String -> SS.StateGrammar -> GF.Cat -> String -> Err [GF.Term]

-- parsing via MCFG
newParser (m:strategy) gr (_, startCat) inString 
    | m=='m' || m=='M' = trace2 "Parser" "MCFG" $ Ok terms
    where terms    = map (ptree2term abstract) trees
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

-- parsing via CFG
newParser (c:strategy) gr (_, startCat) inString 
    | c=='c' || c=='C' = trace2 "Parser" "CFG" $ Ok terms
    where terms    = -- tracePrt "terms" (unlines . map PrGrammar.prt) $
		     map (ptree2term abstract) trees
	  trees    = tracePrt "#trees" (prt . length) $
		     --tracePrt "trees" (prtSep "\n") $
		     concatMap forest2trees forests
	  forests  = tracePrt "$cfForests" (prt) $ -- . length) $
		     tracePrt "forests" (unlines . map prt) $
		     concatMap convertFromCFForest cfForests
	  cfForests= tracePrt "cfForests" (unlines . map prt) $
		     concatMap (chart2forests chart (const False)) finalEdges
	  finalEdges = tracePrt "finalChartEdges" prt $
		       map (uncurry Edge (inputBounds inTokens)) starters
	  chart    = --tracePrt "finalChartEdges" (prt . (? finalEdge)) $
		     tracePrt "#chart" (prt . map (length.snd) . aAssocs) $
		     C.edges2chart inTokens edges
	  edges    = --tracePrt "finalEdges" 
		     --(prt . filter (\(Edge i j _) -> (i,j)==inputBounds inTokens)) $
		     tracePrt "#edges" (prt . length) $
		     PC.parse strategy pInf starters inTokens
	  inTokens = input $ map AbsGFC.KS $ words inString
	  pInf     = cfPInfo $ SS.statePInfo gr
	  starters = tracePrt "startCats" prt $
		     filter isStartCat $ map fst $ aAssocs $ C.topdownRules pInf
	  isStartCat (CFCat (MCFCat cat _) _) = cat == startCat
	  abstract = tracePrt "abstract module" PrGrammar.prt $
		     SS.absId gr
		     --ifNull (Ident.identC "ABS") last $ 
		     --[i | (i, Mods.ModMod m) <- Mods.modules (SS.grammar gr), Mods.isModAbs m]

newParser "" gr start inString = newParser "c" gr start inString

newParser opt gr (_,cat) _ = 
  Bad ("new-parser '" ++ opt ++ "' not defined yet")

ptree2term :: Ident.Ident -> ParseTree Name -> GF.Term
ptree2term a (TNode f ts) = Macros.mkApp (Macros.qq (a,f)) (map (ptree2term a) ts)
ptree2term a (TMeta)      = GF.Meta (GF.MetaSymb 0)

----------------------------------------------------------------------
-- conversion and unification of forests

convertFromCFForest :: ParseForest CFName -> [ParseForest Name]
convertFromCFForest (FNode (CFName name profile) children) 
    | isCoercion name = concat chForests
    | otherwise       = [ FNode name chForests | not (null chForests) ]
    where chForests   = concat [ mapM (checkProfile forests) profile |
				 forests0 <- children,
				 forests <- mapM convertFromCFForest forests0 ]
	  checkProfile forests = unifyManyForests . map (forests !!)
				 -- foldM unifyForests FMeta . map (forests !!)

isCoercion Ident.IW = True
isCoercion _        = False

unifyManyForests :: Eq n => [ParseForest n] -> [ParseForest n]
unifyManyForests [] = [FMeta]
unifyManyForests [f] = [f]
unifyManyForests (f:g:fs) = do h <- unifyForests f g
			       unifyManyForests (h:fs)

unifyForests :: Eq n => ParseForest n -> ParseForest n -> [ParseForest n]
unifyForests FMeta  forest = [forest]
unifyForests forest FMeta  = [forest]
unifyForests (FNode name1 children1) (FNode name2 children2)
    = [ FNode name1 children | name1 == name2, not (null children) ]
    where children = [ forests | forests1 <- children1, forests2 <- children2,
		       forests <- zipWithM unifyForests forests1 forests2 ]



{-
----------------------------------------------------------------------
-- conversion and unification for parse trees instead of forests

convertFromCFTree :: ParseTree CFName -> [ParseTree Name]
convertFromCFTree (TNode (CFName name profile) children0) 
    = [ TNode name children |
	children1 <- mapM convertFromCFTree children0,
	children <- mapM (checkProfile children1) profile ]
    where checkProfile trees = unifyManyTrees . map (trees !!)

unifyManyTrees :: Eq n => [ParseTree n] -> [ParseTree n]
unifyManyTrees [] = [TMeta]
unifyManyTrees [f] = [f]
unifyManyTrees (f:g:fs) = do h <- unifyTrees f g
			     unifyManyTrees (h:fs)

unifyTrees TMeta tree = [tree]
unifyTrees tree TMeta = [tree]
unifyTrees (TNode name1 children1) (TNode name2 children2)
    = [ TNode name1 children | name1 == name2, 
	children <- zipWithM unifyTrees children1 children2 ]

-}

