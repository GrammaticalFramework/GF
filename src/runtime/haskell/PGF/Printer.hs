{-# LANGUAGE FlexibleContexts #-}
module PGF.Printer (ppPGF,ppCat,ppFId,ppFunId,ppSeqId,ppSeq,ppFun) where

import PGF.CId
import PGF.Data
import PGF.ByteCode

import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.IntMap as IntMap
import Data.List
import Data.Array.IArray
--import Data.Array.Unboxed
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

ppCat :: CId -> ([Hypo],[(Double,CId)],Double) -> Doc
ppCat c (hyps,_,_) = text "cat" <+> ppCId c <+> hsep (snd (mapAccumL (ppHypo 4) [] hyps)) <+> char ';'

ppFun :: CId -> (Type,Int,Maybe ([Equation],[[Instr]]),Double) -> Doc
ppFun f (t,_,Just (eqs,code),_) = text "fun" <+> ppCId f <+> colon <+> ppType 0 [] t <+> char ';' $$
                                  (if null eqs
                                     then empty
                                     else text "def" <+> vcat [let scope = foldl pattScope [] patts
                                                                   ds    = map (ppPatt 9 scope) patts
                                                               in ppCId f <+> hsep ds <+> char '=' <+> ppExpr 0 scope res <+> char ';' | Equ patts res <- eqs]) $$
                                  ppCode 0 code
ppFun f (t,_,Nothing,_)         = text "data" <+> ppCId f <+> colon <+> ppType 0 [] t <+> char ';'

ppCnc :: Language -> Concr -> Doc
ppCnc name cnc =
  text "concrete" <+> ppCId name <+> char '{' $$
  nest 2 (ppAll ppFlag (cflags cnc) $$
          text "productions" $$
          nest 2 (vcat [ppProduction (fcat,prod) | (fcat,set) <- IntMap.toList (productions cnc), prod <- Set.toList set]) $$
          text "lindefs" $$
          nest 2 (vcat (concatMap ppLinDefs (IntMap.toList (lindefs cnc)))) $$
          text "linrefs" $$
          nest 2 (vcat (concatMap ppLinRefs (IntMap.toList (linrefs cnc)))) $$
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

ppLinDefs (fid,funids) = 
  [ppFId fid <+> text "->" <+> ppFunId funid <> brackets (ppFId fidVar) | funid <- funids]

ppLinRefs (fid,funids) = 
  [ppFId fidVar <+> text "->" <+> ppFunId funid <> brackets (ppFId fid) | funid <- funids]

ppSeq :: (SeqId,Sequence) -> Doc
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
ppSymbol (SymKS t)    = doubleQuotes (text t)
ppSymbol SymNE        = text "nonExist"
ppSymbol SymBIND      = text "BIND"
ppSymbol SymSOFT_BIND = text "SOFT_BIND"
ppSymbol SymSOFT_SPACE= text "SOFT_SPACE"
ppSymbol SymCAPIT     = text "CAPIT"
ppSymbol SymALL_CAPIT = text "ALL_CAPIT"
ppSymbol (SymKP syms alts) = text "pre" <+> braces (hsep (punctuate semi (hsep (map ppSymbol syms) : map ppAlt alts)))

ppAlt (syms,ps) = hsep (map ppSymbol syms) <+> char '/' <+> hsep (map (doubleQuotes . text) ps)

ppStrs ss = doubleQuotes (hsep (map text ss))

ppFId fid
  | fid == fidString = text "CString"
  | fid == fidInt    = text "CInt"
  | fid == fidFloat  = text "CFloat"
  | fid == fidVar    = text "CVar"
  | fid == fidStart  = text "CStart"
  | otherwise        = char 'C' <> int fid

ppFunId funid = char 'F' <> int funid
ppSeqId seqid = char 'S' <> int seqid

-- Utilities

ppAll :: (a -> b -> Doc) -> Map.Map a b -> Doc
ppAll p m = vcat [ p k v | (k,v) <- Map.toList m]
