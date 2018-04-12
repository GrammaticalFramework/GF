module EqRel where

import qualified Data.Map as M
import Data.List ( sort )

data EqRel a = Top | Classes [[a]] deriving (Eq,Ord,Show)

(/\) :: (Ord a) => EqRel a -> EqRel a -> EqRel a
Top /\ r = r
r /\ Top = r
Classes xss /\ Classes yss = Classes $ sort $ map sort $ concat -- maybe throw away singleton lists?
  [ M.elems tabXs 
  | xs <- xss 
  , let tabXs = M.fromListWith (++) 
                   [ (tabYs M.! x, [x])
                   | x <- xs ] 
  ]

 where
  tabYs = M.fromList [ (y,representative)
                     | ys <- yss
                     , let representative = head ys 
                     , y <- ys ]

basic :: (Ord a) => [a] -> EqRel Int
basic xs = Classes $ sort $ map sort $ M.elems $ M.fromListWith (++) 
  [ (x,[i]) | (x,i) <- zip xs [0..] ]

rep :: EqRel Int -> Int -> Int
rep Top j           = 0
rep (Classes xss) j = head [ head xs | xs <- xss, j `elem` xs ]

