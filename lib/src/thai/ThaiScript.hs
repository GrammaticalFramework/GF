module ThaiScript where

import Data.Char
import qualified Data.Map as Map


-- heuristics for finding syllables
uniSyllables :: [Int] -> [[Int]]
uniSyllables = reverse . (syll [] []) where
  syll sys sy is = case is of
    c:cs | isPreVowel c -> new [] is
    c:d:cs | isConsonant c && isConsonant d -> new [c] (d:cs) ---- no consonant clusters
    c:cs -> continue [c] cs ---- more rules to follow 
    _ -> sy:sys
   where
    new old = syll ((sy ++ old) : sys) []
    continue old = syll sys (sy ++ old)


isPreVowel  :: Int -> Bool
isPreVowel i = 0xe40 <= i && i <= 0xe44

isVowel :: Int -> Bool
isVowel i = 0xe30 <= i && i <= 0xe44

isConsonant :: Int -> Bool
isConsonant i = 0xe01 <= i && i <= 0xe2e && i /= 0xe2d

isMark :: Int -> Bool
isMark i = 0xe47 <= i && i <= 0xe4c


-- the following functions involving pron (=pronunciation) work on syllables
thai2pron  = uni2pron . thai2uni
trans2pron = uni2pron . trans2uni
trans2thai = uni2thai . trans2uni

thai2uni :: String -> [Int]
thai2uni = map fromEnum

uni2thai :: [Int] -> String
uni2thai = map toEnum

uni2pron :: [Int] -> String
uni2pron is = case is of
  0xe40:c:0xe35:0xe22:cs -> pron c ++ tone c cs "i:a" ++ uni2pron cs
  0xe40:c:0xe37:0xe2d:cs -> pron c ++ tone c cs "ü:a" ++ uni2pron cs
  0xe40:c:0xe32:cs -> pron c ++ tone c cs "ao" ++ uni2pron cs
  0xe40:c:0xe34:cs -> pron c ++ tone c cs "ö:" ++ uni2pron cs
  0xe40:c:0xe47:cs -> pron c ++ tone c cs "e" ++ uni2pron cs
  0xe40:c:cs -> pron c ++ tone c cs "e:" ++ uni2pron cs

  0xe41:c:0xe47:cs -> pron c ++ tone c cs "ä" ++ uni2pron cs
  0xe41:c:cs -> pron c ++ tone c cs "ä:" ++ uni2pron cs

  0xe42:c:cs -> pron c ++ tone c cs "o:" ++ uni2pron cs
  0xe43:c:cs -> pron c ++ tone c cs "ai" ++ uni2pron cs
  0xe44:c:cs -> pron c ++ tone c cs "ai" ++ uni2pron cs

  c:0xe30:cs -> pron c ++ tone c cs "a"  ++ uni2pron cs
  c:0xe31:0xe27:cs -> pron c ++ tone c cs "u:a"  ++ uni2pron cs
  c:0xe31:cs -> pron c ++ tone c cs "a"  ++ uni2pron cs
  c:0xe32:cs -> pron c ++ tone c cs "a:" ++ uni2pron cs
  c:0xe33:cs -> pron c ++ tone c cs "am" ++ uni2pron cs
  c:0xe34:cs -> pron c ++ tone c cs "i"  ++ uni2pron cs
  c:0xe35:cs -> pron c ++ tone c cs "i:" ++ uni2pron cs
  c:0xe36:cs -> pron c ++ tone c cs "ü"  ++ uni2pron cs
  c:0xe37:cs -> pron c ++ tone c cs "ü:" ++ uni2pron cs
  c:0xe38:cs -> pron c ++ tone c cs "u"  ++ uni2pron cs
  c:0xe39:cs -> pron c ++ tone c cs "u:" ++ uni2pron cs

  [c] -> enc c
  c:cs -> pron c ++ uni2pron cs
  [] -> []
 where
   enc  c = lookThai [] pronunc_end c
   pron c = lookThai [] pronunc c

tone :: Int -> [Int] -> String -> String
tone c cs v = case (lookThai Low cclass c, isLive cs, toneMark (c:cs)) of
  (_,_,3) -> high v
  (_,_,4) -> rising v
  (Low,_,1) -> falling v
  (Low,_,2) -> high v
  (Low,True,_)  -> mid v
  (Low,False,_) -> case isLong v of
     False -> high v
     True  -> falling v
  (_,_,1) -> low v
  (_,_,2) -> falling v
  (Mid,True,_)   -> mid v
  (Mid,False,_)  -> low v
  (High,True,_)  -> rising v
  (High,False,_) -> low v

