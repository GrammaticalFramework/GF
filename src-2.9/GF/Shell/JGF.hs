----------------------------------------------------------------------
-- |
-- Module      : JGF
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/06/03 22:44:36 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.13 $
--
-- GF editing session controlled by e.g. a Java program. AR 16\/11\/2001
-----------------------------------------------------------------------------

module GF.Shell.JGF where

import GF.Data.Operations
import GF.Infra.UseIO
import GF.Text.Unicode

import GF.API.IOGrammar
import GF.Infra.Option
import GF.Compile.ShellState
import GF.UseGrammar.Session
import GF.Shell.Commands
import GF.Shell.CommandL
import GF.Text.UTF8

import Control.Monad (foldM)
import System



-- GF editing session controlled by e.g. a Java program. AR 16/11/2001

-- | the Boolean is a temporary hack to have two parallel GUIs
sessionLineJ :: Bool -> ShellState -> IO ()
sessionLineJ isNew env = do
  putStrLnFlush $ initEditMsgJavaX env
  let env' = addGlobalOptions (options [sizeDisplay "short",beSilent]) env
  editLoopJnewX isNew env' (initSState)

-- | this is the real version, with XML
--
-- the Boolean is a temporary hack to have two parallel GUIs
editLoopJnewX :: Bool -> CEnv -> SState -> IO ()
editLoopJnewX isNew env state = do
  mscs <- getCommandUTF (isCEnvUTF8 env state) ----
  let (ms,cs) = unzip mscs
      m = unlines ms --- ?
  if null cs 
    then editLoopJnewX isNew env state
    else
      case cs of
        [CQuit] -> return ()
        _ -> do
          (env',state') <- foldM exec (env,state) cs
          let inits = initAndEditMsgJavaX isNew env' state' m
          let 
            package = case last cs of
              CCEnvImport _         -> inits
              CCEnvEmptyAndImport _ -> inits
              CCEnvOpenTerm _       -> inits
              CCEnvOpenString _     -> inits
              CCEnvEmpty            -> initEditMsgJavaX env'
              _ -> displaySStateJavaX isNew env' state' m
          putStrLnFlush package
          editLoopJnewX isNew env' state'
 where
  exec (env,state) c = do
    execCommand env c state

welcome :: String
welcome = 
  "An experimental GF Editor for Java." ++ 
  "(c) Kristofer Johannisson, Janna Khegai, and Aarne Ranta 2002 under CNU GPL."

initEditMsgJavaX :: CEnv -> String
initEditMsgJavaX env = encodeUTF8 $ mkUnicode $ unlines $ tagXML "gfinit" $ 
  tagsXML "newcat"   [["n" +++ cat]     | (_,cat) <- newCatMenu env] ++
  tagXML  "topic"    [abstractName env] ++
  tagXML  "language" [prLanguage langAbstract] ++
  concat [tagAttrXML "language" ("file",file) [prLanguage lang] |
           (file,lang) <- zip (allGrammarFileNames env) (allLanguages env)]


initAndEditMsgJavaX :: Bool -> CEnv -> SState -> String -> String
initAndEditMsgJavaX isNew env state m = 
  initEditMsgJavaX env ++++ displaySStateJavaX isNew env state m
