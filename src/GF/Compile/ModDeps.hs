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
  ModMod m -> test [n | OQualif n v <- opens m, n /= v]

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
    ests <- case es of
      Just e -> liftM singleton $ lookupModuleType gr e
      _ -> return []
    testErr (all (compatMType ety) ests) "inappropriate extension module type" 
    osts <- mapM (lookupModuleType gr . openedModule) os
    testErr (all (==oty) osts) "inappropriate open module type"
    let ab = case it of
               IdentM _ (MTConcrete a) -> [IdentM a MTAbstract]
               _ -> [] ---- 
    return (it, ab ++
                [IdentM e ety | Just e <- [es]] ++ 
                [IdentM (openedModule o) oty | o <- os])

  -- check for superficial compatibility, not submodule relation etc
  compatMType mt0 mt = case (mt0,mt) of
    (MTConcrete _, MTConcrete _) -> True
    (MTResourceImpl _, MTResourceImpl _) -> True
    (MTReuse _, MTReuse _) -> True
    ---- some more
    _ -> mt0 == mt

  gr = MGrammar ms --- hack
