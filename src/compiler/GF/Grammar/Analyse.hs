module GF.Grammar.Analyse (
        stripSourceGrammar,
        constantDepsTerm
        ) where

import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Infra.Option ---
import GF.Infra.Modules
import GF.Grammar.Macros
import GF.Grammar.Lookup

import GF.Data.Operations

import qualified Data.Map as Map
import Data.List (nub)
import Debug.Trace

stripSourceGrammar :: SourceGrammar -> SourceGrammar
stripSourceGrammar sgr = mGrammar [(i, m{jments = Map.map stripInfo (jments m)}) | (i,m) <- modules sgr]

stripInfo :: Info -> Info
stripInfo i = case i of
  AbsCat _ -> i
  AbsFun mt mi me mb -> AbsFun mt mi Nothing mb
  ResParam mp mt -> ResParam mp Nothing
  ResValue lt -> i ----
  ResOper mt md -> ResOper mt Nothing
  ResOverload is fs -> ResOverload is [(lty, L loc (EInt 0)) | (lty,L loc _) <- fs]
  CncCat mty mte mtf -> CncCat mty Nothing Nothing
  CncFun mict mte mtf -> CncFun mict Nothing Nothing
  AnyInd b f -> i

constantsInTerm :: Term -> [Term]
constantsInTerm = nub . consts where
  consts t = case t of
    Q _  -> [t]
    QC _ -> [t]
    _ -> collectOp consts t

constantDeps :: SourceGrammar -> QIdent -> Err [Term]
constantDeps sgr f = do
  ts <- deps f
  let cs = [i | t <- ts, i <- getId t]
  ds <- mapM deps cs
  return $ nub $ concat $ ts:ds
 where
  deps c = case lookupOverload sgr c of
    Ok tts -> 
      return $ concat [constantsInTerm ty ++ constantsInTerm tr | (_,(ty,tr)) <- tts]
    _ -> do  
      ty <- lookupResType sgr c
      tr <- lookupResDef sgr c
      return $ constantsInTerm ty ++ constantsInTerm tr
  getId t = case t of
    Q i -> [i] 
    QC i -> [i] 
    _ -> [] 

constantDepsTerm :: SourceGrammar -> Term -> Err [Term]
constantDepsTerm sgr t = case t of
  Q  i -> constantDeps sgr i
  QC i -> constantDeps sgr i
  P (Vr r) l -> constantDeps sgr $ (r,label2ident l) ---
  _ -> Bad ("expected qualified constant, not " ++ show t)

