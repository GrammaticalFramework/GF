----------------------------------------------------------------------
-- |
-- Module      : TransformCFG
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/14 18:38:36 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.10 $
--
--  This module does some useful transformations on CFGs.
--
-- FIXME: remove cycles
--
-- peb thinks: most of this module should be moved to GF.Conversion...
-----------------------------------------------------------------------------

module TransformCFG (makeNice, CFRule_) where

import Ident
-- import GF.OldParsing.CFGrammar
-- import GF.OldParsing.Utilities (Symbol(..))
-- import GF.OldParsing.GrammarTypes
-- import GF.Printing.PrintParser
import GF.Formalism.CFG 
import GF.Formalism.Utilities (Symbol(..), mapSymbol)
import GF.Conversion.Types
import GF.Infra.Print

import Data.FiniteMap
import Data.List
import Data.Maybe (fromJust)

import Debug.Trace


-- | not very nice to get replace the structured CFCat type with a simple string
type CFRule_ = CFRule Cat_ Name Token
type Cat_ = String

type CFRules = FiniteMap Cat_ [CFRule_]

makeNice :: CGrammar -> [CFRule_]
makeNice = concat . eltsFM . makeNice' . groupProds . cfgToCFRules
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

anyUsedBy :: [Cat_] -> CFRule_ -> Bool
anyUsedBy ss (CFRule _ r _) = or [c `elem` ss | Cat c <- r]

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



fix :: Eq a => (a -> a) -> a -> a
fix f x = let x' = f x in if x' == x then x else fix f x'

nothingOrNull :: Maybe [a] -> Bool
nothingOrNull Nothing = True
nothingOrNull (Just xs) = null xs