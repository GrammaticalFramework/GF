module JGF where

import Operations
import UseIO

import IOGrammar
import Option
import ShellState
import Session
import Commands
import CommandL

import System
import UTF8


-- GF editing session controlled by e.g. a Java program. AR 16/11/2001

sessionLineJ :: ShellState -> IO ()
sessionLineJ env = do
  putStrLnFlush $ initEditMsgJavaX env
  let env' = addGlobalOptions (options [sizeDisplay "short"]) env
  editLoopJ env' (initSState)

editLoopJ :: CEnv -> SState -> IO ()
editLoopJ = editLoopJnewX

-- this is the real version, with XML

editLoopJnewX :: CEnv -> SState -> IO ()
editLoopJnewX env state = do
  c <- getCommandUTF
  case c of
    CQuit -> return ()

    c -> do
      (env',state') <- execCommand env c state
      let package = case c of
            CCEnvImport _         -> initAndEditMsgJavaX env' state'
            CCEnvEmptyAndImport _ -> initAndEditMsgJavaX env' state'
            CCEnvOpenTerm _       -> initAndEditMsgJavaX env' state'
            CCEnvOpenString _     -> initAndEditMsgJavaX env' state'
            CCEnvEmpty            -> initEditMsgJavaX env'
            _ -> displaySStateJavaX env' state'
      putStrLnFlush package
      editLoopJnewX env' state'

welcome = 
  "An experimental GF Editor for Java." ++ 
  "(c) Kristofer Johannisson, Janna Khegai, and Aarne Ranta 2002 under CNU GPL."

initEditMsgJavaX env = encodeUTF8 $ unlines $ tagXML "gfinit" $ 
  tagsXML "newcat"   [["n" +++ cat]     | (_,cat) <- newCatMenu env] ++
  tagXML  "language" [prLanguage langAbstract] ++
  concat [tagAttrXML "language" ("file",file) [prLanguage lang] |
           (file,lang) <- zip (allGrammarFileNames env) (allLanguages env)]

initAndEditMsgJavaX env state = 
  initEditMsgJavaX env ++++ displaySStateJavaX env state
