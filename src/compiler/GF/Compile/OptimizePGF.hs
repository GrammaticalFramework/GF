module GF.Compile.OptimizePGF where

import PGF.CId
import PGF.Data
import PGF.Macros

import GF.Data.Operations

import Data.List
import qualified Data.Map as Map


-- back-end optimization: 
-- suffix analysis followed by common subexpression elimination

optPGF :: PGF -> PGF
optPGF = cseOptimize . suffixOptimize

suffixOptimize :: PGF -> PGF
suffixOptimize = mapConcretes opt
 where 
  opt cnc = cnc {
    lins = Map.map optTerm (lins cnc),
    lindefs = Map.map optTerm (lindefs cnc)
  }

cseOptimize :: PGF -> PGF
cseOptimize = mapConcretes subex

-- analyse word form lists into prefix + suffixes
-- suffix sets can later be shared by subex elim

optTerm :: Term -> Term  
optTerm tr = case tr of
    R ts@(_:_:_) | all isK ts -> mkSuff $ optToks [s | K (KS s) <- ts]
    R ts  -> R $ map optTerm ts
    P t v -> P (optTerm t) v
    _ -> tr
 where
  optToks ss = prf : suffs where
    prf = pref (head ss) (tail ss)
    suffs = map (drop (length prf)) ss
    pref cand ss = case ss of
      s1:ss2 -> if isPrefixOf cand s1 then pref cand ss2 else pref (init cand) ss
      _ -> cand
  isK t = case t of
    K (KS _) -> True
    _ -> False
  mkSuff ("":ws) = R (map (K . KS) ws)
  mkSuff (p:ws) = W p (R (map (K . KS) ws))


-- common subexpression elimination

---subex :: [(CId,Term)] -> [(CId,Term)]
subex :: Concr -> Concr
subex cnc = err error id $ do
  (tree,_) <- appSTM (getSubtermsMod cnc) (Map.empty,0)
  return $ addSubexpConsts tree cnc

type TermList = Map.Map Term (Int,Int) -- number of occs, id
type TermM a = STM (TermList,Int) a

addSubexpConsts :: TermList -> Concr -> Concr
addSubexpConsts tree cnc = cnc {
  opers = Map.fromList [(f,recomp f trm) | (f,trm) <- ops],
  lins  = rec lins,
  lindefs = rec lindefs
  }
 where
   ops = [(fid id, trm) | (trm,(_,id)) <- Map.assocs tree]
   mkOne (f,trm) = (f, recomp f trm)
   recomp f t = case Map.lookup t tree of
     Just (_,id) | fid id /= f -> F $ fid id -- not to replace oper itself
     _ -> case t of
       R ts   -> R $ map (recomp f) ts
       S ts   -> S $ map (recomp f) ts
       W s t  -> W s (recomp f t)
       P t p  -> P (recomp f t) (recomp f p)
       _ -> t
   fid n = mkCId $ "_" ++ show n
   rec field = Map.fromAscList [(f,recomp f trm) | (f,trm) <- Map.assocs (field cnc)]


getSubtermsMod :: Concr -> TermM TermList
getSubtermsMod cnc = do
  mapM getSubterms (Map.assocs (lins cnc))
  mapM getSubterms (Map.assocs (lindefs cnc))
  (tree0,_) <- readSTM
  return $ Map.filter (\ (nu,_) -> nu > 1) tree0
 where
   getSubterms (f,trm) = collectSubterms trm >> return ()

collectSubterms :: Term -> TermM ()
collectSubterms t = case t of
  R ts -> do
    mapM collectSubterms ts
    add t
  S ts -> do
    mapM collectSubterms ts
    add t
  W s u -> do
    collectSubterms u
    add t
  P p u -> do
    collectSubterms p
    collectSubterms u
    add t
  _ -> return ()
 where
   add t = do
     (ts,i) <- readSTM
     let 
       ((count,id),next) = case Map.lookup t ts of
         Just (nu,id) -> ((nu+1,id), i)
         _ ->            ((1,   i ), i+1)
     writeSTM (Map.insert t (count,id) ts, next)

