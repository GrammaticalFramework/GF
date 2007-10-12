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
         , FCat

         , fcatString, fcatInt, fcatFloat

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
import qualified Data.Map as Map

import GF.Formalism.Utilities
import qualified GF.GFCC.AbsGFCC as AbsGFCC
import GF.Infra.PrintClass


------------------------------------------------------------
-- Token
type FToken    = String


------------------------------------------------------------
-- Category
type FPath     = [FIndex]
type FCat      = Int

fcatString, fcatInt, fcatFloat :: Int
fcatString = (-1)
fcatInt    = (-2)
fcatFloat  = (-3)

------------------------------------------------------------
-- Symbol
type FIndex    = Int
data FSymbol
  = FSymCat {-# UNPACK #-} !FCat {-# UNPACK #-} !FIndex {-# UNPACK #-} !Int 
  | FSymTok FToken


------------------------------------------------------------
-- Name
type FName     = NameProfile AbsGFCC.CId

isCoercionF :: FName -> Bool
isCoercionF (Name fun [Unify [0]]) = fun == AbsGFCC.CId "_"
isCoercionF _ = False


------------------------------------------------------------
-- Grammar

type FPointPos = Int
type FGrammar  = ([FRule], Map.Map AbsGFCC.CId [FCat])
data FRule     = FRule FName [FCat] FCat (Array FIndex (Array FPointPos FSymbol))

------------------------------------------------------------
-- pretty-printing

instance Print AbsGFCC.CId where
  prt (AbsGFCC.CId s) = s

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
