module GF.Text.CP1251 where

import Data.Char

decodeCP1251 = map convert where
  convert c
   | c >= '\192' && c <= '\255' = chr (ord c + 848)
   | c == '\168'                = chr 1025      -- cyrillic capital letter lo
   | c == '\184'                = chr 1105      -- cyrillic small   letter lo
   | otherwise                  = c

encodeCP1251 = map convert where
  convert c
   | oc >= 1040 && oc <= 1103 = chr (oc - 848)
   | oc == 1025               = chr 168         -- cyrillic capital letter lo
   | oc == 1105               = chr 184         -- cyrillic small   letter lo
   | otherwise                = c
   where oc = ord c
