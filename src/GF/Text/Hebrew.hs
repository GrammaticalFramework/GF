module Hebrew where

mkHebrew :: String -> String
mkHebrew = reverse . unwords . (map mkHebrewWord) . words
--- reverse : assumes everything's on same line

type HebrewChar = Char

mkHebrewWord :: String -> [HebrewChar]
mkHebrewWord = map mkHebrewChar

mkHebrewChar c = case lookup c cc of Just c' -> c' ; _ -> c 
 where 
   cc = zip allHebrewCodes allHebrew

allHebrewCodes = "-abgdhwzHTyKklMmNnSoPpCcqrst"

allHebrew :: String
allHebrew = (map toEnum (0x05be : [0x05d0 .. 0x05ea]))