toneMark :: [Int] -> Int
toneMark is = case is of
  0xe48:is -> 1
  0xe49:is -> 2
  0xe4a:is -> 3
  0xe4b:is -> 4
  _:is -> toneMark is
  _ -> 0  -- no tone mark in is

isLong :: String -> Bool
isLong s = elem ':' s 

isLive :: [Int] -> Bool
isLive is = case is of
  [i] -> lookThai False liveness i
  [] -> True
  _  -> False

mid, high, low, falling, rising :: String -> String
mid s = s
high = toneMap "á" "é" "í" "ó" "ú" "ǘ" "ä'" "ö'"
low  = toneMap "à" "è" "ì" "ò" "ù" "ǜ" "ä`" "ö`"
rising  = toneMap "ã" "ẽ" "ĩ" "õ" "ũ" "ü~" "ä~" "ö~"
falling  = toneMap "â" "ê" "î" "ô" "û" "ü^" "ä^" "ö^"

toneMap a e i o u ue ae oe s = case s of
  'a':cs -> a++cs
  'e':cs -> e++cs
  'i':cs -> i++cs
  'o':cs -> o++cs
  'u':cs -> u++cs
  'ü':cs -> ue++cs
  'ä':cs -> ae++cs
  'ö':cs -> oe++cs
  _ -> s


lookThai :: a -> (ThaiChar -> a) -> Int -> a
lookThai v f i = maybe v f (Map.lookup i thaiMap)

trans2uni :: String -> [Int]
trans2uni = 
  map (\c -> maybe 0 id $ Map.lookup c trans) . 
  unchar
 where
  trans = Map.fromList [(translit c, unicode c) | c <- allThaiChars]
  
unchar :: String -> [String]  
unchar s = case s of
    c:d:cs 
     | isAlpha d -> [c]    : unchar (d:cs)
     | isSpace d -> [c]:[d]: unchar cs
     | otherwise -> let (ds,cs2) = break (\x -> isAlpha x || isSpace x) cs in
                    (c:d:ds) : unchar cs2
    [_]          -> [s]
    _            -> []


thaiMap :: Map.Map Int ThaiChar
thaiMap = Map.fromList [(unicode c,c) | c <- allThaiChars]

data ThaiChar = TC {
  unicode   :: Int,
  translit  :: String,
  cclass    :: CClass,
  liveness  :: Bool,
  pronunc   :: String,
  pronunc_end :: String
  }
  deriving Show

data CClass = Low | Mid | High
  deriving (Show, Eq)

