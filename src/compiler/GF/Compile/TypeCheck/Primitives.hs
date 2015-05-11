module GF.Compile.TypeCheck.Primitives where

import GF.Grammar
import GF.Grammar.Predef
import qualified Data.Map as Map

typPredefined :: Ident -> Maybe Type
typPredefined f = case Map.lookup f primitives of
                    Just (ResOper (Just (L _ ty)) _) -> Just ty
                    Just (ResParam _ _)              -> Just typePType
                    Just (ResValue (L _ ty))         -> Just ty
                    _                                -> Nothing

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
  , (cNonExist , ResOper (Just (noLoc (mkProd -- Str
                                         [] typeStr []))) Nothing)
  , (cBIND     , ResOper (Just (noLoc (mkProd -- Str
                                         [] typeStr []))) Nothing)
  , (cSOFT_BIND, ResOper (Just (noLoc (mkProd -- Str
                                         [] typeStr []))) Nothing)
  , (cSOFT_SPACE,ResOper (Just (noLoc (mkProd -- Str
                                         [] typeStr []))) Nothing)
  , (cCAPIT    , ResOper (Just (noLoc (mkProd -- Str
                                         [] typeStr []))) Nothing)
  , (cALL_CAPIT, ResOper (Just (noLoc (mkProd -- Str
                                         [] typeStr []))) Nothing)
  ]
  where
    fun from to = oper (mkFunType from to)
    oper ty     = ResOper (Just (noLoc ty)) Nothing

    varL = identS "L"
    varP = identS "P"
