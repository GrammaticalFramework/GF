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

module Russian (mkRussian, mkRusKOI8) where

-- an ad hoc ASCII encoding. Delimiters: /_ _/
mkRussian :: String -> String
mkRussian = unwords . (map mkRussianWord) . words

-- the KOI8 encoding, incomplete. Delimiters: /* */
mkRusKOI8 :: String -> String
mkRusKOI8 = unwords . (map mkRussianKOI8) . words

type RussianChar = Char

mkRussianWord :: String -> [RussianChar]
mkRussianWord = map (mkRussianChar allRussianCodes)

mkRussianKOI8 :: String -> [RussianChar]
mkRussianKOI8 = map (mkRussianChar allRussianKOI8)

mkRussianChar chars c = case lookup c cc of Just c' -> c' ; _ -> c 
 where 
   cc = zip chars allRussian

allRussianCodes = 
 "ÅåABVGDEXZIJKLMNOPRSTUFHCQW£}!*ÖYÄabvgdexzijklmnoprstufhcqw#01'öyä"
allRussianKOI8 =
 "^@áâ÷çäåöúéêëìíîïğòóôõæèãşûıøùÿüàñÁÂ×ÇÄÅÖÚÉÊËÌÍÎÏĞÒÓÔÕÆÈÃŞÛİØÙßÜÀÑ"

allRussian :: String
allRussian = (map toEnum (0x0401:0x0451:[0x0410 .. 0x044f])) -- Ëë in odd places


