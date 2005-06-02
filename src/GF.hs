----------------------------------------------------------------------
-- |
-- Module      : Main
-- Maintainer  : Aarne Ranta
-- Stability   : (stability)
-- Portability : (portability)
--
-- > CVS $Date: 2005/06/02 10:23:52 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.25 $
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
import GF.Compile.MkConcrete
import GF.Shell
import GF.Shell.SubShell
import GF.Shell.ShellCommands
import GF.Shell.PShell
import GF.Shell.JGF
import GF.Text.UTF8

import GF.Today (today,version)
import GF.System.Arch
import System (getArgs)
import Control.Monad (foldM)

-- AR 19/4/2000 -- 28/4/2005

main :: IO ()
main = do
  xs <- getArgs
  let (os,fs) = getOptions "-" xs
      opt j   = oElem j os
      st0     = optInitShellState os
      ifNotSil c = if oElem beSilent os then return () else c 
  case 0 of

    _ | opt getHelp -> do
      putStrLnFlush $ encodeUTF8 helpMsg

    _ | opt forJava -> do
      putStrLnFlush $ encodeUTF8 welcomeMsg 
      st <- useIOE st0 $ 
              foldM (shellStateFromFiles os) st0 fs
      sessionLineJ True st
      return ()

    _ | opt doMake -> do
      case fs of
        [f] -> batchCompile os f
        _ -> putStrLnFlush "expecting exactly one gf file to compile"

    _ | opt makeConcrete -> do
        mapM_ mkConcrete fs

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

helpMsg = unlines [
  "Usage: gf <option>* <file>*",
  "Options:",
  "  -make         batch-compile files",
  "     -noemit      do not emit code when compiling",
  "     -v           be verbose when compiling",
  "  -batch        structure session by XML tags (use > to send into a file)",
  "  -makeconcrete batch-compile .gfp file to concrete syntax using parser",
  "  -help         show this message",
  "To use the GUI: jgf <option>* <file>*"
  ]

welcomeMsg = 
  "Welcome to " ++ authorMsg ++++ welcomeArch ++ "\n\nType 'h' for help."

authorMsg = unlines [
 "Grammatical Framework, Version " ++ version,
 "Compiled " ++ today,
 "Copyright (c)", 
 "Björn Bringert, Håkan Burden, Markus Forsberg, Thomas Hallgren, Harald Hammarström,",
 "Kristofer Johannisson, Janna Khegai, Peter Ljunglöf, Petri Mäenpää,", 
 "and Aarne Ranta, 1998-2005, under GNU General Public License (GPL)",
 "Bug reports to aarne@cs.chalmers.se"
 ]
