----------------------------------------------------------------------
-- |
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:23:43 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.7 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Translate.GFT (main) where

import GF.Compile.ShellState
import GF.Canon.GetGFC
import GF.API

import GF.Text.Unicode
import GF.Text.UTF8
import GF.Infra.UseIO
import GF.Infra.Option
import GF.Infra.Modules (emptyMGrammar) ----
import GF.Data.Operations

import System
import Data.List


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

