----------------------------------------------------------------------
-- |
-- Module      : Main
-- Maintainer  : Aarne Ranta
-- Stability   : (stability)
-- Portability : (portability)
--
-- > CVS $Date: 2005/02/04 10:10:28 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.5 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GFModes (gfInteract, gfBatch, batchCompile) where

import Operations
import UseIO
import Option
import ShellState
import ShellCommands
import Shell
import CommandL (execCommandHistory)
import SubShell
import PShell
import JGF
import Char (isSpace)

-- separated from GF Main 24/6/2003

gfInteract :: HState -> IO HState
gfInteract st@(env,hist) = do
  -- putStrFlush "> " M.F 25/01-02 prompt moved to Arch.
  (s,cs) <- getCommandLines
  case ifImpure cs of

    -- these are the three impure commands
    Just (ICQuit,_) -> do
      ifNotSilent "See you."
      return st
    Just (ICExecuteHistory file,_) -> do
      ss  <- readFileIf file
      let co = pCommandLines ss
      st' <- execLinesH s co st      
      gfInteract st'      
    Just (ICEarlierCommand i,_) -> do
      let line = earlierCommandH st i
          co   = pCommandLine $ words line
      st' <- execLinesH line [co] st       -- s would not work in execLinesH
      gfInteract st'

    Just (ICEditSession,os) -> case getOptVal os useFile of
      Just file -> do
        s <- readFileIf file
        (env',tree) <- execCommandHistory env s
        gfInteract st
      _ -> 
        editSession (addOptions os opts) env >> gfInteract st
    Just (ICTranslateSession,os) -> 
      translateSession (addOptions os opts) env >> gfInteract st

    -- this is a normal command sequence
    _ -> do
      st' <- execLinesH s cs st
      gfInteract st'
   where
     opts = globalOptions env
     ifNotSilent c = 
       if oElem beSilent opts then return () else putStrLnFlush c

gfBatch :: HState -> IO HState
gfBatch st@(sh,_) = do
  (s,cs) <- getCommandLinesBatch
  if s == "q" then return st else do
    st' <- if all isSpace s then return st else do
        putVe "<gfcommand>"
        putVe s
        putVe "</gfcommand>"
        putVe "<gfreply>"
        (_,st') <- execLines True cs st
        putVe "</gfreply>"
        return st'
    gfBatch st'
 where
   putVe = putVerb st

putVerb st@(sh,_) s = if (oElem beSilent (globalOptions sh))
                          then return ()
                          else putStrLnFlush s 

batchCompile :: Options -> FilePath -> IO ()
batchCompile os file = do
  let file' = mkGFC file
  let s     = "i -o" +++ (unwords $ map ('-':) $ words $ prOpts os) +++ file
  let cs    = pCommandLines s
  execLines True cs (initHState emptyShellState)
  return ()

mkGFC = reverse . ("cfg" ++) . dropWhile (/='.') . reverse
