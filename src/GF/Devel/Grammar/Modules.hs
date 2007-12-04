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
  mjments     :: MapJudgement 
  }

emptyModule :: Ident -> Module
emptyModule m = Module MTGrammar [] [] [] [] empty empty

type MapJudgement = Map Ident JEntry -- def or indirection

isCompleteModule :: Module -> Bool
isCompleteModule = Prelude.null . minterfaces 

listJudgements :: Module -> [(Ident,JEntry)]
listJudgements = assocs . mjments

type JEntry = Either Judgement Indirection

data ModuleType =
    MTAbstract
  | MTConcrete Ident
  | MTGrammar 
  deriving Eq

data MInclude =
    MIAll
  | MIExcept [Ident]
  | MIOnly [Ident]

type Indirection = (Ident,Bool) -- module of origin, whether canonical

isConstructorEntry :: Either Judgement Indirection -> Bool
isConstructorEntry ji = case ji of
  Left j -> isConstructor j
  Right i -> snd i

isConstructor :: Judgement -> Bool
isConstructor j = jdef j == EData

isInherited :: MInclude -> Ident -> Bool
isInherited mi i = case mi of
  MIExcept is -> notElem i is
  MIOnly is -> elem i is
  _ -> True


