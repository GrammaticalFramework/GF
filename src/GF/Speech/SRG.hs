----------------------------------------------------------------------
-- |
-- Module      : SRG
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/01 20:09:04 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.20 $
--
-- Representation of, conversion to, and utilities for 
-- printing of a general Speech Recognition Grammar. 
--
-- FIXME: remove \/ warn \/ fail if there are int \/ string literal
-- categories in the grammar
-----------------------------------------------------------------------------

module GF.Speech.SRG (SRG(..), SRGRule(..), SRGAlt(..), SRGItem,
                      SRGCat, SRGNT, CFTerm
                     , makeSRG
                     , makeSimpleSRG
                     , makeNonRecursiveSRG
                     , lookupFM_, prtS
                     , cfgCatToGFCat, srgTopCats
                     ) where

import GF.Data.Operations
import GF.Data.Utilities
import GF.Infra.Ident
import GF.Formalism.CFG
import GF.Formalism.Utilities (Symbol(..), NameProfile(..)
                              , Profile(..), SyntaxForest
                              , filterCats, mapSymbol, symbol)
import GF.Conversion.Types
import GF.Infra.Print
import GF.Speech.TransformCFG
import GF.Speech.Relation
import GF.Speech.FiniteState
import GF.Speech.RegExp
import GF.Speech.CFGToFiniteState
import GF.Infra.Option
import GF.Probabilistic.Probabilistic (Probs)
import GF.Compile.ShellState (StateGrammar, stateProbs, stateOptions, cncId)

import Data.List
import Data.Maybe (fromMaybe, maybeToList)
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Set (Set)
import qualified Data.Set as Set

import Debug.Trace

data SRG = SRG { grammarName :: String    -- ^ grammar name
		 , startCat :: SRGCat     -- ^ start category name
		 , origStartCat :: String -- ^ original start category name
                 , grammarLanguage :: Maybe String -- ^ The language for which the grammar 
                                                   --   is intended, e.g. en-UK
	         , rules :: [SRGRule] 
	       }
	 deriving (Eq,Show)

data SRGRule = SRGRule SRGCat String [SRGAlt] -- ^ SRG category name, original category name
	                                      --   and productions
	     deriving (Eq,Show)

-- | maybe a probability, a rule name and an EBNF right-hand side
data SRGAlt = SRGAlt (Maybe Double) CFTerm SRGItem
	      deriving (Eq,Show)

type SRGItem = RE (Symbol SRGNT Token)

type SRGCat = String

-- | An SRG non-terminal. Category name and its number in the profile.
type SRGNT = (SRGCat, Int)

-- | SRG category name and original name
type CatName = (SRGCat,String) 

type CatNames = Map String String

-- | Create a non-left-recursive SRG. 
--   FIXME: the probabilities in the returned 
--   grammar may be meaningless.
makeSimpleSRG :: Options   -- ^ Grammar options
	      -> StateGrammar
	      -> SRG
makeSimpleSRG opt s = makeSRG preprocess opt s
    where
      preprocess origStart = traceStats "After mergeIdentical"
                             . mergeIdentical
                             . traceStats "After removeLeftRecursion"
                             . removeLeftRecursion origStart 
                             . traceStats "After topDownFilter" 
                             . topDownFilter origStart
                             . traceStats "After bottomUpFilter"
                             . bottomUpFilter
                             . traceStats "After removeCycles"
                             . removeCycles 
                             . traceStats "Inital CFG"

traceStats s g = trace ("---- " ++ s ++ ": " ++ stats g {- ++ "\n" ++ prCFRules g ++ "----" -}) g

stats g = "Categories: " ++ show (countCats g)
          ++ " Rules: " ++ show (countRules g)

makeNonRecursiveSRG :: Options 
                    -> StateGrammar
                    -> SRG
makeNonRecursiveSRG opt s = renameSRG $ 
      SRG { grammarName = prIdent (cncId s),
	    startCat = start,
	    origStartCat = origStart,
            grammarLanguage = getSpeechLanguage opt s,
	    rules = rs }
  where
    origStart = getStartCatCF opt s
    MFA start dfas = cfgToMFA opt s
    rs = [SRGRule l l [SRGAlt Nothing dummyCFTerm (dfaToSRGItem dfa)] | (l,dfa) <- dfas]
      where dfaToSRGItem = mapRE dummySRGNT . minimizeRE . dfa2re
            dummyCFTerm = CFMeta "dummy"
            dummySRGNT = mapSymbol (\c -> (c,0)) id

makeSRG :: (Cat_ -> CFRules -> CFRules)
        -> Options   -- ^ Grammar options
	-> StateGrammar
	-> SRG
makeSRG preprocess opt s = renameSRG $ 
      SRG { grammarName = name,
	    startCat = origStart,
	    origStartCat = origStart,
            grammarLanguage = getSpeechLanguage opt s,
	    rules = rs }
    where 
    name = prIdent (cncId s)
    origStart = getStartCatCF opt s
    (_,cfgRules) = unzip $ allRulesGrouped $ preprocess origStart $ cfgToCFRules s
    rs = map (cfgRulesToSRGRule (stateProbs s)) cfgRules

