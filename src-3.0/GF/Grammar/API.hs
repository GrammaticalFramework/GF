module GF.Grammar.API (
  Grammar,
  emptyGrammar,
  pTerm,
  prTerm,
  checkTerm,
  computeTerm
  ) where

import GF.Source.ParGF
import GF.Source.SourceToGrammar (transExp)
import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Infra.Modules (greatestResource)
import GF.Compile.GetGrammar
import GF.Grammar.Macros
import GF.Grammar.PrGrammar

import GF.Compile.Rename (renameSourceTerm)
import GF.Compile.CheckGrammar (justCheckLTerm)
import GF.Compile.Compute (computeConcrete)

import GF.Data.Operations
import qualified Data.ByteString.Char8 as BS

type Grammar = SourceGrammar

emptyGrammar :: Grammar
emptyGrammar = emptySourceGrammar

pTerm :: String -> Err Term
pTerm s = do
  e <- pExp $ myLexer (BS.pack s)
  transExp e

prTerm :: Term -> String
prTerm = prt

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

