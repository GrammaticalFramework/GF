----------------------------------------------------------------------
-- |
-- Module      : TransformCFG
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/14 15:17:30 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.22 $
--
--  This module does some useful transformations on CFGs.
--
-- FIXME: remove cycles
--
-- peb thinks: most of this module should be moved to GF.Conversion...
-----------------------------------------------------------------------------

-- FIXME: lots of this stuff is used by CFGToFiniteState, thus
-- the missing explicit expot list.
module GF.Speech.TransformCFG {- (CFRule_, CFRules, 
			       cfgToCFRules, getStartCat,
			       removeLeftRecursion,
			       removeEmptyCats, removeIdenticalRules) -} where

import GF.Conversion.Types
import GF.Data.Utilities
import GF.Formalism.CFG 
import GF.Formalism.Utilities (Symbol(..), mapSymbol, filterCats, symbol, NameProfile(..))
import GF.Infra.Ident
import GF.Infra.Option
import GF.Infra.Print
import GF.Speech.FiniteState

import Control.Monad
import Data.FiniteMap
import Data.List
import Data.Maybe (fromJust, fromMaybe)


-- | not very nice to replace the structured CFCat type with a simple string
type CFRule_ = CFRule Cat_ Name Token
type Cat_ = String

type CFRules = [(Cat_,[CFRule_])]

cfgToCFRules :: CGrammar -> CFRules
cfgToCFRules cfg = groupProds [CFRule (catToString c) (map symb r) n | CFRule c r n <- cfg]
    where symb = mapSymbol catToString id
          -- symb (Cat c) = Cat (catToString c)
	  -- symb (Tok t) = Tok t
	  catToString = prt

getStartCat :: Options -> String
getStartCat opts = fromMaybe "S" (getOptVal opts gStartCat) ++ "{}.s"

-- | Group productions by their lhs categories
groupProds :: [CFRule_] -> CFRules
groupProds = fmToList . addListToFM_C (++) emptyFM . map (\r -> (lhsCat r,[r]))

ungroupProds :: CFRules -> [CFRule_]
ungroupProds = concat . map snd


-- | Remove productions which use categories which have no productions
removeEmptyCats :: CFRules -> CFRules
removeEmptyCats = fix removeEmptyCats'
    where
    removeEmptyCats' :: CFRules -> CFRules
    removeEmptyCats' rs = k'
	where
	keep = filter (not . null . snd) rs
	allCats = nub [c | (_,r) <- rs, CFRule _ rhs _ <- r, Cat c <- rhs]
	emptyCats = filter (nothingOrNull . flip lookup rs) allCats
	k' = map (\ (c,xs) -> (c, filter (not . anyUsedBy emptyCats) xs)) keep

-- | Remove rules which are identical, not caring about the rule names.
removeIdenticalRules :: CFRules -> CFRules
removeIdenticalRules g = [(c,nubBy sameCatAndRhs rs) | (c,rs) <- g]
    where sameCatAndRhs (CFRule c1 ss1 _) (CFRule c2 ss2 _) = c1 == c2 && ss1 == ss2

removeLeftRecursion :: CFRules -> CFRules
removeLeftRecursion rs = concatMap removeDirectLeftRecursion $ map handleProds rs
    where 
    handleProds (c, r) = (c, concatMap handleProd r)
    handleProd (CFRule ai (Cat aj:alpha) n) | aj < ai  =
              -- FIXME: this will give multiple rules with the same name
             [CFRule ai (beta ++ alpha) n | CFRule _ beta _ <- lookup' aj rs]
    handleProd r = [r]

removeDirectLeftRecursion :: (Cat_,[CFRule_]) -- ^ All productions for a category
			  -> CFRules
removeDirectLeftRecursion (a,rs) | null dr = [(a,rs)]
				 | otherwise = [(a, as), (a', a's)]
    where 
    a' = a ++ "'" -- FIXME: this might not be unique
    (dr,nr) = partition isDirectLeftRecursive rs
    as = maybeEndWithA' nr
    is = [CFRule a' (tail r) n | CFRule _ r n <- dr]
    a's = maybeEndWithA' is
    maybeEndWithA' xs = xs ++ [CFRule c (r++[Cat a']) n | CFRule c r n <- xs]

isDirectLeftRecursive :: CFRule_ -> Bool
isDirectLeftRecursive (CFRule c (Cat c':_) _) = c == c'
isDirectLeftRecursive _ = False


--
-- * CFG rule utilities
--

catRules :: CFRules -> Cat_ -> [CFRule_]
catRules rs c = fromMaybe [] (lookup c rs)

catSetRules :: CFRules -> [Cat_] -> [CFRule_]
catSetRules g s = concatMap (catRules g) s

lhsCat :: CFRule c n t -> c
lhsCat (CFRule c _ _) = c

ruleRhs :: CFRule c n t ->  [Symbol c t]
ruleRhs (CFRule _ ss _) = ss


-- | Checks if a symbol is a non-terminal of one of the given categories.
catElem :: Eq c => Symbol c t -> [c] -> Bool
catElem s cs = symbol (`elem` cs) (const False) s

-- | Check if any of the categories used on the right-hand side
--   are in the given list of categories.
anyUsedBy :: Eq c => [c] -> CFRule c n t -> Bool
anyUsedBy cs (CFRule _ ss _) = any (`elem` cs) (filterCats ss)

mkName :: String -> Name
mkName n = Name (IC n) []


