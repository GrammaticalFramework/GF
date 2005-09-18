----------------------------------------------------------------------
-- |
-- Module      : Subexpressions
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/18 22:55:46 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.1 $
--
-- Common subexpression elimination.
-- all tables. AR 18\/9\/2005.
-----------------------------------------------------------------------------

module GF.Canon.Subexpressions where -- (subelimCanon) where

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

type TermList = FiniteMap Term (Int,Int) -- number of occs, id

type TermM a = STM (TermList,Int) a

prSubtermStat :: CanonGrammar -> String
prSubtermStat gr = unlines [prt mo ++++ expsIn mo js | (mo,js) <- mos] where
  mos = [(i, tree2list (M.jments m)) | (i, M.ModMod m) <- M.modules gr, M.isModCnc m]
  expsIn mo js = err id id $ do
   (js', (tree,nu)) <- appSTM (getSubtermsMod mo js) (emptyFM,0)
   let list0 = filter ((>1) . fst . snd) $ fmToList tree
   let list1 = sortBy (\ (_,(m,_)) (_,(n,_)) -> compare n m) list0
   return $ unlines [show n ++ "\t" ++ prt trm | (trm,(n,_)) <- list1]

elimSubtermsMod :: (Ident,CanonModInfo) -> Err (Ident, CanonModInfo)
elimSubtermsMod (mo,m) = case m of
  M.ModMod (M.Module mt st fs me ops js) -> do
    (js',(tree,_)) <- appSTM (getSubtermsMod mo (tree2list js)) (emptyFM,0)
    js2 <- liftM buildTree $ addSubexpConsts tree js'
    return (mo,M.ModMod (M.Module mt st fs me ops js2))
  _ -> return (mo,m)

addSubexpConsts :: FiniteMap Term (Int,Int) -> [(Ident,Info)] -> Err [(Ident,Info)]
addSubexpConsts tree lins = do
  let opers = [oper id trm | (trm,(nu,id)) <- list, nu > 1]
  mapM filterOne $ opers ++ lins
 where

   filterOne (f,def) = case def of
     CncFun ci xs trm pn -> do
       trm' <- recomp trm
       return (f,CncFun ci xs trm' pn)
     ResOper ty trm -> do
       trm' <- recomp trm
       return (f,ResOper ty trm')
     _ -> return (f,def)
   recomp t = case t of
     I (CIQ _ e) -> do
       (nu,exp) <- getCount e
       if nu > 1 then return t else recomp exp 
     _ -> composOp recomp t
   list = fmToList tree
   tree' = listToFM $ map (\ (e, (nu,id)) -> (ident id,(nu,e))) $ list
   getCount e = case lookupFM tree' e of
     Just v -> return v
     _ -> return (2,undefined)  --- global from elsewhere: keep
   oper id trm = (ident id, ResOper TStr trm) --- type TStr does not matter

getSubtermsMod :: Ident -> [(Ident,Info)] -> TermM [(Ident,Info)]
getSubtermsMod mo js = do
  js' <- mapM getInfo js
  tryAgain
  tryAgain --- do twice instead of fixpoint iteration
  return js' ----
 where
   getInfo fi@(f,i) = case i of
     CncFun ci xs trm pn -> do
       trm' <- getSubterms mo trm
       return $ (f,CncFun ci xs trm' pn)
     _ -> return fi
   tryAgain = do
     (ts,i) <- readSTM
     let trms = map fst $ fmToList ts
     mapM (getSubtermsAgain mo) trms
     (ts',i') <- readSTM
     if False ---- i' > i || count ts' > count ts 
       then tryAgain
       else return ()
   count = sum . map (fst . snd) . fmToList -- how many subterms there are

getSubterms :: Ident -> Term -> TermM Term
getSubterms mo t = case t of
  Par _ (_:_) -> add t
  T _ cs      -> add t
  V _ ts      -> add t
  K (KP _ _)  -> add t
  _ -> composOp (getSubterms mo) t
 where
   add t = do
     (ts,i) <- readSTM
     let 
       ((count,id),next) = case lookupFM ts t of
         Just (nu,id) -> ((nu+1,id), i)
         _ ->            ((1,   i ), i+1)
     writeSTM (addToFM ts t (count,id), next)
     return $ I $ cident mo id

-- this is used in later phases of iteration
getSubtermsAgain :: Ident -> Term -> TermM Term
getSubtermsAgain mo t = case t of
  T ty cs -> do
    let (ps,ts) = unzip [(p,t) | Cas p t <- cs]
    ts' <- mapM (getSubterms mo) ts
    return $ T ty $ [Cas p t | (p,t) <- zip ps ts']
  V ty ts -> do
    liftM (V ty) $ mapM (getSubterms mo) ts
  Par _ _ -> return t
  K _     -> return t
  _ -> getSubterms mo t

ident :: Int -> Ident
ident i = identC ("A''" ++ show i) ---

cident :: Ident -> Int -> CIdent
cident mo = CIQ mo . ident


unSubelimCanon :: CanonGrammar -> CanonGrammar
unSubelimCanon gr@(M.MGrammar modules) = 
    M.MGrammar $ map unparModule modules where 

  unparModule (i,m) = case m of
    M.ModMod (M.Module mt@(M.MTConcrete _) st fs me ops js) ->
      (i, M.ModMod (M.Module mt st fs me ops (mapTree unparInfo js)))
    _ -> (i,m)

  unparInfo (c,info) = case info of
    CncFun k xs t m -> (c, CncFun k xs (unparTerm t) m)
    _ -> (c,info)

  unparTerm t = case t of
    I c -> errVal t $ liftM unparTerm $ lookupGlobal gr c 
    _ -> C.composSafeOp unparTerm t
