{-# LANGUAGE ForeignFunctionInterface #-} 
-- GF Python bindings                                                                                                                                        -- Jordi Saludes, upc.edu 2010
-- Jordi Saludes, upc.edu 2010
--
module PyGF where

import PGF
import Foreign
import CString
import Foreign.C.Types
import Control.Monad

#include "pygf.h"

freeSp :: String -> Ptr a -> IO ()
freeSp tname p = do
    --DEBUG putStrLn $ "about to free pointer " ++ tname ++ " at " ++ (show p)
    sp <- (#peek PyGF, sp) p
    --DEBUG putStrLn "peeked"
    freeStablePtr sp
    --DEBUG putStrLn $ "freeing " ++ tname ++ " at " ++ (show p)

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

-- It is CId the same as Tree?

{- instance Storable CId where
    sizeOf _ = (#size PyGF)
    alignment _ = alignment (undefined::CInt)
    poke p o = do
      sp <- newStablePtr o
      (#poke PyGF, sp) p sp
    peek p = do
      sp <- (#peek PyGF, sp) p
      deRefStablePtr sp
-}

foreign export ccall gf_freePGF :: Ptr PGF -> IO ()
foreign export ccall gf_freeType :: Ptr Type -> IO ()
foreign export ccall gf_freeLanguage :: Ptr Language -> IO ()
foreign export ccall gf_freeTree :: Ptr Tree -> IO ()
foreign export ccall gf_freeExpr :: Ptr Expr -> IO ()
foreign export ccall gf_freeCId :: Ptr CId -> IO ()
gf_freePGF = freeSp "pgf"
gf_freeType = freeSp "type"
gf_freeLanguage = freeSp "language"
gf_freeTree = freeSp "tree"
gf_freeExpr = freeSp "expression"
gf_freeCId = freeSp "CId"

           
{-foreign export ccall gf_printCId :: Ptr CId-> IO CString
gf_printCId p = do
    c <- peek p
    newCString (showCId c)
-}

foreign export ccall gf_readPGF :: CString -> IO (Ptr PGF)
gf_readPGF path = do
  ppgf <- pyPGF
  p <- peekCString path
  readPGF p >>= poke ppgf
  return ppgf
  
foreign export ccall gf_readLanguage :: Ptr Language -> CString -> IO Bool
gf_readLanguage pt str = do
  s <- (peekCString str)
  case (readLanguage s) of
    Just x -> do
            poke pt x
            return True
    Nothing -> return False

foreign export ccall gf_startCat :: Ptr PGF -> IO (Ptr Type)
gf_startCat ppgf = do
  pgf <- peek ppgf
  pcat <- pyType
  poke pcat (startCat pgf)
  return pcat

foreign export ccall gf_parse :: Ptr PGF -> Ptr Language -> Ptr Type -> CString -> IO  (Ptr ())
gf_parse ppgf plang pcat input = do
  p <- peek ppgf
  c <- peek pcat
  i <- peekCString input
  l <- peek plang
  let parsed = parse p l c i
  --DEBUG putStrLn $  (show $ length  parsed) ++ " parsings"
  listToPy pyTree parsed
  
foreign export ccall gf_showExpr :: Ptr Expr -> IO CString
gf_showExpr pexpr = do
  e <- peek pexpr
  newCString (showExpr [] e)

listToPy :: Storable a => IO (Ptr a) -> [a] -> IO (Ptr ()) -- opaque -- IO (Ptr (Ptr Language))
listToPy mk ls = do
    pyls <- pyList
    mapM_ (mpoke pyls)  ls
    return pyls
  where  mpoke pyl l = do
          pl <- mk
          poke pl l
          pyl << pl
       
-- foreign export ccall "gf_freeArray" free :: Ptr a -> IO ()

              
foreign export ccall gf_showLanguage :: Ptr Language -> IO CString
gf_showLanguage plang = do
  l <- peek plang
  newCString $ showLanguage l

foreign export ccall gf_showType :: Ptr Type -> IO CString
gf_showType ptp = do
  t <- peek ptp
  newCString $ showType [] t

foreign export ccall gf_showPrintName :: Ptr PGF -> Ptr Language -> Ptr CId -> IO CString
gf_showPrintName ppgf plang pcid = do
  pgf <- peek ppgf
  lang <- peek plang
  cid <- peek pcid
  newCString (showPrintName pgf lang cid)

foreign export ccall gf_abstractName :: Ptr PGF -> IO (Ptr Language)
gf_abstractName ppgf = do
  pabs <- pyLang
  pgf <- peek ppgf
  poke pabs $ abstractName pgf
  return pabs

foreign export ccall gf_linearize :: Ptr PGF -> Ptr Language -> Ptr Tree -> IO CString
gf_linearize ppgf plang ptree = do
  pgf <- peek ppgf
  lang <- peek plang
  tree <- peek ptree
  newCString $ linearize pgf lang tree

foreign export ccall gf_languageCode :: Ptr PGF -> Ptr Language -> IO CString
gf_languageCode ppgf plang = do
  pgf <- peek ppgf
  lang <- peek plang
  case languageCode pgf lang of
    Just s -> newCString s
    Nothing -> return nullPtr

foreign export ccall gf_languages :: Ptr PGF -> IO (Ptr ()) -- (Ptr (Ptr Language))
gf_languages ppgf = do
  pgf <- peek ppgf
  listToPy pyLang $ languages pgf

foreign export ccall gf_categories :: Ptr PGF -> IO (Ptr ())
gf_categories ppgf = do
  pgf <- peek ppgf
  listToPy pyCId $ categories pgf

foreign export ccall gf_showCId :: Ptr CId -> IO CString
gf_showCId pcid = do
  cid <- peek pcid
  newCString $ showCId cid

foreign export ccall gf_unapp :: Ptr Expr -> IO (Ptr ())
foreign export ccall gf_unint :: Ptr Expr -> IO CInt
foreign export ccall gf_unstr :: Ptr Expr -> IO CString

gf_unapp pexp = do
    exp <- peek pexp
    case unApp exp of
        Just (f,args) -> do
                   puexp <- pyList
                   pf <- pyCId
                   poke pf f
                   puexp << pf
                   mapM_ (\e -> do
                              pe <- pyExpr
                              poke pe e
                              puexp << pe) args 
                   return puexp
        Nothing -> return nullPtr
gf_unint pexp = do
    exp <- peek pexp
    return $ fromIntegral $ case unInt exp of
                              Just n -> n
                              _      -> (-9)
gf_unstr pexp = do
   exp <- peek pexp
   case unStr exp of
        Just s -> newCString s
        _      -> return nullPtr

foreign export ccall gf_inferexpr :: Ptr PGF -> Ptr Expr -> IO (Ptr Type)
gf_inferexpr ppgf pexp = do
    pgf <- peek ppgf
    exp <- peek pexp
    case inferExpr pgf exp of
      Right (_,t) -> do
                 ptype <- pyType
                 poke ptype t
                 return ptype
      Left _       -> return nullPtr 


foreign export ccall gf_functions :: Ptr PGF -> IO (Ptr ())
gf_functions ppgf = do
    pgf <- peek ppgf
    listToPy pyCId $ functions pgf 

foreign export ccall gf_functiontype :: Ptr PGF -> Ptr CId -> IO (Ptr Type)
gf_functiontype ppgf pcid = do
    pgf <- peek ppgf
    cid <- peek pcid
    case functionType pgf cid of
        Just t -> do
               ptp <- pyType
               poke ptp t
               return ptp
        _      -> return nullPtr


foreign import ccall "newLang" pyLang :: IO (Ptr Language) 
foreign import ccall "newPGF" pyPGF :: IO (Ptr PGF) 
foreign import ccall "newTree" pyTree :: IO (Ptr Tree) 
foreign import ccall "newgfType" pyType :: IO (Ptr Type) 
foreign import ccall "newCId" pyCId :: IO (Ptr CId) 
foreign import ccall "newExpr" pyExpr :: IO (Ptr Expr) 
foreign import ccall "newList" pyList :: IO (Ptr ()) 
foreign import ccall "append" (<<) :: Ptr () -> Ptr a -> IO ()
