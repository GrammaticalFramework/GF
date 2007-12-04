module GF.Devel.Grammar.Modules where

import GF.Devel.Grammar.Judgements
import GF.Devel.Grammar.Terms
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

type SourceModule = (Ident,Module)

listModules :: GF -> [SourceModule]
listModules = assocs.gfmodules

addModule :: Ident -> Module -> GF -> GF
addModule c m gf = gf {gfmodules = insert c m (gfmodules gf)}

data Module = Module {
  mtype       :: ModuleType,
  minterfaces :: [(Ident,Ident)],           -- non-empty for functors 
  minstances  :: [((Ident,MInclude),[(Ident,Ident)])], -- non-empty for instant'ions
  mextends    :: [(Ident,MInclude)],
  mopens      :: [(Ident,Ident)],           -- used name, original name
  mflags      :: Map Ident String,
  mjments     :: Map Ident (Either Judgement Indirection) -- def or indirection
  }

emptyModule :: Ident -> Module
emptyModule m = Module MTGrammar [] [] [] [] empty empty

isCompleteModule :: Module -> Bool
isCompleteModule = Prelude.null . minterfaces 

listJudgements :: Module -> [(Ident,Either Judgement Indirection)]
listJudgements = assocs . mjments

data ModuleType =
    MTAbstract
  | MTConcrete Ident
  | MTGrammar 

data MInclude =
    MIAll
  | MIExcept [Ident]
  | MIOnly [Ident]

type Indirection = (Ident,Bool) -- module of origin, whether canonical

