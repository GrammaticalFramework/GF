----------------------------------------------------------------------
-- |
-- Module      : FileThai
-- Maintainer  : (Maintainer)
-- Stability   : (experimental)
-- Portability : (portable)
--
--
-- Convert transliterated Thai files into UTF-8 and pronunciation
-----------------------------------------------------------------------------

-- AR 21/1/2007

module Main (main) where

import GF.Text.Thai
import Data.List
import System


main = do
  xx <- getArgs
  case xx of
    "-p":f:[] -> thaiPronFile f Nothing
    f     :[] -> thaiFile f Nothing
    _ -> putStrLn "usage: filethai (-p) File"
