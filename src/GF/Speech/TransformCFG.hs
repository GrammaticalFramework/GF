----------------------------------------------------------------------
-- |
-- Module      : TransformCFG
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/18 10:17:11 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.5 $
--
--  This module does some useful transformations on CFGs.
--
-- FIXME: remove cycles
-----------------------------------------------------------------------------

module TransformCFG (makeNice, CFRule_) where

import Ident
import CFGrammar
import Parser (Symbol(..))
import GrammarTypes
import PrintParser

import Data.FiniteMap
import Data.List
import Data.Maybe (fromJust)

import Debug.Trace


-- | not very nice to get replace the structured CFCat type with a simple string
type CFRule_ = Rule CFName String Tokn

type CFRules = FiniteMap String [CFRule_]

makeNice :: CFGrammar -> [CFRule_]
makeNice = concat . eltsFM . makeNice' . groupProds . cfgToCFRules
    where makeNice' = removeLeftRecursion . removeEmptyCats

cfgToCFRules :: CFGrammar -> [CFRule_]
cfgToCFRules cfg = [Rule (catToString c) (map symb r) n | Rule c r n <- cfg]
    where symb (Cat c) = Cat (catToString c)
	  symb (Tok t) = Tok t
	  catToString = prt

-- | Group productions by their lhs categories
groupProds :: [CFRule_] -> CFRules
groupProds = addListToFM_C (++) emptyFM . map (\rs -> (ruleCat rs,[rs]))
    where ruleCat (Rule c _ _) = c

-- | Remove productions which use categories which have no productions
removeEmptyCats :: CFRules -> CFRules
removeEmptyCats rss = listToFM $ fix removeEmptyCats' $ fmToList rss
    where
    removeEmptyCats' :: [(String,[CFRule_])] -> [(String,[CFRule_])]
    removeEmptyCats' rs = k'
	where
	keep = filter (not . null . snd) rs
	allCats = nub [c | (_,r) <- rs, Rule _ rhs _ <- r, Cat c <- rhs]
	emptyCats = filter (nothingOrNull . flip lookup rs) allCats
	k' = map (\ (c,xs) -> (c, filter (not . anyUsedBy emptyCats) xs)) keep

anyUsedBy :: [String] -> CFRule_ -> Bool
anyUsedBy ss (Rule _ r _) = or [c `elem` ss | Cat c <- r]

removeLeftRecursion :: CFRules -> CFRules
removeLeftRecursion rs = listToFM $ concatMap removeDirectLeftRecursion $ map handleProds $ fmToList rs
    where 
    handleProds (c, r) = (c, concatMap handleProd r)
    handleProd (Rule ai (Cat aj:alpha) n) | aj < ai  =
              -- FIXME: this will give multiple rules with the same name
             [Rule ai (beta ++ alpha) n | Rule _ beta _ <- fromJust (lookupFM rs aj)]
    handleProd r = [r]

removeDirectLeftRecursion :: (String,[CFRule_]) -- ^ All productions for a category
			  -> [(String,[CFRule_])]
removeDirectLeftRecursion (a,rs) | null dr = [(a,rs)]
				 | otherwise = [(a, as), (a', a's)]
    where 
    a' = a ++ "'" -- FIXME: this might not be unique
    (dr,nr) = partition isDirectLeftRecursive rs
    as = maybeEndWithA' nr
    is = [Rule a' (tail r) n | Rule _ r n <- dr]
    a's = maybeEndWithA' is
    maybeEndWithA' xs = xs ++ [Rule c (r++[Cat a']) n | Rule c r n <- xs]

isDirectLeftRecursive :: CFRule_ -> Bool
isDirectLeftRecursive (Rule c (Cat c':_) _) = c == c'
isDirectLeftRecursive _ = False



fix :: Eq a => (a -> a) -> a -> a
fix f x = let x' = f x in if x' == x then x else fix f x'

nothingOrNull :: Maybe [a] -> Bool
nothingOrNull Nothing = True
nothingOrNull (Just xs) = null xs