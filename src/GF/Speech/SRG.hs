{- 
   **************************************************************
    GF Module
   
    Description   : Representation of, conversion to, and
                    utilities for printing of a 
                    general Speech Recognition Grammar. 

    Author        : Björn Bringert (bringert@cs.chalmers.se)

    License       : GPL (GNU General Public License)

    Created       : October 1, 2004

    Modified      : 
   ************************************************************** 
-}

-- FIXME: remove / warn / fail if there are int / string literal
-- categories in the grammar

-- FIXME: figure out name prefix from grammar name

module SRG where

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


data SRG = SRG { grammarName :: String    -- ^ grammar name
		 , startCat :: String     -- ^ start category name
		 , origStartCat :: String -- ^ original start category name
	         , rules :: [SRGRule] 
	       }
data SRGRule = SRGRule String String [SRGAlt] -- ^ SRG category name, original category name
	                                      --   and productions
type SRGAlt = [Symbol String Token]
type CatName = (String,String) 
-- ^ SRG category name and original name

type CatNames = FiniteMap String String

makeSRG :: Ident     -- ^ Grammar name
	-> Options   -- ^ Grammar options
	-> CFGrammar -- ^ A context-free grammar
	-> SRG
makeSRG i opts gr = SRG { grammarName = name,
			  startCat = start,
			  origStartCat = origStart,
			  rules = rs }
    where 
    name = prIdent i
    origStart = fromMaybe "S" (getOptVal opts gStartCat) ++ "{}.s"
    start = lookupFM_ names origStart
    gr' = makeNice gr
    names = mkCatNames name (nub $ map ruleCat gr')
    rs = map (cfgRulesToSRGRule names) (sortAndGroupBy ruleCat gr')

cfgRulesToSRGRule :: FiniteMap String String -> [CFRule_] -> SRGRule
cfgRulesToSRGRule names rs@(r:_) = SRGRule cat origCat rhs
    where origCat = ruleCat r
	  cat = lookupFM_ names origCat
	  rhs = nub $ map (map renameCat . ruleRhs) rs
	  renameCat (Cat c) = Cat (lookupFM_ names c)
	  renameCat t = t

ruleCat :: Rule n c t -> c
ruleCat (Rule c _ _) = c

ruleRhs :: Rule n c t -> [Symbol c t]
ruleRhs (Rule _ r _) = r

mkCatNames :: String   -- ^ Category name prefix
	   -> [String] -- ^ Original category names
	   -> FiniteMap String String -- ^ Maps original names to SRG names
mkCatNames prefix origNames = listToFM (zip origNames names)
    where names = [prefix ++ "_" ++ show x | x <- [0..]]

--
-- * Utilities for building and printing SRGs
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
unwordsS = join " "

unlinesS :: [ShowS] -> ShowS
unlinesS = join "\n"

join :: String -> [ShowS] -> ShowS
join glue = concatS . intersperse (showString glue)

sortAndGroupBy :: Ord b => 
		  (a -> b) -- ^ Gets the value to sort and group by
	       -> [a] 
	       -> [[a]]
sortAndGroupBy f = groupBy (both (==) f) . sortBy (both compare f)

both :: (b -> b -> c) -> (a -> b) -> a -> a -> c
both f g x y = f (g x) (g y)

prtS :: Print a => a -> ShowS
prtS = showString . prt

lookupFM_ :: (Ord key, Show key) => FiniteMap key elt -> key -> elt
lookupFM_ fm k = lookupWithDefaultFM fm (error $ "Key not found: " ++ show k) k