allThaiChars :: [ThaiChar]
allThaiChars = [
  TC {unicode = 3585, translit = "k", cclass = Mid, liveness = False, pronunc = "k", pronunc_end = "k"},
  TC {unicode = 3586, translit = "k1", cclass = High, liveness = False, pronunc = "kh", pronunc_end = "k"},
  TC {unicode = 3588, translit = "k2", cclass = Low, liveness = False, pronunc = "kh", pronunc_end = "k"},
  TC {unicode = 3590, translit = "k3", cclass = Low, liveness = False, pronunc = "kh", pronunc_end = "k"},
  TC {unicode = 3591, translit = "g", cclass = Low, liveness = True, pronunc = "ng", pronunc_end = "ng"},
  TC {unicode = 3592, translit = "c", cclass = Mid, liveness = False, pronunc = "j", pronunc_end = "t"},
  TC {unicode = 3593, translit = "c1", cclass = High, liveness = False, pronunc = "ch", pronunc_end = "t"},
  TC {unicode = 3594, translit = "c2", cclass = Low, liveness = False, pronunc = "ch", pronunc_end = "t"},
  TC {unicode = 3595, translit = "s'", cclass = Low, liveness = False, pronunc = "s", pronunc_end = "t"},
  TC {unicode = 3596, translit = "c3", cclass = Low, liveness = False, pronunc = "ch", pronunc_end = "t"},
  TC {unicode = 3597, translit = "y'", cclass = Low, liveness = False, pronunc = "y", pronunc_end = "n"},
  TC {unicode = 3598, translit = "d'", cclass = Mid, liveness = False, pronunc = "d", pronunc_end = "d'"},
  TC {unicode = 3599, translit = "t'", cclass = Mid, liveness = False, pronunc = "t'", pronunc_end = "t'"},
  TC {unicode = 3600, translit = "t1", cclass = High, liveness = False, pronunc = "th", pronunc_end = "t"},
  TC {unicode = 3601, translit = "t2", cclass = Low, liveness = False, pronunc = "th", pronunc_end = "t"},
  TC {unicode = 3602, translit = "t3", cclass = Low, liveness = False, pronunc = "th", pronunc_end = "t"},
  TC {unicode = 3603, translit = "n'", cclass = Low, liveness = True, pronunc = "n", pronunc_end = "n"},
  TC {unicode = 3604, translit = "d", cclass = Mid, liveness = False, pronunc = "d", pronunc_end = "d"},
  TC {unicode = 3605, translit = "t", cclass = Mid, liveness = False, pronunc = "t", pronunc_end = "t"},
  TC {unicode = 3606, translit = "t4", cclass = High, liveness = False, pronunc = "th", pronunc_end = "t"},
  TC {unicode = 3607, translit = "t5", cclass = Low, liveness = False, pronunc = "th", pronunc_end = "t"},
  TC {unicode = 3608, translit = "t6", cclass = Low, liveness = False, pronunc = "th", pronunc_end = "t"},
  TC {unicode = 3609, translit = "n", cclass = Low, liveness = True, pronunc = "n", pronunc_end = "n"},
  TC {unicode = 3610, translit = "b", cclass = Mid, liveness = False, pronunc = "b", pronunc_end = "p"},
  TC {unicode = 3611, translit = "p", cclass = Mid, liveness = False, pronunc = "p", pronunc_end = "p"},
  TC {unicode = 3612, translit = "p1", cclass = High, liveness = False, pronunc = "ph", pronunc_end = "p"},
  TC {unicode = 3613, translit = "f", cclass = High, liveness = False, pronunc = "f", pronunc_end = "p"},
  TC {unicode = 3614, translit = "p2", cclass = Low, liveness = False, pronunc = "ph", pronunc_end = "p"},
  TC {unicode = 3615, translit = "f'", cclass = Low, liveness = False, pronunc = "f", pronunc_end = "p"},
  TC {unicode = 3616, translit = "p3", cclass = Low, liveness = False, pronunc = "ph", pronunc_end = "p"},
  TC {unicode = 3617, translit = "m", cclass = Low, liveness = True, pronunc = "m", pronunc_end = "m"},
  TC {unicode = 3618, translit = "y", cclass = Low, liveness = True, pronunc = "y", pronunc_end = "y"},
  TC {unicode = 3619, translit = "r", cclass = Low, liveness = True, pronunc = "r", pronunc_end = "n"},
  TC {unicode = 3621, translit = "l", cclass = Low, liveness = True, pronunc = "l", pronunc_end = "n"},
  TC {unicode = 3623, translit = "w", cclass = Low, liveness = True, pronunc = "w", pronunc_end = "w"},
  TC {unicode = 3624, translit = "s-", cclass = High, liveness = False, pronunc = "sh", pronunc_end = "t"},
  TC {unicode = 3625, translit = "s.", cclass = High, liveness = False, pronunc = "sh", pronunc_end = "t"},
  TC {unicode = 3626, translit = "s", cclass = High, liveness = False, pronunc = "s", pronunc_end = "t"},
  TC {unicode = 3627, translit = "h", cclass = High, liveness = True, pronunc = "h", pronunc_end = ""},
  TC {unicode = 3628, translit = "l'", cclass = Low, liveness = True, pronunc = "l", pronunc_end = "n"},
  TC {unicode = 3629, translit = "O", cclass = Mid, liveness = True, pronunc = "O", pronunc_end = "O"},
  TC {unicode = 3630, translit = "h'", cclass = Low, liveness = True, pronunc = "h", pronunc_end = ""},

  TC {unicode = 3632, translit = "a.", cclass = Low, liveness = True, pronunc = "a", pronunc_end = "a"},
  TC {unicode = 3633, translit = "a", cclass = Low, liveness = True, pronunc = "a", pronunc_end = "a"},
  TC {unicode = 3634, translit = "a:", cclass = Low, liveness = True, pronunc = "a:", pronunc_end = "a:"},
  TC {unicode = 3635, translit = "a+", cclass = Low, liveness = True, pronunc = "am", pronunc_end = "am"},
  TC {unicode = 3636, translit = "i", cclass = Low, liveness = True, pronunc = "i", pronunc_end = "i"},
  TC {unicode = 3637, translit = "i:", cclass = Low, liveness = True, pronunc = "i:", pronunc_end = "i:"},
  TC {unicode = 3638, translit = "v", cclass = Low, liveness = True, pronunc = "ü", pronunc_end = "ü"},
  TC {unicode = 3639, translit = "v:", cclass = Low, liveness = True, pronunc = "ü:", pronunc_end = "ü:"},
  TC {unicode = 3640, translit = "u", cclass = Low, liveness = True, pronunc = "u", pronunc_end = "u"},
  TC {unicode = 3641, translit = "u:", cclass = Low, liveness = True, pronunc = "u:", pronunc_end = "u:"},
  TC {unicode = 3648, translit = "e", cclass = Low, liveness = True, pronunc = "e:", pronunc_end = "e:"},
  TC {unicode = 3649, translit = "e'", cclass = Low, liveness = True, pronunc = "ä:", pronunc_end = "ä:"},
  TC {unicode = 3650, translit = "o:", cclass = Low, liveness = True, pronunc = "o:", pronunc_end = "o:"},
  TC {unicode = 3651, translit = "a%", cclass = Low, liveness = True, pronunc = "ai", pronunc_end = "ai"},
  TC {unicode = 3652, translit = "a&", cclass = Low, liveness = True, pronunc = "ai", pronunc_end = "ai"},
  TC {unicode = 3653, translit = "L", cclass = Low, liveness = True, pronunc = "l", pronunc_end = "n"},
  TC {unicode = 3654, translit = "R", cclass = Low, liveness = True, pronunc = "r", pronunc_end = "n"},
  TC {unicode = 3655, translit = "S", cclass = Low, liveness = True, pronunc = "", pronunc_end = ""},
  TC {unicode = 3656, translit = "T1", cclass = Low, liveness = True, pronunc = "", pronunc_end = ""},
  TC {unicode = 3657, translit = "T2", cclass = Low, liveness = True, pronunc = "", pronunc_end = ""},
  TC {unicode = 3658, translit = "T3", cclass = Low, liveness = True, pronunc = "", pronunc_end = ""},
  TC {unicode = 3659, translit = "T4", cclass = Low, liveness = True, pronunc = "", pronunc_end = ""},
  TC {unicode = 3660, translit = "K", cclass = Low, liveness = True, pronunc = "", pronunc_end = ""},
  TC {unicode = 3664, translit = "N0", cclass = Low, liveness = False, pronunc = "0", pronunc_end = "0"},
  TC {unicode = 3665, translit = "N1", cclass = Low, liveness = False, pronunc = "1", pronunc_end = "1"},
  TC {unicode = 3666, translit = "N2", cclass = Low, liveness = False, pronunc = "2", pronunc_end = "2"},
  TC {unicode = 3667, translit = "N3", cclass = Low, liveness = False, pronunc = "3", pronunc_end = "3"},
  TC {unicode = 3668, translit = "N4", cclass = Low, liveness = False, pronunc = "4", pronunc_end = "4"},
  TC {unicode = 3669, translit = "N5", cclass = Low, liveness = False, pronunc = "5", pronunc_end = "5"},
  TC {unicode = 3670, translit = "N6", cclass = Low, liveness = False, pronunc = "6", pronunc_end = "6"},
  TC {unicode = 3671, translit = "N7", cclass = Low, liveness = False, pronunc = "7", pronunc_end = "7"},
  TC {unicode = 3672, translit = "N8", cclass = Low, liveness = False, pronunc = "8", pronunc_end = "8"},
  TC {unicode = 3673, translit = "N9", cclass = Low, liveness = False, pronunc = "9", pronunc_end = "9"}
 ]



