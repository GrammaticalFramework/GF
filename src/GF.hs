module Main where

import GFModes
import Operations
import UseIO
import Option
import IOGrammar
import ShellState
import Shell
import SubShell
import ShellCommands
import PShell
import JGF
import UTF8

import Today (today)
import Arch
import System (getArgs)
import Monad (foldM)

-- AR 19/4/2000 -- 11/11/2001

main :: IO ()
main = do
  xs <- getArgs
  let (os,fs) = getOptions "-" xs
      opt j   = oElem j os
  case 0 of

    _ | opt getHelp -> do
      putStrLnFlush $ encodeUTF8 helpMsg

    _ | opt forJava -> do
      putStrLnFlush $ encodeUTF8 welcomeMsg 
      st <- useIOE emptyShellState $ 
              foldM (shellStateFromFiles os) emptyShellState fs
      sessionLineJ True st
      return ()

    _ | opt doMake -> do
      case fs of
        [f] -> batchCompile os f
        _ -> putStrLnFlush "expecting exactly one gf file to compile"

    _ | opt doBatch -> do
      if opt beSilent then return () else putStrLnFlush "<gfbatch>"
      st <- useIOE emptyShellState $ 
              foldM (shellStateFromFiles os) emptyShellState fs
      gfBatch (initHState st) 
      if opt beSilent then return () else putStrLnFlush "</gfbatch>"
      return ()
    _ -> do
      putStrLnFlush $ welcomeMsg
      st <- useIOE emptyShellState $ 
              foldM (shellStateFromFiles os) emptyShellState fs
      if null fs then return () else putCPU 
      gfInteract (initHState st) 
      return ()

helpMsg = unlines [
  "Usage: gf <option>* <file>*",
  "Options:",
  "  -make    batch-compile files",
  "   -noemit do not emit code when compiling",
  "   -v      be verbose when compiling",
  "  -batch   structure session by XML tags (use > to send into a file)",
  "  -help    show this message",
  "To use the GUI: jgf <option>* <file>*"
  ]

welcomeMsg = 
  "Welcome to " ++ authorMsg ++++ welcomeArch ++ "\n\nType 'h' for help."

authorMsg = unlines [
 "Grammatical Framework, Version 2-beta (incomplete functionality)",
 "April 1, 2004", 
--- "Compiled March 26, 2003",
 "Compiled " ++ today,
 "Copyright (c) Markus Forsberg, Thomas Hallgren, Harald Hammarström,",
 "Kristofer Johannisson, Janna Khegai, Peter Ljunglöf, Petri Mäenpää,", 
 "and Aarne Ranta, 1998-2003, under GNU General Public License (GPL)",
 "Bug reports to aarne@cs.chalmers.se"
 ]
