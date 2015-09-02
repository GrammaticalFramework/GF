{-# LANGUAGE ForeignFunctionInterface, MagicHash #-}
module SG.FFI where

import Foreign
import Foreign.C
import PGF2.FFI
import GHC.Ptr
import Data.Int

data SgSG
type SgId = Int64

foreign import ccall "sg/sg.h sg_open"
  sg_open :: CString -> Ptr GuExn -> IO (Ptr SgSG)

foreign import ccall "sg/sg.h sg_close"
  sg_close :: Ptr SgSG -> Ptr GuExn -> IO ()

foreign import ccall "sg/sg.h sg_begin_trans"
  sg_begin_trans :: Ptr SgSG -> Ptr GuExn -> IO ()

foreign import ccall "sg/sg.h sg_commit"
  sg_commit :: Ptr SgSG -> Ptr GuExn -> IO ()

foreign import ccall "sg/sg.h sg_rollback"
  sg_rollback :: Ptr SgSG -> Ptr GuExn -> IO ()

foreign import ccall "sg/sg.h sg_insert_expr"
  sg_insert_expr :: Ptr SgSG -> PgfExpr -> Ptr GuExn -> IO SgId

foreign import ccall "sg/sg.h sg_insert_triple"
  sg_insert_triple :: Ptr SgSG -> SgTriple -> Ptr GuExn -> IO SgId

type SgTriple = Ptr SgId

withTriple :: (SgTriple -> IO a) -> IO a
withTriple = allocaArray 3

gu_exn_type_SgError = Ptr "SgError"# :: CString
