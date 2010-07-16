{-# LANGUAGE ForeignFunctionInterface #-} 
module PyGF where

import PGF
import Foreign
import CString
import Foreign.C.Types

#include "pygf.h"

-- type PyPtr = Ptr Py
freeSp :: String -> Ptr a -> IO ()
freeSp tname p = do
    sp <- (#peek PyGF, sp) p
    freeStablePtr sp
    putStrLn $ "freeing " ++ tname ++ " at " ++ (show p)

instance Storable PGF where
    sizeOf _ = (#size PyGF)
    alignment _ = alignment (undefined::CInt)
    poke p o = do
      sp <- newStablePtr o
      (#poke PyGF, sp) p sp
    peek p = do
      sp <- (#peek PyGF, sp) p
      deRefStablePtr sp

instance Storable Type where
    sizeOf _ = (#size PyGF)
    alignment _ = alignment (undefined::CInt)
    poke p o = do
      sp <- newStablePtr o
      (#poke PyGF, sp) p sp
    peek p = do
      sp <- (#peek PyGF, sp) p
      deRefStablePtr sp

instance Storable Language where
    sizeOf _ = (#size PyGF)
    alignment _ = alignment (undefined::CInt)
    poke p o = do
      sp <- newStablePtr o
      (#poke PyGF, sp) p sp
    peek p = do
      sp <- (#peek PyGF, sp) p
      deRefStablePtr sp

instance Storable Tree where
    sizeOf _ = (#size PyGF)
    alignment _ = alignment (undefined::CInt)
    poke p o = do
      sp <- newStablePtr o
      (#poke PyGF, sp) p sp
    peek p = do
      sp <- (#peek PyGF, sp) p
      deRefStablePtr sp

foreign export ccall gf_freePGF :: Ptr PGF -> IO ()
foreign export ccall gf_freeType :: Ptr Type -> IO ()
foreign export ccall gf_freeLanguage :: Ptr Language -> IO ()
gf_freePGF = freeSp "pgf"
gf_freeType = freeSp "type"
gf_freeLanguage = freeSp "language"

           
{-foreign export ccall gf_printCId :: Ptr CId-> IO CString
gf_printCId p = do
    c <- peek p
    newCString (showCId c)
-}
foreign export ccall gf_readPGF :: Ptr PGF -> CString -> IO ()
gf_readPGF pt path = do
  p <- (peekCString path)
  result <- (readPGF p)
  poke pt result
  
foreign export ccall gf_readLanguage :: Ptr Language -> CString -> IO Bool
gf_readLanguage pt str = do
  s <- (peekCString str)
  case (readLanguage s) of
    Just x -> do
            poke pt x
            return True
    Nothing -> return False

foreign export ccall gf_startCat :: Ptr PGF -> Ptr Type -> IO ()
gf_startCat ppgf pcat= do
  pgf <- peek ppgf
  poke pcat (startCat pgf)

foreign export ccall gf_parse :: Ptr PGF -> Ptr Language -> Ptr Type -> CString -> IO  (Ptr Tree)
gf_parse ppgf plang pcat input = do
  p <- peek ppgf
  c <- peek pcat
  i <- peekCString input
  l <- peek plang
  let parsed = parse p l c i
  -- putStrLn $  (show $ length  parsed) ++ " parsings"
  listToArray $ parsed
  
foreign export ccall gf_showExpr :: Ptr Expr -> IO CString
gf_showExpr pexpr = do
  e <- peek pexpr
  newCString (showExpr [] e)

listToArray :: Storable a => [a] -> IO (Ptr a)
listToArray list = do
    buf <- mallocBytes $ (#size PyGF) * (length list + 1)
    sequence $ zipWith (dpoke buf) [0..] list
    return buf
  where
    dpoke buf n x = do
              pokeElemOff buf n x
              
foreign export ccall gf_showLanguage :: Ptr Language -> IO CString
gf_showLanguage plang = do
  l <- peek plang
  newCString $ showLanguage l

foreign export ccall gf_showType :: Ptr Type -> IO CString
gf_showType ptp = do
  t <- peek ptp
  newCString $ showType [] t