module GF.Compile.Coding where

import GF.Grammar.Grammar
import GF.Grammar.Macros
import GF.Text.UTF8
import GF.Text.CP1251
import GF.Infra.Modules
import GF.Infra.Option
import GF.Data.Operations

import Data.Char

encodeStringsInModule :: SourceModule -> SourceModule
encodeStringsInModule = codeSourceModule encodeUTF8

decodeStringsInModule :: SourceModule -> SourceModule
decodeStringsInModule mo = case mo of
  (_,ModMod m) -> case moduleFlag optEncoding (moduleOptions (flags m)) of
    UTF_8   -> codeSourceModule decodeUTF8 mo
    CP_1251 -> codeSourceModule decodeCP1251 mo
    _ -> mo
  _ -> mo

codeSourceModule :: (String -> String) -> SourceModule ->  SourceModule
codeSourceModule co (id,moi) = case moi of
  ModMod mo -> (id, ModMod $ replaceJudgements mo (mapTree codj (jments mo)))
  _ -> (id,moi)
 where
    codj (c,info) = (c, case info of
      ResOper     pty pt  -> ResOper (mapP codt pty) (mapP codt pt) 
      ResOverload es tyts -> ResOverload es [(codt ty,codt t) | (ty,t) <- tyts]
      CncCat pty pt mpr   -> CncCat pty (mapP codt pt) (mapP codt mpr)
      CncFun mty pt mpr   -> CncFun mty (mapP codt pt) (mapP codt mpr)
      _ -> info
      )
    codt t = case t of
      K s -> K (co s)
      T ty cs -> T ty [(codp p,codt v) | (p,v) <- cs]
      _ -> composSafeOp codt t
    codp p = case p of  --- really: composOpPatt
      PR rs -> PR [(l,codp p) | (l,p) <- rs]
      PString s -> PString (co s)
      PChars s -> PChars (co s)
      PT x p -> PT x (codp p)
      PAs x p -> PAs x (codp p)
      PNeg p -> PNeg (codp p)
      PRep p -> PRep (codp p)
      PSeq p q -> PSeq (codp p) (codp q)
      PAlt p q -> PAlt (codp p) (codp q)
      _ -> p