-- | Give names on the form NameX to all categories.
renameSRG :: SRG -> SRG
renameSRG srg = srg { startCat = renameCat (startCat srg),
                      rules = map renameRule (rules srg) }
  where
    names = mkCatNames (grammarName srg) (allSRGCats srg)
    renameRule (SRGRule _ origCat alts) = SRGRule (renameCat origCat) origCat (map renameAlt alts)
    renameAlt (SRGAlt mp n rhs) = SRGAlt mp n (mapRE renameSymbol rhs) 
    renameSymbol = mapSymbol (\ (c,x) -> (renameCat c, x)) id
    renameCat = lookupFM_ names

getSpeechLanguage :: Options -> StateGrammar -> Maybe String
getSpeechLanguage opt s = 
    fmap (replace '_' '-') $ getOptVal (addOptions opt (stateOptions s)) speechLanguage

-- FIXME: merge alternatives with same rhs and profile but different probabilities
cfgRulesToSRGRule :: Probs -> [CFRule_] -> SRGRule
cfgRulesToSRGRule probs rs@(r:_) = SRGRule origCat origCat rhs
    where 
      origCat = lhsCat r
      alts = [((n,ruleProb probs r),mkSRGSymbols 0 ss) | CFRule c ss n <- rs]
      rhs = [SRGAlt p n (srgItem sss) | ((n,p),sss) <- buildMultiMap alts ]

      mkSRGSymbols _ [] = []
      mkSRGSymbols i (Cat c:ss) = Cat (c,i) : mkSRGSymbols (i+1) ss
      mkSRGSymbols i (Tok t:ss) = Tok t : mkSRGSymbols i ss

ruleProb :: Probs -> CFRule_ -> Maybe Double
ruleProb probs r = lookupProb probs (ruleFun r)

-- FIXME: move to GF.Probabilistic.Probabilistic?
lookupProb :: Probs -> Ident -> Maybe Double
lookupProb probs i = lookupTree prIdent i probs

mkCatNames :: String   -- ^ Category name prefix
	   -> [String] -- ^ Original category names
	   -> Map String String -- ^ Maps original names to SRG names
mkCatNames prefix origNames = Map.fromList (zip origNames names)
    where names = [prefix ++ "_" ++ show x | x <- [0..]]


allSRGCats :: SRG -> [String]
allSRGCats SRG { rules = rs } = [c | SRGRule c _ _ <- rs]

cfgCatToGFCat :: SRGCat -> Maybe String
cfgCatToGFCat c 
    -- categories introduced by removeLeftRecursion contain dashes
    | '-' `elem` c = Nothing 
    -- some categories introduced by -conversion=finite have the form
    -- "{fun:cat}..."
    | "{" `isPrefixOf` c = case dropWhile (/=':') $ takeWhile (/='}') $ tail c of
                             ':':c' -> Just c'
                             _ -> error $ "cfgCatToGFCat: Strange category " ++ show c
    | otherwise = Just $ takeWhile (/='{') c

srgTopCats :: SRG -> [(String,[SRGCat])]
srgTopCats srg = buildMultiMap [(oc, cat) | SRGRule cat origCat _ <- rules srg, 
                                            oc <- maybeToList $ cfgCatToGFCat origCat]

--
-- * Size-optimized EBNF SRGs
--

srgItem :: [[Symbol SRGNT Token]] -> SRGItem
srgItem = unionRE . map mergeItems . sortGroupBy (compareBy filterCats)
-- non-optimizing version:
--srgItem = unionRE . map seqRE

-- | Merges a list of right-hand sides which all have the same 
-- sequence of non-terminals.
mergeItems :: [[Symbol SRGNT Token]] -> SRGItem
mergeItems = minimizeRE . ungroupTokens . minimizeRE . unionRE . map seqRE . map groupTokens

groupTokens :: [Symbol SRGNT Token] -> [Symbol SRGNT [Token]]
groupTokens [] = []
groupTokens (Tok t:ss) = case groupTokens ss of
                           Tok ts:ss' -> Tok (t:ts):ss'
                           ss'        -> Tok [t]:ss'
groupTokens (Cat c:ss) = Cat c : groupTokens ss

ungroupTokens :: RE (Symbol SRGNT [Token]) -> RE (Symbol SRGNT Token)
ungroupTokens = joinRE . mapRE (symbol (RESymbol . Cat) (REConcat . map (RESymbol . Tok)))

--
-- * Utilities for building and printing SRGs
--

lookupFM_ :: (Ord key, Show key) => Map key elt -> key -> elt
lookupFM_ fm k = Map.findWithDefault err k fm
  where err = error $ "Key not found: " ++ show k
                      ++ "\namong " ++ show (Map.keys fm)

prtS :: Print a => a -> ShowS
prtS = showString . prt