-- | Implementations of predefined functions
{-# LANGUAGE TypeSynonymInstances, FlexibleInstances #-}
module GF.Compile.Compute.Predef(predef,predefName,delta) where

import Text.PrettyPrint(render,hang,text)
import qualified Data.Map as Map
import Data.Array(array,(!))
import Data.List (isInfixOf)
import Data.Char (isUpper,toLower,toUpper)
import Control.Monad(ap)

import GF.Data.Utilities (mapSnd,apBoth)

import GF.Compile.Compute.Value
import GF.Infra.Ident (Ident,varX,showIdent)
import GF.Data.Operations(Err,err)
import GF.Grammar.Predef
import PGF.Data(BindType(..))

--------------------------------------------------------------------------------
class Predef a where
  toValue :: a -> Value
  fromValue :: Value -> Err a

instance Predef Int where
  toValue = VInt
  fromValue (VInt i) = return i
  fromValue v = verror "Int" v

instance Predef Bool where
  toValue = boolV

instance Predef String where
  toValue = string
  fromValue v = case norm v of
                  VString s -> return s
                  _ -> verror "String" v

instance Predef Value where
  toValue = id
  fromValue = return
{-
instance (Predef a,Predef b) => Predef (a->b) where
  toValue f = VAbs Explicit (varX 0) $ Bind $ err bug (toValue . f) . fromValue
-}
verror t v =
  case v of
    VError e -> fail e
    VGen {}  -> fail $ "Expected a static value of type "++t
                       ++", got a dynamic value"
    _ -> fail $ "Expected a value of type "++t++", got "++show v

--------------------------------------------------------------------------------

predef f = maybe undef return (Map.lookup f predefs)
  where
    undef = fail $ "Unimplemented predfined operator: Predef."++showIdent f

predefs :: Map.Map Ident Predefined
predefs = Map.fromList predefList

predefName pre = predefNames ! pre
predefNames = array (minBound,maxBound) (map swap predefList)

predefList =
    [(cDrop,Drop),(cTake,Take),(cTk,Tk),(cDp,Dp),(cEqStr,EqStr),
     (cOccur,Occur),(cOccurs,Occurs),(cToUpper,ToUpper),(cToLower,ToLower),
     (cIsUpper,IsUpper),(cLength,Length),(cPlus,Plus),(cEqInt,EqInt),
     (cLessInt,LessInt),
     -- cShow, cRead, cMapStr, cEqVal
     (cError,Error),
     -- Canonical values:
     (cPBool,PBool),(cPFalse,PFalse),(cPTrue,PTrue),(cInt,Int),(cInts,Ints)]
    --- add more functions!!!

delta f vs =
    case f of
      Drop    -> ap2 (drop::Int->String->String)
      Take    -> ap2 (take::Int->String->String)
      Tk      -> ap2 tk
      Dp      -> ap2 dp
      EqStr   -> ap2 ((==)::String->String->Bool)
      Occur   -> ap2 occur
      Occurs  -> ap2 occurs
      ToUpper -> ap1 (map toUpper)
      ToLower -> ap1 (map toLower)
      IsUpper -> ap1 (all isUpper)
      Length  -> ap1 (length::String->Int)
      Plus    -> ap2 ((+)::Int->Int->Int)
      EqInt   -> ap2 ((==)::Int->Int->Bool)
      LessInt -> ap2 ((<)::Int->Int->Bool)
    {- | Show | Read | ToStr | MapStr | EqVal -}
      Error   -> ap1 VError
      -- Canonical values:
      PBool   -> canonical
      Int     -> canonical
      Ints    -> canonical
      PFalse  -> canonical
      PTrue   -> canonical
  where
    canonical = delay
    delay = return (VApp f vs) -- wrong number of arguments

    ap1 f = case vs of
              [v1] -> (toValue . f) `fmap` fromValue v1
              _ -> delay

    ap2 f = case vs of
             [v1,v2] -> toValue `fmap` (f `fmap` fromValue v1 `ap` fromValue v2)
             _ -> delay

--  unimpl id = bug $ "unimplemented predefined function: "++showIdent id
--  problem id vs = bug $ "unexpected arguments: Predef."++showIdent id++" "++show vs

    tk i s = take (max 0 (length s - i)) s :: String
    dp i s = drop (max 0 (length s - i)) s :: String
    occur s t = isInfixOf (s::String) t
    occurs s t = any (`elem` t) (s::String)

boolV b = VCApp (cPredef,if b then cPTrue else cPFalse) []

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

swap (x,y) = (y,x)

bug msg = ppbug (text msg)
ppbug doc = error $ render $
                    hang (text "Internal error in Compute.Predef:") 4 doc
