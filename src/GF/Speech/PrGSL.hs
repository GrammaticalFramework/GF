{- 
   **************************************************************
    GF Module
   
    Description   : This module prints a CFG as a Nuance GSL 2.0
                    grammar.

    Author        : Björn Bringert (bringert@cs.chalmers.se)

    License       : GPL (GNU General Public License)

    Created       : September 13, 2004

    Modified      : 
   ************************************************************** 
-}

-- FIXME: this modules should not be in cfgm, but where?

-- FIXME: remove left-recursion

-- FIXME: remove empty rules

-- FIXME: remove categories with no RHS

-- FIXME: remove / warn / fail if there are int / string literal
-- categories in the grammar

-- FIXME: figure out name prefix from grammar name

module PrGSL (gslPrinter) where

import Ident
import CFGrammar
import Parser (Symbol(..))
import GrammarTypes
import PrintParser
import TransformCFG
import Option

import Data.List
import Data.Maybe (fromMaybe)
import Data.FiniteMap


data GSLGrammar = GSLGrammar String [GSLRule]
data GSLRule = GSLRule String [GSLAlt]
type GSLAlt = [Symbol String Token]

type CatNames = FiniteMap String String

gslPrinter :: Options -> CFGrammar -> String
gslPrinter opts = prGSL start
    where mstart = getOptVal opts gStartCat
	  start = fromMaybe "S" mstart ++ "{}.s"

prGSL :: String -- ^ startcat
      -> CFGrammar -> String
prGSL start cfg = prGSLGrammar names gsl ""
    where
    cfg' = makeNice cfg
    gsl = cfgToGSL start cfg'
    names = mkCatNames "GSL_" gsl

cfgToGSL :: String  -- ^ startcat
	 -> [CFRule_] -> GSLGrammar
cfgToGSL start = 
    GSLGrammar start . map cfgRulesToGSLRule . sortAndGroupBy ruleCat
    where
    ruleCat (Rule c _ _) = c
    ruleRhs (Rule _ r _) = r
    cfgRulesToGSLRule rs@(r:_) = GSLRule (ruleCat r) (map ruleRhs rs)

mkCatNames :: String -- name prefix
	   -> GSLGrammar -> CatNames
mkCatNames pref (GSLGrammar start rules) = 
    listToFM (zipWith dotIfStart lhsCats names)
    where names = [pref ++ show x | x <- [0..]]
	  lhsCats = [ c | GSLRule c _ <- rules]
	  dotIfStart c n | c == start = (c, "." ++ n)
			 | otherwise = (c, n)

prGSLGrammar :: CatNames -> GSLGrammar -> ShowS
prGSLGrammar names (GSLGrammar start g) = header . unlinesS (map prGSLrule g)
    where
    header = showString ";GSL2.0" . nl 
	     . showString ("; startcat = " ++ start ) . nl
    prGSLrule (GSLRule cat rhs) = 
      showString "; " . prtS cat . nl
        . prGSLCat cat . sp . wrap "[" (unwordsS (map prGSLAlt rhs)) "]" . nl
    prGSLAlt rhs = wrap "(" (unwordsS (map prGSLSymbol rhs')) ")"
		   where rhs' = rmPunct rhs
    prGSLSymbol (Cat c) = prGSLCat c
    prGSLSymbol (Tok t) = wrap "\"" (prtS t) "\""
    prGSLCat c = showString n 
	where n = case lookupFM names c of
		    Nothing -> error $ "Unknown category: " ++ c
		    Just x -> x

rmPunct :: [Symbol String Token] -> [Symbol String Token] 
rmPunct [] = []
rmPunct (Tok t:ss) | all isPunct (prt t) = rmPunct ss
rmPunct (s:ss) = s : rmPunct ss

isPunct :: Char -> Bool
isPunct c = c `elem` "-_.;.,?!"

--
-- * Utils
--

nl :: ShowS
nl = showChar '\n'

sp :: ShowS
sp = showChar ' '

wrap :: String -> ShowS -> String -> ShowS
wrap o s c = showString o . s . showString c

concatS :: [ShowS] -> ShowS
concatS = foldr (.) id

unwordsS :: [ShowS] -> ShowS
unwordsS = concatS . intersperse sp 

unlinesS :: [ShowS] -> ShowS
unlinesS = concatS . intersperse nl

sortAndGroupBy :: Ord b => 
		  (a -> b) -- ^ Gets the value to sort and group by
	       -> [a] 
	       -> [[a]]
sortAndGroupBy f = groupBy (both (==) f) . sortBy (both compare f)

both :: (b -> b -> c) -> (a -> b) -> a -> a -> c
both f g x y = f (g x) (g y)

prtS :: Print a => a -> ShowS
prtS = showString . prt