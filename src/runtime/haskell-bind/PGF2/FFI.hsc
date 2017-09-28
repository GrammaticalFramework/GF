{-# LANGUAGE ForeignFunctionInterface, MagicHash, BangPatterns #-}

module PGF2.FFI where

#include <gu/defs.h>
#include <gu/hash.h>
#include <gu/utf8.h>
#include <pgf/pgf.h>

import Foreign ( alloca, peek, poke )
import Foreign.C
import Foreign.Ptr
import Foreign.ForeignPtr
import Control.Exception
import GHC.Ptr
import Data.Int
import Data.Word

type Touch = IO ()

-- | An abstract data type representing multilingual grammar
-- in Portable Grammar Format.
data PGF = PGF {pgf :: Ptr PgfPGF, touchPGF :: Touch}
data Concr = Concr {concr :: Ptr PgfConcr, touchConcr :: Touch}

------------------------------------------------------------------
-- libgu API

data GuEnum
data GuExn
data GuIn
data GuOut
data GuKind
data GuType
data GuString
data GuStringBuf
data GuMap
data GuMapItor
data GuHasher
data GuSeq
data GuBuf
data GuPool
type GuVariant = Ptr ()
type GuHash = (#type GuHash)
type GuUCS = (#type GuUCS)

type CSizeT = (#type size_t)
type CUInt8 = (#type uint8_t)

foreign import ccall unsafe fopen :: CString -> CString -> IO (Ptr ())

foreign import ccall unsafe "gu/mem.h gu_new_pool"
  gu_new_pool :: IO (Ptr GuPool)

foreign import ccall unsafe "gu/mem.h gu_malloc"
  gu_malloc :: Ptr GuPool -> CSizeT -> IO (Ptr a)

foreign import ccall unsafe "gu/mem.h gu_malloc_aligned"
  gu_malloc_aligned :: Ptr GuPool -> CSizeT -> CSizeT -> IO (Ptr a)

foreign import ccall unsafe "gu/mem.h gu_pool_free"
  gu_pool_free :: Ptr GuPool -> IO ()

foreign import ccall unsafe "gu/mem.h &gu_pool_free"
  gu_pool_finalizer :: FinalizerPtr GuPool

foreign import ccall unsafe "gu/exn.h gu_new_exn"
  gu_new_exn :: Ptr GuPool -> IO (Ptr GuExn)

foreign import ccall unsafe "gu/exn.h gu_exn_is_raised"
  gu_exn_is_raised :: Ptr GuExn -> IO Bool

foreign import ccall unsafe "gu/exn.h gu_exn_caught_"
  gu_exn_caught :: Ptr GuExn -> CString -> IO Bool

foreign import ccall unsafe "gu/exn.h gu_exn_raise_"
  gu_exn_raise :: Ptr GuExn -> CString -> IO (Ptr ())

gu_exn_type_GuErrno = Ptr "GuErrno"## :: CString

gu_exn_type_PgfLinNonExist = Ptr "PgfLinNonExist"## :: CString

gu_exn_type_PgfExn = Ptr "PgfExn"## :: CString

gu_exn_type_PgfParseError = Ptr "PgfParseError"## :: CString

gu_exn_type_PgfTypeError = Ptr "PgfTypeError"## :: CString

foreign import ccall unsafe "gu/string.h gu_string_in"
  gu_string_in :: CString -> Ptr GuPool -> IO (Ptr GuIn)

foreign import ccall unsafe "gu/string.h gu_new_string_buf"
  gu_new_string_buf :: Ptr GuPool -> IO (Ptr GuStringBuf)

foreign import ccall unsafe "gu/string.h gu_string_buf_out"
  gu_string_buf_out :: Ptr GuStringBuf -> IO (Ptr GuOut)

foreign import ccall unsafe "gu/file.h gu_file_in"
  gu_file_in :: Ptr () -> Ptr GuPool -> IO (Ptr GuIn)

foreign import ccall unsafe "gu/enum.h gu_enum_next"
  gu_enum_next :: Ptr a -> Ptr (Ptr b) -> Ptr GuPool -> IO ()
 
foreign import ccall unsafe "gu/string.h gu_string_buf_freeze"
  gu_string_buf_freeze :: Ptr GuStringBuf -> Ptr GuPool -> IO CString

foreign import ccall unsafe "gu/utf8.h gu_utf8_decode"
  gu_utf8_decode :: Ptr CString -> IO GuUCS

foreign import ccall unsafe "gu/utf8.h gu_utf8_encode"
  gu_utf8_encode :: GuUCS -> Ptr CString -> IO ()

foreign import ccall unsafe "gu/seq.h gu_make_seq"
  gu_make_seq :: CSizeT -> CSizeT -> Ptr GuPool -> IO (Ptr GuSeq)

foreign import ccall unsafe "gu/seq.h gu_make_buf"
  gu_make_buf :: CSizeT -> Ptr GuPool -> IO (Ptr GuBuf)

foreign import ccall unsafe "gu/map.h gu_make_map"
  gu_make_map :: CSizeT -> Ptr GuHasher -> CSizeT -> Ptr a -> CSizeT -> Ptr GuPool -> IO (Ptr GuMap)

foreign import ccall unsafe "gu/map.h gu_map_insert"
  gu_map_insert :: Ptr GuMap -> Ptr a -> IO (Ptr b)

foreign import ccall unsafe "gu/map.h gu_map_find_default"
  gu_map_find_default :: Ptr GuMap -> Ptr a -> IO (Ptr b)

foreign import ccall "gu/map.h gu_map_iter"
  gu_map_iter :: Ptr GuMap -> Ptr GuMapItor -> Ptr GuExn -> IO ()

foreign import ccall unsafe "gu/hash.h &gu_int_hasher"
  gu_int_hasher :: Ptr GuHasher

foreign import ccall unsafe "gu/hash.h &gu_addr_hasher"
  gu_addr_hasher :: Ptr GuHasher

foreign import ccall unsafe "gu/hash.h &gu_string_hasher"
  gu_string_hasher :: Ptr GuHasher

foreign import ccall unsafe "gu/hash.h &gu_null_struct"
  gu_null_struct :: Ptr a

foreign import ccall unsafe "gu/variant.h gu_variant_tag"
  gu_variant_tag :: GuVariant -> IO CInt

foreign import ccall unsafe "gu/variant.h gu_variant_data"
  gu_variant_data :: GuVariant -> IO (Ptr a)

foreign import ccall unsafe "gu/variant.h gu_alloc_variant"
  gu_alloc_variant :: CUInt8 -> CSizeT -> CSizeT -> Ptr GuVariant -> Ptr GuPool -> IO (Ptr a)


withGuPool :: (Ptr GuPool -> IO a) -> IO a
withGuPool f = bracket gu_new_pool gu_pool_free f

newOut :: Ptr GuPool -> IO (Ptr GuStringBuf, Ptr GuOut)
newOut pool =
   do sb  <- gu_new_string_buf pool
      out <- gu_string_buf_out sb
      return (sb,out)

peekUtf8CString :: CString -> IO String
peekUtf8CString ptr =
  alloca $ \pptr ->
    poke pptr ptr >> decode pptr
  where
    decode pptr = do
      x <- gu_utf8_decode pptr
      if x == 0
        then return []
        else do cs <- decode pptr
                return (((toEnum . fromEnum) x) : cs)

peekUtf8CStringLen :: CString -> CInt -> IO String
peekUtf8CStringLen ptr len =
  alloca $ \pptr ->
    poke pptr ptr >> decode pptr (ptr `plusPtr` fromIntegral len)
  where
    decode pptr end = do
      ptr <- peek pptr
      if ptr >= end
        then return []
        else do x <- gu_utf8_decode pptr
                cs <- decode pptr end
                return (((toEnum . fromEnum) x) : cs)

pokeUtf8CString :: String -> CString -> IO ()
pokeUtf8CString s ptr =
  alloca $ \pptr ->
    poke pptr ptr >> encode s pptr
  where
    encode []     pptr = do
      gu_utf8_encode 0 pptr
    encode (c:cs) pptr = do
      gu_utf8_encode ((toEnum . fromEnum) c) pptr
      encode cs pptr

newUtf8CString :: String -> Ptr GuPool -> IO CString
newUtf8CString s pool = do
  ptr <- gu_malloc pool (fromIntegral (utf8Length s))
  pokeUtf8CString s ptr
  return ptr

utf8Length s = count 0 s
  where
    count !c []         = c+1
    count !c (x:xs)
      | ucs < 0x80      = count (c+1) xs
      | ucs < 0x800     = count (c+2) xs
      | ucs < 0x10000   = count (c+3) xs
      | ucs < 0x200000  = count (c+4) xs
      | ucs < 0x4000000 = count (c+5) xs
      | otherwise       = count (c+6) xs
      where
        ucs = fromEnum x

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
type PgfType = Ptr ()
data PgfCallbacksMap
data PgfOracleCallback
data PgfCncTree
data PgfLinFuncs
data PgfGraphvizOptions
type PgfBindType = (#type PgfBindType)
data PgfAbsFun
data PgfAbsCat
data PgfCCat
data PgfCncFun
data PgfProductionApply

foreign import ccall "pgf/pgf.h pgf_read"
  pgf_read :: CString -> Ptr GuPool -> Ptr GuExn -> IO (Ptr PgfPGF)

foreign import ccall "pgf/pgf.h pgf_write"
  pgf_write :: Ptr PgfPGF -> CString -> Ptr GuExn -> IO ()

foreign import ccall "pgf/pgf.h pgf_abstract_name"
  pgf_abstract_name :: Ptr PgfPGF -> IO CString

foreign import ccall "pgf/pgf.h pgf_iter_languages"
  pgf_iter_languages :: Ptr PgfPGF -> Ptr GuMapItor -> Ptr GuExn -> IO ()

foreign import ccall "pgf/pgf.h pgf_get_language"
  pgf_get_language :: Ptr PgfPGF -> CString -> IO (Ptr PgfConcr)

foreign import ccall "pgf/pgf.h pgf_concrete_name"
  pgf_concrete_name :: Ptr PgfConcr -> IO CString

foreign import ccall "pgf/pgf.h pgf_concrete_load"
  pgf_concrete_load :: Ptr PgfConcr -> Ptr GuIn -> Ptr GuExn -> IO ()

foreign import ccall "pgf/pgf.h pgf_concrete_unload"
  pgf_concrete_unload :: Ptr PgfConcr -> IO ()

foreign import ccall "pgf/pgf.h pgf_language_code"
  pgf_language_code :: Ptr PgfConcr -> IO CString

foreign import ccall "pgf/pgf.h pgf_iter_categories"
  pgf_iter_categories :: Ptr PgfPGF -> Ptr GuMapItor -> Ptr GuExn -> IO ()

foreign import ccall "pgf/pgf.h pgf_start_cat"
  pgf_start_cat :: Ptr PgfPGF -> Ptr GuPool -> IO PgfType

foreign import ccall "pgf/pgf.h pgf_iter_functions"
  pgf_iter_functions :: Ptr PgfPGF -> Ptr GuMapItor -> Ptr GuExn -> IO ()

foreign import ccall "pgf/pgf.h pgf_iter_functions_by_cat"
  pgf_iter_functions_by_cat :: Ptr PgfPGF -> CString -> Ptr GuMapItor -> Ptr GuExn -> IO ()

foreign import ccall "pgf/pgf.h pgf_function_type"
   pgf_function_type :: Ptr PgfPGF -> CString -> IO PgfType

foreign import ccall "pgf/pgf.h pgf_print_name"
  pgf_print_name :: Ptr PgfConcr -> CString -> IO CString

foreign import ccall "pgf/pgf.h pgf_has_linearization"
  pgf_has_linearization :: Ptr PgfConcr -> CString -> IO CInt

foreign import ccall "pgf/pgf.h pgf_linearize"
  pgf_linearize :: Ptr PgfConcr -> PgfExpr -> Ptr GuOut -> Ptr GuExn -> IO ()

foreign import ccall "pgf/pgf.h pgf_lzr_concretize"
  pgf_lzr_concretize :: Ptr PgfConcr -> PgfExpr -> Ptr GuExn -> Ptr GuPool -> IO (Ptr GuEnum)

foreign import ccall "pgf/pgf.h pgf_lzr_wrap_linref"
  pgf_lzr_wrap_linref :: Ptr PgfCncTree -> Ptr GuPool -> IO (Ptr PgfCncTree)

foreign import ccall "pgf/pgf.h pgf_lzr_linearize_simple"
  pgf_lzr_linearize_simple :: Ptr PgfConcr -> Ptr PgfCncTree -> CSizeT -> Ptr GuOut -> Ptr GuExn -> Ptr GuPool -> IO ()

foreign import ccall "pgf/pgf.h pgf_lzr_linearize"
  pgf_lzr_linearize :: Ptr PgfConcr -> Ptr PgfCncTree -> CSizeT -> Ptr (Ptr PgfLinFuncs) -> Ptr GuPool -> IO ()

foreign import ccall "pgf/pgf.h pgf_lzr_get_table"
  pgf_lzr_get_table :: Ptr PgfConcr -> Ptr PgfCncTree -> Ptr CSizeT -> Ptr (Ptr CString) -> IO ()

type SymbolTokenCallback = Ptr (Ptr PgfLinFuncs) -> CString -> IO ()
type PhraseCallback = Ptr (Ptr PgfLinFuncs) -> CString -> CInt -> CSizeT -> CString -> IO ()
type NonExistCallback = Ptr (Ptr PgfLinFuncs) -> IO ()
type MetaCallback = Ptr (Ptr PgfLinFuncs) -> CInt -> IO ()

foreign import ccall "wrapper"
  wrapSymbolTokenCallback :: SymbolTokenCallback -> IO (FunPtr SymbolTokenCallback)

foreign import ccall "wrapper"
  wrapPhraseCallback :: PhraseCallback -> IO (FunPtr PhraseCallback)

foreign import ccall "wrapper"
  wrapSymbolNonExistCallback :: NonExistCallback -> IO (FunPtr NonExistCallback)

foreign import ccall "wrapper"
  wrapSymbolMetaCallback :: MetaCallback -> IO (FunPtr MetaCallback)

foreign import ccall "pgf/pgf.h pgf_align_words"
  pgf_align_words :: Ptr PgfConcr -> PgfExpr -> Ptr GuExn -> Ptr GuPool -> IO (Ptr GuSeq)

foreign import ccall "pgf/pgf.h pgf_parse_with_heuristics"
  pgf_parse_with_heuristics :: Ptr PgfConcr -> PgfType -> CString -> Double -> Ptr PgfCallbacksMap -> Ptr GuExn -> Ptr GuPool -> Ptr GuPool -> IO (Ptr GuEnum)

foreign import ccall "pgf/pgf.h pgf_lookup_sentence"
  pgf_lookup_sentence :: Ptr PgfConcr -> PgfType -> CString -> Ptr GuPool -> Ptr GuPool -> IO (Ptr GuEnum)

type LiteralMatchCallback = CSizeT -> Ptr CSizeT -> Ptr GuPool -> IO (Ptr PgfExprProb)

foreign import ccall "wrapper"
  wrapLiteralMatchCallback :: LiteralMatchCallback -> IO (FunPtr LiteralMatchCallback)

type LiteralPredictCallback = CSizeT -> CString -> Ptr GuPool -> IO (Ptr PgfExprProb)

foreign import ccall "wrapper"
  wrapLiteralPredictCallback :: LiteralPredictCallback -> IO (FunPtr LiteralPredictCallback)

foreign import ccall "pgf/pgf.h pgf_new_callbacks_map"
  pgf_new_callbacks_map :: Ptr PgfConcr -> Ptr GuPool -> IO (Ptr PgfCallbacksMap)

foreign import ccall
  hspgf_callbacks_map_add_literal :: Ptr PgfConcr -> Ptr PgfCallbacksMap -> CString -> FunPtr LiteralMatchCallback -> FunPtr LiteralPredictCallback -> Ptr GuPool -> IO ()

type OracleCallback = CString -> CString -> CSizeT -> IO Bool
type OracleLiteralCallback = CString -> CString -> Ptr CSizeT -> Ptr GuPool -> IO (Ptr PgfExprProb)

foreign import ccall "wrapper"
  wrapOracleCallback :: OracleCallback -> IO (FunPtr OracleCallback)

foreign import ccall "wrapper"
  wrapOracleLiteralCallback :: OracleLiteralCallback -> IO (FunPtr OracleLiteralCallback)

foreign import ccall
  hspgf_new_oracle_callback :: CString -> FunPtr OracleCallback -> FunPtr OracleCallback -> FunPtr OracleLiteralCallback -> Ptr GuPool -> IO (Ptr PgfOracleCallback)

foreign import ccall "pgf/pgf.h pgf_parse_with_oracle"
  pgf_parse_with_oracle :: Ptr PgfConcr -> CString -> CString -> Ptr PgfOracleCallback -> Ptr GuExn -> Ptr GuPool -> Ptr GuPool -> IO (Ptr GuEnum)

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

foreign import ccall "pgf/pgf.h pgf_expr_apply"
  pgf_expr_apply :: Ptr PgfApplication -> Ptr GuPool -> IO PgfExpr

foreign import ccall "pgf/pgf.h pgf_expr_unapply"
  pgf_expr_unapply :: PgfExpr -> Ptr GuPool -> IO (Ptr PgfApplication)

foreign import ccall "pgf/pgf.h pgf_expr_abs"
  pgf_expr_abs :: PgfBindType -> CString -> PgfExpr -> Ptr GuPool -> IO PgfExpr

foreign import ccall "pgf/pgf.h pgf_expr_unabs"
  pgf_expr_unabs :: PgfExpr -> IO (Ptr a)

foreign import ccall "pgf/pgf.h pgf_expr_meta"
  pgf_expr_meta :: CInt -> Ptr GuPool -> IO PgfExpr

foreign import ccall "pgf/pgf.h pgf_expr_unmeta"
  pgf_expr_unmeta :: PgfExpr -> IO (Ptr a)

foreign import ccall "pgf/pgf.h pgf_expr_string"
  pgf_expr_string :: CString -> Ptr GuPool -> IO PgfExpr

foreign import ccall "pgf/pgf.h pgf_expr_int"
  pgf_expr_int :: CInt -> Ptr GuPool -> IO PgfExpr

foreign import ccall "pgf/pgf.h pgf_expr_float"
  pgf_expr_float :: CDouble -> Ptr GuPool -> IO PgfExpr

foreign import ccall "pgf/pgf.h pgf_expr_unlit"
  pgf_expr_unlit :: PgfExpr -> CInt -> IO (Ptr a)

foreign import ccall "pgf/expr.h pgf_expr_arity"
  pgf_expr_arity :: PgfExpr -> IO CInt

foreign import ccall "pgf/expr.h pgf_expr_eq"
  pgf_expr_eq :: PgfExpr -> PgfExpr -> IO CInt

foreign import ccall "pgf/expr.h pgf_expr_hash"
  pgf_expr_hash :: GuHash -> PgfExpr -> IO GuHash

foreign import ccall "pgf/expr.h pgf_expr_size"
  pgf_expr_size :: PgfExpr -> IO CInt

foreign import ccall "pgf/expr.h pgf_expr_functions"
  pgf_expr_functions :: PgfExpr -> Ptr GuPool -> IO (Ptr GuSeq)

foreign import ccall "pgf/expr.h pgf_compute_tree_probability"
  pgf_compute_tree_probability :: Ptr PgfPGF -> PgfExpr -> IO CFloat

foreign import ccall "pgf/expr.h pgf_check_expr"
  pgf_check_expr :: Ptr PgfPGF -> Ptr PgfExpr -> PgfType -> Ptr GuExn -> Ptr GuPool -> IO ()

foreign import ccall "pgf/expr.h pgf_infer_expr"
  pgf_infer_expr :: Ptr PgfPGF -> Ptr PgfExpr -> Ptr GuExn -> Ptr GuPool -> IO PgfType

foreign import ccall "pgf/expr.h pgf_check_type"
  pgf_check_type :: Ptr PgfPGF -> Ptr PgfType -> Ptr GuExn -> Ptr GuPool -> IO ()

foreign import ccall "pgf/expr.h pgf_compute"
  pgf_compute :: Ptr PgfPGF -> PgfExpr -> Ptr GuExn -> Ptr GuPool -> Ptr GuPool -> IO PgfExpr

foreign import ccall "pgf/expr.h pgf_print_expr"
  pgf_print_expr :: PgfExpr -> Ptr PgfPrintContext -> CInt -> Ptr GuOut -> Ptr GuExn -> IO ()

foreign import ccall "pgf/expr.h pgf_print_expr_tuple"
  pgf_print_expr_tuple :: CSizeT -> Ptr PgfExpr -> Ptr PgfPrintContext -> Ptr GuOut -> Ptr GuExn -> IO ()

foreign import ccall "pgf/expr.h pgf_print_category"
  pgf_print_category :: Ptr PgfPGF -> CString -> Ptr GuOut -> Ptr GuExn -> IO ()

foreign import ccall "pgf/expr.h pgf_print_type"
  pgf_print_type :: PgfType -> Ptr PgfPrintContext -> CInt -> Ptr GuOut -> Ptr GuExn -> IO ()

foreign import ccall "pgf/pgf.h pgf_generate_all"
  pgf_generate_all :: Ptr PgfPGF -> PgfType -> Ptr GuExn -> Ptr GuPool -> Ptr GuPool -> IO (Ptr GuEnum)

foreign import ccall "pgf/pgf.h pgf_print"
  pgf_print :: Ptr PgfPGF -> Ptr GuOut -> Ptr GuExn -> IO ()

foreign import ccall "pgf/expr.h pgf_read_expr"
  pgf_read_expr :: Ptr GuIn -> Ptr GuPool -> Ptr GuExn -> IO PgfExpr

foreign import ccall "pgf/expr.h pgf_read_expr_tuple"
  pgf_read_expr_tuple :: Ptr GuIn -> CSizeT -> Ptr PgfExpr -> Ptr GuPool -> Ptr GuExn -> IO CInt

foreign import ccall "pgf/expr.h pgf_read_expr_matrix"
  pgf_read_expr_matrix :: Ptr GuIn -> CSizeT -> Ptr GuPool -> Ptr GuExn -> IO (Ptr GuSeq)

foreign import ccall "pgf/expr.h pgf_read_type"
  pgf_read_type :: Ptr GuIn -> Ptr GuPool -> Ptr GuExn -> IO PgfType

foreign import ccall "pgf/graphviz.h pgf_graphviz_abstract_tree"
  pgf_graphviz_abstract_tree :: Ptr PgfPGF -> PgfExpr -> Ptr PgfGraphvizOptions -> Ptr GuOut -> Ptr GuExn -> IO ()

foreign import ccall "pgf/graphviz.h pgf_graphviz_parse_tree"
  pgf_graphviz_parse_tree :: Ptr PgfConcr -> PgfExpr -> Ptr PgfGraphvizOptions -> Ptr GuOut -> Ptr GuExn -> IO ()

foreign import ccall "pgf/graphviz.h pgf_graphviz_word_alignment"
  pgf_graphviz_word_alignment :: Ptr (Ptr PgfConcr) -> CSizeT -> PgfExpr -> Ptr PgfGraphvizOptions -> Ptr GuOut -> Ptr GuExn -> IO ()

foreign import ccall "pgf/data.h pgf_parser_index"
  pgf_parser_index :: Ptr PgfConcr -> Ptr PgfCCat -> GuVariant -> (#type bool) -> Ptr GuPool -> IO ()

foreign import ccall "pgf/data.h pgf_lzr_index"
  pgf_lzr_index :: Ptr PgfConcr -> Ptr PgfCCat -> GuVariant -> (#type bool) -> Ptr GuPool -> IO ()

foreign import ccall "pgf/data.h pgf_production_is_lexical"
  pgf_production_is_lexical :: Ptr PgfProductionApply -> Ptr GuBuf -> Ptr GuPool -> IO (#type bool)
