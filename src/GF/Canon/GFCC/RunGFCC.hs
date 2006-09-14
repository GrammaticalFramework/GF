module Main where

import GF.Canon.GFCC.GenGFCC
import GF.Canon.GFCC.DataGFCC
import GF.Canon.GFCC.AbsGFCC
import GF.Canon.GFCC.ParGFCC
import GF.Canon.GFCC.PrintGFCC
import GF.Data.Operations
import Data.Map
import System

-- Simple translation application built on GFCC. AR 7/9/2006

main :: IO ()
main = do
  file  <- getLine ----getArgs
  grammar <- file2gfcc file
  loop grammar

loop :: GFCC -> IO ()
loop grammar = do
  s <- getLine
  if s == "quit" then return () else do
    treat grammar s
    loop grammar

treat :: GFCC -> String -> IO ()
treat grammar s = case words s of
  "gt":cat:n:_ -> do
    mapM_ prlin $ take (read n) $ generate grammar (CId cat)
  _ -> lin $ readExp s
 where
  lang = head $ cncnames grammar
  lin t = do
    putStrLn $ printTree $ linExp grammar lang t 
    putStrLn $ linearize grammar lang t
  prlin t = do
    putStrLn $ printTree t
    lin t

--- should be in an API

file2gfcc :: FilePath -> IO GFCC
file2gfcc f = 
  readFile f >>= err (error "no parse") (return . mkGFCC) . pGrammar . myLexer

readExp :: String -> Exp
readExp = err (error "no parse") id . (pExp . myLexer)


{-
treat grammar s = putStrLn $ case comm of
  ["lin"]        -> unlines $ linearizeAll grammar $ readTree grammar rest 
  ["lin",lang]   -> linearize grammar lang $ readTree grammar rest 
  ["parse",cat]  -> unlines $ map showTree $ concat $ parseAll grammar cat rest
  ["parse",lang,cat] -> unlines $ map showTree $ parse grammar lang cat rest
  ["langs"]      -> unwords $ languages grammar
  ["cats"]       -> unwords $ categories grammar
  ["help"]       -> helpMsg
  _ -> "command not interpreted: " ++ s
 where
   (comm,rest) = (words c,drop 1 r) where
      (c,r) = span (/=':') s
-}
