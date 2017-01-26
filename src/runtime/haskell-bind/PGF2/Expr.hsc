{-# LANGUAGE ExistentialQuantification #-}
#include <pgf/pgf.h>

module PGF2.Expr where

import System.IO.Unsafe(unsafePerformIO)
import Foreign hiding (unsafePerformIO)
import Foreign.C
import qualified Text.PrettyPrint as PP
import PGF2.FFI
import Data.List(mapAccumL)

-- | An data type that represents
-- identifiers for functions and categories in PGF.
type CId = String

ppCId = PP.text
wildCId = "_" :: CId

type Cat = CId -- ^ Name of syntactic category
type Fun = CId -- ^ Name of function

-----------------------------------------------------------------------------
-- Expressions

-- The C structure for the expression may point to other structures
-- which are allocated from other pools. In order to ensure that
-- they are not released prematurely we use the exprMaster to
-- store references to other Haskell objects

data Expr = forall a . Expr {expr :: PgfExpr, exprMaster :: a}

instance Show Expr where
  show = showExpr []

-- | Constructs an expression by lambda abstraction
mkAbs :: BindType -> CId -> Expr -> Expr
mkAbs bind_type var (Expr body master) =
  unsafePerformIO $ do
      exprPl <- gu_new_pool
      cvar <- newUtf8CString var exprPl
      c_expr <- pgf_expr_abs cbind_type cvar body exprPl
      exprFPl <- newForeignPtr gu_pool_finalizer exprPl
      return (Expr c_expr (exprFPl,body))
  where
    cbind_type = 
      case bind_type of
        Explicit -> (#const PGF_BIND_TYPE_EXPLICIT)
        Implicit -> (#const PGF_BIND_TYPE_IMPLICIT)

-- | Decomposes an expression into an abstraction and a body
unAbs :: Expr -> Maybe (BindType, CId, Expr)
unAbs (Expr expr master) =
  unsafePerformIO $ do
      c_abs <- pgf_expr_unabs expr
      if c_abs == nullPtr
        then return Nothing
        else do bt  <- fmap toBindType ((#peek PgfExprAbs, bind_type) c_abs)
                var <- (#peek PgfExprAbs, id) c_abs >>= peekUtf8CString
                c_body <- (#peek PgfExprAbs, body) c_abs
                return (Just (bt, var, Expr c_body master))
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
      return (Expr c_expr (exprFPl,args))
  where
    len = length args

-- | Decomposes an expression into an application of a function
unApp :: Expr -> Maybe (Fun,[Expr])
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

-- | Constructs an expression from a string literal
mkStr :: String -> Expr
mkStr str =
  unsafePerformIO $
    withCString str $ \cstr -> do
      exprPl <- gu_new_pool
      c_expr <- pgf_expr_string cstr exprPl
      exprFPl <- newForeignPtr gu_pool_finalizer exprPl
      return (Expr c_expr exprFPl)

-- | Decomposes an expression into a string literal
unStr :: Expr -> Maybe String
unStr (Expr expr master) =
  unsafePerformIO $ do
    plit <- pgf_expr_unlit expr (#const PGF_LITERAL_STR)
    if plit == nullPtr
      then return Nothing
      else do s <- peekUtf8CString (plit `plusPtr` (#offset PgfLiteralStr, val))
              return (Just s)

-- | Constructs an expression from an integer literal
mkInt :: Int -> Expr
mkInt val =
  unsafePerformIO $ do
      exprPl <- gu_new_pool
      c_expr <- pgf_expr_int (fromIntegral val) exprPl
      exprFPl <- newForeignPtr gu_pool_finalizer exprPl
      return (Expr c_expr exprFPl)

-- | Decomposes an expression into an integer literal
unInt :: Expr -> Maybe Int
unInt (Expr expr master) =
  unsafePerformIO $ do
    plit <- pgf_expr_unlit expr (#const PGF_LITERAL_INT)
    if plit == nullPtr
      then return Nothing
      else do n <- peek (plit `plusPtr` (#offset PgfLiteralInt, val))
              return (Just (fromIntegral (n :: CInt)))

-- | Constructs an expression from a real number
mkFloat :: Double -> Expr
mkFloat val =
  unsafePerformIO $ do
      exprPl <- gu_new_pool
      c_expr <- pgf_expr_float (realToFrac val) exprPl
      exprFPl <- newForeignPtr gu_pool_finalizer exprPl
      return (Expr c_expr exprFPl)

-- | Decomposes an expression into a real number literal
unFloat :: Expr -> Maybe Double
unFloat (Expr expr master) =
  unsafePerformIO $ do
    plit <- pgf_expr_unlit expr (#const PGF_LITERAL_FLT)
    if plit == nullPtr
      then return Nothing
      else do n <- peek (plit `plusPtr` (#offset PgfLiteralFlt, val))
              return (Just (realToFrac (n :: CDouble)))

-- | parses a 'String' as an expression
readExpr :: String -> Maybe Expr
readExpr str =
  unsafePerformIO $
    do exprPl <- gu_new_pool
       withGuPool $ \tmpPl ->
         withCString str $ \c_str ->
           do guin <- gu_string_in c_str tmpPl
              exn <- gu_new_exn tmpPl
              c_expr <- pgf_read_expr guin exprPl exn
              status <- gu_exn_is_raised exn
              if (not status && c_expr /= nullPtr)
                then do exprFPl <- newForeignPtr gu_pool_finalizer exprPl
                        return $ Just (Expr c_expr exprFPl)
                else do gu_pool_free exprPl
                        return Nothing

ppExpr :: Int -> [CId] -> Expr -> PP.Doc
ppExpr d xs e = ppParens (d>0) (PP.text (showExpr xs e)) -- just a quick hack !!!

-- | renders an expression as a 'String'. The list
-- of identifiers is the list of all free variables
-- in the expression in order reverse to the order
-- of binding.
showExpr :: [CId] -> Expr -> String
showExpr scope e = 
  unsafePerformIO $
    withGuPool $ \tmpPl ->
      do (sb,out) <- newOut tmpPl
         let printCtxt = nullPtr
         exn <- gu_new_exn tmpPl
         pgf_print_expr (expr e) printCtxt 1 out exn
         s <- gu_string_buf_freeze sb tmpPl
         peekCString s


-----------------------------------------------------------------------------
-- Types

data Type =
   DTyp [Hypo] CId [Expr]
  deriving Show

data BindType = 
    Explicit
  | Implicit
  deriving Show

-- | 'Hypo' represents a hypothesis in a type i.e. in the type A -> B, A is the hypothesis
type Hypo = (BindType,CId,Type)

-- | renders type as 'String'.
showType :: Type -> String
showType = PP.render . ppType 0 []

ppType :: Int -> [CId] -> Type -> PP.Doc
ppType d scope (DTyp hyps cat args)
  | null hyps = ppRes scope cat args
  | otherwise = let (scope',hdocs) = mapAccumL (ppHypo 1) scope hyps
                in ppParens (d > 0) (foldr (\hdoc doc -> hdoc PP.<+> PP.text "->" PP.<+> doc) (ppRes scope cat args) hdocs)
  where
    ppRes scope cat es
      | null es   = ppCId cat
      | otherwise = ppParens (d > 3) (ppCId cat PP.<+> PP.hsep (map (ppExpr 4 scope) es))

ppHypo :: Int -> [CId]-> (BindType,CId,Type) -> ([CId],PP.Doc)
ppHypo d scope (Explicit,x,typ) =
    if x == wildCId
    then (scope, ppType d scope typ)
    else let y = freshName x scope
         in (y:scope, PP.parens (ppCId x PP.<+> PP.char ':' PP.<+> ppType 0 scope typ))
ppHypo d scope (Implicit,x,typ) =
    if x == wildCId
    then (scope,PP.parens (PP.braces (ppCId x) PP.<+> PP.char ':' PP.<+> ppType 0 scope typ))
    else let y = freshName x scope
         in (y:scope,PP.parens (PP.braces (ppCId x) PP.<+> PP.char ':' PP.<+> ppType 0 scope typ))

freshName :: CId -> [CId] -> CId
freshName x xs0 = loop 1 x
  where
    xs = wildCId : xs0

    loop i y
      | elem y xs = loop (i+1) (x++show i)
      | otherwise = y

ppParens True  = PP.parens
ppParens False = id
