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

module GF.Speech.PrSRGS (srgsXmlPrinter) where

import GF.Data.Utilities
import GF.Data.XML
import GF.Speech.RegExp
import GF.Speech.SISR as SISR
import GF.Speech.SRG
import GF.Infra.Ident
import GF.Today

import GF.Formalism.CFG
import GF.Formalism.Utilities (Symbol(..), NameProfile(..), Profile(..), forestName, filterCats)
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
prSrgsXml sisr srg@(SRG{grammarName=name,startCat=start,
                        origStartCat=origStart,grammarLanguage=l,rules=rs})
    = showsXMLDoc $ optimizeSRGS xmlGr
    where
    Just root = cfgCatToGFCat origStart 
    xmlGr = grammar sisr (catFormId root) l $
              [meta "description" 
               ("SRGS XML speech recognition grammar for " ++ name
                ++ ". " ++ "Original start category: " ++ origStart),
               meta "generator" ("Grammatical Framework " ++ version 
                                 ++ " (compiled " ++ today ++ ")")]
            ++ topCatRules
	    ++ concatMap ruleToXML rs
    ruleToXML (SRGRule cat origCat alts) = 
        comments ["Category " ++ origCat] ++ [rule cat (prRhs alts)]
    prRhs rhss = [oneOf (map (mkProd sisr) rhss)] 
    -- externally visible rules for each of the GF categories
    topCatRules = [topRule tc [oneOf (map (it tc) cs)] | (tc,cs) <- srgTopCats srg]
        where it i c = Tag "item" [] [Tag "ruleref" [("uri","#" ++ c)] [],
                                      tag sisr (topCatSISR (catFieldId i) c)]
              topRule i is = Tag "rule" [("id",catFormId i),("scope","public")] is

rule :: String -> [XML] -> XML
rule i = Tag "rule" [("id",i)]

{-
mkProd :: Maybe SISRFormat -> EBnfSRGAlt -> XML
mkProd sisr (EBnfSRGAlt mp n rhs) = Tag "item" w (t ++ xs)
  where xs = [mkItem sisr rhs]
        w = maybe [] (\p -> [("weight", show p)]) mp
        t = [tag sisr (profileInitSISR n)]

mkItem :: Maybe SISRFormat -> EBnfSRGItem -> XML
mkItem sisr = f
  where 
    f (REUnion xs)  = oneOf (map f xs)
    f (REConcat xs) = Tag "item" [] (map f xs)
    f (RERepeat x)  = Tag "item" [("repeat","0-")] [f x]
    f (RESymbol s)  = symItem sisr s
-}

mkProd :: Maybe SISRFormat -> SRGAlt -> XML
mkProd sisr (SRGAlt mp n rhs) = Tag "item" w (ti ++ xs ++ tf)
  where xs = mkItem sisr n rhs
        w = maybe [] (\p -> [("weight", show p)]) mp
        ti = [tag sisr (profileInitSISR n)]
        tf = [tag sisr (profileFinalSISR n)]


mkItem :: Maybe SISRFormat -> CFTerm -> [Symbol SRGNT Token] -> [XML]
mkItem sisr cn ss = map (symItem sisr cn) ss

symItem :: Maybe SISRFormat -> CFTerm -> Symbol SRGNT Token -> XML
symItem sisr cn (Cat n@(c,_)) = 
    Tag "item" [] $ [Tag "ruleref" [("uri","#" ++ c)] [], tag sisr (catSISR cn n)]
symItem _ _ (Tok t) = Tag "item" [] [Data (showToken t)]

tag :: Maybe SISRFormat -> (SISRFormat -> SISRTag) -> XML
tag Nothing _ = Empty
tag (Just fmt) t = case t fmt of
                     [] -> Empty
                     ts -> Tag "tag" [] [Data (prSISR ts)]

catFormId :: String -> String
catFormId = (++ "_cat")

catFieldId :: String -> String
catFieldId = (++ "_field")


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
