----------------------------------------------------------------------
-- |
-- Module      : (Module)
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date $ 
-- > CVS $Author $
-- > CVS $Revision $
--
-- Optimizations on GFC code: sharing, parametrization, value sets.
--
-- optimization: sharing branches in tables. AR 25\/4\/2003.
-- following advice of Josef Svenningsson
-----------------------------------------------------------------------------

module Share (shareModule, OptSpec, shareOpt, paramOpt, valOpt, allOpt) where

import AbsGFC
import Ident
import GFC
import qualified CMacros as C
import PrGrammar (prt)
import Operations
import List
import qualified Modules as M

type OptSpec = [Integer] ---

doOptFactor opt = elem 2 opt
doOptValues opt = elem 3 opt

shareOpt :: OptSpec
shareOpt = []

paramOpt :: OptSpec
paramOpt = [2]

valOpt :: OptSpec
valOpt = [3]

allOpt :: OptSpec
allOpt = [2,3]

shareModule :: OptSpec -> (Ident, CanonModInfo) -> (Ident, CanonModInfo)
shareModule opt (i,m) = case m of
  M.ModMod (M.Module mt st fs me ops js) -> 
    (i,M.ModMod (M.Module mt st fs me ops (mapTree (shareInfo opt) js)))
  _ -> (i,m)

shareInfo opt (c, CncCat ty t m) = (c, CncCat ty (shareOptim opt c t) m)
shareInfo opt (c, CncFun k xs t m) = (c, CncFun k xs (shareOptim opt c t) m)
shareInfo _ i = i

-- | the function putting together optimizations
shareOptim :: OptSpec -> Ident -> Term -> Term
shareOptim opt c 
  | doOptFactor opt && doOptValues opt = values . factor c 0
  | doOptFactor opt = share . factor c 0
  | doOptValues opt = values    
  | otherwise = share

-- | we need no counter to create new variable names, since variables are 
-- local to tables
share :: Term -> Term
share t = case t of
  T ty cs  -> shareT ty [(p, share v) | Cas ps v <- cs, p <- ps]  -- only substant.
  R lts -> R [Ass l (share t) | Ass l t <- lts]
  P t l -> P (share t) l
  S t a -> S (share t) (share a)
  C t a -> C (share t) (share a)
  FV ts -> FV (map share ts)

  _ -> t  -- including D, which is always born shared

 where
   shareT ty = finalize ty . groupC . sortC
 
   sortC :: [(Patt,Term)] -> [(Patt,Term)]
   sortC = sortBy $ \a b -> compare (snd a) (snd b)

   groupC :: [(Patt,Term)] -> [[(Patt,Term)]]
   groupC = groupBy $ \a b -> snd a == snd b

   finalize :: CType -> [[(Patt,Term)]] -> Term
   finalize ty css = T ty [Cas (map fst ps) t | ps@((_,t):_) <- css]


-- | do even more: factor parametric branches
factor :: Ident -> Int -> Term -> Term
factor c i t = case t of
  T _ [_] -> t
  T _ []  -> t
  T ty cs -> T ty $ factors i [Cas [p] (factor c (i+1) v) | Cas ps v <- cs, p <- ps]
  R lts   -> R [Ass l (factor c i t) | Ass l t <- lts]
  P t l   -> P (factor c i t) l
  S t a   -> S (factor c i t) (factor c i a)
  C t a   -> C (factor c i t) (factor c i a)
  FV ts   -> FV (map (factor c i) ts)

  _ -> t
 where

   factors i psvs =   -- we know psvs has at least 2 elements
     let p   = pIdent c i
         vs' = map (mkFun p) psvs
     in if   allEqs vs'
        then mkCase p vs' 
        else psvs

   mkFun p (Cas [patt] val) = replace (C.patt2term patt) (LI p) val

   allEqs (v:vs) = all (==v) vs

   mkCase p (v:_) = [Cas [PV p] v]

pIdent c i = identC ("p_" ++ prt c ++ "__" ++ show i)


-- | we need to replace subterms
replace :: Term -> Term -> Term -> Term
replace old new trm = case trm of
  T ty cs -> T ty [Cas p (repl v) | Cas p v <- cs]
  P t l   -> P (repl t) l
  S t a   -> S (repl t) (repl a)
  C t a   -> C (repl t) (repl a)
  FV ts   -> FV (map repl ts)
  
  -- these are the important cases, since they can correspond to patterns  
  Con c ts | trm == old -> new
  Con c ts            -> Con c (map repl ts)
  R _ | isRec && trm == old -> new
  R lts   -> R [Ass l (repl t) | Ass l t <- lts]

  _ -> trm
 where
   repl = replace old new
   isRec = case trm of
     R _ -> True
     _ -> False

values :: Term -> Term
values t = case t of
  T ty [c] -> T ty [Cas p (values t) | Cas p t <- [c]] -- preserve parametrization
  T ty cs  -> V ty [values t | Cas _ t <- cs] -- assumes proper order
  _ -> C.composSafeOp values t
