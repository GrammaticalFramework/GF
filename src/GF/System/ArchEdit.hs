----------------------------------------------------------------------
-- |
-- Module      : ArchEdit
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/30 12:41:12 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.1 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module ArchEdit (
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
