module GF.GFCC.ShowLinearize (
  tableLinearize,
  recordLinearize,
  termLinearize
  ) where

import GF.GFCC.Linearize
import GF.GFCC.Macros
import GF.GFCC.DataGFCC
import GF.GFCC.AbsGFCC
import GF.GFCC.PrintGFCC ----

import GF.Data.Operations
import Data.List

-- printing linearizations with parameters

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

mkRecord :: Term -> Term -> Record
mkRecord typ trm = case (typ,trm) of
  (R rs,      R ts) -> RR [(str lab, mkRecord ty t) | (P lab ty, t) <- zip rs ts]
  (S [FV ps,ty],R ts) -> RT [(str par, mkRecord ty t) | (par,    t) <- zip ps ts]
  (_,W s (R ts))      -> mkRecord typ (R [K (KS (s ++ u)) | K (KS u) <- ts])
  (FV ps,       C i)  -> RCon $ str $ ps !! i
  (S [],        _)    -> RS $ realize trm
  _                   -> RS $ printTree trm
 where
   str = realize

tableLinearize :: GFCC -> CId -> Exp -> String
tableLinearize gfcc lang = unlines . branches . recLinearize gfcc lang where
  branches r = case r of
    RR  fs -> [lab +++ b | (lab,t) <- fs, b <- branches t]
    RT  fs -> [lab +++ b | (lab,t) <- fs, b <- branches t]
    RFV rs -> intersperse "|" (concatMap branches rs)
    RS  s  -> [" : " ++ s]
    RCon _ -> []

recordLinearize :: GFCC -> CId -> Exp -> String
recordLinearize gfcc lang = prRecord . recLinearize gfcc lang

termLinearize :: GFCC -> CId -> Exp -> String
termLinearize gfcc lang = printTree . linExp gfcc lang

recLinearize :: GFCC -> CId -> Exp -> Record
recLinearize gfcc lang exp = mkRecord typ $ linExp gfcc lang exp where
  typ = case exp of
    DTr _ (AC f) _ -> lookParamLincat gfcc lang $ valCat $ lookType gfcc f

