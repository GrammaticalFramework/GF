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

module LatinASupplement (mkLatinASupplement) where

mkLatinASupplement :: String -> String
mkLatinASupplement = mkLatinASupplementWord

mkLatinASupplementWord :: String -> String
mkLatinASupplementWord str = case str of
  [] -> []
  '<' : cs -> '<' : spoolMarkup cs
  -- Romanian & partly Turkish
  's' : ',' : cs -> toEnum 0x015f : mkLatinASupplementWord cs
  'a' : '%' : cs -> toEnum 0x0103 : mkLatinASupplementWord cs
  -- Slavic and more
  'c' : '^' : cs -> toEnum 0x010d : mkLatinASupplementWord cs
  's' : '^' : cs -> toEnum 0x0161 : mkLatinASupplementWord cs
  'c' : '\'' : cs -> toEnum 0x0107 : mkLatinASupplementWord cs
  'z' : '^' : cs -> toEnum 0x017e : mkLatinASupplementWord cs
  -- Turkish
  'g' : '%' : cs -> toEnum 0x011f : mkLatinASupplementWord cs
  'I' : cs -> toEnum 0x0131 : mkLatinASupplementWord cs
  'c' : ',' : cs -> 'ç' : mkLatinASupplementWord cs
  -- Polish
  'e' : ',' : cs -> toEnum 0x0119 : mkLatinASupplementWord cs
  'a' : ',' : cs -> toEnum 0x0105 : mkLatinASupplementWord cs
  'l' : '/' : cs -> toEnum 0x0142 : mkLatinASupplementWord cs
  'z' : '.' : cs -> toEnum 0x017c : mkLatinASupplementWord cs
  'n' : '\'' : cs -> toEnum 0x0144 : mkLatinASupplementWord cs
  's' : '\'' : cs -> toEnum 0x015b : mkLatinASupplementWord cs
-- 'c' : '\'' : cs -> toEnum 0x0107 : mkLatinASupplementWord cs

  -- Hungarian 
  'o' : '%' : cs -> toEnum 0x0151 : mkLatinASupplementWord cs
  'u' : '%' : cs -> toEnum 0x0171 : mkLatinASupplementWord cs

  -- Mongolian
  'j' : '^' : cs -> toEnum 0x0135 : mkLatinASupplementWord cs

  -- Khowar (actually in Combining diacritical marks not Latin-A Suppl.)
  'o' : '.' : cs -> 'o' : (toEnum 0x0323 : mkLatinASupplementWord cs)

  -- Length bars over vowels e.g korean
  'a' : ':' : cs -> toEnum 0x0101 : mkLatinASupplementWord cs
  'e' : ':' : cs -> toEnum 0x0113 : mkLatinASupplementWord cs
  'i' : ':' : cs -> toEnum 0x012b : mkLatinASupplementWord cs
  'o' : ':' : cs -> toEnum 0x014d : mkLatinASupplementWord cs
  'u' : ':' : cs -> toEnum 0x016b : mkLatinASupplementWord cs

  -- Default 
  c : cs -> c : mkLatinASupplementWord cs

spoolMarkup :: String -> String
spoolMarkup s = case s of
   [] -> [] -- Shouldn't happen
   '>' : cs -> '>' : mkLatinASupplementWord cs
   c1 : cs -> c1 : spoolMarkup cs
