module PrLBNF (prLBNF,prBNF) where

import CF
import CFIdent
import AbsGFC
import Ident
import PrGrammar

import Operations
import Char

-- Printing CF grammars generated from GF as LBNF grammar for BNFC.
-- AR 26/1/2000 -- 9/6/2003 (PPrCF) -- 8/11/2003
-- With a primitive error messaging, by rules and rule tails commented out

prLBNF :: CF -> String
prLBNF = unlines . (map prCFRule) . rulesOfCF -- hiding the literal recogn function

-- a hack to hide the LBNF details
prBNF :: CF -> String
prBNF = unlines . (map (unwords . unLBNF . drop 1 . words . prCFRule)) . rulesOfCF 
  where
    unLBNF r = case r of
      "---":ts -> ts
      ";":"---":ts -> ts
      c:ts -> c : unLBNF ts
      _ -> r

prCFRule :: CFRule -> String
prCFRule (fun,(cat,its)) = 
  prCFFun fun ++ "." +++ prCFCat True cat +++ "::=" +++  --- err in cat -> in syntax
  unwords (map prCFItem its) +++ ";"

prCFFun :: CFFun -> String
prCFFun (CFFun (t, p)) = case t of
  AC (CIQ _ x) -> prId True x
  AD (CIQ _ x) -> prId True x
  _ -> prErr True $ prt t
   
prId b i = case i of
     IC "Int" -> "Integer"
     IC s@(c:_) | isUpper c -> s ++ if isDigit (last s) then "_" else ""
     _ -> prErr b $ prt i

prLab i = case i of
     L (IC "s") -> "" ---
     _ -> "_" ++ prt i

-- just comment out the rest if you cannot interpret the function name in LBNF
-- two versions, depending on whether in the beginning of a rule or elsewhere;
-- in the latter case, error just terminates the rule 
prErr :: Bool -> String -> String
prErr b s = (if b then "" else " ;") +++ "---" +++ s

prCFCat :: Bool -> CFCat -> String
prCFCat b (CFCat ((CIQ _ c),l)) = prId b c ++ prLab l ----

prCFItem (CFNonterm c) = prCFCat False c
prCFItem (CFTerm a) = prRegExp a

prRegExp (RegAlts tt) = case tt of
  [t] -> prQuotedString t
  _ -> prErr False $ prParenth (prTList " | " (map prQuotedString tt))
