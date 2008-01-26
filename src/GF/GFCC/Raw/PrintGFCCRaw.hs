module GF.GFCC.Raw.PrintGFCCRaw (printTree) where

import GF.GFCC.Raw.AbsGFCCRaw

import Data.List (intersperse)

printTree :: Grammar -> String
printTree g = prGrammar g ""

prGrammar :: Grammar -> ShowS
prGrammar (Grm xs) = prRExpList xs

prRExp :: RExp -> ShowS
prRExp (App x []) = showChar '(' . prCId x . showChar ')' 
prRExp (App x xs) = showChar '(' . prCId x . showChar ' ' 
                    . prRExpList xs . showChar ')'
prRExp (AId x) = prCId x
prRExp (AInt x) = shows x
prRExp (AStr x) = showChar '"' . concatS (map mkEsc x) . showChar '"'
prRExp (AFlt x) = shows x -- FIXME: simpler format
prRExp AMet = showChar '?'

mkEsc :: Char -> ShowS
mkEsc s = case s of
  '"'  -> showString "\\\""
  '\\' -> showString "\\\\"
  '\n' -> showString "\\n"
  '\t' -> showString "\\t"
  _    -> showChar s

prRExpList :: [RExp] -> ShowS
prRExpList = concatS . intersperse (showChar ' ') . map prRExp

prCId :: CId -> ShowS
prCId (CId x) = showString x

concatS :: [ShowS] -> ShowS
concatS = foldr (.) id
