module GF.Devel.Grammar.Lookup where

import GF.Devel.Grammar.Modules
import GF.Devel.Grammar.Judgements
import GF.Devel.Grammar.Macros
import GF.Devel.Grammar.Terms
import GF.Infra.Ident

import GF.Data.Operations

import Data.Map

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
  return $ contextOfType ty

lookupFunType :: GF -> Ident -> Ident -> Err Term
lookupFunType = lookupJField jtype 

lookupLin :: GF -> Ident -> Ident -> Err Term
lookupLin = lookupJField jdef

lookupLincat :: GF -> Ident -> Ident -> Err Term
lookupLincat = lookupJField jtype

lookupOperType :: GF -> Ident -> Ident -> Err Term
lookupOperType = lookupJField jtype 

lookupOperDef :: GF -> Ident -> Ident -> Err Term
lookupOperDef = lookupJField jdef

lookupParams :: GF -> Ident -> Ident -> Err [(Ident,Context)]
lookupParams gf m c = do
  ty <- lookupJField jtype gf m c
  return [(k,contextOfType t) | (k,t) <- contextOfType ty]

lookupParamConstructor :: GF -> Ident -> Ident -> Err Type
lookupParamConstructor = lookupJField jtype

lookupParamValues :: GF -> Ident -> Ident -> Err [Term]
lookupParamValues gf m c = do
  d <- lookupJField jdef gf m c
  case d of
    V _ ts -> return ts
    _ -> raise "no parameter values"

-- infrastructure for lookup
    
lookupModule :: GF -> Ident -> Err Module
lookupModule gf m = do
  maybe (raiseIdent "module not found:" m) return $ mlookup m (gfmodules gf)

lookupIdent :: GF -> Ident -> Ident -> Err JEntry
lookupIdent gf m c = do
  mo <- lookupModule gf m
  maybe (raiseIdent "constant not found" c) return $ mlookup c (mjments mo)

lookupJudgement :: GF -> Ident -> Ident -> Err Judgement
lookupJudgement gf m c = do
  eji <- lookupIdent gf m c
  either return (\n -> lookupJudgement gf (fst n) c) eji 

mlookup = Data.Map.lookup

raiseIdent msg i = raise (msg +++ prIdent i)


