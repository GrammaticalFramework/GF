module PGF.Data (module PGF.Data, module PGF.Expr, module PGF.Type) where

import PGF.CId
import PGF.Expr hiding (Value, Env, Tree)
import PGF.Type

import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.IntMap as IntMap
import Data.Array.IArray
import Data.Array.Unboxed
import Data.List


-- internal datatypes for PGF

-- | An abstract data type representing multilingual grammar
-- in Portable Grammar Format.
data PGF = PGF {
  absname   :: CId ,
  cncnames  :: [CId] ,
  gflags    :: Map.Map CId String,   -- value of a global flag
  abstract  :: Abstr ,
  concretes :: Map.Map CId Concr
  }

data Abstr = Abstr {
  aflags  :: Map.Map CId String,      -- value of a flag
  funs    :: Map.Map CId (Type,Int,[Equation]), -- type, arrity and definition of function
  cats    :: Map.Map CId [Hypo],      -- context of a cat
  catfuns :: Map.Map CId [CId]        -- funs to a cat (redundant, for fast lookup)
  }

data Concr = Concr {
  cflags       :: Map.Map CId String,                                -- value of a flag
  printnames   :: Map.Map CId String,                                -- printname of a cat or a fun
  functions    :: Array FunId FFun,
  sequences    :: Array SeqId FSeq,
  productions  :: IntMap.IntMap (Set.Set Production),                -- the original productions loaded from the PGF file
  pproductions :: IntMap.IntMap (Set.Set Production),                -- productions needed for parsing
  lproductions :: Map.Map CId (IntMap.IntMap (Set.Set Production)),  -- productions needed for linearization
  startCats    :: Map.Map CId (FCat,FCat,Array FIndex String),       -- for every category - start/end FCat and a list of label names
  totalCats    :: {-# UNPACK #-} !FCat
  }

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

data Term =
   R [Term]
 | P Term Term
 | S [Term]
 | K Tokn
 | V Int
 | C Int
 | F CId
 | FV [Term]
 | W String Term
 | TM String
  deriving (Eq,Ord,Show)

data Tokn =
   KS String
 | KP [String] [Alternative]
  deriving (Eq,Ord,Show)


-- merge two PGFs; fails is differens absnames; priority to second arg

unionPGF :: PGF -> PGF -> PGF
unionPGF one two = case absname one of
  n | n == wildCId     -> two    -- extending empty grammar
    | n == absname two -> one {  -- extending grammar with same abstract
      concretes = Map.union (concretes two) (concretes one),
      cncnames  = union (cncnames one) (cncnames two)
    }
  _ -> one   -- abstracts don't match ---- print error msg

emptyPGF :: PGF
emptyPGF = PGF {
  absname   = wildCId,
  cncnames  = [] ,
  gflags    = Map.empty,
  abstract  = error "empty grammar, no abstract",
  concretes = Map.empty
  }

-- | This is just a 'CId' with the language name.
-- A language name is the identifier that you write in the 
-- top concrete or abstract module in GF after the 
-- concrete/abstract keyword. Example:
-- 
-- > abstract Lang = ...
-- > concrete LangEng of Lang = ...
type Language     = CId

readLanguage :: String -> Maybe Language
readLanguage = readCId

showLanguage :: Language -> String
showLanguage = showCId

fcatString, fcatInt, fcatFloat, fcatVar :: Int
fcatString = (-1)
fcatInt    = (-2)
fcatFloat  = (-3)
fcatVar    = (-4)

isLiteralFCat :: FCat -> Bool
isLiteralFCat = (`elem` [fcatString, fcatInt, fcatFloat, fcatVar])
