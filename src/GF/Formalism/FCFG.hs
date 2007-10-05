----------------------------------------------------------------------
-- |
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-- Definitions of fast multiple context-free grammars
-----------------------------------------------------------------------------

module GF.Formalism.FCFG
         ( 
         -- * Token
           FToken

         -- * Category
         , FPath
         , FCat(..)

         , initialFCat
         , fcatString, fcatInt, fcatFloat
         , fcat2cid

         -- * Symbol
         , FIndex
         , FSymbol(..)

         -- * Name
         , FName
         , isCoercionF

         -- * Grammar
         , FPointPos
         , FGrammar
         , FRule(..)
         ) where

import Control.Monad (liftM)
import Data.List (groupBy)
import Data.Array

import GF.Formalism.Utilities
import qualified GF.GFCC.AbsGFCC as AbsGFCC
import GF.Infra.PrintClass


------------------------------------------------------------
-- Token
type FToken    = String


------------------------------------------------------------
-- Category
type FPath     = [FIndex]
data FCat      = FCat  {-# UNPACK #-} !Int AbsGFCC.CId [FPath] [(FPath,FIndex)]

initialFCat :: AbsGFCC.CId -> FCat
initialFCat cat = FCat 0 cat [] []

fcatString = FCat (-1) (AbsGFCC.CId "String") [[0]] []
fcatInt    = FCat (-2) (AbsGFCC.CId "Int")    [[0]] []
fcatFloat  = FCat (-3) (AbsGFCC.CId "Float")  [[0]] []

fcat2cid :: FCat -> AbsGFCC.CId
fcat2cid (FCat _ c _ _) = c

instance Eq FCat where
  (FCat id1 _ _ _) == (FCat id2 _ _ _) = id1 == id2

instance Ord FCat where
  compare (FCat id1 _ _ _) (FCat id2 _ _ _) = compare id1 id2


------------------------------------------------------------
-- Symbol
type FIndex    = Int
data FSymbol
  = FSymCat FCat {-# UNPACK #-} !FIndex {-# UNPACK #-} !Int 
  | FSymTok FToken


------------------------------------------------------------
-- Name
type FName     = NameProfile AbsGFCC.CId

isCoercionF :: FName -> Bool
isCoercionF (Name fun [Unify [0]]) = fun == AbsGFCC.CId "_"
isCoercionF _ = False


------------------------------------------------------------
-- Grammar
type FGrammar  = [FRule]
type FPointPos = Int
data FRule     = FRule FName [FCat] FCat (Array FIndex (Array FPointPos FSymbol))


------------------------------------------------------------
-- pretty-printing

instance Print AbsGFCC.CId where
  prt (AbsGFCC.CId s) = s

instance Print FCat where
    prt (FCat _ (AbsGFCC.CId cat) rcs tcs) = cat ++ "{" ++ 
			             prtSep ";" ([prt path                    |  path       <- rcs] ++
			                         [prt path ++ "=" ++ prt term | (path,term) <- tcs])
			                 ++ "}"

instance Print FSymbol where
    prt (FSymCat c l n) = "($" ++ prt n ++ "!" ++ prt l ++ ")"
    prt (FSymTok t)     = simpleShow (prt t)
      where simpleShow str = "\"" ++ concatMap mkEsc str ++ "\""
            mkEsc '\\' = "\\\\"
            mkEsc '\"' = "\\\""
            mkEsc '\n' = "\\n"
            mkEsc '\t' = "\\t"
            mkEsc chr  = [chr]
    prtList = prtSep " "

instance Print FRule where
    prt (FRule name args res lins) = prt name ++ " : " ++ (if null args then "" else prtSep " " args ++ " -> ") ++ prt res ++
                                     " =\n   [" ++ prtSep "\n    " ["("++prtSep " " [prt sym | (_,sym) <- assocs syms]++")" | (_,syms) <- assocs lins]++"]"
    prtList = prtSep "\n"
