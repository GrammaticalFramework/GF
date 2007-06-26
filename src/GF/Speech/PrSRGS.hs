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

module GF.Speech.PrSRGS (srgsXmlPrinter, srgsXmlNonRecursivePrinter) where

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
import GF.Compile.ShellState (StateGrammar)

import Data.Char (toUpper,toLower)
import Data.List
import Data.Maybe
import qualified Data.Map as Map
import qualified Data.Set as Set

srgsXmlPrinter :: Maybe SISRFormat 
	       -> Bool -- ^ Include probabilities
	       -> Options 
               -> StateGrammar -> String
srgsXmlPrinter sisr probs opts s = prSrgsXml sisr probs $ makeSimpleSRG opts s

srgsXmlNonRecursivePrinter :: Options -> StateGrammar -> String
srgsXmlNonRecursivePrinter opts s = prSrgsXml Nothing False $ makeNonRecursiveSRG opts s


prSrgsXml :: Maybe SISRFormat -> Bool -> SRG -> String
prSrgsXml sisr probs srg@(SRG{grammarName=name,startCat=start,
                        origStartCat=origStart,grammarLanguage=l,rules=rs})
    = showXMLDoc (optimizeSRGS xmlGr)
    where
    Just root = cfgCatToGFCat origStart 
    xmlGr = grammar sisr (catFormId root) l $
              [meta "description" 
               ("SRGS XML speech recognition grammar for " ++ name
                ++ ". " ++ "Original start category: " ++ origStart),
               meta "generator" ("Grammatical Framework " ++ version)]
            ++ topCatRules
	    ++ concatMap ruleToXML rs
    ruleToXML (SRGRule cat origCat alts) = 
        comments ["Category " ++ origCat] ++ [rule cat (prRhs alts)]
    prRhs rhss = [oneOf (map (mkProd sisr probs) rhss)] 
    -- externally visible rules for each of the GF categories
    topCatRules = [topRule tc [oneOf (map (it tc) cs)] | (tc,cs) <- srgTopCats srg]
        where it i c = Tag "item" [] ([ETag "ruleref" [("uri","#" ++ c)]] 
                                      ++ tag sisr (topCatSISR c))
              topRule i is = Tag "rule" [("id",catFormId i),("scope","public")] is

rule :: String -> [XML] -> XML
rule i = Tag "rule" [("id",i)]

mkProd :: Maybe SISRFormat -> Bool -> SRGAlt -> XML
mkProd sisr probs (SRGAlt mp n rhs) = Tag "item" w (ti ++ [x] ++ tf)
  where x = mkItem sisr n rhs
        w | probs = maybe [] (\p -> [("weight", show p)]) mp
          | otherwise = []
        ti = tag sisr (profileInitSISR n)
        tf = tag sisr (profileFinalSISR n)

mkItem :: Maybe SISRFormat -> CFTerm -> SRGItem -> XML
mkItem sisr cn = f
  where 
    f (REUnion [])  = ETag "ruleref" [("special","VOID")]
    f (REUnion xs) 
        | not (null es) = Tag "item" [("repeat","0-1")] [f (REUnion nes)]
        | otherwise = oneOf (map f xs)
      where (es,nes) = partition isEpsilon xs
    f (REConcat []) = ETag "ruleref" [("special","NULL")]
    f (REConcat xs) = Tag "item" [] (map f xs)
    f (RERepeat x)  = Tag "item" [("repeat","0-")] [f x]
    f (RESymbol s)  = symItem sisr cn s

{-
mkProd :: Maybe SISRFormat -> Bool -> SRGAlt -> XML
mkProd sisr probs (SRGAlt mp n rhs) = Tag "item" w (ti ++ xs ++ tf)
  where xs = mkItem sisr n rhs
        w | probs = maybe [] (\p -> [("weight", show p)]) mp
          | otherwise = []
        ti = [tag sisr (profileInitSISR n)]
        tf = [tag sisr (profileFinalSISR n)]


mkItem :: Maybe SISRFormat -> CFTerm -> [Symbol SRGNT Token] -> [XML]
mkItem sisr cn ss = map (symItem sisr cn) ss
-}

symItem :: Maybe SISRFormat -> CFTerm -> Symbol SRGNT Token -> XML
symItem sisr cn (Cat n@(c,_)) = 
    Tag "item" [] $ [ETag "ruleref" [("uri","#" ++ c)]] ++ tag sisr (catSISR cn n)
symItem _ _ (Tok t) = Tag "item" [] [Data (showToken t)]

tag :: Maybe SISRFormat -> (SISRFormat -> SISRTag) -> [XML]
tag Nothing _ = []
tag (Just fmt) t = case t fmt of
                     [] -> []
                     ts -> [Tag "tag" [] [Data (prSISR ts)]]

catFormId :: String -> String
catFormId = (++ "_cat")


showToken :: Token -> String
showToken t = t

oneOf :: [XML] -> XML
oneOf = Tag "one-of" []

grammar :: Maybe SISRFormat
        -> String  -- ^ root
        -> Maybe String -- ^language
	-> [XML] -> XML
grammar sisr root ml = 
    Tag "grammar" $ [("xmlns","http://www.w3.org/2001/06/grammar"),
		     ("version","1.0"),
		     ("mode","voice"),
		     ("root",root)]
                 ++ (if isJust sisr then [("tag-format","semantics/1.0")] else [])
                 ++ maybe [] (\l -> [("xml:lang", l)]) ml

meta :: String -> String -> XML
meta n c = ETag "meta" [("name",n),("content",c)]

optimizeSRGS :: XML -> XML
optimizeSRGS = bottomUpXML f 
  where f (Tag "item" [] [x@(Tag "item" _ _)]) = x
        f (Tag "item" [] [x@(Tag "one-of" _ _)]) = x
        f (Tag "item" as [Tag "item" [] xs]) = Tag "item" as xs
        f (Tag "item" as xs) = Tag "item" as (map g xs)
           where g (Tag "item" [] [x@(ETag "ruleref" _)]) = x
                 g x = x
        f (Tag "one-of" [] [x]) = x
        f x = x
