module Nat where

-- testing transfer from unary to binary, for Nat.gf. AR 8/10/2003

data Nat = One | Succ Nat deriving Show

data Bin = BOne | BX Bin | BXPlus Bin deriving Show

succBin:: Bin -> Bin
succBin BOne = BX BOne
succBin (BX b) = BXPlus b
succBin (BXPlus BOne) = BX (BX BOne) 
succBin b = succAux b (lastZero b)

lastZero :: Bin -> Nat
lastZero (BX _) = One
lastZero (BXPlus b) = Succ (lastZero b)

succAux :: Bin -> Nat -> Bin
succAux (BXPlus b) One = BX (succBin b)
succAux (BXPlus b) (Succ n) = BX (succAux b n)
succAux b _ = succBin b

int2bin :: Int -> Bin
int2bin 1 = BOne
int2bin n = succBin (int2bin (n-1))

bin2nat :: Bin -> Nat
bin2nat BOne = One
bin2nat (BX b) = double (bin2nat b) 
bin2nat (BXPlus b) = Succ (double (bin2nat b))

double :: Nat -> Nat
double One = Succ One
double (Succ n) = Succ (Succ (double n))


-- to test

prBin :: Bin -> String
prBin BOne = "1"
prBin (BX b) = prBin b ++ "0"
prBin (BXPlus b) = prBin b ++ "1"

test  = map (prBin . int2bin) [1..16]
test2 = map (bin2nat . int2bin) [1..16]
