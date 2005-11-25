module Main where

import System.Environment (getArgs)

import Transfer.Syntax.Lex
import Transfer.Syntax.Layout

prTokens :: [Token] -> String
prTokens = prTokens_ 1 1
  where 
  prTokens_ _ _ [] = ""
  prTokens_ l c (PT p t:ts) = 
--  prTokens_ l c (Err p:ts) = 

layout :: String -> String
layout s = prTokens . resolveLayout True . tokens

main :: IO ()
main = do args <- getArgs
          case args of
            [] -> getContents >>= putStrLn . layout
            fs -> mapM_ (\f -> readFile f >>= putStrLn . layout) fs
