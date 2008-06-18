module GF.Command.Parse(readCommandLine, pCommand) where

import PGF.ExprSyntax
import PGF.Data(Exp)
import GF.Command.Abstract

import Data.Char
import Control.Monad
import qualified Text.ParserCombinators.ReadP as RP

readCommandLine :: String -> Maybe CommandLine
readCommandLine s = case [x | (x,cs) <- RP.readP_to_S pCommandLine s, all isSpace cs] of
                      [x] -> Just x
                      _   -> Nothing

test s = RP.readP_to_S pCommandLine s 

pCommandLine = RP.sepBy (RP.skipSpaces >> pPipe) (RP.skipSpaces >> RP.char ';')

pPipe = RP.sepBy1 (RP.skipSpaces >> pCommand) (RP.skipSpaces >> RP.char '|')

pCommand = do
  cmd  <- pIdent RP.<++ (RP.char '%' >> pIdent >>= return . ('%':))
  RP.skipSpaces
  opts <- RP.sepBy pOption RP.skipSpaces
  arg  <- pArgument
  return (Command cmd opts arg)

pOption = do
  RP.char '-'
  flg <- pIdent
  RP.option (OOpt flg) (fmap (OFlag flg) (RP.char '=' >> pValue))

pValue = do
  fmap VId  pFilename
  RP.<++
  fmap (VInt . read) (RP.munch1 isDigit)

pFilename = liftM2 (:) (RP.satisfy isFileFirst) (RP.munch (not . isSpace)) where
  isFileFirst c = not (isSpace c) && not (isDigit c)

pArgument =          
  RP.option ANoArg 
    (fmap AExp (pExp False)
              RP.<++ 
    (RP.munch isSpace >> RP.char '%' >> fmap AMacro pIdent))
