module ThaiScript where

import Data.Char
import Data.List
import qualified Data.Map as Map

testFile   = "src/test.txt"
resultFile = "src/results.txt"

test = do
  s <- readFile testFile
  writeFile resultFile []
  mapM_ (testOne . tabs) $ lines s

testOne ws = case ws of
  m:t:p:r:_ -> appendFile resultFile $ concat [mn,"\t",t,"\t",p,"\t",r,"\t",result,"\n"] where
                   result = unwords (intersperse "," (map thai2pron (filter (/=",") (words t))))
                   mn = if result == r 
                      then m
                      else if result == p then (m ++ "+") else (m ++ "-") 
  _ -> return ()

testOneS ws = case ws of
  m:t:p:r:_ -> appendFile resultFile $ concat [m,"\t",t,"\t",pn,"\t",r,"\n"] where
                   result = unwords (intersperse "," (map thai2pron (filter (/=",") (words t))))
                   pn = if m == "+" 
                      then r
                      else p
  _ -> return ()

tabs s = case break (=='\t') s of
  ([], _:ws) -> tabs ws
  (w , _:ws) -> w:tabs ws
  _ -> [s]

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
uni2pron is = case getSyllable is of

-- diph order as in Smyth, p. 15
  [0xe40] : cc : []   : d : cs | kill d -> prons cc ++ tone cc d cs "e"         ++ endWith cs  -- e-8  -> e
  [0xe41] : cc : []   : d : cs | kill d -> prons cc ++ tone cc d cs "\x25b"     ++ endWith cs  -- ä-8 -> ä
  [v]     : cc : []            : d : cs -> prons cc ++ tone cc d cs (pron v)    ++ endWith cs  -- e/ä/o/ay/ay
  [0xe40] : cc : [0xe22]       : d : cs -> prons cc ++ tone cc d cs "\601\601y" ++ endWith cs  -- e-y  -> ööy
  [0xe40] : cc : [0xe2d]       : d : cs -> prons cc ++ tone cc d cs "\601\601"  ++ endWith cs  -- e-O  -> öö
  [0xe40] : cc : [0xe2d,0xe30] : d : cs -> prons cc ++ tone cc d cs "\601"      ++ endWith cs  -- e-Oa -> ö
  [0xe40] : cc : [0xe30]       : d : cs -> prons cc ++ tone cc d cs "e"         ++ endWith cs  -- e-a
  [0xe40] : cc : [0xe32]       : d : cs -> prons cc ++ tone cc d cs "aw"        ++ endWith cs  -- e-a
  [0xe40] : cc : [0xe32,0xe30] : d : cs -> prons cc ++ tone cc d cs "\596"      ++ endWith cs  -- e-Aa -> O
  [0xe40] : cc : [0xe34]       : d : cs -> prons cc ++ tone cc d cs "\601\601"  ++ endWith cs  -- e-i  -> öö
  [0xe40] : cc : [0xe35,0xe22] : d : cs -> prons cc ++ tone cc d cs "ia"        ++ endWith cs  -- e-iiy-> ia
  [0xe40] : cc : [0xe34,0xe22,0xe30] : d : cs -> prons cc ++ tone cc d cs "ia"  ++ endWith cs  -- e-iya-> ia
  [0xe40] : cc : [0xe35,0xe2d] : d : cs -> prons cc ++ tone cc d cs "\x289a"    ++ endWith cs  -- e-iiO-> üa
--[0xe40] : cc : [0xe37,0xe2d] : d : cs -> prons cc ++ tone cc d cs "\649\649"  ++ endWith cs

  [0xe41] : cc : [0xe30]       : d : cs -> prons cc ++ tone cc d cs "\x25b"     ++ endWith cs  -- ä-a -> ä
  [0xe42] : cc : [0xe30]       : d : cs -> prons cc ++ tone cc d cs "o"         ++ endWith cs  -- o-a -> o
  []      : [0xe2d] : v        : d : cs ->          tone [0xe2d] d cs (prons v) ++ endWith cs  -- Ov  -> v
  []      : cc : [0xe31,0xe27] : d : cs -> prons cc ++ tone cc d cs "ua"        ++ endWith cs  -- Caw -> Cua
  []      : bb : [] : cc : []  : d : cs -> prons bb ++ "a" ++ prons cc ++ tone cc [] cs "o" ++ endWith cs    -- CaCoC
  []      : bb : [] : cc : []       ->                         prons bb ++ "o"       ++ endWith [cc]  -- CoC
  []      : cc : v             : d : cs -> prons cc ++ tone cc d cs (prons v)   ++ endWith cs  -- Cv- (normal)

  _ -> prons is --- shouldn't happen

 where
   prons cc = case cc of
     c:0xe4c:cs -> prons cs 
     0xe2b:c:cs | isConsonant c -> concatMap pron (c:cs) ---- only some conss
     _       -> concatMap pron cc
   endWith ss = case ss of
     (c:cs) -> encs c ++ uni2pron (concat cs)
     _   -> []
   encs cs = case cs of
     [] -> []
     _ -> prons (init cs) ++ enc (last cs)

   enc  c = lookThai [] pronunc_end c
   pron c = lookThai [] pronunc c
   kill d = elem 0xe47 d

