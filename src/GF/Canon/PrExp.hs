----------------------------------------------------------------------
-- |
-- Module      : PrExp
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/02/18 19:21:07 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.4 $
--
-- print trees without qualifications
-----------------------------------------------------------------------------

module PrExp (prExp) where

import AbsGFC
import GFC

import Operations

prExp :: Exp -> String
prExp e = case e of
  EApp f a   -> pr1 f +++ pr2 a
  EAbsR x b  -> "\\" ++ prtt x +++ "->" +++ prExp b
  EAbs x _ b -> prExp $ EAbsR x b
  EProd x a b -> "(\\" ++ prtt x +++ ":" +++ prExp a ++ ")" +++ "->" +++ prExp b
  EAtomR a   -> prAtom a
  EAtom a _  -> prAtom a
  _ -> prtt e
 where
   pr1 e = case e of
     EAbsR _ _   -> prParenth $ prExp e
     EAbs _ _ _  -> prParenth $ prExp e
     EProd _ _ _ -> prParenth $ prExp e
     _ -> prExp e
   pr2 e = case e of
     EApp _ _ -> prParenth $ prExp e
     _ -> pr1 e

prAtom a = case a of
  AC c -> prCIdent c
  AD c -> prCIdent c
  _ -> prtt a

prCIdent (CIQ _ c) = prtt c
