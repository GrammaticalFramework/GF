{-# LANGUAGE ForeignFunctionInterface #-}
#include <pgf/pgf.h>
#include <gu/enum.h>
#include <gu/exn.h>

module Gu where

import Foreign
import Foreign.C
import Foreign.C.String
import Foreign.Ptr


data GuEnum
data GuExn
data GuIn
data GuInStream
data GuKind
data GuString
data GuStringBuf
data GuMapItor
data GuOut
data GuOutStream
data GuPool

data PgfPGF
data PgfApplication
data PgfConcr
type PgfExpr = Ptr ()
data PgfExprEnum
data PgfExprProb
data PgfFullFormEntry
data PgfMorphoCallback
data PgfPrintContext
data PgfType
data PgfLexer

------------------------------------------------------------------------------
-- Mindless copypasting and translating of the C functions used in CRuntimeFFI
-- GU stuff



foreign import ccall "gu/mem.h gu_new_pool"
  gu_new_pool :: IO (Ptr GuPool)

foreign import ccall "gu/mem.h gu_pool_free"
  gu_pool_free :: Ptr GuPool -> IO ()

foreign import ccall "gu/mem.h &gu_pool_free"
  gu_pool_free_ptr :: FunPtr (Ptr GuPool -> IO ())

foreign import ccall "gu/exn.h gu_new_exn"
  gu_new_exn :: Ptr GuExn -> Ptr GuKind -> Ptr GuPool -> IO (Ptr GuExn)

foreign import ccall "gu/exn.h gu_exn_is_raised"
  gu_exn_is_raised :: Ptr GuExn -> IO Bool
-- gu_ok exn = do
--   state <- (#peek GuExn, state) exn
--   return (state /= GU_EXN_RAISED)

foreign import ccall "gu/type.h &gu_type__type"
  gu_type__type :: Ptr GuKind


--GuIn* gu_string_in(GuString string, GuPool* pool);
foreign import ccall "gu/string.h gu_string_in"
  gu_string_in :: CString -> Ptr GuPool -> IO (Ptr GuIn)

--GuStringBuf* gu_string_buf(GuPool* pool);
foreign import ccall "gu/string.h gu_string_buf"
  gu_string_buf :: Ptr GuPool -> IO (Ptr GuStringBuf)

--GuOut* gu_string_buf_out(GuStringBuf* sb);
foreign import ccall "gu/string.h gu_string_buf_out"
  gu_string_buf_out :: Ptr GuStringBuf -> IO (Ptr GuOut)


--void gu_enum_next(GuEnum* en, void* to, GuPool* pool)
foreign import ccall "gu/enum.h gu_enum_next"
  gu_enum_next :: Ptr a -> Ptr (Ptr b) -> Ptr GuPool -> IO ()


--GuString gu_string_buf_freeze(GuStringBuf* sb, GuPool* pool);
foreign import ccall "gu/string.h gu_string_buf_freeze"
  gu_string_buf_freeze :: Ptr GuStringBuf -> Ptr GuPool -> IO CString

{-
typedef struct PgfMorphoCallback PgfMorphoCallback;
struct PgfMorphoCallback {
       void (*callback)(PgfMorphoCallback* self,
                        PgfCId lemma, GuString analysis, prob_t prob,
			                 GuExn* err);
};
--allocate this type of structure in haskell
--make a function and do Something
-}

{- Not used
--GuIn* gu_new_in(GuInStream* stream, GuPool* pool);
foreign import ccall "gu/in.h gu_new_in"
  gu_new_in :: Ptr GuInStream -> Ptr GuPool -> Ptr GuIn

--GuOut* gu_new_out(GuOutStream* stream, GuPool* pool);
foreign import ccall "gu/mem.h gu_new_out"
  gu_new_out :: Ptr GuOutStream -> Ptr GuPool -> IO (Ptr GuOut)
--TODO no idea how to get a GuOutStream

--GuOut* gu_file_out(FILE* file, GuPool* pool);
foreign import ccall "gu/file.h gu_file_out"
  gu_file_out :: Ptr CString -> Ptr GuPool -> IO (Ptr GuOut) -}


--Pointer magic here, using plusPtr etc.
ptrToList :: Ptr PgfApplication -> Int -> IO [PgfExpr]
ptrToList appl arity = do
  let ptr = appl `plusPtr` (#offset PgfApplication, args) --args is not an argument, it's the actual field name
  sequence [peek (ptr `plusPtr` (i * (#size PgfExpr))) | i<-[0..arity-1]]




