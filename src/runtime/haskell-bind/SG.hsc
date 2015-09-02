{-# LANGUAGE DeriveDataTypeable #-}

#include <pgf/pgf.h>
#include <gu/exn.h>
#include <sg/sg.h>

module SG( SG, openSG, closeSG
         , beginTrans, commit, rollback, inTransaction
         , SgId
         , insertExpr
         , insertTriple
         ) where

import Foreign
import Foreign.C
import SG.FFI
import PGF2.FFI
import PGF2.Expr

import Data.Typeable
import Control.Exception(Exception,SomeException,catch,throwIO)

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

-----------------------------------------------------------------------
-- Triples

insertTriple :: SG -> Expr -> Expr -> Expr -> IO SgId
insertTriple (SG sg) (Expr expr1 _) (Expr expr2 _) (Expr expr3 _) =
  withGuPool $ \tmpPl -> 
  withTriple $ \triple -> do
    exn <- gu_new_exn tmpPl
    id1 <- sg_insert_expr sg expr1 exn
    handle_sg_exn exn
    pokeElemOff triple 0 id1
    id2 <- sg_insert_expr sg expr2 exn
    handle_sg_exn exn
    pokeElemOff triple 1 id2
    id3 <- sg_insert_expr sg expr3 exn
    handle_sg_exn exn
    pokeElemOff triple 2 id3
    id <- sg_insert_triple sg triple exn
    handle_sg_exn exn
    return id

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
