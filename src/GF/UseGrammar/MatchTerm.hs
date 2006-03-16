----------------------------------------------------------------------
-- |
-- Module      : MatchTerm
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
--
-- functions for matching with terms. AR 16/3/2006
-----------------------------------------------------------------------------

module GF.UseGrammar.MatchTerm where

import GF.Data.Operations
import GF.Data.Zipper

import GF.Grammar.Grammar
import GF.Grammar.PrGrammar
import GF.Infra.Ident
import GF.Grammar.Values
import GF.Grammar.Macros
import GF.Grammar.MMacros

import Control.Monad
import Data.List

-- test if a term has duplicated idents, either any or just atoms

hasDupIdent, hasDupAtom :: Exp -> Bool
hasDupIdent = (>1) . maximum . map length . group . sort . allConstants True
hasDupAtom  = (>1) . maximum . map length . group . sort . allConstants False

-- test if a certain ident occurs in term

grepIdent :: Ident -> Exp -> Bool
grepIdent c = elem c . allConstants True

-- form the list of all constants, optionally ignoring all but atoms

allConstants :: Bool -> Exp -> [Ident]
allConstants alsoApp = err (const []) snd . flip appSTM [] . collect where
  collect e = case e of
    Q _ c  -> add c e
    QC _ c -> add c e
    Cn c   -> add c e
    App f a | not alsoApp -> case f of
      App g b -> collect b >> collect a 
      _ -> collect a
    _ -> composOp collect e
  add c e = updateSTM (c:) >> return e
