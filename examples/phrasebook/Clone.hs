module Main where

import Control.Monad
import Data.Maybe
import System.Cmd
import System.Directory
import System.Environment
import System.Exit


-- To clone a project from one language to another:
--
-- 1. for each Module in modules, copy ModuleFROM to ModuleTO
-- 2. in each ModuleTO, replace substrings FROM by TO, if not prefixes of an Ident
-- 3. in each ModuleTO in specifics, comment out every line in the body
--
-- Syntax:  runghc Clone FROM TO
-- Example: runhugs Clone Swe Nor

-- The following lines are for the phrasebook project, but can be modified to other projects.

modules   = "Phrasebook":"Sentences":specifics
specifics = ["Words","Greetings"]


main = do
  from:to:_ <- getArgs
  mapM_ (clone from to) modules

clone from to pref = do
  s <- readFile (pref ++ from ++ ".gf")
  writeFile (pref ++ to ++ ".gf") (commentIf (isSpecific pref) (replaceLang from to s))

isSpecific = flip elem specifics

replaceLang s1 s2 = repl where
  repl s = case s of
    c:cs -> case splitAt lgs s of
      (pre,c:rest) | pre == s1 && elem c " \n\t,:=(){}.-[];" -> s2 ++ [c] ++ repl rest
      _                      -> c : repl cs
    _ -> s
  lgs = 3 -- length s1

-- the file name has the form p....pLLL.gf, i.e. 3-letter lang name, suffix .gf
getLangName fi = let (nal,ferp) = splitAt 3 (drop 3 (reverse fi)) in (reverse ferp,reverse nal)  

commentIf c = if c then (unlines . commentBody . lines) else id

commentBody ss = header ++ map comment body ++ ["}"] where
  (header,body) = break (isJment . words) ss
  isJment ws = case ws of
    k:_ | elem k ["flags","lin","lincat","oper","param"] -> True
    _ -> False
  comment l = if take 2 l == "--" then l else "-- " ++ l
