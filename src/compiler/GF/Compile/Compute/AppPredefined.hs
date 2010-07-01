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
import GF.Infra.Modules
import GF.Infra.Option
import GF.Data.Operations
import GF.Grammar
import GF.Grammar.Predef

import qualified Data.Map as Map
import qualified Data.ByteString.Char8 as BS
import Text.PrettyPrint

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
predefModInfo = ModInfo MTResource MSComplete noOptions [] Nothing [] [] primitives

primitives = Map.fromList
  [ (cErrorType, ResOper (Just (noLoc typeType)) Nothing)
  , (cInt      , ResOper (Just (noLoc typePType)) Nothing)
  , (cFloat    , ResOper (Just (noLoc typePType)) Nothing)
  , (cInts     , ResOper (Just (noLoc (mkFunType [typeInt] typePType))) Nothing)
  , (cPBool    , ResParam (Just [noLoc (cPTrue,[]),noLoc (cPFalse,[])]) (Just [QC (cPredef,cPTrue), QC (cPredef,cPFalse)]))
  , (cPTrue    , ResValue (noLoc typePBool))
  , (cPFalse   , ResValue (noLoc typePBool))
  , (cError    , ResOper (Just (noLoc (mkFunType [typeStr] typeError))) Nothing)  -- non-can. of empty set
  , (cLength   , ResOper (Just (noLoc (mkFunType [typeTok] typeInt))) Nothing)
  , (cDrop     , ResOper (Just (noLoc (mkFunType [typeInt,typeTok] typeTok))) Nothing)
  , (cTake     , ResOper (Just (noLoc (mkFunType [typeInt,typeTok] typeTok))) Nothing)
  , (cTk       , ResOper (Just (noLoc (mkFunType [typeInt,typeTok] typeTok))) Nothing)
  , (cDp       , ResOper (Just (noLoc (mkFunType [typeInt,typeTok] typeTok))) Nothing)
  , (cEqInt    , ResOper (Just (noLoc (mkFunType [typeInt,typeInt] typePBool))) Nothing)
  , (cLessInt  , ResOper (Just (noLoc (mkFunType [typeInt,typeInt] typePBool))) Nothing)
  , (cPlus     , ResOper (Just (noLoc (mkFunType [typeInt,typeInt] typeInt))) Nothing)
  , (cEqStr    , ResOper (Just (noLoc (mkFunType [typeTok,typeTok] typePBool))) Nothing)
  , (cOccur    , ResOper (Just (noLoc (mkFunType [typeTok,typeTok] typePBool))) Nothing)
  , (cOccurs   , ResOper (Just (noLoc (mkFunType [typeTok,typeTok] typePBool))) Nothing)
----  "read"   -> 
  , (cRead     , ResOper (Just (noLoc (mkProd -- (P : Type) -> Tok -> P
                                         [(Explicit,varP,typePType),(Explicit,identW,typeStr)] (Vr varP) []))) Nothing)
  , (cShow     , ResOper (Just (noLoc (mkProd -- (P : PType) -> P -> Tok
                                         [(Explicit,varP,typePType),(Explicit,identW,Vr varP)] typeStr []))) Nothing)
  , (cToStr    , ResOper (Just (noLoc (mkProd -- (L : Type)  -> L -> Str
                                         [(Explicit,varL,typeType),(Explicit,identW,Vr varL)] typeStr []))) Nothing)
  , (cMapStr   , ResOper (Just (noLoc (mkProd -- (L : Type)  -> (Str -> Str) -> L -> L
                                         [(Explicit,varL,typeType),(Explicit,identW,mkFunType [typeStr] typeStr),(Explicit,identW,Vr varL)] (Vr varL) []))) Nothing)
  ]
  where
    noLoc = L (0,0)

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
        (K s) | f == cLength -> retb $ EInt $ length s
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
      (_,      t)      | f == cShow    -> retb $ foldr C Empty $ map K $ words $ render (ppTerm Unqualified 0 t)
      (_,      K s)    | f == cRead    -> retb $ Cn (identC (BS.pack s)) --- because of K, only works for atomic tags
      (_,      t)      | f == cToStr   -> trm2str t >>= retb
      _ -> retb t ---- prtBad "cannot compute predefined" t

    -- three-place functions
    App (App (Q (mod,f)) z0) y0 | mod == cPredef -> do
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
