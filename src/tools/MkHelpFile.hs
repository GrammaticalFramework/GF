----------------------------------------------------------------------
-- |
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/16 05:40:51 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.7 $
--
-- Compile @HelpFile.hs@ from the text file @HelpFile@.
-----------------------------------------------------------------------------

module Main (main) where

main = do
  s <- readFile "HelpFile"
  let s' = mkHsFile (lines s)
  writeFile "HelpFile.hs" s'

mkHsFile ss =
  helpHeader ++
  "module HelpFile where\n\n" ++
  "import Operations\n\n" ++
  "txtHelpFileSummary =\n" ++
  "  unlines $ map (concat . take 1 . lines) $ paragraphs txtHelpFile\n\n" ++
  "txtHelpCommand c =\n" ++ 
  "  case lookup c [(takeWhile (/=',') p,p) | p <- paragraphs txtHelpFile] of\n" ++
  "    Just s -> s\n" ++
  "    _ -> \"Command not found.\"\n\n" ++
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

helpHeader = unlines [
  "----------------------------------------------------------------------",
  "-- |",
  "-- Module      : HelpFile",
  "-- Maintainer  : Aarne Ranta",
  "-- Stability   : (stable)",
  "-- Portability : (portable)",
  "--",
  "-- > CVS $Date: 2005/04/16 05:40:51 $", 
  "-- > CVS $Author: peb $",
  "-- > CVS $Revision: 1.7 $",
  "--",
  "-- Help on shell commands. Generated from HelpFile by 'make help'.",
  "-- PLEASE DON'T EDIT THIS FILE.",
  "-----------------------------------------------------------------------------",
  "",
  ""
  ]