----------------------------------------------------------------------
-- |
-- Module      : (Module)
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date $ 
-- > CVS $Author $
-- > CVS $Revision $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module JGF where

import Operations
import UseIO
import Unicode

import IOGrammar
import Option
import ShellState
import Session
import Commands
import CommandL

import System
import UTF8


-- GF editing session controlled by e.g. a Java program. AR 16/11/2001

---- the Boolean is a temporary hack to have two parallel GUIs
sessionLineJ :: Bool -> ShellState -> IO ()
sessionLineJ isNew env = do
  putStrLnFlush $ initEditMsgJavaX env
  let env' = addGlobalOptions (options [sizeDisplay "short",beSilent]) env
  editLoopJnewX isNew env' (initSState)

-- this is the real version, with XML

---- the Boolean is a temporary hack to have two parallel GUIs
editLoopJnewX :: Bool -> CEnv -> SState -> IO ()
editLoopJnewX isNew env state = do
  c <- getCommandUTF (isCEnvUTF8 env state) ----
  case c of
    CQuit -> return ()

    c -> do
      (env',state') <- execCommand env c state
      let inits = initAndEditMsgJavaX isNew env' state'
      let package = case c of
            CCEnvImport _         -> inits
            CCEnvEmptyAndImport _ -> inits
            CCEnvOpenTerm _       -> inits
            CCEnvOpenString _     -> inits
            CCEnvEmpty            -> initEditMsgJavaX env'
            _ -> displaySStateJavaX isNew env' state'
      putStrLnFlush package
      editLoopJnewX isNew env' state'

welcome = 
  "An experimental GF Editor for Java." ++ 
  "(c) Kristofer Johannisson, Janna Khegai, and Aarne Ranta 2002 under CNU GPL."

initEditMsgJavaX env = encodeUTF8 $ mkUnicode $ unlines $ tagXML "gfinit" $ 
  tagsXML "newcat"   [["n" +++ cat]     | (_,cat) <- newCatMenu env] ++
  tagXML  "topic"    [abstractName env] ++
  tagXML  "language" [prLanguage langAbstract] ++
  concat [tagAttrXML "language" ("file",file) [prLanguage lang] |
           (file,lang) <- zip (allGrammarFileNames env) (allLanguages env)]

initAndEditMsgJavaX isNew env state = 
  initEditMsgJavaX env ++++ displaySStateJavaX isNew env state
