----------------------------------------------------------------------
-- |
-- Module      : TransformCFG
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/02 15:47:47 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.14 $
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
import GF.Formalism.Utilities (Symbol(..), mapSymbol)
import GF.Conversion.Types
import GF.Infra.Print

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
groupProds = addListToFM_C (++) emptyFM . map (\rs -> (ruleCat rs,[rs]))
    where ruleCat (CFRule c _ _) = c

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
makeRegular = undefined

{-
-- | Get the sets of mutually recursive non-terminals for a grammar.
mutRecCats :: Eq c => [CFRule c n t] -> [[c]]
mutRecCats = 
-}

{-
-- | Get a map of categories to all categories which can occur in 
--   the result of rewriting each category.
allCatsTrans :: CFRules -> FinitMap 
allCatsTrans g c = 
-}

-- Convert a strongly regular grammar to a finite automaton.
-- compileAutomaton :: 

--
-- CFG rule utilities
--

-- | Checks if a context-free rule is right-linear.
isRightLinear :: Eq c => [c]  -- ^ The categories to consider
	      -> CFRule c n t -- ^ The rule to check for right-linearity
	      -> Bool
isRightLinear cs (CFRule _ ss _) = all (not . catElem cs) (safeInit ss)

-- | Checks if a context-free rule is left-linear.
isLeftLinear ::  Eq c => [c]  -- ^ The categories to consider
	      -> CFRule c n t -- ^ The rule to check for right-linearity
	      -> Bool
isLeftLinear cs (CFRule _ ss _) = all (not . catElem cs) (drop 1 ss)

-- | Checks if a symbol is a non-terminal of one of the given categories.
catElem :: Eq c => [c] -> Symbol c t -> Bool
catElem cs (Tok _) = False
catElem cs (Cat c) = c `elem` cs

-- | Check if any of the categories used on the right-hand side
--   are in the given list of categories.
anyUsedBy :: Eq c => [c] -> CFRule c n t -> Bool
anyUsedBy cs (CFRule _ ss _) = any (catElem cs) ss

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
