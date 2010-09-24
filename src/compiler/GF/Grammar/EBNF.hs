----------------------------------------------------------------------
-- |
-- Module      : EBNF
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:21:13 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.5 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Grammar.EBNF (getEBNF) where

import GF.Data.Operations
--import GF.Infra.Comments
import GF.Grammar.CF
--import GF.CF.CFIdent
import GF.Grammar.Grammar
--import GF.Grammar.PrGrammar
--import qualified GF.Source.AbsGF as A

import Data.Char
import Data.List



-- AR 18/4/2000 - 31/3/2004

getEBNF :: String -> String -> Err SourceGrammar
getEBNF name = fmap (cf2gf name . ebnf2cf) . pEBNF

type EBNF = [ERule]
type ERule = (ECat, ERHS)
type ECat = (String,[Int])
type ETok = String

ebnfID = "EBNF" ---- make this parametric!

data ERHS =
   ETerm ETok
 | ENonTerm ECat
 | ESeq  ERHS ERHS
 | EAlt  ERHS ERHS
 | EStar ERHS
 | EPlus ERHS
 | EOpt  ERHS
 | EEmpty

type CFRHS = [CFItem]
type CFJustRule = (CFCat, CFRHS)

ebnf2cf :: EBNF -> [CFRule]
ebnf2cf ebnf = 
  [L (0,0) (mkCFF i rule,rule) | (i,rule) <- zip [0..] (normEBNF ebnf)] where
    mkCFF i (c, _) = ("Mk" ++ c ++ "_" ++ show i)

normEBNF :: EBNF -> [CFJustRule]
normEBNF erules = let
  erules1 = [normERule ([i],r) | (i,r) <- zip [0..] erules]
  erules2 = erules1 ---refreshECats erules1 --- this seems to be just bad !
  erules3 = concat (map pickERules erules2)
  erules4 = nubERules erules3
 in [(mkCFCatE cat, map eitem2cfitem its) | (cat,itss) <- erules3, its <- itss]

refreshECats :: [NormERule] -> [NormERule]
refreshECats rules = [recas [i] rule | (i,rule) <- zip [0..] rules] where
 recas ii (cat,its) = (updECat ii cat, [recss ii 0 s | s <- its])
 recss ii n [] = []
 recss ii n (s:ss) = recit (ii ++ [n]) s : recss ii (n+1) ss
 recit ii it = case it of
   EINonTerm cat  -> EINonTerm (updECat ii cat)
   EIStar (cat,t) -> EIStar (updECat ii cat, [recss ii 0 s | s <- t])
   EIPlus (cat,t) -> EIPlus (updECat ii cat, [recss ii 0 s | s <- t])
   EIOpt  (cat,t) -> EIOpt  (updECat ii cat, [recss ii 0 s | s <- t])
   _ -> it
  
