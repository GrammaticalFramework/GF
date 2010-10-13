module PGF.Generate 
         ( generateAll,         generateAllDepth
         , generateFrom,        generateFromDepth
         , generateRandom,      generateRandomDepth
         , generateRandomFrom,  generateRandomFromDepth
         ) where

import PGF.CId
import PGF.Data
import PGF.Expr
import PGF.Macros
import PGF.TypeCheck
import PGF.Probabilistic

import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import Control.Monad
import Control.Monad.Identity
import System.Random

-- | Generates an exhaustive possibly infinite list of
-- abstract syntax expressions.
generateAll :: PGF -> Type -> [Expr]
generateAll pgf ty = generateAllDepth pgf ty Nothing

-- | A variant of 'generateAll' which also takes as argument
-- the upper limit of the depth of the generated expression.
generateAllDepth :: PGF -> Type -> Maybe Int -> [Expr]
generateAllDepth pgf ty dp = generate () pgf ty dp

-- | Generates a list of abstract syntax expressions
-- in a way similar to 'generateAll' but instead of
-- generating all instances of a given type, this
-- function uses a template. 
generateFrom :: PGF -> Expr -> [Expr]
generateFrom pgf ex = generateFromDepth pgf ex Nothing

-- | A variant of 'generateFrom' which also takes as argument
-- the upper limit of the depth of the generated subexpressions.
generateFromDepth :: PGF -> Expr -> Maybe Int -> [Expr]
generateFromDepth pgf e dp = generateForMetas () pgf e dp

-- | Generates an infinite list of random abstract syntax expressions.
-- This is usefull for tree bank generation which after that can be used
-- for grammar testing.
generateRandom :: RandomGen g => g -> PGF -> Type -> [Expr]
generateRandom g pgf ty = generateRandomDepth g pgf ty Nothing

-- | A variant of 'generateRandom' which also takes as argument
-- the upper limit of the depth of the generated expression.
generateRandomDepth :: RandomGen g => g -> PGF -> Type -> Maybe Int -> [Expr]
generateRandomDepth g pgf ty dp = restart g (\g -> generate (Identity g) pgf ty dp)

-- | Random generation based on template
generateRandomFrom :: RandomGen g => g -> PGF -> Expr -> [Expr]
generateRandomFrom g pgf e = generateRandomFromDepth g pgf e Nothing

-- | Random generation based on template with a limitation in the depth.
generateRandomFromDepth :: RandomGen g => g -> PGF -> Expr -> Maybe Int -> [Expr]
generateRandomFromDepth g pgf e dp = 
  restart g (\g -> generateForMetas (Identity g) pgf e dp)


------------------------------------------------------------------------------
-- The main generation algorithm

generate :: Selector sel => sel -> PGF -> Type -> Maybe Int -> [Expr]
generate sel pgf ty dp =
  [value2expr (funs (abstract pgf),lookupMeta ms) 0 v |
        (ms,v) <- runGenM (abstract pgf) (prove emptyScope (TTyp [] ty) dp) sel emptyMetaStore]

generateForMetas :: Selector sel => sel -> PGF -> Expr -> Maybe Int -> [Expr]
generateForMetas sel pgf e dp =
  case unTcM (infExpr emptyScope e) abs sel emptyMetaStore of
    Ok sel ms (e,_) -> let gen = do fillinVariables $ \scope tty -> do 
                                      v <- prove scope tty dp
                                      return (value2expr (funs abs,lookupMeta ms) 0 v)
                                    refineExpr e
                       in [e | (ms,e) <- runGenM abs gen sel ms]
    Fail _          -> []
  where
    abs = abstract pgf

prove :: Selector sel => Scope -> TType -> Maybe Int -> TcM sel Value
prove scope (TTyp env1 (DTyp [] cat es1)) dp = do
  (fn,DTyp hypos _ es2) <- clauses cat
  case dp of
    Just 0 | not (null hypos) -> mzero
    _                         -> return ()
  (env2,args) <- mkEnv [] hypos
  vs1 <- mapM (PGF.TypeCheck.eval env1) es1
  vs2 <- mapM (PGF.TypeCheck.eval env2) es2
  sequence_ [eqValue mzero suspend (scopeSize scope) v1 v2 | (v1,v2) <- zip vs1 vs2]
  vs <- mapM descend args
  return (VApp fn vs)
  where
    suspend i c = do
      mv <- getMeta i
      case mv of
        MBound e -> c e
        MUnbound scope tty cs -> do v <- prove scope tty dp
                                    e <- TcM (\abs sel ms -> Ok sel ms (value2expr (funs abs,lookupMeta ms) 0 v))
                                    setMeta i (MBound e)
                                    sequence_ [c e | c <- (c:cs)]

    clauses cat = do
      fn <- select cat
      if fn == mkCId "plus" then mzero else return ()
      ty <- lookupFunType fn
      return (fn,ty)

    mkEnv env []                = return (env,[])
    mkEnv env ((bt,x,ty):hypos) = do
      (env,arg) <- if x /= wildCId
                    then do i <- newMeta scope (TTyp env ty)
                            let v = VMeta i env []
                            return (v : env,Right v)
                    else return (env,Left (TTyp env ty))
      (env,args) <- mkEnv env hypos
      return (env,(bt,arg):args)

    descend (bt,arg) = do let dp' = fmap (flip (-) 1) dp
                          v <- case arg of
                                 Right v  -> return v
                                 Left tty -> prove scope tty dp'
                          v <- case bt of
                                 Implicit -> return (VImplArg v)
                                 Explicit -> return v
                          return v


------------------------------------------------------------------------------
-- Generation Monad


runGenM :: Abstr -> TcM s a -> s -> MetaStore s -> [(MetaStore s,a)]
runGenM abs f s ms = toList (unTcM f abs s ms) []
  where
    toList (Ok s ms x)  xs = (ms,x) : xs
    toList (Fail _)     xs = xs
    toList (Zero)       xs = xs
    toList (Plus b1 b2) xs = toList b1 (toList b2 xs)


-- Helper function for random generation. After every
-- success we must restart the search to find sufficiently different solution.
restart :: RandomGen g => g -> (g -> [a]) -> [a]
restart g f =
  let (g1,g2) = split g
  in case f g1 of
       []     -> []
       (x:xs) -> x : restart g2 f
