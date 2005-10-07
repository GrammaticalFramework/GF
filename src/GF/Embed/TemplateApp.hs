module Main where

import GF.Embed.EmbedAPI
import System

-- Simple translation application built on EmbedAPI. AR 7/10/2005

main :: IO ()
main = do
  file:_  <- getArgs
  grammar <- file2grammar file
  translate grammar

translate :: MultiGrammar -> IO ()
translate grammar = do
  s <- getLine
  if s == "quit" then return () else do
    treat grammar s
    translate grammar

treat :: MultiGrammar -> String -> IO ()
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

helpMsg = unlines [
  "lin : <Tree>",
  "lin <Lang> : <Tree>",
  "parse <Cat> : <String>",
  "parse <Lang> <Cat> : <String>",
  "langs",
  "cats",
  "help",
  "quit"
  ]
