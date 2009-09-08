module GF.Command.Parse(readCommandLine, pCommand) where

import PGF.CId
import PGF.Expr
import GF.Command.Abstract

import Data.Char
import Control.Monad
import qualified Text.ParserCombinators.ReadP as RP

readCommandLine :: String -> Maybe CommandLine
readCommandLine s = case [x | (x,cs) <- RP.readP_to_S pCommandLine s, all isSpace cs] of
                      [x] -> Just x
                      _   -> Nothing

pCommandLine =
  (RP.skipSpaces >> RP.char '-' >> RP.char '-' >> RP.skipMany (RP.satisfy (const True)) >> return [])   -- comment
  RP.<++
  (RP.sepBy (RP.skipSpaces >> pPipe) (RP.skipSpaces >> RP.char ';'))

pPipe = RP.sepBy1 (RP.skipSpaces >> pCommand) (RP.skipSpaces >> RP.char '|')

pCommand = (do
  cmd  <- pIdent RP.<++ (RP.char '%' >> pIdent >>= return . ('%':))
  RP.skipSpaces
  opts <- RP.sepBy pOption RP.skipSpaces
  arg  <- pArgument
  return (Command cmd opts arg)
  )
    RP.<++ (do
  RP.char '?' 
  c <- pSystemCommand 
  return (Command "sp" [OFlag "command" (VStr c)] ANoArg)
  ) 

pOption = do
  RP.char '-'
  flg <- pIdent
  RP.option (OOpt flg) (fmap (OFlag flg) (RP.char '=' >> pValue))

pValue = do
  fmap (VInt . read) (RP.munch1 isDigit)
  RP.<++
  fmap VStr pStr
  RP.<++
  fmap VId  pFilename

pFilename = liftM2 (:) (RP.satisfy isFileFirst) (RP.munch (not . isSpace)) where
  isFileFirst c = not (isSpace c) && not (isDigit c)

pArgument =          
  RP.option ANoArg 
    (fmap AExpr pExpr
              RP.<++ 
    (RP.munch isSpace >> RP.char '%' >> fmap AMacro pIdent))

pSystemCommand = 
  RP.munch isSpace >> (
    (RP.char '"' >> (RP.manyTill (pEsc RP.<++ RP.get) (RP.char '"')))
      RP.<++
    RP.many RP.get
    )
       where
         pEsc = RP.char '\\' >> RP.get 
