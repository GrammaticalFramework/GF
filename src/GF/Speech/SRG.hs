----------------------------------------------------------------------
-- |
-- Module      : SRG
--
-- Representation of, conversion to, and utilities for 
-- printing of a general Speech Recognition Grammar. 
--
-- FIXME: remove \/ warn \/ fail if there are int \/ string literal
-- categories in the grammar
----------------------------------------------------------------------
module GF.Speech.SRG (SRG(..), SRGRule(..), SRGAlt(..), SRGItem, SRGSymbol
                     , SRGNT, CFTerm
                     , ebnfPrinter
                     , makeSimpleSRG
                     , makeNonRecursiveSRG
                     , getSpeechLanguage
                     , isExternalCat
                     , lookupFM_, prtS
                     ) where

import GF.Data.Operations
import GF.Data.Utilities
import GF.Infra.Ident
import GF.Infra.PrintClass
import GF.Speech.CFG
import GF.Speech.PGFToCFG
import GF.Speech.Relation
import GF.Speech.FiniteState
import GF.Speech.RegExp
import GF.Speech.CFGToFA
import GF.Infra.Option
import PGF.CId
import PGF.Data
import PGF.Macros

import Data.List
import Data.Maybe (fromMaybe, maybeToList)
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Set (Set)
import qualified Data.Set as Set

import Debug.Trace

data SRG = SRG { srgName :: String    -- ^ grammar name
		 , srgStartCat :: Cat     -- ^ start category name
                 , srgExternalCats :: Set Cat
                 , srgLanguage :: Maybe String -- ^ The language for which the grammar 
                                                   --   is intended, e.g. en-UK
	         , srgRules :: [SRGRule] 
	       }
	 deriving (Eq,Show)

data SRGRule = SRGRule Cat [SRGAlt]
	     deriving (Eq,Show)

-- | maybe a probability, a rule name and an EBNF right-hand side
data SRGAlt = SRGAlt (Maybe Double) CFTerm SRGItem
	      deriving (Eq,Show)

type SRGItem = RE SRGSymbol

type SRGSymbol = Symbol SRGNT Token

-- | An SRG non-terminal. Category name and its number in the profile.
type SRGNT = (Cat, Int)


ebnfPrinter :: PGF -> CId -> String
ebnfPrinter pgf cnc = prSRG $ makeSRG id pgf cnc

makeSRG :: (CFG -> CFG) -> PGF -> CId -> SRG
makeSRG = mkSRG cfgToSRG
    where
      cfgToSRG cfg = [cfRulesToSRGRule rs | (_,rs) <- allRulesGrouped cfg]

-- | Create a compact filtered non-left-recursive SRG. 
makeSimpleSRG :: PGF -> CId -> SRG
makeSimpleSRG  = makeSRG preprocess
    where
      preprocess =   traceStats "After mergeIdentical"
                   . mergeIdentical
                   . traceStats "After removeLeftRecursion"
                   . removeLeftRecursion 
                   . traceStats "After topDownFilter" 
                   . topDownFilter
                   . traceStats "After bottomUpFilter"
                   . bottomUpFilter
                   . traceStats "After removeCycles"
                   . removeCycles 
                   . traceStats "Inital CFG"

traceStats s g = trace ("---- " ++ s ++ ": " ++ stats g {- ++ "\n" ++ prCFRules g ++ "----" -}) g

stats g = "Categories: " ++ show (countCats g)
          ++ ", External categories: " ++ show (Set.size (cfgExternalCats g))
          ++ ", Rules: " ++ show (countRules g)

makeNonRecursiveSRG :: PGF
                    -> CId -- ^ Concrete syntax name.
                    -> SRG
makeNonRecursiveSRG = mkSRG cfgToSRG id
    where
      cfgToSRG cfg = [SRGRule l [SRGAlt Nothing dummyCFTerm (dfaToSRGItem dfa)] | (l,dfa) <- dfas]
          where
            MFA _ dfas = cfgToMFA cfg
            dfaToSRGItem = mapRE dummySRGNT . minimizeRE . dfa2re
            dummyCFTerm = CFMeta (mkCId "dummy")
            dummySRGNT = mapSymbol (\c -> (c,0)) id

