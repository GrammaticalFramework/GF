----------------------------------------------------------------------
-- |
-- Module      : OSCyrillic
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

module OCSCyrillic (mkOCSCyrillic) where

mkOCSCyrillic :: String -> String
mkOCSCyrillic = mkOCSCyrillicWord

mkOCSCyrillicWord :: String -> String
mkOCSCyrillicWord str = case str of
  [] -> []
  ' ' : cs -> ' ' : mkOCSCyrillicWord cs
  '<' : cs -> '<' : spoolMarkup cs  
  'ä' : cs -> toEnum 0x0463 : mkOCSCyrillicWord cs
  'j' : 'e' : '~' : cs -> toEnum 0x0469 : mkOCSCyrillicWord cs 
  'j' : 'o' : '~' : cs -> toEnum 0x046d : mkOCSCyrillicWord cs
  'j' : 'e' : cs -> toEnum 0x0465 : mkOCSCyrillicWord cs
  'e' : '~' : cs -> toEnum 0x0467 : mkOCSCyrillicWord cs
  'o' : '~' : cs -> toEnum 0x046b : mkOCSCyrillicWord cs
  'j' : 'u' : cs -> toEnum 0x044e : mkOCSCyrillicWord cs
  'j' : 'a' : cs -> toEnum 0x044f : mkOCSCyrillicWord cs 
  'u' : cs -> toEnum 0x0479 : mkOCSCyrillicWord cs
  c : cs -> (mkOCSCyrillicChar c) : mkOCSCyrillicWord cs   

spoolMarkup :: String -> String
spoolMarkup s = case s of
   [] -> [] -- Shouldn't happen
   '>' : cs -> '>' : mkOCSCyrillicWord cs
   c1 : cs -> c1 : spoolMarkup cs

mkOCSCyrillicChar :: Char -> Char
mkOCSCyrillicChar c = case lookup c cc of Just c' -> c' ; _ -> c 
 where 
   cc = zip "abvgdeZziJklmnoprstYfxCqwWUyIE" allOCSCyrillic

allOCSCyrillic :: String
allOCSCyrillic = (map toEnum [0x0430 .. 0x044e])
