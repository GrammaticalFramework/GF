module Rebuild where

import Grammar
import ModDeps
import PrGrammar
import Lookup
import Extend
import Macros

import Ident
import Modules
import Operations

-- rebuilding instance + interface, and "with" modules, prior to renaming. 
-- AR 24/10/2003

rebuildModule :: [SourceModule] -> SourceModule -> Err SourceModule
rebuildModule ms mo@(i,mi) = do
  let gr = MGrammar ms
  deps <- moduleDeps ms
  is   <- openInterfaces deps i
  mi' <- case mi of

    -- add the interface type signatures into an instance module
    ModMod m -> do
      testErr (null is || mstatus m == MSIncomplete) 
              ("module" +++ prt i +++ "must be declared incomplete") 
      mi' <- case mtype m of
        MTInstance i0 -> do
          m0 <- lookupModule gr i0
          m' <- case m0 of
            ModMod m1 | isResourceModule m0 -> do ---- mtype m1 == MTInterface -> do
----              checkCompleteInstance m1 m -- do this later, in CheckGrammar
              js' <- extendMod i (jments m1) (jments m)
              return $ replaceJudgements m js'
            _ -> prtBad "interface expected instead of" i0
          return mi -----
        _ -> return mi
      return mi'

    -- add the instance opens to an incomplete module "with" instances
    ModWith mt stat ext ops -> do
      let insts = [(inf,inst) |OQualif _ inf inst <- ops]
      let infs  = map fst insts
      let stat' = ifNull MSComplete (const MSIncomplete) 
                    [i | i <- is, notElem i infs]
      testErr (stat' == MSComplete || stat == MSIncomplete) 
              ("module" +++ prt i +++ "remains incomplete")
      Module mt0 stat0 fs me ops0 js <- do
        mi <- lookupModule gr ext
        case mi of
          ModMod m -> return m --- check compatibility of module type
          _ -> prtBad "expected regular module in 'with' clause, not" ext
      let ops1 = ops ++ [o | o <- ops0, notElem (openedModule o) infs]
                     ++ [oQualif i i | i <- map snd insts] ----
      --- check if me is incomplete
      return $ ModMod $ Module mt0 stat' fs me ops1 
                          (mapTree (qualifInstanceInfo insts) js)

    _ -> return mi
  return (i,mi')

checkCompleteInstance :: SourceRes -> SourceRes -> Err ()
checkCompleteInstance abs cnc = ifNull (return ()) (Bad . unlines) $
  checkComplete [f | (f, ResOper (Yes _) _) <- abs'] cnc'
   where
     abs' = tree2list $ jments abs
     cnc' = mapTree fst $ jments cnc
     checkComplete sought given = foldr ckOne [] sought
       where
         ckOne f = if isInBinTree f given 
                      then id
                      else (("Error: no definition given to" +++ prt f):)

qualifInstanceInfo :: [(Ident,Ident)] -> (Ident,Info) -> (Ident,Info)
qualifInstanceInfo insts (c,i) = (c,qualInfo i) where

  qualInfo i = case i of
    ResOper pty pt -> ResOper (qualP pty) (qualP pt)
    CncCat  pty pt pp -> CncCat (qualP pty) (qualP pt) (qualP pp)
    CncFun  mp pt pp -> CncFun (qualLin mp) (qualP pt) (qualP pp) ---- mp
    ResParam (Yes ps) -> ResParam (yes (map qualParam ps)) 
    ResValue pty ->  ResValue (qualP pty)
    _ -> i
  qualP pt = case pt of
     Yes t -> yes $ qual t
     May m -> may $ qualId m
     _ -> pt
  qualId x = maybe x id $ lookup x insts
  qual t = case t of
     Q m c  -> Q  (qualId m) c
     QC m c -> QC (qualId m) c
     _ -> composSafeOp qual t
  qualParam (p,co) = (p,[(x,qual t) | (x,t) <- co])
  qualLin (Just (c,(co,t))) = (Just (c,([(x,qual t) | (x,t) <- co], qual t)))
  qualLin Nothing = Nothing


   -- NB constructor patterns never appear in interfaces so we need not rename them
