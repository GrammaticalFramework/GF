module GF.Command.PPrTree (tree2exp, exp2tree) where

import PGF.CId
import PGF.Data
import GF.Command.AbsGFShell

tree2exp t = case t of
  TApp f ts -> EApp (i2i f) (map tree2exp ts)
  TAbs xs t -> EAbs (map i2i xs) (tree2exp t)
  TId c     -> EApp (i2i c) []
  TInt i    -> EInt   i
  TStr s    -> EStr   s
  TFloat d  -> EFloat d
 where
   i2i (Ident s) = mkCId s

exp2tree t = case t of
  (EAbs xs e) -> TAbs (map i4i xs) (exp2tree e)
  (EApp f []) -> TId (i4i f)
  (EApp f es) -> TApp (i4i f) (map exp2tree es)
  (EInt   i)  -> TInt i
  (EStr   i)  -> TStr i
  (EFloat i)  -> TFloat i
  (EMeta  i)  -> TId (Ident "?") ----
  where
    i4i s = Ident (prCId s)
