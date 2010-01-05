module PGF.PMCFG where

import PGF.CId
import PGF.Expr

import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.IntMap as IntMap
import Data.Array.IArray
import Data.Array.Unboxed
import Text.PrettyPrint

type FCat      = Int
type FIndex    = Int
type FPointPos = Int
data FSymbol
  = FSymCat {-# UNPACK #-} !Int {-# UNPACK #-} !FIndex
  | FSymLit {-# UNPACK #-} !Int {-# UNPACK #-} !FIndex
  | FSymKS [String]
  | FSymKP [String] [Alternative]
  deriving (Eq,Ord,Show)
data Production
  = FApply  {-# UNPACK #-} !FunId [FCat]
  | FCoerce {-# UNPACK #-} !FCat
  | FConst  Expr [String]
  deriving (Eq,Ord,Show)
data FFun  = FFun CId {-# UNPACK #-} !(UArray FIndex SeqId) deriving (Eq,Ord,Show)
type FSeq  = Array FPointPos FSymbol
type FunId = Int
type SeqId = Int

data Alternative =
   Alt [String] [String]
  deriving (Eq,Ord,Show)

data ParserInfo
    = ParserInfo { functions   :: Array FunId FFun
                 , sequences   :: Array SeqId FSeq
                 , productions0:: IntMap.IntMap (Set.Set Production)    -- this are the original productions as they are loaded from the PGF file
                 , productions :: IntMap.IntMap (Set.Set Production)    -- this are the productions after the filtering for useless productions
                 , startCats   :: Map.Map CId (FCat,FCat,Array FIndex String)  -- for every category - start/end FCat and a list of label names
                 , totalCats   :: {-# UNPACK #-} !FCat
                 }


fcatString, fcatInt, fcatFloat, fcatVar :: Int
fcatString = (-1)
fcatInt    = (-2)
fcatFloat  = (-3)
fcatVar    = (-4)

isLiteralFCat :: FCat -> Bool
isLiteralFCat = (`elem` [fcatString, fcatInt, fcatFloat, fcatVar])

ppPMCFG :: ParserInfo -> Doc
ppPMCFG pinfo =
  text "productions" $$
  nest 2 (vcat [ppProduction (fcat,prod) | (fcat,set) <- IntMap.toList (productions pinfo), prod <- Set.toList set]) $$
  text "functions" $$
  nest 2 (vcat (map ppFun (assocs (functions pinfo)))) $$
  text "sequences" $$
  nest 2 (vcat (map ppSeq (assocs (sequences pinfo)))) $$
  text "startcats" $$
  nest 2 (vcat (map ppStartCat (Map.toList (startCats pinfo))))

ppProduction (fcat,FApply funid args) =
  ppFCat fcat <+> text "->" <+> ppFunId funid <> brackets (hcat (punctuate comma (map ppFCat args)))
ppProduction (fcat,FCoerce arg) =
  ppFCat fcat <+> text "->" <+> char '_' <> brackets (ppFCat arg)
ppProduction (fcat,FConst _ ss) =
  ppFCat fcat <+> text "->" <+> ppStrs ss

ppFun (funid,FFun fun arr) =
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


filterProductions = closure
  where
    closure prods0
      | IntMap.size prods == IntMap.size prods0 = prods
      | otherwise                               = closure prods
      where
        prods = IntMap.mapMaybe (filterProdSet prods0) prods0

    filterProdSet prods set0
      | Set.null set = Nothing
      | otherwise    = Just set
      where
        set = Set.filter (filterRule prods) set0
                             
    filterRule prods (FApply funid args) = all (\fcat -> isLiteralFCat fcat || IntMap.member fcat prods) args
    filterRule prods (FCoerce fcat)      = isLiteralFCat fcat || IntMap.member fcat prods
    filterRule prods _                   = True
