----------------------------------------------------------------------
-- |
-- Maintainer  : Aarne Ranta
-- Stability   : (stability)
-- Portability : (portability)
--
-- > CVS $Date: 2005/10/06 10:02:33 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.8 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.GFModes (gfInteract, gfBatch, batchCompile) where

import GF.Data.Operations
import GF.Infra.UseIO
import GF.Infra.Option
import GF.Compile.ShellState
import GF.Shell.ShellCommands
import GF.Shell
import GF.Shell.CommandL (execCommandHistory)
import GF.Shell.SubShell
import GF.Shell.PShell
import GF.Shell.JGF
import Data.Char (isSpace)

-- separated from GF Main 24/6/2003

gfInteract :: HState -> IO HState
gfInteract st@(env,hist) = do
  -- putStrFlush "> " M.F 25/01-02 prompt moved to Arch.
  (s,cs) <- getCommandLines st
  case ifImpure cs of

    -- these are the three impure commands
    Just (ICQuit,_) -> do
      ifNotSilent "See you."
      return st
    Just (ICExecuteHistory file,_) -> do
      ss  <- readFileIf file
      let co = pCommandLines st ss
      st' <- execLinesH s co st      
      gfInteract st'      
    Just (ICEarlierCommand i,_) -> do
      let line = earlierCommandH st i
          co   = pCommandLine st $ words line
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
  (s,cs) <- getCommandLinesBatch st
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
  let st    = initHState emptyShellState
  let s     = "i -o" +++ (unwords $ map ('-':) $ words $ prOpts os) +++ file
  let cs    = pCommandLines st s
  execLines True cs st
  return ()

mkGFC = reverse . ("cfg" ++) . dropWhile (/='.') . reverse
