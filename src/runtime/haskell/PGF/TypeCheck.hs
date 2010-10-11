{-# LANGUAGE FlexibleContexts, RankNTypes #-}

----------------------------------------------------------------------
-- |
-- Module      : PGF.TypeCheck
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-- Type checking in abstract syntax with dependent types.
-- The type checker also performs renaming and checking for unknown
-- functions. The variable references are replaced by de Bruijn indices.
--
-----------------------------------------------------------------------------

module PGF.TypeCheck ( checkType, checkExpr, inferExpr

                     , ppTcError, TcError(..)

                     -- internals needed for the typechecking of forests
                     , MetaStore, emptyMetaStore, newMeta, newGuardedMeta, fillinVariables, getMeta, setMeta, MetaValue(..)
                     , Scope, emptyScope, scopeSize, scopeEnv, addScopedVar
                     , TcM(..), TcResult(..), TType(..), Selector(..), tcError
                     , tcExpr, infExpr, eqType, eqValue
                     , lookupFunType, eval
                     , refineExpr, checkResolvedMetaStore, lookupMeta
                     ) where

import PGF.Data
import PGF.Expr hiding (eval, apply, value2expr)
import qualified PGF.Expr as Expr
import PGF.Macros (typeOfHypo)
import PGF.CId

import Data.Map as Map
import Data.IntMap as IntMap
import Data.Maybe as Maybe
import Data.List as List
import Control.Monad
import Control.Monad.Identity
import Text.PrettyPrint
import System.Random as Random

-----------------------------------------------------
-- The Scope
-----------------------------------------------------

data    TType = TTyp Env Type
newtype Scope = Scope [(CId,TType)]

emptyScope = Scope []

addScopedVar :: CId -> TType -> Scope -> Scope
addScopedVar x tty (Scope gamma) = Scope ((x,tty):gamma)

-- | returns the type and the De Bruijn index of a local variable
lookupVar :: CId -> Scope -> Maybe (Int,TType)
lookupVar x (Scope gamma) = listToMaybe [(i,tty) | ((y,tty),i) <- zip gamma [0..], x == y]

-- | returns the type and the name of a local variable
getVar :: Int -> Scope -> (CId,TType)
getVar i (Scope gamma) = gamma !! i

scopeEnv :: Scope -> Env
scopeEnv (Scope gamma) = let n = length gamma
                         in [VGen (n-i-1) [] | i <- [0..n-1]]

scopeVars :: Scope -> [CId]
scopeVars (Scope gamma) = List.map fst gamma

scopeSize :: Scope -> Int
scopeSize (Scope gamma) = length gamma

-----------------------------------------------------
-- The Monad
-----------------------------------------------------

type MetaStore s = IntMap (MetaValue s)
data MetaValue s
  = MUnbound Scope TType [Expr -> TcM s ()]
  | MBound   Expr
  | MGuarded Expr  [Expr -> TcM s ()] {-# UNPACK #-} !Int   -- the Int is the number of constraints that have to be solved 
                                                            -- to unlock this meta variable

newtype TcM s a = TcM {unTcM :: Abstr -> s -> MetaStore s -> TcResult s a}
data TcResult s a
  = Ok s (MetaStore s) a
  | Fail TcError
  | Zero
  | Plus (TcResult s a) (TcResult s a)

instance Monad (TcM s) where
  return x = TcM (\abstr s ms -> Ok s ms x)
  f >>= g  = TcM (\abstr s ms -> iter abstr (unTcM f abstr s ms))
    where
      iter abstr (Ok s ms x)  = unTcM (g x) abstr s ms
      iter abstr (Fail e)     = Fail e
      iter abstr Zero         = Zero
      iter abstr (Plus b1 b2) = Plus (iter abstr b1) (iter abstr b2)

instance Selector s => MonadPlus (TcM s) where
  mzero = TcM (\abstr s ms -> Zero)
  mplus f g = TcM (\abstr s ms -> let (s1,s2) = splitSelector s
                                  in Plus (unTcM f abstr s1 ms) (unTcM g abstr s2 ms))

instance Functor (TcM s) where
  fmap f x = TcM (\abstr s ms -> iter (unTcM x abstr s ms))
    where
      iter (Ok s ms x)  = Ok s ms (f x)
      iter (Fail e)     = Fail e
      iter Zero         = Zero
      iter (Plus b1 b2) = Plus (iter b1) (iter b2)

lookupCatHyps :: CId -> TcM s [Hypo]
lookupCatHyps cat = TcM (\abstr s ms -> case Map.lookup cat (cats abstr) of
                                          Just (hyps,_) -> Ok s ms hyps
                                          Nothing       -> Fail (UnknownCat cat))

lookupFunType :: CId -> TcM s Type
lookupFunType fun = TcM (\abstr s ms -> case Map.lookup fun (funs abstr) of
                                          Just (ty,_,_,_) -> Ok s ms ty
                                          Nothing         -> Fail (UnknownFun fun))

emptyMetaStore :: MetaStore s
emptyMetaStore = IntMap.empty

newMeta :: Scope -> TType -> TcM s MetaId
newMeta scope tty = TcM (\abstr s ms -> let metaid = IntMap.size ms + 1
                                        in Ok s (IntMap.insert metaid (MUnbound scope tty []) ms) metaid)

newGuardedMeta :: Expr -> TcM s MetaId
newGuardedMeta e = TcM (\abstr s ms -> let metaid = IntMap.size ms + 1
                                       in Ok s (IntMap.insert metaid (MGuarded e [] 0) ms) metaid)

getMeta :: MetaId -> TcM s (MetaValue s)
getMeta i = TcM (\abstr s ms -> Ok s ms $! case IntMap.lookup i ms of
                                             Just mv  -> mv)

setMeta :: MetaId -> MetaValue s -> TcM s ()
setMeta i mv = TcM (\abstr s ms -> Ok s (IntMap.insert i mv ms) ())

lookupMeta ms i =
  case IntMap.lookup i ms of
    Just (MBound   t)                 -> Just t
    Just (MGuarded t _ x) | x == 0    -> Just t
                          | otherwise -> Nothing
    Just (MUnbound _ _ _)             -> Nothing
    Nothing                           -> Nothing

fillinVariables :: (Scope -> TType -> TcM s Expr) -> TcM s ()
fillinVariables f = do
  fvs <- TcM (\abstr s ms -> Ok s ms [(i,scope,tty,cs) | (i,MUnbound scope tty cs) <- IntMap.toList ms])
  case fvs of
    []                 -> return ()
    (i,scope,tty,cs):_ -> do e <- f scope tty
                             setMeta i (MBound e)
                             sequence_ [c e | c <- cs]
                             fillinVariables f

tcError :: TcError -> TcM s a
tcError e = TcM (\abstr s ms -> Fail e)

addConstraint :: MetaId -> MetaId -> (Expr -> TcM s ()) -> TcM s ()
addConstraint i j c = do
  mv   <- getMeta j
  case mv of
    MUnbound scope tty cs       -> addRef >> setMeta j (MUnbound scope tty ((\e -> release >> c e) : cs))
    MBound   e                  -> c e
    MGuarded e cs x | x == 0    -> c e
                    | otherwise -> addRef >> setMeta j (MGuarded e ((\e -> release >> c e) : cs) x)
  where
    addRef  = TcM (\abstr s ms -> case IntMap.lookup i ms of
                                    Just (MGuarded e cs x) -> Ok s (IntMap.insert i (MGuarded e cs (x+1)) ms) ())

    release = TcM (\abstr s ms -> case IntMap.lookup i ms of
                                    Just (MGuarded e cs x) -> if x == 1
                                                                then unTcM (sequence_ [c e | c <- cs]) abstr s (IntMap.insert i (MGuarded e [] 0) ms)
                                                                else Ok s (IntMap.insert i (MGuarded e cs (x-1)) ms) ())

-----------------------------------------------------
-- Type errors
-----------------------------------------------------

-- | If an error occurs in the typechecking phase
-- the type checker returns not a plain text error message
-- but a 'TcError' structure which describes the error.
data TcError
  = UnknownCat      CId                            -- ^ Unknown category name was found.
  | UnknownFun      CId                            -- ^ Unknown function name was found.
  | WrongCatArgs    [CId] Type CId  Int Int        -- ^ A category was applied to wrong number of arguments.
                                                   -- The first integer is the number of expected arguments and
                                                   -- the second the number of given arguments.
                                                   -- The @[CId]@ argument is the list of free variables
                                                   -- in the type. It should be used for the 'showType' function.
  | TypeMismatch    [CId] Expr Type Type           -- ^ The expression is not of the expected type.
                                                   -- The first type is the expected type, while
                                                   -- the second is the inferred. The @[CId]@ argument is the list
                                                   -- of free variables in both the expression and the type. 
                                                   -- It should be used for the 'showType' and 'showExpr' functions.
  | NotFunType      [CId] Expr Type                -- ^ Something that is not of function type was applied to an argument.
  | CannotInferType [CId] Expr                     -- ^ It is not possible to infer the type of an expression.
  | UnresolvedMetaVars [CId] Expr [MetaId]         -- ^ Some metavariables have to be instantiated in order to complete the typechecking.
  | UnexpectedImplArg [CId] Expr                   -- ^ Implicit argument was passed where the type doesn't allow it
  | UnsolvableGoal [CId] MetaId Type               -- ^ There is a goal that cannot be solved
  deriving Eq

-- | Renders the type checking error to a document. See 'Text.PrettyPrint'.
ppTcError :: TcError -> Doc
ppTcError (UnknownCat cat)             = text "Category" <+> ppCId cat <+> text "is not in scope"
ppTcError (UnknownFun fun)             = text "Function" <+> ppCId fun <+> text "is not in scope"
ppTcError (WrongCatArgs xs ty cat m n) = text "Category" <+> ppCId cat <+> text "should have" <+> int m <+> text "argument(s), but has been given" <+> int n $$
                                         text "In the type:" <+> ppType 0 xs ty
ppTcError (TypeMismatch xs e ty1 ty2)  = text "Couldn't match expected type" <+> ppType 0 xs ty1 $$
                                         text "       against inferred type" <+> ppType 0 xs ty2 $$
                                         text "In the expression:" <+> ppExpr 0 xs e
ppTcError (NotFunType xs e ty)         = text "A function type is expected for the expression" <+> ppExpr 0 xs e <+> text "instead of type" <+> ppType 0 xs ty
ppTcError (CannotInferType xs e)       = text "Cannot infer the type of expression" <+> ppExpr 0 xs e
ppTcError (UnresolvedMetaVars xs e ms) = text "Meta variable(s)" <+> fsep (List.map ppMeta ms) <+> text "should be resolved" $$
                                         text "in the expression:" <+> ppExpr 0 xs e
ppTcError (UnexpectedImplArg xs e)     = braces (ppExpr 0 xs e) <+> text "is implicit argument but not implicit argument is expected here"
ppTcError (UnsolvableGoal xs metaid ty)= text "The goal:" <+> ppMeta metaid <+> colon <+> ppType 0 xs ty $$
                                         text "cannot be solved"

------------------------------------------------------------------------------
-- Selectors

class Selector s where
  splitSelector :: s -> (s,s)
  select        :: CId -> TcM s CId

instance Selector () where
  splitSelector s = (s,s)
  select cat = TcM (\abstr s ms -> case Map.lookup cat (cats abstr) of
                                     Just (_,fns) -> iter ms fns
                                     Nothing      -> Fail (UnknownCat cat))
    where
      iter ms []           = Zero
      iter ms ((_,fn):fns) = Plus (Ok () ms fn) (iter ms fns)

instance RandomGen g => Selector (Identity g) where
  splitSelector (Identity g) = let (g1,g2) = Random.split g
                               in (Identity g1, Identity g2)

  select cat = TcM (\abstr (Identity g) ms ->
                               case Map.lookup cat (cats abstr) of
                                 Just (_,fns) -> do_rand g ms 1.0 fns
                                 Nothing      -> Fail (UnknownCat cat))
    where
      do_rand g ms p []  = Zero
      do_rand g ms p fns = let (d,g')    = randomR (0.0,p) g
                               (g1,g2)   = Random.split g'
                               (p',fn,fns') = hit d fns
                           in Plus (Ok (Identity g1) ms fn) (do_rand g2 ms (p-p') fns')

      hit :: Double -> [(Double,a)] -> (Double,a,[(Double,a)])
      hit d (px@(p,x):xs)
        | d < p     = (p,x,xs)
        | otherwise = let (p',x',xs') = hit (d-p) xs
                      in (p,x',px:xs')

-----------------------------------------------------
-- checkType
-----------------------------------------------------

-- | Check whether a given type is consistent with the abstract
-- syntax of the grammar.
checkType :: PGF -> Type -> Either TcError Type
checkType pgf ty = 
  case unTcM (tcType emptyScope ty >>= refineType) (abstract pgf) () emptyMetaStore of
    Ok s ms ty -> Right ty
    Fail err   -> Left  err

tcType :: Scope -> Type -> TcM s Type
tcType scope ty@(DTyp hyps cat es) = do
  (scope,hyps) <- tcHypos scope hyps
  c_hyps <- lookupCatHyps cat
  let m = length es
      n = length [ty | (Explicit,x,ty) <- c_hyps]
  (delta,es) <- tcCatArgs scope es [] c_hyps ty n m
  return (DTyp hyps cat es)

tcHypos :: Scope -> [Hypo] -> TcM s (Scope,[Hypo])
tcHypos scope []     = return (scope,[])
tcHypos scope (h:hs) = do
  (scope,h ) <- tcHypo  scope h
  (scope,hs) <- tcHypos scope hs
  return (scope,h:hs)

tcHypo :: Scope -> Hypo -> TcM s (Scope,Hypo)
tcHypo scope (b,x,ty) = do
  ty <- tcType scope ty
  if x == wildCId
    then return (scope,(b,x,ty))
    else return (addScopedVar x (TTyp (scopeEnv scope) ty) scope,(b,x,ty))

tcCatArgs scope []              delta []                   ty0 n m = return (delta,[])
tcCatArgs scope (EImplArg e:es) delta ((Explicit,x,ty):hs) ty0 n m = tcError (UnexpectedImplArg (scopeVars scope) e)
tcCatArgs scope (EImplArg e:es) delta ((Implicit,x,ty):hs) ty0 n m = do
  e <- tcExpr scope e (TTyp delta ty)
  (delta,es) <- if x == wildCId
                  then tcCatArgs scope es delta  hs ty0 n m
                  else do v <- eval (scopeEnv scope) e
                          tcCatArgs scope es (v:delta) hs ty0 n m
  return (delta,EImplArg e:es)
tcCatArgs scope es delta ((Implicit,x,ty):hs) ty0 n m = do
  i <- newMeta scope (TTyp delta ty)
  (delta,es) <- if x == wildCId
                  then tcCatArgs scope es                                delta  hs ty0 n m
                  else tcCatArgs scope es (VMeta i (scopeEnv scope) [] : delta) hs ty0 n m
  return (delta,EImplArg (EMeta i) : es)
tcCatArgs scope (e:es) delta ((Explicit,x,ty):hs) ty0 n m = do
  e <- tcExpr scope e (TTyp delta ty)
  (delta,es) <- if x == wildCId
                  then tcCatArgs scope es                               delta  hs ty0 n m
                  else do v <- eval (scopeEnv scope) e
                          tcCatArgs scope es (v:delta) hs ty0 n m
  return (delta,e:es)
tcCatArgs scope _ delta _ ty0@(DTyp _ cat _) n m = do
  tcError (WrongCatArgs (scopeVars scope) ty0 cat n m)

-----------------------------------------------------
-- checkExpr
-----------------------------------------------------

-- | Checks an expression against a specified type.
checkExpr :: PGF -> Expr -> Type -> Either TcError Expr
checkExpr pgf e ty =
  case unTcM (do e <- tcExpr emptyScope e (TTyp [] ty)
                 e <- refineExpr e
                 checkResolvedMetaStore emptyScope e
                 return e) (abstract pgf) () emptyMetaStore of
    Ok _ ms e -> Right e
    Fail err  -> Left err

tcExpr :: Scope -> Expr -> TType -> TcM s Expr
tcExpr scope e0@(EAbs Implicit x e) tty =
  case tty of
    TTyp delta (DTyp ((Implicit,y,ty):hs) c es) -> do e <- if y == wildCId
                                                             then tcExpr (addScopedVar x (TTyp delta ty) scope)
                                                                         e (TTyp delta (DTyp hs c es))
                                                             else tcExpr (addScopedVar x (TTyp delta ty) scope)
                                                                         e (TTyp ((VGen (scopeSize scope) []):delta) (DTyp hs c es))
                                                      return (EAbs Implicit x e)
    _                                           -> do ty <- evalType (scopeSize scope) tty
                                                      tcError (NotFunType (scopeVars scope) e0 ty)
tcExpr scope e0 (TTyp delta (DTyp ((Implicit,y,ty):hs) c es)) = do
  e0 <- if y == wildCId
          then tcExpr (addScopedVar wildCId (TTyp delta ty) scope)
                      e0 (TTyp delta (DTyp hs c es))
          else tcExpr (addScopedVar wildCId (TTyp delta ty) scope)
                      e0 (TTyp ((VGen (scopeSize scope) []):delta) (DTyp hs c es))
  return (EAbs Implicit wildCId e0)
tcExpr scope e0@(EAbs Explicit x e) tty =
  case tty of
    TTyp delta (DTyp ((Explicit,y,ty):hs) c es) -> do e <- if y == wildCId
                                                             then tcExpr (addScopedVar x (TTyp delta ty) scope)
                                                                         e (TTyp delta (DTyp hs c es))
                                                             else tcExpr (addScopedVar x (TTyp delta ty) scope)
                                                                         e (TTyp ((VGen (scopeSize scope) []):delta) (DTyp hs c es))
                                                      return (EAbs Explicit x e)
    _                                           -> do ty <- evalType (scopeSize scope) tty
                                                      tcError (NotFunType (scopeVars scope) e0 ty)
tcExpr scope (EMeta _) tty = do
  i <- newMeta scope tty
  return (EMeta i)
tcExpr scope e0        tty = do
  (e0,tty0) <- infExpr scope e0
  i <- newGuardedMeta e0
  eqType scope (scopeSize scope) i tty tty0
  return (EMeta i)


-----------------------------------------------------
-- inferExpr
-----------------------------------------------------

-- | Tries to infer the type of a given expression. Note that
-- even if the expression is type correct it is not always
-- possible to infer its type in the GF type system.
-- In this case the function returns the 'CannotInferType' error.
inferExpr :: PGF -> Expr -> Either TcError (Expr,Type)
inferExpr pgf e =
  case unTcM (do (e,tty) <- infExpr emptyScope e
                 e <- refineExpr e
                 checkResolvedMetaStore emptyScope e
                 ty <- evalType 0 tty
                 return (e,ty)) (abstract pgf) () emptyMetaStore of
    Ok _ ms (e,ty) -> Right (e,ty)
    Fail err       -> Left err

infExpr :: Scope -> Expr -> TcM s (Expr,TType)
infExpr scope e0@(EApp e1 e2) = do
  (e1,TTyp delta ty) <- infExpr scope e1
  (e0,delta,ty) <- tcArg scope e1 e2 delta ty
  return (e0,TTyp delta ty)
infExpr scope e0@(EFun x) = do
  case lookupVar x scope of
    Just (i,tty) -> return (EVar i,tty)
    Nothing      -> do ty <- lookupFunType x
                       return (e0,TTyp [] ty)
infExpr scope e0@(EVar i) = do
  return (e0,snd (getVar i scope))
infExpr scope e0@(ELit l) = do
  let cat = case l of
              LStr _ -> mkCId "String"
              LInt _ -> mkCId "Int"
              LFlt _ -> mkCId "Float"
  return (e0,TTyp [] (DTyp [] cat []))
infExpr scope (ETyped e ty) = do
  ty <- tcType scope ty
  e  <- tcExpr scope e (TTyp (scopeEnv scope) ty)
  return (ETyped e ty,TTyp (scopeEnv scope) ty)
infExpr scope (EImplArg e) = do
  (e,tty)  <- infExpr scope e
  return (EImplArg e,tty)
infExpr scope e = tcError (CannotInferType (scopeVars scope) e)

tcArg scope e1 e2 delta ty0@(DTyp [] c es) = do
  ty1 <- evalType (scopeSize scope) (TTyp delta ty0)
  tcError (NotFunType (scopeVars scope) e1 ty1)
tcArg scope e1 (EImplArg e2) delta ty0@(DTyp ((Explicit,x,ty):hs) c es) = tcError (UnexpectedImplArg (scopeVars scope) e2)
tcArg scope e1 (EImplArg e2) delta ty0@(DTyp ((Implicit,x,ty):hs) c es) = do
  e2 <- tcExpr scope e2 (TTyp delta ty)
  if x == wildCId
    then return (EApp e1 (EImplArg e2),                              delta,DTyp hs c es)
    else do v2 <- eval (scopeEnv scope) e2
            return (EApp e1 (EImplArg e2),v2:delta,DTyp hs c es)
tcArg scope e1 e2 delta ty0@(DTyp ((Explicit,x,ty):hs) c es) = do
  e2 <- tcExpr scope e2 (TTyp delta ty)
  if x == wildCId
    then return (EApp e1 e2,delta,DTyp hs c es)
    else do v2 <- eval (scopeEnv scope) e2
            return (EApp e1 e2,v2:delta,DTyp hs c es)
tcArg scope e1 e2 delta ty0@(DTyp ((Implicit,x,ty):hs) c es) = do
  i <- newMeta scope (TTyp delta ty)
  if x == wildCId
    then tcArg scope (EApp e1 (EImplArg (EMeta i))) e2                                delta  (DTyp hs c es)
    else tcArg scope (EApp e1 (EImplArg (EMeta i))) e2 (VMeta i (scopeEnv scope) [] : delta) (DTyp hs c es)

-----------------------------------------------------
-- eqType
-----------------------------------------------------

eqType :: Scope -> Int -> MetaId -> TType -> TType -> TcM s ()
eqType scope k i0 tty1@(TTyp delta1 ty1@(DTyp hyps1 cat1 es1)) tty2@(TTyp delta2 ty2@(DTyp hyps2 cat2 es2))
  | cat1 == cat2 = do (k,delta1,delta2) <- eqHyps k delta1 hyps1 delta2 hyps2
                      sequence_ [eqExpr raiseTypeMatchError (addConstraint i0) k delta1 e1 delta2 e2 | (e1,e2) <- zip es1 es2]
  | otherwise    = raiseTypeMatchError
  where
    raiseTypeMatchError = do ty1 <- evalType k tty1
                             ty2 <- evalType k tty2
                             e   <- refineExpr (EMeta i0)
                             tcError (TypeMismatch (scopeVars scope) e ty1 ty2)

    eqHyps :: Int -> Env -> [Hypo] -> Env -> [Hypo] -> TcM s (Int,Env,Env)
    eqHyps k delta1 []                 delta2 []                 =
      return (k,delta1,delta2)
    eqHyps k delta1 ((_,x,ty1) : h1s) delta2 ((_,y,ty2) : h2s) = do
      eqType scope k i0 (TTyp delta1 ty1) (TTyp delta2 ty2)
      if x == wildCId && y == wildCId
        then eqHyps k delta1 h1s delta2 h2s
        else if x /= wildCId && y /= wildCId
               then eqHyps (k+1) ((VGen k []):delta1) h1s ((VGen k []):delta2) h2s
               else raiseTypeMatchError
    eqHyps k delta1               h1s  delta2               h2s  = raiseTypeMatchError

eqExpr :: (forall a . TcM s a) -> (MetaId -> (Expr -> TcM s ()) -> TcM s ()) -> Int -> Env -> Expr -> Env -> Expr -> TcM s ()
eqExpr fail suspend k env1 e1 env2 e2 = do
  v1 <- eval env1 e1
  v2 <- eval env2 e2
  eqValue fail suspend k v1 v2

eqValue :: (forall a . TcM s a) -> (MetaId -> (Expr -> TcM s ()) -> TcM s ()) -> Int -> Value -> Value -> TcM s ()
eqValue fail suspend k v1 v2 = do
  v1 <- deRef v1
  v2 <- deRef v2
  eqValue' k v1 v2
  where
    deRef v@(VMeta i env vs) = do
      mv   <- getMeta i
      case mv of
        MBound   e                 -> apply env e vs
        MGuarded e _ x | x == 0    -> apply env e vs
                       | otherwise -> return v
        MUnbound _ _ _             -> return v
    deRef v = return v

    eqValue' k (VSusp i env vs1 c)            v2                             = suspend i (\e -> apply env e vs1 >>= \v1 -> eqValue fail suspend k (c v1) v2)
    eqValue' k v1                             (VSusp i env vs2 c)            = suspend i (\e -> apply env e vs2 >>= \v2 -> eqValue fail suspend k v1 (c v2))
    eqValue' k (VMeta i env1 vs1)             (VMeta j env2 vs2) | i  == j   = zipWithM_ (eqValue fail suspend k) vs1 vs2
    eqValue' k (VMeta i env1 vs1)             v2                             = do mv <- getMeta i
                                                                                  case mv of
                                                                                    MUnbound scopei _ cs -> do e2 <- mkLam i scopei env1 vs1 v2
                                                                                                               setMeta i (MBound e2)
                                                                                                               sequence_ [c e2 | c <- cs]
                                                                                    MGuarded e cs x      -> setMeta i (MGuarded e ((\e -> apply env1 e vs1 >>= \v1 -> eqValue' k v1 v2) : cs) x)
    eqValue' k v1                             (VMeta i env2 vs2)             = do mv <- getMeta i
                                                                                  case mv of
                                                                                    MUnbound scopei _ cs -> do e1 <- mkLam i scopei env2 vs2 v1
                                                                                                               setMeta i (MBound e1)
                                                                                                               sequence_ [c e1 | c <- cs]
                                                                                    MGuarded e cs x      -> setMeta i (MGuarded e ((\e -> apply env2 e vs2 >>= \v2 -> eqValue' k v1 v2) : cs) x)
    eqValue' k (VApp f1 vs1)                  (VApp f2 vs2)   | f1 == f2     = zipWithM_ (eqValue fail suspend k) vs1 vs2
    eqValue' k (VConst f1 vs1)                (VConst f2 vs2) | f1 == f2     = zipWithM_ (eqValue fail suspend k) vs1 vs2
    eqValue' k (VLit l1)                      (VLit l2    )   | l1 == l2     = return ()
    eqValue' k (VGen  i vs1)                  (VGen  j vs2)   | i  == j      = zipWithM_ (eqValue fail suspend k) vs1 vs2
    eqValue' k (VClosure env1 (EAbs _ x1 e1)) (VClosure env2 (EAbs _ x2 e2)) = let v = VGen k []
                                                                               in eqExpr fail suspend (k+1) (v:env1) e1 (v:env2) e2
    eqValue' k v1                             v2                             = fail

    mkLam i scope env vs0 v = do
      let k  = scopeSize scope
          vs  = reverse (take k env) ++ vs0
          xs  = nub [i | VGen i [] <- vs]
      if length vs == length xs
        then return ()
        else fail
      v <- occurCheck i k xs v
      e <- value2expr (length xs) v
      return (addLam vs0 e)
      where
        addLam []     e = e
        addLam (v:vs) e = EAbs Explicit var (addLam vs e)

        var = mkCId "v"

    occurCheck i0 k xs (VApp f vs)      = do vs <- mapM (occurCheck i0 k xs) vs
                                             return (VApp f vs)
    occurCheck i0 k xs (VLit l)         = return (VLit l)
    occurCheck i0 k xs (VMeta i env vs) = do if i == i0
                                               then fail
                                               else return ()
                                             mv <- getMeta i
                                             case mv of
                                               MBound   e                                 -> apply env e vs >>= occurCheck i0 k xs
                                               MGuarded e _ _                             -> apply env e vs >>= occurCheck i0 k xs
                                               MUnbound scopei _ _ | scopeSize scopei > k -> fail
                                                                   | otherwise            -> do vs <- mapM (occurCheck i0 k xs) vs
                                                                                                return (VMeta i env vs)
    occurCheck i0 k xs (VSusp i env vs cnt) = do suspend i (\e -> apply env e vs >>= \v -> occurCheck i0 k xs (cnt v) >> return ())
                                                 return (VSusp i env vs cnt)
    occurCheck i0 k xs (VGen  i vs)     = case List.findIndex (==i) xs of
                                            Just i  -> do vs <- mapM (occurCheck i0 k xs) vs
                                                          return (VGen i vs)
                                            Nothing -> fail
    occurCheck i0 k xs (VConst f vs)    = do vs <- mapM (occurCheck i0 k xs) vs
                                             return (VConst f vs)
    occurCheck i0 k xs (VClosure env e) = do env <- mapM (occurCheck i0 k xs) env
                                             return (VClosure env e)


-----------------------------------------------------------
-- check for meta variables that still have to be resolved
-----------------------------------------------------------

checkResolvedMetaStore :: Scope -> Expr -> TcM s ()
checkResolvedMetaStore scope e = TcM (\abstr s ms -> 
  let xs = [i | (i,mv) <- IntMap.toList ms, not (isResolved mv)]
  in if List.null xs
       then Ok s ms ()
       else Fail (UnresolvedMetaVars (scopeVars scope) e xs))
  where
    isResolved (MUnbound _ _ []) = True
    isResolved (MGuarded  _ _ _) = True
    isResolved (MBound    _)     = True
    isResolved _                 = False

-----------------------------------------------------
-- evalType
-----------------------------------------------------

evalType :: Int -> TType -> TcM s Type
evalType k (TTyp delta ty) = evalTy funs k delta ty
  where
    evalTy sig k delta (DTyp hyps cat es) = do
      (k,delta,hyps) <- evalHypos sig k delta hyps
      es <- mapM (\e -> eval delta e >>= value2expr k) es
      return (DTyp hyps cat es)

    evalHypos sig k delta []              = return (k,delta,[])
    evalHypos sig k delta ((b,x,ty):hyps) = do
      ty <- evalTy sig k delta ty
      (k,delta,hyps) <- if x == wildCId
                          then evalHypos sig k                  delta  hyps
                          else evalHypos sig (k+1) ((VGen k []):delta) hyps
      return (k,delta,(b,x,ty) : hyps)


-----------------------------------------------------
-- refinement
-----------------------------------------------------

refineExpr :: Expr -> TcM s Expr
refineExpr e = TcM (\abstr s ms -> Ok s ms (refineExpr_ ms e))

refineExpr_ ms e = refine e
  where
    refine (EAbs b x e)  = EAbs b x (refine e)
    refine (EApp e1 e2)  = EApp (refine e1) (refine e2)
    refine (ELit l)      = ELit l
    refine (EMeta i)     = case IntMap.lookup i ms of
                             Just (MBound   e    ) -> refine e
                             Just (MGuarded e _ _) -> refine e
                             _                     -> EMeta i
    refine (EFun f)      = EFun f
    refine (EVar i)      = EVar i
    refine (ETyped e ty) = ETyped (refine e) (refineType_ ms ty)
    refine (EImplArg e)  = EImplArg (refine e)

refineType :: Type -> TcM s Type
refineType ty = TcM (\abstr s ms -> Ok s ms (refineType_ ms ty))

refineType_ ms (DTyp hyps cat es) = DTyp [(b,x,refineType_ ms ty) | (b,x,ty) <- hyps] cat (List.map (refineExpr_ ms) es)

eval :: Env -> Expr -> TcM s Value
eval env e = TcM (\abstr s ms -> Ok s ms (Expr.eval (funs abstr,lookupMeta ms) env e))

apply :: Env -> Expr -> [Value] -> TcM s Value
apply env e vs = TcM (\abstr s ms -> Ok s ms (Expr.apply (funs abstr,lookupMeta ms) env e vs))

value2expr :: Int -> Value -> TcM s Expr
value2expr i v = TcM (\abstr s ms -> Ok s ms (Expr.value2expr (funs abstr,lookupMeta ms) i v))
