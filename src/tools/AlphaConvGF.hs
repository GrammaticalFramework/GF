----------------------------------------------------------------------
-- |
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/16 05:40:50 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.4 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module Main (main) where

import LexGF
import Alex
import System

main :: IO ()
main = do
  file1:file2:_ <- getArgs
  s  <- readFile file1
  ts <- tokens s
  if file1==file2 then print (length ts) else return () -- make sure file1 is in mem
  writeFile file2 []                       -- create file2 or remove its old contents
  alphaConv file2 ts (Pn 1 1 1)

alphaConv :: FilePath -> [Token] -> Posn -> IO ()
alphaConv file (t:ts) p0 = case t of
  PT p (TV s) -> changeId file p0 p s ts
  _ -> putToken file p0 t >>= alphaConv file ts
alphaConv _ _ = putStrLn "Ready."

putToken :: FilePath -> Posn -> Token -> IO Posn
putToken file (Pn _ l0 c0) t@(PT (Pn a l c) _) = do
  let s  = prToken t 
      ns = l - l0
      ls = length s
  replicate ns $ appendFile file '\n'
  replicate (if ns == 0 then c - c0 else c-1) $ putChar ' '
  putStr s 
  return $ Pn (a + ls) l (c + ls) ts
