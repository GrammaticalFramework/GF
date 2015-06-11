module PGF.Data (module PGF.Data, module PGF.Expr, module PGF.Type) where

import PGF.CId
import PGF.Expr hiding (Value, Sig, Env, Tree, eval, apply, applyValue, value2expr)
import PGF.ByteCode
import PGF.Type

import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.IntMap as IntMap
import qualified Data.IntSet as IntSet
import qualified PGF.TrieMap as TMap
import Data.Array.IArray
import Data.Array.Unboxed
--import Data.List


-- internal datatypes for PGF

-- | An abstract data type representing multilingual grammar
-- in Portable Grammar Format.
data PGF = PGF {
  gflags    :: Map.Map CId Literal,   -- value of a global flag
  absname   :: CId ,
  abstract  :: Abstr ,
  concretes :: Map.Map CId Concr
  }

data Abstr = Abstr {
  aflags  :: Map.Map CId Literal,                            -- ^ value of a flag
  funs    :: Map.Map CId (Type,Int,Maybe ([Equation],[[Instr]]),Double),-- ^ type, arrity and definition of function + probability
  cats    :: Map.Map CId ([Hypo],[(Double, CId)],Double)                -- ^ 1. context of a category
                                                                        --   2. functions of a category. The functions are stored
                                                                        --      in decreasing probability order.
                                                                        --   3. probability
  }

data Concr = Concr {
  cflags       :: Map.Map CId Literal,                               -- value of a flag
  printnames   :: Map.Map CId String,                                -- printname of a cat or a fun
  cncfuns      :: Array FunId CncFun,
  lindefs      :: IntMap.IntMap [FunId],
  linrefs      :: IntMap.IntMap [FunId],
  sequences    :: Array SeqId Sequence,
  productions  :: IntMap.IntMap (Set.Set Production),                -- the original productions loaded from the PGF file
  pproductions :: IntMap.IntMap (Set.Set Production),                -- productions needed for parsing
  lproductions :: Map.Map CId (IntMap.IntMap (Set.Set Production)),  -- productions needed for linearization
  cnccats      :: Map.Map CId CncCat,
  lexicon      :: IntMap.IntMap (IntMap.IntMap (TMap.TrieMap Token IntSet.IntSet)),
  totalCats    :: {-# UNPACK #-} !FId
  }

type Token  = String
type FId    = Int
type LIndex = Int
type DotPos = Int
data Symbol
  = SymCat {-# UNPACK #-} !Int {-# UNPACK #-} !LIndex
  | SymLit {-# UNPACK #-} !Int {-# UNPACK #-} !LIndex
  | SymVar {-# UNPACK #-} !Int {-# UNPACK #-} !Int
  | SymKS Token
  | SymKP [Symbol] [([Symbol],[String])]
  | SymBIND                         -- the special BIND token
  | SymSOFT_BIND                    -- the special SOFT_BIND token
  | SymSOFT_SPACE                   -- the special SOFT_SPACE token
  | SymCAPIT                        -- the special CAPIT token
  | SymALL_CAPIT                    -- the special ALL_CAPIT token
  | SymNE                           -- non exist (this should be last constructor to simplify the binary search in the runtime)
  deriving (Eq,Ord,Show)
data Production
  = PApply  {-# UNPACK #-} !FunId [PArg]
  | PCoerce {-# UNPACK #-} !FId
  | PConst  CId Expr [Token]
  deriving (Eq,Ord,Show)
data PArg = PArg [(FId,FId)] {-# UNPACK #-} !FId deriving (Eq,Ord,Show)
data CncCat = CncCat {-# UNPACK #-} !FId {-# UNPACK #-} !FId {-# UNPACK #-} !(Array LIndex String)
data CncFun = CncFun CId {-# UNPACK #-} !(UArray LIndex SeqId) deriving (Eq,Ord,Show)
type Sequence = Array DotPos Symbol
type FunId = Int
type SeqId = Int

-- merge two PGFs; fails if different abstract names; priority to second arg

unionPGF :: PGF -> PGF -> PGF
unionPGF one two = fst $ msgUnionPGF one two

msgUnionPGF :: PGF -> PGF -> (PGF, Maybe String)
msgUnionPGF one two = case absname one of
  n | n == wildCId     -> (two, Nothing)    -- extending empty grammar
    | n == absname two && haveSameFunsPGF one two -> (one { -- extending grammar with same abstract
      concretes = Map.union (concretes two) (concretes one)
    }, Nothing)
  _ -> (two, -- abstracts don't match, discard the old one  -- error msg in Importing.ioUnionPGF
        Just "Abstract changed, previous concretes discarded.")

emptyPGF :: PGF
emptyPGF = PGF {
  gflags    = Map.empty,
  absname   = wildCId,
  abstract  = error "empty grammar, no abstract",
  concretes = Map.empty
  }

-- sameness of function type signatures, checked when importing a new concrete in env
haveSameFunsPGF :: PGF -> PGF -> Bool
haveSameFunsPGF one two = 
  let 
    fsone = [(f,t) | (f,(t,_,_,_)) <- Map.toList (funs (abstract one))]
    fstwo = [(f,t) | (f,(t,_,_,_)) <- Map.toList (funs (abstract two))]
  in fsone == fstwo

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

fidString, fidInt, fidFloat, fidVar :: FId
fidString = (-1)
fidInt    = (-2)
fidFloat  = (-3)
fidVar    = (-4)

isPredefFId :: FId -> Bool
isPredefFId = (`elem` [fidString, fidInt, fidFloat, fidVar])
