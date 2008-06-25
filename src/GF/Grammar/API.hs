module GF.Grammar.API (
  Grammar,
  emptyGrammar,
  pTerm,
  prTerm,
  checkTerm,
  computeTerm,
  showTerm,
  TermPrintStyle(..),
  pTermPrintStyle
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
import GF.Infra.Option

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

showTerm :: TermPrintStyle -> Term -> String
showTerm style t = 
    case style of
      TermPrintTable   -> unlines [p +++ s | (p,s) <- prTermTabular t]
      TermPrintAll     -> unlines [      s | (p,s) <- prTermTabular t]
      TermPrintUnqual  -> prt_ t
      TermPrintDefault -> prt t


data TermPrintStyle = TermPrintTable | TermPrintAll | TermPrintUnqual | TermPrintDefault
  deriving (Show,Eq)

pTermPrintStyle s = case s of
  "table"  -> TermPrintTable
  "all"    -> TermPrintAll
  "unqual" -> TermPrintUnqual
  _        -> TermPrintDefault


