----------------------------------------------------------------------
-- |
-- Module      : Subexpressions
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/20 09:32:56 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.4 $
--
-- Common subexpression elimination.
-- all tables. AR 18\/9\/2005.
-----------------------------------------------------------------------------

module GF.Canon.Subexpressions (
  elimSubtermsMod, prSubtermStat, unSubelimCanon, unSubelimModule
  ) where

import GF.Canon.AbsGFC
import GF.Infra.Ident
import GF.Canon.GFC
import GF.Canon.Look
import GF.Grammar.PrGrammar
import GF.Canon.CMacros as C
import GF.Data.Operations
import qualified GF.Infra.Modules as M

import Control.Monad
import Data.FiniteMap
import Data.List

{-
This module implements a simple common subexpression elimination
 for gfc grammars, to factor out shared subterms in lin rules.
It works in three phases: 

  (1) collectSubterms collects recursively all subterms of forms table and (P x..y)
      from lin definitions (experience shows that only these forms
      tend to get shared) and counts how many times they occur
  (2) addSubexpConsts takes those subterms t that occur more than once
      and creates definitions of form "oper A''n = t" where n is a
      fresh number; notice that we assume no ids of this form are in
      scope otherwise
  (3) elimSubtermsMod goes through lins and the created opers by replacing largest
      possible subterms by the newly created identifiers

The optimization is invoked in gf by the flag i -subs.

If an application does not support GFC opers, the effect of this
optimization can be undone by the function unSubelimCanon.

The function unSubelimCanon can be used to diagnostisize how much
cse is possible in the grammar. It is used by the flag pg -printer=subs.

-}

-- exported functions

elimSubtermsMod :: (Ident,CanonModInfo) -> Err (Ident, CanonModInfo)
elimSubtermsMod (mo,m) = case m of
  M.ModMod (M.Module mt st fs me ops js) -> do
    (tree,_) <- appSTM (getSubtermsMod mo (tree2list js)) (emptyFM,0)
    js2 <- liftM buildTree $ addSubexpConsts mo tree $ tree2list js
    return (mo,M.ModMod (M.Module mt st fs me ops js2))
  _ -> return (mo,m)

prSubtermStat :: CanonGrammar -> String
prSubtermStat gr = unlines [prt mo ++++ expsIn mo js | (mo,js) <- mos] where
  mos = [(i, tree2list (M.jments m)) | (i, M.ModMod m) <- M.modules gr, M.isModCnc m]
  expsIn mo js = err id id $ do
    (tree,_) <- appSTM (getSubtermsMod mo js) (emptyFM,0)
    let list0 = fmToList tree
    let list1 = sortBy (\ (_,(m,_)) (_,(n,_)) -> compare n m) list0
    return $ unlines [show n ++ "\t" ++ prt trm | (trm,(n,_)) <- list1]

unSubelimCanon :: CanonGrammar -> CanonGrammar
unSubelimCanon gr@(M.MGrammar modules) = 
    M.MGrammar $ map unSubelimModule modules 
 
unSubelimModule :: CanonModule -> CanonModule
unSubelimModule mo@(i,m) = case m of
    M.ModMod (M.Module mt@(M.MTConcrete _) st fs me ops js) | hasSub ljs ->
      (i, M.ModMod (M.Module mt st fs me ops 
                     (rebuild (map unparInfo ljs)))) 
                        where ljs = tree2list js
    _ -> (i,m)
  where
    -- perform this iff the module has opers
    hasSub ljs = not $ null [c | (c,ResOper _ _) <- ljs]
    unparInfo (c,info) = case info of
      CncFun k xs t m -> [(c, CncFun k xs (unparTerm t) m)]
      ResOper _ _ -> []
      _ -> [(c,info)]
    unparTerm t = case t of
      I c -> errVal t $ liftM unparTerm $ lookupGlobal gr c 
      _ -> C.composSafeOp unparTerm t
    gr = M.MGrammar [mo] 
    rebuild = buildTree . concat

-- implementation

type TermList = FiniteMap Term (Int,Int) -- number of occs, id
type TermM a = STM (TermList,Int) a

addSubexpConsts :: Ident -> FiniteMap Term (Int,Int) -> [(Ident,Info)] -> Err [(Ident,Info)]
addSubexpConsts mo tree lins = do
  let opers = [oper id trm | (trm,(_,id)) <- list]
  mapM mkOne $ opers ++ lins
 where

   mkOne (f,def) = case def of
     CncFun ci xs trm pn -> do
       trm' <- recomp f trm
       return (f,CncFun ci xs trm' pn)
     ResOper ty trm -> do
       trm' <- recomp f trm
       return (f,ResOper ty trm')
     _ -> return (f,def)
   recomp f t = case lookupFM tree t of
     Just (_,id) | ident id /= f -> return $ I $ cident mo id
     _ -> composOp (recomp f) t

   list = fmToList tree

   oper id trm = (ident id, ResOper TStr trm) --- type TStr does not matter

getSubtermsMod :: Ident -> [(Ident,Info)] -> TermM (FiniteMap Term (Int,Int))
getSubtermsMod mo js = do
  mapM (getInfo (collectSubterms mo)) js
  (tree0,_) <- readSTM
  return $ filterFM (\_ (nu,_) -> nu > 1) tree0
 where
   getInfo get fi@(f,i) = case i of
     CncFun ci xs trm pn -> do
       get trm
       return $ fi
     ResOper ty trm -> do
       get trm
       return $ fi
     _ -> return fi

collectSubterms :: Ident -> Term -> TermM Term
collectSubterms mo t = case t of
  Par _ (_:_) -> add t
  T ty cs -> do
    let (ps,ts) = unzip [(p,t) | Cas p t <- cs]
    mapM (collectSubterms mo) ts
    add t
  V ty ts -> do
    mapM (collectSubterms mo) ts
    add t
  K (KP _ _)  -> add t
  _ -> composOp (collectSubterms mo) t
 where
   add t = do
     (ts,i) <- readSTM
     let 
       ((count,id),next) = case lookupFM ts t of
         Just (nu,id) -> ((nu+1,id), i)
         _ ->            ((1,   i ), i+1)
     writeSTM (addToFM ts t (count,id), next)
     return t --- only because of composOp

ident :: Int -> Ident
ident i = identC ("A''" ++ show i) ---

cident :: Ident -> Int -> CIdent
cident mo = CIQ mo . ident
