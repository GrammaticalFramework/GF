{-# LANGUAGE ForeignFunctionInterface, MagicHash #-}
module SG.FFI where

import Foreign
import Foreign.C
import PGF2.FFI
import GHC.Ptr
import Data.Int

data SgSG
data SgQueryExprResult
data SgTripleResult
data SgQuery
data SgQueryResult
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
  sg_insert_expr :: Ptr SgSG -> PgfExpr -> CInt -> Ptr GuExn -> IO SgId

foreign import ccall "sg/sg.h sg_get_expr"
  sg_get_expr :: Ptr SgSG -> SgId -> Ptr GuPool -> Ptr GuExn -> IO PgfExpr

foreign import ccall "sg/sg.h sg_query_expr"
  sg_query_expr :: Ptr SgSG -> PgfExpr -> Ptr GuPool -> Ptr GuExn -> IO (Ptr SgQueryExprResult)

foreign import ccall "sg/sg.h sg_query_next"
  sg_query_next :: Ptr SgSG -> Ptr SgQueryExprResult -> Ptr SgId -> Ptr GuPool -> Ptr GuExn -> IO PgfExpr

foreign import ccall "sg/sg.h sg_query_close"
  sg_query_close :: Ptr SgSG -> Ptr SgQueryExprResult -> Ptr GuExn -> IO ()

foreign import ccall "sg/sg.h sg_update_fts_index"
  sg_update_fts_index :: Ptr SgSG -> Ptr PgfPGF -> Ptr GuExn -> IO ()

foreign import ccall "sg/sg.h sg_query_linearization"
  sg_query_linearization :: Ptr SgSG -> CString -> Ptr GuPool -> Ptr GuExn -> IO (Ptr GuSeq)

foreign import ccall "sg/sg.h sg_insert_triple"
  sg_insert_triple :: Ptr SgSG -> SgTriple -> Ptr GuExn -> IO SgId

foreign import ccall "sg/sg.h sg_get_triple"
  sg_get_triple :: Ptr SgSG -> SgId -> SgTriple -> Ptr GuPool -> Ptr GuExn -> IO CInt

foreign import ccall "sg/sg.h sg_query_triple"
  sg_query_triple :: Ptr SgSG -> SgTriple -> Ptr GuExn -> IO (Ptr SgTripleResult)

foreign import ccall "sg/sg.h sg_triple_result_fetch"
  sg_triple_result_fetch :: Ptr SgTripleResult -> Ptr SgId -> SgTriple -> Ptr GuPool -> Ptr GuExn -> IO CInt

foreign import ccall "sg/sg.h sg_triple_result_close"
  sg_triple_result_close :: Ptr SgTripleResult -> Ptr GuExn -> IO ()

foreign import ccall "sg/sg.h sg_prepare_query"
  sg_prepare_query :: Ptr SgSG -> CInt -> Ptr PgfExpr -> Ptr GuPool -> Ptr GuExn -> IO (Ptr SgQuery)

foreign import ccall "sg/sg.h sg_query"
  sg_query :: Ptr SgSG -> Ptr SgQuery -> Ptr GuExn -> IO (Ptr SgQueryResult)



type SgTriple = Ptr PgfExpr

withTriple :: (SgTriple -> IO a) -> IO a
withTriple = allocaArray 3

gu_exn_type_SgError = Ptr "SgError"# :: CString
