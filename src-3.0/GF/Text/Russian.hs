----------------------------------------------------------------------
-- |
-- Module      : Russian
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:23:40 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.5 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Text.Russian (mkRussian, mkRusKOI8) where

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

allRussianCodes :: [Char]
allRussianCodes = 
 -- changed to Ints to work with Haskell compilers e.g. GHC 6.5 CVS
 -- which expect source files to be in UTF-8
 -- /bringert 2006-05-19
 -- "ÅåABVGDEXZIJKLMNOPRSTUFHCQW£}!*ÖYÄabvgdexzijklmnoprstufhcqw#01'öyä"
 map toEnum [197,229,65,66,86,71,68,69,88,90,73,74,75,76,77,78,79,80,82,83,84,85,70,72,67,81,87,163,125,33,42,214,89,196,97,98,118,103,100,101,120,122,105,106,107,108,109,110,111,112,114,115,116,117,102,104,99,113,119,35,48,49,39,246,121,228]

allRussianKOI8 :: [Char]
allRussianKOI8 =
 -- changed to Ints to work with Haskell compilers e.g. GHC 6.5 CVS
 -- which expect source files to be in UTF-8
 -- /bringert 2006-05-19
 -- "^@áâ÷çäåöúéêëìíîïğòóôõæèãşûıøùÿüàñÁÂ×ÇÄÅÖÚÉÊËÌÍÎÏĞÒÓÔÕÆÈÃŞÛİØÙßÜÀÑ"
 map toEnum [94,64,225,226,247,231,228,229,246,250,233,234,235,236,237,238,239,240,242,243,244,245,230,232,227,254,251,253,248,249,255,252,224,241,193,194,215,199,196,197,214,218,201,202,203,204,205,206,207,208,210,211,212,213,198,200,195,222,219,221,216,217,223,220,192,209]

allRussian :: String
allRussian = (map toEnum (0x0401:0x0451:[0x0410 .. 0x044f])) -- Ëë in odd places


