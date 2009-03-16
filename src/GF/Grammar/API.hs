module GF.Grammar.API (
  Grammar,
  emptyGrammar,
  checkTerm,
  computeTerm,
  showTerm,
  TermPrintStyle(..), TermPrintQual(..),
  ) where

import GF.Infra.Ident
import GF.Infra.Modules (greatestResource)
import GF.Compile.GetGrammar
import GF.Grammar.Macros
import GF.Grammar.Parser
import GF.Grammar.Printer
import GF.Grammar.Grammar

import GF.Compile.Rename (renameSourceTerm)
import GF.Compile.CheckGrammar (justCheckLTerm)
import GF.Compile.Compute (computeConcrete)

import GF.Data.Operations
import GF.Infra.Option

import qualified Data.ByteString.Char8 as BS
import Text.PrettyPrint

type Grammar = SourceGrammar

emptyGrammar :: Grammar
emptyGrammar = emptySourceGrammar

checkTerm :: Grammar -> Term -> Err Term
checkTerm gr t = do
  mo <- maybe (Bad "no source grammar in scope") return $ greatestResource gr
  checkTermAny gr mo t

checkTermAny :: Grammar -> Ident -> Term -> Err Term
checkTermAny gr m t = do
  t1 <- renameSourceTerm gr m t
  justCheckLTerm gr t1

computeTerm :: Grammar -> Term -> Err Term
computeTerm = computeConcrete

showTerm :: TermPrintStyle -> TermPrintQual -> Term -> String
showTerm style q t = render $
  case style of
    TermPrintTable   -> vcat [p <+> s | (p,s) <- ppTermTabular q t]
    TermPrintAll     -> vcat [      s | (p,s) <- ppTermTabular q t]
    TermPrintDefault -> ppTerm q 0 t

data TermPrintStyle
  = TermPrintTable
  | TermPrintAll
  | TermPrintDefault
