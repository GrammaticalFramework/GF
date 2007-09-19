module Main where

import GF.Canon.GFCC.GFCCAPI
import qualified GF.Canon.GFCC.GenGFCC as G ---
import GF.Canon.GFCC.AbsGFCC (CId(CId)) ---
import System.Random (newStdGen)
import System (getArgs)


-- Simple translation application built on GFCC. AR 7/9/2006 -- 19/9/2007

main :: IO ()
main = do
  file:_  <- getArgs
  grammar <- file2grammar file
  putStrLn $ "languages:  " ++ unwords (languages grammar)
  putStrLn $ "categories: " ++ unwords (categories grammar)
  loop grammar

loop :: MultiGrammar -> IO ()
loop grammar = do
  s <- getLine
  if s == "quit" then return () else do
    treat grammar s
    loop grammar

treat :: MultiGrammar -> String -> IO ()
treat grammar s = case words s of
  "gt":cat:n:_ -> do
    mapM_ prlinonly $ take (read n) $ G.generate grammar (CId cat)
  "gtt":cat:n:_ -> do
    mapM_ prlin $ take (read n) $ G.generate grammar (CId cat)
  "gr":cat:n:_ -> do
    gen <- newStdGen
    mapM_ prlinonly $ take (read n) $ G.generateRandom gen grammar (CId cat)
  "grt":cat:n:_ -> do
    gen <- newStdGen
    mapM_ prlin $ take (read n) $ G.generateRandom gen grammar (CId cat)
  "p":lang:cat:ws -> do
    let ts = parse grammar lang cat $ unwords ws
    mapM_ (putStrLn . showTree) ts 
  "search":cat:n:ws -> do
    case G.parse (read n) grammar (CId cat) ws of
      t:_ -> prlin t
      _ -> putStrLn "no parse found" 
  _ -> lins $ readTree grammar s
 where
  langs = languages grammar
  lins t = mapM_ (lint t) $ langs 
  lint t lang = do
----    putStrLn $ showTree $ linExp grammar lang t 
    lin t lang
  lin t lang = do
    putStrLn $ linearize grammar lang t
  prlins t = do
    putStrLn $ showTree t
    lins t
  prlin t = do
    putStrLn $ showTree t
    prlinonly t
  prlinonly t = mapM_ (lin t) $ langs

