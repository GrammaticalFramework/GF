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

module GF.Compile.Compute.AppPredefined (
          isInPredefined, typPredefined, arrityPredefined, predefModInfo, appPredefined
		  ) where

import GF.Infra.Ident
import GF.Infra.Option
import GF.Data.Operations
import GF.Grammar
import GF.Grammar.Predef

import qualified Data.Map as Map
import qualified Data.ByteString.Char8 as BS
import Text.PrettyPrint
import Data.Char (isUpper,toUpper,toLower)

-- predefined function type signatures and definitions. AR 12/3/2003.

isInPredefined :: Ident -> Bool
isInPredefined f = Map.member f primitives

typPredefined :: Ident -> Maybe Type
typPredefined f = case Map.lookup f primitives of
                    Just (ResOper (Just (L _ ty)) _) -> Just ty
                    Just (ResParam _ _)              -> Just typePType
                    Just (ResValue (L _ ty))         -> Just ty
                    _                                -> Nothing

arrityPredefined :: Ident -> Maybe Int
arrityPredefined f = do ty <- typPredefined f
                        let (ctxt,_) = typeFormCnc ty
                        return (length ctxt)

predefModInfo :: SourceModInfo
predefModInfo = ModInfo MTResource MSComplete noOptions [] Nothing [] [] "Predef.gf" Nothing primitives

primitives = Map.fromList
  [ (cErrorType, ResOper (Just (noLoc typeType)) Nothing)
  , (cInt      , ResOper (Just (noLoc typePType)) Nothing)
  , (cFloat    , ResOper (Just (noLoc typePType)) Nothing)
  , (cInts     , fun [typeInt] typePType)
  , (cPBool    , ResParam (Just (noLoc [(cPTrue,[]),(cPFalse,[])])) (Just [QC (cPredef,cPTrue), QC (cPredef,cPFalse)]))
  , (cPTrue    , ResValue (noLoc typePBool))
  , (cPFalse   , ResValue (noLoc typePBool))
  , (cError    , fun [typeStr] typeError)  -- non-can. of empty set
  , (cLength   , fun [typeTok] typeInt)
  , (cDrop     , fun [typeInt,typeTok] typeTok)
  , (cTake     , fun [typeInt,typeTok] typeTok)
  , (cTk       , fun [typeInt,typeTok] typeTok)
  , (cDp       , fun [typeInt,typeTok] typeTok)
  , (cEqInt    , fun [typeInt,typeInt] typePBool)
  , (cLessInt  , fun [typeInt,typeInt] typePBool)
  , (cPlus     , fun [typeInt,typeInt] typeInt)
  , (cEqStr    , fun [typeTok,typeTok] typePBool)
  , (cOccur    , fun [typeTok,typeTok] typePBool)
  , (cOccurs   , fun [typeTok,typeTok] typePBool)

  , (cToUpper  , fun [typeTok] typeTok)
  , (cToLower  , fun [typeTok] typeTok)
  , (cIsUpper  , fun [typeTok] typePBool)

----  "read"   -> 
  , (cRead     , ResOper (Just (noLoc (mkProd -- (P : Type) -> Tok -> P
                                         [(Explicit,varP,typePType),(Explicit,identW,typeStr)] (Vr varP) []))) Nothing)
  , (cShow     , ResOper (Just (noLoc (mkProd -- (P : PType) -> P -> Tok
                                         [(Explicit,varP,typePType),(Explicit,identW,Vr varP)] typeStr []))) Nothing)
  , (cEqVal    , ResOper (Just (noLoc (mkProd -- (P : PType) -> P -> P -> PBool
                                         [(Explicit,varP,typePType),(Explicit,identW,Vr varP),(Explicit,identW,Vr varP)] typePBool []))) Nothing)
  , (cToStr    , ResOper (Just (noLoc (mkProd -- (L : Type)  -> L -> Str
                                         [(Explicit,varL,typeType),(Explicit,identW,Vr varL)] typeStr []))) Nothing)
  , (cMapStr   , ResOper (Just (noLoc (mkProd -- (L : Type)  -> (Str -> Str) -> L -> L
                                         [(Explicit,varL,typeType),(Explicit,identW,mkFunType [typeStr] typeStr),(Explicit,identW,Vr varL)] (Vr varL) []))) Nothing)
  ]
  where
    fun from to = oper (mkFunType from to)
    oper ty     = ResOper (Just (noLoc ty)) Nothing

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
    Q (mod,f) | mod == cPredef ->
      case x of
        (K s) | f == cLength  -> retb $ EInt $ length s
        (K s) | f == cIsUpper -> retb $ if (all isUpper s) then predefTrue else predefFalse
        (K s) | f == cToUpper -> retb $ K $ map toUpper s
        (K s) | f == cToLower -> retb $ K $ map toLower s
        (K s) | f == cError   -> retb $ Error s

        _                    -> retb t

    -- two-place functions
    App (Q (mod,f)) z0 | mod == cPredef -> do
     (z,_) <- appPredefined z0
     case (norm z, norm x) of
      (EInt i, K s)    | f == cDrop    -> retb $ K (drop i s)
      (EInt i, K s)    | f == cTake    -> retb $ K (take i s)
      (EInt i, K s)    | f == cTk      -> retb $ K (take (max 0 (length s - i)) s)
      (EInt i, K s)    | f == cDp      -> retb $ K (drop (max 0 (length s - i)) s)
      (K s,    K t)    | f == cEqStr   -> retb $ if s == t then predefTrue else predefFalse
      (K s,    K t)    | f == cOccur   -> retb $ if substring s t then predefTrue else predefFalse
      (K s,    K t)    | f == cOccurs  -> retb $ if any (flip elem t) s then predefTrue else predefFalse
      (EInt i, EInt j) | f == cEqInt   -> retb $ if i==j then predefTrue else predefFalse
      (EInt i, EInt j) | f == cLessInt -> retb $ if i<j  then predefTrue else predefFalse
      (EInt i, EInt j) | f == cPlus    -> retb $ EInt $ i+j
      (_,      t)      | f == cShow  && notVar t  -> retb $ foldrC $ map K $ words $ render (ppTerm Unqualified 0 t)
      (_,      K s)    | f == cRead    -> retb $ Cn (identC (BS.pack s)) --- because of K, only works for atomic tags
      (_,      t)      | f == cToStr   -> trm2str t >>= retb
      _ -> retb t ---- prtBad "cannot compute predefined" t

    -- three-place functions
    App (App (Q (mod,f)) z0) y0 | mod == cPredef -> do
     (y,_) <- appPredefined y0
     (z,_) <- appPredefined z0
     case (z, y, x) of
       (ty,op,t) | f == cMapStr -> retf $ mapStr ty op t
       _ | f == cEqVal && notVar y && notVar x -> retb $ if y==x then predefTrue else predefFalse
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
   notVar t = case t of
     Vr _ -> False
     App f a -> notVar f && notVar a
     _ -> True ---- would need to check that t is a value
   foldrC ts = if null ts then Empty else foldr1 C ts

-- read makes variables into constants

predefTrue = QC (cPredef,cPTrue)
predefFalse = QC (cPredef,cPFalse)

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
