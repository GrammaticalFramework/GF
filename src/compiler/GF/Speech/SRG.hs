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
                     , makeNonLeftRecursiveSRG
                     , makeNonRecursiveSRG
                     , isExternalCat
                     , lookupFM_
                     ) where

import GF.Data.Operations
import GF.Data.Utilities
import GF.Infra.Ident
import GF.Infra.Option
import GF.Speech.CFG
import GF.Speech.PGFToCFG
import GF.Data.Relation
import GF.Speech.FiniteState
import GF.Speech.RegExp
import GF.Speech.CFGToFA
import GF.Infra.Option
import PGF

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

ebnfPrinter :: Options -> PGF -> CId -> String
ebnfPrinter opts pgf cnc = prSRG opts $ makeSRG opts pgf cnc

-- | Create a compact filtered non-left-recursive SRG. 
makeNonLeftRecursiveSRG :: Options -> PGF -> CId -> SRG
makeNonLeftRecursiveSRG opts = makeSRG opts'
    where
      opts' = setDefaultCFGTransform opts CFGNoLR True

makeSRG :: Options -> PGF -> CId -> SRG
makeSRG opts = mkSRG cfgToSRG preprocess
    where
      cfgToSRG cfg = [cfRulesToSRGRule rs | (_,rs) <- allRulesGrouped cfg]
      preprocess =   maybeTransform opts CFGMergeIdentical mergeIdentical
                   . maybeTransform opts CFGNoLR removeLeftRecursion 
                   . maybeTransform opts CFGRegular makeRegular
                   . maybeTransform opts CFGTopDownFilter topDownFilter
                   . maybeTransform opts CFGBottomUpFilter bottomUpFilter
                   . maybeTransform opts CFGRemoveCycles removeCycles 
                   . maybeTransform opts CFGStartCatOnly purgeExternalCats

setDefaultCFGTransform :: Options -> CFGTransform -> Bool -> Options
setDefaultCFGTransform opts t b = setCFGTransform t b `addOptions` opts

maybeTransform :: Options -> CFGTransform -> (CFG -> CFG) -> (CFG -> CFG)
maybeTransform opts t f = if cfgTransform opts t then f else id

traceStats s g = trace ("---- " ++ s ++ ": " ++ stats g {- ++ "\n" ++ prCFRules g ++ "----" -}) g

stats g = "Categories: " ++ show (countCats g)
          ++ ", External categories: " ++ show (Set.size (cfgExternalCats g))
          ++ ", Rules: " ++ show (countRules g)

makeNonRecursiveSRG :: Options 
                    -> PGF
                    -> CId -- ^ Concrete syntax name.
                    -> SRG
makeNonRecursiveSRG opts = mkSRG cfgToSRG id
    where
      cfgToSRG cfg = [SRGRule l [SRGAlt Nothing dummyCFTerm (dfaToSRGItem dfa)] | (l,dfa) <- dfas]
          where
            MFA _ dfas = cfgToMFA cfg
            dfaToSRGItem = mapRE dummySRGNT . minimizeRE . dfa2re
            dummyCFTerm = CFMeta (mkCId "dummy")
            dummySRGNT = mapSymbol (\c -> (c,0)) id

mkSRG :: (CFG -> [SRGRule]) -> (CFG -> CFG) -> PGF -> CId -> SRG
mkSRG mkRules preprocess pgf cnc =
    SRG { srgName = showCId cnc,
	  srgStartCat = cfgStartCat cfg,
          srgExternalCats = cfgExternalCats cfg,
          srgLanguage = languageCode pgf cnc,
	  srgRules = mkRules cfg }
    where cfg = renameCats (showCId cnc) $ preprocess $ pgfToCFG pgf cnc

-- | Renames all external cats C to C_cat, and all internal cats C_X (where X is any string), 
--   to C_N where N is an integer.
renameCats :: String -> CFG -> CFG
renameCats prefix cfg = mapCFGCats renameCat cfg
  where renameCat c | isExternal c = c ++ "_cat"
                    | otherwise = Map.findWithDefault (badCat c) c names
        isExternal c = c `Set.member` cfgExternalCats cfg        
        catsByPrefix = buildMultiMap [(takeWhile (/='_') cat, cat) | cat <- allCats' cfg, not (isExternal cat)]
        names = Map.fromList [(c,pref++"_"++show i) | (pref,cs) <- catsByPrefix, (c,i) <- zip cs [1..]]
        badCat c = error ("GF.Speech.SRG.renameCats: " ++ c ++ "\n" ++ prCFG cfg)

cfRulesToSRGRule :: [CFRule] -> SRGRule
cfRulesToSRGRule rs@(r:_) = SRGRule (lhsCat r) rhs
    where 
      alts = [((n,Nothing),mkSRGSymbols 0 ss) | CFRule c ss n <- rs]
      rhs = [SRGAlt p n (srgItem sss) | ((n,p),sss) <- buildMultiMap alts ]

      mkSRGSymbols _ [] = []
      mkSRGSymbols i (NonTerminal c:ss) = NonTerminal (c,i) : mkSRGSymbols (i+1) ss
      mkSRGSymbols i (Terminal t:ss)    = Terminal t : mkSRGSymbols i ss

srgLHSCat :: SRGRule -> Cat
srgLHSCat (SRGRule c _) = c

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

prSRG :: Options -> SRG -> String
prSRG opts srg = prProductions $ map prRule $ ext ++ int
    where 
      sisr = flag optSISR opts
      (ext,int) = partition (isExternalCat srg . srgLHSCat) (srgRules srg)
      prRule (SRGRule c alts) = (c,unwords (intersperse "|" (concatMap prAlt alts)))
      prAlt (SRGAlt _ t rhs) = 
          -- FIXME: hack: we high-jack the --sisr flag to add 
          -- a simple lambda calculus format for semantic interpretation
          -- Maybe the --sisr flag should be renamed.
          case sisr of
            Just _  -> 
                -- copy tags to each part of a top-level union,
                -- to get simpler output
                case rhs of
                  REUnion xs -> map prOneAlt xs
                  _          -> [prOneAlt rhs]
                where prOneAlt a = prRE prSym a ++ " { " ++ prCFTerm t ++ " }"
            Nothing -> [prRE prSym rhs]
      prSym = symbol fst (\t -> "\""++ t ++"\"")

lookupFM_ :: (Ord key, Show key) => Map key elt -> key -> elt
lookupFM_ fm k = Map.findWithDefault err k fm
  where err = error $ "Key not found: " ++ show k
                      ++ "\namong " ++ show (Map.keys fm)
