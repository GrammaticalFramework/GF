module GF.Devel.Modules where

import GF.Grammar.Grammar
import GF.Infra.Ident

import Data.Map


data GF = GF {
  gfabsname   :: Maybe Ident ,
  gfcncnames  :: [Ident] ,
  gflags      :: Map Ident String ,   -- value of a global flag
  gfmodules   :: Map Ident Module
  }

data Module = Module {
  mtype       :: ModuleType,
  minterfaces :: [(Ident,Ident)],  -- non-empty for functors 
  mextends    :: [(Ident,MInclude)],
  mopens      :: [(Ident,Ident)],    -- used name, original name
  mflags      :: Map Ident String,
  mjments     :: Map Ident (Either Judgement Ident)  -- def or indirection
  }

data ModuleType =
    MAbstract
  | MConcrete Ident
  | MGrammar 

data Judgement = Judgement {
  jform :: JudgementForm,
  jtype :: Type,
  jdef  :: Term,
  jprintname :: Term
  }

data JudgementForm =
    JCat
  | JFun
  | JOper
  | JParam

