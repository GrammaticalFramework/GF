----------------------------------------------------------------------
-- |
-- Module      : TransformCFG
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/08 15:39:12 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.17 $
--
--  This module does some useful transformations on CFGs.
--
-- FIXME: remove cycles
--
-- peb thinks: most of this module should be moved to GF.Conversion...
-----------------------------------------------------------------------------

module GF.Speech.TransformCFG (CFRule_, CFRules, 
			       cfgToCFRules, getStartCat,
			       removeLeftRecursion,
			       removeEmptyCats,
			       makeRegular, 
			       compileAutomaton) where

import GF.Infra.Ident
import GF.Formalism.CFG 
import GF.Formalism.Utilities (Symbol(..), mapSymbol, filterCats, symbol, NameProfile(..))
import GF.Conversion.Types
import GF.Infra.Print
import GF.Infra.Option
import GF.Speech.FiniteState

import Control.Monad
import Data.FiniteMap
import Data.List
import Data.Maybe (fromJust, fromMaybe)

import Debug.Trace


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

catRules :: CFRules -> Cat_ -> [CFRule_]
catRules rs c = fromMaybe [] (lookup c rs)

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

removeLeftRecursion :: CFRules -> CFRules
removeLeftRecursion rs = concatMap removeDirectLeftRecursion $ map handleProds rs
    where 
    handleProds (c, r) = (c, concatMap handleProd r)
    handleProd (CFRule ai (Cat aj:alpha) n) | aj < ai  =
              -- FIXME: this will give multiple rules with the same name
             [CFRule ai (beta ++ alpha) n | CFRule _ beta _ <- fromJust (lookup aj rs)]
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


-- Use the transformation algorithm from \"Regular Approximation of Context-free
-- Grammars through Approximation\", Mohri and Nederhof, 2000
-- to create an over-generating regular frammar for a context-free 
-- grammar
makeRegular :: CFRules -> CFRules
makeRegular g = groupProds $ concatMap trSet (mutRecCats g)
  where trSet cs | allXLinear cs rs = rs
		 | otherwise = concatMap handleCat cs
	    where rs = concatMap (catRules g) cs
		  handleCat c = [CFRule c' [] (mkName (c++"-empty"))] -- introduce A' -> e
				++ concatMap (makeRightLinearRules c) (catRules g c)
		      where c' = newCat c
		  makeRightLinearRules b' (CFRule c ss n) = 
		      case ys of
			      [] -> [CFRule b' (xs ++ [Cat (newCat c)]) n] -- no non-terminals left
			      (Cat b:zs) -> CFRule b' (xs ++ [Cat b]) n 
					: makeRightLinearRules (newCat b) (CFRule c zs n)
		      where (xs,ys) = break (`catElem` cs) ss
	newCat c = c ++ "$"


-- | Get the sets of mutually recursive non-terminals for a grammar.
mutRecCats :: CFRules -> [[Cat_]]
mutRecCats g = equivalenceClasses $ symmetricSubrelation $ transitiveClosure $ reflexiveClosure allCats r
  where r = nub [(c,c') | (_,rs) <- g, CFRule c ss _ <- rs, Cat c' <- ss]
	allCats = map fst g



-- Convert a strongly regular grammar to a finite automaton.
compileAutomaton :: Cat_ -- ^ Start category
		 -> CFRules
		 -> FA () (Maybe Token)
compileAutomaton start g = make_fa s [Cat start] f g fa''
  where fa = newFA ()
	s = startState fa
	(fa',f) = newState () fa
	fa'' = addFinalState f fa'

-- | The make_fa algorithm from \"Regular approximation of CFLs: a grammatical view\",
--   Mark-Jan Nederhof. International Workshop on Parsing Technologies, 1997.
make_fa :: State -> [Symbol Cat_ Token] -> State 
	-> CFRules -> FA () (Maybe Token) -> FA () (Maybe Token)
make_fa q0 a q1 g fa = 
    case a of
	   [] -> newTrans q0 Nothing q1 fa
	   [Tok t] -> newTrans q0 (Just t) q1 fa

--
-- * CFG rule utilities
--

{-
-- | Get all the rules for a given category.
catRules :: Eq c => [CFRule c n t] -> c -> [CFRule c n t]
catRules rs c = [r | r@(CFRule c' _ _) <- rs, c' == c]
-}

-- | Gets the set of LHS categories of a set of rules.
lhsCats :: Eq c => [CFRule c n t] -> [c]
lhsCats = nub . map lhsCat

lhsCat :: CFRule c n t -> c
lhsCat (CFRule c _ _) = c

-- | Check if all the rules are right-linear, or all the rules are
--   left-linear, with respect to given categories.
allXLinear :: Eq c => [c] -> [CFRule c n t] -> Bool
allXLinear cs rs = all (isRightLinear cs) rs || all (isLeftLinear cs) rs

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