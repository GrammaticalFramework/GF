module Main where

import GF.Devel.Compile.GFC

import System (getArgs)

main = do
  xx <- getArgs
  mainGFC xx