pickERules :: NormERule -> [NormERule]
pickERules rule@(cat,alts) = rule : concat (map pics (concat alts)) where
 pics it = case it of
   EIStar ru@(cat,t) -> mkEStarRules cat ++ pickERules ru
   EIPlus ru@(cat,t) -> mkEPlusRules cat ++ pickERules ru
   EIOpt  ru@(cat,t) -> mkEOptRules cat ++ pickERules ru
   _ -> []
 mkEStarRules cat = [(cat', [[],[EINonTerm cat, EINonTerm cat']])] 
                                        where cat' = mkNewECat cat "Star"
 mkEPlusRules cat = [(cat', [[EINonTerm cat],[EINonTerm cat, EINonTerm cat']])] 
                                        where cat' = mkNewECat cat "Plus"
 mkEOptRules cat  = [(cat', [[],[EINonTerm cat]])] 
                                        where cat' = mkNewECat cat "Opt"

nubERules :: [NormERule] -> [NormERule]
nubERules rules = nub optim where 
  optim = map (substERules (map mkSubst replaces)) irreducibles
  (replaces,irreducibles) = partition reducible rules
  reducible (cat,[items]) = isNewCat cat && all isOldIt items
  reducible _ = False
  isNewCat (_,ints) = ints == []
  isOldIt (EITerm _) = True
  isOldIt (EINonTerm cat) = not (isNewCat cat)
  isOldIt _ = False
  mkSubst (cat,its) = (cat, head its) -- def of reducible: its must be singleton
--- the optimization assumes each cat has at most one EBNF rule.

substERules :: [(ECat,[EItem])] -> NormERule -> NormERule
substERules g (cat,itss) = (cat, map sub itss) where
  sub [] = []
  sub (i@(EINonTerm cat') : ii) = case lookup cat g of
                                    Just its -> its ++ sub ii 
                                    _ -> i : sub ii
  sub (EIStar r : ii) = EIStar (substERules g r) : ii
  sub (EIPlus r : ii) = EIPlus (substERules g r) : ii
  sub (EIOpt r : ii)  = EIOpt  (substERules g r) : ii

eitem2cfitem :: EItem -> CFItem 
eitem2cfitem it = case it of
  EITerm a       -> Right a
  EINonTerm cat  -> Left (mkCFCatE cat)
  EIStar (cat,_) -> Left (mkCFCatE (mkNewECat cat "Star"))
  EIPlus (cat,_) -> Left (mkCFCatE (mkNewECat cat "Plus"))
  EIOpt  (cat,_) -> Left (mkCFCatE (mkNewECat cat "Opt"))

type NormERule = (ECat,[[EItem]]) -- disjunction of sequences of items

data EItem =
   EITerm String
 | EINonTerm ECat
 | EIStar NormERule
 | EIPlus NormERule
 | EIOpt  NormERule
  deriving Eq

normERule :: ([Int],ERule) -> NormERule
normERule (ii,(cat,rhs)) = 
 (cat,[map (mkEItem (ii ++ [i])) r' | (i,r') <- zip [0..] (disjNorm rhs)]) where
  disjNorm r = case r of
    ESeq r1 r2 -> [x ++ y | x <- disjNorm r1, y <- disjNorm r2]
    EAlt r1 r2 -> disjNorm r1 ++ disjNorm r2
    EEmpty -> [[]]
    _ -> [[r]]

mkEItem :: [Int] -> ERHS -> EItem
mkEItem ii rhs = case rhs of
  ETerm a -> EITerm a
  ENonTerm cat -> EINonTerm cat
  EStar r -> EIStar (normERule (ii,(mkECat ii, r)))
  EPlus r -> EIPlus (normERule (ii,(mkECat ii, r)))
  EOpt  r -> EIOpt  (normERule (ii,(mkECat ii, r)))
  _ -> EINonTerm ("?????",[])
--  _ -> error "should not happen in ebnf" ---

mkECat ints = ("C", ints)

prECat (c,[]) = c
prECat (c,ints) = c ++ "_" ++ prTList "_" (map show ints)

mkCFCatE :: ECat -> CFCat
mkCFCatE = prECat

updECat _ (c,[]) = (c,[])
updECat ii (c,_) = (c,ii)

mkNewECat (c,ii) str = (c ++ str,ii)

------ parser for EBNF grammars

pEBNF :: String -> Err EBNF
pEBNF = parseResultErr (longestOfMany (pJ pERule))

pERule :: Parser Char ERule
pERule = pECat ... pJ (literals ":=" ||| literals "::=") +.. pERHS 0 ..+ jL ";"

pERHS :: Int -> Parser Char ERHS
pERHS 0 = pTList "|" (pERHS 1) *** foldr1 EAlt
pERHS 1 = longestOfMany (pJ (pERHS 2)) *** foldr ESeq EEmpty
pERHS 2 = pERHS 3 ... pJ pUnaryEOp *** (\ (a,f) -> f a)
pERHS 3 = pQuotedString *** ETerm
          ||| pECat *** ENonTerm ||| pParenth (pERHS 0)

pUnaryEOp :: Parser Char (ERHS -> ERHS)
pUnaryEOp = 
 lits "*" <<< EStar ||| lits "+" <<< EPlus ||| lits "?" <<< EOpt ||| succeed id

pECat = pIdent *** (\c -> (c,[]))



----------------------------------------------------------------------
-- Module      : Parsers
-- some parser combinators a la Wadler and Hutton.
-- (only used in module "EBNF")
-----------------------------------------------------------------------------

infixr 2 |||, +||
infixr 3 ***
infixr 5 .>.
infixr 5 ...
infixr 5 ....
infixr 5 +..
infixr 5 ..+
infixr 6 |>
infixr 3 <<<


type Parser a b = [a] -> [(b,[a])]

parseResults :: Parser a b -> [a] -> [b]
parseResults p s = [x | (x,r) <- p s, null r]

parseResultErr :: Show a => Parser a b -> [a] -> Err b
parseResultErr p s = case parseResults p s of
  [x] -> return x
  []  -> case 
       maximumBy (\x y -> compare (length y) (length x)) (s:[r | (_,r) <- p s]) of
    r -> Bad $ "\nno parse; reached" ++++ take 300 (show r)
  _   -> Bad "ambiguous"

(...) :: Parser a b -> Parser a c -> Parser a (b,c)
(p ... q) s = [((x,y),r) | (x,t) <- p s, (y,r) <- q t]

(.>.) :: Parser a b -> (b -> Parser a c) -> Parser a c
(p .>. f) s = [(c,r) | (x,t) <- p s, (c,r) <- f x t]

(|||) :: Parser a b -> Parser a b -> Parser a b
(p ||| q) s = p s ++ q s

(+||) :: Parser a b -> Parser a b -> Parser a b
p1 +|| p2 = take 1 . (p1 ||| p2)

literal :: (Eq a) => a -> Parser a a
literal x (c:cs) = [(x,cs) | x == c]
literal _ _ = []

(***) :: Parser a b -> (b -> c) -> Parser a c
(p *** f) s = [(f x,r) | (x,r) <- p s] 

succeed :: b -> Parser a b
succeed v s = [(v,s)]

fails :: Parser a b
fails s = []

(+..) :: Parser a b -> Parser a c -> Parser a c
p1 +.. p2 = p1 ... p2 *** snd

(..+) :: Parser a b -> Parser a c -> Parser a b
p1 ..+ p2 = p1 ... p2 *** fst

(<<<) :: Parser a b -> c -> Parser a c  -- return
p <<< v = p *** (\x -> v)

(|>) :: Parser a b -> (b -> Bool) -> Parser a b
p |> b = p .>. (\x -> if b x then succeed x else fails)

many :: Parser a b -> Parser a [b]
many p = (p ... many p *** uncurry (:)) +|| succeed []

some :: Parser a b -> Parser a [b]
some p = (p ... many p) *** uncurry (:)

longestOfMany :: Parser a b -> Parser a [b]
longestOfMany p = p .>. (\x -> longestOfMany p *** (x:)) +|| succeed []

closure :: (b -> Parser a b) -> (b -> Parser a b)
closure p v = p v .>. closure p ||| succeed v

pJunk   :: Parser Char String
pJunk = longestOfMany (satisfy (\x -> elem x "\n\t "))

pJ :: Parser Char a -> Parser Char a
pJ p = pJunk +.. p ..+ pJunk

pTList  :: String -> Parser Char a -> Parser Char [a]
pTList t p = p .... many (jL t +.. p) *** (\ (x,y) -> x:y) -- mod. AR 5/1/1999

pTJList  :: String -> String -> Parser Char a -> Parser Char [a]
pTJList t1 t2 p = p .... many (literals t1 +.. jL t2 +.. p) *** (uncurry (:))

pElem   :: [String] -> Parser Char String
pElem l = foldr (+||) fails (map literals l)

(....) :: Parser Char b -> Parser Char c -> Parser Char (b,c)
p1 .... p2 = p1 ... pJunk +.. p2

item :: Parser a a
item (c:cs) = [(c,cs)]
item [] = []

satisfy :: (a -> Bool) -> Parser a a
satisfy b = item |> b

literals :: (Eq a,Show a) => [a] -> Parser a [a]
literals l = case l of 
  []  -> succeed [] 
  a:l -> literal a ... literals l *** (\ (x,y) -> x:y)

lits :: (Eq a,Show a) => [a] -> Parser a [a]
lits ts = literals ts

jL :: String -> Parser Char String
jL = pJ . lits

pParenth :: Parser Char a -> Parser Char a
pParenth p = literal '(' +.. pJunk +.. p ..+ pJunk ..+ literal ')'

-- | p,...,p
pCommaList :: Parser Char a -> Parser Char [a]
pCommaList p = pTList "," (pJ p)                      

-- | the same or nothing
pOptCommaList :: Parser Char a -> Parser Char [a]
pOptCommaList p = pCommaList p ||| succeed []            

-- | (p,...,p), poss. empty
pArgList :: Parser Char a -> Parser Char [a]
pArgList p = pParenth (pCommaList p) ||| succeed [] 

-- | min. 2 args
pArgList2 :: Parser Char a -> Parser Char [a]
pArgList2 p = pParenth (p ... jL "," +.. pCommaList p) *** uncurry (:) 

longestOfSome :: Parser a b -> Parser a [b]
longestOfSome p = (p ... longestOfMany p) *** (\ (x,y) -> x:y)

pIdent :: Parser Char String
pIdent = pLetter ... longestOfMany pAlphaPlusChar *** uncurry (:)
  where alphaPlusChar c = isAlphaNum c || c=='_' || c=='\''

pLetter, pDigit :: Parser Char Char
pLetter = satisfy (`elem` (['A'..'Z'] ++ ['a'..'z'] ++ 
                           ['\192' .. '\255'])) -- no such in Char
pDigit  = satisfy isDigit

pLetters :: Parser Char String
pLetters = longestOfSome pLetter

pAlphanum, pAlphaPlusChar :: Parser Char Char
pAlphanum      = pDigit ||| pLetter
pAlphaPlusChar = pAlphanum ||| satisfy (`elem` "_'")

pQuotedString :: Parser Char String
pQuotedString = literal '"' +.. pEndQuoted where
 pEndQuoted =
       literal '"' *** (const [])
   +|| (literal '\\' +.. item .>. \ c -> pEndQuoted *** (c:))
   +|| item .>. \ c -> pEndQuoted *** (c:)

pIntc :: Parser Char Int
pIntc = some (satisfy numb) *** read
         where numb x = elem x ['0'..'9']

