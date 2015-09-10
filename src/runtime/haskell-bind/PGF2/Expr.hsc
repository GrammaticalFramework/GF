{-# LANGUAGE ExistentialQuantification #-}
#include <pgf/pgf.h>

module PGF2.Expr where

import System.IO.Unsafe(unsafePerformIO)
import Foreign hiding (unsafePerformIO)
import Foreign.C
import qualified Text.PrettyPrint as PP
import PGF2.FFI

type CId = String

ppCId = PP.text
wildCId = "_" :: CId

type Cat = String -- ^ Name of syntactic category
type Fun = String -- ^ Name of function

-----------------------------------------------------------------------------
-- Expressions

-- The C structure for the expression may point to other structures
-- which are allocated from other pools. In order to ensure that
-- they are not released prematurely we use the exprMaster to
-- store references to other Haskell objects

data Expr = forall a . Expr {expr :: PgfExpr, exprMaster :: a}

instance Show Expr where
  show = showExpr

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

mkStr :: String -> Expr
mkStr str =
  unsafePerformIO $
    withCString str $ \cstr -> do
      exprPl <- gu_new_pool
      c_expr <- pgf_expr_string cstr exprPl
      exprFPl <- newForeignPtr gu_pool_finalizer exprPl
      return (Expr c_expr exprFPl)

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

ppExpr :: Int -> Expr -> PP.Doc
ppExpr d e = ppParens (d>0) (PP.text (showExpr e)) -- just a quick hack !!!

showExpr :: Expr -> String
showExpr e = 
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
showType = PP.render . ppType 0

ppType :: Int -> Type -> PP.Doc
ppType d (DTyp hyps cat args)
  | null hyps = ppRes cat args
  | otherwise = let hdocs = map (ppHypo 1) hyps
                in ppParens (d > 0) (foldr (\hdoc doc -> hdoc PP.<+> PP.text "->" PP.<+> doc) (ppRes cat args) hdocs)
  where
    ppRes cat es
      | null es   = ppCId cat
      | otherwise = ppParens (d > 3) (ppCId cat PP.<+> PP.hsep (map (ppExpr 4) es))

ppHypo :: Int -> (BindType,CId,Type) -> PP.Doc
ppHypo d (Explicit,x,typ) =
    if x == wildCId
    then ppType d typ
    else PP.parens (ppCId x PP.<+> PP.char ':' PP.<+> ppType 0 typ)
ppHypo d (Implicit,x,typ) =
    PP.parens (PP.braces (ppCId x) PP.<+> PP.char ':' PP.<+> ppType 0 typ)

ppParens True  = PP.parens
ppParens False = id
