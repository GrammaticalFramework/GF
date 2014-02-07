{-# LANGUAGE ForeignFunctionInterface, ExistentialQuantification, TypeSynonymInstances, FlexibleInstances #-}
#include <pgf/pgf.h>
#include <gu/enum.h>
#include <gu/exn.h>

module CRuntimeFFI(-- * PGF
                   PGF,readPGF,abstractName,startCat,
                   -- * Concrete syntax
                   Concr,Language,languages,getConcr,parse,linearize,
                   -- * Trees
                   Expr,Tree,readExpr,showExpr,unApp,
                   -- * Morphology
                   MorphoAnalysis,lookupMorpho,fullFormLexicon,
                   printLexEntry,
                   ) where

import Prelude hiding (fromEnum)
import Control.Exception
import System.IO
import System.IO.Unsafe
import CId (CId(..), 
            mkCId, wildCId,
            readCId, showCId)
import Gu
import PgfLow

import Foreign hiding ( Pool, newPool, unsafePerformIO )
import Foreign.C
import Foreign.C.String
import Foreign.Ptr


import Data.Char
import Data.Map (Map, empty, insert)
import qualified Data.ByteString as BS
import Data.IORef


-----------------------------------------------------------------------------
-- How to compile
-- hsc2hs Gu.hsc CRuntimeFFI.hsc -v --cflag="-std=c99" && ghc -lpgf -lgu --make CRuntimeFFI 
-----------------------------------------------------------------------------
-- Mindless copypasting and translating of the C functions in Gu.hsc and PgfLow.hs
-- More user-friendly functions here 

-----------------------------------------------------------------------------
--Memory management, pools and outs
type Pool = ForeignPtr GuPool
type Out = (Ptr GuStringBuf, Ptr GuOut)


--when you create a GuOut, you create also a GuStringBuf
--and when you give GuOut to a function that outputs something,
--the result goes into that GuStringBuf
newOut :: Ptr GuPool -> IO Out 
newOut pool =
   do sb <- gu_string_buf pool
      out <- gu_string_buf_out sb
      return (sb,out)
--Don't create newOut using withGuPool inside
--Rather do like this:
{-
withGuPool $ \pl ->
  do out <- newOut pl
     <other stuff>
-}
  -- withGuPool $ \pl -> 
  --   do sb <- gu_string_buf pl
  --      out <- gu_string_buf_out sb
  --      return (sb,out)


-----------------------------------------------------------------------------
-- Functions that take a PGF.
-- PGF has many Concrs.
-- A Concr retains its PGF in a field (memory management reasons?)

data PGF = PGF {pgfPool :: Ptr GuPool, pgf :: Ptr PgfPGF} deriving Show
data Concr = Concr {concr :: (Ptr PgfConcr), concrMaster :: PGF}
type Language = CId

readPGF :: FilePath -> IO PGF
readPGF filepath =
  do pl <- gu_new_pool
     pgf <- withCString filepath $ \file -> 
              pgf_read file pl nullPtr
     return PGF {pgfPool = pl, pgf = pgf}


getConcr :: PGF -> Language -> Maybe Concr
getConcr p (CId lang) = unsafePerformIO $
    BS.useAsCString lang $ \lng -> do
        cnc <- pgf_get_language (pgf p) lng
        return (if cnc==nullPtr then Nothing else Just (Concr cnc p))


languages :: PGF -> Map Language Concr
languages p = unsafePerformIO $
    do ref <- newIORef empty
       allocaBytes (#size GuMapItor) $ \itor ->
                   do fptr <- wrapLanguages (getLanguages ref)
                      (#poke GuMapItor, fn) itor fptr
                      pgf_iter_languages (pgf p) itor nullPtr
       readIORef ref
    where
       getLanguages :: IORef (Map Language Concr) -> Languages
       getLanguages ref itor key value exn = do
         langs <- readIORef ref
         key'  <- fmap CId  $ BS.packCString (castPtr key)
         value' <- fmap (\ptr -> Concr ptr p) $  peek (castPtr value)
         writeIORef ref (insert key' value' langs)
--type Languages = Ptr GuMapItor -> Ptr () -> Ptr () -> Ptr GuExn -> IO (


generateAll :: PGF -> CId -> [(Tree,Float)]
generateAll p (CId cat) = unsafePerformIO $
  withGuPool $ \iterPl ->
--    withGuPool $ \exprPl -> --segfaults if I use this
      do exprPl <- gu_new_pool
         pgfExprs <- BS.useAsCString cat $ \cat ->
                     pgf_generate_all (pgf p) cat exprPl --this pool isn't freed. segfaults if I try.
         fromPgfExprEnum pgfExprs iterPl p --this pool is freed afterwards. it's used in fromPgfExprEnum, and I imagine it makes more sense to give a pool as an argument, rather than in that function create and free new pools in its body (it calls itself recursively)
         

abstractName :: PGF -> Language
abstractName p = unsafePerformIO $ fmap CId (BS.packCString =<< pgf_abstract_name (pgf p))

startCat :: PGF -> CId
startCat p = unsafePerformIO $ fmap CId (BS.packCString =<< pgf_start_cat (pgf p))

printGrammar :: PGF -> String
printGrammar p = unsafePerformIO $
  withGuPool $ \outPl ->
    withGuPool $ \printPl ->
      do (sb,out) <- newOut outPl
         pgf_print (pgf p) out nullPtr --nullPtr is for exception
         grammar <- gu_string_buf_freeze sb printPl
         peekCString grammar
 

-----------------------------------------------------------------------------
-- Expressions

--exprMaster is one of the following: 
-- * PGF 
-- * pool from which the expr is allocated
-- * iterator from generateAll
-- TODO ask more about this design
-- the master of an Expr needs to be retained because of memory management (?)
data Expr = forall a . Expr {expr :: PgfExpr, exprMaster :: a}

instance Show Expr where
  show = showExpr

instance Eq Expr where
  (Expr e1 m1) == (Expr e2 m2) = e1 == e2

type Tree = Expr


unApp :: Expr -> Maybe (CId,[Expr])
unApp (Expr expr master) = unsafePerformIO $
  withGuPool $ \pl -> do
     pgfAppl <- pgf_expr_unapply expr pl
     if pgfAppl == nullPtr
       then return Nothing
       else do 
          fun <- peekCString =<< (#peek PgfApplication, fun) pgfAppl
          arity <- (#peek PgfApplication, n_args) pgfAppl :: IO CInt 
          pgfExprs <- ptrToList pgfAppl (fromIntegral arity) --CInt to Int
          --print (arity,fun)
          let args = [Expr a master | a<-pgfExprs]
          return $ Just (mkCId fun, args)

--Krasimir recommended not to use PgfApplication, but PgfExprApp instead.
--but then we found out that some of those functions don't behave nicely 
--with the FFI, so we need to use PgfApplication anyway, unless we do some
--C coding to make the C library nicer.


readExpr :: String -> Maybe Expr
readExpr str = unsafePerformIO $
 do exprPl <- gu_new_pool  --we return this pool with the Expr
    withGuPool $ \inPl ->   --these pools are freed right after
      withGuPool $ \exnPl ->
        withCString str $ \str ->
         do guin <- gu_string_in str inPl
            exn <- gu_new_exn nullPtr gu_type__type exnPl
            pgfExpr <- pgf_read_expr guin exprPl exn
            status <- gu_exn_is_raised exn
            if (status==False && pgfExpr /= nullPtr)
              then return $ Just (Expr pgfExpr exprPl)
              else do
                   gu_pool_free exprPl --if Expr is not returned, free pool
                   return Nothing

-- TODO: do we need 3 different pools for this?
showExpr :: Expr -> String
showExpr e = unsafePerformIO $
  withGuPool $ \pl ->
    do (sb,out) <- newOut pl
       let printCtxt = nullPtr
       exn <- gu_new_exn nullPtr gu_type__type pl
       pgf_print_expr (expr e) printCtxt 1 out exn
       abstree <- gu_string_buf_freeze sb pl
       peekCString abstree


-----------------------------------------------------------------------------
-- Functions using Concr
-- Morpho analyses, parsing & linearization

type MorphoAnalysis = (CId,String,Float)


--There is no buildMorpho in the C library, just a lookupMorpho from a Concr
lookupMorpho :: Concr -> String -> [MorphoAnalysis]
lookupMorpho (Concr concr master) sent = unsafePerformIO $
  do ref <- newIORef []
     allocaBytes (#size PgfMorphoCallback) $ \cback -> 
                        do fptr <- wrapLookupMorpho (getAnalysis ref)
                           (#poke PgfMorphoCallback, callback) cback fptr
                           withCString sent $ \sent ->
                             pgf_lookup_morpho concr sent cback nullPtr

     readIORef ref
  where 
    getAnalysis :: IORef [MorphoAnalysis] -> Ptr PgfMorphoCallback -> CString -> CString -> Float -> Ptr GuExn -> IO () --IORef [(CId, String, Float)] -> Callback
    getAnalysis ref self clemma canal prob exn = do
      ans <- readIORef ref
      lemma <- fmap CId (BS.packCString clemma)
      anal  <- peekCString canal
      writeIORef ref ((lemma, anal, prob):ans)

fullFormLexicon :: Concr -> [(String, [MorphoAnalysis])]
fullFormLexicon lang = 
  let lexicon  = fullformLexicon' lang
      analyses = map (lookupMorpho lang) lexicon
  in  zip lexicon analyses
  where fullformLexicon' :: Concr -> [String]
        fullformLexicon' lang = unsafePerformIO $
            do pl <- gu_new_pool
               lexEnum <- pgf_fullform_lexicon (concr lang) pl
               fromFullFormEntry lexEnum  pl (concrMaster lang)

printLexEntry :: (String, [MorphoAnalysis]) -> String
printLexEntry (lemma, anals) = 
  "Lemma: " ++ lemma ++ "\nAnalyses: " ++ show anals ++ "\n" -- map show' anals
--      where show' :: MorphoAnalysis -> String
--            show' (id,anal,prob) = showCId id ++ ", " ++ anal ++ ", " ++ show prob ++ "\n"


--Note: unlike in Haskell library, we give Concr -> ... and not PGF -> Lang -> ...
--Also this returns a list of tuples (tree,prob) instead of just trees
parse :: Concr -> CId -> String -> [(Tree,Float)]
parse (Concr lang master) (CId cat) sent = unsafePerformIO $
   withGuPool $ \iterPl ->   -- this pool will get freed eventually
     do inpool      <- gu_new_pool
        outpool     <- gu_new_pool
        treesEnum   <- parse_ lang cat sent inpool outpool
        outpoolFPtr <- newForeignPtr gu_pool_free_ptr outpool
        fromPgfExprEnum treesEnum iterPl (master,outpoolFPtr)
  where  
    parse_ :: Ptr PgfConcr -> BS.ByteString -> String -> Ptr GuPool -> Ptr GuPool -> IO (Ptr PgfExprEnum)
    parse_ pgfcnc cat sent inpool outpool =
      do BS.useAsCString cat $ \cat ->
           withCString sent $ \sent ->
             pgf_parse pgfcnc cat sent nullPtr inpool outpool


--In Haskell library, this function has type signature PGF -> Language -> Tree -> String
--Here we replace PGF -> Language with Concr
linearize :: Concr -> Tree -> String
linearize lang tree = unsafePerformIO $
  withGuPool $ \outPl ->
    withGuPool $ \linPl ->
     do (sb,out) <- newOut outPl
        pgf_linearize (concr lang) (expr tree) out nullPtr --linearization goes to stringbuf
        lin <- gu_string_buf_freeze sb linPl
        peekCString lin


-----------------------------------------------------------------------------
-- Helper functions

-- # syntax: http://www.haskell.org/ghc/docs/7.2.1/html/users_guide/hsc2hs.html
fromPgfExprEnum :: Ptr PgfExprEnum -> Ptr GuPool -> a -> IO [(Tree, Float)]
fromPgfExprEnum enum pl master = 
  do pgfExprProb <- alloca $ \ptr -> 
                      do gu_enum_next enum ptr pl
                         peek ptr
     if pgfExprProb == nullPtr
       then return []
       else do expr <- (#peek PgfExprProb, expr) pgfExprProb
               prob <- (#peek PgfExprProb, prob) pgfExprProb
               ts <- unsafeInterleaveIO (fromPgfExprEnum enum pl master)
               return ((Expr expr master,prob) : ts)


fromFullFormEntry :: Ptr GuEnum -> Ptr GuPool -> PGF -> IO [String]
fromFullFormEntry enum pl master = 
  do ffEntry <- alloca $ \ptr ->
                  do gu_enum_next enum ptr pl
                     peek ptr 
--   ffEntry :: Ptr PgfFullFormEntry
     if ffEntry == nullPtr
       then return []
       else do tok <- peekCString =<< pgf_fullform_get_string ffEntry
               toks <- unsafeInterleaveIO (fromFullFormEntry enum pl master)
               return (tok : toks)
