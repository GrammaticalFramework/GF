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

         , fcatString, fcatInt, fcatFloat, fcatVar

         -- * Symbol
         , FIndex
         , FSymbol(..)

         -- * Grammar
         , Profile
         , FPointPos
         , FGrammar
         , FRule(..)
         ) where

import Control.Monad (liftM)
import Data.List (groupBy)
import Data.Array
import qualified Data.Map as Map

import GF.Formalism.Utilities
import GF.GFCC.CId
import GF.Infra.PrintClass

------------------------------------------------------------
-- Token
type FToken    = String


------------------------------------------------------------
-- Category
type FPath     = [FIndex]
type FCat      = Int

fcatString, fcatInt, fcatFloat, fcatVar :: Int
fcatString = (-1)
fcatInt    = (-2)
fcatFloat  = (-3)
fcatVar    = (-4)


------------------------------------------------------------
-- Symbol
type FIndex    = Int
data FSymbol
  = FSymCat {-# UNPACK #-} !FCat {-# UNPACK #-} !FIndex {-# UNPACK #-} !Int 
  | FSymTok FToken


------------------------------------------------------------
-- Grammar

type Profile   = [Int]
type FPointPos = Int
type FGrammar  = ([FRule], Map.Map CId [FCat])
data FRule     = FRule CId [Profile] [FCat] FCat (Array FIndex (Array FPointPos FSymbol))

------------------------------------------------------------
-- pretty-printing

instance Print CId where
    prt = prCId

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
    prt (FRule fun profile args res lins) =
      prt fun ++ prtProf profile ++ " : " ++ (if null args then "" else prtSep " " args ++ " -> ") ++ prt res ++
      " =\n   [" ++ prtSep "\n    " ["("++prtSep " " [prt sym | (_,sym) <- assocs syms]++")" | (_,syms) <- assocs lins]++"]"
      where
        prtProf []   = "?"
	prtProf args = prtSep "=" args

    prtList = prtSep "\n"
