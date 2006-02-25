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
import GF.Shell
import GF.Shell.SubShell
import GF.Shell.ShellCommands
import GF.Shell.PShell
import GF.Shell.JGF
import GF.Text.UTF8

import GF.Today (today,version)
import GF.System.Arch
import System (getArgs,system)
import Control.Monad (foldM,liftM)
import Data.List (nub)

-- AR 19/4/2000 -- 28/4/2005

main :: IO ()
main = do
  xs <- getArgs
  let 
   (os,fs) = getOptions "-" xs
   opt j   = oElem j os
   st0     = optInitShellState os
   ifNotSil c = if oElem beSilent os then return () else c 

   doGF os fs = case 0 of

    _ | opt getHelp -> do
      putStrLnFlush $ encodeUTF8 helpMsg

    _ | opt forJava -> do
      putStrLnFlush $ encodeUTF8 welcomeMsg 
      st <- useIOE st0 $ 
              foldM (shellStateFromFiles os) st0 fs
      sessionLineJ True st
      return ()

    _ | opt doMake -> do
      mapM_ (batchCompile os) fs
      return ()

    _ | opt makeConcrete -> do
        mkConcretes fs

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

      ifNotSil $ putStrLnFlush $ welcomeMsg
      st <- useIOE st0 $ 
              foldM (shellStateFromFiles os) st0 fs
      if null fs then return () else (ifNotSil putCPU) 
      gfInteract (initHState st) 
      return ()
  -- preprocessing gfe
  if opt fromExamples 
    then do
        es <- liftM (nub . concat) $ mapM (getGFEFiles os) fs
        mkConcretes es
        doGF (removeOption fromExamples os) fs
    else doGF os fs

helpMsg = unlines [
  "Usage: gf <option>* <file>*",
  "Options:",
  "  -batch        structure session by XML tags (use > to send into a file)",
  "  -edit         start the editor GUI (same as command 'jgf')",
  "  -ex           first compile .gfe files as needed, then .gf files",
  "  -examples     batch-compile .gfe files by parsing examples",
  "  -help         show this message",
  "  -make         batch-compile files",
  "     -noemit      do not emit code when compiling",
  "     -v           be verbose when compiling",
  "Also all flags for import (i) are interpreted; see 'help import'.",
  "An example combination of flags is",
  "  gf -batch -nocpu -s",
  "which suppresses all messages except the output and fatal errors."
  ]

welcomeMsg = 
  "Welcome to " ++ authorMsg ++++ 
  "If ä and ö (umlaut letters) look strange, see 'h -coding'." ++
  "\n\nType 'h' for help, and 'h [Command] for more detailed help.\n"

authorMsg = unlines [
 "Grammatical Framework, Version " ++ version,
 "Compiled " ++ today,
 "Copyright (c)", 
 "Björn Bringert, Håkan Burden, Hans-Joachim Daniels, Markus Forsberg",
 "Thomas Hallgren, Harald Hammarström, Kristofer Johannisson,", 
 "Janna Khegai, Peter Ljunglöf, Petri Mäenpää, and", 
 "Aarne Ranta, 1998-2005, under GNU General Public License (GPL)",
 "Bug reports to aarne@cs.chalmers.se"
 ]
