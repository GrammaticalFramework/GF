module GF.GFCC.Raw.ParGFCCRaw (parseGrammar) where

import GF.GFCC.Raw.AbsGFCCRaw

import Control.Monad
import Data.Char

parseGrammar :: String -> IO Grammar
parseGrammar s = case runP pGrammar s of
                   Just (x,"") -> return x
                   _           -> fail "Parse error"

pGrammar :: P Grammar
pGrammar = liftM Grm pTerms

pTerms :: P [RExp]
pTerms = liftM2 (:) (pTerm 1) pTerms <++ (skipSpaces >> return [])

pTerm :: Int -> P RExp
pTerm n = skipSpaces >> (pParen <++ pApp <++ pNum <++ pStr <++ pMeta)
  where pParen = between (char '(') (char ')') (pTerm 0)
        pApp = liftM2 App pIdent (if n == 0 then pTerms else return [])
        pStr = char '"' >> liftM AStr (manyTill (pEsc <++ get) (char '"'))
        pEsc = char '\\' >> get
        pNum = do x <- munch1 isDigit
                  ((char '.' >> munch1 isDigit >>= \y -> return (AFlt (read (x++"."++y))))
                   <++
                   return (AInt (read x)))
        pMeta = char '?' >> return AMet
        pIdent = liftM CId $ liftM2 (:) (satisfy isIdentFirst) (munch isIdentRest)
        isIdentFirst c = c == '_' || isAlpha c
        isIdentRest c = c == '_' || c == '\'' || isAlphaNum c

-- Parser combinators with only left-biased choice

newtype P a = P { runP :: String -> Maybe (a,String) }

instance Monad P where
    return x = P (\ts -> Just (x,ts))
    P p >>= f = P (\ts -> p ts >>= \ (x,ts') -> runP (f x) ts')
    fail _ = pfail

instance MonadPlus P where
    mzero = pfail
    mplus = (<++)


get :: P Char
get = P (\ts -> case ts of
                  [] -> Nothing
                  c:cs -> Just (c,cs))

look :: P String
look = P (\ts -> Just (ts,ts))

(<++) :: P a -> P a -> P a
P p <++ P q = P (\ts -> p ts `mplus` q ts)

pfail :: P a
pfail = P (\ts -> Nothing)

satisfy :: (Char -> Bool) -> P Char
satisfy p = do c <- get
               if p c then return c else pfail

char :: Char -> P Char
char c = satisfy (c==)

string :: String -> P String
string this = look >>= scan this
    where
      scan []     _               = return this
      scan (x:xs) (y:ys) | x == y = get >> scan xs ys
      scan _      _               = pfail

skipSpaces :: P ()
skipSpaces = look >>= skip
    where
      skip (c:s) | isSpace c = get >> skip s
      skip _                 = return ()

manyTill :: P a -> P end -> P [a]
manyTill p end = scan
  where scan = (end >> return []) <++ liftM2 (:) p scan

munch :: (Char -> Bool) -> P String
munch p = munch1 p <++ return []

munch1 :: (Char -> Bool) -> P String
munch1 p = liftM2 (:) (satisfy p) (munch p)

choice :: [P a] -> P a
choice = msum

between :: P open -> P close -> P a -> P a
between open close p = do open
                          x <- p
                          close
                          return x
