module GF.Canon.GFCC.GenGFCC where

import GF.Canon.GFCC.DataGFCC
import GF.Canon.GFCC.AbsGFCC
import GF.Data.Operations
import qualified Data.Map as M

-- generate an infinite list of trees
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
