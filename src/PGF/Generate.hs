module PGF.Generate where

import PGF.CId
import PGF.Data
import PGF.Macros
import PGF.TypeCheck

import qualified Data.Map as M
import System.Random

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
genRandom gen pgf ty@(DTyp _ cat _) = filter (\e -> case checkExpr pgf e ty of 
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
        in (foldl EApp (EFun f) ts, k+1)
    getf d fs = let lg = (length fs) in
      fs !! (floor (d * fromIntegral lg))
    getts ds cats = case cats of
      c:cs -> let 
          (t, k)  = gett ds c
          (ts,ks) = getts (drop k ds) cs 
        in (t:ts, k + ks)
      _ -> ([],0)

    fns cat = [(f,(fst (catSkeleton ty))) | (f,ty) <- functionsToCat pgf cat]
