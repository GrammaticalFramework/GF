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
-- With primitive error messaging, by rules and rule tails commented out

prLBNF :: CF -> String
prLBNF cf = unlines $ (map (prCFRule cs)) $ rulesOfCF cf --- no literal recogn function
  where    
    cs = map IC ["Int","String"] ++ [catId c | (_,(c,_)) <- rulesOfCF cf]

-- a hack to hide the LBNF details
prBNF :: CF -> String
prBNF = unlines . (map (unwords . unLBNF . drop 1 . words)) . lines . prLBNF
  where
    unLBNF r = case r of
      "---":ts -> ts
      ";":"---":ts -> ts
      c:ts -> c : unLBNF ts
      _ -> r

catId ((CFCat ((CIQ _ c),l))) = c

prCFRule :: [Ident] -> CFRule -> String
prCFRule cs (fun,(cat,its)) = 
  prCFFun cat fun ++ "." +++ prCFCat True cat +++ "::=" +++  --- err in cat -> in syntax
  unwords (map (prCFItem cs) its) +++ ";"

prCFFun :: CFCat -> CFFun -> String
prCFFun (CFCat (_,l)) (CFFun (t, p)) = case t of
  AC (CIQ _ x) -> let f = prId True x in (f ++ lab +++ f2 f +++ prP p)
  AD (CIQ _ x) -> let f = prId True x in (f ++ lab +++ f2 f +++ prP p)
  _ -> prErr True $ prt t
 where
   lab = prLab l
   f2 f = if null lab then "" else f
   prP = concatMap show
   
prId b i = case i of
     IC "Int"  -> "Integer"
     IC "#Var" -> "Ident"
     IC "Var"  -> "Ident"
     IC "id_"  -> "_"
     IC s@(c:_) | isUpper c -> s ++ if isDigit (last s) then "_" else ""
     _ -> prErr b $ prt i

prLab i = case i of
     L (IC "s") -> "" ---
     L (IC "_") -> "" ---
     _ -> let x = prt i in "_" ++ x ++ if isDigit (last x) then "_" else ""

-- just comment out the rest if you cannot interpret the function name in LBNF
-- two versions, depending on whether in the beginning of a rule or elsewhere;
-- in the latter case, error just terminates the rule 
prErr :: Bool -> String -> String
prErr b s = (if b then "" else " ;") +++ "---" +++ s

prCFCat :: Bool -> CFCat -> String
prCFCat b (CFCat ((CIQ _ c),l)) = prId b c ++ prLab l ----

-- if a category does not have a production of its own, we replace it by Ident
prCFItem cs (CFNonterm c) = if elem (catId c) cs then prCFCat False c else "Ident"
prCFItem _ (CFTerm a) = prRegExp a

prRegExp (RegAlts tt) = case tt of
  [t] -> prQuotedString t
  _ -> prErr False $ prParenth (prTList " | " (map prQuotedString tt))
