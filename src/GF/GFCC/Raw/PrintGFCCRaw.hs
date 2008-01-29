module GF.GFCC.Raw.PrintGFCCRaw (printTree) where

import GF.GFCC.Raw.AbsGFCCRaw

import Data.List (intersperse)

printTree :: Grammar -> String
printTree g = prGrammar g ""

prGrammar :: Grammar -> ShowS
prGrammar (Grm xs) = prRExpList xs

prRExp :: Int -> RExp -> ShowS
prRExp _ (App x []) = prCId x
prRExp n (App x xs) = p (prCId x . showChar ' ' . prRExpList xs)
    where p s = if n == 0 then s else showChar '(' . s . showChar ')'
prRExp _ (AInt x) = shows x
prRExp _ (AStr x) = showChar '"' . concatS (map mkEsc x) . showChar '"'
prRExp _ (AFlt x) = shows x -- FIXME: simpler format
prRExp _ AMet = showChar '?'

mkEsc :: Char -> ShowS
mkEsc s = case s of
  '"'  -> showString "\\\""
  '\\' -> showString "\\\\"
  '\n' -> showString "\\n"
  '\t' -> showString "\\t"
  _    -> showChar s

prRExpList :: [RExp] -> ShowS
prRExpList = concatS . intersperse (showChar ' ') . map (prRExp 1)

prCId :: CId -> ShowS
prCId (CId x) = showString x

concatS :: [ShowS] -> ShowS
concatS = foldr (.) id
