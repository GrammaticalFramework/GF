module PGF.ShowLinearize (
  tableLinearize,
  recordLinearize,
  termLinearize,
  allLinearize
  ) where

import PGF.CId
import PGF.Data
import PGF.Macros
import PGF.Linearize

import GF.Data.Operations
import Data.List

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
  (R rs,      R ts) -> RR [(str lab, mkRecord ty t) | (P lab ty, t) <- zip rs ts]
  (S [FV ps,ty],R ts) -> RT [(str par, mkRecord ty t) | (par,    t) <- zip ps ts]
  (_,W s (R ts))      -> mkRecord typ (R [K (KS (s ++ u)) | K (KS u) <- ts])
  (FV ps,       C i)  -> RCon $ str $ ps !! i
  (S [],        _)    -> RS $ realize trm
  _                   -> RS $ show trm ---- printTree trm
 where
   str = realize

-- show all branches, without labels and params
allLinearize :: PGF -> CId -> Exp -> String
allLinearize pgf lang = concat . map pr . tabularLinearize pgf lang where
  pr (p,vs) = unlines vs

-- show all branches, with labels and params
tableLinearize :: PGF -> CId -> Exp -> String
tableLinearize pgf lang = unlines . map pr . tabularLinearize pgf lang where
  pr (p,vs) = p +++ ":" +++ unwords (intersperse "|" vs)

-- create a table from labels+params to variants
tabularLinearize :: PGF -> CId -> Exp -> [(String,[String])]
tabularLinearize pgf lang = branches . recLinearize pgf lang where
  branches r = case r of
    RR  fs -> [(lab +++ b,s) | (lab,t) <- fs, (b,s) <- branches t]
    RT  fs -> [(lab +++ b,s) | (lab,t) <- fs, (b,s) <- branches t]
    RFV rs -> [([], ss) | (_,ss) <- concatMap branches rs]
    RS  s  -> [([], [s])]
    RCon _ -> []

-- show record in GF-source-like syntax
recordLinearize :: PGF -> CId -> Exp -> String
recordLinearize pgf lang = prRecord . recLinearize pgf lang

-- create a GF-like record, forming the basis of all functions above
recLinearize :: PGF -> CId -> Exp -> Record
recLinearize pgf lang exp = mkRecord typ $ linExp pgf lang exp where
  typ = case exp of
          EApp f _ -> lookParamLincat pgf lang $ valCat $ lookType pgf f

-- show PGF term
termLinearize :: PGF -> CId -> Exp -> String
termLinearize pgf lang = show . linExp pgf lang


