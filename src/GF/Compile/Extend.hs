module Extend where

import Grammar
import Ident
import PrGrammar
import Modules
import Update
import Macros
import Operations

import Monad

-- AR 14/5/2003

-- The top-level function $extendModInfo$
-- extends a module symbol table by indirections to the module it extends

extendModInfo :: Ident -> SourceModInfo -> SourceModInfo -> Err SourceModInfo
extendModInfo name old new = case (old,new) of
  (ModMod m0, ModMod (Module mt fs _ ops js)) -> do
    testErr (mtype m0 == mt) ("illegal extension type at module" +++ show name)
    js' <- extendMod name (jments m0) js
    return $ ModMod (Module mt fs Nothing ops js)

-- this is what happens when extending a module: new information is inserted,
-- and the process is interrupted if unification fails

extendMod :: Ident -> BinTree (Ident,Info) -> BinTree (Ident,Info) -> 
             Err (BinTree (Ident,Info))
extendMod name old new = 
  foldM (tryInsert (extendAnyInfo name) (indirInfo name)) new $ tree2list old

indirInfo :: Ident -> Info -> Info
indirInfo n info = AnyInd b n' where 
  (b,n') = case info of
    ResValue _ -> (True,n)
    ResParam _ -> (True,n)
    AnyInd b k -> (b,k)
    _ -> (False,n) ---- canonical in Abs

{- ----
case info of
  AbsFun pty ptr -> AbsFun (perhIndir n pty) (perhIndir n ptr)
  ---- find a suitable indirection for cat info!

  ResOper pty ptr -> ResOper (perhIndir n pty) (perhIndir n ptr)
  ResParam pp -> ResParam (perhIndir n pp) 
  _ -> info

  CncCat pty ptr ppr -> CncCat (perhIndir n pty) (perhIndir n ptr) (perhIndir n ppr)
  CncFun m ptr   ppr -> CncFun m (perhIndir n ptr)                 (perhIndir n ppr)
-}

perhIndir :: Ident -> Perh a -> Perh a
perhIndir n p = case p of
  Yes _ -> May n
  _ -> p

extendAnyInfo :: Ident -> Info -> Info -> Err Info
extendAnyInfo n i j = case (i,j) of
  (AbsCat mc1 mf1, AbsCat mc2 mf2) -> 
    liftM2 AbsCat (updatePerhaps n mc1 mc2) (updatePerhaps n mf1 mf2) --- add cstrs
  (AbsFun mt1 md1, AbsFun mt2 md2) -> 
    liftM2 AbsFun (updatePerhaps n mt1 mt2) (updatePerhaps n md1 md2) --- add defs

  (ResParam mt1, ResParam mt2) -> liftM ResParam $ updatePerhaps n mt1 mt2
  (ResValue mt1, ResValue mt2) -> liftM ResValue $ updatePerhaps n mt1 mt2
  (ResOper mt1 m1, ResOper mt2 m2) -> 
    liftM2 ResOper (updatePerhaps n mt1 mt2) (updatePerhaps n m1 m2)

  (CncCat mc1 mf1 mp1, CncCat mc2 mf2 mp2) -> 
    liftM3 CncCat (updatePerhaps n mc1 mc2) 
                  (updatePerhaps n mf1 mf2) (updatePerhaps n mp1 mp2)
  (CncFun m mt1 md1, CncFun _ mt2 md2) -> 
    liftM2 (CncFun m) (updatePerhaps n mt1 mt2) (updatePerhaps n md1 md2)

  _ -> Bad $ "cannot unify information for" +++ show n
