----------------------------------------------------------------------
-- |
-- Module      : Arch
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/02/24 11:46:34 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.6 $
--
-- architecture\/compiler dependent definitions for unix\/hbc
-----------------------------------------------------------------------------

module Arch (
 myStdGen, prCPU, selectLater, modifiedFiles, ModTime, getModTime,getNowTime,
 welcomeArch, fetchCommand, laterModTime) where

import Time
import Random
import CPUTime
import Monad (filterM)
import Directory
import System.Console.Readline

---- import qualified UnicodeF as U --(fudlogueWrite)

-- architecture/compiler dependent definitions for unix/hbc

myStdGen :: Int -> IO StdGen ---
--- myStdGen _ = newStdGen --- gives always the same result
myStdGen int0 = do
  t0  <- getClockTime 
  cal <- toCalendarTime t0 
  let int = int0 + ctSec cal + fromInteger (div (ctPicosec cal) 10000000)
  return $ mkStdGen int

prCPU :: Integer -> IO Integer
prCPU cpu = do 
  cpu' <- getCPUTime
  putStrLn (show ((cpu' - cpu) `div` 1000000000) ++ " msec")
  return cpu'

welcomeArch :: String
welcomeArch = "This is the system compiled with ghc."

fetchCommand :: String -> IO (String)
fetchCommand s = do
  res <- readline s
  case res of
   Nothing -> return "q"
   Just s -> do addHistory s
                return s

-- | selects the one with the later modification time of two
selectLater :: FilePath -> FilePath -> IO FilePath
selectLater x y = do
  ex <- doesFileExist x
  if not ex 
    then return y --- which may not exist
    else do
      ey <- doesFileExist y
      if not ey 
        then return x
        else do 
          tx <- getModificationTime x
          ty <- getModificationTime y
          return $ if tx < ty then y else x

-- | a file is considered modified also if it has not been read yet
--
-- new 23\/2\/2004: the environment ofs has just module names
modifiedFiles :: [(FilePath,ModTime)] -> [FilePath] -> IO [FilePath]
modifiedFiles ofs fs = do
  filterM isModified fs
 where
  isModified file = case lookup (justModName file) ofs of
    Just to -> do
      t <- getModificationTime file
      return $ to < t
    _ -> return True

  justModName = 
    reverse . takeWhile (/='/') . tail . dropWhile (/='.') . reverse

type ModTime = ClockTime

laterModTime :: ModTime -> ModTime -> Bool
laterModTime = (>)

getModTime :: FilePath -> IO (Maybe ModTime)
getModTime f = do
  b <- doesFileExist f
  if b then (getModificationTime f >>= return . Just) else return Nothing

getNowTime :: IO ModTime
getNowTime = getClockTime
