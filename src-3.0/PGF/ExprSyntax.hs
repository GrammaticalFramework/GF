module PGF.ExprSyntax(readExp, showExp,
                      pExp,ppExp,
                      
                     -- helpers
                      pIdent,pStr
                     ) where

import PGF.CId
import PGF.Data

import Data.Char
import Control.Monad
import qualified Text.PrettyPrint as PP
import qualified Text.ParserCombinators.ReadP as RP


-- | parses 'String' as an expression
readExp :: String -> Maybe Exp
readExp s = case [x | (x,cs) <- RP.readP_to_S (pExp False) s, all isSpace cs] of
              [x] -> Just x
              _   -> Nothing

-- | renders expression as 'String'
showExp :: Exp -> String
showExp = PP.render . ppExp False

pExps :: RP.ReadP [Exp]
pExps = liftM2 (:) (pExp True) pExps RP.<++ (RP.skipSpaces >> return [])

pExp :: Bool -> RP.ReadP Exp
pExp isNested = RP.skipSpaces >> (pParen RP.<++ pAbs RP.<++ pApp RP.<++ pNum RP.<++ 
    liftM EStr pStr RP.<++ pMeta)
  where 
        pParen = RP.between (RP.char '(') (RP.char ')') (pExp False)
        pAbs = do xs <- RP.between (RP.char '\\') (RP.skipSpaces >> RP.string "->") (RP.sepBy1 (RP.skipSpaces >> pCId) (RP.skipSpaces >> RP.char ','))
                  t  <- pExp False
                  return (EAbs xs t)
        pApp = do f  <- pCId
                  ts <- (if isNested then return [] else pExps)
                  return (EApp f ts)
        pMeta = do RP.char '?'
                   x <- RP.munch1 isDigit
                   return (EMeta (read x))
        pNum = do x <- RP.munch1 isDigit
                  ((RP.char '.' >> RP.munch1 isDigit >>= \y -> return (EFloat (read (x++"."++y))))
                   RP.<++
                   (return (EInt (read x))))

pStr = RP.char '"' >> (RP.manyTill (pEsc RP.<++ RP.get) (RP.char '"'))
          where
            pEsc = RP.char '\\' >> RP.get    

pCId = fmap mkCId pIdent

pIdent = liftM2 (:) (RP.satisfy isIdentFirst) (RP.munch isIdentRest)
  where
    isIdentFirst c = c == '_' || isLetter c
    isIdentRest c = c == '_' || c == '\'' || isAlphaNum c

ppExp isNested (EAbs xs t) = ppParens isNested (PP.char '\\' PP.<>
                                                PP.hsep (PP.punctuate PP.comma (map (PP.text . prCId) xs)) PP.<+>
                                                PP.text "->" PP.<+>
                                                ppExp False t)
ppExp isNested (EApp f []) = PP.text (prCId f)
ppExp isNested (EApp f ts) = ppParens isNested (PP.text (prCId f) PP.<+> PP.hsep (map (ppExp True) ts))
ppExp isNested (EStr   s)  = PP.text (show s)
ppExp isNested (EInt   n)  = PP.integer n
ppExp isNested (EFloat d)  = PP.double d
ppExp isNested (EMeta  n)  = PP.char '?' PP.<> PP.int n
ppExp isNested (EVar  id)  = PP.text (prCId id)

ppParens True  = PP.parens
ppParens False = id
