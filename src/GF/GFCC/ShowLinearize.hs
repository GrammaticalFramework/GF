module GF.GFCC.ShowLinearize (
  tableLinearize,
  recordLinearize,
  termLinearize,
  allLinearize
  ) where

import GF.GFCC.Linearize
import GF.GFCC.Macros
import GF.GFCC.DataGFCC
import GF.GFCC.Raw.AbsGFCCRaw (CId (..))
--import GF.GFCC.PrintGFCC ----

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

-- uses the encoding of record types in GFCC.paramlincat
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
allLinearize :: GFCC -> CId -> Exp -> String
allLinearize gfcc lang = concat . map pr . tabularLinearize gfcc lang where
  pr (p,vs) = unlines vs

-- show all branches, with labels and params
tableLinearize :: GFCC -> CId -> Exp -> String
tableLinearize gfcc lang = unlines . map pr . tabularLinearize gfcc lang where
  pr (p,vs) = p +++ ":" +++ unwords (intersperse "|" vs)

-- create a table from labels+params to variants
tabularLinearize :: GFCC -> CId -> Exp -> [(String,[String])]
tabularLinearize gfcc lang = branches . recLinearize gfcc lang where
  branches r = case r of
    RR  fs -> [(lab +++ b,s) | (lab,t) <- fs, (b,s) <- branches t]
    RT  fs -> [(lab +++ b,s) | (lab,t) <- fs, (b,s) <- branches t]
    RFV rs -> [([], ss) | (_,ss) <- concatMap branches rs]
    RS  s  -> [([], [s])]
    RCon _ -> []

-- show record in GF-source-like syntax
recordLinearize :: GFCC -> CId -> Exp -> String
recordLinearize gfcc lang = prRecord . recLinearize gfcc lang

-- create a GF-like record, forming the basis of all functions above
recLinearize :: GFCC -> CId -> Exp -> Record
recLinearize gfcc lang exp = mkRecord typ $ linExp gfcc lang exp where
  typ = case exp of
    DTr _ (AC f) _ -> lookParamLincat gfcc lang $ valCat $ lookType gfcc f

-- show GFCC term
termLinearize :: GFCC -> CId -> Exp -> String
termLinearize gfcc lang = show . linExp gfcc lang


