module Main where

import GF.Devel.GFC
import GF.Devel.GFI

import System (getArgs)

main :: IO ()
main = do
  xx <- getArgs
  case xx of
    "--batch":args -> mainGFC args
    _ -> mainGFI xx

