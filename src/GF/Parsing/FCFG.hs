----------------------------------------------------------------------
-- |
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-- FCFG parsing
-----------------------------------------------------------------------------

module GF.Parsing.FCFG
    (parseFCF,buildFCFPInfo,FCFPInfo(..),makeFinalEdge) where

import GF.Data.SortedList 
import GF.Data.Assoc

import GF.Infra.PrintClass

import GF.Formalism.FCFG
import GF.Formalism.Utilities

import qualified GF.Parsing.FCFG.Active as Active
import GF.Parsing.FCFG.PInfo

import GF.GFCC.DataGFCC
import GF.GFCC.CId
import GF.GFCC.Macros
import GF.GFCC.ErrM

import qualified Data.Map as Map

----------------------------------------------------------------------
-- parsing

-- main parsing function

parseFCF :: 
      String ->         -- ^ parsing strategy
      FCFPInfo ->       -- ^ compiled grammar (fcfg) 
      CId ->            -- ^ starting category
      [String] ->       -- ^ input tokens
      Err [Exp]         -- ^ resulting GF terms
parseFCF strategy pinfo startCat inString =
    do let inTokens = input inString
       startCats <- Map.lookup startCat (startupCats pinfo)
       fcfParser <- {- trace lctree $ -} parseFCF strategy
       let chart = fcfParser pinfo startCats inTokens
	   (i,j) = inputBounds inTokens
	   finalEdges = [makeFinalEdge cat i j | cat <- startCats]
	   forests = map cnv_forests $ chart2forests chart (const False) finalEdges
           filteredForests = forests >>= applyProfileToForest
	   trees = nubsort $ filteredForests >>= forest2trees
       return $ map tree2term trees
    where
      parseFCF :: String -> Err (FCFParser)
      parseFCF "bottomup" = Ok  $ Active.parse "b"
      parseFCF "topdown"  = Ok  $ Active.parse "t"
      parseFCF strat      = Bad $ "FCFG parsing strategy not defined: " ++ strat


cnv_forests FMeta         = FMeta
cnv_forests (FNode (Name (CId n) p) fss) = FNode (Name (CId n) (map cnv_profile p)) (map (map cnv_forests) fss)
cnv_forests (FString x)   = FString x
cnv_forests (FInt    x)   = FInt    x
cnv_forests (FFloat  x)   = FFloat  x

cnv_profile (Unify    x) = Unify x
cnv_profile (Constant x) = Constant (cnv_forests2 x)

cnv_forests2 FMeta         = FMeta
cnv_forests2 (FNode (CId n) fss) = FNode (CId n) (map (map cnv_forests2) fss)
cnv_forests2 (FString x)   = FString x
cnv_forests2 (FInt    x)   = FInt    x
cnv_forests2 (FFloat  x)   = FFloat  x

----------------------------------------------------------------------
-- parse trees to GFCC terms

tree2term :: SyntaxTree CId -> Exp
tree2term (TNode f ts) = tree (AC f) (map tree2term ts)

tree2term (TString  s) = tree (AS s) []
tree2term (TInt     n) = tree (AI n) []
tree2term (TFloat   f) = tree (AF f) []
tree2term (TMeta)      = exp0

----------------------------------------------------------------------
-- conversion and unification of forests

-- simplest implementation
applyProfileToForest :: SyntaxForest FName -> [SyntaxForest CId]
applyProfileToForest (FNode name@(Name fun profile) children) 
    | isCoercionF name = concat chForests
    | otherwise       = [ FNode fun chForests | not (null chForests) ]
    where chForests   = concat [ applyProfileM unifyManyForests profile forests |
				 forests0 <- children,
				 forests <- mapM applyProfileToForest forests0 ]
applyProfileToForest (FString s) = [FString s]
applyProfileToForest (FInt    n) = [FInt    n]
applyProfileToForest (FFloat  f) = [FFloat  f]
applyProfileToForest (FMeta)     = [FMeta]
