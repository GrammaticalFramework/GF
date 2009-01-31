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
import Data.Maybe (isNothing)

-- | rebuilding instance + interface, and "with" modules, prior to renaming. 
-- AR 24/10/2003
rebuildModule :: [SourceModule] -> SourceModule -> Err SourceModule
rebuildModule ms mo@(i,mi@(ModInfo mt stat fs_ me mw ops_ med_ js_ ps_)) = do
  let gr = MGrammar ms
----  deps <- moduleDeps ms
----  is   <- openInterfaces deps i
  let is = [] ---- the method above is buggy: try "i -src" for two grs. AR 8/3/2005
  mi'  <- case mw of

    -- add the information given in interface into an instance module
    Nothing -> do
      testErr (null is || mstatus mi == MSIncomplete) 
              ("module" +++ prt i +++ 
               "has open interfaces and must therefore be declared incomplete") 
      case mt of
        MTInstance i0 -> do
          m1 <- lookupModule gr i0
          testErr (isModRes m1) ("interface expected instead of" +++ prt i0)
          js' <- extendMod False (i0,const True) i (jments m1) (jments mi)
          --- to avoid double inclusions, in instance I of I0 = J0 ** ...
          case extends mi of
            []  -> return $ replaceJudgements mi js'
            j0s -> do
                m0s <- mapM (lookupModule gr) j0s
                let notInM0 c _  = all (not . isInBinTree c . jments) m0s
                let js2 = filterBinTree notInM0 js'
                return $ (replaceJudgements mi js2) 
                  {positions = 
                    buildTree (tree2list (positions m1) ++ 
                               tree2list (positions mi))}
        _ -> return mi

    -- add the instance opens to an incomplete module "with" instances
    Just (ext,incl,ops) -> do
      let (infs,insts) = unzip ops
      let stat' = ifNull MSComplete (const MSIncomplete)
                    [i | i <- is, notElem i infs]
      testErr (stat' == MSComplete || stat == MSIncomplete) 
              ("module" +++ prt i +++ "remains incomplete")
      ModInfo mt0 _ fs me' _ ops0 _ js ps0 <- lookupModule gr ext
      let ops1 = nub $
                   ops_ ++ -- N.B. js has been name-resolved already
                   [OQualif i j | (i,j) <- ops] ++
                   [o | o <- ops0, notElem (openedModule o) infs] ++
                   [OQualif i i | i <- insts] ++
                   [OSimple i   | i <- insts]

      --- check if me is incomplete
      let fs1 = fs `addOptions` fs_                           -- new flags have priority
      let js0 = [ci | ci@(c,_) <- tree2list js, isInherited incl c]
      let js1 = buildTree (tree2list js_ ++ js0)
      let ps1 = buildTree (tree2list ps_ ++ tree2list ps0)
      let med1= nub (ext : infs ++ insts ++ med_)
      return $ ModInfo mt0 stat' fs1 me Nothing ops1 med1 js1 ps1

  return (i,mi')

checkCompleteInstance :: SourceModInfo -> SourceModInfo -> Err ()
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

