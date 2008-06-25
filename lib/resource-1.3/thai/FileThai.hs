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
import GF.Text.UTF8
import Data.List
import System


main = do
  xx <- getArgs
  case xx of
    "-f":f:[] -> thaiFakeFile f Nothing
    "-p":f:[] -> thaiPronFile f Nothing
    "-w":f:[] -> thaiWordList f
    f     :[] -> thaiFile f Nothing
    _ -> putStrLn "usage: filethai (-f|-p|-w) File"


-- adapted to the format of StringsThai

thaiWordList :: FilePath -> IO ()
thaiWordList f = do
  ss <- readFile f >>= return . lines
  mapM_ mkLine ss
 where
  mkLine s = case words s of
    o : "=" : s : ";" : "--" : es -> 
      putStrLn $ 
        thai s ++ "\t" ++ pron s ++ "\t" ++ fake s ++ "\t" ++ unwords es
    _ -> return ()
  thai = encodeUTF8 . mkThaiWord . init . tail
  pron = mkThaiPron . init . tail
  fake = mkThaiFake . init . tail