--[TC u t Low False t t | 
 -- (u,t) <- Map.toList (trans_from_unicode transThai)]

pronChar :: Int -> String 
pronChar i = show i




data Transliteration = Trans {
  trans_to_unicode   :: Map.Map String Int,
  trans_from_unicode :: Map.Map Int String,
  invisible_chars    :: [String],
  printname          :: String
  }

appTransToUnicode :: Transliteration -> String -> String
appTransToUnicode trans = 
  concat .
  map (\c -> maybe c (return . toEnum) $
             Map.lookup c (trans_to_unicode trans)
      ) . 
  filter (flip notElem (invisible_chars trans)) . 
  unchar

appTransFromUnicode :: Transliteration -> String -> String
appTransFromUnicode trans = 
  concat .
  map (\c -> maybe [toEnum c] id $ 
             Map.lookup c (trans_from_unicode trans)
      ) . 
  map fromEnum


mkTransliteration :: String -> [String] -> [Int] -> Transliteration
mkTransliteration name ts us = 
 Trans (Map.fromList (tzip ts us)) (Map.fromList (uzip us ts)) [] name
  where
    tzip ts us = [(t,u) | (t,u) <- zip ts us, t /= "-"]
    uzip us ts = [(u,t) | (u,t) <- zip us ts, t /= "-"]


