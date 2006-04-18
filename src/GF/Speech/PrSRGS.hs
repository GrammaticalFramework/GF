----------------------------------------------------------------------
-- |
-- Module      : PrSRGS
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/01 20:09:04 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- This module prints a CFG as an SRGS XML grammar.
--
-- FIXME: remove \/ warn \/ fail if there are int \/ string literal
-- categories in the grammar
-----------------------------------------------------------------------------

module GF.Speech.PrSRGS (srgsXmlPrinter) where

import GF.Data.Utilities
import GF.Data.XML
import GF.Speech.SRG
import GF.Infra.Ident
import GF.Today

import GF.Formalism.CFG
import GF.Formalism.Utilities (Symbol(..), NameProfile(..), Profile(..), forestName)
import GF.Conversion.Types
import GF.Infra.Print
import GF.Infra.Option
import GF.Probabilistic.Probabilistic (Probs)

import Data.Char (toUpper,toLower)
import Data.List
import qualified Data.Map as Map
import qualified Data.Set as Set

srgsXmlPrinter :: Ident -- ^ Grammar name
               -> String    -- ^ Start category
	       -> Options 
               -> Bool  -- ^ Whether to include semantic interpretation 
	       -> Maybe Probs
	       -> CGrammar -> String
srgsXmlPrinter name start opts sisr probs cfg = prSrgsXml sisr srg ""
    where srg = makeSRG name start opts probs cfg

prSrgsXml :: Bool -> SRG -> ShowS
prSrgsXml sisr (SRG{grammarName=name,startCat=start,
               origStartCat=origStart,grammarLanguage=l,rules=rs})
    = showsXMLDoc xmlGr
    where
    root = prCat start
    xmlGr = grammar root l ([meta "description" 
                             ("SRGS XML speech recognition grammar for " ++ name
                              ++ ". " ++ "Original start category: " ++ origStart),
                             meta "generator" ("Grammatical Framework " ++ version 
                                               ++ " (compiled " ++ today ++ ")")]
                            ++ topCatRules
			    ++ map ruleToXML rs)
    ruleToXML (SRGRule cat origCat alts) = 
	rule (prCat cat) (comments ["Category " ++ origCat] ++ prRhs isList alts)
      where isList = "List" `isPrefixOf` origCat && length cs == 2
                      && isBase (cs!!0) && isCons (cs!!1)
            cs = sortNub [f | SRGAlt _ (Name f _) _ <- alts]
    prRhs isList rhss = [oneOf (map (mkProd sisr isList) rhss)] 
    -- externally visible rules for each of the GF categories
    topCatRules = [topRule tc [oneOf (map it cs)] | (tc,cs) <- topCats]
        where topCats = buildMultiMap [(cfgCatToGFCat origCat, cat) | SRGRule cat origCat _ <- rs]
              it c = symItem [] (Cat c) 0
              topRule i is = Tag "rule" [("id",i),("scope","public")] 
                             (is ++ [tag ["$."++i++ " = $$"]])

rule :: String -> [XML] -> XML
rule i = Tag "rule" [("id",i)]

cfgCatToGFCat :: String -> String
cfgCatToGFCat = takeWhile (/='{')

isBase :: Fun -> Bool
isBase f = "Base" `isPrefixOf` prIdent f

isCons :: Fun -> Bool
isCons f = "Cons" `isPrefixOf` prIdent f

mkProd :: Bool -> Bool -> SRGAlt -> XML
mkProd sisr isList (SRGAlt p n@(Name f pr) rhs) 
    | sisr = prodItem (Just n) p (r ++ if isList then [buildList] else [])
    | otherwise = prodItem Nothing p (map (\s -> symItem [] s 0) rhs)
  where 
  r = map (uncurry (symItem pr)) (numberCats 0 rhs)
  buildList | isBase f = 
                tag ["$ = new Array(" ++ join "," args ++ ")"]
            | isCons f = tag ["$.arg1.unshift($.arg0); $ = $.arg1;"]
    where args = ["$.arg"++show n | n <- [0..length pr-1]]
  numberCats _ [] = []
  numberCats n (s@(Cat _):ss) = (s,n):numberCats (n+1) ss
  numberCats n (s:ss) = (s,n):numberCats n ss
  

