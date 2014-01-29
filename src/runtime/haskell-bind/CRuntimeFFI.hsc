{-# LANGUAGE ForeignFunctionInterface, ExistentialQuantification, TypeSynonymInstances, FlexibleInstances #-}
#include <pgf/pgf.h>
#include <gu/enum.h>
#include <gu/exn.h>

module CRuntimeFFI(-- * PGF
                   PGF,readPGF,abstractName,startCat,
                   -- * Concrete syntax
                   Concr,Language,{-languages,-}getConcr,parse,linearize,
                   -- * Trees
                   Expr,Tree,readExpr,showExpr,unApp,
                   -- * Morphology
                   MorphoAnalysis,lookupMorpho,fullFormLexicon,
                   printLexEntry
                   ) where

import Prelude hiding (fromEnum)
--import Control.Monad
--import System.IO
import System.IO.Unsafe
import CId (CId(..), 
            mkCId, wildCId,
            readCId, showCId)
import Gu
import PgfLow

import Foreign hiding ( Pool, newPool, unsafePerformIO )
import Foreign.C
import Control.Exception
--import Foreign.C.String
--import Foreign.Ptr


--import Data.Char
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

     
newPool :: IO Pool
newPool =
  do pl <- gu_new_pool
     newForeignPtr_ pl --newForeignPtr gu_pool_free_ptr pl

--when you create a GuOut, you create also a GuStringBuf
--and when you give GuOut to a function that outputs something,
--the result goes into that GuStringBuf
newOut :: IO Out 
newOut =
   do sb <- withGuPool $ \pl -> gu_string_buf pl
      out <- gu_string_buf_out sb
      return (sb,out)
--  gu_string_buf :: Ptr GuPool -> IO (Ptr GuStringBuf)

-----------------------------------------------------------------------------
-- Functions that take a PGF.
-- PGF has many Concrs.
-- A Concr retains its PGF in a field (memory management reasons?)

data PGF = PGF {pgfPool :: Ptr GuPool, pgf :: Ptr PgfPGF} deriving Show
data Concr = Concr {concr :: (Ptr PgfConcr), concrMaster :: PGF}
type Language = CId

readPGF :: FilePath -> IO PGF
readPGF filepath =
  do pool <- gu_new_pool
     pgf <- withCString filepath $ \file -> 
              pgf_read file pool nullPtr
     return PGF {pgfPool = pool, pgf = pgf}
    -- withGuPool $ \pl ->
    --   do pgf <- withCString filepath $ \file ->
    --                pgf_read file pl nullPtr
    --      return PGF {pgfPool = pl, pgf = pgf}       



getConcr :: PGF -> Language -> Maybe Concr
getConcr p (CId lang) = unsafePerformIO $
    BS.useAsCString lang $ \lng -> do
        cnc <- pgf_get_language (pgf p) lng
        return (if cnc==nullPtr then Nothing else Just (Concr cnc p))



-- languages :: PGF -> [Concr]
-- languages p = undefined
--TODO 
-- void pgf_iter_languages(PgfPGF* pgf, GuMapItor* fn, GuExn* err)
-- {
-- 	gu_map_iter(pgf->concretes, fn, err);
-- }

generateAll :: PGF -> CId -> [(Tree,Float)]
generateAll p (CId cat) = unsafePerformIO $
  do pgfExprs <- BS.useAsCString cat $ \cat ->
                    withGuPool $ \pl ->
                      pgf_generate_all (pgf p) cat pl
     fromPgfExprEnum pgfExprs p

abstractName :: PGF -> Language
abstractName p = unsafePerformIO $ fmap CId (BS.packCString =<< pgf_abstract_name (pgf p))

startCat :: PGF -> CId
startCat p = unsafePerformIO $ fmap CId (BS.packCString =<< pgf_start_cat (pgf p))

printGrammar :: PGF -> Pool -> String
printGrammar p pool = unsafePerformIO $
  do (sb,out) <- newOut
     pgf_print (pgf p) out nullPtr
     withGuPool $ \pl ->
         do grammar <- gu_string_buf_freeze sb pl
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
 do pool <- gu_new_pool  --we return this pool with the Expr
    withCString str $ \str ->
     withGuPool $ \pl1 ->   --these pools are freed right after
       withGuPool $ \pl2 ->
         do guin <- gu_string_in str pl1
            exn <- gu_new_exn nullPtr gu_type__type pl2
            pgfExpr <- pgf_read_expr guin pool exn
            status <- gu_exn_is_raised exn
            if (status==False && pgfExpr /= nullPtr)
              then return $ Just (Expr pgfExpr pool)
              else do
                   gu_pool_free pool --if Expr is not returned, free pool
                   return Nothing

showExpr :: Expr -> String
showExpr e = unsafePerformIO $
 do (sb,out) <- newOut
    let printCtxt = nullPtr
    exn <- withGuPool $ \pl ->
        gu_new_exn nullPtr gu_type__type pl
    pgf_print_expr (expr e) printCtxt 1 out exn
    withGuPool $ \pl ->
       do abstree <- gu_string_buf_freeze sb pl
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
          do pool <- newPool
             lexEnum <- withGuPool $ \pl -> 
                 pgf_fullform_lexicon (concr lang) pl
             fromFullFormEntry lexEnum (concrMaster lang)

printLexEntry :: (String, [MorphoAnalysis]) -> String
printLexEntry (lemma, anals) = 
  "Lemma: " ++ lemma ++ "\nAnalyses: " ++ show anals ++ "\n" -- map show' anals
--      where show' :: MorphoAnalysis -> String
--            show' (id,anal,prob) = showCId id ++ ", " ++ anal ++ ", " ++ show prob ++ "\n"


--Note: unlike in Haskell library, we give Concr -> ... and not PGF -> Lang -> ...
--Also this returns a list of tuples (tree,prob) instead of just trees
parse :: Concr -> CId -> String -> [(Tree,Float)]
parse (Concr lang master) (CId cat) sent = unsafePerformIO $
  do treesEnum <- parse_ lang cat sent
     fromPgfExprEnum treesEnum master
  where 
    parse_ :: Ptr PgfConcr -> BS.ByteString -> String -> IO (Ptr PgfExprEnum)
    parse_ pgfcnc cat sent =
      do putStrLn "foo"
         inpool <- gu_new_pool
         outpool <- gu_new_pool
         BS.useAsCString cat $ \cat ->
                   withCString sent $ \sent ->
                     pgf_parse pgfcnc cat sent nullPtr inpool outpool 
                           -- `finally` do (gu_pool_free inpool)
                           --              (gu_pool_free outpool)
         -- gu_pool_free inpool
         -- gu_pool_free outpool
         -- return enum

--In Haskell library, this function has type signature PGF -> Language -> Tree -> String
--Here we replace PGF -> Language with Concr
linearize :: Concr -> Tree -> String
linearize lang tree = unsafePerformIO $
  do pool <- newPool
     (sb,out) <- newOut
     pgf_linearize (concr lang) (expr tree) out nullPtr --linearization goes to stringbuf
     withGuPool $ \pl ->
         do lin <- gu_string_buf_freeze sb pl
            peekCString lin



-----------------------------------------------------------------------------
-- Helper functions

-- # syntax: http://www.haskell.org/ghc/docs/7.2.1/html/users_guide/hsc2hs.html
fromPgfExprEnum :: Ptr PgfExprEnum -> a -> IO [(Tree, Float)]
fromPgfExprEnum enum master = 
  do pgfExprProb <- alloca $ \ptr -> 
                      withGuPool $ \pl -> 
                        do gu_enum_next enum ptr pl
                           peek ptr
     if pgfExprProb == nullPtr
       then return []
       else do expr <- (#peek PgfExprProb, expr) pgfExprProb
               prob <- (#peek PgfExprProb, prob) pgfExprProb
               ts <- unsafeInterleaveIO (fromPgfExprEnum enum master)
               return ((Expr expr master, prob) : ts)

fromFullFormEntry :: Ptr GuEnum -> PGF -> IO [String]
fromFullFormEntry enum master = 
  do ffEntry <- alloca $ \ptr ->
                  withGuPool $ \pl ->
                    do gu_enum_next enum ptr pl
                       peek ptr 
--   ffEntry :: Ptr PgfFullFormEntry
     if ffEntry == nullPtr
       then return []
       else do tok <- peekCString =<< pgf_fullform_get_string ffEntry
               toks <- unsafeInterleaveIO (fromFullFormEntry enum master)
               return (tok : toks)
