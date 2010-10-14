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

import Data.Maybe (fromMaybe)
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap
import Control.Monad
import Control.Monad.Identity
import System.Random


------------------------------------------------------------------------------
-- The API

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
  [e | (_,ms,e) <- snd $ runTcM (abstract pgf) (prove emptyScope (TTyp [] ty) dp >>= refineExpr) sel emptyMetaStore]

generateForMetas :: Selector sel => sel -> PGF -> Expr -> Maybe Int -> [Expr]
generateForMetas sel pgf e dp =
  case unTcM (infExpr emptyScope e) abs sel emptyMetaStore of
    Ok sel ms (e,_) -> let gen = do fillinVariables $ \scope tty -> do 
                                       prove scope tty dp
                                    refineExpr e
                       in [e | (_,ms,e) <- snd $ runTcM abs gen sel ms]
    Fail _ _        -> []
  where
    abs = abstract pgf

prove :: Selector sel => Scope -> TType -> Maybe Int -> TcM sel Expr
prove scope (TTyp env1 (DTyp [] cat es1)) dp = do
  (fe,DTyp hypos _ es2) <- select cat dp
  if fe == EFun (mkCId "plus") then mzero else return ()
  case dp of
    Just 0 | not (null hypos) -> mzero
    _                         -> return ()
  (env2,args) <- mkEnv [] hypos
  vs1 <- mapM (PGF.TypeCheck.eval env1) es1
  vs2 <- mapM (PGF.TypeCheck.eval env2) es2
  sequence_ [eqValue mzero suspend (scopeSize scope) v1 v2 | (v1,v2) <- zip vs1 vs2]
  es <- mapM descend args
  return (foldl EApp fe es)
  where
    suspend i c = do
      mv <- getMeta i
      case mv of
        MBound e -> c e
        MUnbound scope tty cs -> do e <- prove scope tty dp
                                    setMeta i (MBound e)
                                    sequence_ [c e | c <- (c:cs)]

    mkEnv env []                = return (env,[])
    mkEnv env ((bt,x,ty):hypos) = do
      (env,arg) <- if x /= wildCId
                    then do i <- newMeta scope (TTyp env ty)
                            return (VMeta i env [] : env,Right (EMeta i))
                    else return (env,Left (TTyp env ty))
      (env,args) <- mkEnv env hypos
      return (env,(bt,arg):args)

    descend (bt,arg) = do let dp' = fmap (flip (-) 1) dp
                          e <- case arg of
                                 Right e  -> return e
                                 Left tty -> prove scope tty dp'
                          e <- case bt of
                                 Implicit -> return (EImplArg e)
                                 Explicit -> return e
                          return e


-- Helper function for random generation. After every
-- success we must restart the search to find sufficiently different solution.
restart :: RandomGen g => g -> (g -> [a]) -> [a]
restart g f =
  let (g1,g2) = split g
  in case f g1 of
       []     -> []
       (x:xs) -> x : restart g2 f


------------------------------------------------------------------------------
-- Selectors

instance Selector () where
  splitSelector s = (s,s)
  select cat dp
    | cat == cidInt    = return (ELit (LInt 999),  DTyp [] cat [])
    | cat == cidFloat  = return (ELit (LFlt 3.14), DTyp [] cat [])
    | cat == cidString = return (ELit (LStr "Foo"),DTyp [] cat [])
    | otherwise        = TcM (\abstr s ms -> case Map.lookup cat (cats abstr) of
                                               Just (_,fns) -> iter abstr ms fns
                                               Nothing      -> Fail s (UnknownCat cat))
    where
      iter abstr ms []           = Zero
      iter abstr ms ((_,fn):fns) = Plus (select_helper fn abstr () ms) (iter abstr ms fns)

instance RandomGen g => Selector (Identity g) where
  splitSelector (Identity g) = let (g1,g2) = split g
                               in (Identity g1, Identity g2)

  select cat dp
    | cat == cidInt    = TcM (\abstr (Identity g) ms ->
                                  let (n,g') = maybe random (\d -> randomR ((-10)*d,10*d)) dp g
                                  in Ok (Identity g) ms (ELit (LInt n),DTyp [] cat []))
    | cat == cidFloat  = TcM (\abstr (Identity g) ms ->
                                  let (d,g') = maybe random (\d' -> let d = fromIntegral d'
                                                                    in randomR ((-pi)*d,pi*d)) dp g
                                  in Ok (Identity g) ms (ELit (LFlt d),DTyp [] cat []))
    | cat == cidString = TcM (\abstr (Identity g) ms ->
                                  let (g1,g2) = split g
                                      s = take (fromMaybe 10 dp) (randomRs ('A','Z') g1)
                                  in Ok (Identity g2) ms (ELit (LStr s),DTyp [] cat []))
    | otherwise        = TcM (\abstr (Identity g) ms ->
                                  case Map.lookup cat (cats abstr) of
                                    Just (_,fns) -> do_rand abstr g ms 1.0 fns
                                    Nothing      -> Fail (Identity g) (UnknownCat cat))
    where
      do_rand abstr g ms p []  = Zero
      do_rand abstr g ms p fns = let (d,g')    = randomR (0.0,p) g
                                     (g1,g2)   = split g'
                                     (p',fn,fns') = hit d fns
                                 in Plus (select_helper fn abstr (Identity g1) ms) (do_rand abstr g2 ms (p-p') fns')

      hit :: Double -> [(Double,a)] -> (Double,a,[(Double,a)])
      hit d (px@(p,x):xs)
        | d < p     = (p,x,xs)
        | otherwise = let (p',x',xs') = hit (d-p) xs
                      in (p,x',px:xs')

select_helper fn = unTcM $ do
  ty <- lookupFunType fn
  return (EFun fn,ty)
