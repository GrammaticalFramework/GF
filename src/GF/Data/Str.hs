module Str (
  Str (..), Tok (..),        --- constructors needed in PrGrammar 
  str2strings, str2allStrings, str, sstr, sstrV, 
  isZeroTok, prStr, plusStr, glueStr,
  strTok, 
  allItems
) where

import Operations
import List (isPrefixOf, isSuffixOf, intersperse)

-- abstract token list type. AR 2001, revised and simplified 20/4/2003

newtype Str = Str [Tok]  deriving (Read, Show, Eq, Ord)

data Tok = 
   TK String
 | TN Ss [(Ss, [String])] -- variants depending on next string 
    deriving (Eq, Ord, Show, Read)

-- notice that having both pre and post would leave to inconsistent situations:
--   pre {"x" ; "y" / "a"} ++ post {"b" ; "a" / "x"}
-- always violates a condition expressed by the one or the other

-- a variant can itself be a token list, but for simplicity only a list of strings
-- i.e. not itself containing variants

type Ss = [String]

-- matching functions in both ways

matchPrefix :: Ss -> [(Ss,[String])] -> [String] -> Ss
matchPrefix s vs t = 
    head ([u | (u,as) <- vs, any (\c -> isPrefixOf c (concat t)) as] ++ [s])

str2strings :: Str -> Ss
str2strings (Str st) = alls st where 
  alls st = case st of
    TK s     : ts -> s                   : alls ts
    TN ds vs : ts -> matchPrefix ds vs t ++ t where t = alls ts
    []            -> []

str2allStrings :: Str -> [Ss]
str2allStrings (Str st) = alls st where 
  alls st = case st of
    TK s     : ts -> [s        : t | t <- alls ts]
    TN ds vs : [] -> [ds      ++ v | v <- map fst vs]
    TN ds vs : ts -> [matchPrefix ds vs t ++ t | t <- alls ts]
    []            -> [[]]

sstr :: Str -> String
sstr = unwords . str2strings

-- to handle a list of variants

sstrV :: [Str] -> String
sstrV ss = case ss of
  []  -> "*"
  _   -> unwords $ intersperse "/" $ map (unwords . str2strings) ss

str :: String -> Str
str s = if null s then Str [] else Str [itS s]

itS :: String -> Tok
itS s = TK s

isZeroTok :: Str -> Bool
isZeroTok t = case t of
  Str [] -> True
  Str [TK []] -> True
  _ -> False

strTok :: Ss -> [(Ss,[String])] -> Str
strTok ds vs = Str [TN ds vs]

prStr = prQuotedString . sstr

plusStr :: Str -> Str -> Str
plusStr (Str ss) (Str tt) = Str (ss ++ tt)

glueStr :: Str -> Str -> Str
glueStr (Str ss) (Str tt) = Str $ case (ss,tt) of
  ([],_) -> tt
  (_,[]) -> ss
  _ -> init ss ++ glueIt (last ss) (head tt) ++ tail tt
 where
   glueIt t u = case (t,u) of
     (TK s, TK s') -> return $ TK $ s ++ s'
     (TN ds vs, TN es ws) -> return $ TN (glues (matchPrefix ds vs es) es) 
                               [(glues (matchPrefix ds vs w) w,cs) | (w,cs) <- ws]
     (TN ds vs, TK s) -> map TK $ glues (matchPrefix ds vs [s]) [s]
     (TK s, TN es ws) -> return $ TN (glues [s] es) [(glues [s] w, c) | (w,c) <- ws]

glues :: [[a]] -> [[a]] -> [[a]]
glues ss tt = case (ss,tt) of
  ([],_) -> tt
  (_,[]) -> ss
  _ -> init ss ++ [last ss ++ head tt] ++ tail tt

-- to create the list of all lexical items

allItems :: Str -> [String]
allItems (Str s) = concatMap allOne s where
  allOne t = case t of
    TK s -> [s]
    TN ds vs -> ds ++ concatMap fst vs
