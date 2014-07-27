module GF.Grammar.ShowTerm where

import GF.Grammar.Grammar
import GF.Grammar.Printer
import GF.Grammar.Lookup
import GF.Data.Operations

import GF.Text.Pretty
import Data.List  (intersperse)

showTerm :: SourceGrammar -> TermPrintStyle -> TermPrintQual -> Term -> String
showTerm gr sty q t = case sty of
    TermPrintTable -> render $ vcat [p <+> s | (p,s) <- ppTermTabular gr q t]
    TermPrintAll   -> render $ vcat [      s | (p,s) <- ppTermTabular gr q t]
    TermPrintList  -> renderStyle (style{mode = OneLineMode}) $ 
      vcat (punctuate ',' [s | (p,s) <- ppTermTabular gr q t])
    TermPrintOne   -> render $ vcat [      s | (p,s) <- take 1 (ppTermTabular gr q t)]
    TermPrintDefault -> render $ ppTerm q 0 t

ppTermTabular :: SourceGrammar -> TermPrintQual -> Term -> [(Doc,Doc)]
ppTermTabular gr q = pr where
  pr t = case t of
    R rs   -> 
      [(lab       <+> '.' <+> path, str) | (lab,(_,val)) <- rs, (path,str) <- pr val]
    T _ cs -> 
      [(ppPatt q 0 patt     <+> "=>" <+> path, str) | (patt,  val ) <- cs, (path,str) <- pr val]
    V ty cs -> 
      let pvals = case allParamValues gr ty of
                    Ok pvals -> pvals
                    Bad _    -> map Meta [1..]
      in [(ppTerm q 0 pval <+> "=>" <+> path, str) | (pval, val) <- zip pvals cs, (path,str) <- pr val]
    _      -> [(empty,ps t)]
  ps t = case t of
    K s   -> pp s
    C s u -> ps s <+> ps u
    FV ts -> hsep (intersperse (pp '/') (map ps ts))
    _     -> ppTerm q 0 t

data TermPrintStyle
  = TermPrintTable
  | TermPrintAll
  | TermPrintList
  | TermPrintOne
  | TermPrintDefault
