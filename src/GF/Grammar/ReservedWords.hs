module ReservedWords (isResWord, isResWordGFC) where

import List

-- reserved words of GF. (c) Aarne Ranta 19/3/2002 under Gnu GPL
-- modified by Markus Forsberg 9/4. 
-- modified by AR 12/6/2003 for GF2 and GFC


isResWord :: String -> Bool
isResWord s = isInTree s resWordTree

resWordTree :: BTree
resWordTree = 
--  mapTree fst $ sorted2tree $ flip zip (repeat ()) $ sort allReservedWords
    B "let" (B "concrete" (B "Tok" (B "Str" (B "PType" (B "Lin" N N) N) (B "Strs" N N)) (B "case" (B "abstract" (B "Type" N N) N) (B "cat" N N))) (B "fun" (B "flags" (B "def" (B "data" N N) N) (B "fn" N N)) (B "in" (B "grammar" N N) (B "include" N N)))) (B "pattern" (B "of" (B "lindef" (B "lincat" (B "lin" N N) N) (B "lintype" N N)) (B "out" (B "oper" (B "open" N N) N) (B "param" N N))) (B "strs" (B "resource" (B "printname" (B "pre" N N) N) (B "reuse" N N)) (B "transfer" (B "table" N N) (B "variants" N N))))


isResWordGFC :: String -> Bool
isResWordGFC s = isInTree s $
  B "of" (B "fun" (B "concrete" (B "cat" (B "abstract" N N) N) (B "flags" N N)) (B "lin" (B "in" N N) (B "lincat" N N))) (B "resource" (B "param" (B "oper" (B "open" N N) N) (B "pre" N N)) (B "table" (B "strs" N N) (B "variants" N N)))

data BTree = N | B String BTree BTree deriving (Show)

isInTree :: String -> BTree -> Bool
isInTree x tree = case tree of
 N -> False
 B a left right 
   | x < a  -> isInTree x left
   | x > a  -> isInTree x right
   | x == a -> True

