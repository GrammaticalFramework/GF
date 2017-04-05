module PGF.Generate 
         ( generateAll,         generateAllDepth
         , generateFrom,        generateFromDepth
         , generateRandom,      generateRandomDepth
         , generateRandomFrom,  generateRandomFromDepth
         , generateOntology,    generateOntologyDepth
         , prove
         ) where

import PGF.CId
import PGF.Data
import PGF.TypeCheck
import Control.Monad
import Control.Monad.State
import Control.Monad.Identity
import System.Random
import Data.Maybe(isNothing)

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
generateFromDepth pgf e dp = 
  [e | (_,_,e) <- snd $ runTcM (abstract pgf)
                               (generateForMetas (prove dp) e)
                               emptyMetaStore ()]

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
  restart g (\g -> [e | (_,ms,e) <- snd $ runTcM (abstract pgf)
                                                 (generateForMetas (prove dp) e)
                                                 emptyMetaStore (Identity g)])

generateOntology :: RandomGen g => g -> PGF -> Type -> [(Maybe Expr, Type)] -> [Expr]
generateOntology g pgf ty args = generateOntologyDepth g pgf ty args Nothing

generateOntologyDepth :: RandomGen g => g -> PGF -> Type -> [(Maybe Expr, Type)] -> Maybe Int -> [Expr]
generateOntologyDepth g pgf ty args dp =
  restart g (\g -> [e | (_,(Ontology args' _),e) <- snd $ runTcM (abstract pgf)
                                                                 (prove dp emptyScope (TTyp [] ty) >>= checkResolvedMetaStore emptyScope)
                                                                 emptyMetaStore
                                                                 (Ontology args g),
                        all (isNothing . fst) args'])

------------------------------------------------------------------------------
-- The main generation algorithm

generate :: Selector sel => sel -> PGF -> Type -> Maybe Int -> [Expr]
generate sel pgf ty dp =
  [e | (_,ms,e) <- snd $ runTcM (abstract pgf)
                                (prove dp emptyScope (TTyp [] ty) >>= checkResolvedMetaStore emptyScope)
                                emptyMetaStore sel]


prove :: Selector sel => Maybe Int -> Scope -> TType -> TcM sel Expr
prove dp scope (TTyp env1 (DTyp hypos1 cat es1)) = do
  vs1 <- mapM (PGF.TypeCheck.eval env1) es1
  let scope' = exScope scope env1 hypos1
  (fe,TTyp env2 (DTyp hypos2 _ es2)) <- select cat scope' dp
  case dp of
    Just 0 | not (null hypos2) -> mzero
    _                          -> return ()
  (env2,args) <- mkEnv scope' env2 hypos2
  vs2 <- mapM (PGF.TypeCheck.eval env2) es2
  sequence_ [eqValue mzero suspend (scopeSize scope') v1 v2 | (v1,v2) <- zip vs1 vs2]
  es <- mapM (descend scope') args
  return (abs hypos1 (foldl EApp fe es))
  where
    suspend i c = do
      mv <- getMeta i
      case mv of
        MBound e -> c e
        MUnbound x scope tty cs -> setMeta i (MUnbound x scope tty (c:cs))

    abs []                e = e
    abs ((bt,x,ty):hypos) e = EAbs bt x (abs hypos e)

    exScope scope env []                = scope
    exScope scope env ((bt,x,ty):hypos) = 
       let env' | x /= wildCId = VGen (scopeSize scope) [] : env
                | otherwise    = env
       in exScope (addScopedVar x (TTyp env ty) scope) env' hypos

    mkEnv scope env []                = return (env,[])
    mkEnv scope env ((bt,x,ty):hypos) = do
      (env,arg) <- if x /= wildCId
                    then do i <- newMeta scope (TTyp env ty)
                            return (VMeta i (scopeEnv scope) [] : env,Right (EMeta i))
                    else return (env,Left (TTyp env ty))
      (env,args) <- mkEnv scope env hypos
      return (env,(bt,arg):args)

    descend scope (bt,arg) = do
      let dp' = fmap (flip (-) 1) dp
      e <- case arg of
             Right e  -> return e
             Left tty -> prove dp' scope tty
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
  select cat scope dp = do
    gens <- typeGenerators scope cat
    TcM (\abstr k h -> iter k gens)
    where
      iter k []              ms s = id
      iter k ((_,e,tty):fns) ms s = k (e,tty) ms s . iter k fns ms s


instance RandomGen g => Selector (Identity g) where
  splitSelector (Identity g) = let (g1,g2) = split g
                               in (Identity g1, Identity g2)

  select cat scope dp = do
    gens <- typeGenerators scope cat
    TcM (\abstr k h -> iter k 1.0 gens)
    where
      iter k p []   ms (Identity g) = id
      iter k p gens ms (Identity g) = let (d,g')    = randomR (0.0,p) g
                                          (g1,g2)   = split g'
                                          (p',e_ty,gens') = hit d gens
                                      in k e_ty ms (Identity g1) . iter k (p-p') gens' ms (Identity g2)

      hit :: Double -> [(Double,Expr,TType)] -> (Double,(Expr,TType),[(Double,Expr,TType)])
      hit d (gen@(p,e,ty):gens)
        | d < p || null gens = (p,(e,ty),gens)
        | otherwise = let (p',e_ty',gens') = hit (d-p) gens
                      in (p',e_ty',gen:gens')


data Ontology a = Ontology [(Maybe Expr, Type)] a

instance RandomGen g => Selector (Ontology g) where
  splitSelector (Ontology args g) = let (g1,g2) = split g
                                    in (Ontology args g1, Ontology args g2)

  select cat scope dp = do
    Ontology args g <- get
    case pickArg [] cat args of
      []   -> do gens <- typeGenerators scope cat
                 TcM (\abstr k h -> iter k 1.0 gens)
      alts -> msum [  case mb_e of
                        Just e  -> do put (Ontology args g)
                                      return (e, TTyp [] ty)
                        Nothing -> mzero
                    | (mb_e,ty,args) <- alts]
    where
      iter k p []   ms (Ontology ce g) = id
      iter k p gens ms (Ontology ce g) =
        let (d,g')    = randomR (0.0,p) g
            (g1,g2)   = split g'
            (p',e_ty,gens') = hit d gens
        in k e_ty ms (Ontology ce g1) . iter k (p-p') gens' ms (Ontology ce g2)

      hit :: Double -> [(Double,Expr,TType)] -> (Double,(Expr,TType),[(Double,Expr,TType)])
      hit d (gen@(p,e,ty):gens) | d < p || null gens = (p,(e,ty),gens)
                                | otherwise          = let (p',e_ty',gens') = hit (d-p) gens
                                                       in (p',e_ty',gen:gens')

      pickArg args' cat' [] = []
      pickArg args' cat' (arg@(mb_e,ty@(DTyp _ cat _)):args)
        | cat' == cat = (mb_e, ty, foldl (flip (:)) args args') : 
                        pickArg (arg:args') cat' args
        | otherwise   = pickArg (arg:args') cat' args
