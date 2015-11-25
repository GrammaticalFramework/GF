{-# LANGUAGE DeriveDataTypeable #-}

#include <pgf/pgf.h>
#include <gu/exn.h>
#include <sg/sg.h>

module SG( SG, openSG, closeSG
         , beginTrans, commit, rollback, inTransaction
         , SgId
         , insertExpr, getExpr
         , readTriple, showTriple
         , insertTriple, getTriple
         , queryTriple
         ) where

import Foreign hiding (unsafePerformIO)
import Foreign.C
import SG.FFI
import PGF2.FFI
import PGF2.Expr

import Data.Typeable
import Control.Exception(Exception,SomeException,catch,throwIO)
import System.IO.Unsafe(unsafePerformIO,unsafeInterleaveIO)

-----------------------------------------------------------------------
-- Global database operations and types

newtype SG = SG {sg :: Ptr SgSG}

openSG :: FilePath -> IO SG
openSG fpath =
  withCString fpath $ \c_fpath ->
  withGuPool $ \tmpPl -> do
    exn <- gu_new_exn tmpPl
    sg <- sg_open c_fpath exn
    failed <- gu_exn_is_raised exn
    if failed
      then do is_errno <- gu_exn_caught exn gu_exn_type_GuErrno
              if is_errno
                then do perrno <- (#peek GuExn, data.data) exn
                        errno  <- peek perrno
                        ioError (errnoToIOError "openSG" (Errno errno) Nothing (Just fpath))
                else do is_sgerr <- gu_exn_caught exn gu_exn_type_SgError
                        if is_sgerr
                          then do c_msg <- (#peek GuExn, data.data) exn
                                  msg <- peekCString c_msg
                                  throwIO (SGError msg)
                          else throwIO (SGError "The database cannot be opened")
      else return (SG sg)

closeSG :: SG -> IO ()
closeSG (SG sg) =
  withGuPool $ \tmpPl -> do
    exn <- gu_new_exn tmpPl
    sg <- sg_close sg exn
    handle_sg_exn exn

beginTrans :: SG -> IO ()
beginTrans (SG sg) =
  withGuPool $ \tmpPl -> do
    exn <- gu_new_exn tmpPl
    sg <- sg_begin_trans sg exn
    handle_sg_exn exn

commit :: SG -> IO ()
commit (SG sg) =
  withGuPool $ \tmpPl -> do
    exn <- gu_new_exn tmpPl
    sg <- sg_commit sg exn
    handle_sg_exn exn

rollback :: SG -> IO ()
rollback (SG sg) =
  withGuPool $ \tmpPl -> do
    exn <- gu_new_exn tmpPl
    sg <- sg_rollback sg exn
    handle_sg_exn exn

inTransaction :: SG -> IO a -> IO a
inTransaction sg f =
  catch (beginTrans sg >> f >>= \x -> commit sg >> return x)
        (\e -> rollback sg >> throwIO (e :: SomeException))

-----------------------------------------------------------------------
-- Expressions

insertExpr :: SG -> Expr -> IO SgId
insertExpr (SG sg) (Expr expr _) =
  withGuPool $ \tmpPl -> do
    exn <- gu_new_exn tmpPl
    id <- sg_insert_expr sg expr exn
    handle_sg_exn exn
    return id

getExpr :: SG -> SgId -> IO (Maybe Expr)
getExpr (SG sg) id = do
  exprPl  <- gu_new_pool
  exprFPl <- newForeignPtr gu_pool_finalizer exprPl
  withGuPool $ \tmpPl -> do
    exn <- gu_new_exn tmpPl
    c_expr <- sg_get_expr sg id exprPl exn
    handle_sg_exn exn
    if c_expr == nullPtr
      then do touchForeignPtr exprFPl
              return Nothing
      else do return $ Just (Expr c_expr exprFPl)

-----------------------------------------------------------------------
-- Triples

readTriple :: String -> Maybe (Expr,Expr,Expr)
readTriple str =
  unsafePerformIO $
    do exprPl <- gu_new_pool
       withGuPool $ \tmpPl ->
         withCString str $ \c_str ->
           withTriple $ \triple -> do
             do guin <- gu_string_in c_str tmpPl
                exn <- gu_new_exn tmpPl
                ok <- pgf_read_expr_tuple guin 3 triple exprPl exn
                status <- gu_exn_is_raised exn
                if (ok == 1 && not status)
                  then do c_expr1 <- peekElemOff triple 0
                          c_expr2 <- peekElemOff triple 1
                          c_expr3 <- peekElemOff triple 2
                          exprFPl <- newForeignPtr gu_pool_finalizer exprPl
                          return $ Just (Expr c_expr1 exprFPl,Expr c_expr2 exprFPl,Expr c_expr3 exprFPl)
                  else do gu_pool_free exprPl
                          return Nothing

showTriple :: Expr -> Expr -> Expr -> String
showTriple (Expr expr1 _) (Expr expr2 _) (Expr expr3 _) =
  unsafePerformIO $
    withGuPool $ \tmpPl ->
      withTriple $ \triple -> do
         (sb,out) <- newOut tmpPl
         let printCtxt = nullPtr
         exn <- gu_new_exn tmpPl
         pokeElemOff triple 0 expr1
         pokeElemOff triple 1 expr2
         pokeElemOff triple 2 expr3
         pgf_print_expr_tuple 3 triple printCtxt out exn
         s <- gu_string_buf_freeze sb tmpPl
         peekCString s

insertTriple :: SG -> Expr -> Expr -> Expr -> IO SgId
insertTriple (SG sg) (Expr expr1 _) (Expr expr2 _) (Expr expr3 _) =
  withGuPool $ \tmpPl -> 
  withTriple $ \triple -> do
    exn <- gu_new_exn tmpPl
    pokeElemOff triple 0 expr1
    pokeElemOff triple 1 expr2
    pokeElemOff triple 2 expr3
    id <- sg_insert_triple sg triple exn
    handle_sg_exn exn
    return id

getTriple :: SG -> SgId -> IO (Maybe (Expr,Expr,Expr))
getTriple (SG sg) id = do
  exprPl <- gu_new_pool
  exprFPl <- newForeignPtr gu_pool_finalizer exprPl
  withGuPool $ \tmpPl ->
   withTriple $ \triple -> do
     exn <- gu_new_exn tmpPl
     res <- sg_get_triple sg id triple exprPl exn
     handle_sg_exn exn
     if res /= 0
       then do c_expr1 <- peekElemOff triple 0
               c_expr2 <- peekElemOff triple 1
               c_expr3 <- peekElemOff triple 2
               return (Just (Expr c_expr1 exprFPl
                            ,Expr c_expr2 exprFPl
                            ,Expr c_expr3 exprFPl
                            ))
       else do touchForeignPtr exprFPl
               return Nothing

queryTriple :: SG -> Maybe Expr -> Maybe Expr -> Maybe Expr -> IO [(SgId,Expr,Expr,Expr)]
queryTriple (SG sg) mb_expr1 mb_expr2 mb_expr3 =
  withGuPool $ \tmpPl ->
  withTriple $ \triple -> do
    exn <- gu_new_exn tmpPl
    pokeElemOff triple 0 (toCExpr mb_expr1)
    pokeElemOff triple 1 (toCExpr mb_expr2)
    pokeElemOff triple 2 (toCExpr mb_expr3)
    res <- sg_query_triple sg triple exn
    handle_sg_exn exn
    unsafeInterleaveIO (fetchResults res)
  where
    toCExpr Nothing              = nullPtr
    toCExpr (Just (Expr expr _)) = expr

    fromCExpr c_expr exprFPl Nothing  = Expr c_expr exprFPl
    fromCExpr c_expr exprFPl (Just e) = e

    fetchResults res = do
      exprPl  <- gu_new_pool
      alloca $ \pKey ->
       withGuPool $ \tmpPl ->
        withTriple $ \triple -> do
          exn <- gu_new_exn tmpPl
          r <- sg_triple_result_fetch res pKey triple exprPl exn
          failed <- gu_exn_is_raised exn
          if failed
            then do gu_pool_free exprPl
                    sg_triple_result_close res exn
                    handle_sg_exn exn
                    return []
            else if r == 0
                   then do gu_pool_free exprPl
                           sg_triple_result_close res exn
                           return []
                   else do exprFPl <- newForeignPtr gu_pool_finalizer exprPl
                           c_expr1 <- peekElemOff triple 0
                           c_expr2 <- peekElemOff triple 1
                           c_expr3 <- peekElemOff triple 2
                           key <- peek pKey
                           rest <- unsafeInterleaveIO (fetchResults res)
                           return ((key,fromCExpr c_expr1 exprFPl mb_expr1
                                       ,fromCExpr c_expr2 exprFPl mb_expr2
                                       ,fromCExpr c_expr3 exprFPl mb_expr3) : rest)

-----------------------------------------------------------------------
-- Exceptions

newtype SGError = SGError String
     deriving (Show, Typeable)

instance Exception SGError

handle_sg_exn exn = do
  failed <- gu_exn_is_raised exn
  if failed
    then do is_sgerr <- gu_exn_caught exn gu_exn_type_SgError
            if is_sgerr
              then do c_msg <- (#peek GuExn, data.data) exn
                      msg <- peekCString c_msg
                      throwIO (SGError msg)
              else throwIO (SGError "Unknown database error")
    else return ()

-----------------------------------------------------------------------
