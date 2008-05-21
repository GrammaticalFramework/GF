module GF.GFCC.Generate where

import GF.GFCC.Macros
import GF.GFCC.DataGFCC
import GF.GFCC.CId

import qualified Data.Map as M
import System.Random

-- generate an infinite list of trees exhaustively
generate :: GFCC -> CId -> Maybe Int -> [Exp]
generate gfcc cat dp = concatMap (\i -> gener i cat) depths
 where
  gener 0 c = [tree (AC f) [] | (f, ([],_)) <- fns c]
  gener i c = [
    tr | 
      (f, (cs,_)) <- fns c,
      let alts = map (gener (i-1)) cs,
      ts <- combinations alts,
      let tr = tree (AC f) ts,
      depth tr >= i
    ]
  fns c = [(f,catSkeleton ty) | (f,ty) <- functionsToCat gfcc c]
  depths = maybe [0 ..] (\d -> [0..d]) dp

-- generate an infinite list of trees randomly
genRandom :: StdGen -> GFCC -> CId -> [Exp]
genRandom gen gfcc cat = genTrees (randomRs (0.0, 1.0 :: Double) gen) cat where

  timeout = 47 -- give up

  genTrees ds0 cat = 
    let (ds,ds2) = splitAt (timeout+1) ds0  -- for time out, else ds
        (t,k) = genTree ds cat      
    in (if k>timeout then id else (t:))
                (genTrees ds2 cat)          -- else (drop k ds)

  genTree rs = gett rs where
    gett ds cid | cid == mkCId "String" = (tree (AS "foo") [], 1)
    gett ds cid | cid == mkCId "Int"    = (tree (AI 12345) [], 1)
    gett [] _ = (tree (AS "TIMEOUT") [], 1) ----
    gett ds cat = case fns cat of
      [] -> (tree (AM 0) [],1)
      fs -> let 
          d:ds2    = ds
          (f,args) = getf d fs
          (ts,k)   = getts ds2 args
        in (tree (AC f) ts, k+1)
    getf d fs = let lg = (length fs) in
      fs !! (floor (d * fromIntegral lg))
    getts ds cats = case cats of
      c:cs -> let 
          (t, k)  = gett ds c
          (ts,ks) = getts (drop k ds) cs 
        in (t:ts, k + ks)
      _ -> ([],0)

    fns cat = [(f,(fst (catSkeleton ty))) | (f,ty) <- functionsToCat gfcc cat]


{-
-- brute-force parsing method; only returns the first result
-- note: you cannot throw away rules with unknown words from the grammar
-- because it is not known which field in each rule may match the input

searchParse :: Int -> GFCC -> CId -> [String] -> [Exp]
searchParse i gfcc cat ws = [t | t <- gen, s <- lins t, words s == ws] where 
  gen    = take i $ generate gfcc cat
  lins t = [linearize gfcc lang t | lang <- cncnames gfcc]
-}
