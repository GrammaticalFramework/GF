module TransferDefGFCC where

import GF.Canon.GFCC.GFCCAPI (Tree)
import GSyntax

transfer :: Tree -> Tree
transfer = gf . answer . fg

answer :: GQuestion -> GAnswer
answer p = case p of
  GOdd x   -> test odd x
  GEven x  -> test even x
  GPrime x -> test prime x

value :: GObject -> Int
value e = case e of
  GNumber (GInt i) -> fromInteger i

test :: (Int -> Bool) -> GObject -> GAnswer
test f x = if f (value x) then GYes else GNo

prime :: Int -> Bool
prime x = elem x primes where
  primes = sieve [2 .. x]
  sieve (p:xs) = p : sieve [ n | n <- xs, n `mod` p > 0 ]
  sieve [] = []
