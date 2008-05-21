module GF.GFCC.Raw.PrintGFCCRaw (printTree) where

import GF.GFCC.CId
import GF.GFCC.Raw.AbsGFCCRaw

import Data.List (intersperse)
import Numeric (showFFloat)
import qualified Data.ByteString.Char8 as BS

printTree :: Grammar -> String
printTree g = prGrammar g ""

prGrammar :: Grammar -> ShowS
prGrammar (Grm xs) = prRExpList xs

prRExp :: Int -> RExp -> ShowS
prRExp _ (App x []) = showString x
prRExp n (App x xs) = p (showString x . showChar ' ' . prRExpList xs)
    where p s = if n == 0 then s else showChar '(' . s . showChar ')'
prRExp _ (AInt x) = shows x
prRExp _ (AStr x) = showChar '"' . concatS (map mkEsc x) . showChar '"'
prRExp _ (AFlt x) = showFFloat Nothing x
prRExp _ AMet = showChar '?'

mkEsc :: Char -> ShowS
mkEsc s = case s of
  '"'  -> showString "\\\""
  '\\' -> showString "\\\\"
  _    -> showChar s

prRExpList :: [RExp] -> ShowS
prRExpList = concatS . intersperse (showChar ' ') . map (prRExp 1)

concatS :: [ShowS] -> ShowS
concatS = foldr (.) id
