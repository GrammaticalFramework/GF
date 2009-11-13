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

module GF.Compile.Concrete.AppPredefined (isInPredefined, typPredefined, appPredefined
		     ) where

import GF.Infra.Ident
import GF.Data.Operations
import GF.Grammar.Predef
import GF.Grammar.Grammar
import GF.Grammar.Macros
import GF.Grammar.Printer
import qualified Data.ByteString.Char8 as BS
import Text.PrettyPrint

-- predefined function type signatures and definitions. AR 12/3/2003.

isInPredefined :: Ident -> Bool
isInPredefined = err (const True) (const False) . typPredefined

typPredefined :: Ident -> Err Type
typPredefined f
  | f == cInt       = return typePType
  | f == cFloat     = return typePType
  | f == cErrorType = return typeType
  | f == cInts      = return $ mkFunType [typeInt] typePType
  | f == cPBool     = return typePType
  | f == cError     = return $ mkFunType [typeStr] typeError  -- non-can. of empty set
  | f == cPFalse    = return $ typePBool
  | f == cPTrue     = return $ typePBool
  | f == cDp        = return $ mkFunType [typeInt,typeTok] typeTok
  | f == cDrop      = return $ mkFunType [typeInt,typeTok] typeTok
  | f == cEqInt     = return $ mkFunType [typeInt,typeInt] typePBool
  | f == cLessInt   = return $ mkFunType [typeInt,typeInt] typePBool
  | f == cEqStr     = return $ mkFunType [typeTok,typeTok] typePBool
  | f == cLength    = return $ mkFunType [typeTok] typeInt
  | f == cOccur     = return $ mkFunType [typeTok,typeTok] typePBool
  | f == cOccurs    = return $ mkFunType [typeTok,typeTok] typePBool
  | f == cPlus      = return $ mkFunType [typeInt,typeInt] (typeInt)
----  "read"   -> (P : Type) -> Tok -> P
  | f == cShow      = return $ mkProd -- (P : PType) -> P -> Tok
    [(Explicit,varP,typePType),(Explicit,identW,Vr varP)] typeStr []
  | f == cToStr     = return $ mkProd -- (L : Type)  -> L -> Str
    [(Explicit,varL,typeType),(Explicit,identW,Vr varL)] typeStr []
  | f == cMapStr    = return $ mkProd -- (L : Type)  -> (Str -> Str) -> L -> L
    [(Explicit,varL,typeType),(Explicit,identW,mkFunType [typeStr] typeStr),(Explicit,identW,Vr varL)] (Vr varL) []
  | f == cTake      = return $ mkFunType [typeInt,typeTok] typeTok
  | f == cTk        = return $ mkFunType [typeInt,typeTok] typeTok
  | otherwise       = Bad (render (text "unknown in Predef:" <+> ppIdent f))

varL :: Ident
varL = identC (BS.pack "L")

varP :: Ident
varP = identC (BS.pack "P")

appPredefined :: Term -> Err (Term,Bool)
appPredefined t = case t of
  App f x0 -> do
   (x,_) <- appPredefined x0
   case f of
    -- one-place functions
    Q mod f | mod == cPredef ->
      case x of
        (K s) | f == cLength -> retb $ EInt $ toInteger $ length s
        _                    -> retb t

    -- two-place functions
    App (Q mod f) z0 | mod == cPredef -> do
     (z,_) <- appPredefined z0
     case (norm z, norm x) of
      (EInt i, K s)    | f == cDrop    -> retb $ K (drop (fi i) s)
      (EInt i, K s)    | f == cTake    -> retb $ K (take (fi i) s)
      (EInt i, K s)    | f == cTk      -> retb $ K (take (max 0 (length s - fi i)) s)
      (EInt i, K s)    | f == cDp      -> retb $ K (drop (max 0 (length s - fi i)) s)
      (K s,    K t)    | f == cEqStr   -> retb $ if s == t then predefTrue else predefFalse
      (K s,    K t)    | f == cOccur   -> retb $ if substring s t then predefTrue else predefFalse
      (K s,    K t)    | f == cOccurs  -> retb $ if any (flip elem t) s then predefTrue else predefFalse
      (EInt i, EInt j) | f == cEqInt   -> retb $ if i==j then predefTrue else predefFalse
      (EInt i, EInt j) | f == cLessInt -> retb $ if i<j  then predefTrue else predefFalse
      (EInt i, EInt j) | f == cPlus    -> retb $ EInt $ i+j
      (_,      t)      | f == cShow    -> retb $ foldr C Empty $ map K $ words $ render (ppTerm Unqualified 0 t)
      (_,      K s)    | f == cRead    -> retb $ Cn (identC (BS.pack s)) --- because of K, only works for atomic tags
      (_,      t)      | f == cToStr   -> trm2str t >>= retb
      _ -> retb t ---- prtBad "cannot compute predefined" t

    -- three-place functions
    App (App (Q mod f) z0) y0 | mod == cPredef -> do
     (y,_) <- appPredefined y0
     (z,_) <- appPredefined z0
     case (z, y, x) of
      (ty,op,t) | f == cMapStr -> retf $ mapStr ty op t
      _ -> retb t ---- prtBad "cannot compute predefined" t

    _ -> retb t ---- prtBad "cannot compute predefined" t
  _ -> retb t
                  ---- should really check the absence of arg variables
 where
   retb t = return (retc t,True)  -- no further computing needed
   retf t = return (retc t,False) -- must be computed further
   retc t = case t of
     K [] -> t
     K s  -> foldr1 C (map K (words s))
     _    -> t
   norm t = case t of
     Empty -> K []
     C u v -> case (norm u,norm v) of
       (K x,K y) -> K (x +++ y)
       _ -> t
     _ -> t
   fi = fromInteger

-- read makes variables into constants

predefTrue = QC cPredef cPTrue
predefFalse = QC cPredef cPFalse

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
  C _ _           -> return $ t
  K _             -> return $ t
  S c _           -> trm2str c
  Empty           -> return $ t
  _               -> Bad (render (text "cannot get Str from term" <+> ppTerm Unqualified 0 t))

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
