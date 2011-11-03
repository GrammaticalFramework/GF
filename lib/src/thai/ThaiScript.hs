module ThaiScript where

import Data.Char
import qualified Data.Map as Map

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

  TC {unicode = 3632, translit = "a.", cclass = Low, liveness = False, pronunc = "a.", pronunc_end = "a."},
  TC {unicode = 3633, translit = "a", cclass = Low, liveness = False, pronunc = "a", pronunc_end = "a"},
  TC {unicode = 3634, translit = "a:", cclass = Low, liveness = False, pronunc = "a:", pronunc_end = "a:"},
  TC {unicode = 3635, translit = "a+", cclass = Low, liveness = False, pronunc = "a+", pronunc_end = "a+"},
  TC {unicode = 3636, translit = "i", cclass = Low, liveness = False, pronunc = "i", pronunc_end = "i"},
  TC {unicode = 3637, translit = "i:", cclass = Low, liveness = False, pronunc = "i:", pronunc_end = "i:"},
  TC {unicode = 3638, translit = "v", cclass = Low, liveness = False, pronunc = "v", pronunc_end = "v"},
  TC {unicode = 3639, translit = "v:", cclass = Low, liveness = False, pronunc = "v:", pronunc_end = "v:"},
  TC {unicode = 3640, translit = "u", cclass = Low, liveness = False, pronunc = "u", pronunc_end = "u"},
  TC {unicode = 3641, translit = "u:", cclass = Low, liveness = False, pronunc = "u:", pronunc_end = "u:"},
  TC {unicode = 3648, translit = "e", cclass = Low, liveness = False, pronunc = "e", pronunc_end = "e"},
  TC {unicode = 3649, translit = "e'", cclass = Low, liveness = False, pronunc = "e'", pronunc_end = "e'"},
  TC {unicode = 3650, translit = "o:", cclass = Low, liveness = False, pronunc = "o:", pronunc_end = "o:"},
  TC {unicode = 3651, translit = "a%", cclass = Low, liveness = False, pronunc = "a%", pronunc_end = "a%"},
  TC {unicode = 3652, translit = "a&", cclass = Low, liveness = False, pronunc = "a&", pronunc_end = "a&"},
  TC {unicode = 3653, translit = "L", cclass = Low, liveness = False, pronunc = "L", pronunc_end = "L"},
  TC {unicode = 3654, translit = "R", cclass = Low, liveness = False, pronunc = "R", pronunc_end = "R"},
  TC {unicode = 3655, translit = "S", cclass = Low, liveness = False, pronunc = "S", pronunc_end = "S"},
  TC {unicode = 3656, translit = "T1", cclass = Low, liveness = False, pronunc = "T1", pronunc_end = "T1"},
  TC {unicode = 3657, translit = "T2", cclass = Low, liveness = False, pronunc = "T2", pronunc_end = "T2"},
  TC {unicode = 3658, translit = "T3", cclass = Low, liveness = False, pronunc = "T3", pronunc_end = "T3"},
  TC {unicode = 3659, translit = "T4", cclass = Low, liveness = False, pronunc = "T4", pronunc_end = "T4"},
  TC {unicode = 3660, translit = "K", cclass = Low, liveness = False, pronunc = "K", pronunc_end = "K"},
  TC {unicode = 3664, translit = "N0", cclass = Low, liveness = False, pronunc = "N0", pronunc_end = "N0"},
  TC {unicode = 3665, translit = "N1", cclass = Low, liveness = False, pronunc = "N1", pronunc_end = "N1"},
  TC {unicode = 3666, translit = "N2", cclass = Low, liveness = False, pronunc = "N2", pronunc_end = "N2"},
  TC {unicode = 3667, translit = "N3", cclass = Low, liveness = False, pronunc = "N3", pronunc_end = "N3"},
  TC {unicode = 3668, translit = "N4", cclass = Low, liveness = False, pronunc = "N4", pronunc_end = "N4"},
  TC {unicode = 3669, translit = "N5", cclass = Low, liveness = False, pronunc = "N5", pronunc_end = "N5"},
  TC {unicode = 3670, translit = "N6", cclass = Low, liveness = False, pronunc = "N6", pronunc_end = "N6"},
  TC {unicode = 3671, translit = "N7", cclass = Low, liveness = False, pronunc = "N7", pronunc_end = "N7"},
  TC {unicode = 3672, translit = "N8", cclass = Low, liveness = False, pronunc = "N8", pronunc_end = "N8"},
  TC {unicode = 3673, translit = "N9", cclass = Low, liveness = False, pronunc = "N9", pronunc_end = "N9"}
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

unchar :: String -> [String]
unchar s = case s of
  c:d:cs 
   | isAlpha d -> [c]    : unchar (d:cs)
   | isSpace d -> [c]:[d]: unchar cs
   | otherwise -> let (ds,cs2) = break (\x -> isAlpha x || isSpace x) cs in
                  (c:d:ds) : unchar cs2
  [_]          -> [s]
  _            -> []

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