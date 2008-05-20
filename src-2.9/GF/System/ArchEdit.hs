----------------------------------------------------------------------
-- |
-- Module      : ArchEdit
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:46:15 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.System.ArchEdit (
  fudlogueEdit, fudlogueWrite, fudlogueWriteUni
 ) where

fudlogueEdit :: a -> b -> IO ()
fudlogueEdit _ _ = do
  putStrLn "sorry no fudgets available in Hugs"
  return ()

fudlogueWrite :: a -> b -> IO ()
fudlogueWrite _ _ = do
  putStrLn "sorry no fudgets available in Hugs"

fudlogueWriteUni :: a -> b -> IO ()
fudlogueWriteUni _ _ = do
  putStrLn "sorry no fudgets available in Hugs"
