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

module SharedString (shareString) where

import Data.HashTable as H
import System.IO.Unsafe (unsafePerformIO)

{-# NOINLINE stringPool #-}
stringPool :: HashTable String String
stringPool = unsafePerformIO $ new (==) hashString

{-# NOINLINE shareString #-}
shareString :: String -> String
shareString s = unsafePerformIO $ do
    mv <- H.lookup stringPool s
    case mv of
	    Just s' -> return s'
	    Nothing -> do
		       H.insert stringPool s s
		       return s
