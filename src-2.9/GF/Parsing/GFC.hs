----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/13 12:40:19 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.9 $
--
-- The main parsing module, parsing GFC grammars
-- by translating to simpler formats, such as PMCFG and CFG
----------------------------------------------------------------------

module GF.Parsing.GFC
    (parse, PInfo(..), buildPInfo) where

import GF.System.Tracing 
import GF.Infra.Print
import qualified GF.Grammar.PrGrammar as PrGrammar

import GF.Data.ErrM

import qualified GF.Grammar.Grammar as Grammar
import qualified GF.Grammar.Macros as Macros
import qualified GF.Canon.AbsGFC as AbsGFC
import qualified GF.GFCC.DataGFCC as AbsGFCC
import GF.GFCC.CId
import qualified GF.Infra.Ident as Ident
import GF.CF.CFIdent (CFCat, cfCat2Ident, CFTok, wordsCFTok, prCFTok)

import GF.Data.SortedList 
import GF.Data.Assoc
import GF.Formalism.Utilities
import GF.Conversion.Types

import qualified GF.Formalism.GCFG as G
import qualified GF.Formalism.SimpleGFC as S
import qualified GF.Formalism.MCFG as M
import GF.Formalism.FCFG
import qualified GF.Formalism.CFG as C
import qualified GF.Parsing.MCFG as PM
import qualified GF.Parsing.FCFG as PF
import qualified GF.Parsing.CFG as PC

----------------------------------------------------------------------
-- parsing information

data PInfo = PInfo { mcfPInfo :: MCFPInfo
		   , fcfPInfo :: PF.FCFPInfo
		   , cfPInfo  :: CFPInfo
		   }

type MCFPInfo = PM.MCFPInfo MCat Name MLabel Token
type CFPInfo  = PC.CFPInfo CCat Name Token

buildPInfo :: MGrammar -> FGrammar -> CGrammar -> PInfo
buildPInfo mcfg fcfg cfg = PInfo { mcfPInfo = PM.buildMCFPInfo mcfg
                                 , fcfPInfo = PF.buildFCFPInfo fcfg
			         , cfPInfo  = PC.buildCFPInfo  cfg
			         }

instance Print PInfo where
    prt (PInfo m f c) = prt m ++ "\n" ++ prt c

----------------------------------------------------------------------
-- main parsing function

parse :: String         -- ^ parsing algorithm (mcfg or cfg)
      -> String         -- ^ parsing strategy
      -> PInfo          -- ^ compiled grammars (mcfg and cfg) 
      -> Ident.Ident    -- ^ abstract module name
      -> CFCat          -- ^ starting category
      -> [CFTok]        -- ^ input tokens
      -> Err [Grammar.Term] -- ^ resulting GF terms


-- parsing via CFG
parse "c" strategy pinfo abs startCat inString
    = do let inTokens = tracePrt "Parsing.GFC - input tokens" prt $
		      inputMany (map wordsCFTok inString)
	 let startCats = tracePrt "Parsing.GFC - starting CF categories" prt $
			 filter isStart $ map fst $ aAssocs $ PC.topdownRules cfpi
	     isStart cat = ccat2scat cat == cfCat2Ident startCat
	     cfpi = cfPInfo pinfo
	 cfParser <- PC.parseCF strategy
	 let cfChart = tracePrt "Parsing.GFC - CF chart" (prt . length) $
		       cfParser cfpi startCats inTokens
	     chart = tracePrt "Parsing.GFC - chart" (prt . map (length.snd) . aAssocs) $
		     C.grammar2chart cfChart
	     finalEdges = tracePrt "Parsing.GFC - final chart edges" prt $
			  map (uncurry Edge (inputBounds inTokens)) startCats
	     forests = chart2forests chart (const False) finalEdges
         traceM "Parsing.GFC - nr. unfiltered forests" (prt (length forests))
         traceM "Parsing.GFC - nr. unfiltered trees" (prt (length (forests >>= forest2trees)))
         let filteredForests = tracePrt "Parsing.GFC - nr. forests" (prt . length) $
	  		       forests >>= applyProfileToForest
	     -- compactFs = tracePrt "#compactForests" (prt . length) $
	     -- 	          tracePrt "compactForests" (prtBefore "\n") $
	     -- 	          compactForests forests
	     trees = tracePrt "Parsing.GFC - nr. trees" (prt . length) $
	  	     nubsort $ filteredForests >>= forest2trees
		     -- compactFs >>= forest2trees
         return $ map (tree2term abs) trees


