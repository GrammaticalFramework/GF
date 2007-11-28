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


-- look up fields for a constant in a grammar

lookupJField :: (Judgement -> a) -> GF -> Ident -> Ident -> Err a
lookupJField field gf m c = do
  j <- lookupJudgement gf m c
  return $ field j

lookupJForm :: GF -> Ident -> Ident -> Err JudgementForm
lookupJForm = lookupJField jform

-- the following don't (need to) check that the jment form is adequate
 
lookupCatContext :: GF -> Ident -> Ident -> Err Context
lookupCatContext gf m c = do
  ty <- lookupJField jtype gf m c
  return [] ---- context of ty

lookupFunType :: GF -> Ident -> Ident -> Err Term
lookupFunType = lookupJField jtype 

lookupLin :: GF -> Ident -> Ident -> Err Term
lookupLin = lookupJField jlin

lookupLincat :: GF -> Ident -> Ident -> Err Term
lookupLincat = lookupJField jlin

lookupParamValues :: GF -> Ident -> Ident -> Err [Term]
lookupParamValues gf m c = do
  j <- lookupJudgement gf m c
  case jdef j of
    V _ ts -> return ts
    _ -> raise "no parameter values"

-- infrastructure for lookup
    
lookupIdent :: GF -> Ident -> Ident -> Err (Either Judgement Ident)
lookupIdent gf m c = do
  mo <- maybe (raise "module not found") return $ mlookup m (gfmodules gf)
  maybe (Bad "constant not found") return $ mlookup c (mjments mo)

lookupJudgement :: GF -> Ident -> Ident -> Err Judgement
lookupJudgement gf m c = do
  eji <- lookupIdent gf m c
  either return (\n -> lookupJudgement gf n c) eji 

mlookup = Data.Map.lookup

