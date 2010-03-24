module PGF.Printer (ppPGF,ppCat,ppFun) where

import PGF.CId
import PGF.Data
import PGF.Macros

import GF.Data.Operations

import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.IntMap as IntMap
import Data.List
import Data.Array.IArray
import Data.Array.Unboxed
import Text.PrettyPrint


ppPGF :: PGF -> Doc
ppPGF pgf = ppAbs (absname pgf) (abstract pgf) $$ ppAll ppCnc (concretes pgf)

ppAbs :: Language -> Abstr -> Doc
ppAbs name a = text "abstract" <+> ppCId name <+> char '{' $$
               nest 2 (ppAll ppFlag (aflags a) $$
                       ppAll ppCat (cats a) $$
                       ppAll ppFun (funs a)) $$
               char '}'

ppFlag :: CId -> Literal -> Doc
ppFlag flag value = text "flag" <+> ppCId flag <+> char '=' <+> ppLit value ;

ppCat :: CId -> ([Hypo],[CId]) -> Doc
ppCat c (hyps,_) = text "cat" <+> ppCId c <+> hsep (snd (mapAccumL (ppHypo 4) [] hyps))

ppFun :: CId -> (Type,Int,Maybe [Equation]) -> Doc
ppFun f (t,_,Just eqs) = text "fun" <+> ppCId f <+> colon <+> ppType 0 [] t $$
                         if null eqs
                           then empty
                           else text "def" <+> vcat [let scope = foldl pattScope [] patts
                                                         ds    = map (ppPatt 9 scope) patts
                                                     in ppCId f <+> hsep ds <+> char '=' <+> ppExpr 0 scope res | Equ patts res <- eqs]
ppFun f (t,_,Nothing)  = text "data" <+> ppCId f <+> colon <+> ppType 0 [] t

ppCnc :: Language -> Concr -> Doc
ppCnc name cnc =
  text "concrete" <+> ppCId name <+> char '{' $$
  nest 2 (ppAll ppFlag (cflags cnc) $$
          text "productions" $$
          nest 2 (vcat [ppProduction (fcat,prod) | (fcat,set) <- IntMap.toList (productions cnc), prod <- Set.toList set]) $$
          text "functions" $$
          nest 2 (vcat (map ppCncFun (assocs (cncfuns cnc)))) $$
          text "sequences" $$
          nest 2 (vcat (map ppSeq (assocs (sequences cnc)))) $$
          text "categories" $$
          nest 2 (vcat (map ppCncCat (Map.toList (cnccats cnc))))) $$
  char '}'

ppProduction (fcat,PApply funid args) =
  ppFCat fcat <+> text "->" <+> ppFunId funid <> brackets (hcat (punctuate comma (map ppFCat args)))
ppProduction (fcat,PCoerce arg) =
  ppFCat fcat <+> text "->" <+> char '_' <> brackets (ppFCat arg)
ppProduction (fcat,PConst _ ss) =
  ppFCat fcat <+> text "->" <+> ppStrs ss

ppCncFun (funid,CncFun fun arr) =
  ppFunId funid <+> text ":=" <+> parens (hcat (punctuate comma (map ppSeqId (elems arr)))) <+> brackets (ppCId fun)

ppSeq (seqid,seq) = 
  ppSeqId seqid <+> text ":=" <+> hsep (map ppSymbol (elems seq))

ppCncCat (id,(CncCat start end labels)) =
  ppCId id <+> text ":=" <+> (text "range " <+> brackets (ppFCat start <+> text ".." <+> ppFCat end) $$
                              text "labels" <+> brackets (vcat (map (text . show) (elems labels))))

ppSymbol (SymCat d r) = char '<' <> int d <> comma <> int r <> char '>'
ppSymbol (SymLit d r) = char '<' <> int d <> comma <> int r <> char '>'
ppSymbol (SymKS ts)   = ppStrs ts
ppSymbol (SymKP ts alts) = text "pre" <+> braces (hsep (punctuate semi (ppStrs ts : map ppAlt alts)))

ppAlt (Alt ts ps) = ppStrs ts <+> char '/' <+> hsep (map (doubleQuotes . text) ps)

ppStrs ss = doubleQuotes (hsep (map text ss))

ppFCat  fcat
  | fcat == fcatString = text "CString"
  | fcat == fcatInt    = text "CInt"
  | fcat == fcatFloat  = text "CFloat"
  | fcat == fcatVar    = text "CVar"
  | otherwise          = char 'C' <> int fcat

ppFunId funid = char 'F' <> int funid
ppSeqId seqid = char 'S' <> int seqid

-- Utilities

ppAll :: (a -> b -> Doc) -> Map.Map a b -> Doc
ppAll p m = vcat [ p k v | (k,v) <- Map.toList m]
