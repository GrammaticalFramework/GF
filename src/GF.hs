{-# OPTIONS -cpp #-}
----------------------------------------------------------------------
-- |
-- Module      : Main
-- Maintainer  : Aarne Ranta
-- Stability   : (stability)
-- Portability : (portability)
--
-- > CVS $Date: 2005/06/30 11:36:49 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.29 $
--
-- The Main module of GF program.
-----------------------------------------------------------------------------

module Main (main) where

import GF.GFModes (gfInteract, gfBatch, batchCompile)
import GF.Data.Operations
import GF.Infra.UseIO
import GF.Infra.Option
import GF.API.IOGrammar
import GF.Compile.ShellState
import GF.Compile.Compile
import GF.Compile.MkConcrete
import GF.Compile.Wordlist
import GF.Shell
import GF.Shell.SubShell
import GF.Shell.ShellCommands
import GF.Shell.PShell
import GF.Shell.JGF
import GF.System.Signal
import GF.Text.UTF8

import GF.Today (today,version,libdir)
import GF.System.Arch
import System (getArgs,system,getEnv)
import System.FilePath
import Control.Monad (foldM,liftM)
import Data.List (nub)

#ifdef mingw32_HOST_OS
import System.Win32.Console
import System.Win32.NLS
#endif

-- AR 19/4/2000 -- 21/3/2006

main :: IO ()
main = do
#ifdef mingw32_HOST_OS
  codepage <- getACP
  setConsoleCP codepage
  setConsoleOutputCP codepage
#endif
  
  xs <- getArgs
  let 
   (os,fs) = getOptions "-" xs
   opt j   = oElem j os
   st0     = optInitShellState os
   ifNotSil c = if oElem beSilent os then return () else c 

   doGF os fs = case 0 of

    _ | opt getHelp || any opt (map iOpt ["h", "-help", "-h"])-> do
      putStrLnFlush $ encodeUTF8 helpMsg

    _ | opt forJava -> do
      welcome <- welcomeMsgLib
      putStrLnFlush $ encodeUTF8 welcome 
      st <- useIOE st0 $ 
              foldM (shellStateFromFiles os) st0 fs
      sessionLineJ True st
      return ()

    _ | opt doMake -> do
      mapM_ (batchCompile os) fs
      return ()

    _ | opt makeConcrete -> do
        mkConcretes os fs

    _ | opt openEditor -> do
        system $ "jgf" +++ unwords xs
        return ()

    _ | opt doBatch -> do
      if opt beSilent then return () else putStrLnFlush "<gfbatch>"
      st <- useIOE st0 $ 
              foldM (shellStateFromFiles os) st0 fs
      gfBatch (initHState st) 
      if opt beSilent then return () else putStrLnFlush "</gfbatch>"
      return ()
    _ -> do
      welcome <- welcomeMsgLib
      ifNotSil $ putStrLnFlush $ welcome
      st <- useIOE st0 $ 
              foldM (shellStateFromFiles os) st0 fs
      if null fs then return () else (ifNotSil putCPU) 
      blockInterrupt (gfInteract (initHState st)) 
      return ()
  -- preprocessing gfe
  if opt fromExamples 
    then do
        es <- liftM (nub . concat) $ mapM (getGFEFiles os) fs
        mkConcretes os es
        doGF (removeOption fromExamples os) fs
  -- preprocessing gfwl
    else if (length fs == 1 && takeExtensions (head fs) == ".gfwl")
    then do
      fs' <- mkWordlist (head fs)
      doGF os fs'
    else doGF os fs

helpMsg = unlines [
  "Usage: gf <option>* <file>*",
  "Options:",
  "  -batch        structure session by XML tags (use > to send into a file)",
  "  -edit         start the editor GUI (same as command 'jgf')",
  "  -ex           first compile .gfe files as needed, then .gf files",
  "  -examples     batch-compile .gfe files by parsing examples",
  "     -treebank  use a treebank, instead of a grammar, as parser",
  "  -make         batch-compile files",
  "     -noemit      do not emit code when compiling",
  "     -v           be verbose when compiling",
  "  -help         show this message",
  "Also all flags for import (i) are interpreted; see 'help import'.",
  "An example combination of flags is",
  "  gf -batch -nocpu -s",
  "which suppresses all messages except the output and fatal errors."
  ]

welcomeMsgLib = do
  lib <- getLibraryPath
  return $ welcomeMsg lib

welcomeMsg lib = 
  "Welcome to " ++ authorMsg ++++ 
  "If \228 and \246 (umlaut letters) look strange, see 'h -coding'." ++
  "\nGF_LIB_PATH is set to " ++ lib ++
  "\n\nType 'h' for help, and 'h [Command] for more detailed help.\n"

authorMsg = unlines [
 "Grammatical Framework, Version " ++ version,
 "Compiled " ++ today,
 "Copyright (c)", 
 "Krasimir Angelov, Bj\246rn Bringert, H\229kan Burden, Hans-Joachim Daniels,",
 "Markus Forsberg, Thomas Hallgren, Harald Hammarstr\246m, Kristofer Johannisson,",
 "Janna Khegai, Peter Ljungl\246f, Petri M\228enp\228\228, and", 
 "Aarne Ranta, 1998-2006, under GNU General Public License (GPL)",
 "Bug reports to aarne@cs.chalmers.se"
 ]
