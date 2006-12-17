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
--
-- FIXME: figure out name prefix from grammar name
-----------------------------------------------------------------------------

module GF.Speech.SRG (SRG(..), SRGRule(..), SRGAlt(..),
                      SRGCat, SRGNT,
                      makeSimpleSRG, makeSRG
                     , lookupFM_, prtS
                     , topDownFilter, cfgCatToGFCat
                     , EBnfSRGAlt(..), EBnfSRGItem
                     , ebnfSRGAlts
                     ) where

import GF.Data.Operations
import GF.Data.Utilities
import GF.Infra.Ident
import GF.Formalism.CFG
import GF.Formalism.Utilities (Symbol(..), NameProfile(..)
                              , Profile(..), SyntaxForest
                              , filterCats, mapSymbol)
import GF.Conversion.Types
import GF.Infra.Print
import GF.Speech.TransformCFG
import GF.Speech.Relation
import GF.Speech.FiniteState
import GF.Speech.RegExp
import GF.Infra.Option
import GF.Probabilistic.Probabilistic (Probs)

import Data.List
import Data.Maybe (fromMaybe)
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Set (Set)
import qualified Data.Set as Set

data SRG = SRG { grammarName :: String    -- ^ grammar name
		 , startCat :: String     -- ^ start category name
		 , origStartCat :: String -- ^ original start category name
                 , grammarLanguage :: String -- ^ The language for which the grammar 
                                             --   is intended, e.g. en_UK
	         , rules :: [SRGRule] 
	       }
	 deriving (Eq,Show)

data SRGRule = SRGRule SRGCat String [SRGAlt] -- ^ SRG category name, original category name
	                                      --   and productions
	     deriving (Eq,Show)

-- | maybe a probability, a rule name and a list of symbols
data SRGAlt = SRGAlt (Maybe Double) Name [Symbol SRGNT Token]
	      deriving (Eq,Show)

type SRGCat = String

-- | An SRG non-terminal. Category name and slots which it fills in.
type SRGNT = (SRGCat, [Int])

-- | SRG category name and original name
type CatName = (SRGCat,String) 

type CatNames = Map String String

-- | Create a non-left-recursive SRG. 
--   FIXME: the probabilities, names and profiles in the returned 
--   grammar may be meaningless.
makeSimpleSRG :: Ident     -- ^ Grammar name
              -> String    -- ^ Start category
	      -> Options   -- ^ Grammar options
	      -> Maybe Probs -- ^ Probabilities
	      -> CGrammar -- ^ A context-free grammar
	      -> SRG
makeSimpleSRG 
    = makeSRG_ (removeLeftRecursion . removeIdenticalRules . removeEmptyCats . removeCycles)

-- | Create a SRG preserving the names, profiles and probabilities of the 
--   input grammar. The returned grammar may be left-recursive.
makeSRG :: Ident     -- ^ Grammar name
        -> String    -- ^ Start category
	-> Options   -- ^ Grammar options
	-> Maybe Probs -- ^ Probabilities
	-> CGrammar -- ^ A context-free grammar
	-> SRG
makeSRG = makeSRG_ removeEmptyCats

makeSRG_ :: (CFRules -> CFRules) -- ^ Transformations to apply to the
                                 --   CFG before converting to SRG
         -> Ident     -- ^ Grammar name
         -> String    -- ^ Start category
	 -> Options   -- ^ Grammar options
	 -> Maybe Probs -- ^ Probabilities
	 -> CGrammar -- ^ A context-free grammar
	 -> SRG
makeSRG_ f i origStart opts probs gr 
    = SRG { grammarName = name,
	    startCat = lookupFM_ names origStart,
	    origStartCat = origStart,
            grammarLanguage = l,
	    rules = rs }
    where 
    name = prIdent i
    l = fromMaybe "en_UK" (getOptVal opts speechLanguage)
    gr' = f (cfgToCFRules gr)
    (cats,cfgRules) = unzip gr'
    names = mkCatNames name cats
    rs = map (cfgRulesToSRGRule names probs) cfgRules

