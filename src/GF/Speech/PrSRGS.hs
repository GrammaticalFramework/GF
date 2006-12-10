----------------------------------------------------------------------
-- |
-- Module      : PrSRGS
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- This module prints a CFG as an SRGS XML grammar.
--
-- FIXME: remove \/ warn \/ fail if there are int \/ string literal
-- categories in the grammar
-----------------------------------------------------------------------------

module GF.Speech.PrSRGS (SISRFormat(..), srgsXmlPrinter) where

import GF.Data.Utilities
import GF.Data.XML
import GF.Speech.SISR as SISR
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
import Data.Maybe
import qualified Data.Map as Map
import qualified Data.Set as Set


srgsXmlPrinter :: Ident -- ^ Grammar name
               -> String    -- ^ Start category
	       -> Options 
               -> Maybe SISRFormat 
	       -> Maybe Probs
	       -> CGrammar -> String
srgsXmlPrinter name start opts sisr probs cfg = prSrgsXml sisr srg ""
    where srg = makeSRG name start opts probs cfg

prSrgsXml :: Maybe SISRFormat -> SRG -> ShowS
prSrgsXml sisr (SRG{grammarName=name,startCat=start,
               origStartCat=origStart,grammarLanguage=l,rules=rs})
    = showsXMLDoc xmlGr
    where
    root = cfgCatToGFCat origStart 
    xmlGr = grammar sisr root l $
              [meta "description" 
               ("SRGS XML speech recognition grammar for " ++ name
                ++ ". " ++ "Original start category: " ++ origStart),
               meta "generator" ("Grammatical Framework " ++ version 
                                 ++ " (compiled " ++ today ++ ")")]
            ++ topCatRules
	    ++ map ruleToXML rs
    ruleToXML (SRGRule cat origCat alts) = 
	rule (prCat cat) (comments ["Category " ++ origCat] ++ prRhs isList alts)
      where isList = False 
                     -- Disabled list build since OptimTalk can't handle it ATM
                     {- "List" `isPrefixOf` origCat && length cs == 2
                        && isBase (cs!!0) && isCons (cs!!1) -}
            cs = sortNub [f | SRGAlt _ (Name f _) _ <- alts]
    prRhs isList rhss = [oneOf (map (mkProd sisr isList) rhss)] 
    -- externally visible rules for each of the GF categories
    topCatRules = [topRule tc [oneOf (map (it tc) cs)] | (tc,cs) <- topCats]
        where topCats = buildMultiMap [(cfgCatToGFCat origCat, cat) | SRGRule cat origCat _ <- rs]
              it i c = Tag "item" [] [Tag "ruleref" [("uri","#" ++ prCat c)] [],
                                      tag sisr [(EThis :. i) := (ERef c)]]
              topRule i is = Tag "rule" [("id",i),("scope","public")] is

rule :: String -> [XML] -> XML
rule i = Tag "rule" [("id",i)]

cfgCatToGFCat :: String -> String
cfgCatToGFCat = takeWhile (/='{')

isBase :: Fun -> Bool
isBase f = "Base" `isPrefixOf` prIdent f

isCons :: Fun -> Bool
isCons f = "Cons" `isPrefixOf` prIdent f

mkProd :: Maybe SISRFormat -> Bool -> SRGAlt -> XML
mkProd sisr isList (SRGAlt p n@(Name f pr) rhs) 
    = prodItem sisr n p (r ++ if isList then [tag sisr buildList] else [])
  where 
  r = map (uncurry (symItem sisr pr)) (numberCats 0 rhs)
  buildList | isBase f = [EThis := (ENew "Array" args)]
            | isCons f = [EApp (EThis :. "arg1" :. "unshift") [EThis :. "arg0"], 
                          EThis := (EThis :. "arg1")]
    where args = [EThis :. ("arg"++show n) | n <- [0..length pr-1]]
  numberCats _ [] = []
  numberCats n (s@(Cat _):ss) = (s,n):numberCats (n+1) ss
  numberCats n (s:ss) = (s,n):numberCats n ss
  

prodItem :: Maybe SISRFormat -> Name -> Maybe Double -> [XML] -> XML
prodItem sisr n mp xs = Tag "item" w (t++cs)
  where 
  w = maybe [] (\p -> [("weight", show p)]) mp
  t = prodTag sisr n
  cs = case xs of
	       [Tag "item" [] xs'] -> xs'
	       _ -> xs

prodTag :: Maybe SISRFormat -> Name -> [XML]
prodTag sisr (Name f prs) = [tag sisr ts]
  where 
  ts = [(EThis :. "name") := (EStr (prIdent f))] ++
       [(EThis :. ("arg" ++ show n)) := (EStr (argInit (prs!!n))) 
            | n <- [0..length prs-1]]
  argInit (Unify _) = "?"
  argInit (Constant f) = maybe "?" prIdent (forestName f)

symItem :: Maybe SISRFormat -> [Profile a] -> Symbol String Token -> Int -> XML
symItem sisr prs (Cat c) x = Tag "item" [] ([Tag "ruleref" [("uri","#" ++ prCat c)] []]++t)
  where 
  t = if null ts then [] else [tag sisr ts]
  ts = [(EThis :. ("arg" ++ show n)) := (ERef (prCat c)) 
            | n <- [0..length prs-1], inProfile x (prs!!n)]
symItem _ _ (Tok t) _ = Tag "item" [] [Data (showToken t)]

tag :: Maybe SISRFormat -> [SISRExpr] -> XML
tag Nothing _ = Empty
tag (Just fmt) ts = Tag "tag" [] [Data (join "; " (map (prSISR fmt) ts))]

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

grammar :: Maybe SISRFormat
        -> String  -- ^ root
        -> String -- ^language
	-> [XML] -> XML
grammar sisr root l = 
    Tag "grammar" $ [("xml:lang", l),
                     ("xmlns","http://www.w3.org/2001/06/grammar"),
		     ("version","1.0"),
		     ("mode","voice"),
		     ("root",root)]
                 ++ (if isJust sisr then [("tag-format","semantics/1.0")] else [])

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