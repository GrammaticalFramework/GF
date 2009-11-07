----------------------------------------------------------------------
-- |
-- Module      : BackOpt
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

module GF.Compile.BackOpt (shareModule) where

import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Infra.Option
import qualified GF.Grammar.Macros as C
import GF.Data.Operations
import Data.List
import qualified GF.Infra.Modules as M
import qualified Data.ByteString.Char8 as BS

import Data.Set (Set)
import qualified Data.Set as Set

shareModule :: Options -> SourceModule -> SourceModule
shareModule opts (i,mo) = (i,M.replaceJudgements mo (mapTree (shareInfo optim) (M.jments mo)))
  where
    optim = flag optOptimizations opts

type OptSpec = Set Optimization

shareInfo :: OptSpec -> (Ident, Info) -> Info
shareInfo opt (c, CncCat ty (Just t) m) = CncCat ty (Just (shareOptim opt c t)) m
shareInfo opt (c, CncFun kxs (Just t) m) = CncFun kxs (Just (shareOptim opt c t)) m
shareInfo opt (c, ResOper ty (Just t)) = ResOper ty (Just (shareOptim opt c t))
shareInfo _ (_,i) = i

-- the function putting together optimizations
shareOptim :: OptSpec -> Ident -> Term -> Term
shareOptim opt c =   (if OptValues      `Set.member` opt then values     else id)
                   . (if OptParametrize `Set.member` opt then factor c 0 else id)

-- do even more: factor parametric branches

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

qqIdent c i = identC (BS.pack ("q_" ++ showIdent c ++ "__" ++ show i))


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