mkSRG :: (CFG -> [SRGRule]) -> (CFG -> CFG) -> PGF -> CId -> SRG
mkSRG mkRules preprocess pgf cnc =
    SRG { srgName = prCId cnc,
	  srgStartCat = cfgStartCat cfg,
          srgExternalCats = cfgExternalCats cfg,
          srgLanguage = getSpeechLanguage pgf cnc,
	  srgRules = mkRules cfg }
    where cfg = renameCats (prCId cnc) $ preprocess $ pgfToCFG pgf cnc

-- | Renames all external cats C to C_cat, and all internal cats to
--   GrammarName_N where N is an integer.
renameCats :: String -> CFG -> CFG
renameCats prefix cfg = mapCFGCats renameCat cfg
  where renameCat c | isExternal c = c ++ "_cat"
                    | otherwise = fromMaybe ("renameCats: " ++ c) (Map.lookup c names)
        isExternal c = c `Set.member` cfgExternalCats cfg        
        names = Map.fromList $ zip (allCats cfg) [prefix ++ "_" ++ show x | x <- [0..]]

getSpeechLanguage :: PGF -> CId -> Maybe String
getSpeechLanguage pgf cnc = fmap (replace '_' '-') $ lookConcrFlag pgf cnc (mkCId "language")

cfRulesToSRGRule :: [CFRule] -> SRGRule
cfRulesToSRGRule rs@(r:_) = SRGRule (lhsCat r) rhs
    where 
      alts = [((n,Nothing),mkSRGSymbols 0 ss) | CFRule c ss n <- rs]
      rhs = [SRGAlt p n (srgItem sss) | ((n,p),sss) <- buildMultiMap alts ]

      mkSRGSymbols _ [] = []
      mkSRGSymbols i (NonTerminal c:ss) = NonTerminal (c,i) : mkSRGSymbols (i+1) ss
      mkSRGSymbols i (Terminal t:ss)    = Terminal t : mkSRGSymbols i ss

allSRGCats :: SRG -> [String]
allSRGCats SRG { srgRules = rs } = [c | SRGRule c _ <- rs]

isExternalCat :: SRG -> Cat -> Bool
isExternalCat srg c = c `Set.member` srgExternalCats srg

--
-- * Size-optimized EBNF SRGs
--

srgItem :: [[SRGSymbol]] -> SRGItem
srgItem = unionRE . map mergeItems . sortGroupBy (compareBy filterCats)
-- non-optimizing version:
--srgItem = unionRE . map seqRE

-- | Merges a list of right-hand sides which all have the same 
-- sequence of non-terminals.
mergeItems :: [[SRGSymbol]] -> SRGItem
mergeItems = minimizeRE . ungroupTokens . minimizeRE . unionRE . map seqRE . map groupTokens

groupTokens :: [SRGSymbol] -> [Symbol SRGNT [Token]]
groupTokens [] = []
groupTokens (Terminal t:ss) = case groupTokens ss of
                                Terminal ts:ss' -> Terminal (t:ts):ss'
                                ss'             -> Terminal [t]:ss'
groupTokens (NonTerminal c:ss) = NonTerminal c : groupTokens ss

ungroupTokens :: RE (Symbol SRGNT [Token]) -> RE SRGSymbol
ungroupTokens = joinRE . mapRE (symbol (RESymbol . NonTerminal) (REConcat . map (RESymbol . Terminal)))

--
-- * Utilities for building and printing SRGs
--

prSRG :: SRG -> String
prSRG = unlines . map prRule . srgRules
    where 
      prRule (SRGRule c alts) = c ++ " ::= " ++ unwords (intersperse "|" (map prAlt alts))
      prAlt (SRGAlt _ _ rhs) = prRE prSym rhs
      prSym = symbol fst (\t -> "\""++ t ++"\"")

lookupFM_ :: (Ord key, Show key) => Map key elt -> key -> elt
lookupFM_ fm k = Map.findWithDefault err k fm
  where err = error $ "Key not found: " ++ show k
                      ++ "\namong " ++ show (Map.keys fm)

prtS :: Print a => a -> ShowS
prtS = showString . prt