transThai :: Transliteration
transThai = mkTransliteration "Thai" allTrans allCodes where
  allTrans = words $
    "-  k  k1 -  k2 -  k3 g  c  c1 c2 s' c3 y' d' t' " ++
    "t1 t2 t3 n' d  t  t4 t5 t6 n  b  p  p1 f  p2 f' " ++
    "p3 m  y  r  -  l  -  w  s- s. s  h  l' O  h' -  " ++
    "a. a  a: a+ i  i: v  v: u  u: -  -  -  -  -  -  " ++
    "e  e' o: a% a& L  R  S  T1 T2 T3 T4 K  -  -  -  " ++
    "N0 N1 N2 N3 N4 N5 N6 N7 N8 N9 -  -  -  -  -  -  "
  allCodes = [0x0e00 .. 0x0e7f]

{-
| e01 | ก | k | M
| e02 | ข | k1 | H
| e04 | ค | k2 |
| e06 | ฆ | k3 |
| e07 | ง | g |
| e08 | จ | c | M
| e09 | ฉ | c1 | H
| e0a | ช | c2 |
| e0b | ซ | s' |
| e0c | ฌ | c3 |
| e0d | ญ | y' |
| e0e | ฎ | d' | M
| e0f | ฏ | t' | M
| e10 | ฐ | t1 | H
| e11 | ฑ | t2 |
| e12 | ฒ | t3 |
| e13 | ณ | n' |
| e14 | ด | d | M
| e15 | ต | t | M
| e16 | ถ | t4 | H
| e17 | ท | t5 |
| e18 | ธ | t6 |
| e19 | น | n |
| e1a | บ | b | M
| e1b | ป | p | M
| e1c | ผ | p1 | H
| e1d | ฝ | f | H
| e1e | พ | p2 |
| e1f | ฟ | f' |
| e20 | ภ | p3 |
| e21 | ม | m |
| e22 | ย | y |
| e23 | ร | r |
| e25 | ล | l |
| e27 | ว | w |
| e28 | ศ | s- | H
| e29 | ษ | s. | H
| e2a | ส | s | H
| e2b | ห | h | H
| e2c | ฬ | l' |
| e2d | อ | O | M
| e2e | ฮ | h' |

| e30 | ะ | a. |
| e31 | ั | a |
| e32 | า | a: |
| e33 | ำ | a+ |
| e34 | ิ | i |
| e35 | ี | i: |
| e36 | ึ | v |
| e37 | ื | v: |
| e38 | ุ | u |
| e39 | ู | u: |
| e40 | เ | e |
| e41 | แ | e' |
| e42 | โ | o: |
| e43 | ใ | a% |
| e44 | ไ | a& |
| e45 | ๅ | L |
| e46 | ๆ | R |
| e47 | ็ | S |
| e48 | ่ | T1 |
| e49 | ้ | T2 |
| e4a | ๊ | T3 |
| e4b | ๋ | T4 |
| e4c | ์ | K |
| e50 | ๐ | N0 |
| e51 | ๑ | N1 |
| e52 | ๒ | N2 |
| e53 | ๓ | N3 |
| e54 | ๔ | N4 |
| e55 | ๕ | N5 |
| e56 | ๖ | N6 |
| e57 | ๗ | N7 |
| e58 | ๘ | N8 |
| e59 | ๙ | N9 |
-}