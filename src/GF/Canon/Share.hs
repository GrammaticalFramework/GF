module Share (shareModule, OptSpec, basicOpt, fullOpt) where

import AbsGFC
import Ident
import GFC
import qualified CMacros as C
import Operations
import List
import qualified Modules as M

-- optimization: sharing branches in tables. AR 25/4/2003
-- following advice of Josef Svenningsson

type OptSpec = [Integer] ---
doOptFactor opt = elem 2 opt
basicOpt = []
fullOpt = [2]

shareModule :: OptSpec -> (Ident, CanonModInfo) -> (Ident, CanonModInfo)
shareModule opt (i,m) = case m of
  M.ModMod (M.Module mt st fs me ops js) -> 
    (i,M.ModMod (M.Module mt st fs me ops (mapTree (shareInfo opt) js)))
  _ -> (i,m)

shareInfo opt (c, CncCat ty t m) = (c, CncCat ty (shareOpt opt t) m)
shareInfo opt (c, CncFun k xs t m) = (c, CncFun k xs (shareOpt opt t) m)
shareInfo _ i = i

-- the function putting together optimizations
shareOpt :: OptSpec -> Term -> Term
shareOpt opt 
  | doOptFactor opt = share . factor 0
  | otherwise = share

-- we need no counter to create new variable names, since variables are 
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


-- do even more: factor parametric branches

factor :: Int -> Term -> Term
factor i t = case t of
  T _ [_] -> t
  T _ []  -> t
  T ty cs -> T ty $ factors i [Cas [p] (factor (i+1) v) | Cas ps v <- cs, p <- ps]
  R lts   -> R [Ass l (factor i t) | Ass l t <- lts]
  P t l   -> P (factor i t) l
  S t a   -> S (factor i t) (factor i a)
  C t a   -> C (factor i t) (factor i a)
  FV ts   -> FV (map (factor i) ts)

  _ -> t
 where

   factors i psvs =   -- we know psvs has at least 2 elements
     let p   = pIdent i
         vs' = map (mkFun p) psvs
     in if   allEqs vs'
        then mkCase p vs' 
        else psvs

   mkFun p (Cas [patt] val) = replace (C.patt2term patt) (LI p) val

   allEqs (v:vs) = all (==v) vs

   mkCase p (v:_) = [Cas [PV p] v]

pIdent i = identC ("p__" ++ show i)


--  we need to replace subterms

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

