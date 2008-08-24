module URLEncoding where

import Data.Bits (shiftL, (.|.))
import Data.Char (chr,digitToInt,isHexDigit)


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
