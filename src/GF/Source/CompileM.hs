module CompileM where

import Grammar
import Ident
import Option
import PrGrammar
import Update
import Lookup
import Modules
---import Rename

import Operations
import UseIO

import Monad

compileMGrammar :: Options -> SourceGrammar -> IOE SourceGrammar
compileMGrammar opts sgr = do

  ioeErr $ checkUniqueModuleNames sgr

  deps <- ioeErr $ moduleDeps sgr

  deplist <- either return 
                 (\ms -> ioeBad $ "circular modules" +++ unwords (map show ms)) $ 
                 topoTest deps

  let deps' = closureDeps deps

  foldM (compileModule opts deps' sgr) emptyMGrammar deplist

checkUniqueModuleNames :: MGrammar i f a r c -> Err ()
checkUniqueModuleNames gr = do
  let ms = map fst $ tree2list $ modules gr
      msg = checkUnique ms
  if null msg then return () else Bad $ unlines msg

-- to decide what modules immediately depend on what, and check if the
-- dependencies are appropriate

moduleDeps :: MGrammar i f a c r -> Err Dependencies
moduleDeps gr = mapM deps $ tree2list $ modules gr where
  deps (c,mi) = errIn ("checking dependencies of module" +++ prt c) $ case mi of
    ModAbs m -> chDep (IdentM c MTAbstract) 
                      (extends m) MTAbstract (opens m) MTAbstract
    ModRes m -> chDep (IdentM c MTResource) 
                      (extends m) MTResource (opens m) MTResource
    ModCnc m -> do
      a:ops <- case opens m of
        os@(_:_) -> return os
        _ -> Bad "no abstract indicated for concrete module"
      aty <- lookupModuleType gr a
      testErr (aty == MTAbstract) "the for-module is not an abstract syntax" 
      chDep (IdentM c (MTConcrete a)) (extends m) MTResource ops MTResource

  chDep it es ety os oty = do
    ests <- mapM (lookupModuleType gr) es
    testErr (all (==ety) ests) "inappropriate extension module type" 
    osts <- mapM (lookupModuleType gr) os
    testErr (all (==oty) osts) "inappropriate open module type" 
    return (it, [IdentM e ety | e <- es] ++ [IdentM o oty | o <- os])

type Dependencies = [(IdentM Ident,[IdentM Ident])]

---compileModule :: Options -> Dependencies -> SourceGrammar -> 
---                 CanonGrammar -> IdentM -> IOE CanonGrammar
compileModule opts deps sgr cgr i = do
  
   let name = identM i 

   testIfCompiled deps name

   mi <- ioeErr $ lookupModule sgr name

   mi' <- case typeM i of
     -- previously compiled cgr used as symbol table
     MTAbstract   -> compileAbstract cgr mi
     MTResource   -> compileResource cgr mi
     MTConcrete a -> compileConcrete a cgr mi 

   ifIsOpt doOutput $ writeCanonFile name mi'

   return $ addModule cgr name mi'

 where

   ifIsOpt o f = if (oElem o opts) then f else return ()
   doOutput    = iOpt "o"


testIfCompiled :: Dependencies -> Ident -> IOE Bool
testIfCompiled _ _ = return False ----

---writeCanonFile :: Ident -> CanonModInfo -> IOE ()
writeCanonFile name mi' = ioeIO $ writeFile (canonFileName name) [] ----

canonFileName n = n ++ ".gfc" ---- elsewhere!

---compileAbstract :: CanonGrammar -> SourceModInfo -> IOE CanonModInfo
compileAbstract can (ModAbs m0) = do
  let m1 = renameMAbstract m0
{-
  checkUnique
  typeCheck
  generateCode
  addToCanon
-}
  ioeBad "compile abs not yet"

---compileResource :: CanonGrammar -> SourceModInfo -> IOE CanonModInfo
compileResource can md = do
{-
  checkUnique
  typeCheck
  topoSort
  compileOpers -- conservative, since more powerful than lin
  generateCode
  addToCanon
-}
  ioeBad "compile res not yet"

---compileConcrete :: Ident -> CanonGrammar -> SourceModInfo -> IOE CanonModInfo
compileConcrete ab can md = do
{-
  checkUnique
  checkComplete ab
  typeCheck
  topoSort
  compileOpers
  optimize
  createPreservedOpers
  generateCode
  addToCanon
-}
  ioeBad "compile cnc not yet"


-- to be imported

closureDeps :: [(a,[a])] -> [(a,[a])]
closureDeps ds = ds ---- fix-point iteration
