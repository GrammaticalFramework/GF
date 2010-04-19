module GF.Text.Coding where

import qualified Data.ByteString as BS
import Data.ByteString.Internal
import GHC.IO
import GHC.IO.Buffer
import GHC.IO.Encoding
import GHC.IO.Exception
import Control.Monad

encodeUnicode :: TextEncoding -> String -> ByteString
encodeUnicode enc s =
  unsafePerformIO $ do
    let len = length s
    cbuf0 <- newCharBuffer (len*4) ReadBuffer
    foldM (\i c -> writeCharBuf (bufRaw cbuf0) i c) 0 s
    let cbuf = cbuf0{bufR=len}
    case enc of
      TextEncoding {mkTextEncoder=mk} -> do encoder <- mk
                                            bss <- translate (encode encoder) cbuf
                                            close encoder
                                            return (BS.concat bss)
  where
    translate cod cbuf
      | i < w     = do bbuf <- newByteBuffer 128 WriteBuffer
                       (cbuf,bbuf) <- cod cbuf bbuf
                       if isEmptyBuffer bbuf
                         then ioe_invalidCharacter
                         else do let bs = PS (bufRaw bbuf) (bufL bbuf) (bufR bbuf-bufL bbuf)
                                 bss <- translate cod cbuf
                                 return (bs:bss)
      | otherwise = return []
      where
        i = bufL cbuf
        w = bufR cbuf

decodeUnicode :: TextEncoding -> ByteString -> String
decodeUnicode enc (PS fptr l len) =
  unsafePerformIO $ do
    let bbuf = Buffer{bufRaw=fptr, bufState=ReadBuffer, bufSize=len, bufL=l, bufR=l+len}
    cbuf <- newCharBuffer 128 WriteBuffer
    case enc of
      TextEncoding {mkTextDecoder=mk} -> do decoder <- mk
                                            s <- translate (encode decoder) bbuf cbuf
                                            close decoder
                                            return s
  where
    translate cod bbuf cbuf
      | i < w     = do (bbuf,cbuf) <- cod bbuf cbuf
                       if isEmptyBuffer cbuf
                         then ioe_invalidCharacter
                         else unpack cod bbuf cbuf
      | otherwise = return []
      where
        i = bufL bbuf
        w = bufR bbuf
                                            
    unpack cod bbuf cbuf
      | i < w     = do (c,i') <- readCharBuf (bufRaw cbuf) i
                       cs <- unpack cod bbuf cbuf{bufL=i'}
                       return (c:cs)
      | otherwise = translate cod bbuf cbuf{bufL=0,bufR=0}
      where
        i = bufL cbuf
        w = bufR cbuf

ioe_invalidCharacter = ioException
   (IOError Nothing InvalidArgument ""
        ("invalid byte sequence for this encoding") Nothing Nothing)