getSyllable :: [Int] -> [[Int]]  -- (V?),(C|CC|hC),(V*),(D*),(C*),[[],C]?
getSyllable s = case s of
  v:cs | preVowel v -> [v]:getCons v cs
  []  -> []
  c:_ -> []:getCons c s
 where
   getCons v s = case s of
     b:c:cs   | b == 0xe2b    && isConsonant c                  -> [b,c]:getVow v cs      -- hC
     b:cs     | b == 0xe2d                                      -> [b]  :getVow v cs      -- O
     b:c:cs   | isConsonant b && (elem c [0xe23, 0xe25, 0xe27]) -> [b,c]:getVow v cs      -- C(l|r|w) cluster
     b:c:d:[] | isConsonant b && isConsonant c && isConsonant d -> [b]  :[]:[c]:[]:[d]:[] -- CaCoC
     b:c:[]   | isConsonant b && isConsonant c                  -> [b]  :[]:[c]:[]        -- CoC
     b:cs     | isConsonant b                                   -> [b]  :getVow v cs      -- C
     _ -> [s] --- shouldn't happen ??
   getVow v0 s = case span (\x -> inVow v0 x || diacritic x) s of
     (v,c:cs) -> let (d,w) = partition diacritic v in w:d:[c]:getSyllable cs
     (v,_) -> let (d,w) = partition diacritic v in [w,d]
   inVow v0 x = inVowel x || case v0 of
     0xe40 -> elem x [0xe22]  -- after e-, also y is a part of a vowel
     _ -> False

inVowel  v  = (0xe30 <= v && v <= 0xe39) || v == 0xe2d -- infix vowels
preVowel v  = 0xe40 <= v && v <= 0xe44  -- prefix vowels
diacritic x = 0xe47 <= x && x <= 0xe4d  -- tones, killers

tone :: [Int] -> [Int] -> [[Int]] -> String -> String
tone cc@(c:_) d cs v = case (lookThai Low cclass c, isLive cs1, toneMark d) of
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
 where
  cs1 = concat (take 1 cs)

toneMark :: [Int] -> Int
toneMark is = case is of
  0xe48:is -> 1
  0xe49:is -> 2
  0xe4a:is -> 3
  0xe4b:is -> 4
  _:is -> toneMark is
  _ -> 0  -- no tone mark in is

isLong :: String -> Bool
isLong s = case s of
  'i':'a':_ -> True
  'u':'a':_ -> True
  '\x289':a:_ -> True
  c:d:_ | c == d -> True  --- must be vowels
  _:cs           -> isLong cs
  _ -> False 

isLive :: [Int] -> Bool
isLive is = case is of
  [i] -> lookThai False liveness i
  [] -> True
  _  -> False

mid, high, low, falling, rising :: String -> String
mid s = s
high = accent '\x301'
low  = accent '\x300'
rising = accent '\x306'
falling = accent '\x302'

