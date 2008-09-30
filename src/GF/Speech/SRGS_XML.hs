----------------------------------------------------------------------
-- |
-- Module      : GF.Speech.SRGS_XML
--
-- Prints an SRGS XML speech recognition grammars.
----------------------------------------------------------------------
module GF.Speech.SRGS_XML (srgsXmlPrinter, srgsXmlNonRecursivePrinter) where

import GF.Data.Utilities
import GF.Data.XML
import GF.Infra.Option
import GF.Speech.CFG
import GF.Speech.RegExp
import GF.Speech.SISR as SISR
import GF.Speech.SRG
import PGF (PGF, CId)

import Control.Monad
import Data.Char (toUpper,toLower)
import Data.List
import Data.Maybe
import qualified Data.Map as Map

srgsXmlPrinter :: Maybe SISRFormat 
               -> PGF -> CId -> String
srgsXmlPrinter sisr pgf cnc = prSrgsXml sisr $ makeNonLeftRecursiveSRG pgf cnc

srgsXmlNonRecursivePrinter :: PGF -> CId -> String
srgsXmlNonRecursivePrinter pgf cnc = prSrgsXml Nothing $ makeNonRecursiveSRG pgf cnc


prSrgsXml :: Maybe SISRFormat -> SRG -> String
prSrgsXml sisr srg = showXMLDoc (optimizeSRGS xmlGr)
    where
    xmlGr = grammar sisr (srgStartCat srg) (srgLanguage srg) $
              [meta "description" 
                 ("SRGS XML speech recognition grammar for " ++ srgName srg ++ "."),
               meta "generator" "Grammatical Framework"]
	    ++ map ruleToXML (srgRules srg)
    ruleToXML (SRGRule cat alts) = Tag "rule" ([("id",cat)]++pub) (prRhs alts)
        where pub = if isExternalCat srg cat then [("scope","public")] else []
    prRhs rhss = [oneOf (map (mkProd sisr) rhss)] 

mkProd :: Maybe SISRFormat -> SRGAlt -> XML
mkProd sisr (SRGAlt mp n rhs) = Tag "item" [] (ti ++ [x] ++ tf)
  where x = mkItem sisr n rhs
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

symItem :: Maybe SISRFormat -> CFTerm -> Symbol SRGNT Token -> XML
symItem sisr cn (NonTerminal n@(c,_)) = 
    Tag "item" [] $ [ETag "ruleref" [("uri","#" ++ c)]] ++ tag sisr (catSISR cn n)
symItem _ _ (Terminal t) = Tag "item" [] [Data (showToken t)]

tag :: Maybe SISRFormat -> (SISRFormat -> SISRTag) -> [XML]
tag Nothing _ = []
tag (Just fmt) t = case t fmt of
                     [] -> []
                     ts -> [Tag "tag" [] [Data (prSISR ts)]]

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