prodItem :: Maybe Name -> Maybe Double -> [XML] -> XML
prodItem n mp xs = Tag "item" w (t++cs)
  where 
  w = maybe [] (\p -> [("weight", show p)]) mp
  t = maybe [] prodTag n
  cs = case xs of
	       [Tag "item" [] xs'] -> xs'
	       _ -> xs

prodTag :: Name -> [XML]
prodTag (Name f prs) = [tag ts]
  where 
  ts = ["$.name=" ++ showFun f] ++
       ["$.arg" ++ show n ++ "=" ++ argInit (prs!!n) 
            | n <- [0..length prs-1]]
  argInit (Unify _) = metavar
  argInit (Constant f) = maybe metavar showFun (forestName f)
  showFun = show . prIdent
  metavar = show "?"

symItem :: [Profile a] -> Symbol String Token -> Int -> XML
symItem prs (Cat c) x = Tag "item" [] ([Tag "ruleref" [("uri","#" ++ prCat c)] []]++t)
  where 
  t = if null ts then [] else [tag ts]
  ts = ["$.arg" ++ show n ++ "=$$" 
            | n <- [0..length prs-1], inProfile x (prs!!n)]
symItem _ (Tok t) _ = Tag "item" [] [Data (showToken t)]

tag :: [String] -> XML
tag ts = Tag "tag" [] [Data (join "; " ts)]

inProfile :: Int -> Profile a -> Bool
inProfile x (Unify xs) = x `elem` xs
inProfile _ (Constant _) = False

prCat :: String -> String
prCat c = c

showToken :: Token -> String
showToken t = t

oneOf :: [XML] -> XML
oneOf [x] = x
oneOf xs = Tag "one-of" [] xs

grammar :: String  -- ^ root
        -> String -- ^language
	-> [XML] -> XML
grammar root l = Tag "grammar" [("xml:lang", l),
                                ("xmlns","http://www.w3.org/2001/06/grammar"),
			        ("version","1.0"),
			        ("mode","voice"),
			        ("root",root)]

meta :: String -> String -> XML
meta n c = Tag "meta" [("name",n),("content",c)] []

{-

--
-- * SRGS minimization
--

minimizeRule :: XML -> XML
minimizeRule (Tag "rule" attrs cs) 
    = Tag "rule" attrs (map minimizeOneOf cs)
      
minimizeOneOf :: XML -> XML
minimizeOneOf (Tag "one-of" attrs cs) 
    = Tag "item" [] (p++[Tag "one-of" attrs cs'])
  where
  (pref,cs') = factor cs
  p = if null pref then [] else [Tag "one-of" [] pref]
minimizeOneOf x = x

factor :: [XML] -> ([XML],[XML])
factor xs = case f of
                    Just (ps,xs') -> (map it ps, map it xs')
                    Nothing -> ([],xs)
  where 
  -- FIXME: maybe getting all the longest terminal prefixes
  -- is not optimal?
  f = cartesianFactor $ map (terminalPrefix . unIt) xs
  unIt (Tag "item" [] cs) = cs
  it cs = Tag "item" [] cs

terminalPrefix :: [XML] -> ([XML],[XML])
terminalPrefix cs = (terms, tags ++ cs'')
  where (tags,cs') = span isTag cs
        (terms,cs'') = span isTerminalItem cs'

isTag :: XML -> Bool
isTag (Tag t _ _) = t == "tag"
isTag _ = False

isTerminalItem :: XML -> Bool
isTerminalItem (Tag "item" [] [Data _]) = True
isTerminalItem _ = False

-- 
-- * Utilities
--

allEqual :: Eq a => [a] -> Bool
allEqual [] = True
allEqual (x:xs) = all (x==) xs

cartesianFactor :: (Ord a, Ord b) => [(a,b)] -> Maybe ([a],[b])
cartesianFactor xs 
    | not (null es) && allEqual es = Just (Map.keys m, Set.elems (head es))
    | otherwise = Nothing
  where m = Map.fromListWith Set.union [(x,Set.singleton y) | (x,y) <- xs]
        es = Map.elems m
-}