-- parsing via MCFG
parse "m" strategy pinfo abs startCat inString
    = do let inTokens = tracePrt "Parsing.GFC - input tokens" prt $
		      inputMany (map wordsCFTok inString)
         let startCats = tracePrt "Parsing.GFC - starting MCF categories" prt $
			 filter isStart $ PM.grammarCats mcfpi
	     isStart cat = mcat2scat cat == cfCat2Ident startCat
	     mcfpi = mcfPInfo pinfo
	 mcfParser <- PM.parseMCF strategy
	 let chart = mcfParser mcfpi startCats inTokens
	     finalEdges = tracePrt "Parsing.GFC - final chart edges" prt $
			  [ PM.makeFinalEdge cat lbl (inputBounds inTokens) | 
			    cat@(MCat _ [lbl]) <- startCats ]
	     forests = chart2forests chart (const False) finalEdges
         traceM "Parsing.GFC - nr. unfiltered forests" (prt (length forests))
         traceM "Parsing.GFC - nr. unfiltered trees" (prt (length (forests >>= forest2trees)))
         let filteredForests = tracePrt "Parsing.GFC - nr. forests" (prt . length) $
	  		       forests >>= applyProfileToForest
	     -- compactFs = tracePrt "#compactForests" (prt . length) $
	     -- 	          tracePrt "compactForests" (prtBefore "\n") $
	     -- 	          compactForests forests
	     trees = tracePrt "Parsing.GFC - nr. trees" (prt . length) $
	  	     nubsort $ filteredForests >>= forest2trees
		     -- compactFs >>= forest2trees
         return $ map (tree2term abs) trees


-- parsing via FCFG
parse "f" strategy pinfo abs startCat inString =
  let Ident.IC x = cfCat2Ident startCat
      cat' = CId x
  in case PF.parseFCF strategy (fcfPInfo pinfo) cat' (map prCFTok inString) of
       Ok  es  -> Ok  (map (exp2term abs) es)
       Bad msg -> Bad msg


-- error parser: 
selectParser prs strategy _ _ _ = Bad $ "Parser '" ++ prs ++ "' not defined with strategy: " ++ strategy 

cnv_forests FMeta         = FMeta
cnv_forests (FNode (Name (CId n) p) fss) = FNode (Name (Ident.IC n) (map cnv_profile p)) (map (map cnv_forests) fss)
cnv_forests (FString x)   = FString x
cnv_forests (FInt    x)   = FInt    x
cnv_forests (FFloat  x)   = FFloat  x

cnv_profile (Unify    x) = Unify x
cnv_profile (Constant x) = Constant (cnv_forests2 x)

cnv_forests2 FMeta         = FMeta
cnv_forests2 (FNode (CId n) fss) = FNode (Ident.IC n) (map (map cnv_forests2) fss)
cnv_forests2 (FString x)   = FString x
cnv_forests2 (FInt    x)   = FInt    x
cnv_forests2 (FFloat  x)   = FFloat  x

----------------------------------------------------------------------
-- parse trees to GF terms

tree2term :: Ident.Ident -> SyntaxTree Fun -> Grammar.Term
tree2term abs (TNode f ts) = Macros.mkApp (Macros.qq (abs,f)) (map (tree2term abs) ts)
tree2term abs (TString  s) = Macros.string2term s
tree2term abs (TInt     n) = Macros.int2term    n
tree2term abs (TFloat   f) = Macros.float2term  f
tree2term abs (TMeta)      = Macros.mkMeta 0

exp2term :: Ident.Ident -> AbsGFCC.Exp -> Grammar.Term
exp2term abs (AbsGFCC.DTr _ a es) =  ---- TODO: bindings
  Macros.mkApp (atom2term abs a) (map (exp2term abs) es)

atom2term :: Ident.Ident -> AbsGFCC.Atom -> Grammar.Term
atom2term abs (AbsGFCC.AC (CId f)) = Macros.qq (abs,Ident.IC f)
atom2term abs (AbsGFCC.AS s) = Macros.string2term s
atom2term abs (AbsGFCC.AI n) = Macros.int2term    n
atom2term abs (AbsGFCC.AF f) = Macros.float2term  f
atom2term abs (AbsGFCC.AM i) = Macros.mkMeta (fromInteger i)

----------------------------------------------------------------------
-- conversion and unification of forests

-- simplest implementation
applyProfileToForest :: SyntaxForest Name -> [SyntaxForest Fun]
applyProfileToForest (FNode name@(Name fun profile) children) 
    | isCoercion name = concat chForests
    | otherwise       = [ FNode fun chForests | not (null chForests) ]
    where chForests   = concat [ applyProfileM unifyManyForests profile forests |
				 forests0 <- children,
				 forests <- mapM applyProfileToForest forests0 ]
applyProfileToForest (FString s) = [FString s]
applyProfileToForest (FInt    n) = [FInt    n]
applyProfileToForest (FFloat  f) = [FFloat  f]
applyProfileToForest (FMeta)     = [FMeta]

{-
-- more intelligent(?) implementation
applyProfileToForest (FNode (Name name profile) children) 
    | isCoercion name = concat chForests
    | otherwise       = [ FNode name chForests | not (null chForests) ]
    where chForests   = concat [ mapM (checkProfile forests) profile |
				 forests0 <- children,
				 forests <- mapM applyProfileToForest forests0 ]
-}


