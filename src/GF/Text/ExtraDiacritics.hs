----------------------------------------------------------------------
-- |
-- Module      : ExtraDiacritics
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/02/18 19:21:14 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.4 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module ExtraDiacritics (mkExtraDiacritics) where

mkExtraDiacritics :: String -> String
mkExtraDiacritics = mkExtraDiacriticsWord

mkExtraDiacriticsWord :: String -> String
mkExtraDiacriticsWord str = case str of
  [] -> []
  '<' : cs -> '<' : spoolMarkup cs
  -- 
  '/' : cs -> toEnum 0x0301 : mkExtraDiacriticsWord cs
  '~' : cs -> toEnum 0x0306 : mkExtraDiacriticsWord cs
  ':' : cs -> toEnum 0x0304 : mkExtraDiacriticsWord cs -- some of these could be put in LatinA
  '.' : cs -> toEnum 0x0323 : mkExtraDiacriticsWord cs
  'i' : '-' : cs -> toEnum 0x0268 : mkExtraDiacriticsWord cs -- in IPA extensions
  -- Default 
  c : cs -> c : mkExtraDiacriticsWord cs

spoolMarkup :: String -> String
spoolMarkup s = case s of
   [] -> [] -- Shouldn't happen
   '>' : cs -> '>' : mkExtraDiacriticsWord cs
   c1 : cs -> c1 : spoolMarkup cs
