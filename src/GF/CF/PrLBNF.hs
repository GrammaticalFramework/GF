module PrLBNF (prLBNF,prBNF) where

import CF
import CFIdent
import AbsGFC
import Ident
import PrGrammar
import ShellState
import GFC
import Look

import Operations
import Modules

import Char
import List (nub)

-- Printing CF grammars generated from GF as LBNF grammar for BNFC.
-- AR 26/1/2000 -- 9/6/2003 (PPrCF) -- 8/11/2003 -- 27/9/2004
-- With primitive error messaging, by rules and rule tails commented out

prLBNF :: Bool -> StateGrammar -> String
prLBNF new gr = unlines $ pragmas ++ (map (prCFRule cs) rules)
  where    
    cs = map IC ["Int","String"] ++ [catId c | (_,(c,_)) <- rules]
    cf = stateCF gr
    (pragmas,rules) = if new  -- tries to treat precedence levels
                         then mkLBNF (stateGrammarST gr) $ rulesOfCF cf
                         else ([],rulesOfCF cf) -- "normal" behaviour

-- a hack to hide the LBNF details
prBNF :: Bool -> StateGrammar -> String
prBNF b = unlines . (map (unwords . unLBNF . drop 1 . words)) . lines . prLBNF b
  where
    unLBNF r = case r of
      "---":ts -> ts
      ";":"---":ts -> ts
      c:ts -> c : unLBNF ts
      _ -> r

--- awful low level code without abstraction over label names etc
mkLBNF :: CanonGrammar -> [CFRule] -> ([String],[CFRule])
mkLBNF gr rules = (coercions, nub $ concatMap mkRule rules) where
  coercions = ["coercions" +++ prt_ c +++ show n +++ ";"  | 
    (_,ModMod m) <- modules gr,
    (c,CncCat (RecType ls) _ _) <- tree2list $ jments m,
    Lbg (L (IC "p")) (TInts n) <- ls
    ]
  precedences = [(f,(prec,assoc))  | 
    (_,ModMod m) <- modules gr,
    (f,CncFun _ _ (R lin) _) <- tree2list $ jments m,
    (Just prec, Just assoc) <- [(
       lookup "p" [(lab,p) | Ass (L (IC lab)) (EInt p) <- lin],
       lookup "a" [(lab,a) | Ass (L (IC lab)) (Con (CIQ _ (IC a)) []) <- lin]
       )]
    ]
  precfuns = map fst precedences
  mkRule r@(fun@(CFFun (t, p)),(cat,its)) = case t of
    AC (CIQ _ c) -> case lookup c precedences of
      Just (prec,assoc) -> [(fun,(mkCat prec cat,mkIts cat prec assoc 0 its))]
      _ -> return r
    AD (CIQ _ c) -> case lookup c precedences of
      Just (prec,assoc) -> [(fun,(mkCat prec cat,mkIts cat prec assoc 0 its))]
      _ -> return r
    _ -> return r
  mkIts cat prec assoc i its = case its of
    CFTerm (RegAlts ["("]):n@(CFNonterm k):CFTerm (RegAlts [")"]):rest | k==cat -> 
      mkIts cat prec assoc i $ n:rest  -- remove variants with parentheses 
    CFNonterm k:rest | k==cat -> 
      CFNonterm (mkNonterm prec assoc i k) : mkIts cat prec assoc (i+1) rest
    it:rest -> it:mkIts cat prec assoc i rest
    [] -> []

  mkCat prec (CFCat ((CIQ m (IC c)),l)) = CFCat ((CIQ m (IC (c ++ show prec ++ "+"))),l)
  mkNonterm prec assoc i cat = mkCat prec' cat 
    where 
      prec' = case (assoc,i) of
        ("PL",0) -> prec
        ("PR",0) -> prec + 1
        ("PR",_) -> prec
        _        -> prec + 1

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
     IC s@(c:_) | last s == '+' -> init s  -- hack to save precedence information
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
