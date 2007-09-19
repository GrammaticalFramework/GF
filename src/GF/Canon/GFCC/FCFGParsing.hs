module GF.Canon.GFCC.FCFGParsing where

import GF.Canon.GFCC.DataGFCC
import GF.Canon.GFCC.AbsGFCC
import GF.Conversion.SimpleToFCFG (convertGrammar)

--import GF.System.Tracing 
--import GF.Infra.Print
--import qualified GF.Grammar.PrGrammar as PrGrammar

--import GF.Data.Operations (Err(..))

--import qualified GF.Grammar.Grammar as Grammar
--import qualified GF.Grammar.Macros as Macros
--import qualified GF.Canon.AbsGFC as AbsGFC
--import qualified GF.Canon.GFCC.AbsGFCC as AbsGFCC
--import qualified GF.Infra.Ident as Ident
--import GF.CF.CFIdent (CFCat, cfCat2Ident, CFTok, wordsCFTok)

import GF.Data.SortedList 
import GF.Data.Assoc
import GF.Formalism.Utilities --(forest2trees)

--import GF.Conversion.Types

import GF.Formalism.FCFG
--import qualified GF.Formalism.GCFG as G
--import qualified GF.Formalism.SimpleGFC as S
--import qualified GF.Formalism.MCFG as M
--import qualified GF.Formalism.CFG as C
--import qualified GF.Parsing.MCFG as PM
import qualified GF.Parsing.FCFG as PF
--import qualified GF.Parsing.CFG as PC
import GF.Canon.GFCC.ErrM


--convertGrammar :: Grammar -> [(Ident,FGrammar)]

--import qualified GF.Parsing.GFC as New
--checkErr $ New.parse algorithm strategy (pInfo sg) (absId sg) cat toks
-- algorithm "f"
-- strategy "bottomup"

type Token = String ----
type CFTok = String ----
type CFCat = CId ----
type Fun = CId ----

cfCat2Ident = id ----

wordsCFTok :: CFTok -> [String]
wordsCFTok = return ----


type FCFPInfo = PF.FCFPInfo FCat FName Token

-- main parsing function

parse :: 
--         String ->      -- ^ parsing algorithm (mcfg or cfg)
--         String ->      -- ^ parsing strategy
      FCFPInfo ->       -- ^ compiled grammar (fcfg) 
--      Ident.Ident ->    -- ^ abstract module name
      CFCat ->          -- ^ starting category
      [CFTok] ->        -- ^ input tokens
      Err [Exp]         -- ^ resulting GF terms

parse pinfo startCat inString = 

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
tree2term (TNode f ts) = Tr (AC (CId f)) (map tree2term ts)
{- ----
tree2term (TString  s) = Macros.string2term s
tree2term (TInt     n) = Macros.int2term    n
tree2term (TFloat   f) = Macros.float2term  f
tree2term (TMeta)      = Macros.mkMeta 0
-}


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


--------------------- From parsing types ------------------------------

-- * fast nonerasing MCFG

type FIndex   = Int
type FPath    = [FIndex]
type FName    = NameProfile CId
type FGrammar = FCFGrammar FCat FName Token
type FRule    = FCFRule    FCat FName Token
data FCat     = FCat  {-# UNPACK #-} !Int CId [FPath] [(FPath,FIndex)]

initialFCat :: CId -> FCat
initialFCat cat = FCat 0 cat [] []

fcatString = FCat (-1) (CId "String") [[0]] []
fcatInt    = FCat (-2) (CId "Int")    [[0]] []
fcatFloat  = FCat (-3) (CId "Float")  [[0]] []

fcat2cid :: FCat -> CId
fcat2cid (FCat _ c _ _) = c

instance Eq FCat where
  (FCat id1 _ _ _) == (FCat id2 _ _ _) = id1 == id2

instance Ord FCat where
  compare (FCat id1 _ _ _) (FCat id2 _ _ _) = compare id1 id2



---

isCoercion :: Name -> Bool
isCoercion (Name fun [Unify [0]]) = False -- isWildIdent fun
isCoercion _ = False

type Name = NameProfile Fun
