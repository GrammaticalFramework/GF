module Main where

import System

-- to create a gfs script that builds a gfcm file. AR 29/1/2004
-- reads old GF

-- change these to your needs

scriptFile = "mkNumerals.gfs"
multiFile = "numerals.gfcm"
absModule = "Numerals"
excluded = ["numerals.Abs.gf"]

main :: IO ()
main = do
  system "ls *.gf >files"
  s <- readFile "files"
  writeFile scriptFile $ unlines $ map mkOne $ 
                         filter (flip notElem excluded) $ lines s
  appendFile scriptFile "s\n"
  appendFile scriptFile $ "pm | wf " ++ multiFile

mkOne file = "i -old -abs=" ++ absModule ++ " -cnc=" ++ lang ++ " " ++ file
  where 
    lang = takeWhile (/= '.') file

