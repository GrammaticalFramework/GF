module Main where

import Data.Char
import Data.List
import qualified Data.Map as Map
import System

-- convert all files *Tha.gf into *ThP.gf with "t" changed to (thpron "t" "p")

main = allThpron

allThpron = do
  System.system "ls *Tha*.gf ../api/*Tha*.gf >srcThai.txt"
  files <- readFile "srcThai.txt" >>= return . lines
  mapM_ fileThpron files
  return ()

fileThpron file = do
  s <- readFile file
  let tgt = appThpron file
  writeFile tgt (appThpron s)
  putStrLn ("wrote " ++ tgt)

-- thb = IPA Thai; not used in ISO-639-3 like Thp 
appThpron s = case s of
  '"':cs -> let (w,_:rest) = break (=='"') cs in mkThpron w ++ appThpron rest
  'T':'h':'a':'A':rest             -> "Thb" ++ appThpron rest  -- AllThaAbs
  'T':'h':'a':c:rest   | isAlpha c -> "Tha" ++ c : appThpron rest  -- Thank
  'T':'h':'a':rest -> "Thb" ++ appThpron rest
  c:cs -> c:appThpron cs
  _ -> s

mkThpron s = "(thpron \"" ++ s ++ "\" \"" ++ thai2pron s ++ "\")"


-- the following functions involving pron (=pronunciation) work on syllables

thai2pron  = uni2pron . thai2uni
trans2pron = uni2pron . trans2uni
trans2thai = uni2thai . trans2uni
trans2dat  = uni2dat  . trans2uni

thai2uni :: String -> [Int]
thai2uni = map fromEnum

uni2thai :: [Int] -> String
uni2thai = map toEnum

uni2pron :: [Int] -> String
uni2pron = dat2pron . uni2dat

uni2dat = map (maybe CR dat . (\u -> Map.lookup u uniMap))  --- CR as exception value

--high = accent '\x301'
--low  = accent '\x300'
--rising = accent '\x306'
--falling = accent '\x302'

dat2pron :: [ThaiDat] -> String
dat2pron is = case is of

-- exceptional words
 [Ce,Ck1,CaL]    -> "kha\x301w"
 [Cc1,Ca,Cn]     -> "cha\x301n"
 [CaE,Ch,Cm]     -> "m" ++ high "ay"
 [Ct,CT2,CO,Cg]  -> "t" ++ falling i_O ++ i_ng 
 [Ce,Cg,Ci,Cn]   -> i_ng ++ i_oe ++ "n"
 [CaE,Cd,CT2]    -> "d" ++ falling "aay"
 [Ce,Ck,CT2,CaL] -> "k" ++ falling "aaw"
 [CaE,Cm,CT2]    -> "m" ++ high "aay"
 [CO,Cy,CaL,Ck]  -> "y" ++ low "aak"
 [CO,Cy,CT1,CaL] -> "y" ++ low "aa"
 [CO,Cy,CT1,CaL,Cg] -> "y" ++ low "aa" ++ i_ng
 [CO,Cy,CT1,CuL] -> "y" ++ low "uu"
 [Cp3,Cr]        -> "phan" --- not in Smyth
 [Cp2,Cw,Ck]     -> "phw" ++ falling "ak" -- not in Smyth
 [Cc2,CvL,CT1,CO] -> "ch" ++ falling i_uue --- to get rid of final O
 [CO,Cg,CT1,Cu,Cn] -> low "a" ++ i_ng ++ low "un" --- probably there is a rule for leading vowelless O

