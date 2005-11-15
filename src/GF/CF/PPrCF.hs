----------------------------------------------------------------------
-- |
-- Module      : PPrCF
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/15 17:56:13 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.13 $
--
-- printing and parsing CF grammars, rules, and trees AR 26/1/2000 -- 9/6/2003
--
-- use the Print class instead!
-----------------------------------------------------------------------------

module GF.CF.PPrCF (prCF, prCFTree, prCFRule, prCFFun, prCFCat, prCFItem, prRegExp, pCF) where

import GF.Data.Operations
import GF.CF.CF
import GF.CF.CFIdent
import GF.Canon.AbsGFC
import GF.Grammar.PrGrammar

import Data.Char
import Data.List

prCF :: CF -> String
prCF = unlines . (map prCFRule) . rulesOfCF -- hiding the literal recogn function

prCFTree :: CFTree -> String
prCFTree (CFTree (fun, (_,trees))) = prCFFun fun ++ prs trees where 
 prs [] = ""
 prs ts = " " ++ unwords (map ps ts)
 ps t@(CFTree (_,(_,[]))) = prCFTree t
 ps t = prParenth (prCFTree t)

prCFRule :: CFRule -> String
prCFRule (fun,(cat,its)) = 
  prCFFun fun ++ "." +++ prCFCat cat +++ "::=" +++ 
  unwords (map prCFItem its) +++ ";"

prCFFun :: CFFun -> String
prCFFun = prCFFun' True ---- False -- print profiles for debug

prCFFun' :: Bool -> CFFun -> String
prCFFun' profs (CFFun (t, p)) = prt_ t ++ pp p where
    pp p = if (not profs || normal p) then "" else "_" ++ concat (map show p)
    normal p = and [x==y && null b | ((b,x),y) <- zip p (map (:[]) [0..])]

prCFCat :: CFCat -> String
prCFCat (CFCat (c,l)) = prt_ c ++ case prt_ l of
  "s" -> []
  _   -> "-" ++ prt_ l ----

prCFItem :: CFItem -> String
prCFItem (CFNonterm c) = prCFCat c
prCFItem (CFTerm a) = prRegExp a

prRegExp :: RegExp -> String
prRegExp (RegAlts tt) = case tt of
  [t] -> prQuotedString t
  _ -> prParenth (prTList " | " (map prQuotedString tt))

-- rules have an amazingly easy parser, if we use the format
-- fun. C -> item1 item2 ... where unquoted items are treated as cats
-- Actually would be nice to add profiles to this.

getCFRule :: String -> String -> Err [CFRule]
getCFRule mo s = getcf (wrds s) where
  getcf ws = case ws of
    fun : cat : a : its | isArrow a -> 
      Ok [(string2CFFun mo (init fun), 
            (string2CFCat mo cat, map mkIt its))]
    cat : a : its | isArrow a -> 
      Ok [(string2CFFun mo (mkFun cat it), 
            (string2CFCat mo cat, map mkIt it)) | it <- chunk its]
    _ -> Bad (" invalid rule:" +++ s)
  isArrow a = elem a ["->", "::="] 
  mkIt w = case w of
    ('"':w@(_:_)) -> atomCFTerm (string2CFTok (init w))
    _             -> CFNonterm (string2CFCat mo w)
  chunk its = case its of
    [] -> [[]]
    _ -> chunks "|" its
  mkFun cat its = case its of
    [] -> cat ++ "_"
    _ -> concat $ intersperse "_" (cat : map clean its) -- CLE style
  clean = filter isAlphaNum -- to form valid identifiers
  wrds = takeWhile (/= ";") . words -- to permit semicolon in the end

pCF :: String -> String -> Err [CFRule]
pCF mo s = do
  rules <- mapM (getCFRule mo) $ filter isRule $ lines s
  return $ concat rules
 where
   isRule line = case dropWhile isSpace line of
     '-':'-':_ -> False
     _ -> not $ all isSpace line
