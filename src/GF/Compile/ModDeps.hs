module ModDeps where

import Grammar
import Ident
import Option
import PrGrammar
import Update
import Lookup
import Modules

import Operations

import Monad
import List

-- AR 13/5/2003

-- to check uniqueness of module names and import names, the
-- appropriateness of import and extend types,
-- to build a dependency graph of modules, and to sort them topologically

mkSourceGrammar :: [(Ident,SourceModInfo)] -> Err SourceGrammar
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

-- check that import names don't clash with module names

checkUniqueImportNames :: [Ident] -> SourceModInfo -> Err ()
checkUniqueImportNames ns mo = case mo of
  ModMod m -> test [n | OQualif _ n v <- opens m, n /= v]

 where

  test ms = testErr (all (`notElem` ns) ms)
                    ("import names clashing with module names among" +++ 
                       unwords (map prt ms))

-- to decide what modules immediately depend on what, and check if the
-- dependencies are appropriate

type Dependencies = [(IdentM Ident,[IdentM Ident])]

moduleDeps :: [(Ident,SourceModInfo)] -> Err Dependencies
moduleDeps ms = mapM deps ms where
  deps (c,mi) = errIn ("checking dependencies of module" +++ prt c) $ case mi of
    ModMod m -> case mtype m of
      MTConcrete a -> do
        aty <- lookupModuleType gr a
        testErr (aty == MTAbstract) "the for-module is not an abstract syntax" 
        chDep (IdentM c (MTConcrete a)) 
              (extends m) (MTConcrete a) (opens m) MTResource
      t -> chDep (IdentM c t) (extends m) t (opens m) t

  chDep it es ety os oty = do
    ests <- mapM (lookupModuleType gr) es
    testErr (all (compatMType ety) ests) "inappropriate extension module type" 
    osts <- mapM (lookupModuleType gr . openedModule) os
    testErr (all (compatOType oty) osts) "inappropriate open module type"
    let ab = case it of
               IdentM _ (MTConcrete a) -> [IdentM a MTAbstract]
               _ -> [] ---- 
    return (it, ab ++
                [IdentM e ety | e <- es] ++ 
                [IdentM (openedModule o) oty | o <- os])

  -- check for superficial compatibility, not submodule relation etc: what can be extended
  compatMType mt0 mt = case (mt0,mt) of
    (MTConcrete _, MTConcrete _) -> True
    (MTInstance _, MTInstance _) -> True
    (MTReuse _, MTReuse _) -> True
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
      MTReuse _ -> True
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

-- this function finds out what modules are really needed in the canoncal gr.
-- its argument is typically a concrete module name

requiredCanModules :: (Eq i, Show i) => MGrammar i f a -> i -> [i]
requiredCanModules gr = nub . iterFix (concatMap more) . singleton where
  more i = errVal [] $ do
    m <- lookupModMod gr i
    return $ extends m ++ map openedModule (opens m)



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

