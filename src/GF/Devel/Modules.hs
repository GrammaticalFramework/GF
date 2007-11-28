module GF.Devel.Modules where

import GF.Devel.Judgements
import GF.Devel.Terms
import GF.Infra.Ident

import GF.Data.Operations

import Control.Monad
import Data.Map


data GF = GF {
  gfabsname   :: Maybe Ident ,
  gfcncnames  :: [Ident] ,
  gflags      :: Map Ident String ,   -- value of a global flag
  gfmodules   :: Map Ident Module
  }

emptyGF :: GF
emptyGF = GF Nothing [] empty empty

data Module = Module {
  mtype       :: ModuleType,
  mof         :: Ident,               -- other for concrete, same for rest
  minterfaces :: [(Ident,Ident)],     -- non-empty for functors 
  mextends    :: [(Ident,MInclude)],
  minstances  :: [(Ident,Ident)],     -- non-empty for instantiations
  mopens      :: [(Ident,Ident)],     -- used name, original name
  mflags      :: Map Ident String,
  mjments     :: Map Ident (Either Judgement Ident)  -- def or indirection
  }

emptyModule :: Ident -> Module
emptyModule m = Module MGrammar m [] [] [] [] empty empty

listJudgements :: Module -> [(Ident,Either Judgement Ident)]
listJudgements = assocs . mjments

data ModuleType =
    MAbstract
  | MConcrete
  | MGrammar 

data MInclude =
    MIAll
  | MIExcept [Ident]
  | MIOnly [Ident]


