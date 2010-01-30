module PGF.Generate where

import PGF.CId
import PGF.Data
import PGF.Macros
import PGF.TypeCheck
import PGF.Probabilistic

import qualified Data.Map as M
import System.Random

-- generate all fillings of metavariables in an expr
generateAllFrom :: Maybe Expr -> PGF -> Type -> Maybe Int -> [Expr]
generateAllFrom mex pgf ty mi = maybe (gen ty) (generateForMetas pgf gen) mex where
  gen ty = generate pgf ty mi

-- generate random fillings of metavariables in an expr
generateRandomFrom :: Maybe Expr -> 
                      Maybe Probabilities -> StdGen -> PGF -> Type -> [Expr]
generateRandomFrom mex ps rg pgf ty = 
  maybe (gen ty) (generateForMetas pgf gen) mex where
    gen ty = genRandomProb ps rg pgf ty

generateForMetas :: PGF -> (Type -> [Expr]) -> Expr -> [Expr]
generateForMetas pgf gen exp = case exp of
  EApp f (EMeta _) -> [EApp g a | g <- gener f, a <- genArg g]
  EApp f x         -> [EApp g a | g <- gener f, a <- gener x]
  _ -> [exp]
 where
  gener    = generateForMetas pgf gen
  genArg f = case inferExpr pgf f of
    Right (_,DTyp ((_,_,ty):_) _ _) -> gen ty
    _ -> []

-- generate an infinite list of trees exhaustively
generate :: PGF -> Type -> Maybe Int -> [Expr]
generate pgf ty@(DTyp _ cat _) dp = filter (\e -> case checkExpr pgf e ty of 
                                                    Left  _ -> False
                                                    Right _ -> True             )
                                           (concatMap (\i -> gener i cat) depths)
 where
  gener 0 c = [EFun f | (f, ([],_)) <- fns c]
  gener i c = [
    tr | 
      (f, (cs,_)) <- fns c,
      let alts = map (gener (i-1)) cs,
      ts <- combinations alts,
      let tr = foldl EApp (EFun f) ts,
      depth tr >= i
    ]
  fns c = [(f,catSkeleton ty) | (f,ty) <- functionsToCat pgf c]
  depths = maybe [0 ..] (\d -> [0..d]) dp

-- generate an infinite list of trees randomly
genRandom :: StdGen -> PGF -> Type -> [Expr]
genRandom = genRandomProb Nothing

genRandomProb :: Maybe Probabilities -> StdGen -> PGF -> Type -> [Expr]
genRandomProb mprobs gen pgf ty@(DTyp _ cat _) = 
   filter (\e -> case checkExpr pgf e ty of 
                   Left  _ -> False
                   Right _ -> True             )
          (genTrees (randomRs (0.0, 1.0 :: Double) gen) cat)
 where
  timeout = 47 -- give up

  genTrees ds0 cat = 
    let (ds,ds2) = splitAt (timeout+1) ds0  -- for time out, else ds
        (t,k) = genTree ds cat      
    in (if k>timeout then id else (t:))
                (genTrees ds2 cat)          -- else (drop k ds)

  genTree rs = gett rs where
    gett ds cid | cid == cidString = (ELit (LStr "foo"), 1)
    gett ds cid | cid == cidInt    = (ELit (LInt 12345), 1)
    gett ds cid | cid == cidFloat  = (ELit (LFlt 12345), 1)
    gett [] _   = (ELit (LStr "TIMEOUT"), 1) ----
    gett ds cat = case fns cat of
      [] -> (EMeta 0,1)
      fs -> let 
          d:ds2    = ds
          (f,args) = getf d fs
          (ts,k)   = getts ds2 args
        in (foldl EApp f ts, k+1)
    getf d fs = case mprobs of
      Just _ -> hitRegion d [(p,(f,args)) | (p,(f,args)) <- fs]
      _      -> let 
                  lg = length fs 
                  (f,v) = snd (fs !! (floor (d * fromIntegral lg)))
                in (EFun f,v)
    getts ds cats = case cats of
      c:cs -> let 
          (t, k)  = gett ds c
          (ts,ks) = getts (drop k ds) cs 
        in (t:ts, k + ks)
      _ -> ([],0)

    fns :: CId -> [(Double,(CId,[CId]))]
    fns cat = case mprobs of 
      Just probs -> maybe [] id $ M.lookup cat (catProbs probs)
      _ -> [(deflt,(f,(fst (catSkeleton ty)))) | 
              let fs = functionsToCat pgf cat, 
              (f,ty) <- fs,
              let deflt = 1.0 / fromIntegral (length fs)]

hitRegion :: Double -> [(Double,(CId,[a]))] -> (Expr,[a])
hitRegion d vs = case vs of
  (p1,(f,v1)):vs2 -> if d < p1 then (EFun f, v1) else hitRegion (d-p1) vs2
  _ -> (EMeta 9,[])


