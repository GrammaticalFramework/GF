module CommandL where

import Operations
import UseIO

import CMacros

import GetTree
import ShellState
import Option
import Session
import Commands

import Char
import List (intersperse)

import UTF8

-- a line-based shell

initEditLoop :: CEnv -> IO () -> IO ()
initEditLoop env resume = do
  let env' = startEditEnv env
  putStrLnFlush $ initEditMsg env'
  let state = initSStateEnv env'
  putStrLnFlush $ showCurrentState env' state
  editLoop env' state resume

editLoop :: CEnv -> SState -> IO () -> IO ()
editLoop env state resume = do
  putStrFlush "edit> "
  c <- getCommand
  if (isQuit c) then resume else do
    (env',state') <- execCommand env c state
    let package = case c of
          CCEnvEmptyAndImport _ -> initEditMsgEmpty env'
          _ -> showCurrentState env' state'
    putStrLnFlush package

    editLoop env' state' resume

getCommand :: IO Command
getCommand = do
  s <- getLine
  return $ pCommand s

getCommandUTF :: IO Command
getCommandUTF = do
  s <- getLine
  return $ pCommand s  -- the GUI is doing this: $ decodeUTF8 s 

pCommand = pCommandWords . words where 
  pCommandWords s = case s of
    "n" : cat : _ -> CNewCat cat
    "t" : ws      -> CNewTree $ unwords ws
    "g" : ws      -> CRefineWithTree $ unwords ws  -- *g*ive
    "p" : ws      -> CRefineParse $ unwords ws
    "rc": i : _   -> CRefineWithClip (readIntArg i)
    ">" : i : _   -> CAhead $ readIntArg i
    ">" : []      -> CAhead 1
    "<" : i : _   -> CBack $ readIntArg i
    "<" : []      -> CBack 1
    ">>" : _      -> CNextMeta
    "<<" : _      -> CPrevMeta
    "'" : _       -> CTop
    "+" : _       -> CLast
    "mp" : p      -> CMovePosition (readIntList (unwords p))
    "r" : f : _   -> CRefineWithAtom f
    "w" : f:i : _ -> CWrapWithFun (f, readIntArg i)
    "ch": f : _   -> CChangeHead f
    "ph": f:i : _ -> CPeelHead (f, readIntArg i)
    "x" : ws      -> CAlphaConvert $ unwords ws
    "s" : i : _   -> CSelectCand (readIntArg i)
    "f" : "unstructured" : _ -> CRemoveOption showStruct --- hmmm
    "f" : "structured" : _ -> CAddOption showStruct --- hmmm
    "f" : s : _   -> CAddOption (filterString s)
    "u" : _       -> CUndo
    "d" : _       -> CDelete
    "ac" : _      -> CAddClip
    "c" : s : _   -> CTermCommand s
    "a" : _       -> CRefineRandom --- *a*leatoire
    "m" :  _      -> CMenu
    "ml" : s : _  -> changeMenuLanguage s
    "ms" : s : _  -> changeMenuSize s
    "mt" : s : _  -> changeMenuTyped s
    "v" : _       -> CView
    "q" : _       -> CQuit
    "h" : _       -> CHelp initEditMsg

    "i" : file: _ -> CCEnvImport file
    "e" : []      -> CCEnvEmpty
    "e" : file: _ -> CCEnvEmptyAndImport file

    "open" : f: _ -> CCEnvOpenTerm f
    "openstring": f: _ -> CCEnvOpenString f

    "on" :lang: _ -> CCEnvOn  lang 
    "off":lang: _ -> CCEnvOff lang 
    "pfile" :f:_  -> CCEnvRefineParse f
    "tfile" :f:_  -> CCEnvRefineWithTree f

-- openstring file
-- pfile file
-- tfile file
-- on lang
-- off lang

    "gf": comm    -> CCEnvGFShell (unwords comm)

    []            -> CVoid
    _             -> CError

-- well, this lists the commands of the line-based editor
initEditMsg env = unlines $
  "State-dependent editing commands are given in the menu:" :
  "  n [Cat] = new, r [Fun] = refine, w [Fun] [Int] = wrap,":
  "  ch [Fun] = change head, d = delete, s [Int] = select," :
  "  x [Var] [Var] = alpha convert." :
  "Commands changing the environment:" :
  "  i [file] = import, e = empty." :
  "Other commands:" : 
  "  a = random, v = change view, u = undo, h = help, q = quit," :
  "  ml [Lang] = change menu language," :
  "  ms (short | long) = change menu command size," :
  "  mt (typed | untyped) = change menu item typing," :
  "  p [string] = refine by parsing, g [term] = refine by term," :             
  "  > = down, < = up, ' = top, >> = next meta, << = previous meta." :
---- ("  c [" ++ unwords (intersperse "|" allTermCommands) ++ "] = modify term") : 
---- ("  f [" ++ unwords (intersperse "|" allStringCommands) ++ "] = modify output") : 
  []

initEditMsgEmpty env = initEditMsg env +++++ unlines (
  "Start editing by n Cat selecting category\n\n" :
  "-------------\n" :
  ["n" +++ cat | (_,cat) <- newCatMenu env]
  )

showCurrentState env' state' =
  unlines (tr ++ ["",""] ++ msg ++ ["",""] ++ map fst menu) 
                 where (tr,msg,menu) = displaySStateIn env' state'

-- to read position; borrowed from Prelude; should be elsewhere
readIntList :: String -> [Int]
readIntList s = case [x | (x,t) <- reads s, ("","") <- lex t] of
                  [x] -> x
                  _   -> []
