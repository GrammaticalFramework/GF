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
-- Rebuild a source module from incomplete and its with-instance.
-----------------------------------------------------------------------------

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
  mi'  <- case mi of

    -- add the information given in interface into an instance module
    ModMod m -> do
      testErr (null is || mstatus m == MSIncomplete) 
              ("module" +++ prt i +++ 
               "has open interfaces and must therefore be declared incomplete") 
      case mtype m of
        MTInstance i0 -> do
          m1 <- lookupModMod gr i0
          testErr (isModRes m1) ("interface expected instead of" +++ prt i0)
          m' <- do
            js' <- extendMod False i0 i (jments m1) (jments m)
            --- to avoid double inclusions, in instance I of I0 = J0 ** ...
            case extends m of
              [] -> return $ replaceJudgements m js'
              j0:jj -> do 
                m0 <- lookupModMod gr j0
                let notInM0 c = not $ isInBinTree (fst c) $ mapTree fst $ jments m0
                let js2 = sorted2tree $ filter notInM0 $ tree2list js'
                if null jj 
                  then return $ replaceJudgements m js2
                  else Bad "FIXME: handle multiple inheritance in instance"
          return $ ModMod m'
        _ -> return mi

    -- add the instance opens to an incomplete module "with" instances
    ModWith mt stat ext me ops -> do
      let insts = [(inf,inst) | OQualif _ inf inst <- ops]
      let infs  = map fst insts
      let stat' = ifNull MSComplete (const MSIncomplete)
                    [i | i <- is, notElem i infs]
      testErr (stat' == MSComplete || stat == MSIncomplete) 
              ("module" +++ prt i +++ "remains incomplete")
      Module mt0 _ fs me' ops0 js <- lookupModMod gr ext
      let ops1 = ops ++ [o | o <- ops0, notElem (openedModule o) infs]
                     ++ [oQualif i i | i <- map snd insts] ----
                     ++ [oSimple i   | i <- map snd insts] ----
      --- check if me is incomplete
      return $ ModMod $ Module mt0 stat' fs me ops1 js 
                          ---- (mapTree (qualifInstanceInfo insts) js) -- not needed

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

{- ---- should not be needed
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
-}
