module GF.Canon.GFCC.GenGFCC where

import GF.Canon.GFCC.DataGFCC
import GF.Canon.GFCC.AbsGFCC
import GF.Data.Operations
import qualified Data.Map as M
import System.Random

-- generate an infinite list of trees exhaustively
generate :: GFCC -> CId -> [Exp]
generate gfcc cat = concatMap (\i -> gener i cat) [0..]
 where
  gener 0 c = [Tr (AC f) [] | (f, Typ [] _) <- fns c]
  gener i c = [
    tr | 
      (f, Typ cs _) <- fns c,
      let alts = map (gener (i-1)) cs,
      ts <- combinations alts,
      let tr = Tr (AC f) ts,
      depth tr >= i
    ]
  fns cat = 
    let fs = maybe [] id $ M.lookup cat $ cats $ abstract gfcc
    in [(f,ty) | f <- fs, Just ty <- [M.lookup f $ funs $ abstract gfcc]]
  depth tr = case tr of
    Tr _ [] -> 1
    Tr _ ts -> maximum (map depth ts) + 1

-- generate an infinite list of trees randomly
generateRandom :: StdGen -> GFCC -> CId -> [Exp]
generateRandom gen gfcc cat = genTrees (randomRs (0.0, 1.0) gen) cat where

  timeout = 47 -- give up

  genTrees ds0 cat = 
    let (ds,ds2) = splitAt (timeout+1) ds0  -- for time out, else ds
        (t,k) = genTree ds cat      
    in (if k>timeout then id else (t:))
                (genTrees ds2 cat)          -- else (drop k ds)

  genTree rs = gett rs where
    gett ds (CId "String") = (Tr (AS "foo") [], 1)
    gett ds (CId "Int")    = (Tr (AI 12345) [], 1)
    gett ds cat = case fns cat of
      fs -> let 
          d:ds2    = ds
          (f,args) = getf d fs
          (ts,k)   = getts ds2 args
        in (Tr (AC f) ts, k+1)
    getf d fs = let lg = (length fs) in
      fs !! (floor (d * fromIntegral lg))
    getts ds cats = case cats of
      c:cs -> let 
          (t, k)  = gett ds c
          (ts,ks) = getts (drop k ds) cs 
        in (t:ts, k + ks)
      _ -> ([],0)

    fns cat = 
      let fs = maybe [] id $ M.lookup cat $ cats $ abstract gfcc
      in [(f,cs) | f <- fs, 
            Just (Typ cs _) <- [M.lookup f $ funs $ abstract gfcc]]
