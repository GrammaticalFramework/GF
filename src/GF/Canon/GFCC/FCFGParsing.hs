module GF.Canon.GFCC.FCFGParsing (parserLang,PF.buildFCFPInfo,PF.FCFPInfo) where

import GF.Canon.GFCC.DataGFCC
import GF.Canon.GFCC.AbsGFCC
import GF.Conversion.SimpleToFCFG (convertGrammar,FCat(..))

import GF.Data.SortedList 
import GF.Data.Assoc
import GF.Formalism.Utilities --(forest2trees)
import qualified GF.Data.Operations as Op

import GF.Formalism.FCFG
import qualified GF.Parsing.FCFG as PF
import GF.Canon.GFCC.ErrM
import GF.Infra.PrintClass

parserLang :: GFCC -> CId -> CFCat -> [CFTok] -> Err [Exp]
parserLang mgr lang = parse info where
  fcfgs = convertGrammar mgr
  info  = PF.buildFCFPInfo $ maybe (error "no parser") id $ lookup lang fcfgs

type CFTok = String ----
type CFCat = CId ----
type Fun = CId ----

cfCat2Ident = id ----

wordsCFTok :: CFTok -> [String]
wordsCFTok = return ----


-- main parsing function

parse :: 
--         String ->      -- ^ parsing algorithm (mcfg or cfg)
--         String ->      -- ^ parsing strategy
      PF.FCFPInfo ->       -- ^ compiled grammar (fcfg) 
--      Ident.Ident ->    -- ^ abstract module name
      CFCat ->          -- ^ starting category
      [CFTok] ->        -- ^ input tokens
      Err [Exp]         -- ^ resulting GF terms

parse pinfo startCat inString = e2e $

    do let inTokens = inputMany (map wordsCFTok inString)
       forests <- selectParser pinfo startCat inTokens
       let filteredForests = forests >>= applyProfileToForest
	   trees = nubsort $ filteredForests >>= forest2trees

       return $ map tree2term trees


-- parsing via FCFG
selectParser pinfo startCat inTokens
    = do let startCats = filter isStart $ PF.grammarCats fcfpi
	     isStart cat = cat' == cfCat2Ident startCat
	       where CId x = fcat2cid cat
	             cat'  = CId x
	     fcfpi = pinfo
	 fcfParser <- PF.parseFCF "bottomup"
	 let chart = fcfParser fcfpi startCats inTokens
	     (i,j) = inputBounds inTokens
	     finalEdges = [PF.makeFinalEdge cat i j | cat <- startCats]
	 return $ map cnv_forests $ chart2forests chart (const False) finalEdges

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

tree2term :: SyntaxTree Fun -> Exp
tree2term (TNode f ts) = Tr (AC f) (map tree2term ts)

tree2term (TString  s) = Tr (AS s) []
tree2term (TInt     n) = Tr (AI n) []
tree2term (TFloat   f) = Tr (AF f) []
tree2term (TMeta)      = Tr AM []

----------------------------------------------------------------------
-- conversion and unification of forests

-- simplest implementation
applyProfileToForest :: SyntaxForest FName -> [SyntaxForest Fun]
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

---

e2e :: Op.Err a -> Err a
e2e e = case e of
  Op.Ok v -> Ok v
  Op.Bad s -> Bad s

