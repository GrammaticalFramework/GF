module SubShell where

import Operations
import UseIO
import ShellState
import Option
import API

import CommandL
import ArchEdit

-- AR 20/4/2000 -- 12/11/2001

editSession :: Options -> ShellState -> IO ()
editSession opts st
  | oElem makeFudget opts = fudlogueEdit font st'
  | otherwise             = initEditLoop st' (return ())
 where
   st'   = addGlobalOptions opts st
   font  = maybe myUniFont mkOptFont $ getOptVal opts useFont

myUniFont = "-mutt-clearlyu-medium-r-normal--0-0-100-100-p-0-iso10646-1"
mkOptFont = id

translateSession :: Options -> ShellState -> IO ()
translateSession opts st = do
  let grs   = allStateGrammars st
      cat   = firstCatOpts opts (firstStateGrammar st)
      trans s = unlines $
                if oElem showLang opts then 
                  [l +++ ":" +++ s | (l,s) <- zip (map (prIdent . cncId) grs) 
                                                  (translateBetweenAll grs cat s)]
                  else translateBetweenAll grs cat s
  translateLoop opts trans

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
