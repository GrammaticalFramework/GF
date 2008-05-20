----------------------------------------------------------------------
-- |
-- Module      : Parsers
-- Maintainer  : Aarne Ranta
-- Stability   : Almost Obsolete
-- Portability : Haskell 98
--
-- > CVS $Date: 2005/04/21 16:22:06 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.6 $
--
-- some parser combinators a la Wadler and Hutton.
-- no longer used in many places in GF
-- (only used in module "EBNF")
-----------------------------------------------------------------------------

module GF.Data.Parsers (-- * Main types and functions
		Parser, parseResults, parseResultErr,
		-- * Basic combinators (on any token type)
		(...), (.>.), (|||), (+||), literal, (***),
		succeed, fails, (+..), (..+), (<<<), (|>),
		many, some, longestOfMany, longestOfSome,
		closure,
		-- * Specific combinators (for @Char@ token type)
		pJunk, pJ, jL, pTList, pTJList, pElem,
		(....), item, satisfy, literals, lits,
		pParenth, pCommaList, pOptCommaList,
		pArgList, pArgList2,
		pIdent, pLetter, pDigit, pLetters,
		pAlphanum, pAlphaPlusChar,
		pQuotedString, pIntc
	       ) where

import GF.Data.Operations
import Data.Char
import Data.List


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

