module GF.Devel.OptimizeGFCC where

import qualified GF.Canon.GFCC.AbsGFCC as C
import qualified GF.Canon.GFCC.DataGFCC as D
import qualified GF.Canon.GFCC.PrintGFCC as Pr

import qualified GF.Infra.Option as O

import GF.Infra.Option
import GF.Data.Operations

import Data.List
import Data.Char (isDigit)
import qualified Data.Map as Map
import Debug.Trace ----


-- back-end optimization: 
-- suffix analysis followed by common subexpression elimination

optGFCC :: D.GFCC -> D.GFCC
optGFCC gfcc = gfcc {
  D.concretes = 
    Map.fromAscList
    [(lang, (opt cnc)) | (lang,cnc) <- Map.assocs (D.concretes gfcc)]
  }
 where 
  opt cnc = Map.fromAscList $ subex [(f,optTerm t) | (f,t) <- Map.assocs cnc]

-- analyse word form lists into prefix + suffixes
-- suffix sets can later be shared by subex elim

optTerm :: C.Term -> C.Term  
optTerm tr = case tr of
    C.R ts@(_:_:_) | all isK ts -> mkSuff $ optToks [s | C.K (C.KS s) <- ts]
    C.R ts  -> C.R $ map optTerm ts
    C.P t v -> C.P (optTerm t) v
    C.L x t -> C.L x (optTerm t)
    _ -> tr
 where
  optToks ss = prf : suffs where
    prf = pref (head ss) (tail ss)
    suffs = map (drop (length prf)) ss
    pref cand ss = case ss of
      s1:ss2 -> if isPrefixOf cand s1 then pref cand ss2 else pref (init cand) ss
      _ -> cand
  isK t = case t of
    C.K (C.KS _) -> True
    _ -> False
  mkSuff ("":ws) = C.R (map (C.K . C.KS) ws)
  mkSuff (p:ws) = C.W p (C.R (map (C.K . C.KS) ws))


-- common subexpression elimination; see ./Subexpression.hs for the idea

subex :: [(C.CId,C.Term)] -> [(C.CId,C.Term)]
subex js = errVal js $ do
  (tree,_) <- appSTM (getSubtermsMod js) (Map.empty,0)
  return $ addSubexpConsts tree js

type TermList = Map.Map C.Term (Int,Int) -- number of occs, id
type TermM a = STM (TermList,Int) a

addSubexpConsts :: TermList -> [(C.CId,C.Term)] -> [(C.CId,C.Term)]
addSubexpConsts tree lins =
  let opers = sortBy (\ (f,_) (g,_) -> compare f g)
                [(fid id, trm) | (trm,(_,id)) <- list]
  in map mkOne $ opers ++ lins
 where
   mkOne (f,trm) = (f, recomp f trm)
   recomp f t = case Map.lookup t tree of
     Just (_,id) | fid id /= f -> C.F $ fid id -- not to replace oper itself
     _ -> case t of
       C.R ts   -> C.R $ map (recomp f) ts
       C.S ts   -> C.S $ map (recomp f) ts
       C.W s t  -> C.W s (recomp f t)
       C.P t p  -> C.P (recomp f t) (recomp f p)
       C.RP t p -> C.RP (recomp f t) (recomp f p)
       C.L x t  -> C.L x (recomp f t)
       _ -> t
   fid n = C.CId $ "_" ++ show n
   list = Map.toList tree

getSubtermsMod :: [(C.CId,C.Term)] -> TermM TermList
getSubtermsMod js = do
  mapM (getInfo collectSubterms) js
  (tree0,_) <- readSTM
  return $ Map.filter (\ (nu,_) -> nu > 1) tree0
 where
   getInfo get (f,trm) = do
     get trm
     return ()

collectSubterms :: C.Term -> TermM ()
collectSubterms t = case t of
  C.R ts -> do
    mapM collectSubterms ts
    add t
  C.RP u v -> do
    collectSubterms v
    add t
  C.S ts -> do
    mapM collectSubterms ts
    add t
  C.W s u -> do
    collectSubterms u
    add t
  C.P p u -> do
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

