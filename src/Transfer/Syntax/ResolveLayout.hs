module Main where

import System.Environment (getArgs)

import Transfer.Syntax.Lex
import Transfer.Syntax.Layout

prTokens :: [Token] -> String
prTokens = prTokens_ 1 1
  where 
  prTokens_ _ _ [] = ""
  prTokens_ l c (t@(PT (Pn _ l' c') _):ts) = 
      replicate (l'-l) '\n' 
       ++ replicate (if l' == l then c'-c else c'-1) ' '
       ++ s ++ prTokens_ l' (c'+length s) ts
    where s = prToken t
--  prTokens_ l c (Err p:ts) = 

layout :: String -> String
layout s = prTokens ts'
--           ++ "\n" ++ show ts'
  where ts = tokens s
        ts' = resolveLayout True ts

main :: IO ()
main = do args <- getArgs
          case args of
            [] -> getContents >>= putStrLn . layout
            fs -> mapM_ (\f -> readFile f >>= putStrLn . layout) fs
