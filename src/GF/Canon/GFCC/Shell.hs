module Main where

import GF.Canon.GFCC.GFCCAPI
import qualified GF.Canon.GFCC.GenGFCC as G ---
import GF.Canon.GFCC.AbsGFCC (CId(CId)) ---
import System.Random (newStdGen)
import System (getArgs)
import Data.Char (isDigit)

-- Simple translation application built on GFCC. AR 7/9/2006 -- 19/9/2007

main :: IO ()
main = do
  file:_  <- getArgs
  grammar <- file2grammar file
  printHelp grammar
  loop grammar

loop :: MultiGrammar -> IO ()
loop grammar = do
  s <- getLine
  if s == "q" then return () else do
    treat grammar s
    loop grammar

printHelp grammar = do
  putStrLn $ "languages:  " ++ unwords (languages grammar)
  putStrLn $ "categories: " ++ unwords (categories grammar)
  putStrLn commands


commands = unlines [
  "Commands:",
  "  (gt | gtt | gr | grt) Cat Num - generate all or random",
  "  p Lang Cat String             - parse (unquoted) string",
  "  l Tree                        - linearize in all languages",
  "  h                             - help",
  "  q                             - quit"
  ]

treat :: MultiGrammar -> String -> IO ()
treat mgr s = case words s of
  "gt" :cat:n:_ -> mapM_ prlinonly $ take (read1 n) $ generateAll mgr cat
  "gtt":cat:n:_ -> mapM_ prlin $ take (read1 n) $ generateAll mgr cat
  "gr" :cat:n:_ -> generateRandom mgr cat >>= mapM_ prlinonly . take (read1 n) 
  "grt":cat:n:_ -> generateRandom mgr cat >>= mapM_ prlin . take (read1 n) 
  "p":lang:cat:ws -> do
    let ts = parse mgr lang cat $ unwords ws
    mapM_ (putStrLn . showTree) ts 
  "search":cat:n:ws -> do
    case G.parse (read n) grammar (CId cat) ws of
      t:_ -> prlin t
      _ -> putStrLn "no parse found" 
  "h":_ -> printHelp mgr
  _ -> lins $ readTree mgr s
 where
  grammar = gfcc mgr
  langs = languages mgr
  lins t = mapM_ (lint t) $ langs 
  lint t lang = do
----    putStrLn $ showTree $ linExp grammar lang t 
    lin t lang
  lin t lang = do
    putStrLn $ linearize mgr lang t
  prlins t = do
    putStrLn $ showTree t
    lins t
  prlin t = do
    putStrLn $ showTree t
    prlinonly t
  prlinonly t = mapM_ (lin t) $ langs
  read1 s = if all isDigit s then read s else 1


