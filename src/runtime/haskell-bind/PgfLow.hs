{-# LANGUAGE ForeignFunctionInterface #-}

module PgfLow where

import Foreign.C
import Foreign.C.String
import Foreign.Ptr
import Gu

------------------------------------------------------------------------------
-- Mindless copypasting and translating of the C functions used in CRuntimeFFI
-- From pgf.h



-- PgfPGF* pgf_read(const char* fpath, GuPool* pool, GuExn* err);
foreign import ccall "pgf/pgf.h pgf_read"
  pgf_read :: CString -> Ptr GuPool -> Ptr GuExn -> IO (Ptr PgfPGF)

-- GuString pgf_abstract_name(PgfPGF*);
foreign import ccall "pgf/pgf.h pgf_abstract_name"
  pgf_abstract_name :: Ptr PgfPGF -> IO CString

-- void pgf_iter_languages(PgfPGF*, GuMapItor*, GuExn* err);
foreign import ccall "pgf/pgf.h pgf_iter_languages"
  pgf_iter_languages :: Ptr PgfPGF -> Ptr GuMapItor -> Ptr GuExn -> IO ()
-- TODO test this function
-- GuMapItor???
-- implement a fun in haskell, export it to c
-- GuMapItor contains a pointer to a function
-- Ask Koen
-- foreign export

-- PgfConcr* pgf_get_language(PgfPGF*, PgfCId lang);
foreign import ccall "pgf/pgf.h pgf_get_language"
  pgf_get_language :: Ptr PgfPGF -> CString -> IO (Ptr PgfConcr)


-- GuString pgf_concrete_name(PgfConcr*);
foreign import ccall "pgf/pgf.h pgf_concrete_name"
  pgf_concrete_name :: Ptr PgfConcr -> IO CString

-- GuString pgf_language_code(PgfConcr* concr);
foreign import ccall "pgf/pgf.h pgf_language_code"
  pgf_language_code :: Ptr PgfConcr -> IO CString


--void pgf_iter_categories(PgfPGF* pgf, GuMapItor* fn, GuExn* err);
foreign import ccall "pgf/pgf.h pgf_iter_categories"
  pgf_iter_categories :: Ptr PgfPGF -> Ptr GuMapItor -> Ptr GuExn -> IO ()
--TODO test this function

-- PgfCId pgf_start_cat(PgfPGF* pgf, GuPool* pool);
foreign import ccall "pgf/pgf.h pgf_start_cat"
  pgf_start_cat :: Ptr PgfPGF -> IO CString

-- void pgf_iter_functions(PgfPGF* pgf, GuMapItor* fn, GuExn* err);
foreign import ccall "pgf/pgf.h pgf_iter_functions"
  pgf_iter_functions :: Ptr PgfPGF -> Ptr GuMapItor -> Ptr GuExn -> IO ()
--TODO test this function

-- void pgf_iter_functions_by_cat(PgfPGF* pgf, PgfCId catname,
--                          GuMapItor* fn, GuExn* err);
foreign import ccall "pgf/pgf.h pgf_iter_functions_by_cat"
  pgf_iter_functions_by_cat :: Ptr PgfPGF -> Ptr GuMapItor -> Ptr GuExn -> IO ()
--TODO test this function

-- PgfType* pgf_function_type(PgfPGF* pgf, PgfCId funname); 
foreign import ccall "pgf/pgf.h pgf_function_type"
   pgf_function_type :: Ptr PgfPGF -> CString -> IO (Ptr PgfType)

-- GuString pgf_print_name(PgfConcr*, PgfCId id);
foreign import ccall "pgf/pgf.h pgf_print_name"
  pgf_print_name :: Ptr PgfConcr -> CString -> IO CString

--void pgf_linearize(PgfConcr* concr, PgfExpr expr, GuOut* out, GuExn* err);
foreign import ccall "pgf/pgf.h pgf_linearize"
  pgf_linearize :: Ptr PgfConcr -> PgfExpr -> Ptr GuOut -> Ptr GuExn -> IO ()

-- PgfExprEnum* pgf_parse(PgfConcr* concr, PgfCId cat, GuString sentence,
--                        GuExn* err, GuPool* pool, GuPool* out_pool);
foreign import ccall "pgf/pgf.h pgf_parse"
  pgf_parse :: Ptr PgfConcr -> CString -> CString -> Ptr GuExn -> Ptr GuPool -> Ptr GuPool -> IO (Ptr PgfExprEnum)

--void pgf_lookup_morpho(PgfConcr *concr, GuString sentence,
--                  PgfMorphoCallback* callback, GuExn* err);
foreign import ccall "pgf/pgf.h pgf_lookup_morpho"
  pgf_lookup_morpho :: Ptr PgfConcr -> CString -> Ptr PgfMorphoCallback -> Ptr GuExn -> IO ()

type Callback = Ptr PgfMorphoCallback -> CString -> CString -> Float -> Ptr GuExn -> IO ()

foreign import ccall "wrapper"
  wrapLookupMorpho :: Callback -> IO (FunPtr Callback)


--GuEnum* pgf_fullform_lexicon(PgfConcr *concr, GuPool* pool);
foreign import ccall "pgf/pgf.h pgf_fullform_lexicon"
  pgf_fullform_lexicon :: Ptr PgfConcr -> Ptr GuPool -> IO (Ptr GuEnum)

--GuString pgf_fullform_get_string(PgfFullFormEntry* entry);
foreign import ccall "pgf/pgf.h pgf_fullform_get_string"
  pgf_fullform_get_string :: Ptr PgfFullFormEntry -> IO CString

-- void pgf_fullform_get_analyses(PgfFullFormEntry* entry,
--                                PgfMorphoCallback* callback, GuExn* err)
foreign import ccall "pgf/pgf.h pgf_fullform_get_analyses"
  pgf_fullform_get_analyses :: Ptr PgfFullFormEntry -> Ptr PgfMorphoCallback -> Ptr GuExn -> IO ()
                    

--PgfApplication* pgf_expr_unapply(PgfExpr expr, GuPool* pool);
foreign import ccall "pgf/pgf.h pgf_expr_unapply"
  pgf_expr_unapply :: PgfExpr -> Ptr GuPool -> IO (Ptr PgfApplication)

--int pgf_expr_arity(PgfExpr expr);
foreign import ccall "pgf/expr.h pgf_expr_arity"
  pgf_expr_arity :: PgfExpr -> IO Int
--Not needed anymore, solved the problem with unapply using CInt instead of Int


--void pgf_print_expr(PgfExpr expr, PgfPrintContext* ctxt, int prec, 
--               GuOut* out, GuExn* err);
foreign import ccall "pgf/expr.h pgf_print_expr"
  pgf_print_expr :: PgfExpr -> Ptr PgfPrintContext -> Int -> Ptr GuOut -> Ptr GuExn -> IO ()
--PgfExprEnum* pgf_generate_all(PgfPGF* pgf, PgfCId cat, GuPool* pool);
foreign import ccall "pgf/pgf.h pgf_generate_all"
  pgf_generate_all :: Ptr PgfPGF -> CString -> Ptr GuPool -> IO (Ptr PgfExprEnum)

-- void pgf_print(PgfPGF* pgf, GuOut* out, GuExn* err); 
foreign import ccall "pgf/pgf.h pgf_print"
  pgf_print :: Ptr PgfPGF -> Ptr GuOut -> Ptr GuExn -> IO ()

--PgfExpr pgf_read_expr(GuIn* in, GuPool* pool, GuExn* err);
foreign import ccall "pgf/expr.h pgf_read_expr"
  pgf_read_expr :: Ptr GuIn -> Ptr GuPool -> Ptr GuExn -> IO PgfExpr

--PgfExprEnum*
--pgf_parse_with_heuristics(PgfConcr* concr, PgfCId cat, PgfLexer *lexer, 
--                          double heuristics, 
--                          GuPool* pool, GuPool* out_pool);
-- Not needed

-- GuEnum* pgf_complete(PgfConcr* concr, PgfCId cat, PgfLexer *lexer, 
--                     GuString prefix, GuPool* pool);
-- TODO

-- bool pgf_parseval(PgfConcr* concr, PgfExpr expr, PgfCId cat, 
--                  double *precision, double *recall, double *exact);
-- Not needed
