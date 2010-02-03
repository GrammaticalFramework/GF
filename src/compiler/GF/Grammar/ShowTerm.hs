module GF.Grammar.ShowTerm where

import GF.Grammar.Grammar
import GF.Grammar.Printer
import GF.Grammar.Lookup
import GF.Data.Operations

import Text.PrettyPrint
import Data.List  (intersperse)

showTerm :: SourceGrammar -> TermPrintStyle -> TermPrintQual -> Term -> String
showTerm gr style q t = render $
  case style of
    TermPrintTable   -> vcat [p <+> s | (p,s) <- ppTermTabular gr q t]
    TermPrintAll     -> vcat [      s | (p,s) <- ppTermTabular gr q t]
    TermPrintDefault -> ppTerm q 0 t

ppTermTabular :: SourceGrammar -> TermPrintQual -> Term -> [(Doc,Doc)]
ppTermTabular gr q = pr where
  pr t = case t of
    R rs   -> 
      [(ppLabel lab       <+> char '.'  <+> path, str) | (lab,(_,val)) <- rs, (path,str) <- pr val]
    T _ cs -> 
      [(ppPatt q 0 patt     <+> text "=>" <+> path, str) | (patt,  val ) <- cs, (path,str) <- pr val]
    V ty cs -> 
      let pvals = case allParamValues gr ty of
                    Ok pvals -> pvals
                    Bad _    -> map Meta [1..]
      in [(ppTerm q 0 pval <+> text "=>" <+> path, str) | (pval, val) <- zip pvals cs, (path,str) <- pr val]
    _      -> [(empty,ps t)]
  ps t = case t of
    K s   -> text s
    C s u -> ps s <+> ps u
    FV ts -> hsep (intersperse (char '/') (map ps ts))
    _     -> ppTerm q 0 t

data TermPrintStyle
  = TermPrintTable
  | TermPrintAll
  | TermPrintDefault
