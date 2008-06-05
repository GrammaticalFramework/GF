module GF.Command.Parse(readCommandLine) where

import PGF.ExprSyntax
import GF.Command.Abstract

import Data.Char
import qualified Text.ParserCombinators.ReadP as RP

readCommandLine :: String -> Maybe CommandLine
readCommandLine s = case [x | (x,cs) <- RP.readP_to_S pCommandLine s, all isSpace cs] of
                      [x] -> Just x
                      _   -> Nothing

test s = RP.readP_to_S pCommandLine s 

pCommandLine = RP.sepBy (RP.skipSpaces >> pPipe) (RP.skipSpaces >> RP.char ';')

pPipe = RP.sepBy (RP.skipSpaces >> pCommand) (RP.skipSpaces >> RP.char '|')

pCommand = do
  cmd  <- pIdent
  RP.skipSpaces
  opts <- RP.many pOption
  arg  <- RP.option ANoArg (fmap AExp (pExp False))
  return (Command cmd opts arg)

pOption = do
  RP.char '-'
  flg <- pIdent
  RP.option (OOpt flg) (fmap (OFlag flg) (RP.char '=' >> pValue))

pValue = do
  fmap VId  pIdent
  RP.<++
  fmap (VInt . read) (RP.munch1 isDigit)
