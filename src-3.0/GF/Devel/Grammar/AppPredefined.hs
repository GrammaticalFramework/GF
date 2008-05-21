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

module GF.Devel.Grammar.AppPredefined (
  isInPredefined, 
  typPredefined, 
  appPredefined
  ) where

import GF.Devel.Grammar.Grammar
import GF.Devel.Grammar.Construct
import GF.Devel.Grammar.Macros
import GF.Devel.Grammar.PrGF (prt,prt_,prtBad)
import GF.Infra.Ident

import GF.Data.Operations


-- predefined function type signatures and definitions. AR 12/3/2003.

isInPredefined :: Ident -> Bool
isInPredefined = err (const True) (const False) . typPredefined

typPredefined :: Ident -> Err Type
typPredefined c@(IC f) = case f of
  "Int"    -> return typePType
  "Float"  -> return typePType
  "Error"  -> return typeType
  "Ints"   -> return $ mkFunType [cnPredef "Int"] typePType
  "PBool"  -> return typePType
  "error"  -> return $ mkFunType [typeStr] (cnPredef "Error")  -- non-can. of empty set
  "PFalse" -> return $ cnPredef "PBool"
  "PTrue"  -> return $ cnPredef "PBool"
  "dp"     -> return $ mkFunType [cnPredef "Int",typeStr] typeStr
  "drop"   -> return $ mkFunType [cnPredef "Int",typeStr] typeStr
  "eqInt"  -> return $ mkFunType [cnPredef "Int",cnPredef "Int"] (cnPredef "PBool")
  "lessInt"-> return $ mkFunType [cnPredef "Int",cnPredef "Int"] (cnPredef "PBool")
  "eqStr"  -> return $ mkFunType [typeStr,typeStr] (cnPredef "PBool")
  "length" -> return $ mkFunType [typeStr] (cnPredef "Int")
  "occur"  -> return $ mkFunType [typeStr,typeStr] (cnPredef "PBool")
  "occurs" -> return $ mkFunType [typeStr,typeStr] (cnPredef "PBool")
  "plus"   -> return $ mkFunType [cnPredef "Int",cnPredef "Int"] (cnPredef "Int")
----  "read"   -> (P : Type) -> Tok -> P
  "show"   -> return $ mkProds -- (P : PType) -> P -> Tok
    ([(identC "P",typePType),(identW,Vr (identC "P"))],typeStr,[]) 
  "toStr"  -> return $ mkProds -- (L : Type)  -> L -> Str
    ([(identC "L",typeType),(identW,Vr (identC "L"))],typeStr,[]) 
  "mapStr" -> 
    let ty = identC "L" in
    return $ mkProds -- (L : Type)  -> (Str -> Str) -> L -> L
    ([(ty,typeType),(identW,mkFunType [typeStr] typeStr),(identW,Vr ty)],Vr ty,[]) 
  "take"   -> return $ mkFunType [cnPredef "Int",typeStr] typeStr
  "tk"     -> return $ mkFunType [cnPredef "Int",typeStr] typeStr
  _        -> prtBad "unknown in Predef:" c

typPredefined c = prtBad "unknown in Predef:" c

mkProds (cont,t,xx) = foldr (uncurry Prod) (mkApp t xx) cont

appPredefined :: Term -> Err (Term,Bool)
appPredefined t = case t of

  App f x0 -> do
   (x,_) <- appPredefined x0
   case f of
    -- one-place functions
    Q (IC "Predef") (IC f) -> case (f, x) of
      ("length", K s) -> retb $ EInt $ toInteger $ length s
      _ -> retb t ---- prtBad "cannot compute predefined" t

    -- two-place functions
    App (Q (IC "Predef") (IC f)) z0 -> do
     (z,_) <- appPredefined z0
     case (f, norm z, norm x) of
      ("drop", EInt i, K s) -> retb $ K (drop (fi i) s)
      ("take", EInt i, K s) -> retb $ K (take (fi i) s)
      ("tk",   EInt i, K s) -> retb $ K (take (max 0 (length s - fi i)) s)
      ("dp",   EInt i, K s) -> retb $ K (drop (max 0 (length s - fi i)) s)
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
   fi = fromInteger

-- read makes variables into constants

str2tag :: String -> Term
str2tag s = case s of
----  '\'' : cs -> mkCn $ pTrm $ init cs
  _ -> Con $ IC s ---
 where
   mkCn t = case t of
     Vr i -> Con i
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
  V _ (s:_)       -> trm2str s
  C _ _         -> return $ t
  K _           -> return $ t
  S c _         -> trm2str c
  Empty         -> return $ t
  _ -> prtBad "cannot get Str from term" t

-- simultaneous recursion on type and term: type arg is essential!
-- But simplify the task by assuming records are type-annotated
-- (this has been done in type checking)
mapStr :: Type -> Term -> Term -> Term
mapStr ty f t = case (ty,t) of
  _ | elem ty [typeStr,typeStr] -> App f t
  (_,        R ts)    -> R [(l,mapField v)   | (l,v) <- ts]
  (Table a b,T ti cs) -> T ti [(p,mapStr b f v) | (p,v) <- cs]
  _    -> t 
 where
   mapField (mty,te) = case mty of
     Just ty -> (mty,mapStr ty f te)
     _ -> (mty,te)
