module URLEncoding(urlDecodeUnicode,decodeQuery) where

import Data.Bits (shiftL, (.|.))
import Data.Char (chr,digitToInt,isHexDigit)

-- | Decode hexadecimal escapes
urlDecodeUnicode :: String -> String
urlDecodeUnicode [] = ""
urlDecodeUnicode ('%':'u':x1:x2:x3:x4:s) 
    | all isHexDigit [x1,x2,x3,x4] =
    chr (    digitToInt x1 `shiftL` 12 
         .|. digitToInt x2 `shiftL` 8
         .|. digitToInt x3 `shiftL` 4
         .|. digitToInt x4) : urlDecodeUnicode s
urlDecodeUnicode ('%':x1:x2:s) | isHexDigit x1 && isHexDigit x2 =
    chr (    digitToInt x1 `shiftL` 4
         .|. digitToInt x2) : urlDecodeUnicode s
urlDecodeUnicode (c:s) = c : urlDecodeUnicode s

--------------------------------------------------------------------------------

type Query = [(String,String)]

-- | Decode application/x-www-form-urlencoded
decodeQuery :: String -> Query
decodeQuery = map (aboth decode . breakAt '=') . chopList (breakAt '&')

aboth f (x,y) = (f x,f y)

-- | Decode "+" and hexadecimal escapes
decode [] = []
decode ('%':'u':d1:d2:d3:d4:cs)
    | all isHexDigit [d1,d2,d3,d4] = chr(fromhex4 d1 d2 d3 d4):decode cs
decode ('%':d1:d2:cs)
    | all isHexDigit [d1,d2] = chr(fromhex2 d1 d2):decode cs
decode ('+':cs) = ' ':decode cs
decode (c:cs) = c:decode cs

fromhex4 d1 d2 d3 d4 = 256*fromhex2 d1 d2+fromhex2 d3 d4
fromhex2 d1 d2 = 16*digitToInt d1+digitToInt d2


-- From hbc-library ListUtil ---------------------------------------------------

-- Repeatedly extract (and transform) values until a predicate hold.  Return the list of values.
unfoldr :: (a -> (b, a)) -> (a -> Bool) -> a -> [b]
unfoldr f p x | p x       = []
	      | otherwise = y:unfoldr f p x'
			      where (y, x') = f x

chopList :: ([a] -> (b, [a])) -> [a] -> [b]
chopList f l = unfoldr f null l

breakAt :: (Eq a) => a -> [a] -> ([a], [a])
breakAt _ [] = ([], [])
breakAt x (x':xs) =
	if x == x' then
	    ([], xs)
	else
	    let (ys, zs) = breakAt x xs
	    in  (x':ys, zs)
