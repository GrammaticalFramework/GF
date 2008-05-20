module GF.Command.PPrTree (pTree, prExp, tree2exp) where

import GF.GFCC.DataGFCC
import GF.GFCC.CId
import GF.GFCC.Macros
import qualified GF.Command.ParGFShell as P
import GF.Command.PrintGFShell
import GF.Command.AbsGFShell
import GF.Data.ErrM

pTree :: String -> Exp
pTree s = case P.pTree (P.myLexer s) of
  Ok t -> tree2exp t
  Bad s -> error s

tree2exp t = case t of
  TApp f ts -> tree (AC (i2i f)) (map tree2exp ts)  
  TAbs xs t -> DTr (map i2i xs ++ ys) f ts where DTr ys f ts = tree2exp t 
  TId c     -> tree (AC (i2i c)) [] 
  TInt i    -> tree (AI i) []
  TStr s    -> tree (AS s) []
  TFloat d  -> tree (AF d) [] 
 where
   i2i (Ident s) = CId s

prExp :: Exp -> String
prExp = printTree . exp2tree

exp2tree (DTr xs at ts) = tabs (map i4i xs) (tapp at (map exp2tree ts)) 
  where
    tabs [] t = t
    tabs ys t = TAbs ys t
    tapp (AC f) [] = TId (i4i f)
    tapp (AC f) vs = TApp (i4i f) vs
    tapp (AI i) [] = TInt i
    tapp (AS i) [] = TStr i
    tapp (AF i) [] = TFloat i
    tapp (AM i) [] = TId (Ident "?") ----
    i4i (CId s) = Ident s
