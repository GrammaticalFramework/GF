----------------------------------------------------------------------
-- |
-- Module      : AppPredefined
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/10/06 14:21:34 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.13 $
--
-- Predefined function type signatures and definitions.
-----------------------------------------------------------------------------

module GF.Grammar.AppPredefined (isInPredefined, typPredefined, appPredefined
		     ) where

import GF.Data.Operations
import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Grammar.Macros
import GF.Grammar.PrGrammar (prt,prt_,prtBad)
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
  "occurs" -> return $ mkFunType [typeTok,typeTok] (cnPredef "PBool")
  "plus"   -> return $ mkFunType [cnPredef "Int",cnPredef "Int"] (cnPredef "Int")
----  "read"   -> (P : Type) -> Tok -> P
  "show"   -> return $ mkProd -- (P : PType) -> P -> Tok
    ([(zIdent "P",typePType),(wildIdent,Vr (zIdent "P"))],typeStr,[]) 
  "toStr"  -> return $ mkProd -- (L : Type)  -> L -> Str
    ([(zIdent "L",typeType),(wildIdent,Vr (zIdent "L"))],typeStr,[]) 
  "mapStr" -> 
    let ty = zIdent "L" in
    return $ mkProd -- (L : Type)  -> (Str -> Str) -> L -> L
    ([(ty,typeType),(wildIdent,mkFunType [typeStr] typeStr),(wildIdent,Vr ty)],Vr ty,[]) 
  "take"   -> return $ mkFunType [cnPredef "Int",typeTok] typeTok
  "tk"     -> return $ mkFunType [cnPredef "Int",typeTok] typeTok
  _        -> prtBad "unknown in Predef:" c
typPredefined c = prtBad "unknown in Predef:" c

appPredefined :: Term -> Err (Term,Bool)
appPredefined t = case t of

  App f x0 -> do
   (x,_) <- appPredefined x0
   case f of
    -- one-place functions
    Q (IC "Predef") (IC f) -> case (f, x) of
      ("length", K s) -> retb $ EInt $ length s
      _ -> retb t ---- prtBad "cannot compute predefined" t

    -- two-place functions
    App (Q (IC "Predef") (IC f)) z0 -> do
     (z,_) <- appPredefined z0
     case (f, norm z, norm x) of
      ("drop", EInt i, K s) -> retb $ K (drop i s)
      ("take", EInt i, K s) -> retb $ K (take i s)
      ("tk",   EInt i, K s) -> retb $ K (take (max 0 (length s - i)) s)
      ("dp",   EInt i, K s) -> retb $ K (drop (max 0 (length s - i)) s)
      ("eqStr",K s,    K t) -> retb $ if s == t then predefTrue else predefFalse
      ("occur",K s,    K t) -> retb $ if substring s t then predefTrue else predefFalse
      ("occurs",K s,   K t) -> retb $ if any (flip elem t) s then predefTrue else predefFalse
      ("eqInt",EInt i, EInt j) -> retb $ if i==j then predefTrue else predefFalse
      ("lessInt",EInt i, EInt j) -> retb $ if i<j then predefTrue else predefFalse
      ("plus", EInt i, EInt j) -> retb $ EInt $ i+j
      ("show", _, t) -> retb $ foldr C Empty $ map K $ words $ prt t
      ("read", _, K s) -> retb $ str2tag s --- because of K, only works for atomic tags
      ("toStr", _, t) -> trm2str t >>= retb

      _ -> retb t ---- prtBad "cannot compute predefined" t

    -- three-place functions
    App (App (Q (IC "Predef") (IC f)) z0) y0 -> do
     (y,_) <- appPredefined y0
     (z,_) <- appPredefined z0
     case (f, z, y, x) of
      ("mapStr",ty,op,t) -> retf $ mapStr ty op t
      _ -> retb t ---- prtBad "cannot compute predefined" t

    _ -> retb t ---- prtBad "cannot compute predefined" t
  _ -> retb t
                  ---- should really check the absence of arg variables
 where
   retb t = return (t,True)  -- no further computing needed
   retf t = return (t,False) -- must be computed further
   norm t = case t of
     Empty -> K []
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

trm2str :: Term -> Err Term
trm2str t = case t of
  R ((_,(_,s)):_) -> trm2str s
  T _ ((_,s):_)   -> trm2str s
  TSh _ ((_,s):_) -> trm2str s
  V _ (s:_)       -> trm2str s
  C _ _         -> return $ t
  K _           -> return $ t
  Empty         -> return $ t
  _ -> prtBad "cannot get Str from term" t

-- simultaneous recursion on type and term: type arg is essential!
-- But simplify the task by assuming records are type-annotated
-- (this has been done in type checking)
mapStr :: Type -> Term -> Term -> Term
mapStr ty f t = case (ty,t) of
  _ | elem ty [typeStr,typeTok] -> App f t
  (_,        R ts)    -> R [(l,mapField v)   | (l,v) <- ts]
  (Table a b,T ti cs) -> T ti [(p,mapStr b f v) | (p,v) <- cs]
  _    -> t 
 where
   mapField (mty,te) = case mty of
     Just ty -> (mty,mapStr ty f te)
     _ -> (mty,te)