-- words following the rules (mostly from Smyth's Essential Grammar)
 _ -> case getSyllable is of
  [Ce]  : cc : [] : d : cs | brev d -> prons cc ++ tone cc d cs "e"         ++ endWith cs  -- e-8  -> e
  [Ce'] : cc : [] : d : cs | brev d -> prons cc ++ tone cc d cs i_ae        ++ endWith cs  -- ä-8 -> ä
  [v]   :[CO]: []          : d : cs ->             tone[CO]d cs (pron v)    ++ endWith cs  -- e/ä/o/ay/ay
  [v]   : cc : []          : d : cs -> prons cc ++ tone cc d cs (pron v)    ++ endWith cs  -- e/ä/o/ay/ay
  [Ce]  : cc : [Cy]        : d : cs -> prons cc ++ tone cc d cs (i_ooe++"y")++ endWith cs  -- e-y  -> ööy
  [Ce]  : cc : [CO]        : d : cs -> prons cc ++ tone cc d cs i_ooe       ++ endWith cs  -- e-O  -> öö
  [Ce]  : cc : [CO,CaP]    : d : cs -> prons cc ++ tone cc d cs i_oe        ++ endWith cs  -- e-Oa -> ö
  [Ce]  : cc : [CaP]       : d : cs -> prons cc ++ tone cc d cs "e"         ++ endWith cs  -- e-a
  [Ce]  : cc : [CaL]       : d : cs -> prons cc ++ tone cc d cs "aw"        ++ endWith cs  -- e-a
  [Ce]  : cc : [CaL,CaP]   : d : cs -> prons cc ++ tone cc d cs i_O         ++ endWith cs  -- e-Aa -> O
  [Ce]  : cc : [Ci]        : d : cs -> prons cc ++ tone cc d cs i_ooe       ++ endWith cs  -- e-i  -> öö
  [Ce]  : cc : [CiL,Cy]    : d : cs -> prons cc ++ tone cc d cs "ia"        ++ endWith cs  -- e-iiy-> ia
  [Ce]  : cc : [Ci,Cy,CaP] : d : cs -> prons cc ++ tone cc d cs "ia"        ++ endWith cs  -- e-iya-> ia
  [Ce]  : cc : [CiL,CO]    : d : cs -> prons cc ++ tone cc d cs "ia"        ++ endWith cs  -- e-iiO-> üa
  [Ce]  : cc : [CvL,CO]    : d : cs -> prons cc ++ tone cc d cs (i_ue++"a") ++ endWith cs  -- e-vvO-> üa
  [Ce]  : cc : [CvL,CO,Cy] : d : cs -> prons cc ++ tone cc d cs (i_ue++"ay")++ endWith cs  -- e-vvOy-> üay
  [Ce'] : cc : [CaP]       : d : cs -> prons cc ++ tone cc d cs i_ae        ++ endWith cs  -- ä-a -> ä
  [CoL] : cc : [CaP]       : d : cs -> prons cc ++ tone cc d cs "o"         ++ endWith cs  -- o-a -> o
  []    :[CO]: v           : d : cs ->             tone[CO]d cs (prons v)   ++ endWith cs  -- Ov  -> v
  []    : cc : [Ca,Cw]     : d : cs -> prons cc ++ tone cc d cs "ua"        ++ endWith cs  -- Caw -> Cua
  []    : cc : v           :[CK]:cs -> endWith cs                                          -- swas(di:K)
  []    : bb : [] : cc : []: d : cs -> prons bb ++ "a" ++ prons cc ++ tone cc [] cs "o" ++ endWith (d:cs) -- CaCoC
  []    : bb : [] : cc : []         -> prons bb ++                    tone bb [] [cc] "o" ++ endWith [cc]  -- CoC
  []    : bb : [] : cc : v : d : cs -> prons bb ++ "a" ++ prons cc ++ tone cc [] cs (prons v) ++ endWith cs -- CaCvC
  []    : cc : v           : d : cs -> prons cc ++ tone cc d cs (prons v)               ++ endWith cs  -- Cv- (normal)

  _ -> prons is --- shouldn't happen

 where
   prons cc = case cc of
     _ :CK:cs -> prons cs -- killer 
     Ch:c:cs | isConsonant c -> concatMap pron (c:cs) -- hC, ---- only some conss
     _       -> concatMap pron cc
   endWith ss = case concat ss of
     _:CK:cs  -> dat2pron cs
     c   :cs  -> enc c ++ dat2pron cs
     _        -> []

   enc  c = lookThai [] enp c
   pron c = lookThai [] pro c
   brev d = elem CS d  -- shortener

getSyllable :: [ThaiDat] -> [[ThaiDat]]  -- (V?),(C|CC|hC),(V*),(D*),(C*),[[],C]?
getSyllable s = case s of
  v:cs | isPreVowel v -> [v]:getCons v cs
  []  -> []
  c:_ -> []:getCons c s
 where
   getCons v s = case s of
     Ch:c:cs     | isConsonant c && isLow c -> let (cc:ccs) = getCons v (c:cs) in (Ch:cc):ccs -- hC
     CO:cs                                  -> [CO]  :getVow v cs      -- O
     Cs:Cr:cs                               -> [Cs]  :getVow v cs      -- sr -> s
     _:CK:[]                                -> []
     b:Cr:Cr:[]  | isConsonant b            -> [b]   :[Ca]:[]:[Cr]:[]  -- Crr  -> Can
     b:Cr:Cr:[c] | all isConsonant [b,c]    -> [b]   :[Ca]:[]:[c]:[]   -- CrrC -> CaC  
     b:c:cs      | isCluster b c            -> [b,c] :getVow v cs      -- C(l|r|w) cluster
     b:cs        | isPreVowel v             -> [b]   :getVow v cs
     b:c:Cw:Cy:[]| isConsonant b && isDiacritic c -> [b]:[Cu,Ca]:[c]:[Cy]:[] -- CTuay
     b:Cw:Cy:[]  | isConsonant b            -> [b]   :[Cu,Ca]:[]:[Cy]:[] -- Cuay
     b:c:d:[]    | all isConsonant [b,c,d]  -> [b]   :[]:[c]:[]:[d]:[] -- CaCoC
     b:c:[]      | all isConsonant [b,c]    -> [b]   :[]:[c]:[]        -- CoC
     b:c:cs      | all isConsonant [b,c]    -> [b]   :[]:[c]:getVow c cs -- CaCvC
     b:cs        | isConsonant b            -> [b]   :getVow v cs      -- C
     _ -> [s] --- shouldn't happen ??
   getVow v0 s = case span (\x -> inVow v0 x || isDiacritic x) s of
     (v,c:cs) -> let (d,w) = partition isDiacritic v in w:d:[c]:getSyllable cs
     (v,_)    -> let (d,w) = partition isDiacritic v in [w,d]
   inVow v0 x = isInVowel x || case v0 of
     Ce -> elem x [Cy]  -- after e-, also y is a part of a vowel
     _  -> False --- elem x [Cw]
   isLow c = lookThai Low ccl c == Low

isCluster b c = 
      (pronTha c == "r"  && elem (pronTha b) ["k","kh","p","ph","t"])
   || (pronTha c == "ri" && elem (pronTha b) ["k","kh","p","ph","t"])
   || (pronTha c == "l" && elem (pronTha b) ["k","kh","p","ph"])
   || (pronTha c == "w" && elem (pronTha b) ["k","kh"])

pronTha c = lookThai [] pro c

isInVowel :: ThaiDat -> Bool
isInVowel v  = (CaP <= v && v <= CuL) || v == CO -- infix vowels

isPreVowel :: ThaiDat -> Bool
isPreVowel i = Ce <= i && i <= CaE

isVowel :: ThaiDat -> Bool
isVowel i = CaP <= i && i <= CaE

isConsonant :: ThaiDat -> Bool
isConsonant i = Ck <= i && i <= Ch' && i /= CO

isDiacritic :: ThaiDat -> Bool
isDiacritic i = CS <= i && i <= CK

tone :: [ThaiDat] -> [ThaiDat] -> [[ThaiDat]] -> String -> String
tone cc@(c:_) d cs v = case (lookThai Low ccl c, isLive cs1, toneMark d) of
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
tone _ _ _ v = mid v

toneMark :: [ThaiDat] -> Int
toneMark is = case is of
  CT1:is -> 1
  CT2:is -> 2
  CT3:is -> 3
  CT4:is -> 4
  _  :is -> toneMark is
  _      -> 0  -- no tone mark in is

isLong :: String -> Bool
isLong s = case s of
  'i':'a':_   -> True
  'u':'a':_   -> True
  '\x289':a:_ -> True     -- uea
  c:d:_ | c == d -> True  --- must be vowels
  _:cs           -> isLong cs
  _ -> False 

isLive :: [ThaiDat] -> Bool
isLive is = case is of
  [i] -> lookThai False liv i
  []  -> True
  _   -> False

mid, high, low, falling, rising :: String -> String
mid s = s
high = accent '\x301'
low  = accent '\x300'
rising = accent '\x306'
falling = accent '\x302'

accent a s = case s of
  c:cs -> c:a:cs
  _ -> s

trans2uni :: String -> [Int]
trans2uni = 
  map (\c -> maybe 0 id $ Map.lookup c trans) . 
  unchar
 where
  trans = Map.fromList [(tra c, uni c) | c <- allThaiChars]
  
unchar :: String -> [String]  
unchar s = case s of
    c:d:cs 
     | isAlpha d -> [c]    : unchar (d:cs)
     | isSpace d -> [c]:[d]: unchar cs
     | otherwise -> let (ds,cs2) = break (\x -> isAlpha x || isSpace x) cs in
                    (c:d:ds) : unchar cs2
    [_]          -> [s]
    _            -> []


thaiMap :: Map.Map ThaiDat ThaiChar
thaiMap = Map.fromList [(dat c,c) | c <- allThaiChars]

uniMap :: Map.Map Int ThaiChar
uniMap  = Map.fromList [(uni c,c) | c <- allThaiChars]

lookThai :: a -> (ThaiChar -> a) -> ThaiDat -> a
lookThai v f i = maybe v f (Map.lookup i thaiMap)

data ThaiChar = TC {
  dat :: ThaiDat,
  uni :: Int,
  tra :: String,
  ccl :: CClass,
  liv :: Bool,
  pro :: String,
  enp :: String
  }
  deriving Show

data CClass = Low | Mid | High
  deriving (Show, Eq)

-- IPA sounds
i_ng = "\331"
i_O  = "\596"
i_ue = "\x289"
i_ae = "\x25b"
i_oe = "\601"
i_ooe = i_oe ++ i_oe
i_uue = i_ue ++ i_ue
i_aae = i_ae ++ i_ae
i_OO  = i_O  ++ i_O

allThaiChars :: [ThaiChar]
allThaiChars = [
  TC {dat = Ck,  uni = 3585, tra = "k", ccl = Mid, liv = False, pro = "k", enp = "k"},
  TC {dat = Ck1, uni = 3586, tra = "k1", ccl = High, liv = False, pro = "kh", enp = "k"},
  TC {dat = Ck2, uni = 3588, tra = "k2", ccl = Low, liv = False, pro = "kh", enp = "k"},
  TC {dat = Ck3, uni = 3590, tra = "k3", ccl = Low, liv = False, pro = "kh", enp = "k"},
  TC {dat = Cg,  uni = 3591, tra = "g", ccl = Low, liv = True, pro = i_ng, enp = i_ng},
  TC {dat = Cc,  uni = 3592, tra = "c", ccl = Mid, liv = False, pro = "c", enp = "t"},
  TC {dat = Cc1, uni = 3593, tra = "c1", ccl = High, liv = False, pro = "ch", enp = "t"},
  TC {dat = Cc2, uni = 3594, tra = "c2", ccl = Low, liv = False, pro = "ch", enp = "t"},
  TC {dat = Cs', uni = 3595, tra = "s'", ccl = Low, liv = False, pro = "s", enp = "t"},
  TC {dat = Cc3, uni = 3596, tra = "c3", ccl = Low, liv = False, pro = "ch", enp = "t"},
  TC {dat = Cy', uni = 3597, tra = "y'", ccl = Low, liv = False, pro = "y", enp = "n"},
  TC {dat = Cd', uni = 3598, tra = "d'", ccl = Mid, liv = False, pro = "d", enp = "t"},
  TC {dat = Ct', uni = 3599, tra = "t'", ccl = Mid, liv = False, pro = "t", enp = "t"},
  TC {dat = Ct1, uni = 3600, tra = "t1", ccl = High, liv = False, pro = "th", enp = "t"},
  TC {dat = Ct2, uni = 3601, tra = "t2", ccl = Low, liv = False, pro = "th", enp = "t"},
  TC {dat = Ct3, uni = 3602, tra = "t3", ccl = Low, liv = False, pro = "th", enp = "t"},
  TC {dat = Cn', uni = 3603, tra = "n'", ccl = Low, liv = True, pro = "n", enp = "n"},
  TC {dat = Cd,  uni = 3604, tra = "d", ccl = Mid, liv = False, pro = "d", enp = "t"},
  TC {dat = Ct,  uni = 3605, tra = "t", ccl = Mid, liv = False, pro = "t", enp = "t"},
  TC {dat = Ct4, uni = 3606, tra = "t4", ccl = High, liv = False, pro = "th", enp = "t"},
  TC {dat = Ct5, uni = 3607, tra = "t5", ccl = Low, liv = False, pro = "th", enp = "t"},
  TC {dat = Ct6, uni = 3608, tra = "t6", ccl = Low, liv = False, pro = "th", enp = "t"},
  TC {dat = Cn,  uni = 3609, tra = "n", ccl = Low, liv = True, pro = "n", enp = "n"},
  TC {dat = Cb,  uni = 3610, tra = "b", ccl = Mid, liv = False, pro = "b", enp = "p"},
  TC {dat = Cp,  uni = 3611, tra = "p", ccl = Mid, liv = False, pro = "p", enp = "p"},
  TC {dat = Cp1, uni = 3612, tra = "p1", ccl = High, liv = False, pro = "ph", enp = "p"},
  TC {dat = Cf,  uni = 3613, tra = "f", ccl = High, liv = False, pro = "f", enp = "p"},
  TC {dat = Cp2, uni = 3614, tra = "p2", ccl = Low, liv = False, pro = "ph", enp = "p"},
  TC {dat = Cf', uni = 3615, tra = "f'", ccl = Low, liv = False, pro = "f", enp = "p"},
  TC {dat = Cp3, uni = 3616, tra = "p3", ccl = Low, liv = False, pro = "ph", enp = "p"},
  TC {dat = Cm,  uni = 3617, tra = "m", ccl = Low, liv = True, pro = "m", enp = "m"},
  TC {dat = Cy,  uni = 3618, tra = "y", ccl = Low, liv = True, pro = "y", enp = "y"},
  TC {dat = Cr,  uni = 3619, tra = "r", ccl = Low, liv = True, pro = "r", enp = "n"},
  TC {dat = Cl,  uni = 3621, tra = "l", ccl = Low, liv = True, pro = "l", enp = "n"},
  TC {dat = Cw,  uni = 3623, tra = "w", ccl = Low, liv = True, pro = "w", enp = "w"},
  TC {dat = CsM, uni = 3624, tra = "s-", ccl = High, liv = False, pro = "s", enp = "t"},
  TC {dat = CsP, uni = 3625, tra = "s.", ccl = High, liv = False, pro = "s", enp = "t"},
  TC {dat = Cs,  uni = 3626, tra = "s", ccl = High, liv = False, pro = "s", enp = "t"},
  TC {dat = Ch,  uni = 3627, tra = "h", ccl = High, liv = True, pro = "h", enp = ""},
  TC {dat = Cl,  uni = 3628, tra = "l'", ccl = Low, liv = True, pro = "l", enp = "n"},
  TC {dat = CO,  uni = 3629, tra = "O", ccl = Mid, liv = True, pro = i_OO, enp = i_OO},
  TC {dat = Ch', uni = 3630, tra = "h'", ccl = Low, liv = True, pro = "h", enp = ""},

  TC {dat = CaP, uni = 3632, tra = "a.", ccl = Low, liv = False, pro = "a", enp = "a"},
  TC {dat = Ca,  uni = 3633, tra = "a",  ccl = Low, liv = False, pro = "a", enp = "a"},
  TC {dat = CaL, uni = 3634, tra = "a:", ccl = Low, liv = True, pro = "aa", enp = "aa"},
  TC {dat = Cam, uni = 3635, tra = "a+", ccl = Low, liv = True, pro = "am", enp = "am"},
  TC {dat = Ci,  uni = 3636, tra = "i",  ccl = Low, liv = False, pro = "i", enp = "i"},
  TC {dat = CiL, uni = 3637, tra = "i:", ccl = Low, liv = True, pro = "ii", enp = "ii"},
  TC {dat = Cv,  uni = 3638, tra = "v",  ccl = Low, liv = False, pro = i_ue, enp = i_ue},
  TC {dat = CvL, uni = 3639, tra = "v:", ccl = Low, liv = True,  pro = i_uue, enp = i_uue},
  TC {dat = Cu,  uni = 3640, tra = "u",  ccl = Low, liv = False, pro = "u", enp = "u"},
  TC {dat = CuL, uni = 3641, tra = "u:", ccl = Low, liv = True, pro = "uu", enp = "uu"},
  TC {dat = Ce,  uni = 3648, tra = "e",  ccl = Low, liv = True, pro = "ee", enp = "ee"},
  TC {dat = Ce', uni = 3649, tra = "e'", ccl = Low, liv = True, pro = i_aae, enp = i_aae},
  TC {dat = CoL, uni = 3650, tra = "o:", ccl = Low, liv = True, pro = "oo", enp = "oo"},
  TC {dat = CaH, uni = 3651, tra = "a%", ccl = Low, liv = True, pro = "ay", enp = "ay"},
  TC {dat = CaE, uni = 3652, tra = "a&", ccl = Low, liv = True, pro = "ay", enp = "ay"},
  TC {dat = CL,  uni = 3653, tra = "L",  ccl = Low, liv = True, pro = "li", enp = "n"},
  TC {dat = CR,  uni = 3654, tra = "R",  ccl = Low, liv = True, pro = "ri", enp = "n"},
  TC {dat = CS,  uni = 3655, tra = "S",  ccl = Low, liv = True, pro = "", enp = ""},
  TC {dat = CT1, uni = 3656, tra = "T1", ccl = Low, liv = True, pro = "", enp = ""},
  TC {dat = CT2, uni = 3657, tra = "T2", ccl = Low, liv = True, pro = "", enp = ""},
  TC {dat = CT3, uni = 3658, tra = "T3", ccl = Low, liv = True, pro = "", enp = ""},
  TC {dat = CT4, uni = 3659, tra = "T4", ccl = Low, liv = True, pro = "", enp = ""},
  TC {dat = CK,  uni = 3660, tra = "K",  ccl = Low, liv = True, pro = "", enp = ""},
  TC {dat = CN0, uni = 3664, tra = "N0", ccl = Low, liv = False, pro = "0", enp = "0"},
  TC {dat = CN1, uni = 3665, tra = "N1", ccl = Low, liv = False, pro = "1", enp = "1"},
  TC {dat = CN2, uni = 3666, tra = "N2", ccl = Low, liv = False, pro = "2", enp = "2"},
  TC {dat = CN3, uni = 3667, tra = "N3", ccl = Low, liv = False, pro = "3", enp = "3"},
  TC {dat = CN4, uni = 3668, tra = "N4", ccl = Low, liv = False, pro = "4", enp = "4"},
  TC {dat = CN5, uni = 3669, tra = "N5", ccl = Low, liv = False, pro = "5", enp = "5"},
  TC {dat = CN6, uni = 3670, tra = "N6", ccl = Low, liv = False, pro = "6", enp = "6"},
  TC {dat = CN7, uni = 3671, tra = "N7", ccl = Low, liv = False, pro = "7", enp = "7"},
  TC {dat = CN8, uni = 3672, tra = "N8", ccl = Low, liv = False, pro = "8", enp = "8"},
  TC {dat = CN9, uni = 3673, tra = "N9", ccl = Low, liv = False, pro = "9", enp = "9"}
 ]

data ThaiDat =
  Ck  | Ck1 | Ck2 | Ck3 | Cg  | Cc  | Cc1 | Cc2 | Cs' | 
  Cc3 | Cy' | Cd' | Ct' | Ct1 | Ct2 | Ct3 | Cn' | Cd  | 
  Ct  | Ct4 | Ct5 | Ct6 | Cn  | Cb  | Cp  | Cp1 | Cf  | 
  Cp2 | Cf' | Cp3 | Cm  | Cy  | Cr  | Cl  | Cw  | CsM |
  CsP | Cs  | Ch  | Cl' | CO  | Ch' | CaP | Ca  | CaL |
  Cam | Ci  | CiL | Cv  | CvL | Cu  | CuL | Ce  | Ce' |
  CoL | CaH | CaE | CL  | CR  | CS  | CT1 | CT2 | CT3 |
  CT4 | CK  | CN0 | CN1 | CN2 | CN3 | CN4 | CN5 | CN6 |
  CN7 | CN8 | CN9
 deriving (Eq,Ord,Show)

-- testing with Wikipedia Swadesh list

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


-- heuristics for finding syllables - unreliable, unfinished
uniSyllables :: [ThaiDat] -> [[ThaiDat]]
uniSyllables = reverse . (syll [] []) where
  syll sys sy is = case is of
    c:cs | isPreVowel c -> new [] is
    c:d:cs | isConsonant c && isConsonant d -> new [c] (d:cs) ---- no consonant clusters
    c:cs -> continue [c] cs ---- more rules to follow 
    _ -> sy:sys
   where
    new old = syll ((sy ++ old) : sys) []
    continue old = syll sys (sy ++ old)


