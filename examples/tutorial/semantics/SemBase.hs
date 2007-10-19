module SemBase where

import GSyntax
import Logic

-- translation of Base syntax to Logic

iS :: GS -> Prop
iS s = case s of
  GPredAP np ap -> iNP np (iAP ap)
  GConjS c s t  -> iConj c (iS s) (iS t)

iNP :: GNP -> (Exp -> Prop) -> Prop
iNP np p = case np of
  GEvery cn -> All   (If  (iCN cn var) (p var)) ----
  GSome  cn -> Exist (And (iCN cn var) (p var)) ----
  GConjNP c np1 np2 -> iConj c (iNP np1 p) (iNP np2 p)
  GUseInt (GInt i) -> p (int i)

iAP :: GAP -> Exp -> Prop
iAP ap e = case ap of
  GComplA2 a2 np    -> iNP np (iA2 a2 e)
  GConjAP c ap1 ap2 -> iConj c (iAP ap1 e) (iAP ap2 e)
  GEven -> ev e
  GOdd -> Not (ev e)

iCN :: GCN -> Exp -> Prop
iCN cn e = case cn of
  GModCN ap cn0 -> And (iCN cn0 e) (iAP ap e)
  GNumber -> eq e e

iConj :: GConj -> Prop -> Prop -> Prop
iConj c = case c of
  GAnd -> And
  GOr  -> Or

iA2 :: GA2 -> Exp -> Exp -> Prop
iA2 a2 e1 e2 = case a2 of
  GGreater -> lt e2 e1
  GSmaller -> lt e1 e2 
  GEqual   -> eq e1 e2

var = Var 0
