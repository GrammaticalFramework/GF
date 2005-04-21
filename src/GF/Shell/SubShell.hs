----------------------------------------------------------------------
-- |
-- Module      : SubShell
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:46:12 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.9 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Shell.SubShell where

import GF.Data.Operations
import GF.Infra.UseIO
import GF.Compile.ShellState
import GF.Infra.Option
import GF.API

import GF.Shell.CommandL
import GF.System.ArchEdit

import Data.List

-- AR 20/4/2000 -- 12/11/2001

editSession :: Options -> ShellState -> IO ()
editSession opts st
  | oElem makeFudget opts = fudlogueEdit font st'
  | otherwise             = initEditLoop st' (return ())
 where
   st'   = addGlobalOptions opts st
   font  = maybe myUniFont mkOptFont $ getOptVal opts useFont

myUniFont :: String
myUniFont = "-mutt-clearlyu-medium-r-normal--0-0-100-100-p-0-iso10646-1"

mkOptFont :: String -> String
mkOptFont = id

translateSession :: Options -> ShellState -> IO ()
translateSession opts st = do
  let grs   = allStateGrammars st
      cat   = firstCatOpts opts (firstStateGrammar st)
      trans s = unlines $ 
                if oElem showLang opts then 
                  sort $ [l +++ ":" +++ s | (l,s) <- zip (map (prIdent . cncId) grs) 
                                                     (translateBetweenAll grs cat s)]
                  else translateBetweenAll grs cat s
  translateLoop opts trans

translateLoop :: Options -> (String -> String) -> IO ()
translateLoop opts trans = do
  let fud  = oElem makeFudget opts
      font = maybe myUniFont mkOptFont $ getOptVal opts useFont
  if fud then fudlogueWrite font trans else loopLine
 where
   loopLine = do
     putStrFlush "trans> "
     s <- getLine
     if s == "." then return () else do
       putStrLnFlush $ trans s
       loopLine
