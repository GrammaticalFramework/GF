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

module GF.Speech.PrSRGS_ABNF (srgsAbnfPrinter) where

import GF.Conversion.Types
import GF.Data.Utilities
import GF.Formalism.CFG
import GF.Formalism.Utilities (Symbol(..), NameProfile(..), Profile(..), filterCats)
import GF.Infra.Ident
import GF.Infra.Print
import GF.Infra.Option
import GF.Probabilistic.Probabilistic (Probs)
import GF.Speech.SISR
import GF.Speech.SRG
import GF.Speech.RegExp
import GF.Compile.ShellState (StateGrammar)
import GF.Today

import Data.Char
import Data.List
import Text.PrettyPrint.HughesPJ
import Debug.Trace


srgsAbnfPrinter :: Maybe SISRFormat
                -> Bool -- ^ Include probabilities
	        -> Options 
                -> StateGrammar -> String
srgsAbnfPrinter sisr probs opts s = show $ prABNF sisr probs $ makeSimpleSRG opts s

prABNF :: Maybe SISRFormat -> Bool -> SRG -> Doc
prABNF sisr probs srg@(SRG{grammarName=name,grammarLanguage = l,
                     startCat=start,origStartCat=origStart,rules=rs})
    = header $++$ mainCat $++$ vcat topCatRules $++$ foldr ($++$) empty (map prRule rs)
    where
    header = text "#ABNF 1.0 UTF-8;" $$
             meta "description" 
               ("Speech recognition grammar for " ++ name
                ++ ". " ++ "Original start category: " ++ origStart) $$
             meta "generator" ("Grammatical Framework " ++ version) $$
             text "language" <+> text l <> char ';'
    mainCat = text "root" <+> prCat start <> char ';'
    prRule (SRGRule cat origCat rhs) = 
	comment origCat $$
        rule False cat (map prAlt (ebnfSRGAlts rhs))
    -- FIXME: use the probability
    prAlt (EBnfSRGAlt mp n rhs) = sep [initTag, parens (prItem sisr n rhs), finalTag]
      where initTag | isEmpty t = empty
                    | otherwise = text "$NULL" <+>  t
                where t = tag sisr (profileInitSISR n)
            finalTag = tag sisr (profileFinalSISR n)

    topCatRules = [rule True (catFormId tc) (map (it tc) cs) | (tc,cs) <- srgTopCats srg]
        where it i c = prCat c <+> tag sisr (topCatSISR c)

catFormId :: String -> String
catFormId = (++ "_cat")

prCat :: SRGCat -> Doc
prCat c = char '$' <> text c

prItem :: Maybe SISRFormat -> CFTerm -> EBnfSRGItem -> Doc
prItem sisr t = f 1
  where
    f _ (REUnion [])  = text "$VOID"
    f p (REUnion xs) 
        | not (null es) = brackets (f 0 (REUnion nes))
        | otherwise = (if p >= 1 then parens else id) (alts (map (f 1) xs))
      where (es,nes) = partition isEpsilon xs
    f _ (REConcat []) = text "$NULL"
    f p (REConcat xs) = (if p >= 3 then parens else id) (hsep (map (f 2) xs))
    f p (RERepeat x)  = f 3 x <> text "<0->"
    f _ (RESymbol s)  = prSymbol sisr t s


prSymbol :: Maybe SISRFormat -> CFTerm -> Symbol SRGNT Token -> Doc
prSymbol sisr cn (Cat n@(c,_)) = prCat c <+> tag sisr (catSISR cn n)
prSymbol _ cn (Tok t) | all isPunct (prt t) = empty  -- removes punctuation
                      | otherwise = text (prt t) -- FIXME: quote if there is whitespace or odd chars

tag :: Maybe SISRFormat -> (SISRFormat -> SISRTag) -> Doc
tag Nothing _ = empty
tag (Just fmt) t = 
    case t fmt of
      [] -> empty
      -- grr, silly SRGS ABNF does not have an escaping mechanism
      ts | '{' `elem` x || '}' `elem` x -> text "{!{" <+> text x <+> text "}!}"
         | otherwise -> text "{" <+> text x <+> text "}"
         where x = prSISR ts

isPunct :: Char -> Bool
isPunct c = c `elem` "-_.;.,?!"

comment :: String -> Doc
comment s = text "//" <+> text s

alts :: [Doc] -> Doc
alts = sep . prepunctuate (text "| ")

rule :: Bool -> SRGCat -> [Doc] -> Doc
rule pub c xs = sep [p <+> prCat c <+> char '=', nest 2 (alts xs) <+> char ';']
  where p = if pub then text "public" else empty

meta :: String -> String -> Doc
meta n v = text "meta" <+> text (show n) <+> text "is" <+> text (show v)

-- Pretty-printing utilities

emptyLine :: Doc
emptyLine = text ""

prepunctuate :: Doc -> [Doc] -> [Doc]
prepunctuate _ [] = []
prepunctuate p (x:xs) = x : map (p <>) xs

($++$) :: Doc -> Doc -> Doc
x $++$ y = x $$ emptyLine $$ y

