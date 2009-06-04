module Main where

import Distribution.Simple

main :: IO ()
main = defaultMainWithHooks simpleUserHooks
