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
-- (Description of the module)
-----------------------------------------------------------------------------

module MkUnion (makeUnion) where

import Grammar
import Ident
import Modules
import Macros
import PrGrammar

import Operations
import Option

import List
import Monad

-- building union of modules
-- AR 1/3/2004 --- OBSOLETE 15/9/2004 with multiple inheritance

makeUnion :: SourceGrammar -> Ident -> ModuleType Ident -> [(Ident,[Ident])] ->
             Err SourceModule
makeUnion gr m ty imps = do
  ms    <- mapM (lookupModMod gr . fst) imps
  typ   <- return ty ---- getTyp ms
  ext   <- getExt [i | Just i <- map extends ms]
  ops   <- return $ nub $ concatMap opens ms
  flags <- return $ concatMap flags ms
  js    <- liftM (buildTree . concat) $ mapM getJments imps
  return $ (m, ModMod (Module typ MSComplete flags ext ops js))

 where
   getExt es = case es of
     [] -> return Nothing
     i:is -> if all (==i) is then return (Just i) 
               else Bad "different extended modules in union forbidden"
   getJments (i,fs) = do
     m  <- lookupModMod gr i
     let js = jments m
     if null fs 
       then 
         return (map (unqual i) $ tree2list js) 
       else do
         ds <- mapM (flip justLookupTree js) fs
         return $ map (unqual i) $ zip fs ds

   unqual i (f,d) = curry id f $ case d of
     AbsCat  pty pts -> AbsCat (qualCo pty) (qualPs pts)
     AbsFun  pty pt -> AbsFun (qualP pty) (qualP pt)
     AbsTrans t     -> AbsTrans $ qual t
     ResOper pty pt -> ResOper (qualP pty) (qualP pt)
     CncCat  pty pt pp -> CncCat (qualP pty) (qualP pt) (qualP pp)
     CncFun  mp pt pp -> CncFun (qualLin mp) (qualP pt) (qualP pp) ---- mp
     ResParam (Yes ps) -> ResParam (yes (map qualParam ps)) 
     ResValue pty ->  ResValue (qualP pty)
     _ -> d
    where
     qualP pt = case pt of
       Yes t -> yes $ qual t
       _ -> pt
     qualPs pt = case pt of
       Yes ts -> yes $ map qual ts
       _ -> pt
     qualCo pco = case pco of
       Yes co -> yes $ [(x,qual t) | (x,t) <- co]
       _ -> pco
     qual t = case t of
       Q m c  | m==i -> Cn c
       QC m c | m==i -> Cn c
       _ -> composSafeOp qual t
     qualParam (p,co) = (p,[(x,qual t) | (x,t) <- co])
     qualLin (Just (c,(co,t))) = (Just (c,([(x,qual t) | (x,t) <- co], qual t)))
     qualLin Nothing = Nothing
     
