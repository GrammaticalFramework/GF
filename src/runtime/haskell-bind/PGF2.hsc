{-# LANGUAGE ExistentialQuantification, DeriveDataTypeable, ScopedTypeVariables #-}
-------------------------------------------------
-- |
-- Module      : PGF2
-- Maintainer  : Krasimir Angelov
-- Stability   : stable
-- Portability : portable
--
-- This module is an Application Programming Interface to
-- load and interpret grammars compiled in the Portable Grammar Format (PGF).
-- The PGF format is produced as the final output from the GF compiler.
-- The API is meant to be used for embedding GF grammars in Haskell
-- programs
-------------------------------------------------

#include <pgf/pgf.h>
#include <pgf/linearizer.h>
#include <gu/enum.h>
#include <gu/exn.h>

module PGF2 (-- * PGF
             PGF,readPGF,

             -- * Identifiers
             CId,

             -- * Abstract syntax
             AbsName,abstractName,
             -- ** Categories
             Cat,categories,
             -- ** Functions
             Fun,functions, functionsByCat, functionType, hasLinearization,
             -- ** Expressions
             Expr,showExpr,readExpr,
             mkAbs,unAbs,
             mkApp,unApp,
             mkStr,unStr,
             mkInt,unInt,
             mkFloat,unFloat,
             mkMeta,unMeta,
             mkCId,
             treeProbability,

             -- ** Types
             Type, Hypo, BindType(..), startCat,
             readType, showType,
             mkType, unType,

             -- ** Type checking
             checkExpr, inferExpr, checkType,

             -- ** Computing
             compute,

             -- * Concrete syntax
             ConcName,Concr,languages,concreteName,
             -- ** Linearization
             linearize,linearizeAll,tabularLinearize,tabularLinearizeAll,bracketedLinearize,
             FId, LIndex, BracketedString(..), showBracketedString, flattenBracketedString,

             alignWords,
             -- ** Parsing
             parse, parseWithHeuristics,
             -- ** Sentence Lookup
             lookupSentence,
             -- ** Generation
             generateAll,
             -- ** Morphological Analysis
             MorphoAnalysis, lookupMorpho, fullFormLexicon,
             -- ** Visualizations
             GraphvizOptions(..), graphvizDefaults,
             graphvizAbstractTree, graphvizParseTree, graphvizWordAlignment,

             -- * Exceptions
             PGFError(..),

             -- * Grammar specific callbacks
             LiteralCallback,literalCallbacks
            ) where

import Prelude hiding (fromEnum)
import Control.Exception(Exception,throwIO)
import Control.Monad(forM_)
import System.IO.Unsafe(unsafePerformIO,unsafeInterleaveIO)
import Text.PrettyPrint
import PGF2.Expr
import PGF2.Type
import PGF2.FFI

import Foreign hiding ( Pool, newPool, unsafePerformIO )
import Foreign.C
import Data.Typeable
import qualified Data.Map as Map
import Data.IORef
import Data.Char(isUpper,isSpace)
import Data.List(isSuffixOf,maximumBy,nub)
import Data.Function(on)

 
-----------------------------------------------------------------------
-- Functions that take a PGF.
-- PGF has many Concrs.
--
-- A Concr retains its PGF in a field in order to retain a reference to
-- the foreign pointer in case if the application still has a reference
-- to Concr but has lost its reference to PGF.


type AbsName  = CId -- ^ Name of abstract syntax
type ConcName = CId -- ^ Name of concrete syntax

-- | Reads file in Portable Grammar Format and produces
-- 'PGF' structure. The file is usually produced with:
--
-- > $ gf -make <grammar file name>
readPGF :: FilePath -> IO PGF
readPGF fpath =
  do pool <- gu_new_pool
     pgf  <- withCString fpath $ \c_fpath ->
               withGuPool $ \tmpPl -> do
                 exn <- gu_new_exn tmpPl
                 pgf <- pgf_read c_fpath pool exn
                 failed <- gu_exn_is_raised exn
                 if failed
                   then do is_errno <- gu_exn_caught exn gu_exn_type_GuErrno
                           if is_errno
                             then do perrno <- (#peek GuExn, data.data) exn
                                     errno  <- peek perrno
                                     gu_pool_free pool
                                     ioError (errnoToIOError "readPGF" (Errno errno) Nothing (Just fpath))
                             else do gu_pool_free pool
                                     throwIO (PGFError "The grammar cannot be loaded")
                   else return pgf
     pgfFPtr <- newForeignPtr gu_pool_finalizer pool
     return (PGF pgf (touchForeignPtr pgfFPtr))

-- | List of all languages available in the grammar.
languages :: PGF -> Map.Map ConcName Concr
languages p =
  unsafePerformIO $
    do ref <- newIORef Map.empty
       allocaBytes (#size GuMapItor) $ \itor ->
                   do fptr <- wrapMapItorCallback (getLanguages ref)
                      (#poke GuMapItor, fn) itor fptr
                      pgf_iter_languages (pgf p) itor nullPtr
                      freeHaskellFunPtr fptr
       readIORef ref
  where
    getLanguages :: IORef (Map.Map String Concr) -> MapItorCallback
    getLanguages ref itor key value exn = do
      langs <- readIORef ref
      name  <- peekUtf8CString (castPtr key)
      concr <- fmap (\ptr -> Concr ptr (touchPGF p)) $ peek (castPtr value)
      writeIORef ref $! Map.insert name concr langs

-- | The abstract language name is the name of the top-level
-- abstract module
concreteName :: Concr -> ConcName
concreteName c = unsafePerformIO (peekUtf8CString =<< pgf_concrete_name (concr c))

-- | Generates an exhaustive possibly infinite list of
-- all abstract syntax expressions of the given type. 
-- The expressions are ordered by their probability.
generateAll :: PGF -> Type -> [(Expr,Float)]
generateAll p (Type ctype _) =
  unsafePerformIO $
    do genPl  <- gu_new_pool
       exprPl <- gu_new_pool
       exn    <- gu_new_exn genPl
       enum   <- pgf_generate_all (pgf p) ctype exn genPl exprPl
       genFPl  <- newForeignPtr gu_pool_finalizer genPl
       exprFPl <- newForeignPtr gu_pool_finalizer exprPl
       fromPgfExprEnum enum genFPl (touchPGF p >> touchForeignPtr exprFPl)

-- | The abstract language name is the name of the top-level
-- abstract module
abstractName :: PGF -> AbsName
abstractName p = unsafePerformIO (peekUtf8CString =<< pgf_abstract_name (pgf p))

-- | The start category is defined in the grammar with
-- the \'startcat\' flag. This is usually the sentence category
-- but it is not necessary. Despite that there is a start category
-- defined you can parse with any category. The start category
-- definition is just for convenience.
startCat :: PGF -> Type
startCat p = unsafePerformIO $ do
  typPl <- gu_new_pool
  c_type <- pgf_start_cat (pgf p) typPl
  typeFPl <- newForeignPtr gu_pool_finalizer typPl
  return (Type c_type (touchForeignPtr typeFPl))

loadConcr :: Concr -> FilePath -> IO ()
loadConcr c fpath =
  withCString fpath $ \c_fpath ->
  withCString "rb" $ \c_mode ->
  withGuPool $ \tmpPl -> do
    file <- fopen c_fpath c_mode
    inp <- gu_file_in file tmpPl
    exn <- gu_new_exn tmpPl
    pgf_concrete_load (concr c) inp exn
    failed <- gu_exn_is_raised exn
    if failed
      then do is_errno <- gu_exn_caught exn gu_exn_type_GuErrno
              if is_errno
                then do perrno <- (#peek GuExn, data.data) exn
                        errno  <- peek perrno
                        ioError (errnoToIOError "loadConcr" (Errno errno) Nothing (Just fpath))
                else do throwIO (PGFError "The language cannot be loaded")
      else return ()

unloadConcr :: Concr -> IO ()
unloadConcr c = pgf_concrete_unload (concr c)

-- | The type of a function
functionType :: PGF -> Fun -> Type
functionType p fn =
  unsafePerformIO $
  withGuPool $ \tmpPl -> do
    c_fn <- newUtf8CString fn tmpPl
    c_type <- pgf_function_type (pgf p) c_fn
    if c_type == nullPtr
      then throwIO (PGFError ("Function '"++fn++"' is not defined"))
      else return (Type c_type (touchPGF p))

-- | Checks an expression against a specified type.
checkExpr :: PGF -> Expr -> Type -> Either String Expr
checkExpr (PGF p _) (Expr c_expr touch1) (Type c_ty touch2) =
  unsafePerformIO $
  alloca $ \pexpr ->
  withGuPool $ \tmpPl -> do
    exn <- gu_new_exn tmpPl
    exprPl <- gu_new_pool
    poke pexpr c_expr
    pgf_check_expr p pexpr c_ty exn exprPl
    touch1 >> touch2
    status <- gu_exn_is_raised exn
    if not status
      then do exprFPl <- newForeignPtr gu_pool_finalizer exprPl
              c_expr <- peek pexpr
              return (Right (Expr c_expr (touchForeignPtr exprFPl)))
      else do is_tyerr <- gu_exn_caught exn gu_exn_type_PgfTypeError
              c_msg <- (#peek GuExn, data.data) exn
              msg <- peekUtf8CString c_msg
              gu_pool_free exprPl
              if is_tyerr
                then return (Left msg)
                else throwIO (PGFError msg)

-- | Tries to infer the type of an expression. Note that
-- even if the expression is type correct it is not always
-- possible to infer its type in the GF type system.
-- In this case the function returns an error.
inferExpr :: PGF -> Expr -> Either String (Expr, Type)
inferExpr (PGF p _) (Expr c_expr touch1) =
  unsafePerformIO $
  alloca $ \pexpr ->
  withGuPool $ \tmpPl -> do
    exn <- gu_new_exn tmpPl
    exprPl <- gu_new_pool
    poke pexpr c_expr
    c_ty <- pgf_infer_expr p pexpr exn exprPl
    touch1
    status <- gu_exn_is_raised exn
    if not status
      then do exprFPl <- newForeignPtr gu_pool_finalizer exprPl
              let touch = touchForeignPtr exprFPl
              c_expr <- peek pexpr
              return (Right (Expr c_expr touch, Type c_ty touch))
      else do is_tyerr <- gu_exn_caught exn gu_exn_type_PgfTypeError
              c_msg <- (#peek GuExn, data.data) exn
              msg <- peekUtf8CString c_msg
              gu_pool_free exprPl
              if is_tyerr
                then return (Left msg)
                else throwIO (PGFError msg)

-- | Check whether a type is consistent with the abstract
-- syntax of the grammar.
checkType :: PGF -> Type -> Either String Type
checkType (PGF p _) (Type c_ty touch1) =
  unsafePerformIO $
  alloca $ \pty ->
  withGuPool $ \tmpPl -> do
    exn <- gu_new_exn tmpPl
    typePl <- gu_new_pool
    poke pty c_ty
    pgf_check_type p pty exn typePl
    touch1
    status <- gu_exn_is_raised exn
    if not status
      then do typeFPl <- newForeignPtr gu_pool_finalizer typePl
              c_ty <- peek pty
              return (Right (Type c_ty (touchForeignPtr typeFPl)))
      else do is_tyerr <- gu_exn_caught exn gu_exn_type_PgfTypeError
              c_msg <- (#peek GuExn, data.data) exn
              msg <- peekUtf8CString c_msg
              gu_pool_free typePl
              if is_tyerr
                then return (Left msg)
                else throwIO (PGFError msg)

compute :: PGF -> Expr -> Expr
compute (PGF p _) (Expr c_expr touch1) =
  unsafePerformIO $
  withGuPool $ \tmpPl -> do
    exn <- gu_new_exn tmpPl
    exprPl <- gu_new_pool
    c_expr <- pgf_compute p c_expr exn tmpPl exprPl
    touch1
    status <- gu_exn_is_raised exn
    if not status
      then do exprFPl <- newForeignPtr gu_pool_finalizer exprPl
              return (Expr c_expr (touchForeignPtr exprFPl))
      else do c_msg <- (#peek GuExn, data.data) exn
              msg <- peekUtf8CString c_msg
              gu_pool_free exprPl
              throwIO (PGFError msg)

treeProbability :: PGF -> Expr -> Float
treeProbability (PGF p _) (Expr c_expr touch1) =
  unsafePerformIO $ do
    res <- pgf_compute_tree_probability p c_expr
    touch1
    return (realToFrac res)

-----------------------------------------------------------------------------
-- Graphviz

data GraphvizOptions = GraphvizOptions {noLeaves :: Bool,
                                        noFun :: Bool,
                                        noCat :: Bool,
                                        noDep :: Bool,
                                        nodeFont :: String,
                                        leafFont :: String,
                                        nodeColor :: String,
                                        leafColor :: String,
                                        nodeEdgeStyle :: String,
                                        leafEdgeStyle :: String
                                       }

graphvizDefaults = GraphvizOptions False False False True "" "" "" "" "" ""

-- | Renders an abstract syntax tree in a Graphviz format.
graphvizAbstractTree :: PGF -> GraphvizOptions -> Expr -> String
graphvizAbstractTree p opts e =
  unsafePerformIO $
    withGuPool $ \tmpPl ->
      do (sb,out) <- newOut tmpPl
         exn <- gu_new_exn tmpPl
         c_opts <- newGraphvizOptions tmpPl opts
         pgf_graphviz_abstract_tree (pgf p) (expr e) c_opts out exn
         touchExpr e
         s <- gu_string_buf_freeze sb tmpPl
         peekUtf8CString s


graphvizParseTree :: Concr -> GraphvizOptions -> Expr -> String
graphvizParseTree c opts e =
  unsafePerformIO $
    withGuPool $ \tmpPl ->
      do (sb,out) <- newOut tmpPl
         exn <- gu_new_exn tmpPl
         c_opts <- newGraphvizOptions tmpPl opts
         pgf_graphviz_parse_tree (concr c) (expr e) c_opts out exn
         touchExpr e
         s <- gu_string_buf_freeze sb tmpPl
         peekUtf8CString s

graphvizWordAlignment :: [Concr] -> GraphvizOptions -> Expr -> String
graphvizWordAlignment cs opts e =
  unsafePerformIO $
    withGuPool $ \tmpPl ->
    withArrayLen (map concr cs) $ \n_concrs ptr ->
      do (sb,out) <- newOut tmpPl
         exn <- gu_new_exn tmpPl
         c_opts <- newGraphvizOptions tmpPl opts
         pgf_graphviz_word_alignment ptr (fromIntegral n_concrs) (expr e) c_opts out exn
         touchExpr e
         s <- gu_string_buf_freeze sb tmpPl
         peekUtf8CString s

newGraphvizOptions :: Ptr GuPool -> GraphvizOptions -> IO (Ptr PgfGraphvizOptions)
newGraphvizOptions pool opts = do
  c_opts <- gu_malloc pool (#size PgfGraphvizOptions)
  (#poke PgfGraphvizOptions, noLeaves) c_opts (if noLeaves opts then 1 else 0 :: CInt)
  (#poke PgfGraphvizOptions, noFun)    c_opts (if noFun    opts then 1 else 0 :: CInt)
  (#poke PgfGraphvizOptions, noCat)    c_opts (if noCat    opts then 1 else 0 :: CInt)
  (#poke PgfGraphvizOptions, noDep)    c_opts (if noDep    opts then 1 else 0 :: CInt)
  newUtf8CString (nodeFont opts) pool >>= (#poke PgfGraphvizOptions, nodeFont) c_opts
  newUtf8CString (leafFont opts) pool >>= (#poke PgfGraphvizOptions, leafFont) c_opts
  newUtf8CString (nodeColor opts) pool >>= (#poke PgfGraphvizOptions, nodeColor) c_opts
  newUtf8CString (leafColor opts) pool >>= (#poke PgfGraphvizOptions, leafColor) c_opts
  newUtf8CString (nodeEdgeStyle opts) pool >>= (#poke PgfGraphvizOptions, nodeEdgeStyle) c_opts
  newUtf8CString (leafEdgeStyle opts) pool >>= (#poke PgfGraphvizOptions, leafEdgeStyle) c_opts
  return c_opts

-----------------------------------------------------------------------------
-- Functions using Concr
-- Morpho analyses, parsing & linearization

type MorphoAnalysis = (Fun,Cat,Float)

lookupMorpho :: Concr -> String -> [MorphoAnalysis]
lookupMorpho (Concr concr master) sent =
  unsafePerformIO $
     withGuPool $ \tmpPl -> do
       ref <- newIORef []
       cback <- gu_malloc tmpPl (#size PgfMorphoCallback)
       fptr <- wrapLookupMorphoCallback (getAnalysis ref)
       (#poke PgfMorphoCallback, callback) cback fptr
       c_sent <- newUtf8CString sent tmpPl
       pgf_lookup_morpho concr c_sent cback nullPtr
       freeHaskellFunPtr fptr
       readIORef ref

fullFormLexicon :: Concr -> [(String, [MorphoAnalysis])]
fullFormLexicon lang =
  unsafePerformIO $
    do pl <- gu_new_pool
       enum <- pgf_fullform_lexicon (concr lang) pl
       fpl <- newForeignPtr gu_pool_finalizer pl
       fromFullFormEntry enum fpl
  where
    fromFullFormEntry :: Ptr GuEnum -> ForeignPtr GuPool -> IO [(String, [MorphoAnalysis])]
    fromFullFormEntry enum fpl =
      do ffEntry <- alloca $ \ptr ->
                      withForeignPtr fpl $ \pl ->
                        do gu_enum_next enum ptr pl
                           peek ptr
         if ffEntry == nullPtr
           then do finalizeForeignPtr fpl
                   touchConcr lang
                   return []
           else do tok  <- peekUtf8CString =<< pgf_fullform_get_string ffEntry
                   ref  <- newIORef []
                   allocaBytes (#size PgfMorphoCallback) $ \cback ->
                        do fptr <- wrapLookupMorphoCallback (getAnalysis ref)
                           (#poke PgfMorphoCallback, callback) cback fptr
                           pgf_fullform_get_analyses ffEntry cback nullPtr
                   ans  <- readIORef ref
                   toks <- unsafeInterleaveIO (fromFullFormEntry enum fpl)
                   return ((tok,ans) : toks)

getAnalysis :: IORef [MorphoAnalysis] -> LookupMorphoCallback
getAnalysis ref self c_lemma c_anal prob exn = do
  ans <- readIORef ref
  lemma <- peekUtf8CString c_lemma
  anal  <- peekUtf8CString c_anal
  writeIORef ref ((lemma, anal, prob):ans)

parse :: Concr -> Type -> String -> Either String [(Expr,Float)]
parse lang ty sent = parseWithHeuristics lang ty sent (-1.0) []

parseWithHeuristics :: Concr      -- ^ the language with which we parse
                    -> Type       -- ^ the start category
                    -> String     -- ^ the input sentence
                    -> Double     -- ^ the heuristic factor. 
                                  -- A negative value tells the parser 
                                  -- to lookup up the default from 
                                  -- the grammar flags
                    -> [(Cat, Int -> Int -> Maybe (Expr,Float,Int))]
                                  -- ^ a list of callbacks for literal categories.
                                  -- The arguments of the callback are:
                                  -- the index of the constituent for the literal category;
                                  -- the input sentence; the current offset in the sentence.
                                  -- If a literal has been recognized then the output should
                                  -- be Just (expr,probability,end_offset)
                    -> Either String [(Expr,Float)]
parseWithHeuristics lang (Type ctype _) sent heuristic callbacks =
  unsafePerformIO $
    do exprPl  <- gu_new_pool
       parsePl <- gu_new_pool
       exn     <- gu_new_exn parsePl
       sent    <- newUtf8CString sent parsePl
       callbacks_map <- mkCallbacksMap (concr lang) callbacks parsePl
       enum    <- pgf_parse_with_heuristics (concr lang) ctype sent heuristic callbacks_map exn parsePl exprPl
       failed  <- gu_exn_is_raised exn
       if failed
         then do is_parse_error <- gu_exn_caught exn gu_exn_type_PgfParseError
                 if is_parse_error
                   then do c_tok <- (#peek GuExn, data.data) exn
                           tok <- peekUtf8CString c_tok
                           gu_pool_free parsePl
                           gu_pool_free exprPl
                           return (Left tok)
                   else do is_exn <- gu_exn_caught exn gu_exn_type_PgfExn
                           if is_exn
                             then do c_msg <- (#peek GuExn, data.data) exn
                                     msg <- peekUtf8CString c_msg
                                     gu_pool_free parsePl
                                     gu_pool_free exprPl
                                     throwIO (PGFError msg)
                             else do gu_pool_free parsePl
                                     gu_pool_free exprPl
                                     throwIO (PGFError "Parsing failed")
         else do parseFPl <- newForeignPtr gu_pool_finalizer parsePl
                 exprFPl  <- newForeignPtr gu_pool_finalizer exprPl
                 exprs    <- fromPgfExprEnum enum parseFPl (touchConcr lang >> touchForeignPtr exprFPl)
                 return (Right exprs)

mkCallbacksMap :: Ptr PgfConcr -> [(String, Int -> Int -> Maybe (Expr,Float,Int))] -> Ptr GuPool -> IO (Ptr PgfCallbacksMap)
mkCallbacksMap concr callbacks pool = do
  callbacks_map <- pgf_new_callbacks_map concr pool
  forM_ callbacks $ \(cat,match) -> do
    ccat     <- newUtf8CString cat pool
    match    <- wrapLiteralMatchCallback (match_callback match)
    predict  <- wrapLiteralPredictCallback predict_callback
    hspgf_callbacks_map_add_literal concr callbacks_map ccat match predict pool
  return callbacks_map
  where
    match_callback match clin_idx poffset out_pool = do
      coffset <- peek poffset
      case match (fromIntegral clin_idx) (fromIntegral coffset) of
        Nothing               -> return nullPtr
        Just (e,prob,offset') -> do poke poffset (fromIntegral offset')

                                    -- here we copy the expression to out_pool
                                    c_e <- withGuPool $ \tmpPl -> do
                                             exn <- gu_new_exn tmpPl
        
                                             (sb,out) <- newOut tmpPl
                                             let printCtxt = nullPtr
                                             pgf_print_expr (expr e) printCtxt 1 out exn
                                             c_str <- gu_string_buf_freeze sb tmpPl

                                             guin <- gu_string_in c_str tmpPl
                                             pgf_read_expr guin out_pool exn

                                    ep <- gu_malloc out_pool (#size PgfExprProb)
                                    (#poke PgfExprProb, expr) ep c_e
                                    (#poke PgfExprProb, prob) ep prob
                                    return ep

    predict_callback _ _ _ = return nullPtr

lookupSentence :: Concr      -- ^ the language with which we parse
               -> Type       -- ^ the start category
               -> String     -- ^ the input sentence
               -> [(Expr,Float)]
lookupSentence lang (Type ctype _) sent =
  unsafePerformIO $
    do exprPl  <- gu_new_pool
       parsePl <- gu_new_pool
       sent    <- newUtf8CString sent parsePl
       enum    <- pgf_lookup_sentence (concr lang) ctype sent parsePl exprPl
       parseFPl <- newForeignPtr gu_pool_finalizer parsePl
       exprFPl  <- newForeignPtr gu_pool_finalizer exprPl
       exprs    <- fromPgfExprEnum enum parseFPl (touchConcr lang >> touchForeignPtr exprFPl)
       return exprs


-- | The oracle is a triple of functions.
-- The first two take a category name and a linearization field name
-- and they should return True/False when the corresponding 
-- prediction or completion is appropriate. The third function
-- is the oracle for literals.
type Oracle = (Maybe (Cat -> String -> Int -> Bool)
              ,Maybe (Cat -> String -> Int -> Bool)
              ,Maybe (Cat -> String -> Int -> Maybe (Expr,Float,Int))
              )

parseWithOracle :: Concr      -- ^ the language with which we parse
                -> Cat        -- ^ the start category
                -> String     -- ^ the input sentence
                -> Oracle
                -> Either String [(Expr,Float)]
parseWithOracle lang cat sent (predict,complete,literal) =
  unsafePerformIO $
    do parsePl <- gu_new_pool
       exprPl  <- gu_new_pool
       exn     <- gu_new_exn parsePl
       cat     <- newUtf8CString cat  parsePl
       sent    <- newUtf8CString sent parsePl
       predictPtr  <- maybe (return nullFunPtr) (wrapOracleCallback . oracleWrapper) predict
       completePtr <- maybe (return nullFunPtr) (wrapOracleCallback . oracleWrapper) complete
       literalPtr  <- maybe (return nullFunPtr) (wrapOracleLiteralCallback . oracleLiteralWrapper) literal
       cback <- hspgf_new_oracle_callback sent predictPtr completePtr literalPtr parsePl
       enum    <- pgf_parse_with_oracle (concr lang) cat sent cback exn parsePl exprPl
       failed  <- gu_exn_is_raised exn
       if failed
         then do is_parse_error <- gu_exn_caught exn gu_exn_type_PgfParseError
                 if is_parse_error
                   then do c_tok <- (#peek GuExn, data.data) exn
                           tok <- peekUtf8CString c_tok
                           gu_pool_free parsePl
                           gu_pool_free exprPl
                           return (Left tok)
                   else do is_exn <- gu_exn_caught exn gu_exn_type_PgfExn
                           if is_exn
                             then do c_msg <- (#peek GuExn, data.data) exn
                                     msg <- peekUtf8CString c_msg
                                     gu_pool_free parsePl
                                     gu_pool_free exprPl
                                     throwIO (PGFError msg)
                             else do gu_pool_free parsePl
                                     gu_pool_free exprPl
                                     throwIO (PGFError "Parsing failed")
         else do parseFPl <- newForeignPtr gu_pool_finalizer parsePl
                 exprFPl  <- newForeignPtr gu_pool_finalizer exprPl
                 exprs    <- fromPgfExprEnum enum parseFPl (touchConcr lang >> touchForeignPtr exprFPl)
                 return (Right exprs)
  where
    oracleWrapper oracle catPtr lblPtr offset = do
      cat <- peekUtf8CString catPtr
      lbl <- peekUtf8CString lblPtr
      return (oracle cat lbl (fromIntegral offset))

    oracleLiteralWrapper oracle catPtr lblPtr poffset out_pool = do
      cat <- peekUtf8CString catPtr
      lbl <- peekUtf8CString lblPtr
      offset <- peek poffset
      case oracle cat lbl (fromIntegral offset) of
        Just (e,prob,offset) ->
                      do poke poffset (fromIntegral offset)

                         -- here we copy the expression to out_pool
                         c_e <- withGuPool $ \tmpPl -> do
                                  exn <- gu_new_exn tmpPl

                                  (sb,out) <- newOut tmpPl
                                  let printCtxt = nullPtr
                                  pgf_print_expr (expr e) printCtxt 1 out exn
                                  c_str <- gu_string_buf_freeze sb tmpPl

                                  guin <- gu_string_in c_str tmpPl
                                  pgf_read_expr guin out_pool exn

                         ep <- gu_malloc out_pool (#size PgfExprProb)
                         (#poke PgfExprProb, expr) ep c_e
                         (#poke PgfExprProb, prob) ep prob
                         return ep
        Nothing    -> do return nullPtr

-- | Returns True if there is a linearization defined for that function in that language
hasLinearization :: Concr -> Fun -> Bool
hasLinearization lang id = unsafePerformIO $
  withGuPool $ \pl -> do
    res <- newUtf8CString id pl >>= pgf_has_linearization (concr lang)
    return (res /= 0)

-- | Linearizes an expression as a string in the language
linearize :: Concr -> Expr -> String
linearize lang e = unsafePerformIO $
  withGuPool $ \pl ->
    do (sb,out) <- newOut pl
       exn <- gu_new_exn pl
       pgf_linearize (concr lang) (expr e) out exn
       touchExpr e
       failed <- gu_exn_is_raised exn
       if failed
         then do is_nonexist <- gu_exn_caught exn gu_exn_type_PgfLinNonExist
                 if is_nonexist
                   then return ""
                   else do is_exn <- gu_exn_caught exn gu_exn_type_PgfExn
                           if is_exn
                             then do c_msg <- (#peek GuExn, data.data) exn
                                     msg <- peekUtf8CString c_msg
                                     throwIO (PGFError msg)
                             else throwIO (PGFError "The abstract tree cannot be linearized")
         else do lin <- gu_string_buf_freeze sb pl
                 peekUtf8CString lin

-- | Generates all possible linearizations of an expression
linearizeAll :: Concr -> Expr -> [String]
linearizeAll lang e = unsafePerformIO $
  do pl <- gu_new_pool
     exn <- gu_new_exn pl
     cts <- pgf_lzr_concretize (concr lang) (expr e) exn pl
     failed <- gu_exn_is_raised exn
     if failed
       then throwExn exn pl
       else collect cts exn pl
  where
    collect cts exn pl = withGuPool $ \tmpPl -> do
      ctree <- alloca $ \ptr -> do gu_enum_next cts ptr tmpPl
                                   peek ptr
      if ctree == nullPtr
        then do gu_pool_free pl
                touchExpr e
                return []
        else do (sb,out) <- newOut tmpPl
                ctree <- pgf_lzr_wrap_linref ctree tmpPl
                pgf_lzr_linearize_simple (concr lang) ctree 0 out exn tmpPl
                failed <- gu_exn_is_raised exn
                if failed
                  then do is_nonexist <- gu_exn_caught exn gu_exn_type_PgfLinNonExist
                          if is_nonexist
                            then collect cts exn pl
                            else throwExn exn pl
                  else do lin <- gu_string_buf_freeze sb tmpPl
                          s <- peekUtf8CString lin
                          ss <- collect cts exn pl
                          return (s:ss)

    throwExn exn pl = do
      is_exn <- gu_exn_caught exn gu_exn_type_PgfExn
      if is_exn
        then do c_msg <- (#peek GuExn, data.data) exn
                msg <- peekUtf8CString c_msg
                gu_pool_free pl
                throwIO (PGFError msg)
        else do gu_pool_free pl
                throwIO (PGFError "The abstract tree cannot be linearized")

-- | Generates a table of linearizations for an expression
tabularLinearize :: Concr -> Expr -> [(String, String)]
tabularLinearize lang e = 
  case tabularLinearizeAll lang e of
    (lins:_) -> lins
    _        -> []

-- | Generates a table of linearizations for an expression
tabularLinearizeAll :: Concr -> Expr -> [[(String, String)]]
tabularLinearizeAll lang e = unsafePerformIO $
  withGuPool $ \tmpPl -> do
    exn <- gu_new_exn tmpPl
    cts <- pgf_lzr_concretize (concr lang) (expr e) exn tmpPl
    failed <- gu_exn_is_raised exn
    if failed
      then throwExn exn
      else collect cts exn tmpPl
  where
    collect cts exn tmpPl = do
      ctree <- alloca $ \ptr -> do gu_enum_next cts ptr tmpPl
                                   peek ptr
      if ctree == nullPtr
        then do touchExpr e
                return []
        else do labels <- alloca $ \p_n_lins ->
                          alloca $ \p_labels -> do
                            pgf_lzr_get_table (concr lang) ctree p_n_lins p_labels
                            n_lins <- peek p_n_lins
                            labels <- peek p_labels
                            labels <- peekArray (fromIntegral n_lins) labels
                            labels <- mapM peekCString labels
                            return labels
                lins <- collectTable lang ctree 0 labels exn tmpPl
                linss <- collect cts exn tmpPl
                return (lins : linss)

    collectTable lang ctree lin_idx []             exn tmpPl = return []
    collectTable lang ctree lin_idx (label:labels) exn tmpPl = do
      (sb,out) <- newOut tmpPl
      pgf_lzr_linearize_simple (concr lang) ctree lin_idx out exn tmpPl
      failed <- gu_exn_is_raised exn
      if failed
        then do is_nonexist <- gu_exn_caught exn gu_exn_type_PgfLinNonExist
                if is_nonexist
                  then collectTable lang ctree (lin_idx+1) labels exn tmpPl
                  else throwExn exn
        else do lin <- gu_string_buf_freeze sb tmpPl
                s  <- peekUtf8CString lin
                ss <- collectTable lang ctree (lin_idx+1) labels exn tmpPl
                return ((label,s):ss)

    throwExn exn = do
      is_exn <- gu_exn_caught exn gu_exn_type_PgfExn
      if is_exn
        then do c_msg <- (#peek GuExn, data.data) exn
                msg <- peekUtf8CString c_msg
                throwIO (PGFError msg)
        else do throwIO (PGFError "The abstract tree cannot be linearized")

type FId    = Int
type LIndex = Int

-- | BracketedString represents a sentence that is linearized
-- as usual but we also want to retain the ''brackets'' that
-- mark the beginning and the end of each constituent.
data BracketedString
  = Leaf String                                                                -- ^ this is the leaf i.e. a single token
  | Bracket CId {-# UNPACK #-} !FId {-# UNPACK #-} !LIndex CId [BracketedString]
                                                                               -- ^ this is a bracket. The 'CId' is the category of
                                                                               -- the phrase. The 'FId' is an unique identifier for
                                                                               -- every phrase in the sentence. For context-free grammars
                                                                               -- i.e. without discontinuous constituents this identifier
                                                                               -- is also unique for every bracket. When there are discontinuous 
                                                                               -- phrases then the identifiers are unique for every phrase but
                                                                               -- not for every bracket since the bracket represents a constituent.
                                                                               -- The different constituents could still be distinguished by using
                                                                               -- the constituent index i.e. 'LIndex'. If the grammar is reduplicating
                                                                               -- then the constituent indices will be the same for all brackets
                                                                               -- that represents the same constituent.
                                                                               -- The second 'CId' is the name of the abstract function that generated
                                                                               -- this phrase.

-- | Renders the bracketed string as a string where 
-- the brackets are shown as @(S ...)@ where
-- @S@ is the category.
showBracketedString :: BracketedString -> String
showBracketedString = render . ppBracketedString

ppBracketedString (Leaf t) = text t
ppBracketedString (Bracket cat fid index _ bss) = parens (text cat <> colon <> int fid <+> hsep (map ppBracketedString bss))

-- | Extracts the sequence of tokens from the bracketed string
flattenBracketedString :: BracketedString -> [String]
flattenBracketedString (Leaf w)              = [w]
flattenBracketedString (Bracket _ _ _ _ bss) = concatMap flattenBracketedString bss

bracketedLinearize :: Concr -> Expr -> [BracketedString]
bracketedLinearize lang e = unsafePerformIO $
  withGuPool $ \pl -> 
    do exn <- gu_new_exn pl
       cts <- pgf_lzr_concretize (concr lang) (expr e) exn pl
       failed <- gu_exn_is_raised exn
       if failed
         then throwExn exn
         else do ctree <- alloca $ \ptr -> do gu_enum_next cts ptr pl
                                              peek ptr
                 if ctree == nullPtr
                   then do touchExpr e
                           return []
                   else do ctree <- pgf_lzr_wrap_linref ctree pl
                           ref <- newIORef ([],[])
                           allocaBytes (#size PgfLinFuncs) $ \pLinFuncs  ->
                            alloca $ \ppLinFuncs -> do
                              fptr_symbol_token <- wrapSymbolTokenCallback (symbol_token ref)
                              fptr_begin_phrase <- wrapPhraseCallback (begin_phrase ref)
                              fptr_end_phrase   <- wrapPhraseCallback (end_phrase ref)
                              fptr_symbol_ne    <- wrapSymbolNonExistCallback (symbol_ne exn)
                              fptr_symbol_meta  <- wrapSymbolMetaCallback (symbol_meta ref)
                              (#poke PgfLinFuncs, symbol_token) pLinFuncs fptr_symbol_token
                              (#poke PgfLinFuncs, begin_phrase) pLinFuncs fptr_begin_phrase
                              (#poke PgfLinFuncs, end_phrase)   pLinFuncs fptr_end_phrase
                              (#poke PgfLinFuncs, symbol_ne)    pLinFuncs fptr_symbol_ne
                              (#poke PgfLinFuncs, symbol_bind)  pLinFuncs nullPtr
                              (#poke PgfLinFuncs, symbol_capit) pLinFuncs nullPtr
                              (#poke PgfLinFuncs, symbol_meta)  pLinFuncs fptr_symbol_meta
                              poke ppLinFuncs pLinFuncs
                              pgf_lzr_linearize (concr lang) ctree 0 ppLinFuncs pl
                              freeHaskellFunPtr fptr_symbol_token
                              freeHaskellFunPtr fptr_begin_phrase
                              freeHaskellFunPtr fptr_end_phrase
                              freeHaskellFunPtr fptr_symbol_ne
                              freeHaskellFunPtr fptr_symbol_meta
                           failed <- gu_exn_is_raised exn
                           if failed
                             then do is_nonexist <- gu_exn_caught exn gu_exn_type_PgfLinNonExist
                                     if is_nonexist
                                       then return []
                                       else throwExn exn
                             else do (_,bs) <- readIORef ref
                                     return (reverse bs)
  where
    symbol_token ref _ c_token = do
      (stack,bs) <- readIORef ref
      token <- peekUtf8CString c_token
      writeIORef ref (stack,Leaf token : bs)

    begin_phrase ref _ c_cat c_fid c_lindex c_fun = do
      (stack,bs) <- readIORef ref
      writeIORef ref (bs:stack,[])

    end_phrase ref _ c_cat c_fid c_lindex c_fun = do
      (bs':stack,bs) <- readIORef ref
      cat <- peekUtf8CString c_cat
      let fid    = fromIntegral c_fid
      let lindex = fromIntegral c_lindex
      fun <- peekUtf8CString c_fun
      writeIORef ref (stack, Bracket cat fid lindex fun (reverse bs) : bs')

    symbol_ne exn _ = do
      gu_exn_raise exn gu_exn_type_PgfLinNonExist
      return ()

    symbol_meta ref _ meta_id = do
      (stack,bs) <- readIORef ref
      writeIORef ref (stack,Leaf "?" : bs)

    throwExn exn = do
      is_exn <- gu_exn_caught exn gu_exn_type_PgfExn
      if is_exn
        then do c_msg <- (#peek GuExn, data.data) exn
                msg <- peekUtf8CString c_msg
                throwIO (PGFError msg)
        else do throwIO (PGFError "The abstract tree cannot be linearized")

alignWords :: Concr -> Expr -> [(String, [Int])]
alignWords lang e = unsafePerformIO $
  withGuPool $ \pl ->
    do exn <- gu_new_exn pl
       seq <- pgf_align_words (concr lang) (expr e) exn pl
       touchExpr e
       failed <- gu_exn_is_raised exn
       if failed
         then do is_nonexist <- gu_exn_caught exn gu_exn_type_PgfLinNonExist
                 if is_nonexist
                   then return []
                   else do is_exn <- gu_exn_caught exn gu_exn_type_PgfExn
                           if is_exn
                             then do c_msg <- (#peek GuExn, data.data) exn
                                     msg <- peekUtf8CString c_msg
                                     throwIO (PGFError msg)
                             else throwIO (PGFError "The abstract tree cannot be linearized")
         else do len <- (#peek GuSeq, len) seq
                 arr <- peekArray (fromIntegral (len :: CInt)) (seq `plusPtr` (#offset GuSeq, data))
                 mapM peekAlignmentPhrase arr
  where
    peekAlignmentPhrase :: Ptr () -> IO (String, [Int])
    peekAlignmentPhrase ptr = do
      c_phrase <- (#peek PgfAlignmentPhrase, phrase) ptr
      phrase <- peekUtf8CString c_phrase
      n_fids <- (#peek PgfAlignmentPhrase, n_fids) ptr
      (fids :: [CInt]) <- peekArray (fromIntegral (n_fids :: CInt)) (ptr `plusPtr` (#offset PgfAlignmentPhrase, fids))
      return (phrase, map fromIntegral fids)

-- | List of all functions defined in the abstract syntax
functions :: PGF -> [Fun]
functions p =
  unsafePerformIO $
    withGuPool $ \tmpPl ->
    allocaBytes (#size GuMapItor) $ \itor -> do
      exn <- gu_new_exn tmpPl
      ref <- newIORef []
      fptr <- wrapMapItorCallback (getFunctions ref)
      (#poke GuMapItor, fn) itor fptr
      pgf_iter_functions (pgf p) itor exn
      touchPGF p
      freeHaskellFunPtr fptr
      fs <- readIORef ref
      return (reverse fs)
  where
    getFunctions :: IORef [String] -> MapItorCallback
    getFunctions ref itor key value exn = do
      names <- readIORef ref
      name  <- peekUtf8CString (castPtr key)
      writeIORef ref $! (name : names)

-- | List of all functions defined for a category
functionsByCat :: PGF -> Cat -> [Fun]
functionsByCat p cat =
  unsafePerformIO $
    withGuPool $ \tmpPl ->
    allocaBytes (#size GuMapItor) $ \itor -> do
      exn <- gu_new_exn tmpPl
      ref <- newIORef []
      fptr <- wrapMapItorCallback (getFunctions ref)
      (#poke GuMapItor, fn) itor fptr
      ccat <- newUtf8CString cat tmpPl
      pgf_iter_functions_by_cat (pgf p) ccat itor exn
      touchPGF p
      freeHaskellFunPtr fptr
      fs <- readIORef ref
      return (reverse fs)
  where
    getFunctions :: IORef [String] -> MapItorCallback
    getFunctions ref itor key value exn = do
      names <- readIORef ref
      name  <- peekUtf8CString (castPtr key)
      writeIORef ref $! (name : names)

-- | List of all categories defined in the grammar.
-- The categories are defined in the abstract syntax
-- with the \'cat\' keyword.
categories :: PGF -> [Cat]
categories p =
  unsafePerformIO $
    withGuPool $ \tmpPl ->
    allocaBytes (#size GuMapItor) $ \itor -> do
      exn <- gu_new_exn tmpPl
      ref <- newIORef []
      fptr <- wrapMapItorCallback (getCategories ref)
      (#poke GuMapItor, fn) itor fptr
      pgf_iter_categories (pgf p) itor exn
      touchPGF p
      freeHaskellFunPtr fptr
      cs <- readIORef ref
      return (reverse cs)
  where
    getCategories :: IORef [String] -> MapItorCallback
    getCategories ref itor key value exn = do
      names <- readIORef ref
      name  <- peekUtf8CString (castPtr key)
      writeIORef ref $! (name : names)

categoryContext :: PGF -> Cat -> Maybe [Hypo]
categoryContext pgf cat = Nothing -- !!! not implemented yet TODO

-----------------------------------------------------------------------------
-- Helper functions

fromPgfExprEnum :: Ptr GuEnum -> ForeignPtr GuPool -> IO () -> IO [(Expr, Float)]
fromPgfExprEnum enum fpl touch =
  do pgfExprProb <- alloca $ \ptr ->
                      withForeignPtr fpl $ \pl ->
                        do gu_enum_next enum ptr pl
                           peek ptr
     if pgfExprProb == nullPtr
       then do finalizeForeignPtr fpl
               return []
       else do expr <- (#peek PgfExprProb, expr) pgfExprProb
               ts <- unsafeInterleaveIO (fromPgfExprEnum enum fpl touch)
               prob <- (#peek PgfExprProb, prob) pgfExprProb
               return ((Expr expr touch,prob) : ts)

-----------------------------------------------------------------------
-- Exceptions

newtype PGFError = PGFError String
     deriving (Show, Typeable)

instance Exception PGFError

-----------------------------------------------------------------------

type LiteralCallback =
       PGF -> (ConcName,Concr) -> String -> Int -> Int -> Maybe (Expr,Float,Int)

-- | Callbacks for the App grammar
literalCallbacks :: [(AbsName,[(Cat,LiteralCallback)])]
literalCallbacks = [("App",[("PN",nerc),("Symb",chunk)])]

-- | Named entity recognition for the App grammar 
-- (based on ../java/org/grammaticalframework/pgf/NercLiteralCallback.java)
nerc :: LiteralCallback
nerc pgf (lang,concr) sentence lin_idx offset =
  case consume capitalized (drop offset sentence) of
    (capwords@(_:_),rest) |
       not ("Eng" `isSuffixOf` lang && name `elem` ["I","I'm"]) ->
        if null ls
        then pn
        else case cat of
              "PN" -> retLit (mkApp lemma [])
              "WeekDay" -> retLit (mkApp "weekdayPN" [mkApp lemma []])
              "Month" -> retLit (mkApp "monthPN" [mkApp lemma []])
              _ -> Nothing
      where
        retLit e = Just (e,0,end_offset)
          where end_offset = offset+length name
        pn = retLit (mkApp "SymbPN" [mkApp "MkSymb" [mkStr name]])
        ((lemma,cat),_) = maximumBy (compare `on` snd) (reverse ls)
        ls = [((fun,cat),p)
              |(fun,_,p)<-lookupMorpho concr name,
                let cat=functionCat fun,
                cat/="Nationality"]
        name = trimRight (concat capwords)
    _ -> Nothing
  where
    -- | Variant of unfoldr
    consume munch xs =
      case munch xs of
        Nothing -> ([],xs)
        Just (y,xs') -> (y:ys,xs'')
          where (ys,xs'') = consume munch xs'

    functionCat f = case unType (functionType pgf f) of (_,cat,_) -> cat

-- | Callback to parse arbitrary words as chunks (from
-- ../java/org/grammaticalframework/pgf/UnknownLiteralCallback.java)
chunk :: LiteralCallback
chunk _ (_,concr) sentence lin_idx offset =
  case uncapitalized (drop offset sentence) of
    Just (word0@(_:_),rest) | null (lookupMorpho concr word) ->
        Just (expr,0,offset+length word)
      where
        word = trimRight word0
        expr = mkApp "MkSymb" [mkStr word]
    _ -> Nothing


-- More helper functions

trimRight = reverse . dropWhile isSpace . reverse

capitalized = capitalized' isUpper
uncapitalized = capitalized' (not.isUpper)

capitalized' test s@(c:_) | test c =
  case span (not.isSpace) s of
    (name,rest1) ->
      case span isSpace rest1 of
        (space,rest2) -> Just (name++space,rest2)
capitalized' not s = Nothing
