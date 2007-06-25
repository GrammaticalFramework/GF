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
import GF.Infra.Option
import GF.Probabilistic.Probabilistic (Probs)
import GF.Compile.ShellState (StateGrammar, stateProbs, stateOptions, cncId)

import Data.List
import Data.Maybe (fromMaybe, maybeToList)
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Set (Set)
import qualified Data.Set as Set

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
      preprocess origStart = mergeIdentical
                             . removeLeftRecursion origStart 
                             . fix (topDownFilter origStart . bottomUpFilter)
                             . removeCycles

makeNonRecursiveSRG :: Options 
                    -> StateGrammar
                    -> SRG
makeNonRecursiveSRG opt s = removeRecursion $ makeSRG preprocess opt s
    where
      preprocess origStart = mergeIdentical
                             . makeRegular 
                             . fix (topDownFilter origStart . bottomUpFilter)
                             . removeCycles

makeSRG :: (Cat_ -> CFRules -> CFRules)
        -> Options   -- ^ Grammar options
	-> StateGrammar
	-> SRG
makeSRG preprocess opt s =
      SRG { grammarName = name,
	    startCat = lookupFM_ names origStart,
	    origStartCat = origStart,
            grammarLanguage = l,
	    rules = rs }
    where 
    opts = addOptions opt (stateOptions s)
    name = prIdent (cncId s)
    origStart = getStartCatCF opts s
    probs = stateProbs s
    l = fmap (replace '_' '-') $ getOptVal opts speechLanguage
    (cats,cfgRules) = unzip $ preprocess origStart $ cfgToCFRules s
    names = mkCatNames name cats
    rs = map (cfgRulesToSRGRule names probs) cfgRules

-- FIXME: merge alternatives with same rhs and profile but different probabilities
cfgRulesToSRGRule :: Map String String -> Probs -> [CFRule_] -> SRGRule
cfgRulesToSRGRule names probs rs@(r:_) = SRGRule cat origCat rhs
    where 
      origCat = lhsCat r
      cat = lookupFM_ names origCat
      alts = [((n,ruleProb probs r),mkSRGSymbols 0 ss) | CFRule c ss n <- rs]
      rhs = [SRGAlt p n (srgItem sss) | ((n,p),sss) <- buildMultiMap alts ]

      mkSRGSymbols _ [] = []
      mkSRGSymbols i (Cat c:ss) = Cat (renameCat c,i) : mkSRGSymbols (i+1) ss
      mkSRGSymbols i (Tok t:ss) = Tok t : mkSRGSymbols i ss

      renameCat = lookupFM_ names

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
-- * Full recursion removal
--

{-
S -> foo
S -> apa
S -> bar S
S -> baz S
=>
S -> (bar|baz)* (foo|apa)
-}

-- | Removes recursion from a right-linear SRG by converting to EBNF.
-- FIXME: corrupts semantics and probabilities
removeRecursion :: SRG -> SRG
removeRecursion srg = srg'
    where
      srg' = srg { rules = [SRGRule lhs orig [SRGAlt Nothing dummyCFTerm (f lhs alts)] 
                               | SRGRule lhs orig alts <- rules srg] }
      dummyCFTerm = CFMeta "dummy"
      getRHS cat = unionRE [ rhs | SRGRule lhs _ alts <- rules srg', lhs == cat,
                                   SRGAlt _ _ rhs <- alts]
      mutRec = srgMutRec srg
      -- Replaces all cats in same mutually recursive set as LHS 
      -- (except the LHS category itself) with
      -- their respective right-hand sides.
      -- This makes all rules either non-recursive, or directly right-recursive.
      -- NOTE: this fails (loops) if the input grammar is not right-linear.
      -- Then replaces all direct right-recursion by Kleene stars.
      f lhs alts = recToKleene $ mapRE' g $ unionRE [rhs | SRGAlt _ _ rhs <- alts]
          where
            g (Cat (c,_)) | isRelatedTo mutRec lhs c && c /= lhs = getRHS c
            g t = RESymbol t
            recToKleene rhs = concatRE [repeatRE (unionRE r), unionRE nr]
                where (r,nr) = partition isRecursive (normalSplitRE rhs)
            isRecursive re = lhs `elem` srgItemUses re

-- | Converts any regexp which does not contain Kleene stars to a
-- disjunctive normal form.
{-
(a|b) (c|d) => [a c, a d, b c, b d]
(a|b) | (c d) => [a, b, c d]
(a b) | (c d) => [a b, c d]
-}
normalSplitRE :: SRGItem -> [SRGItem]
normalSplitRE (REUnion xs)  = concatMap normalSplitRE xs
normalSplitRE (REConcat xs) = map concatRE $ sequence $ map normalSplitRE xs
normalSplitRE x = [x]

srgMutRec :: SRG -> Rel SRGCat
srgMutRec = reflexiveSubrelation . symmetricSubrelation . transitiveClosure . srgUses

srgUses :: SRG -> Rel SRGCat
srgUses srg = mkRel [(lhs,c) | SRGRule lhs _ alts <- rules srg,
                               SRGAlt _ _ rhs <- alts,
                               c <- srgItemUses rhs]

srgItemUses :: SRGItem -> [SRGCat]
srgItemUses rhs = [c | Cat (c,_) <- symbolsRE rhs]

--
-- * Utilities for building and printing SRGs
--

lookupFM_ :: (Ord key, Show key) => Map key elt -> key -> elt
lookupFM_ fm k = Map.findWithDefault err k fm
  where err = error $ "Key not found: " ++ show k
                      ++ "\namong " ++ show (Map.keys fm)

prtS :: Print a => a -> ShowS
prtS = showString . prt