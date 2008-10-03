----------------------------------------------------------------------
-- |
-- Module      : Rebuild
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/30 21:08:14 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.14 $
--
-- Rebuild a source module from incomplete and its with-instance.
-----------------------------------------------------------------------------

module GF.Compile.Rebuild (rebuildModule) where

import GF.Grammar.Grammar
import GF.Compile.ModDeps
import GF.Grammar.PrGrammar
import GF.Grammar.Lookup
import GF.Compile.Extend
import GF.Grammar.Macros

import GF.Infra.Ident
import GF.Infra.Modules
import GF.Infra.Option
import GF.Data.Operations

import Data.List (nub)

-- | rebuilding instance + interface, and "with" modules, prior to renaming. 
-- AR 24/10/2003
rebuildModule :: [SourceModule] -> SourceModule -> Err SourceModule
rebuildModule ms mo@(i,mi) = do
  let gr = MGrammar ms
----  deps <- moduleDeps ms
----  is   <- openInterfaces deps i
  let is = [] ---- the method above is buggy: try "i -src" for two grs. AR 8/3/2005
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
            js' <- extendMod False (i0,const True) i (jments m1) (jments m)
            --- to avoid double inclusions, in instance I of I0 = J0 ** ...
            case extends m of
              [] -> return $ replaceJudgements m js'
              j0s -> do 
                m0s <- mapM (lookupModMod gr) j0s
                let notInM0 c _  = all (not . isInBinTree c . jments) m0s
                let js2 = filterBinTree notInM0 js'
                return $ (replaceJudgements m js2) 
                  {positions = 
                    buildTree (tree2list (positions m1) ++ 
                               tree2list (positions m))}
--          checkCompleteInstance m1 m'
          return $ ModMod m'
        _ -> return mi

    -- add the instance opens to an incomplete module "with" instances
    --      ModWith mt stat ext me ops -> do
    ModWith (Module mt stat fs_ me ops_ js_ ps_) (ext,incl) ops -> do
      let insts = [(inf,inst) | OQualif _ inf inst <- ops]
      let infs  = map fst insts
      let stat' = ifNull MSComplete (const MSIncomplete)
                    [i | i <- is, notElem i infs]
      testErr (stat' == MSComplete || stat == MSIncomplete) 
              ("module" +++ prt i +++ "remains incomplete")
      Module mt0 _ fs me' ops0 js ps0 <- lookupModMod gr ext
      let ops1 = nub $
                   ops_ ++ -- N.B. js has been name-resolved already
                   ops ++ [o | o <- ops0, notElem (openedModule o) infs]
                       ++ [oQualif i i | i <- map snd insts] ----
                       ++ [oSimple i   | i <- map snd insts] ----

      --- check if me is incomplete
      let fs1 = addModuleOptions fs fs_                           -- new flags have priority
      let js0 = [ci | ci@(c,_) <- tree2list js, isInherited incl c]
      let js1 = buildTree (tree2list js_ ++ js0)
      let ps1 = buildTree (tree2list ps_ ++ tree2list ps0)
      return $ ModMod $ Module mt0 stat' fs1 me ops1 js1 ps1 
                          ---- (mapTree (qualifInstanceInfo insts) js) -- not needed

    _ -> return mi
  return (i,mi')

checkCompleteInstance :: SourceRes -> SourceRes -> Err ()
checkCompleteInstance abs cnc = ifNull (return ()) (Bad . unlines) $
  checkComplete [f | (f, ResOper (Yes _) _) <- abs'] cnc'
   where
     abs' = tree2list $ jments abs
     cnc' = jments cnc
     checkComplete sought given = foldr ckOne [] sought
       where
         ckOne f = if isInBinTree f given 
                      then id
                      else (("Error: no definition given to" +++ prt f):)

