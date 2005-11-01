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

module GF.Speech.SRG where

import GF.Data.Operations
import GF.Data.Utilities
import GF.Infra.Ident
import GF.Formalism.CFG
import GF.Formalism.Utilities (Symbol(..))
import GF.Conversion.Types
import GF.Infra.Print
import GF.Speech.TransformCFG
import GF.Infra.Option
import GF.Probabilistic.Probabilistic (Probs)

import Data.List
import Data.Maybe (fromMaybe)
import Data.FiniteMap

data SRG = SRG { grammarName :: String    -- ^ grammar name
		 , startCat :: String     -- ^ start category name
		 , origStartCat :: String -- ^ original start category name
	         , rules :: [SRGRule] 
	       }
	 deriving (Eq,Show)

data SRGRule = SRGRule String String [SRGAlt] -- ^ SRG category name, original category name
	                                      --   and productions
	     deriving (Eq,Show)

-- | maybe a probability, and a list of symbols
data SRGAlt = SRGAlt (Maybe Double) [Symbol String Token]
	      deriving (Eq,Show)

-- | SRG category name and original name
type CatName = (String,String) 

type CatNames = FiniteMap String String

makeSRG :: Ident     -- ^ Grammar name
	-> Options   -- ^ Grammar options
	-> Maybe Probs -- ^ Probabilities
	-> CGrammar -- ^ A context-free grammar
	-> SRG
makeSRG i opts probs gr 
    = SRG { grammarName = name,
	    startCat = lookupFM_ names origStart,
	    origStartCat = origStart,
	    rules = rs }
    where 
    name = prIdent i
    origStart = getStartCat opts
    gr' = removeLeftRecursion $ removeIdenticalRules $ removeEmptyCats $ cfgToCFRules gr
    (cats,cfgRules) = unzip gr'
    names = mkCatNames name cats
    rs = map (cfgRulesToSRGRule names probs) cfgRules


-- FIXME: probabilities get larger than 1.0 when new rules are
-- introduced
-- FIXME: merge alternatives with same rhs but different probabilities
cfgRulesToSRGRule :: FiniteMap String String -> Maybe Probs -> [CFRule_] -> SRGRule
cfgRulesToSRGRule names probs rs@(r:_) = SRGRule cat origCat rhs
    where origCat = lhsCat r
	  cat = lookupFM_ names origCat
	  rhs = nub $ map ruleToAlt rs
	  ruleToAlt r = SRGAlt (ruleProb probs r) (map renameCat (ruleRhs r))
	  renameCat (Cat c) = Cat (lookupFM_ names c)
	  renameCat t = t

ruleProb :: Maybe Probs -> CFRule_ -> Maybe Double
ruleProb mp r = mp >>= \probs -> lookupProb probs (ruleFun r)

-- FIXME: move to GF.Probabilistic.Probabilistic?
lookupProb :: Probs -> Ident -> Maybe Double
lookupProb probs i = lookupTree prIdent i probs

mkCatNames :: String   -- ^ Category name prefix
	   -> [String] -- ^ Original category names
	   -> FiniteMap String String -- ^ Maps original names to SRG names
mkCatNames prefix origNames = listToFM (zip origNames names)
    where names = [prefix ++ "_" ++ show x | x <- [0..]]

--
-- * Utilities for building and printing SRGs
--

lookupFM_ :: (Ord key, Show key) => FiniteMap key elt -> key -> elt
lookupFM_ fm k = lookupWithDefaultFM fm (error $ "Key not found: " ++ show k) k

prtS :: Print a => a -> ShowS
prtS = showString . prt