----------------------------------------------------------------------
-- |
-- Module      : AppPredefined
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/02/18 19:21:12 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.9 $
--
-- Predefined function type signatures and definitions.
-----------------------------------------------------------------------------

module AppPredefined (isInPredefined, typPredefined, appPredefined
		     ) where

import Operations
import Grammar
import Ident
import Macros
import PrGrammar (prt,prt_,prtBad)
---- import PGrammar (pTrm)

-- predefined function type signatures and definitions. AR 12/3/2003.

isInPredefined :: Ident -> Bool
isInPredefined = err (const True) (const False) . typPredefined

typPredefined :: Ident -> Err Type
typPredefined c@(IC f) = case f of
  "Int"    -> return typePType
  "Ints"   -> return $ mkFunType [cnPredef "Int"] typePType
  "PBool"  -> return typePType
  "PFalse" -> return $ cnPredef "PBool"
  "PTrue"  -> return $ cnPredef "PBool"
  "dp"     -> return $ mkFunType [cnPredef "Int",typeTok] typeTok
  "drop"   -> return $ mkFunType [cnPredef "Int",typeTok] typeTok
  "eqInt"  -> return $ mkFunType [cnPredef "Int",cnPredef "Int"] (cnPredef "PBool")
  "lessInt"-> return $ mkFunType [cnPredef "Int",cnPredef "Int"] (cnPredef "PBool")
  "eqStr"  -> return $ mkFunType [typeTok,typeTok] (cnPredef "PBool")
  "length" -> return $ mkFunType [typeTok] (cnPredef "Int")
  "occur"  -> return $ mkFunType [typeTok,typeTok] (cnPredef "PBool")
  "plus"   -> return $ mkFunType [cnPredef "Int",cnPredef "Int"] (cnPredef "Int")
----  "read"   -> (P : Type) -> Tok -> P
  "show"   -> return $ mkProd -- (P : PType) -> P -> Tok
    ([(zIdent "P",typePType),(wildIdent,Vr (zIdent "P"))],typeStr,[]) 
  "toStr"  -> return $ mkProd -- (L : Type)  -> L -> Str
    ([(zIdent "L",typeType),(wildIdent,Vr (zIdent "L"))],typeStr,[]) 
  "take"   -> return $ mkFunType [cnPredef "Int",typeTok] typeTok
  "tk"     -> return $ mkFunType [cnPredef "Int",typeTok] typeTok
  _        -> prtBad "unknown in Predef:" c
typPredefined c = prtBad "unknown in Predef:" c

appPredefined :: Term -> Term
appPredefined t = case t of

  App f x -> case f of

    -- one-place functions
    Q (IC "Predef") (IC f) -> case (f, appPredefined x) of
      ("length", K s) -> EInt $ length s
      _ -> t

    -- two-place functions
    App (Q (IC "Predef") (IC f)) z -> case (f, appPredefined z, appPredefined x) of
      ("drop", EInt i, K s) -> K (drop i s)
      ("take", EInt i, K s) -> K (take i s)
      ("tk",   EInt i, K s) -> K (take (max 0 (length s - i)) s)
      ("dp",   EInt i, K s) -> K (drop (max 0 (length s - i)) s)
      ("eqStr",K s,    K t) -> if s == t then predefTrue else predefFalse
      ("occur",K s,    K t) -> if substring s t then predefTrue else predefFalse
      ("eqInt",EInt i, EInt j) -> if i==j then predefTrue else predefFalse
      ("lessInt",EInt i, EInt j) -> if i<j then predefTrue else predefFalse
      ("plus", EInt i, EInt j) -> EInt $ i+j
      ("show", _, t) -> foldr C Empty $ map K $ words $ prt t
      ("read", _, K s) -> str2tag s --- because of K, only works for atomic tags
      ("toStr", _, t) -> trm2str t

      _ -> t
    _ -> t
  _ -> t

-- read makes variables into constants

str2tag :: String -> Term
str2tag s = case s of
----  '\'' : cs -> mkCn $ pTrm $ init cs
  _ -> Cn $ IC s ---
 where
   mkCn t = case t of
     Vr i -> Cn i
     App c a -> App (mkCn c) (mkCn a)
     _ -> t


predefTrue = Q (IC "Predef") (IC "PTrue")
predefFalse = Q (IC "Predef") (IC "PFalse")

substring :: String -> String -> Bool
substring s t = case (s,t) of
  (c:cs, d:ds) -> (c == d && substring cs ds) || substring s ds
  ([],_) -> True
  _ -> False

trm2str :: Term -> Term
trm2str t = case t of
  R ((_,(_,s)):_)   -> trm2str s
  T _ ((_,s):_) -> trm2str s
  TSh _ ((_,s):_) -> trm2str s
  V _ (s:_) -> trm2str s
  C _ _         -> t
  K _           -> t
  Empty         -> t
  _ -> K $ "ERROR_toStr_" ++ prt_ t --- eliminated by type checker

