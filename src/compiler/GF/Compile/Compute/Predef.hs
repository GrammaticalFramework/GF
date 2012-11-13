-- | Implementations of predefined functions
module GF.Compile.Compute.Predef where

import Text.PrettyPrint(render,hang,text)
import qualified Data.Map as Map
import Data.List (isInfixOf)
import Data.Char (isUpper,toLower,toUpper)

import GF.Data.Utilities (mapSnd,apBoth)

import GF.Compile.Compute.Value
import GF.Infra.Ident (Ident)
import GF.Grammar.Predef

predefs :: Map.Map Ident ([Value]->Value)
predefs = Map.fromList $ mapSnd strictf
    [(cDrop,apISS drop),(cTake,apISS take),(cTk,apISS tk),(cDp,apISS dp),
     (cEqStr,apSSB (==)),(cOccur,apSSB occur),(cOccurs,apSSB occurs),
     (cToUpper,apSS (map toUpper)),(cToLower,apSS (map toLower)),
     (cIsUpper,apSB (all isUpper)),(cLength,apSS' (VInt . length)),
     (cPlus,apIII (+)),(cEqInt,apIIB (==)),(cLessInt,apIIB (<)),
     (cShow,unimpl),(cRead,unimpl),(cToStr,unimpl),(cMapStr,unimpl),
     (cEqVal,unimpl),(cError,apSS' VError)]
    --- add more functions!!!
  where
    unimpl = bug "unimplemented predefined function"

    tk i s = take (max 0 (length s - i)) s
    dp i s = drop (max 0 (length s - i)) s
    occur s t = isInfixOf s t
    occurs s t = any (`elem` t) s

    apIII f vs = case vs of
                   [VInt i1, VInt i2] -> VInt (f i1 i2)
                   _ -> bug $ "f::Int->Int->Int got "++show vs

    apIIB f vs = case vs of
                   [VInt i1, VInt i2] -> boolV (f i1 i2)
                   _ -> bug $ "f::Int->Int->Bool got "++show vs

    apISS f vs = case vs of
                   [VInt i, VString s] -> string (f i s)
                   _ -> bug $ "f::Int->Str->Str got "++show vs

    apSSB f vs = case vs of
                   [VString s1, VString s2] -> boolV (f s1 s2)
                   _ -> bug $ "f::Str->Str->Bool got "++show vs

    apSB  f vs = case vs of
                   [VString s] -> boolV (f s)
                   _ -> bug $ "f::Str->Bool got "++show vs

    apSS  f vs = case vs of
                   [VString s] -> string (f s)
                   _ -> bug $ "f::Str->Str got "++show vs

    apSS' f vs = case vs of
                   [VString s] -> f s
                   _ -> bug $ "f::Str->_ got "++show vs

    boolV b = VCApp (cPredef,if b then cPTrue else cPFalse) []

    strictf f vs = case normvs vs of
                     Left err -> VError err
                     Right vs -> f vs

    normvs = mapM (strict . norm)

    norm v =
      case v of
        VC v1 v2 -> case apBoth norm (v1,v2) of
                      (VString s1,VString s2) -> VString (s1++" "++s2)
                      (v1,v2) -> VC v1 v2
        _ -> v

    strict v = case v of
                 VError err -> Left err
                 _ -> Right v

    string s = case words s of
                 [] -> VString ""
                 ss -> foldr1 VC (map VString ss)

---

bug msg = ppbug (text msg)
ppbug doc = error $ render $
                    hang (text "Internal error in Compute.Predef:") 4 doc
