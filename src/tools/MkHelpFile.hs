module Main where

main = do
  s <- readFile "HelpFile"
  let s' = mkHsFile (lines s)
  writeFile "HelpFile.hs" s'

mkHsFile ss =
  "module HelpFile where\n\n" ++
  "txtHelpFile =\n" ++
  unlines (map mkOne ss) ++
  "  []"

mkOne s = "  \"" ++ pref s ++ (escs s) ++ "\" ++"
 where 
   pref (' ':_) = "\\n"
   pref _ = "\\n" ---
   escs [] = []
   escs (c:cs) | elem c "\"\\" = '\\':c:escs cs
   escs (c:cs) = c:escs cs
