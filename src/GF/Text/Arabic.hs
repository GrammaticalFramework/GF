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

module Arabic (mkArabic) where

mkArabic :: String -> String
mkArabic = unwords . (map mkArabicWord) . words
----mkArabic = reverse . unwords . (map mkArabicWord) . words
--- reverse : assumes everything's on same line

type ArabicChar = Char

mkArabicWord :: String -> [ArabicChar]
mkArabicWord = map mkArabicChar . getLetterPos

getLetterPos :: String -> [(Char,Int)]
getLetterPos []     = []
getLetterPos ('I':cs)  = ('*',7) : getLetterPos cs           -- 0xfe80
getLetterPos ('O':cs)  = ('*',8) : getIn cs                  -- 0xfe8b
getLetterPos ('l':'a':cs) = ('*',5) : getLetterPos cs        -- 0xfefb
getLetterPos [c]    = [(c,1)]                                -- 1=isolated
getLetterPos (c:cs) | isReduced c = (c,1) : getLetterPos cs
getLetterPos (c:cs) = (c,3) : getIn cs                       -- 3=initial

  
getIn []     = []
getIn ('I':cs)  = ('*',7) : getLetterPos cs                -- 0xfe80
getIn ('O':cs)  = ('*',9) : getIn cs                       -- 0xfe8c
getIn ('l':'a':cs) = ('*',6) : getLetterPos cs             -- 0xfefc
getIn [c]    = [(c,2)]                                     -- 2=final
getIn (c:cs) | isReduced c = (c,2) : getLetterPos cs
getIn (c:cs) = (c,4) : getIn cs                            -- 4=medial

isReduced :: Char -> Bool
isReduced c = c `elem` "UuWiYOaAdVrzwj"

mkArabicChar ('*',p) | p > 4 && p < 10 = 
  (map toEnum [0xfefb,0xfefc,0xfe80,0xfe8b,0xfe8c]) !! (p-5)  
mkArabicChar cp@(c,p) = case lookup c cc of Just c' -> (c' !! (p-1)) ; _ -> c 
 where 
   cc = mkArabicTab allArabicCodes allArabic

mkArabicTab (c:cs) as = (c,as1) : mkArabicTab cs as2 where
  (as1,as2) = if isReduced c then splitAt 2 as else splitAt 4 as
mkArabicTab [] _ = []

allArabicCodes = "UuWiYOabAtvgHCdVrzscSDTZoxfqklmnhwjy" 

allArabic :: String
allArabic = (map toEnum [0xfe81 .. 0xfef4]) -- I=0xfe80


