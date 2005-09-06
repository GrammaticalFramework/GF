----------------------------------------------------------------------
-- |
-- Module      : TransformCFG
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/06 08:06:42 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.15 $
--
--  This module does some useful transformations on CFGs.
--
-- FIXME: remove cycles
--
-- peb thinks: most of this module should be moved to GF.Conversion...
-----------------------------------------------------------------------------

module GF.Speech.TransformCFG (makeNice, CFRule_, makeRegular) where

import GF.Infra.Ident
import GF.Formalism.CFG 
import GF.Formalism.Utilities (Symbol(..), mapSymbol, filterCats, symbol, NameProfile(..))
import GF.Conversion.Types
import GF.Infra.Print

import Control.Monad
import Data.FiniteMap
import Data.List
import Data.Maybe (fromJust)

import Debug.Trace


-- | not very nice to replace the structured CFCat type with a simple string
type CFRule_ = CFRule Cat_ Name Token
type Cat_ = String

type CFRules = FiniteMap Cat_ [CFRule_]

-- | Remove left-recursion and categories with no productions
--   from a context-free grammar.
makeNice :: CGrammar -> [CFRule_]
makeNice = ungroupProds . makeNice' . groupProds . cfgToCFRules
    where makeNice' = removeLeftRecursion . removeEmptyCats

cfgToCFRules :: CGrammar -> [CFRule_]
cfgToCFRules cfg = [CFRule (catToString c) (map symb r) n | CFRule c r n <- cfg]
    where symb = mapSymbol catToString id
          -- symb (Cat c) = Cat (catToString c)
	  -- symb (Tok t) = Tok t
	  catToString = prt

-- | Group productions by their lhs categories
groupProds :: [CFRule_] -> CFRules
groupProds = addListToFM_C (++) emptyFM . map (\r -> (lhsCat r,[r]))

ungroupProds :: CFRules -> [CFRule_]
ungroupProds = concat . eltsFM

-- | Remove productions which use categories which have no productions
removeEmptyCats :: CFRules -> CFRules
removeEmptyCats rss = listToFM $ fix removeEmptyCats' $ fmToList rss
    where
    removeEmptyCats' :: [(Cat_,[CFRule_])] -> [(Cat_,[CFRule_])]
    removeEmptyCats' rs = k'
	where
	keep = filter (not . null . snd) rs
	allCats = nub [c | (_,r) <- rs, CFRule _ rhs _ <- r, Cat c <- rhs]
	emptyCats = filter (nothingOrNull . flip lookup rs) allCats
	k' = map (\ (c,xs) -> (c, filter (not . anyUsedBy emptyCats) xs)) keep

removeLeftRecursion :: CFRules -> CFRules
removeLeftRecursion rs = listToFM $ concatMap removeDirectLeftRecursion $ map handleProds $ fmToList rs
    where 
    handleProds (c, r) = (c, concatMap handleProd r)
    handleProd (CFRule ai (Cat aj:alpha) n) | aj < ai  =
              -- FIXME: this will give multiple rules with the same name
             [CFRule ai (beta ++ alpha) n | CFRule _ beta _ <- fromJust (lookupFM rs aj)]
    handleProd r = [r]

removeDirectLeftRecursion :: (Cat_,[CFRule_]) -- ^ All productions for a category
			  -> [(Cat_,[CFRule_])]
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


