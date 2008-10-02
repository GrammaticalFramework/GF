module GF.Source.SharedString (shareString) where

import Data.Map as M
import Data.IORef
import qualified Data.ByteString.Char8 as BS
import System.IO.Unsafe (unsafePerformIO)

{-# NOINLINE stringPoolRef #-}
stringPoolRef :: IORef (M.Map BS.ByteString BS.ByteString)
stringPoolRef = unsafePerformIO $ newIORef M.empty

{-# NOINLINE shareString #-}
shareString :: BS.ByteString -> BS.ByteString
shareString s = unsafePerformIO $ do
  stringPool <- readIORef stringPoolRef
  case M.lookup s stringPool of
    Just s' -> return s'
    Nothing -> do let s' = BS.copy s
                  writeIORef stringPoolRef $! M.insert s' s' stringPool
                  return s'