-- FIXME: merge alternatives with same rhs and profile but different probabilities
cfgRulesToSRGRule :: Map String String -> Maybe Probs -> [CFRule_] -> SRGRule
cfgRulesToSRGRule names probs rs@(r:_) = SRGRule cat origCat rhs
    where 
      origCat = lhsCat r
      cat = lookupFM_ names origCat
      rhs = nub $ map ruleToAlt rs
      ruleToAlt r@(CFRule c ss n@(Name _ prs)) 
          = SRGAlt (ruleProb probs r) n (mkSRGSymbols 0 ss)
            where
              mkSRGSymbols _ [] = []
              mkSRGSymbols i (Cat c:ss) = Cat (c',slots) : mkSRGSymbols (i+1) ss
                  where c' = lookupFM_ names c
                        slots = [x | x <- [0..length prs-1], inProfile i (prs!!x)]
              mkSRGSymbols i (Tok t:ss) = Tok t : mkSRGSymbols i ss
      inProfile :: Int -> Profile a -> Bool
      inProfile x (Unify xs) = x `elem` xs
      inProfile _ (Constant _) = False

ruleProb :: Maybe Probs -> CFRule_ -> Maybe Double
ruleProb mp r = mp >>= \probs -> lookupProb probs (ruleFun r)

-- FIXME: move to GF.Probabilistic.Probabilistic?
lookupProb :: Probs -> Ident -> Maybe Double
lookupProb probs i = lookupTree prIdent i probs

mkCatNames :: String   -- ^ Category name prefix
	   -> [String] -- ^ Original category names
	   -> Map String String -- ^ Maps original names to SRG names
mkCatNames prefix origNames = Map.fromList (zip origNames names)
    where names = [prefix ++ "_" ++ show x | x <- [0..]]


-- | Remove categories which are not reachable from the start category.
topDownFilter :: SRG -> SRG
topDownFilter srg@(SRG { startCat = start, rules = rs }) = srg { rules = rs' }
  where 
  rs' = [ r | r@(SRGRule c _ _) <- rs, c `Set.member` keep]
  rhsCats = [ (c,c') | r@(SRGRule c _ ps) <- rs, 
                       SRGAlt _ _ ss <- ps, 
                       (c',_) <- filterCats ss]
  uses = reflexiveClosure_ (allSRGCats srg) $ transitiveClosure $ mkRel rhsCats
  keep = allRelated uses start

allSRGCats :: SRG -> [String]
allSRGCats SRG { rules = rs } = [c | SRGRule c _ _ <- rs]

cfgCatToGFCat :: SRGCat -> String
cfgCatToGFCat = takeWhile (/='{')

--
-- * Size-optimized EBNF SRGs
--

data EBnfSRGAlt = EBnfSRGAlt (Maybe Double) Name EBnfSRGItem
	     deriving (Eq,Show)

type EBnfSRGItem = RE (Symbol SRGNT Token)


ebnfSRGAlts :: [SRGAlt] -> [EBnfSRGAlt]
ebnfSRGAlts alts = [EBnfSRGAlt p n (ebnfSRGItem sss) 
                    | ((p,n),sss) <- buildMultiMap [((p,n),ss) | SRGAlt p n ss <- alts]]

ebnfSRGItem :: [[Symbol SRGNT Token]] -> EBnfSRGItem
ebnfSRGItem = dfa2re . mkSRGFA

mkSRGFA :: [[Symbol SRGNT Token]] -> DFA (Symbol SRGNT Token)
mkSRGFA = minimize . dfa2nfa . foldr addString (newFA ())

addString :: [a] -> DFA a -> DFA a
addString xs fa = addFinalState (last sts0) $ newTransitions ts fa'
  where (fa',ss) = newStates (replicate (length xs) ()) fa
        sts0 = startState fa : sts1
        sts1 = map fst ss
        ts = zip3 sts0 sts1 xs

--
-- * Utilities for building and printing SRGs
--

lookupFM_ :: (Ord key, Show key) => Map key elt -> key -> elt
lookupFM_ fm k = Map.findWithDefault (error $ "Key not found: " ++ show k) k fm

prtS :: Print a => a -> ShowS
prtS = showString . prt