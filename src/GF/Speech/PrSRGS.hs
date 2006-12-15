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
import GF.Speech.RegExp
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
    = showsXMLDoc $ optimizeSRGS xmlGr
    where
    root = cfgCatToGFCat origStart 
    xmlGr = grammar sisr root l $
              [meta "description" 
               ("SRGS XML speech recognition grammar for " ++ name
                ++ ". " ++ "Original start category: " ++ origStart),
               meta "generator" ("Grammatical Framework " ++ version 
                                 ++ " (compiled " ++ today ++ ")")]
            ++ topCatRules
	    ++ concatMap ruleToXML rs
    ruleToXML (SRGRule cat origCat alts) = 
        comments ["Category " ++ origCat] ++ [rule (prCat cat) (prRhs $ ebnfSRGAlts alts)]
    prRhs rhss = [oneOf (map (mkProd sisr) rhss)] 
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

mkProd :: Maybe SISRFormat -> EBnfSRGAlt -> XML
mkProd sisr (EBnfSRGAlt mp n@(Name f prs) rhs) = Tag "item" w (t ++ xs)
  where xs = [mkItem sisr rhs]
        w = maybe [] (\p -> [("weight", show p)]) mp
        t = [tag sisr ts]
        ts = [(EThis :. "name") := (EStr (prIdent f))] ++
             [(EThis :. ("arg" ++ show n)) := (EStr (argInit (prs!!n))) 
                  | n <- [0..length prs-1]]
        argInit (Unify _) = "?"
        argInit (Constant f) = maybe "?" prIdent (forestName f)

mkItem :: Maybe SISRFormat -> EBnfSRGItem -> XML
mkItem sisr = f
  where 
    f (REUnion xs)  = oneOf (map f xs)
    f (REConcat xs) = Tag "item" [] (map f xs)
    f (RERepeat x)  = Tag "item" [("repeat","0-")] [f x]
    f (RESymbol s)  = symItem sisr s

symItem :: Maybe SISRFormat -> Symbol SRGNT Token -> XML
symItem sisr (Cat (c,slots)) = Tag "item" [] ([Tag "ruleref" [("uri","#" ++ prCat c)] []]++t)
  where 
  t = if null ts then [] else [tag sisr ts]
  ts = [(EThis :. ("arg" ++ show s)) := (ERef (prCat c)) | s <- slots]
symItem _ (Tok t) = Tag "item" [] [Data (showToken t)]

tag :: Maybe SISRFormat -> [SISRExpr] -> XML
tag Nothing _ = Empty
tag (Just fmt) ts = Tag "tag" [] [Data (join "; " (map (prSISR fmt) ts))]

prCat :: String -> String
prCat c = c

showToken :: Token -> String
showToken t = t

oneOf :: [XML] -> XML
oneOf = Tag "one-of" []

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

optimizeSRGS :: XML -> XML
optimizeSRGS = bottomUpXML f 
  where f (Tag "item" [] [x@(Tag "item" [] _)]) = x
        f (Tag "one-of" [] [x]) = x
        f x = x
