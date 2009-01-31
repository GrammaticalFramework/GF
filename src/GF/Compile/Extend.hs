----------------------------------------------------------------------
-- |
-- Module      : Extend
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/30 21:08:14 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.18 $
--
-- AR 14\/5\/2003 -- 11\/11
--
-- The top-level function 'extendModule'
-- extends a module symbol table by indirections to the module it extends
-----------------------------------------------------------------------------

module GF.Compile.Extend (extendModule, extendMod
	      ) where

import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Grammar.PrGrammar
import GF.Infra.Modules
import GF.Compile.Update
import GF.Grammar.Macros
import GF.Data.Operations

import Control.Monad
import Data.List(nub)

extendModule :: [SourceModule] -> SourceModule -> Err SourceModule
extendModule ms (name,m)
  ---- Just to allow inheritance in incomplete concrete (which are not
  ---- compiled anyway), extensions are not built for them.
  ---- Should be replaced by real control. AR 4/2/2005
  | mstatus m == MSIncomplete && isModCnc m = return (name,m)
  | otherwise                               = do m' <- foldM extOne m (extend m) 
                                                 return (name,m')
 where
   extOne mo (n,cond) = do
     m0 <- lookupModule (MGrammar ms) n

     -- test that the module types match, and find out if the old is complete
     testErr (sameMType (mtype m) (mtype mo)) 
             ("illegal extension type to module" +++ prt name)

     let isCompl = isCompleteModule m0

     -- build extension in a way depending on whether the old module is complete
     js1 <- extendMod isCompl (n, isInherited cond) name (jments m0) (jments mo)

     -- if incomplete, throw away extension information
     return $ 
          if isCompl
            then mo {jments = js1}
            else mo {extend = filter ((/=n) . fst) (extend mo)
                    ,mexdeps= nub (n : mexdeps mo)
                    ,jments = js1
                    }

-- | When extending a complete module: new information is inserted,
-- and the process is interrupted if unification fails.
-- If the extended module is incomplete, its judgements are just copied.
extendMod :: Bool -> (Ident,Ident -> Bool) -> Ident -> 
             BinTree Ident Info -> BinTree Ident Info -> 
             Err (BinTree Ident Info)
extendMod isCompl (name,cond) base old new = foldM try new $ tree2list old where
  try t i@(c,_) | not (cond c) = return t
  try t i@(c,_) = errIn ("constant" +++ prt c) $
                  tryInsert (extendAnyInfo isCompl name base) indirIf t i
  indirIf = if isCompl then indirInfo name else id

indirInfo :: Ident -> Info -> Info
indirInfo n info = AnyInd b n' where 
  (b,n') = case info of
    ResValue _ -> (True,n)
    ResParam _ -> (True,n)
    AbsFun _ (Yes EData) -> (True,n) 
    AnyInd b k -> (b,k)
    _ -> (False,n) ---- canonical in Abs

perhIndir :: Ident -> Perh a -> Perh a
perhIndir n p = case p of
  Yes _ -> May n
  _ -> p

extendAnyInfo :: Bool -> Ident -> Ident -> Info -> Info -> Err Info
extendAnyInfo isc n o i j = 
 errIn ("building extension for" +++ prt n +++ "in" +++ prt o) $ case (i,j) of
  (AbsCat mc1 mf1, AbsCat mc2 mf2) -> 
    liftM2 AbsCat (updn isc n mc1 mc2) (updn isc n mf1 mf2) --- add cstrs
  (AbsFun mt1 md1, AbsFun mt2 md2) -> 
    liftM2 AbsFun (updn isc n mt1 mt2) (updn isc n md1 md2) --- add defs
  (ResParam mt1, ResParam mt2) -> 
    liftM ResParam $ updn isc n mt1 mt2
  (ResValue mt1, ResValue mt2) -> 
    liftM ResValue $ updn isc n mt1 mt2
  (_, ResOverload ms t) | elem n ms ->
    return $ ResOverload ms t
  (ResOper mt1 m1, ResOper mt2 m2) ->           ---- extendResOper n mt1 m1 mt2 m2 
    liftM2 ResOper (updn isc n mt1 mt2) (updn isc n m1 m2)
  (CncCat mc1 mf1 mp1, CncCat mc2 mf2 mp2) -> 
    liftM3 CncCat (updn isc n mc1 mc2) (updn isc n mf1 mf2) (updn isc n mp1 mp2)
  (CncFun m mt1 md1, CncFun _ mt2 md2) -> 
    liftM2 (CncFun m) (updn isc n mt1 mt2) (updn isc n md1 md2)

----  (AnyInd _ _, ResOper _ _) -> return j ----

  (AnyInd b1 m1, AnyInd b2 m2) -> do
    testErr (b1 == b2) "inconsistent indirection status"
---- commented out as work-around for a spurious problem in
---- TestResourceFre; should look at building of completion. 17/11/2004 
    testErr (m1 == m2) $ 
      "different sources of indirection: " +++ show m1 +++ show m2
    return i

  _ -> Bad $ "cannot unify information in" ++++ show i ++++ "and" ++++ show j

--- where
   
updn isc n = if isc  then (updatePerhaps n) else (updatePerhapsHard n)
updc isc n = if True then (updatePerhaps n) else (updatePerhapsHard n)



{- ---- no more needed: this is done in Rebuild
-- opers declared in an interface and defined in an instance are a special case

extendResOper n mt1 m1 mt2 m2 = case (m1,m2) of
  (Nope,_) -> return $ ResOper (strip mt1) m2
  _ -> liftM2 ResOper (updatePerhaps n mt1 mt2) (updatePerhaps n m1 m2)
 where
   strip (Yes t) = Yes $ strp t
   strip m = m
   strp t = case t of
     Q _ c  -> Vr c
     QC _ c -> Vr c
     _ -> composSafeOp strp t
-}
