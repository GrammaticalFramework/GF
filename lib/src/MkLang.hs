module Main where

-- Prepare a new resource directory. Usage:
-- 1. $ cp german/*.gf dutch/
-- 2. $ cd dutch/
-- 3. $ runghc ../MkLang.hs Ger Dut
-- AR 6/11/2009

import System
import List

main = do
  xx <- getArgs 
  change xx

change xx = case xx of
  from:to:_ -> do
     system "ls *.gf > files.tmp"
     files <- readFile "files.tmp" >>= return . lines
     mapM_ (changeFileName from to) files
     system "ls *.gf > files.tmp"
     files <- readFile "files.tmp" >>= return . lines
     mapM_ (changeIdents from to) files
     mapM_ commentOut files
  comment -> do
     files <- readFile "files.tmp" >>= return . lines
     mapM_ commentOut files

changeFileName from to file = system $ "mv " ++ file ++ " " ++ to_file where
  to_file = take (length file - 3 - length from) (takeWhile (/='.') file) ++ to ++ ".gf"

changeIdents from to = changeInFile changes
 where
   lg = length from
   changes s = case s of
     c:cs 
       | take lg s == from -> to ++ changes (drop lg s)
       | otherwise         -> c : changes cs
     _ -> s

commentOut = changeInFile comm where
  comm s = let (hd,tl) = break (=='{') s in 
    hd ++ "\n{\n" ++ unlines ["--" ++ l | l <- lines tl] ++ "\n}\n"

changeInFile ch file = do
  s <- readFile file
  writeFile "gf.tmp" (ch s)
  system $ "mv gf.tmp " ++ file
