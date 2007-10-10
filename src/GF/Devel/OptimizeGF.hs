----------------------------------------------------------------------
-- |
-- Module      : OptimizeGF
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:21:33 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.6 $
--
-- Optimizations on GF source code: sharing, parametrization, value sets.
--
-- optimization: sharing branches in tables. AR 25\/4\/2003.
-- following advice of Josef Svenningsson
-----------------------------------------------------------------------------

module GF.Devel.OptimizeGF (shareModule,unshareModule) where 

import GF.Grammar.Grammar
import GF.Grammar.Lookup
import GF.Infra.Ident
import qualified GF.Grammar.Macros as C
import GF.Grammar.PrGrammar (prt)
import qualified GF.Infra.Modules as M
import GF.Data.Operations

import Data.List

shareModule :: (Ident, SourceModInfo) -> (Ident, SourceModInfo)
shareModule = processModule optim

unshareModule :: SourceGrammar -> (Ident, SourceModInfo) -> (Ident, SourceModInfo)
unshareModule gr = processModule (const (unoptim gr))

processModule :: 
  (Ident -> Term -> Term) -> (Ident, SourceModInfo) -> (Ident, SourceModInfo)
processModule opt (i,m) = case m of
  M.ModMod (M.Module mt st fs me ops js) -> 
    (i,M.ModMod (M.Module mt st fs me ops (mapTree (shareInfo opt) js)))
  _ -> (i,m)

shareInfo opt (c, CncCat ty (Yes t) m) = (c,CncCat ty (Yes (opt c t)) m)
shareInfo opt (c, CncFun kxs (Yes t) m) = (c,CncFun kxs (Yes (opt c t)) m)
shareInfo opt (c, ResOper ty (Yes t)) = (c,ResOper ty (Yes (opt c t)))
shareInfo _ i = i

-- the function putting together optimizations
optim :: Ident -> Term -> Term
optim c = values . factor c 0

-- we need no counter to create new variable names, since variables are 
-- local to tables (only true in GFC) ---

-- factor parametric branches

factor :: Ident -> Int -> Term -> Term
factor c i t = case t of
  T _ [_] -> t
  T _ []  -> t
  T (TComp ty) cs -> 
    T (TTyped ty) $ factors i [(p, factor c (i+1) v) | (p, v) <- cs]
  _ -> C.composSafeOp (factor c i) t
 where

   factors i psvs =   -- we know psvs has at least 2 elements
     let p   = qqIdent c i
         vs' = map (mkFun p) psvs
     in if   allEqs vs'
        then mkCase p vs' 
        else psvs

   mkFun p (patt, val) = replace (C.patt2term patt) (Vr p) val

   allEqs (v:vs) = all (==v) vs

   mkCase p (v:_) = [(PV p, v)]

--- we hope this will be fresh and don't check... in GFC would be safe

qqIdent c i = identC ("q_" ++ prt c ++ "__" ++ show i)


--  we need to replace subterms

replace :: Term -> Term -> Term -> Term
replace old new trm = case trm of
  
  -- these are the important cases, since they can correspond to patterns  
  QC _ _   | trm == old -> new
  App t ts | trm == old -> new
  App t ts              -> App (repl t) (repl ts)
  R _ | isRec && trm == old -> new
  _ -> C.composSafeOp repl trm
 where
   repl = replace old new
   isRec = case trm of
     R _ -> True
     _ -> False

-- It is very important that this is performed only after case
-- expansion since otherwise the order and number of values can
-- be incorrect. Guaranteed by the TComp flag.

values :: Term -> Term
values t = case t of
  T ty [(ps,t)]   -> T ty [(ps,values t)] -- don't destroy parametrization
  T (TComp ty) cs -> V ty [values t | (_, t) <- cs]
  _ -> C.composSafeOp values t


-- to undo the effect of factorization

unoptim :: SourceGrammar -> Term -> Term
unoptim gr = unfactor gr

unfactor :: SourceGrammar -> Term -> Term
unfactor gr t = case t of
  T (TTyped ty) [(PV x,u)] -> V ty [restore x v (unfac u) | v <- vals ty]
  _ -> C.composSafeOp unfac t
 where
   unfac = unfactor gr
   vals  = err error id . allParamValues gr
   restore x u t = case t of
     Vr y | y == x -> u
     _ -> C.composSafeOp (restore x u) t