-- Use the transformation algorithm from \"Regular Approximation of Context-free
-- Grammars through Approximation\", Mohri and Nederhof, 2000
-- to create an over-generating regular frammar for a context-free 
-- grammar
makeRegular :: [CFRule_] -> [CFRule_]
makeRegular g = concatMap trSet (mutRecCats g)
  where trSet cs | allXLinear cs rs = rs
		 | otherwise = concatMap handleCat cs
	    where rs = concatMap (catRules g) cs
		  handleCat c = [CFRule c' [] (mkName (c++"-empty"))] -- introduce A' -> e
				++ concatMap (makeRightLinearRules c) crs
				-- FIXME: add more rules here, see pg 255, item 2
		      where crs = catRules rs c
			    c' = newCat c
		  makeRightLinearRules b' (CFRule c ss n) = 
		      case ys of
			      [] -> [CFRule b' (xs ++ [Cat (newCat c)]) n] -- no non-terminals left
			      (Cat b:zs) -> CFRule b' (xs ++ [Cat b]) n 
					: makeRightLinearRules (newCat b) (CFRule c zs n)
		      where (xs,ys) = break (`catElem` cs) ss
	newCat c = c ++ "$"


-- | Check if all the rules are right-linear, or all the rules are
--   left-linear, with respect to given categories.
allXLinear :: Eq c => [c] -> [CFRule c n t] -> Bool
allXLinear cs rs = all (isRightLinear cs) rs || all (isLeftLinear cs) rs

-- | Get the sets of mutually recursive non-terminals for a grammar.
mutRecCats :: Eq c => [CFRule c n t] -> [[c]]
mutRecCats g = equivalenceClasses $ symmetricSubrelation $ transitiveClosure $ reflexiveClosure allCats r
  where r = nub [(c,c') | CFRule c ss _ <- g, Cat c' <- ss]
	allCats = nub [c | CFRule c _ _ <- g]

-- Convert a strongly regular grammar to a finite automaton.
-- compileAutomaton :: 

--
-- * CFG rule utilities
--

-- | Get all the rules for a given category.
catRules :: Eq c => [CFRule c n t] -> c -> [CFRule c n t]
catRules rs c = [r | r@(CFRule c' _ _) <- rs, c' == c]

-- | Gets the set of LHS categories of a set of rules.
lhsCats :: Eq c => [CFRule c n t] -> [c]
lhsCats = nub . map lhsCat

lhsCat :: CFRule c n t -> c
lhsCat (CFRule c _ _) = c

-- | Checks if a context-free rule is right-linear.
isRightLinear :: Eq c => [c]  -- ^ The categories to consider
	      -> CFRule c n t -- ^ The rule to check for right-linearity
	      -> Bool
isRightLinear cs (CFRule _ ss _) = all (not . (`catElem` cs)) (safeInit ss)

-- | Checks if a context-free rule is left-linear.
isLeftLinear ::  Eq c => [c]  -- ^ The categories to consider
	      -> CFRule c n t -- ^ The rule to check for right-linearity
	      -> Bool
isLeftLinear cs (CFRule _ ss _) = all (not . (`catElem` cs)) (drop 1 ss)

-- | Checks if a symbol is a non-terminal of one of the given categories.
catElem :: Eq c => Symbol c t -> [c] -> Bool
catElem s cs = symbol (`elem` cs) (const False) s

-- | Check if any of the categories used on the right-hand side
--   are in the given list of categories.
anyUsedBy :: Eq c => [c] -> CFRule c n t -> Bool
anyUsedBy cs (CFRule _ ss _) = any (`elem` cs) (filterCats ss)

mkName :: String -> Name
mkName n = Name (IC n) []

--
-- * Relations
--

-- FIXME: these could use a more efficent data structures and algorithms.

isRelatedTo :: Eq a => [(a,a)] -> a  -> a -> Bool
isRelatedTo r x y = (x,y) `elem` r

transitiveClosure :: Eq a => [(a,a)] -> [(a,a)]
transitiveClosure r = fix (\r -> r `union` [ (x,w) | (x,y) <- r, (z,w) <- r, y == z ]) r

reflexiveClosure :: Eq a => [a] -- ^ The set over which the relation is defined.
		 -> [(a,a)] -> [(a,a)]
reflexiveClosure u r = [(x,x) | x <- u] `union` r

symmetricSubrelation :: Eq a => [(a,a)] -> [(a,a)]
symmetricSubrelation r = [p | p@(x,y) <- r, (y,x) `elem` r]

-- | Get the equivalence classes from an equivalence relation. Since
--   the relation is relexive, the set can be recoved from the relation.
equivalenceClasses :: Eq a => [(a,a)] -> [[a]]
equivalenceClasses r = equivalenceClasses_ (nub (map fst r)) r
 where equivalenceClasses_ [] _ = []
       equivalenceClasses_ (x:xs) r = (x:ys):equivalenceClasses_ zs r
	   where (ys,zs) = partition (isRelatedTo r x) xs

--
-- * Utilities
--

fix :: Eq a => (a -> a) -> a -> a
fix f x = let x' = f x in if x' == x then x else fix f x'

nothingOrNull :: Maybe [a] -> Bool
nothingOrNull Nothing = True
nothingOrNull (Just xs) = null xs

safeInit :: [a] -> [a]
safeInit [] = []
safeInit xs = init xs

unionAll :: Eq a => [[a]] -> [a]
unionAll = nub . concat

whenMP :: MonadPlus m => Bool -> a -> m a
whenMP b x = if b then return x else mzero

--
-- * Testing stuff, can be removed
-- 

c --> ss = CFRule c ss (mkName "")

prGr g = putStrLn $ showGr g

showGr g = unlines $ map showRule g

showRule (CFRule c ss _) = c ++ " --> " ++ unwords (map showSym ss) 

showSym s = symbol id show s