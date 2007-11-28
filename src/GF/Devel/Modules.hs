module GF.Devel.Modules where

import GF.Grammar.Grammar
import GF.Infra.Ident

import GF.Data.Operations

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

data Judgement = Judgement {
  jform :: JudgementForm,  -- cat         fun        oper    param
  jtype :: Type,           -- context     type       type    type
  jdef  :: Term,           -- lindef      def        -       values
  jlin  :: Term,           -- lincat      lin        def     constructors
  jprintname :: Term       -- printname   printname  -       -
  }

data JudgementForm =
    JCat
  | JFun
  | JOper
  | JParam

lookupIdent :: GF -> Ident -> Ident -> Err (Either Judgement Ident)
lookupIdent gf m c = do
  mo <- maybe (Bad "module not found") return $ mlookup m (gfmodules gf)
  maybe (Bad "constant not found") return $ mlookup c (mjments mo)

lookupJudgement :: GF -> Ident -> Ident -> Err Judgement
lookupJudgement gf m c = do
  eji <- lookupIdent gf m c
  either return (\n -> lookupJudgement gf n c) eji 

mlookup = Data.Map.lookup

