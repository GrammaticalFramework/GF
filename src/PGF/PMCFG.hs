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
  | FSymTok Tokn
  deriving (Eq,Ord,Show)
type Profile = [Int]
data Production
  = FApply  {-# UNPACK #-} !FunId [FCat]
  | FCoerce {-# UNPACK #-} !FCat
  | FConst  Tree String
  deriving (Eq,Ord,Show)
data FFun  = FFun CId [Profile] {-# UNPACK #-} !(UArray FIndex SeqId) deriving (Eq,Ord,Show)
type FSeq  = Array FPointPos FSymbol
type FunId = Int
type SeqId = Int

data Tokn =
   KS String
 | KP [String] [Alternative]
  deriving (Eq,Ord,Show)

data Alternative =
   Alt [String] [String]
  deriving (Eq,Ord,Show)

data ParserInfo
    = ParserInfo { functions   :: Array FunId FFun
                 , sequences   :: Array SeqId FSeq
	         , productions :: IntMap.IntMap (Set.Set Production)
	         , startCats   :: Map.Map CId [FCat]
	         , totalCats   :: {-# UNPACK #-} !FCat
	         }


fcatString, fcatInt, fcatFloat, fcatVar :: Int
fcatString = (-1)
fcatInt    = (-2)
fcatFloat  = (-3)
fcatVar    = (-4)


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
ppProduction (fcat,FConst _ s) =
  ppFCat fcat <+> text "->" <+> text (show s)

ppFun (funid,FFun fun _ arr) =
  ppFunId funid <+> text ":=" <+> parens (hcat (punctuate comma (map ppSeqId (elems arr)))) <+> brackets (text (prCId fun))

ppSeq (seqid,seq) = 
  ppSeqId seqid <+> text ":=" <+> hsep (map ppSymbol (elems seq))

ppStartCat (id,fcats) =
  text (prCId id) <+> text ":=" <+> brackets (hcat (punctuate comma (map ppFCat fcats)))

ppSymbol (FSymCat d r) = char '<' <> int d <> comma <> int r <> char '>'
ppSymbol (FSymLit d r) = char '<' <> int d <> comma <> int r <> char '>'
ppSymbol (FSymTok (KS t))   = text (show t)

ppFCat  fcat  = char 'C' <> int fcat
ppFunId funid = char 'F' <> int funid
ppSeqId seqid = char 'S' <> int seqid
