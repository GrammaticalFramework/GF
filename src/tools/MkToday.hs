module Main where

import System

main :: IO ()
main = do
  system "date >foo.tmp"
  d0 <- readFile "foo.tmp"
  let d = head $ lines d0
  writeFile "Today.hs" $ mkToday d
  system "rm foo.tmp"
  return ()

mkToday d = "module Today where today = \"" ++ d ++ "\"\n"

