----------------------------------------------------------------------
-- |
-- Module      : Russian
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/02/18 19:21:15 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.4 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module Russian (mkRussian, mkRusKOI8) where

-- | an ad hoc ASCII encoding. Delimiters: @\/_ _\/@
mkRussian :: String -> String
mkRussian = unwords . (map mkRussianWord) . words

-- | the KOI8 encoding, incomplete. Delimiters: @\/* *\/@
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


