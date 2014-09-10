{-# LANGUAGE ExistentialQuantification, DeriveDataTypeable #-}
-------------------------------------------------
-- |
-- Maintainer  : Krasimir Angelov
-- Stability   : stable
-- Portability : portable
--
-- This is the Haskell binding to the C run-time system for
-- loading and interpreting grammars compiled in Portable Grammar Format (PGF).
-------------------------------------------------
#include <pgf/pgf.h>
#include <gu/enum.h>
#include <gu/exn.h>

module PGF2 (-- * PGF
             PGF,readPGF,abstractName,startCat,
             loadConcr,unloadConcr,
             -- * Concrete syntax
             Concr,languages,parse,linearize,addLiteral,
             -- * Trees
             Expr,readExpr,showExpr,unApp,
             -- * Morphology
             MorphoAnalysis, lookupMorpho, fullFormLexicon,
             -- * Exceptions
             PGFError(..)
            ) where

import Prelude hiding (fromEnum)
import Control.Exception(Exception,throwIO)
import System.IO.Unsafe(unsafePerformIO,unsafeInterleaveIO)
import PGF2.FFI

import Foreign hiding ( Pool, newPool, unsafePerformIO )
import Foreign.C
import Data.Typeable
import qualified Data.Map as Map
import Data.IORef

 
-----------------------------------------------------------------------
-- Functions that take a PGF.
-- PGF has many Concrs.
--
-- A Concr retains its PGF in a field in order to retain a reference to
-- the foreign pointer in case if the application still has a reference
-- to Concr but has lost its reference to PGF.

data PGF = PGF {pgf :: Ptr PgfPGF, pgfMaster :: ForeignPtr GuPool}
data Concr = Concr {concr :: Ptr PgfConcr, concrMaster :: PGF}

readPGF :: FilePath -> IO PGF
readPGF fpath =
  do pool <- gu_new_pool
     pgf  <- withCString fpath $ \c_fpath ->
               withGuPool $ \tmpPl -> do
                 exn <- gu_new_exn nullPtr gu_type__type tmpPl
                 pgf <- pgf_read c_fpath pool exn
                 failed <- gu_exn_is_raised exn
                 if failed
                   then do ty <- gu_exn_caught exn
                           if ty == gu_type__GuErrno
                             then do perrno <- (#peek GuExn, data.data) exn
                                     errno  <- peek perrno
                                     gu_pool_free pool
                                     ioError (errnoToIOError "readPGF" (Errno errno) Nothing (Just fpath))
                             else do gu_pool_free pool
                                     throwIO (PGFError "The grammar cannot be loaded")
                   else return pgf
     master <- newForeignPtr gu_pool_finalizer pool
     return PGF {pgf = pgf, pgfMaster = master}

languages :: PGF -> Map.Map String Concr
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
      name  <- peekCString (castPtr key)
      concr <- fmap (\ptr -> Concr ptr p) $ peek (castPtr value)
      writeIORef ref $! Map.insert name concr langs

generateAll :: PGF -> String -> [(Expr,Float)]
generateAll p cat =
  unsafePerformIO $
    do genPl  <- gu_new_pool
       exprPl <- gu_new_pool
       enum   <- withCString cat $ \cat ->
                   pgf_generate_all (pgf p) cat genPl
       genFPl  <- newForeignPtr gu_pool_finalizer genPl
       exprFPl <- newForeignPtr gu_pool_finalizer exprPl
       fromPgfExprEnum enum genFPl (p,exprFPl)

abstractName :: PGF -> String
abstractName p = unsafePerformIO (peekCString =<< pgf_abstract_name (pgf p))

startCat :: PGF -> String
startCat p = unsafePerformIO (peekCString =<< pgf_start_cat (pgf p))

loadConcr :: Concr -> FilePath -> IO ()
loadConcr c fpath =
  withCString fpath $ \c_fpath ->
  withCString "rb" $ \c_mode ->
  withGuPool $ \tmpPl -> do
    file <- fopen c_fpath c_mode
    inp <- gu_file_in file tmpPl
    exn <- gu_new_exn nullPtr gu_type__type tmpPl
    pgf_concrete_load (concr c) inp exn
    failed <- gu_exn_is_raised exn
    if failed
      then do ty <- gu_exn_caught exn
              if ty == gu_type__GuErrno
                then do perrno <- (#peek GuExn, data.data) exn
                        errno  <- peek perrno
                        ioError (errnoToIOError "loadConcr" (Errno errno) Nothing (Just fpath))
                else do throwIO (PGFError "The language cannot be loaded")
      else return ()

unloadConcr :: Concr -> IO ()
unloadConcr c = pgf_concrete_unload (concr c)

-----------------------------------------------------------------------------
-- Expressions

-- The C structure for the expression may point to other structures
-- which are allocated from other pools. In order to ensure that
-- they are not released prematurely we use the exprMaster to
-- store references to other Haskell objects

data Expr = forall a . Expr {expr :: PgfExpr, exprMaster :: a}

instance Show Expr where
  show = showExpr

unApp :: Expr -> Maybe (String,[Expr])
unApp (Expr expr master) =
  unsafePerformIO $
    withGuPool $ \pl -> do
      appl <- pgf_expr_unapply expr pl
      if appl == nullPtr
        then return Nothing
        else do 
           fun <- peekCString =<< (#peek PgfApplication, fun) appl
           arity <- (#peek PgfApplication, n_args) appl :: IO CInt 
           c_args <- peekArray (fromIntegral arity) (appl `plusPtr` (#offset PgfApplication, args))
           return $ Just (fun, [Expr c_arg master | c_arg <- c_args])

readExpr :: String -> Maybe Expr
readExpr str =
  unsafePerformIO $
    do exprPl <- gu_new_pool
       withGuPool $ \tmpPl ->
         withCString str $ \c_str ->
           do guin <- gu_string_in c_str tmpPl
              exn <- gu_new_exn nullPtr gu_type__type tmpPl
              c_expr <- pgf_read_expr guin exprPl exn
              status <- gu_exn_is_raised exn
              if (not status && c_expr /= nullPtr)
                then do exprFPl <- newForeignPtr gu_pool_finalizer exprPl
                        return $ Just (Expr c_expr exprFPl)
                else do gu_pool_free exprPl
                        return Nothing

showExpr :: Expr -> String
showExpr e = 
  unsafePerformIO $
    withGuPool $ \tmpPl ->
      do (sb,out) <- newOut tmpPl
         let printCtxt = nullPtr
         exn <- gu_new_exn nullPtr gu_type__type tmpPl
         pgf_print_expr (expr e) printCtxt 1 out exn
         s <- gu_string_buf_freeze sb tmpPl
         peekCString s


-----------------------------------------------------------------------------
-- Functions using Concr
-- Morpho analyses, parsing & linearization

type MorphoAnalysis = (String,String,Float)

lookupMorpho :: Concr -> String -> [MorphoAnalysis]
lookupMorpho (Concr concr master) sent = unsafePerformIO $
  do ref <- newIORef []
     allocaBytes (#size PgfMorphoCallback) $ \cback -> 
                        do fptr <- wrapLookupMorphoCallback (getAnalysis ref)
                           (#poke PgfMorphoCallback, callback) cback fptr
                           withCString sent $ \c_sent ->
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
                   return []
           else do tok  <- peekCString =<< pgf_fullform_get_string ffEntry
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
  lemma <- peekCString c_lemma
  anal  <- peekCString c_anal
  writeIORef ref ((lemma, anal, prob):ans)

parse :: Concr -> String -> String -> Either String [(Expr,Float)]
parse lang cat sent =
  unsafePerformIO $
    do parsePl <- gu_new_pool
       exprPl  <- gu_new_pool
       exn     <- gu_new_exn nullPtr gu_type__type parsePl
       enum    <- withCString cat $ \cat ->
                    withCString sent $ \sent ->
                      pgf_parse (concr lang) cat sent exn parsePl exprPl
       failed  <- gu_exn_is_raised exn
       if failed
         then do ty <- gu_exn_caught exn
                 if ty == gu_type__PgfParseError
                   then do c_tok <- (#peek GuExn, data.data) exn
                           tok <- peekCString c_tok
                           gu_pool_free parsePl
                           gu_pool_free exprPl
                           return (Left tok)
                   else if ty == gu_type__PgfExn
                          then do c_msg <- (#peek GuExn, data.data) exn
                                  msg <- peekCString c_msg
                                  gu_pool_free parsePl
                                  gu_pool_free exprPl
                                  throwIO (PGFError msg)
                          else do gu_pool_free parsePl
                                  gu_pool_free exprPl
                                  throwIO (PGFError "Parsing failed")
         else do parseFPl <- newForeignPtr gu_pool_finalizer parsePl
                 exprFPl  <- newForeignPtr gu_pool_finalizer exprPl
                 exprs    <- fromPgfExprEnum enum parseFPl (lang,exprFPl)
                 return (Right exprs)

addLiteral :: Concr -> String -> (Int -> String -> Int -> Maybe (Expr,Float,Int)) -> IO ()
addLiteral lang cat match =
  withCString cat $ \ccat ->
  withGuPool  $ \tmp_pool -> do
    callback <- hspgf_new_literal_callback (concr lang)
    match    <- wrapLiteralMatchCallback match_callback
    predict  <- wrapLiteralPredictCallback predict_callback
    (#poke PgfLiteralCallback, match)   callback match
    (#poke PgfLiteralCallback, predict) callback predict
    exn      <- gu_new_exn nullPtr gu_type__type tmp_pool
    pgf_concr_add_literal (concr lang) ccat callback exn
    failed <- gu_exn_is_raised exn
    if failed
      then do ty <- gu_exn_caught exn
              if ty == gu_type__PgfExn
                then do c_msg <- (#peek GuExn, data.data) exn
                        msg <- peekCString c_msg
                        throwIO (PGFError msg)
                else throwIO (PGFError "The literal cannot be added")
      else return ()
  where
    match_callback _ clin_idx csentence poffset out_pool = do
      sentence <- peekCString csentence
      coffset  <- peek poffset
      offset <- alloca $ \pcsentence -> do
                   poke pcsentence csentence
                   gu2hs_string_offset pcsentence (plusPtr csentence (fromIntegral coffset)) 0
      case match (fromIntegral clin_idx) sentence offset of
        Nothing               -> return nullPtr
        Just (e,prob,offset') -> do poke poffset (fromIntegral offset')

                                    -- here we copy the expression to out_pool
                                    c_e <- withGuPool $ \tmpPl -> do
                                             exn <- gu_new_exn nullPtr gu_type__type tmpPl
        
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

    predict_callback _ _ _ _ = return nullPtr

    gu2hs_string_offset pcstart cend offset = do
      cstart <- peek pcstart
      if cstart < cend
        then do gu_utf8_decode pcstart
                gu2hs_string_offset pcstart cend (offset+1)
        else return offset

linearize :: Concr -> Expr -> String
linearize lang e = unsafePerformIO $
  withGuPool $ \pl ->
    do (sb,out) <- newOut pl
       exn <- gu_new_exn nullPtr gu_type__type pl
       pgf_linearize (concr lang) (expr e) out exn
       failed <- gu_exn_is_raised exn
       if failed
         then do ty <- gu_exn_caught exn
                 if ty == gu_type__PgfLinNonExist
                   then return ""
                   else if ty == gu_type__PgfExn
                          then do c_msg <- (#peek GuExn, data.data) exn
                                  msg <- peekCString c_msg
                                  throwIO (PGFError msg)
                          else throwIO (PGFError "The abstract tree cannot be linearized")
         else do lin <- gu_string_buf_freeze sb pl
                 peekCString lin


-----------------------------------------------------------------------------
-- Helper functions

newOut :: Ptr GuPool -> IO (Ptr GuStringBuf, Ptr GuOut)
newOut pool =
   do sb <- gu_string_buf pool
      out <- gu_string_buf_out sb
      return (sb,out)

fromPgfExprEnum :: Ptr GuEnum -> ForeignPtr GuPool -> a -> IO [(Expr, Float)]
fromPgfExprEnum enum fpl master =
  do pgfExprProb <- alloca $ \ptr ->
                      withForeignPtr fpl $ \pl ->
                        do gu_enum_next enum ptr pl
                           peek ptr
     if pgfExprProb == nullPtr
       then do finalizeForeignPtr fpl
               return []
       else do expr <- (#peek PgfExprProb, expr) pgfExprProb
               ts <- unsafeInterleaveIO (fromPgfExprEnum enum fpl master)
               prob <- (#peek PgfExprProb, prob) pgfExprProb
               return ((Expr expr master,prob) : ts)

-----------------------------------------------------------------------
-- Exceptions

newtype PGFError = PGFError String
     deriving (Show, Typeable)

instance Exception PGFError
