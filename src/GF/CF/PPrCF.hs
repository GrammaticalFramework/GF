module PPrCF where

import Operations
import CF
import CFIdent
import AbsGFC
import PrGrammar

-- printing and parsing CF grammars, rules, and trees AR 26/1/2000 -- 9/6/2003
---- use the Print class instead!

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
prCFFun' profs (CFFun (t, p)) = prt t ++ pp p where
    pp p = if (not profs || normal p) then "" else "_" ++ concat (map show p)
    normal p = and [x==y && null b | ((b,x),y) <- zip p (map (:[]) [0..])]

prCFCat :: CFCat -> String
prCFCat (CFCat (c,l)) = prt c ++ "-" ++ prt l ----

prCFItem (CFNonterm c) = prCFCat c
prCFItem (CFTerm a) = prRegExp a

prRegExp (RegAlts tt) = case tt of
  [t] -> prQuotedString t
  _ -> prParenth (prTList " | " (map prQuotedString tt))

{- ----
-- rules have an amazingly easy parser, if we use the format
-- fun. C -> item1 item2 ... where unquoted items are treated as cats
-- Actually would be nice to add profiles to this.

getCFRule :: String -> Maybe CFRule
getCFRule s = getcf (wrds s) where
  getcf ww | length ww > 2 && ww !! 2 `elem` ["->", "::="] = 
            Just (string2CFFun (init fun), (string2CFCat cat, map mkIt its)) where
    fun : cat : _ : its = words s
    mkIt ('"':w@(_:_)) = atomCFTerm (string2CFTok (init w))
    mkIt w = CFNonterm (string2CFCat w)
  getcf _ = Nothing
  wrds = takeWhile (/= ";") . words -- to permit semicolon in the end
-}