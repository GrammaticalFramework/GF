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
generateFromDepth pgf e dp = generateForMetas False pgf (\ty -> generateAllDepth pgf ty dp) e

-- | Generates an infinite list of random abstract syntax expressions.
-- This is usefull for tree bank generation which after that can be used
-- for grammar testing.
generateRandom :: RandomGen g => g -> PGF -> Type -> [Expr]
generateRandom g pgf ty = 
    generate (Identity g) pgf ty Nothing

-- | A variant of 'generateRandom' which also takes as argument
-- the upper limit of the depth of the generated expression.
generateRandomDepth :: RandomGen g => g -> PGF -> Type -> Maybe Int -> [Expr]
generateRandomDepth g pgf ty dp = generate (Identity g) pgf ty dp

-- | Random generation based on template
generateRandomFrom :: RandomGen g => g -> PGF -> Expr -> [Expr]
generateRandomFrom g pgf e = 
  generateForMetas True pgf (\ty -> generate (Identity g) pgf ty Nothing) e

-- | Random generation based on template with a limitation in the depth.
generateRandomFromDepth :: RandomGen g => g -> PGF -> Expr -> Maybe Int -> [Expr]
generateRandomFromDepth g pgf e dp = 
  generateForMetas True pgf (\ty -> generate (Identity g) pgf ty dp) e



-- generic algorithm for filling holes in a generator
-- for random, should be breadth-first, since otherwise first metas always get the same
-- value when a list is generated
generateForMetas :: Bool -> PGF -> (Type -> [Expr]) -> Expr -> [Expr]
generateForMetas breadth pgf gen exp = case exp of
  EApp f (EMeta _) -> [EApp g a | g <- gener f, a <- genArg g]
  EApp f x | breadth -> [EApp g a | (g,a) <- zip (gener f) (gener x)]
  EApp f x           -> [EApp g a | g <- gener f, a <- gener x]
  _ -> if breadth then repeat exp else [exp]
 where
  gener    = generateForMetas breadth pgf gen
  genArg f = case inferExpr pgf f of
    Right (_,DTyp ((_,_,ty):_) _ _) -> gen ty
    _ -> []


------------------------------------------------------------------------------
-- The main generation algorithm

generate :: Selector sel => sel -> PGF -> Type -> Maybe Int -> [Expr]
generate sel pgf ty dp =
  [value2expr (funs (abstract pgf),lookupMeta ms) 0 v |
        (ms,v) <- runGenM (prove (abstract pgf) emptyScope (TTyp [] ty) dp) sel IntMap.empty]

prove :: Selector sel => Abstr -> Scope -> TType -> Maybe Int -> GenM sel MetaStore Value
prove abs scope tty@(TTyp env (DTyp [] cat es)) dp = do
  (fn,DTyp hypos cat es) <- clauses cat
  case dp of
    Just 0 | not (null hypos) -> mzero
    _                         -> return ()
  (env,args) <- mkEnv [] hypos
  runTcM abs (eqType scope (scopeSize scope) 0 (TTyp env (DTyp [] cat es)) tty)
  vs <- mapM descend args
  return (VApp fn vs)
  where
    clauses cat =
      do fn <- select abs cat
         case Map.lookup fn (funs abs) of
           Just (ty,_,_,_) -> return (fn,ty)
           Nothing         -> mzero

    mkEnv env []                = return (env,[])
    mkEnv env ((bt,x,ty):hypos) = do
      (env,arg) <- if x /= wildCId
                    then do i <- runTcM abs (newMeta scope (TTyp env ty))
                            let v = VMeta i env []
                            return (v : env,Right v)
                    else return (env,Left (TTyp env ty))
      (env,args) <- mkEnv env hypos
      return (env,(bt,arg):args)

    descend (bt,arg) = do let dp' = fmap (flip (-) 1) dp
                          v <- case arg of
                                 Right v  -> return v
                                 Left tty -> prove abs scope tty dp'
                          v <- case bt of
                                 Implicit -> return (VImplArg v)
                                 Explicit -> return v
                          return v


------------------------------------------------------------------------------
-- Generation Monad

newtype GenM sel s a = GenM {unGen :: sel -> s -> Choice sel s a}
data Choice sel s a = COk sel s a
                    | CFail
                    | CBranch (Choice sel s a) (Choice sel s a)

instance Monad (GenM sel s) where
  return x = GenM (\sel s -> COk sel s x)
  f >>= g  = GenM (\sel s -> iter (unGen f sel s))
    where
      iter (COk sel s x)   = unGen (g x) sel s
      iter (CBranch b1 b2) = CBranch (iter b1) (iter b2)
      iter CFail           = CFail
  fail _   = GenM (\sel s -> CFail)

instance Selector sel => MonadPlus (GenM sel s) where
  mzero = GenM (\sel s -> CFail)
  mplus f g = GenM (\sel s -> let (sel1,sel2) = splitSelector sel
                              in CBranch (unGen f sel1 s) (unGen g sel2 s))

runGenM :: GenM sel s a -> sel -> s -> [(s,a)]
runGenM f sel s = toList (unGen f sel s) []
  where
    toList (COk sel s x)   xs = (s,x) : xs
    toList (CFail)         xs = xs
    toList (CBranch b1 b2) xs = toList b1 (toList b2 xs)

runTcM :: Abstr -> TcM a -> GenM sel MetaStore a
runTcM abs f = GenM (\sel ms ->
  case unTcM f abs ms of
    Ok ms a -> COk sel ms a
    Fail _  -> CFail)


------------------------------------------------------------------------------
-- Selectors

class Selector sel where
  splitSelector :: sel -> (sel,sel)
  select        :: Abstr -> CId -> GenM sel s CId

instance Selector () where
  splitSelector sel = (sel,sel)
  select abs cat = GenM (\sel s -> case Map.lookup cat (cats abs) of
                                     Just (_,fns) -> iter s fns
                                     Nothing      -> CFail)
    where
      iter s []           = CFail
      iter s ((_,fn):fns) = CBranch (COk () s fn) (iter s fns)

instance RandomGen g => Selector (Identity g) where
  splitSelector (Identity g) = let (g1,g2) = split g
                               in (Identity g1, Identity g2)

  select abs cat = GenM (\(Identity g) s ->
                                      case Map.lookup cat (cats abs) of
                                        Just (_,fns) -> do_rand g s 1.0 fns
                                        Nothing      -> CFail)
    where
      do_rand g s p []  = CFail
      do_rand g s p fns = let (d,g')    = randomR (0.0,p) g
                              (g1,g2)   = split g'
                              (p',fn,fns') = hit d fns
                          in CBranch (COk (Identity g1) s fn) (do_rand g2 s (p-p') fns')

      hit :: Double -> [(Double,a)] -> (Double,a,[(Double,a)])
      hit d (px@(p,x):xs)
        | d < p     = (p,x,xs)
        | otherwise = let (p',x',xs') = hit (d-p) xs
                      in (p,x',px:xs')
