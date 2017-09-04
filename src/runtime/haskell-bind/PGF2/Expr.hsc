#include <pgf/pgf.h>

module PGF2.Expr where

import System.IO.Unsafe(unsafePerformIO)
import Foreign hiding (unsafePerformIO)
import Foreign.C
import PGF2.FFI

-- | An data type that represents
-- identifiers for functions and categories in PGF.
type CId = String

wildCId = "_" :: CId

type Cat = CId -- ^ Name of syntactic category
type Fun = CId -- ^ Name of function

data BindType = 
    Explicit
  | Implicit
  deriving Show

-----------------------------------------------------------------------------
-- Expressions

-- The C structure for the expression may point to other structures
-- which are allocated from other pools. In order to ensure that
-- they are not released prematurely we use the exprMaster to
-- store references to other Haskell objects

data Expr = Expr {expr :: PgfExpr, touchExpr :: Touch}

instance Show Expr where
  show = showExpr []

instance Eq Expr where
  (Expr e1 e1_touch) == (Expr e2 e2_touch) = 
    unsafePerformIO $ do
      res <- pgf_expr_eq e1 e2
      e1_touch >> e2_touch
      return (res /= 0)

-- | Constructs an expression by lambda abstraction
mkAbs :: BindType -> CId -> Expr -> Expr
mkAbs bind_type var (Expr body bodyTouch) =
  unsafePerformIO $ do
      exprPl <- gu_new_pool
      cvar <- newUtf8CString var exprPl
      c_expr <- pgf_expr_abs cbind_type cvar body exprPl
      exprFPl <- newForeignPtr gu_pool_finalizer exprPl
      return (Expr c_expr (bodyTouch >> touchForeignPtr exprFPl))
  where
    cbind_type = 
      case bind_type of
        Explicit -> (#const PGF_BIND_TYPE_EXPLICIT)
        Implicit -> (#const PGF_BIND_TYPE_IMPLICIT)

-- | Decomposes an expression into an abstraction and a body
unAbs :: Expr -> Maybe (BindType, CId, Expr)
unAbs (Expr expr touch) =
  unsafePerformIO $ do
      c_abs <- pgf_expr_unabs expr
      if c_abs == nullPtr
        then return Nothing
        else do bt  <- fmap toBindType ((#peek PgfExprAbs, bind_type) c_abs)
                var <- (#peek PgfExprAbs, id) c_abs >>= peekUtf8CString
                c_body <- (#peek PgfExprAbs, body) c_abs
                return (Just (bt, var, Expr c_body touch))
  where
    toBindType :: CInt -> BindType
    toBindType (#const PGF_BIND_TYPE_EXPLICIT) = Explicit
    toBindType (#const PGF_BIND_TYPE_IMPLICIT) = Implicit

-- | Constructs an expression by applying a function to a list of expressions
mkApp :: Fun -> [Expr] -> Expr
mkApp fun args =
  unsafePerformIO $
    withCString fun $ \cfun ->
    allocaBytes ((#size PgfApplication) + len * sizeOf (undefined :: PgfExpr)) $ \papp -> do
      (#poke PgfApplication, fun) papp cfun
      (#poke PgfApplication, n_args) papp len
      pokeArray (papp `plusPtr` (#offset PgfApplication, args)) (map expr args)
      exprPl <- gu_new_pool
      c_expr <- pgf_expr_apply papp exprPl
      exprFPl <- newForeignPtr gu_pool_finalizer exprPl
      return (Expr c_expr (mapM_ touchExpr args >> touchForeignPtr exprFPl))
  where
    len = length args

-- | Decomposes an expression into an application of a function
unApp :: Expr -> Maybe (Fun,[Expr])
unApp (Expr expr touch) =
  unsafePerformIO $
    withGuPool $ \pl -> do
      appl <- pgf_expr_unapply expr pl
      if appl == nullPtr
        then return Nothing
        else do 
           fun <- peekCString =<< (#peek PgfApplication, fun) appl
           arity <- (#peek PgfApplication, n_args) appl :: IO CInt 
           c_args <- peekArray (fromIntegral arity) (appl `plusPtr` (#offset PgfApplication, args))
           return $ Just (fun, [Expr c_arg touch | c_arg <- c_args])

-- | Constructs an expression from a string literal
mkStr :: String -> Expr
mkStr str =
  unsafePerformIO $
    withCString str $ \cstr -> do
      exprPl <- gu_new_pool
      c_expr <- pgf_expr_string cstr exprPl
      exprFPl <- newForeignPtr gu_pool_finalizer exprPl
      return (Expr c_expr (touchForeignPtr exprFPl))

-- | Decomposes an expression into a string literal
unStr :: Expr -> Maybe String
unStr (Expr expr touch) =
  unsafePerformIO $ do
    plit <- pgf_expr_unlit expr (#const PGF_LITERAL_STR)
    if plit == nullPtr
      then return Nothing
      else do s <- peekUtf8CString (plit `plusPtr` (#offset PgfLiteralStr, val))
              touch
              return (Just s)

-- | Constructs an expression from an integer literal
mkInt :: Int -> Expr
mkInt val =
  unsafePerformIO $ do
      exprPl <- gu_new_pool
      c_expr <- pgf_expr_int (fromIntegral val) exprPl
      exprFPl <- newForeignPtr gu_pool_finalizer exprPl
      return (Expr c_expr (touchForeignPtr exprFPl))

-- | Decomposes an expression into an integer literal
unInt :: Expr -> Maybe Int
unInt (Expr expr touch) =
  unsafePerformIO $ do
    plit <- pgf_expr_unlit expr (#const PGF_LITERAL_INT)
    if plit == nullPtr
      then return Nothing
      else do n <- peek (plit `plusPtr` (#offset PgfLiteralInt, val))
              touch
              return (Just (fromIntegral (n :: CInt)))

-- | Constructs an expression from a real number
mkFloat :: Double -> Expr
mkFloat val =
  unsafePerformIO $ do
      exprPl <- gu_new_pool
      c_expr <- pgf_expr_float (realToFrac val) exprPl
      exprFPl <- newForeignPtr gu_pool_finalizer exprPl
      return (Expr c_expr (touchForeignPtr exprFPl))

-- | Decomposes an expression into a real number literal
unFloat :: Expr -> Maybe Double
unFloat (Expr expr touch) =
  unsafePerformIO $ do
    plit <- pgf_expr_unlit expr (#const PGF_LITERAL_FLT)
    if plit == nullPtr
      then return Nothing
      else do n <- peek (plit `plusPtr` (#offset PgfLiteralFlt, val))
              touch
              return (Just (realToFrac (n :: CDouble)))

-- | Constructs a meta variable as an expression
mkMeta :: Int -> Expr
mkMeta id =
  unsafePerformIO $ do
      exprPl <- gu_new_pool
      c_expr <- pgf_expr_meta (fromIntegral id) exprPl
      exprFPl <- newForeignPtr gu_pool_finalizer exprPl
      return (Expr c_expr (touchForeignPtr exprFPl))

-- | Decomposes an expression into a meta variable
unMeta :: Expr -> Maybe Int
unMeta (Expr expr touch) =
  unsafePerformIO $ do
      c_meta <- pgf_expr_unmeta expr
      if c_meta == nullPtr
        then return Nothing
        else do id <- (#peek PgfExprMeta, id) c_meta
                touch
                return (Just (fromIntegral (id :: CInt)))

-- | this functions is only for backward compatibility with the old Haskell runtime
mkCId x = x

-- | parses a 'String' as an expression
readExpr :: String -> Maybe Expr
readExpr str =
  unsafePerformIO $
    do exprPl <- gu_new_pool
       withGuPool $ \tmpPl ->
         do c_str <- newUtf8CString str tmpPl
            guin <- gu_string_in c_str tmpPl
            exn <- gu_new_exn tmpPl
            c_expr <- pgf_read_expr guin exprPl exn
            status <- gu_exn_is_raised exn
            if (not status && c_expr /= nullPtr)
              then do exprFPl <- newForeignPtr gu_pool_finalizer exprPl
                      return $ Just (Expr c_expr (touchForeignPtr exprFPl))
              else do gu_pool_free exprPl
                      return Nothing

-- | renders an expression as a 'String'. The list
-- of identifiers is the list of all free variables
-- in the expression in order reverse to the order
-- of binding.
showExpr :: [CId] -> Expr -> String
showExpr scope e = 
  unsafePerformIO $
    withGuPool $ \tmpPl ->
      do (sb,out) <- newOut tmpPl
         printCtxt <- newPrintCtxt scope tmpPl
         exn <- gu_new_exn tmpPl
         pgf_print_expr (expr e) printCtxt 1 out exn
         touchExpr e
         s <- gu_string_buf_freeze sb tmpPl
         peekUtf8CString s

newPrintCtxt :: [String] -> Ptr GuPool -> IO (Ptr PgfPrintContext)
newPrintCtxt []     pool = return nullPtr
newPrintCtxt (x:xs) pool = do
  pctxt <- gu_malloc pool (#size PgfPrintContext)
  newUtf8CString x  pool >>= (#poke PgfPrintContext, name) pctxt
  newPrintCtxt   xs pool >>= (#poke PgfPrintContext, next) pctxt
  return pctxt
