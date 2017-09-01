#include <pgf/pgf.h>

module PGF2.Type where

import System.IO.Unsafe(unsafePerformIO)
import Foreign hiding (unsafePerformIO)
import Foreign.C
import qualified Text.PrettyPrint as PP
import Data.List(mapAccumL)
import PGF2.Expr
import PGF2.FFI

-- The C structure for the expression may point to other structures
-- which are allocated from other pools. In order to ensure that
-- they are not released prematurely we use the exprMaster to
-- store references to other Haskell objects
data Type = Type {typ :: PgfExpr, touchType :: Touch}

-- | 'Hypo' represents a hypothesis in a type i.e. in the type A -> B, A is the hypothesis
type Hypo = (BindType,CId,Type)

instance Show Type where
  show = showType []

-- | parses a 'String' as a type
readType :: String -> Maybe Type
readType str =
  unsafePerformIO $
    do typPl <- gu_new_pool
       withGuPool $ \tmpPl ->
         do c_str <- newUtf8CString str tmpPl
            guin <- gu_string_in c_str tmpPl
            exn <- gu_new_exn tmpPl
            c_type <- pgf_read_type guin typPl exn
            status <- gu_exn_is_raised exn
            if (not status && c_type /= nullPtr)
              then do typFPl <- newForeignPtr gu_pool_finalizer typPl
                      return $ Just (Type c_type (touchForeignPtr typFPl))
              else do gu_pool_free typPl
                      return Nothing

-- | renders a type as a 'String'. The list
-- of identifiers is the list of all free variables
-- in the type in order reverse to the order
-- of binding.
showType :: [CId] -> Type -> String
showType scope (Type ty touch) = 
  unsafePerformIO $
    withGuPool $ \tmpPl ->
      do (sb,out) <- newOut tmpPl
         printCtxt <- newPrintCtxt scope tmpPl
         exn <- gu_new_exn tmpPl
         pgf_print_type ty printCtxt 0 out exn
         touch
         s <- gu_string_buf_freeze sb tmpPl
         peekUtf8CString s

-- | creates a type from a list of hypothesises, a category and 
-- a list of arguments for the category. The operation 
-- @mkType [h_1,...,h_n] C [e_1,...,e_m]@ will create 
-- @h_1 -> ... -> h_n -> C e_1 ... e_m@
mkType :: [Hypo] -> CId -> [Expr] -> Type
mkType hypos cat exprs = unsafePerformIO $ do
  typPl  <- gu_new_pool
  let n_exprs = fromIntegral (length exprs) :: CInt
  c_type <- gu_malloc typPl ((#size PgfType) + n_exprs * (#size PgfExpr))
  c_hypos <- gu_make_seq (#size PgfHypo) (fromIntegral (length hypos)) typPl
  hs <- pokeHypos (c_hypos `plusPtr` (#offset GuSeq, data)) hypos typPl
  (#poke PgfType, hypos) c_type c_hypos
  ccat <- newUtf8CString cat typPl
  (#poke PgfType, cid) c_type ccat
  (#poke PgfType, n_exprs) c_type n_exprs
  pokeExprs (c_type `plusPtr` (#offset PgfType, exprs)) exprs
  typFPl <- newForeignPtr gu_pool_finalizer typPl
  return (Type c_type (mapM_ touchHypo hypos >> mapM_ touchExpr exprs >> touchForeignPtr typFPl))
  where
    pokeHypos :: Ptr a -> [Hypo] -> Ptr GuPool -> IO ()
    pokeHypos c_hypo []                                    typPl = return ()
    pokeHypos c_hypo ((bind_type,cid,Type c_ty _) : hypos) typPl = do
      (#poke PgfHypo, bind_type) c_hypo cbind_type
      newUtf8CString cid typPl >>= (#poke PgfHypo, cid) c_hypo
      (#poke PgfHypo, type) c_hypo c_ty
      pokeHypos (plusPtr c_hypo (#size PgfHypo)) hypos typPl
      where
        cbind_type :: CInt
        cbind_type =
          case bind_type of
            Explicit -> (#const PGF_BIND_TYPE_EXPLICIT)
            Implicit -> (#const PGF_BIND_TYPE_IMPLICIT)

    pokeExprs ptr []              = return ()
    pokeExprs ptr ((Expr e _):es) = do
      poke ptr e
      pokeExprs (plusPtr ptr (#size PgfExpr)) es

    touchHypo (_,_,ty) = touchType ty

-- | Decomposes a type into a list of hypothesises, a category and 
-- a list of arguments for the category.
unType :: Type -> ([Hypo],CId,[Expr])
unType (Type c_type touch) = unsafePerformIO $ do
  cid <- (#peek PgfType, cid) c_type >>= peekUtf8CString
  c_hypos <- (#peek PgfType, hypos) c_type
  n_hypos <- (#peek GuSeq, len) c_hypos
  hs <- peekHypos (c_hypos `plusPtr` (#offset GuSeq, data)) 0 n_hypos
  n_exprs <- (#peek PgfType, n_exprs) c_type
  es <- peekExprs (c_type `plusPtr` (#offset PgfType, exprs)) 0 n_exprs
  return (hs,cid,es)
  where
    peekHypos :: Ptr a -> Int -> Int -> IO [Hypo]
    peekHypos c_hypo i n
      | i < n     = do cid <- (#peek PgfHypo, cid) c_hypo >>= peekUtf8CString
                       c_ty <- (#peek PgfHypo, type) c_hypo
                       bt  <- fmap toBindType ((#peek PgfHypo, bind_type) c_hypo)
                       hs <- peekHypos (plusPtr c_hypo (#size PgfHypo)) (i+1) n
                       return ((bt,cid,Type c_ty touch) : hs)
      | otherwise = return []

    toBindType :: CInt -> BindType
    toBindType (#const PGF_BIND_TYPE_EXPLICIT) = Explicit
    toBindType (#const PGF_BIND_TYPE_IMPLICIT) = Implicit

    peekExprs ptr i n
      | i < n     = do e  <- peekElemOff ptr i
                       es <- peekExprs ptr (i+1) n
                       return (Expr e touch : es)
      | otherwise = return []
