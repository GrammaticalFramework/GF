----------------------------------------------------------------------
-- |
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/16 05:40:50 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.6 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module Main (main) where

import ShellState
import GetGFC
import API

import Unicode
import UTF8
import UseIO
import Option
import Modules (emptyMGrammar) ----
import Operations

import System
import List


main :: IO ()
main = do
  file:_ <- getArgs
  let opts = noOptions
  can    <- useIOE (error "no grammar file") $ getCanonGrammar file
  st     <- err error return $ 
               grammar2shellState opts (can, emptyMGrammar)
  let grs = allStateGrammars st
  let cat = firstCatOpts opts (firstStateGrammar st)

----  interact (doTranslate grs cat)
  s <- getLine
  putStrLnFlush $ doTranslate grs cat $ drop 2 s -- to remove "n="

doTranslate grs cat s =
  let ss = [l +++ ":" +++ s | (l,s) <- zip (map (prIdent . cncId) grs) 
                                                (translateBetweenAll grs cat s)]
  in mkHTML ss

mkHTML = unlines . htmlDoc . intersperse "<p>" . map (encodeUTF8 . mkUnicode) . sort

htmlDoc ss = "<html>":metaHead:"<body>": ss ++ ["</body>","</html>"]

metaHead =
 "<HEAD><META http-equiv=Content-Type content=\"text/html; charset=utf-8\"></HEAD>"

