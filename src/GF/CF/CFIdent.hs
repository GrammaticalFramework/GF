module CFIdent where

import Operations
import GFC
import Ident
import AbsGFC
import PrGrammar
import Str
import Char (toLower, toUpper)

-- symbols (categories, functions) for context-free grammars.

-- these types should be abstract

data CFTok = 
   TS String     -- normal strings
 | TC String     -- strings that are ambiguous between upper or lower case
 | TL String     -- string literals
 | TI Int        -- integer literals
 | TV Ident      -- variables
 | TM Int String -- metavariables; the integer identifies it
  deriving (Eq, Ord, Show)

newtype CFCat = CFCat (CIdent,Label) deriving (Eq, Ord, Show)

tS, tC, tL, tI, tV, tM :: String -> CFTok
tS  = TS
tC  = TC
tL  = TL
tI  = TI . read 
tV  = TV . identC
tM  = TM 0

tInt :: Int -> CFTok
tInt = TI

prCFTok :: CFTok -> String
prCFTok t = case t of
  TS s -> s
  TC s -> s
  TL s -> s
  TI i -> show i
  TV x -> prt x
  TM i _ -> "?" ---

-- to build trees: the Atom contains a GF function, Cn | Meta | Vr | Literal
newtype CFFun = CFFun (Atom, Profile) deriving (Eq,Show)

type Profile  = [([[Int]],[Int])]


-- the following functions should be used instead of constructors

-- to construct CF functions

mkCFFun :: Atom -> CFFun
mkCFFun t = CFFun (t,[])

{- ----
getCFLiteral :: String -> Maybe (CFCat, CFFun)
getCFLiteral s = case lookupLiteral' s of
  Ok (c, lit) -> Just (cat2CFCat c, mkCFFun lit)
  _ -> Nothing
-}

varCFFun :: Ident -> CFFun
varCFFun = mkCFFun . AV

consCFFun :: CIdent -> CFFun
consCFFun = mkCFFun . AC

{- ----
string2CFFun :: String -> CFFun 
string2CFFun = consCFFun . Ident
-}

cfFun2String :: CFFun -> String
cfFun2String (CFFun (f,_)) = prt f

cfFun2Profile :: CFFun -> Profile
cfFun2Profile (CFFun (_,p)) = p

{- ----
strPro2cfFun :: String -> Profile -> CFFun
strPro2cfFun str p = (CFFun (AC (Ident str), p))
-}

metaCFFun :: CFFun
metaCFFun = mkCFFun $ AM 0

-- to construct CF categories

-- belongs elsewhere
mkCIdent :: String -> String -> CIdent
mkCIdent m c = CIQ (identC m) (identC c)

ident2CFCat :: CIdent -> Ident -> CFCat
ident2CFCat mc d = CFCat (mc, L d)

-- standard way of making cf cat: label s
string2CFCat :: String -> String -> CFCat
string2CFCat m c = ident2CFCat (mkCIdent m c) (identC "s")

idents2CFCat :: Ident -> Ident -> CFCat
idents2CFCat m c = ident2CFCat (CIQ m c) (identC "s")

catVarCF :: CFCat
catVarCF = ident2CFCat (mkCIdent "_" "#Var") (identC "_") ----

cat2CFCat :: (Ident,Ident) -> CFCat
cat2CFCat = uncurry idents2CFCat


{- ----
uCFCat :: CFCat
uCFCat = cat2CFCat uCat
-}

moduleOfCFCat :: CFCat -> Ident
moduleOfCFCat (CFCat (CIQ m _, _)) = m

-- the opposite direction
cfCat2Cat :: CFCat -> (Ident,Ident)
cfCat2Cat (CFCat (CIQ m c,_)) = (m,c)

-- to construct CF tokens

string2CFTok :: String -> CFTok
string2CFTok = tS

str2cftoks :: Str -> [CFTok]
str2cftoks = map tS . words . sstr

-- decide if two token lists look the same (in parser postprocessing)

compatToks :: [CFTok] -> [CFTok] -> Bool
compatToks ts us = and [compatTok t u | (t,u) <- zip ts us]

compatTok t u = any (`elem` (alts t)) (alts u) where
  alts u = case u of
    TC (c:s) -> [toLower c : s, toUpper c : s]
    _ -> [prCFTok u]

-- decide if two CFFuns have the same function head (profiles may differ)

compatCFFun :: CFFun -> CFFun -> Bool
compatCFFun (CFFun (f,_)) (CFFun (g,_)) = f == g

-- decide whether two categories match
-- the modifiers can be from different modules, but on the same extension
-- path, so there is no clash, and they can be safely ignored ---
compatCF :: CFCat -> CFCat -> Bool
----compatCF = (==)
compatCF (CFCat (CIQ _ c, l)) (CFCat (CIQ _ c', l')) = c==c' && l==l'
