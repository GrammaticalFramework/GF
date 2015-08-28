----------------------------------------------------------------------
-- |
-- Module      : PrJSRGS_ABNF
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/01 20:09:04 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.16 $
--
-- This module prints a CFG as a JSGF grammar.
--
-- FIXME: remove \/ warn \/ fail if there are int \/ string literal
-- categories in the grammar
--
-- FIXME: convert to UTF-8
-----------------------------------------------------------------------------

module GF.Speech.SRGS_ABNF (srgsAbnfPrinter, srgsAbnfNonRecursivePrinter) where

--import GF.Data.Utilities
import GF.Infra.Option
import GF.Grammar.CFG
import GF.Speech.SISR as SISR
import GF.Speech.SRG
import GF.Speech.RegExp
import PGF (PGF, CId)

--import Data.Char
import Data.List
import Data.Maybe
import GF.Text.Pretty
--import Debug.Trace

width :: Int
width = 75

srgsAbnfPrinter :: Options
	        -> PGF -> CId -> String
srgsAbnfPrinter opts pgf cnc = showDoc $ prABNF sisr $ makeNonLeftRecursiveSRG opts pgf cnc
    where sisr = flag optSISR opts

srgsAbnfNonRecursivePrinter :: Options -> PGF -> CId -> String
srgsAbnfNonRecursivePrinter opts pgf cnc = showDoc $ prABNF Nothing $ makeNonRecursiveSRG opts pgf cnc

showDoc = renderStyle (style { lineLength = width })

prABNF :: Maybe SISRFormat -> SRG -> Doc
prABNF sisr srg
    = header $++$ foldr ($++$) empty (map prRule (srgRules srg))
    where
    header = "#ABNF 1.0 UTF-8;" $$
             meta "description" ("Speech recognition grammar for " ++ srgName srg) $$
             meta "generator" "Grammatical Framework" $$
             language $$ tagFormat $$ mainCat
    language = maybe empty (\l -> "language" <+> l <> ';') (srgLanguage srg)
    tagFormat | isJust sisr = "tag-format" <+> "<semantics/1.0>" <> ';'
              | otherwise = empty
    mainCat = "root" <+> prCat (srgStartCat srg) <> ';'
    prRule (SRGRule cat alts) = rule (isExternalCat srg cat) cat (map prAlt alts)
    prAlt (SRGAlt mp n rhs) = sep [initTag, p (prItem sisr n rhs), finalTag]
      where initTag = tag sisr (profileInitSISR n)
            finalTag = tag sisr (profileFinalSISR n)
            p = if isEmpty initTag && isEmpty finalTag then id else parens

prCat :: Cat -> Doc
prCat c = '$' <> c

prItem :: Maybe SISRFormat -> CFTerm -> SRGItem -> Doc
prItem sisr t = f 0
  where
    f _ (REUnion [])  = pp "$VOID"
    f p (REUnion xs) 
        | not (null es) = brackets (f 0 (REUnion nes))
        | otherwise = (if p >= 1 then parens else id) (alts (map (f 1) xs))
      where (es,nes) = partition isEpsilon xs
    f _ (REConcat []) = pp "$NULL"
    f p (REConcat xs) = (if p >= 3 then parens else id) (fsep (map (f 2) xs))
    f p (RERepeat x)  = f 3 x <> "<0->"
    f _ (RESymbol s)  = prSymbol sisr t s


prSymbol :: Maybe SISRFormat -> CFTerm -> SRGSymbol -> Doc
prSymbol sisr cn (NonTerminal n@(c,_)) = prCat c <+> tag sisr (catSISR cn n)
prSymbol _ cn (Terminal t) 
    | all isPunct t = empty  -- removes punctuation
    | otherwise = pp t -- FIXME: quote if there is whitespace or odd chars

tag :: Maybe SISRFormat -> (SISRFormat -> SISRTag) -> Doc
tag Nothing _ = empty
tag (Just fmt) t = 
    case t fmt of
      [] -> empty
      -- grr, silly SRGS ABNF does not have an escaping mechanism
      ts | '{' `elem` x || '}' `elem` x -> "{!{" <+> x <+> "}!}"
         | otherwise -> "{" <+> x <+> "}"
         where x = prSISR ts

isPunct :: Char -> Bool
isPunct c = c `elem` "-_.;.,?!"
{-
comment :: String -> Doc
comment s = "//" <+> s
-}
alts :: [Doc] -> Doc
alts = fsep . prepunctuate ("| ")

rule :: Bool -> Cat -> [Doc] -> Doc
rule pub c xs = p <+> prCat c <+> '=' <+> nest 2 (alts xs) <+> ';'
  where p = if pub then pp "public" else empty

meta :: String -> String -> Doc
meta n v = "meta" <+> show n <+> "is" <+> show v <> ';'

-- Pretty-printing utilities

emptyLine :: Doc
emptyLine = pp ""

--prepunctuate :: Doc -> [Doc] -> [Doc]
prepunctuate _ [] = []
prepunctuate p (x:xs) = x : map (p <>) xs

($++$) :: Doc -> Doc -> Doc
x $++$ y = x $$ emptyLine $$ y

