----------------------------------------------------------------------
-- |
-- Module      : GetGFC
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/30 18:39:43 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.9 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Canon.GetGFC (getCanonModule, getCanonGrammar) where

import GF.Data.Operations
import GF.Canon.ParGFC
import GF.Canon.GFC
import GF.Canon.MkGFC
import GF.Infra.Modules
import GF.Compile.GetGrammar (err2err) ---
import GF.Infra.UseIO

import System.IO
import System.Directory
import Control.Monad

getCanonModule :: FilePath -> IOE CanonModule
getCanonModule file = do
  gr <- getCanonGrammar file
  case modules gr of
    [m] -> return m
    _ -> ioeErr $ Bad "expected exactly one module in a file"

getCanonGrammar :: FilePath -> IOE CanonGrammar
-- getCanonGrammar = getCanonGrammarByLine
getCanonGrammar file = do
  s <- ioeIO $ readFileIf file
  c <- ioeErr $ pCanon $ myLexer s
  return $ canon2grammar c

{-
-- the following surprisingly does not save memory so it is
-- not in use

getCanonGrammarByLine :: FilePath -> IOE CanonGrammar
getCanonGrammarByLine file = do
  b <- ioeIO $ doesFileExist file
  if not b 
    then ioeErr $ Bad $ "file" +++ file +++ "does not exist"
    else do
   ioeIO $ putStrLn ""
   hand <- ioeIO $ openFile file ReadMode ---- err
   size <- ioeIO $ hFileSize hand
   gr <- addNextLine (size,0) 1 hand emptyMGrammar
   ioeIO $ hClose hand
   return $ MGrammar $ reverse $ modules gr

 where
   addNextLine (size,act) d hand gr = do
     eof <- ioeIO $ hIsEOF hand 
     if eof 
       then return gr 
       else do
         s <- ioeIO  $ hGetLine hand
         let act' = act + toInteger (length s)
--         if isHash act act' then (ioeIO $ putChar '#') else return () 
         updGrammar act' d gr $ pLine $ myLexer s
    where     
      updGrammar a d gr (Ok t) = case buildCanonGrammar d gr t of 
        (gr',d') -> addNextLine (size,a) d' hand gr'
      updGrammar _ _ gr (Bad s) = do
        ioeIO $ putStrLn s
        return emptyMGrammar

      isHash a b = a `div` step < b `div` step
      step = size `div` 50
-}
