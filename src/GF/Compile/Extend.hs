module Extend where

import Grammar
import Ident
import PrGrammar
import Modules
import Update
import Macros
import Operations

import Monad

-- AR 14/5/2003 -- 11/11

-- The top-level function $extendModule$
-- extends a module symbol table by indirections to the module it extends

extendModule :: [SourceModule] -> SourceModule -> Err SourceModule
extendModule ms (name,mod) = case mod of
  ModMod (Module mt st fs me ops js) -> do

{- --- building the {s : Str} lincat from js0
    js  <- case mt of
      MTConcrete a -> do
        ModMod ma <- lookupModule (MGrammar ms) a
        let cats = [c | (c,AbsCat _ _) <- tree2list $ jments ma]
            jscs = [(c,CncCat (yes defLinType) nope nope) | c <- cats]
        return $ updatesTreeNondestr jscs js0
      _ -> return js0
-}

    case me of
      -- if the module is an extension of another one...
      Just n -> do
        (m0,isCompl) <- do
          m <- lookupModMod  (MGrammar ms) n

          -- test that the module types match, and find out if the old is complete
          testErr (sameMType (mtype m) mt) 
                    ("illegal extension type to module" +++ prt name)
          return (m,isCompleteModule m)

        -- build extension in a way depending on whether the old module is complete
        js1 <- extendMod isCompl n (jments m0) js

        -- if incomplete, throw away extension information
        let me' = if isCompl then me else Nothing 
        return $ (name,ModMod (Module mt st fs me' ops js1))

      -- if the module is not an extension, just return it
      _ -> return (name,mod)

-- When extending a complete module: new information is inserted,
-- and the process is interrupted if unification fails.
-- If the extended module is incomplete, its judgements are just copied.

extendMod :: Bool -> Ident -> BinTree (Ident,Info) -> BinTree (Ident,Info) -> 
             Err (BinTree (Ident,Info))
extendMod isCompl name old new = foldM try new $ tree2list old where
  try t i@(c,_) = errIn ("constant" +++ prt c) $
                  tryInsert (extendAnyInfo isCompl name) indirIf t i
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

extendAnyInfo :: Bool -> Ident -> Info -> Info -> Err Info
extendAnyInfo isc n i j = errIn ("building extension for" +++ prt n) $ case (i,j) of
  (AbsCat mc1 mf1, AbsCat mc2 mf2) -> 
    liftM2 AbsCat (updn isc n mc1 mc2) (updn isc n mf1 mf2) --- add cstrs
  (AbsFun mt1 md1, AbsFun mt2 md2) -> 
    liftM2 AbsFun (updn isc n mt1 mt2) (updn isc n md1 md2) --- add defs
  (ResParam mt1, ResParam mt2) -> 
    liftM ResParam $ updn isc n mt1 mt2
  (ResValue mt1, ResValue mt2) -> 
    liftM ResValue $ updn isc n mt1 mt2
  (ResOper mt1 m1, ResOper mt2 m2) ->           ---- extendResOper n mt1 m1 mt2 m2 
    liftM2 ResOper (updn isc n mt1 mt2) (updn isc n m1 m2)
  (CncCat mc1 mf1 mp1, CncCat mc2 mf2 mp2) -> 
    liftM3 CncCat (updn isc n mc1 mc2) (updn isc n mf1 mf2) (updn isc n mp1 mp2)
  (CncFun m mt1 md1, CncFun _ mt2 md2) -> 
    liftM2 (CncFun m) (updn isc n mt1 mt2) (updn isc n md1 md2)

----  (AnyInd _ _, ResOper _ _) -> return j ----

  _ -> Bad $ "cannot unify information in" ++++ show i ++++ "and" ++++ show j

--- where
   
updn isc n = if isc then (updatePerhaps n) else (updatePerhapsHard n)



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
