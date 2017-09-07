module PGF.Internal(CId(..),Language,PGF(..),
                    PGF2.Concr,lookConcr,
                    FId,isPredefFId,
                    FunId,LIndex,Token,Production(..),PArg(..),
                    CncCat(..),CncFun(..),Symbol(..),DotPos,
                    concrTotalCats, concrCategories, concrProductions,
                    concrTotalFuns, concrFunction,
                    concrTotalSeqs, concrSequence) where

import qualified PGF2
import qualified Data.Map as Map
import Data.Array.IArray
import Data.Array.Unboxed

newtype CId = CId String deriving (Show,Read,Eq,Ord)

type Language = CId
data PGF = PGF PGF2.PGF (Map.Map String PGF2.Concr)

lookConcr (PGF _ langs) (CId lang) =
  case Map.lookup lang langs of
    Just cnc -> cnc
    Nothing  -> error "Unknown language"

type Token = String
type FId = Int
type LIndex = Int
type DotPos = Int
data Symbol
  = SymCat {-# UNPACK #-} !Int {-# UNPACK #-} !LIndex
  | SymLit {-# UNPACK #-} !Int {-# UNPACK #-} !LIndex
  | SymVar {-# UNPACK #-} !Int {-# UNPACK #-} !Int
  | SymKS Token
  | SymKP [Symbol] [([Symbol],[String])]
  | SymBIND                         -- the special BIND token
  | SymNE                           -- non exist
  | SymSOFT_BIND                    -- the special SOFT_BIND token
  | SymSOFT_SPACE                   -- the special SOFT_SPACE token
  | SymCAPIT                        -- the special CAPIT token
  | SymALL_CAPIT                    -- the special ALL_CAPIT token
  deriving (Eq,Ord,Show)
data Production
  = PApply  {-# UNPACK #-} !FunId [PArg]
  | PCoerce {-# UNPACK #-} !FId
  deriving (Eq,Ord,Show)
data PArg = PArg [(FId,FId)] {-# UNPACK #-} !FId deriving (Eq,Ord,Show)
data CncCat = CncCat {-# UNPACK #-} !FId {-# UNPACK #-} !FId {-# UNPACK #-} !(Array LIndex String)
data CncFun = CncFun CId {-# UNPACK #-} !(UArray LIndex SeqId) deriving (Eq,Ord,Show)
type FunId = Int
type SeqId = Int

concrTotalCats :: PGF2.Concr -> FId
concrTotalCats = error "concrTotalCats is not implemented"

concrCategories :: PGF2.Concr -> [(CId,CncCat)]
concrCategories = error "concrCats is not implemented"

concrProductions :: PGF2.Concr -> FId -> [Production]
concrProductions = error "concrProductions is not implemented"

concrTotalFuns :: PGF2.Concr -> FunId
concrTotalFuns = error "concrTotalFuns is not implemented"

concrFunction :: PGF2.Concr -> FunId -> CncFun
concrFunction = error "concrFunction is not implemented"

concrTotalSeqs :: PGF2.Concr -> SeqId
concrTotalSeqs = error "concrTotalSeqs is not implemented"

concrSequence :: PGF2.Concr -> SeqId -> [Symbol]
concrSequence = error "concrSequence is not implemented"

isPredefFId :: FId -> Bool
isPredefFId = error "isPredefFId is not implemented"
