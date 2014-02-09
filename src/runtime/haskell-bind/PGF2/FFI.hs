{-# LANGUAGE ForeignFunctionInterface #-}

module PGF2.FFI where

import Foreign.C
import Foreign.C.String
import Foreign.Ptr
import Foreign.ForeignPtr
import Control.Exception

------------------------------------------------------------------
-- libgu API

data GuEnum
data GuExn
data GuIn
data GuKind
data GuString
data GuStringBuf
data GuMapItor
data GuOut
data GuPool

foreign import ccall "gu/mem.h gu_new_pool"
  gu_new_pool :: IO (Ptr GuPool)

foreign import ccall "gu/mem.h gu_pool_free"
  gu_pool_free :: Ptr GuPool -> IO ()

foreign import ccall "gu/mem.h &gu_pool_free"
  gu_pool_finalizer :: FinalizerPtr GuPool

foreign import ccall "gu/exn.h gu_new_exn"
  gu_new_exn :: Ptr GuExn -> Ptr GuKind -> Ptr GuPool -> IO (Ptr GuExn)

foreign import ccall "gu/exn.h gu_exn_is_raised"
  gu_exn_is_raised :: Ptr GuExn -> IO Bool

foreign import ccall "gu/type.h &gu_type__type"
  gu_type__type :: Ptr GuKind

foreign import ccall "gu/string.h gu_string_in"
  gu_string_in :: CString -> Ptr GuPool -> IO (Ptr GuIn)

foreign import ccall "gu/string.h gu_string_buf"
  gu_string_buf :: Ptr GuPool -> IO (Ptr GuStringBuf)

foreign import ccall "gu/string.h gu_string_buf_out"
  gu_string_buf_out :: Ptr GuStringBuf -> IO (Ptr GuOut)

foreign import ccall "gu/enum.h gu_enum_next"
  gu_enum_next :: Ptr a -> Ptr (Ptr b) -> Ptr GuPool -> IO ()

foreign import ccall "gu/string.h gu_string_buf_freeze"
  gu_string_buf_freeze :: Ptr GuStringBuf -> Ptr GuPool -> IO CString

withGuPool :: (Ptr GuPool -> IO a) -> IO a
withGuPool f = bracket gu_new_pool gu_pool_free f


------------------------------------------------------------------
-- libpgf API

data PgfPGF
data PgfApplication
data PgfConcr
type PgfExpr = Ptr ()
data PgfExprProb
data PgfFullFormEntry
data PgfMorphoCallback
data PgfPrintContext
data PgfType

foreign import ccall "pgf/pgf.h pgf_read"
  pgf_read :: CString -> Ptr GuPool -> Ptr GuExn -> IO (Ptr PgfPGF)

foreign import ccall "pgf/pgf.h pgf_abstract_name"
  pgf_abstract_name :: Ptr PgfPGF -> IO CString

foreign import ccall "pgf/pgf.h pgf_iter_languages"
  pgf_iter_languages :: Ptr PgfPGF -> Ptr GuMapItor -> Ptr GuExn -> IO ()

foreign import ccall "pgf/pgf.h pgf_get_language"
  pgf_get_language :: Ptr PgfPGF -> CString -> IO (Ptr PgfConcr)

foreign import ccall "pgf/pgf.h pgf_concrete_name"
  pgf_concrete_name :: Ptr PgfConcr -> IO CString

foreign import ccall "pgf/pgf.h pgf_language_code"
  pgf_language_code :: Ptr PgfConcr -> IO CString

foreign import ccall "pgf/pgf.h pgf_iter_categories"
  pgf_iter_categories :: Ptr PgfPGF -> Ptr GuMapItor -> Ptr GuExn -> IO ()

foreign import ccall "pgf/pgf.h pgf_start_cat"
  pgf_start_cat :: Ptr PgfPGF -> IO CString

foreign import ccall "pgf/pgf.h pgf_iter_functions"
  pgf_iter_functions :: Ptr PgfPGF -> Ptr GuMapItor -> Ptr GuExn -> IO ()

foreign import ccall "pgf/pgf.h pgf_iter_functions_by_cat"
  pgf_iter_functions_by_cat :: Ptr PgfPGF -> Ptr GuMapItor -> Ptr GuExn -> IO ()

foreign import ccall "pgf/pgf.h pgf_function_type"
   pgf_function_type :: Ptr PgfPGF -> CString -> IO (Ptr PgfType)

foreign import ccall "pgf/pgf.h pgf_print_name"
  pgf_print_name :: Ptr PgfConcr -> CString -> IO CString

foreign import ccall "pgf/pgf.h pgf_linearize"
  pgf_linearize :: Ptr PgfConcr -> PgfExpr -> Ptr GuOut -> Ptr GuExn -> IO ()

foreign import ccall "pgf/pgf.h pgf_parse"
  pgf_parse :: Ptr PgfConcr -> CString -> CString -> Ptr GuExn -> Ptr GuPool -> Ptr GuPool -> IO (Ptr GuEnum)

foreign import ccall "pgf/pgf.h pgf_lookup_morpho"
  pgf_lookup_morpho :: Ptr PgfConcr -> CString -> Ptr PgfMorphoCallback -> Ptr GuExn -> IO ()

type LookupMorphoCallback = Ptr PgfMorphoCallback -> CString -> CString -> Float -> Ptr GuExn -> IO ()

foreign import ccall "wrapper"
  wrapLookupMorphoCallback :: LookupMorphoCallback -> IO (FunPtr LookupMorphoCallback)

type MapItorCallback = Ptr GuMapItor -> Ptr () -> Ptr () -> Ptr GuExn -> IO ()

foreign import ccall "wrapper"
  wrapMapItorCallback :: MapItorCallback -> IO (FunPtr MapItorCallback)

foreign import ccall "pgf/pgf.h pgf_fullform_lexicon"
  pgf_fullform_lexicon :: Ptr PgfConcr -> Ptr GuPool -> IO (Ptr GuEnum)

foreign import ccall "pgf/pgf.h pgf_fullform_get_string"
  pgf_fullform_get_string :: Ptr PgfFullFormEntry -> IO CString

foreign import ccall "pgf/pgf.h pgf_fullform_get_analyses"
  pgf_fullform_get_analyses :: Ptr PgfFullFormEntry -> Ptr PgfMorphoCallback -> Ptr GuExn -> IO ()
                    
foreign import ccall "pgf/pgf.h pgf_expr_unapply"
  pgf_expr_unapply :: PgfExpr -> Ptr GuPool -> IO (Ptr PgfApplication)

foreign import ccall "pgf/expr.h pgf_expr_arity"
  pgf_expr_arity :: PgfExpr -> IO Int

foreign import ccall "pgf/expr.h pgf_print_expr"
  pgf_print_expr :: PgfExpr -> Ptr PgfPrintContext -> Int -> Ptr GuOut -> Ptr GuExn -> IO ()

foreign import ccall "pgf/pgf.h pgf_generate_all"
  pgf_generate_all :: Ptr PgfPGF -> CString -> Ptr GuPool -> IO (Ptr GuEnum)

foreign import ccall "pgf/pgf.h pgf_print"
  pgf_print :: Ptr PgfPGF -> Ptr GuOut -> Ptr GuExn -> IO ()

foreign import ccall "pgf/expr.h pgf_read_expr"
  pgf_read_expr :: Ptr GuIn -> Ptr GuPool -> Ptr GuExn -> IO PgfExpr
