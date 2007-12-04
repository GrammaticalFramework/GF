module Main where

import GF.Devel.Grammar.LexGF
import GF.Devel.Grammar.ParGF
---- import GF.Devel.Grammar.PrintGF
import GF.Devel.Grammar.Modules

import GF.Devel.Grammar.SourceToGF

import qualified GF.Devel.Grammar.ErrM as GErr ----
import GF.Data.Operations

import Data.Map
import System (getArgs)

main = do
  f:_ <- getArgs
  s   <- readFile f
  let tt = myLexer s
  case pGrammar tt of
    GErr.Bad s -> putStrLn s
    GErr.Ok g -> compile g

compile g = do
  let eg = transGrammar g
  case eg of
    Ok gr -> print (length (assocs (gfmodules gr))) >> putStrLn "OK"
    Bad s -> putStrLn s
  return ()

