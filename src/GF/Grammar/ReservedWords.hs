----------------------------------------------------------------------
-- |
-- Module      : (Module)
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date $ 
-- > CVS $Author $
-- > CVS $Revision $
--
-- (Description of the module)
-----------------------------------------------------------------------------

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
--  nowadays obtained from LexGF.hs
    B "let" (B "data" (B "Type" (B "Str" (B "PType" (B "Lin" N N) N) (B "Tok" (B "Strs" N N) N)) (B "cat" (B "case" (B "abstract" N N) N) (B "concrete" N N))) (B "in" (B "fn" (B "flags" (B "def" N N) N) (B "grammar" (B "fun" N N) N)) (B "instance" (B "incomplete" (B "include" N N) N) (B "interface" N N)))) (B "pre" (B "open" (B "lindef" (B "lincat" (B "lin" N N) N) (B "of" (B "lintype" N N) N)) (B "param" (B "out" (B "oper" N N) N) (B "pattern" N N))) (B "transfer" (B "reuse" (B "resource" (B "printname" N N) N) (B "table" (B "strs" N N) N)) (B "where" (B "variants" (B "union" N N) N) (B "with" N N))))

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

