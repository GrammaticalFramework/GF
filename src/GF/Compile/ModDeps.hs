----------------------------------------------------------------------
-- |
-- Module      : ModDeps
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/11 23:24:34 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.14 $
--
-- Check correctness of module dependencies. Incomplete.
--
-- AR 13\/5\/2003
-----------------------------------------------------------------------------

module GF.Compile.ModDeps (mkSourceGrammar,
		moduleDeps,
		openInterfaces,
		requiredCanModules
	       ) where

import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Infra.Option
import GF.Grammar.Printer
import GF.Compile.Update
import GF.Grammar.Lookup
import GF.Infra.Modules

import GF.Data.Operations

import Control.Monad
import Data.List

-- | to check uniqueness of module names and import names, the
-- appropriateness of import and extend types,
-- to build a dependency graph of modules, and to sort them topologically
mkSourceGrammar :: [SourceModule] -> Err SourceGrammar
mkSourceGrammar ms = do
  let ns = map fst ms
  checkUniqueErr ns
  mapM (checkUniqueImportNames ns . snd) ms
  deps    <- moduleDeps ms
  deplist <- either 
               return 
               (\ms -> Bad $ "circular modules" +++ unwords (map show ms)) $ 
               topoTest deps
  return $ MGrammar [(m, maybe undefined id $ lookup m ms)  | IdentM m _ <- deplist]

checkUniqueErr ::  (Show i, Eq i) => [i] -> Err ()
checkUniqueErr ms = do
  let msg = checkUnique ms
  if null msg then return () else Bad $ unlines msg

-- | check that import names don't clash with module names
checkUniqueImportNames :: [Ident] -> SourceModInfo -> Err ()
checkUniqueImportNames ns mo = test [n | OQualif n v <- opens mo, n /= v]
 where
   test ms = testErr (all (`notElem` ns) ms)
                     ("import names clashing with module names among" +++ unwords (map prt ms))

type Dependencies = [(IdentM Ident,[IdentM Ident])]

-- | to decide what modules immediately depend on what, and check if the
-- dependencies are appropriate
moduleDeps :: [SourceModule] -> Err Dependencies
moduleDeps ms = mapM deps ms where
  deps (c,m) = errIn ("checking dependencies of module" +++ prt c) $ case mtype m of
      MTConcrete a -> do
        aty <- lookupModuleType gr a
        testErr (aty == MTAbstract) "the of-module is not an abstract syntax" 
        chDep (IdentM c (MTConcrete a)) 
              (extends m) (MTConcrete a) (opens m) MTResource
      t -> chDep (IdentM c t) (extends m) t (opens m) t

  chDep it es ety os oty = do
    ests <- mapM (lookupModuleType gr) es
    testErr (all (compatMType ety) ests) "inappropriate extension module type" 
----    osts <- mapM (lookupModuleType gr . openedModule) os
----    testErr (all (compatOType oty) osts) "inappropriate open module type"
    let ab = case it of
               IdentM _ (MTConcrete a) -> [IdentM a MTAbstract]
               _ -> [] ---- 
    return (it, ab ++
                [IdentM e ety | e <- es] ++ 
                [IdentM (openedModule o) oty | o <- os])

  -- check for superficial compatibility, not submodule relation etc: what can be extended
  compatMType mt0 mt = case (mt0,mt) of
    (MTResource,   MTConcrete _) -> True
    (MTInstance _, MTConcrete _) -> True
    (MTInterface,  MTAbstract)   -> True
    (MTConcrete _, MTConcrete _) -> True
    (MTInstance _, MTInstance _) -> True
    (MTInstance _, MTResource) -> True
    (MTResource, MTInstance _) -> True
    ---- some more?
    _ -> mt0 == mt
  -- in the same way; this defines what can be opened
  compatOType mt0 mt = case mt0 of
    MTAbstract     -> mt == MTAbstract
    MTTransfer _ _ -> mt == MTAbstract
    _ -> case mt of
      MTResource -> True
      MTInterface -> True
      MTInstance _ -> True
      _ -> False      

  gr = MGrammar ms --- hack

openInterfaces :: Dependencies -> Ident -> Err [Ident]
openInterfaces ds m = do
  let deps = [(i,ds) | (IdentM i _,ds) <- ds]
  let more (c,_) = [(i,mt) | Just is <- [lookup c deps], IdentM i mt <- is]
  let mods = iterFix (concatMap more) (more (m,undefined))
  return $ [i | (i,MTInterface) <- mods]

-- | this function finds out what modules are really needed in the canonical gr.
-- its argument is typically a concrete module name
requiredCanModules :: (Ord i, Show i) => Bool -> MGrammar i a -> i -> [i]
requiredCanModules isSingle gr c = nub $ filter notReuse ops ++ exts where
  exts = allExtends gr c
  ops  = if isSingle 
         then map fst (modules gr)
         else iterFix (concatMap more) $ exts
  more i = errVal [] $ do
    m <- lookupModule gr i
    return $ extends m ++ [o | o <- map openedModule (opens m)]
  notReuse i = errVal True $ do
    m <- lookupModule gr i
    return $ isModRes m -- to exclude reused Cnc and Abs from required


{-
-- to test
exampleDeps = [
  (ir "Nat",[ii "Gen", ir "Adj"]),
  (ir "Adj",[ii "Num", ii "Gen", ir "Nou"]),
  (ir "Nou",[ii "Cas"])
  ]

ii s = IdentM (IC s) MTInterface
ir s = IdentM (IC s) MTResource
-}

