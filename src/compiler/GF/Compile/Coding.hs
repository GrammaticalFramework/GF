module GF.Compile.Coding where

import GF.Grammar.Grammar
import GF.Grammar.Macros
import GF.Text.Coding
import GF.Infra.Modules
import GF.Infra.Option
import GF.Data.Operations

import Data.Char

encodeStringsInModule :: SourceModule -> SourceModule
encodeStringsInModule = codeSourceModule (encodeUnicode UTF_8)

decodeStringsInModule :: SourceModule -> SourceModule
decodeStringsInModule mo = codeSourceModule (decodeUnicode (flag optEncoding (flagsModule mo))) mo

codeSourceModule :: (String -> String) -> SourceModule -> SourceModule
codeSourceModule co (id,mo) = (id,replaceJudgements mo (mapTree codj (jments mo)))
 where
    codj (c,info) = case info of
      ResOper     pty pt  -> ResOper (fmap (codeTerm co) pty) (fmap (codeTerm co) pt) 
      ResOverload es tyts -> ResOverload es [(codeTerm co ty,codeTerm co t) | (ty,t) <- tyts]
      CncCat pty pt mpr   -> CncCat pty (fmap (codeTerm co) pt) (fmap (codeTerm co) mpr)
      CncFun mty pt mpr   -> CncFun mty (fmap (codeTerm co) pt) (fmap (codeTerm co) mpr)
      _ -> info

codeTerm :: (String -> String) -> L Term -> L Term
codeTerm co (L loc t) = L loc (codt t)
  where
    codt t = case t of
      K s -> K (co s)
      T ty cs -> T ty [(codp p,codt v) | (p,v) <- cs]
      EPatt p -> EPatt (codp p)
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

-- | Run an encoding function on all string literals within the given string.
codeStringLiterals :: (String -> String) -> String -> String
codeStringLiterals _ [] = []
codeStringLiterals co ('"':cs) = '"' : inStringLiteral cs
  where inStringLiteral [] = error "codeStringLiterals: unterminated string literal"
        inStringLiteral ('"':ds) = '"' : codeStringLiterals co ds
        inStringLiteral ('\\':d:ds) = '\\' : co [d] ++ inStringLiteral ds
        inStringLiteral (d:ds) = co [d] ++ inStringLiteral ds
codeStringLiterals co (c:cs) = c : codeStringLiterals co cs