accent a s = case s of
  c:cs -> c:a:cs
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
  TC {unicode = 3591, translit = "g", cclass = Low, liveness = True, pronunc = "\331", pronunc_end = "\331"},
  TC {unicode = 3592, translit = "c", cclass = Mid, liveness = False, pronunc = "c", pronunc_end = "t"},
  TC {unicode = 3593, translit = "c1", cclass = High, liveness = False, pronunc = "ch", pronunc_end = "t"},
  TC {unicode = 3594, translit = "c2", cclass = Low, liveness = False, pronunc = "ch", pronunc_end = "t"},
  TC {unicode = 3595, translit = "s'", cclass = Low, liveness = False, pronunc = "s", pronunc_end = "t"},
  TC {unicode = 3596, translit = "c3", cclass = Low, liveness = False, pronunc = "ch", pronunc_end = "t"},
  TC {unicode = 3597, translit = "y'", cclass = Low, liveness = False, pronunc = "y", pronunc_end = "n"},
  TC {unicode = 3598, translit = "d'", cclass = Mid, liveness = False, pronunc = "d", pronunc_end = "t"},
  TC {unicode = 3599, translit = "t'", cclass = Mid, liveness = False, pronunc = "t", pronunc_end = "t"},
  TC {unicode = 3600, translit = "t1", cclass = High, liveness = False, pronunc = "th", pronunc_end = "t"},
  TC {unicode = 3601, translit = "t2", cclass = Low, liveness = False, pronunc = "th", pronunc_end = "t"},
  TC {unicode = 3602, translit = "t3", cclass = Low, liveness = False, pronunc = "th", pronunc_end = "t"},
  TC {unicode = 3603, translit = "n'", cclass = Low, liveness = True, pronunc = "n", pronunc_end = "n"},
  TC {unicode = 3604, translit = "d", cclass = Mid, liveness = False, pronunc = "d", pronunc_end = "t"},
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
  TC {unicode = 3624, translit = "s-", cclass = High, liveness = False, pronunc = "s", pronunc_end = "t"},
  TC {unicode = 3625, translit = "s.", cclass = High, liveness = False, pronunc = "s", pronunc_end = "t"},
  TC {unicode = 3626, translit = "s", cclass = High, liveness = False, pronunc = "s", pronunc_end = "t"},
  TC {unicode = 3627, translit = "h", cclass = High, liveness = True, pronunc = "h", pronunc_end = ""},
  TC {unicode = 3628, translit = "l'", cclass = Low, liveness = True, pronunc = "l", pronunc_end = "n"},
  TC {unicode = 3629, translit = "O", cclass = Mid, liveness = True, pronunc = "\596\596", pronunc_end = "\596\596"},
  TC {unicode = 3630, translit = "h'", cclass = Low, liveness = True, pronunc = "h", pronunc_end = ""},

  TC {unicode = 3632, translit = "a.", cclass = Low, liveness = False, pronunc = "a", pronunc_end = "a"},
  TC {unicode = 3633, translit = "a", cclass = Low, liveness = False, pronunc = "a", pronunc_end = "a"},
  TC {unicode = 3634, translit = "a:", cclass = Low, liveness = True, pronunc = "aa", pronunc_end = "aa"},
  TC {unicode = 3635, translit = "a+", cclass = Low, liveness = True, pronunc = "am", pronunc_end = "am"},
  TC {unicode = 3636, translit = "i", cclass = Low, liveness = False, pronunc = "i", pronunc_end = "i"},
  TC {unicode = 3637, translit = "i:", cclass = Low, liveness = True, pronunc = "ii", pronunc_end = "ii"},
  TC {unicode = 3638, translit = "v", cclass = Low, liveness = False, pronunc = "\x289", pronunc_end = "\x289"},
  TC {unicode = 3639, translit = "v:", cclass = Low, liveness = True, pronunc = "\x289\x289", pronunc_end = "\x289\x289"},
  TC {unicode = 3640, translit = "u", cclass = Low, liveness = False, pronunc = "u", pronunc_end = "u"},
  TC {unicode = 3641, translit = "u:", cclass = Low, liveness = True, pronunc = "uu", pronunc_end = "uu"},
  TC {unicode = 3648, translit = "e", cclass = Low, liveness = True, pronunc = "ee", pronunc_end = "ee"},
  TC {unicode = 3649, translit = "e'", cclass = Low, liveness = True, pronunc = "\x25b\x25b", pronunc_end = "0x25b\x25b"},
  TC {unicode = 3650, translit = "o:", cclass = Low, liveness = True, pronunc = "oo", pronunc_end = "oo"},
  TC {unicode = 3651, translit = "a%", cclass = Low, liveness = True, pronunc = "ay", pronunc_end = "ay"},
  TC {unicode = 3652, translit = "a&", cclass = Low, liveness = True, pronunc = "ay", pronunc_end = "ay"},
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



{-
uni2pron :: [Int] -> String
uni2pron is = case is of
  0xe40:c:0xe34      :cs -> pron c ++ tone c cs "\601\601" ++ uni2pron cs
  0xe40:c:0xe35:0xe22:cs -> pron c ++ tone c cs "iia"      ++ uni2pron cs
  0xe40:c:0xe37:0xe2d:cs -> pron c ++ tone c cs "\649\649" ++ uni2pron cs
  0xe40:c:0xe47      :cs -> pron c ++ tone c cs "e"        ++ uni2pron cs
  0xe41:c:0xe47      :cs -> pron c ++ tone c cs "\x25b"    ++ uni2pron cs

  v:0xe2b:c:cs | bvow v && isConsonant c  
                         -> pron c ++ tone 0xe2b cs (pron v) ++ uni2pron cs  -- h-
  v:b:c:cs | clust b c && bvow v                                             -- kr- etc
                         -> pron b ++ pron c ++ tone b (c:cs) (pron v) ++ uni2pron cs
  v:c:cs | bvow v        -> pron c ++ tone c cs (pron v)   ++ uni2pron cs  -- e .. ay

  c:0xe31:0xe27:cs       -> pron c ++ tone c cs "ua"      ++ uni2pron cs

  0xe2b:c:v:cs | isConsonant c && cvow v  
                         -> pron c ++ tone 0xe2b cs (pron v) ++ uni2pron cs  -- h-
  b:c:v:cs | clust b c && cvow v                                             -- kr- etc
                         -> pron b ++ pron c ++ tone b (c:cs) (pron v) ++ uni2pron cs
  0xe2d:v:cs   | cvow v  ->           tone 0xe2d cs (pron v) ++ uni2pron cs  -- O-
  c:v:cs       | cvow v  -> pron c ++ tone c     cs (pron v) ++ uni2pron cs  -- a .. u:

  [c] -> enc c
  c:cs -> pron c ++ uni2pron cs  --- shouldn't happen if syllabified ??
  [] -> []
 where
   enc  c = lookThai [] pronunc_end c
   pron c = lookThai [] pronunc c
   cvow v = (0xe30 <= v && v <= 0xe39) || v == 0xe2d -- central vowels
   bvow v = 0xe40 <= v && v <= 0xe44  -- begin vowels
   clust b c = isConsonant b && (elem c [0xe23, 0xe25, 0xe27])
-}
