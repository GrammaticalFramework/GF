module Main where

import GFC
import GFI

import System.Environment (getArgs)

main :: IO ()
main = do
  args <- getArgs
  case args of
    "--batch":args -> mainGFC args
    _              -> mainGFI args
