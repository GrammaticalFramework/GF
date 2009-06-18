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
type Profile = [Int]
data Production
  = FApply  {-# UNPACK #-} !FunId [FCat]
  | FCoerce {-# UNPACK #-} !FCat
  | FConst  Tree [String]
  deriving (Eq,Ord,Show)
data FFun  = FFun CId [Profile] {-# UNPACK #-} !(UArray FIndex SeqId) deriving (Eq,Ord,Show)
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
	         , startCats   :: Map.Map CId [FCat]
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
  nest 2 (vcat [ppProduction (fcat,prod) | (fcat,set) <- IntMap.toList (productions0 pinfo), prod <- Set.toList set]) $$
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

ppFun (funid,FFun fun _ arr) =
  ppFunId funid <+> text ":=" <+> parens (hcat (punctuate comma (map ppSeqId (elems arr)))) <+> brackets (text (prCId fun))

ppSeq (seqid,seq) = 
  ppSeqId seqid <+> text ":=" <+> hsep (map ppSymbol (elems seq))

ppStartCat (id,fcats) =
  text (prCId id) <+> text ":=" <+> brackets (hcat (punctuate comma (map ppFCat fcats)))

ppSymbol (FSymCat d r) = char '<' <> int d <> comma <> int r <> char '>'
ppSymbol (FSymLit d r) = char '<' <> int d <> comma <> int r <> char '>'
ppSymbol (FSymKS ts)   = ppStrs ts
ppSymbol (FSymKP ts alts) = text "pre" <+> braces (hsep (punctuate semi (ppStrs ts : map ppAlt alts)))

ppAlt (Alt ts ps) = ppStrs ts <+> char '/' <+> hsep (map (doubleQuotes . text) ps)

ppStrs ss = doubleQuotes (hsep (map text ss))

ppFCat  fcat
  | fcat == fcatString = text "String"
  | fcat == fcatInt    = text "Int"
  | fcat == fcatFloat  = text "Float"
  | fcat == fcatVar    = text "Var"
  | otherwise          = char 'C' <> int fcat

ppFunId funid = char 'F' <> int funid
ppSeqId seqid = char 'S' <> int seqid


filterProductions prods =
  fmap (Set.filter filterRule) prods
  where
    filterRule (FApply funid args) = all (\fcat -> isLiteralFCat fcat || IntMap.member fcat prods) args
    filterRule (FCoerce _)         = True
    filterRule _                   = True
