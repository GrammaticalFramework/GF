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
               nest 2 (ppAll ppCat (cats a) $$
                       ppAll ppFun (funs a)) $$
               char '}'

ppCat :: CId -> [Hypo] -> Doc
ppCat c hyps = text "cat" <+> ppCId c <+> hsep (snd (mapAccumL ppHypo [] hyps))

ppFun :: CId -> (Type,Int,[Equation]) -> Doc
ppFun f (t,_,eqs) = text "fun" <+> ppCId f <+> colon <+> ppType 0 [] t $$
                    if null eqs
                      then empty
                      else text "def" <+> vcat [let (scope,ds) = mapAccumL (ppPatt 9) [] patts
                                                in ppCId f <+> hsep ds <+> char '=' <+> ppExpr 0 scope res | Equ patts res <- eqs]

ppCnc :: Language -> Concr -> Doc
ppCnc name cnc =
  text "concrete" <+> ppCId name <+> char '{' $$
  nest 2 (text "productions" $$
          nest 2 (vcat [ppProduction (fcat,prod) | (fcat,set) <- IntMap.toList (productions cnc), prod <- Set.toList set]) $$
          text "functions" $$
          nest 2 (vcat (map ppFFun (assocs (functions cnc)))) $$
          text "sequences" $$
          nest 2 (vcat (map ppSeq (assocs (sequences cnc)))) $$
          text "startcats" $$
          nest 2 (vcat (map ppStartCat (Map.toList (startCats cnc))))) $$
  char '}'

ppProduction (fcat,FApply funid args) =
  ppFCat fcat <+> text "->" <+> ppFunId funid <> brackets (hcat (punctuate comma (map ppFCat args)))
ppProduction (fcat,FCoerce arg) =
  ppFCat fcat <+> text "->" <+> char '_' <> brackets (ppFCat arg)
ppProduction (fcat,FConst _ ss) =
  ppFCat fcat <+> text "->" <+> ppStrs ss

ppFFun (funid,FFun fun arr) =
  ppFunId funid <+> text ":=" <+> parens (hcat (punctuate comma (map ppSeqId (elems arr)))) <+> brackets (ppCId fun)

ppSeq (seqid,seq) = 
  ppSeqId seqid <+> text ":=" <+> hsep (map ppSymbol (elems seq))

ppStartCat (id,(start,end,labels)) =
  ppCId id <+> text ":=" <+> (text "range " <+> brackets (ppFCat start <+> text ".." <+> ppFCat end) $$
                              text "labels" <+> brackets (vcat (map (text . show) (elems labels))))

ppSymbol (FSymCat d r) = char '<' <> int d <> comma <> int r <> char '>'
ppSymbol (FSymLit d r) = char '<' <> int d <> comma <> int r <> char '>'
ppSymbol (FSymKS ts)   = ppStrs ts
ppSymbol (FSymKP ts alts) = text "pre" <+> braces (hsep (punctuate semi (ppStrs ts : map ppAlt alts)))

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
