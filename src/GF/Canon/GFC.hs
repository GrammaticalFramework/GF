module GFC where

import AbsGFC
import PrintGFC
import qualified Abstract as A

import Ident
import Option
import Zipper
import Operations
import qualified Modules as M

import Char

-- canonical GF. AR 10/9/2002 -- 9/5/2003 -- 21/9

type Context = [(Ident,Exp)]

type CanonGrammar = M.MGrammar Ident Flag Info

type CanonModInfo = M.ModInfo Ident Flag Info

type CanonModule = (Ident, CanonModInfo)

type CanonAbs = M.Module Ident Option Info

data Info = 
   AbsCat  A.Context [A.Fun]
 | AbsFun  A.Type A.Term
 | AbsTrans A.Term

 | ResPar  [ParDef]
 | ResOper CType Term     -- global constant
 | CncCat  CType Term Printname
 | CncFun  CIdent [ArgVar] Term Printname
 | AnyInd Bool Ident
  deriving (Show)

type Printname = Term

-- some printing ----

{-
prCanonModInfo :: (Ident,CanonModInfo) -> String
prCanonModInfo = printTree . info2mod

prGrammar :: CanonGrammar -> String
prGrammar = printTree . grammar2canon
-}

{-
-- apply a function to all concrete terms in a grammar
mapConcreteTerms :: (Term -> Term) -> CanonGrammar -> CanonGrammar
mapConcreteTerms f (M.MGrammar xs) = M.MGrammar $ map (onSnd (onModule f)) xs
    where
    onModule :: (Term -> Term) -> M.ModInfo i f Info -> M.ModInfo i f Info
    onModule f m = case m of
       M.ModMod (m@M.Module{M.jments=js}) -> 
	   M.ModMod (m{ M.jments = mapTree (onSnd (onInfo f)) js })
       _ -> m





    -- if -utf8 was given, convert from language specific coding
    encode = if oElem useUTF8 opts then setUTF8Flag . canonUTF8 else id
    canonUTF8 = mapConcreteTerms (onTokens (anyCodingToUTF8 opts))
    setUTF8Flag = setFlag "coding" "utf8"

moduleToUTF8 :: Module Ident Flag Info -> Module Ident Flag Info
moduleToUTF8 m = m{ jments = mapTree (onSnd }
    where 
    code = anyCodingToUTF8 (moduleOpts m)
    moduleOpts = okError . mapM redFlag . flags

data MGrammar i f a = MGrammar {modules :: [(i,ModInfo i f a)]}
  deriving Show

data ModInfo i f a =
    ModMainGrammar (MainGrammar i)
  | ModMod  (Module i f a)
  | ModWith (ModuleType i) ModuleStatus i [OpenSpec i]
  deriving Show

data Module i f a = Module {
    mtype   :: ModuleType i ,
    mstatus :: ModuleStatus ,
    flags   :: [f] ,
    extends :: Maybe i ,
    opens   :: [OpenSpec i] ,
    jments  :: BinTree (i,a)
  }
  deriving Show



-- Set a flag in all modules in a grammar
setFlag :: String -> String -> CanonGrammar -> CanonGrammar
setFlag n v (M.MGrammar ms) = M.MGrammar $ map (onSnd setFlagMod) ms
    where
    setFlagMod m = case m of
      M.ModMod (m@M.Module{M.flags=fs}) -> M.ModMod $ m{ M.flags = fs' }
	  where fs' = Flg (IC n) (IC v):[f | f@(Flg (IC n') _) <- fs, n' /= n]
      _ -> m
-}
	      
mapInfoTerms :: (Term -> Term) -> Info -> Info
mapInfoTerms f i = case i of 
         ResOper x a -> ResOper x (f a)
	 CncCat  x a y -> CncCat x (f a) y
	 CncFun  x y a z -> CncFun x y (f a) z
	 _ -> i

setFlag :: String -> String -> [Flag] -> [Flag]
setFlag n v fs = Flg (IC n) (IC v):[f | f@(Flg (IC n') _) <- fs, n' /= n]