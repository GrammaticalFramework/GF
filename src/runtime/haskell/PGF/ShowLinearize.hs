module PGF.ShowLinearize (
  collectWords,
  tableLinearize,
  recordLinearize,
  termLinearize,
  tabularLinearize,
  allLinearize,
  markLinearize
  ) where

import PGF.CId
import PGF.Data
import PGF.Tree
import PGF.Macros
import PGF.Linearize

import GF.Data.Operations
import Data.List
import qualified Data.Map as Map

-- printing linearizations in different ways with source parameters

-- internal representation, only used internally in this module
data Record = 
   RR   [(String,Record)]
 | RT   [(String,Record)]
 | RFV  [Record]
 | RS   String
 | RCon String

prRecord :: Record -> String
prRecord = prr where
  prr t = case t of
    RR fs -> concat $ 
      "{" : 
      (intersperse ";" (map (\ (l,v) -> unwords [l,"=", prr v]) fs)) ++ ["}"]
    RT fs -> concat $
      "table {" : 
      (intersperse ";" (map (\ (l,v) -> unwords [l,"=>",prr v]) fs)) ++ ["}"]
    RFV ts -> concat $
      "variants {" : (intersperse ";" (map prr ts)) ++ ["}"]
    RS s -> prQuotedString s
    RCon s -> s

-- uses the encoding of record types in PGF.paramlincat
mkRecord :: Term -> Term -> Record
mkRecord typ trm = case (typ,trm) of
  (_,         FV ts)  -> RFV $ map (mkRecord typ) ts
  (R rs,      R ts)   -> RR [(str lab, mkRecord ty t) | (P lab ty, t) <- zip rs ts]
  (S [FV ps,ty],R ts) -> RT [(str par, mkRecord ty t) | (par,    t) <- zip ps ts]
  (_,W s (R ts))      -> mkRecord typ (R [K (KS (s ++ u)) | K (KS u) <- ts])
  (FV ps,       C i)  -> RCon $ str $ ps !! i
  (S [],        _)    -> case realizes trm of
                           [s] -> RS s
                           ss  -> RFV $ map RS ss
  _                   -> RS $ show trm ---- printTree trm
 where
   str = realize

-- show all branches, without labels and params
allLinearize :: (String -> String) -> PGF -> CId -> Expr -> String
allLinearize unlex pgf lang = concat . map (unlex . pr) . tabularLinearize pgf lang where
  pr (p,vs) = unlines vs

-- show all branches, with labels and params
tableLinearize :: (String -> String) -> PGF -> CId -> Expr -> String
tableLinearize unlex pgf lang = unlines . map pr . tabularLinearize pgf lang where
  pr (p,vs) = p +++ ":" +++ unwords (intersperse "|" (map unlex vs))

-- create a table from labels+params to variants
tabularLinearize :: PGF -> CId -> Expr -> [(String,[String])]
tabularLinearize pgf lang = branches . recLinearize pgf lang where
  branches r = case r of
    RR  fs -> [(lab +++ b,s) | (lab,t) <- fs, (b,s) <- branches t]
    RT  fs -> [(lab +++ b,s) | (lab,t) <- fs, (b,s) <- branches t]
    RFV rs -> concatMap branches rs
    RS  s  -> [([], [s])]
    RCon _ -> []

-- show record in GF-source-like syntax
recordLinearize :: PGF -> CId -> Expr -> String
recordLinearize pgf lang = prRecord . recLinearize pgf lang

-- create a GF-like record, forming the basis of all functions above
recLinearize :: PGF -> CId -> Expr -> Record
recLinearize pgf lang tree = mkRecord typ $ linTree pgf lang tree where
  typ = case expr2tree tree of
          Fun f _ -> lookParamLincat pgf lang $ valCat $ lookType pgf f

-- show PGF term
termLinearize :: PGF -> CId -> Expr -> String
termLinearize pgf lang = show . linTree pgf lang

-- show bracketed markup with references to tree structure
markLinearize :: PGF -> CId -> Expr -> String
markLinearize pgf lang = concat . take 1 . linearizesMark pgf lang


-- for Morphology: word, lemma, tags
collectWords :: PGF -> Language -> [(String, [(CId,String)])]
collectWords pgf lang = 
    concatMap collOne 
      [(f,c,length xs) | (f,(DTyp xs c _,_,_)) <- Map.toList $ funs $ abstract pgf] 
  where
    collOne (f,c,i) = 
      fromRec f [showCId c] (recLinearize pgf lang (foldl EApp (EFun f) (replicate i (EMeta 888))))
    fromRec f v r = case r of
      RR  rs -> concat [fromRec f v t | (_,t) <- rs] 
      RT  rs -> concat [fromRec f (p:v) t | (p,t) <- rs]
      RFV rs -> concatMap (fromRec f v) rs
      RS  s  -> [(w,[(f,unwords (reverse v))]) | w <- words s, w /= "?888"] ---
--      RS  s  -> [(s,[(f,unwords (reverse v))])]
      RCon c -> [] ---- inherent

