module GF.Text.CP1252 where

import Data.Char

decodeCP1252 = map id
encodeCP1252 = map (\x -> if x <= '\255' then x else '?')
