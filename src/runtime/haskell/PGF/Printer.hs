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
ppFlag flag value = text "flag" <+> ppCId flag <+> char '=' <+> ppLit value <+> char ';'

ppCat :: CId -> ([Hypo],[(Double,CId)]) -> Doc
ppCat c (hyps,_) = text "cat" <+> ppCId c <+> hsep (snd (mapAccumL (ppHypo 4) [] hyps)) <+> char ';'

ppFun :: CId -> (Type,Int,Maybe [Equation],Double) -> Doc
ppFun f (t,_,Just eqs,_) = text "fun" <+> ppCId f <+> colon <+> ppType 0 [] t <+> char ';' $$
                           if null eqs
                             then empty
                             else text "def" <+> vcat [let scope = foldl pattScope [] patts
                                                           ds    = map (ppPatt 9 scope) patts
                                                       in ppCId f <+> hsep ds <+> char '=' <+> ppExpr 0 scope res <+> char ';' | Equ patts res <- eqs]
ppFun f (t,_,Nothing,_)  = text "data" <+> ppCId f <+> colon <+> ppType 0 [] t <+> char ';'

ppCnc :: Language -> Concr -> Doc
ppCnc name cnc =
  text "concrete" <+> ppCId name <+> char '{' $$
  nest 2 (ppAll ppFlag (cflags cnc) $$
          text "productions" $$
          nest 2 (vcat [ppProduction (fcat,prod) | (fcat,set) <- IntMap.toList (productions cnc), prod <- Set.toList set]) $$
          text "lindefs" $$
          nest 2 (vcat (map ppLinDef (IntMap.toList (lindefs cnc)))) $$
          text "lin" $$
          nest 2 (vcat (map ppCncFun (assocs (cncfuns cnc)))) $$
          text "sequences" $$
          nest 2 (vcat (map ppSeq (assocs (sequences cnc)))) $$
          text "categories" $$
          nest 2 (vcat (map ppCncCat (Map.toList (cnccats cnc)))) $$
          text "printnames" $$
          nest 2 (vcat (map ppPrintName (Map.toList (printnames cnc))))) $$
  char '}'

ppCncArg :: PArg -> Doc
ppCncArg (PArg hyps fid)
  | null hyps = ppFId fid
  | otherwise = hsep (map (ppFId . snd) hyps) <+> text "->" <+> ppFId fid

ppProduction (fid,PApply funid args) =
  ppFId fid <+> text "->" <+> ppFunId funid <> brackets (hcat (punctuate comma (map ppCncArg args)))
ppProduction (fid,PCoerce arg) =
  ppFId fid <+> text "->" <+> char '_' <> brackets (ppFId arg)
ppProduction (fid,PConst _ _ ss) =
  ppFId fid <+> text "->" <+> ppStrs ss

ppCncFun (funid,CncFun fun arr) =
  ppFunId funid <+> text ":=" <+> parens (hcat (punctuate comma (map ppSeqId (elems arr)))) <+> brackets (ppCId fun)

ppLinDef (fid,funids) = 
  ppFId fid <+> text "->" <+> hcat (punctuate comma (map ppFunId funids))

ppSeq (seqid,seq) = 
  ppSeqId seqid <+> text ":=" <+> hsep (map ppSymbol (elems seq))

ppCncCat (id,(CncCat start end labels)) =
  ppCId id <+> text ":=" <+> (text "range " <+> brackets (ppFId start <+> text ".." <+> ppFId end) $$
                              text "labels" <+> brackets (vcat (map (text . show) (elems labels))))

ppPrintName (id,name) =
  ppCId id <+> text ":=" <+> ppStrs [name]

ppSymbol (SymCat d r) = char '<' <> int d <> comma <> int r <> char '>'
ppSymbol (SymLit d r) = char '{' <> int d <> comma <> int r <> char '}'
ppSymbol (SymVar d r) = char '<' <> int d <> comma <> char '$' <> int r <> char '>'
ppSymbol (SymKS ts)   = ppStrs ts
ppSymbol (SymKP ts alts) = text "pre" <+> braces (hsep (punctuate semi (ppStrs ts : map ppAlt alts)))

ppAlt (Alt ts ps) = ppStrs ts <+> char '/' <+> hsep (map (doubleQuotes . text) ps)

ppStrs ss = doubleQuotes (hsep (map text ss))

ppFId fid
  | fid == fidString = text "CString"
  | fid == fidInt    = text "CInt"
  | fid == fidFloat  = text "CFloat"
  | fid == fidVar    = text "CVar"
  | otherwise        = char 'C' <> int fid

ppFunId funid = char 'F' <> int funid
ppSeqId seqid = char 'S' <> int seqid

-- Utilities

ppAll :: (a -> b -> Doc) -> Map.Map a b -> Doc
ppAll p m = vcat [ p k v | (k,v) <- Map.toList m]
