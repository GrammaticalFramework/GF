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
-- Datastructures and functions for modules, common to GF and GFC.
-----------------------------------------------------------------------------

module Modules where

import Ident
import Option
import Operations

import List


-- AR 29/4/2003

-- The same structure will be used in both source code and canonical.
-- The parameters tell what kind of data is involved.
-- Invariant: modules are stored in dependency order

data MGrammar i f a = MGrammar {modules :: [(i,ModInfo i f a)]}
  deriving Show

data ModInfo i f a =
    ModMainGrammar (MainGrammar i)
  | ModMod  (Module i f a)
  | ModWith (ModuleType i) ModuleStatus i [i] [OpenSpec i]
  deriving Show

data Module i f a = Module {
    mtype   :: ModuleType i ,
    mstatus :: ModuleStatus ,
    flags   :: [f] ,
    extends :: [i],
    opens   :: [OpenSpec i] ,
    jments  :: BinTree (i,a)
  }
  deriving Show

-- encoding the type of the module
data ModuleType i = 
    MTAbstract 
  | MTTransfer (OpenSpec i) (OpenSpec i) 
  | MTResource
  | MTConcrete i

  -- up to this, also used in GFC. Below, source only.

  | MTInterface
  | MTInstance i 
  | MTReuse (MReuseType i)
  | MTUnion (ModuleType i) [(i,[i])] --- not meant to be recursive
  deriving (Eq,Show)

data MReuseType i = MRInterface i | MRInstance i i | MRResource i
  deriving (Show,Eq)

-- previously: single inheritance
extendm :: Module i f a -> Maybe i
extendm m = case extends m of
  [i] -> Just i
  _   -> Nothing

-- destructive update

--- dep order preserved since old cannot depend on new
updateMGrammar :: Ord i => MGrammar i f a -> MGrammar i f a -> MGrammar i f a
updateMGrammar old new = MGrammar $ 
  [(i,m) | (i,m) <- os, notElem i (map fst ns)] ++ ns
 where
   os = modules old
   ns = modules new

updateModule :: Ord i => Module i f t -> i -> t -> Module i f t
updateModule (Module  mt ms fs me ops js) i t = 
  Module mt ms fs me ops (updateTree (i,t) js)

replaceJudgements :: Module i f t -> BinTree (i,t) -> Module i f t
replaceJudgements (Module mt ms fs me ops _) js = Module mt ms fs me ops js

addOpenQualif :: i -> i -> Module i f t -> Module i f t
addOpenQualif i j (Module mt ms fs me ops js) = 
  Module mt ms fs me (oQualif i j : ops) js

flagsModule :: (i,ModInfo i f a) -> [f]
flagsModule (_,mi) = case mi of
  ModMod m -> flags m
  _ -> []

allFlags :: MGrammar i f a -> [f]
allFlags gr = concat $ map flags $ reverse [m | (_, ModMod m) <- modules gr]

mapModules :: (Module i f a -> Module i f a) 
	   -> MGrammar i f a -> MGrammar i f a 
mapModules f = MGrammar . map (onSnd mapModules') . modules
    where mapModules' (ModMod m) = ModMod (f m)
	  mapModules' m = m

data MainGrammar i = MainGrammar {
    mainAbstract  :: i ,
    mainConcretes :: [MainConcreteSpec i]
  }
  deriving Show

data MainConcreteSpec i = MainConcreteSpec {
    concretePrintname :: i ,
    concreteName :: i ,
    transferIn   :: Maybe (OpenSpec i) ,  -- if there is an in-transfer
    transferOut  :: Maybe (OpenSpec i)    -- if there is an out-transfer
  }
  deriving Show

data OpenSpec i = 
   OSimple OpenQualif i 
 | OQualif OpenQualif i i
  deriving (Eq,Show)

data OpenQualif =
   OQNormal
 | OQInterface
 | OQIncomplete
  deriving (Eq,Show)

oSimple = OSimple OQNormal
oQualif = OQualif OQNormal

data ModuleStatus = 
   MSComplete 
 | MSIncomplete 
  deriving (Eq,Show)

openedModule :: OpenSpec i -> i
openedModule o = case o of
  OSimple _ m -> m
  OQualif _ _ m -> m

allOpens m = case mtype m of
  MTTransfer a b -> a : b : opens m
  _ -> opens m

-- initial dependency list
depPathModule :: Ord i => Module i f a -> [OpenSpec i]
depPathModule m = fors m ++ exts m ++ opens m where
  fors m = case mtype m of
    MTTransfer i j -> [i,j]
    MTConcrete i   -> [oSimple i]
    MTInstance i   -> [oSimple i]
    _              -> []
  exts m = map oSimple $ extends m

-- all dependencies
allDepsModule :: Ord i => MGrammar i f a -> Module i f a -> [OpenSpec i]
allDepsModule gr m = iterFix add os0 where
  os0 = depPathModule m
  add os = [m | o <- os, Just (ModMod n) <- [lookup (openedModule o) mods], 
                m <- depPathModule n]
  mods = modules gr

-- select just those modules that a given one depends on, including itself
partOfGrammar :: Ord i => MGrammar i f a -> (i,ModInfo i f a) -> MGrammar i f a
partOfGrammar gr (i,m) = MGrammar [mo | mo@(j,_) <- mods, elem j modsFor] 
  where
    mods = modules gr
    modsFor = case m of
      ModMod n -> (i:) $ map openedModule $ allDepsModule gr n
      _ -> [i] ---- ModWith?


-- all modules that a module extends, directly or indirectly
allExtends :: (Show i,Ord i) => MGrammar i f a -> i -> [i]
allExtends gr i = case lookupModule gr i of
  Ok (ModMod m) -> case extends m of 
    [] -> [i]
    is -> i : concatMap (allExtends gr) is
  _ -> []

-- this plus that an instance extends its interface
allExtendsPlus :: (Show i,Ord i) => MGrammar i f a -> i -> [i]
allExtendsPlus gr i = case lookupModule gr i of
  Ok (ModMod m) -> i : concatMap (allExtendsPlus gr) (exts m)
  _ -> []
 where
   exts m = extends m ++ [j | MTInstance j <- [mtype m]]

-- conversely: all modules that extend a given module, incl. instances of interface
allExtensions :: (Show i,Ord i) => MGrammar i f a -> i -> [i]
allExtensions gr i = case lookupModule gr i of
  Ok (ModMod m) -> let es = exts i in es ++ concatMap (allExtensions gr) es
  _ -> []
 where
   exts i = [j | (j,m) <- mods, elem i (extends m) 
                             || elem (MTInstance i) [mtype m]]
   mods = [(j,m) | (j,ModMod m) <- modules gr]

-- initial search path: the nonqualified dependencies
searchPathModule :: Ord i => Module i f a -> [i]
searchPathModule m = [i | OSimple _ i <- depPathModule m]

-- a new module can safely be added to the end, since nothing old can depend on it
addModule :: Ord i => 
             MGrammar i f a -> i -> ModInfo i f a -> MGrammar i f a
addModule gr name mi = MGrammar $ (modules gr ++ [(name,mi)])

emptyMGrammar :: MGrammar i f a
emptyMGrammar = MGrammar []

emptyModInfo :: ModInfo i f a
emptyModInfo = ModMod emptyModule

emptyModule :: Module i f a
emptyModule = Module MTResource MSComplete [] [] [] NT

-- we store the module type with the identifier

data IdentM i = IdentM {
  identM :: i ,
  typeM  :: ModuleType i
  }
  deriving (Eq,Show)

typeOfModule mi = case mi of
  ModMod m -> mtype m

abstractOfConcrete :: (Show i, Eq i) => MGrammar i f a -> i -> Err i
abstractOfConcrete gr c = do
  m <- lookupModule gr c
  case m of
    ModMod n -> case mtype n of
      MTConcrete a -> return a
      _ -> Bad $ "expected concrete" +++ show c
    _ -> Bad $ "expected concrete" +++ show c

abstractModOfConcrete :: (Show i, Eq i) => 
                         MGrammar i f a -> i -> Err (Module i f a)
abstractModOfConcrete gr c = do
  a <- abstractOfConcrete gr c
  m <- lookupModule gr a
  case m of
    ModMod n -> return n
    _ -> Bad $ "expected abstract" +++ show c


-- the canonical file name

--- canonFileName s = prt s ++ ".gfc"

lookupModule :: (Show i,Eq i) => MGrammar i f a -> i -> Err (ModInfo i f a)
lookupModule gr m = case lookup m (modules gr) of
  Just i -> return i
  _ -> Bad $ "unknown module" +++ show m 
             +++ "among" +++ unwords (map (show . fst) (modules gr)) ---- debug

lookupModuleType :: (Show i,Eq i) => MGrammar i f a -> i -> Err (ModuleType i)
lookupModuleType gr m = do
  mi <- lookupModule gr m
  return $ typeOfModule mi

lookupModMod :: (Show i,Eq i) => MGrammar i f a -> i -> Err (Module i f a)
lookupModMod gr i = do
  mo <- lookupModule gr i
  case mo of 
    ModMod m -> return m
    _ -> Bad $ "expected proper module, not" +++ show i

lookupInfo :: (Show i, Ord i) => Module i f a -> i -> Err a
lookupInfo mo i = lookupTree show i (jments mo)

allModMod :: (Show i,Eq i) => MGrammar i f a -> [(i,Module i f a)]
allModMod gr = [(i,m) | (i, ModMod m) <- modules gr]

isModAbs m = case mtype m of
  MTAbstract -> True
----  MTUnion t -> isModAbs t
  _ -> False

isModRes m = case mtype m of
  MTResource -> True
  MTReuse _ -> True
----  MTUnion t -> isModRes t --- maybe not needed, since eliminated early
  MTInterface -> True ---
  MTInstance _ -> True
  _ -> False

isModCnc m = case mtype m of
  MTConcrete _ -> True
----  MTUnion t -> isModCnc t
  _ -> False

isModTrans m = case mtype m of
  MTTransfer _ _ -> True
----  MTUnion t -> isModTrans t
  _ -> False

sameMType m n = case (m,n) of
  (MTConcrete _, MTConcrete _) -> True
  (MTInstance _, MTInstance _) -> True
  (MTInstance _, MTResource) -> True
  (MTInstance _, MTInterface) -> True
  (MTResource, MTInstance _) -> True
  (MTResource, MTInterface) -> True
  (MTInterface,MTResource) -> True
  _ -> m == n

-- don't generate code for interfaces and for incomplete modules
isCompilableModule m = case m of
  ModMod m -> case mtype m of
    MTInterface -> False
    _ -> mstatus m == MSComplete
  _ -> False ---

-- interface and "incomplete M" are not complete
isCompleteModule :: (Eq i) =>  Module i f a -> Bool
isCompleteModule m = mstatus m == MSComplete && mtype m /= MTInterface


-- all abstract modules
allAbstracts :: Eq i => MGrammar i f a -> [i]
allAbstracts gr = [i | (i,ModMod m) <- modules gr, mtype m == MTAbstract]

-- the last abstract in dependency order (head of list)
greatestAbstract :: Eq i => MGrammar i f a -> Maybe i
greatestAbstract gr = case allAbstracts gr of
  []  -> Nothing
  a:_ -> return a

-- all resource modules
allResources :: MGrammar i f a -> [i]
allResources gr = [i | (i,ModMod m) <- modules gr, isModRes m]

-- the greatest resource in dependency order
greatestResource :: MGrammar i f a -> Maybe i
greatestResource gr = case allResources gr of
  [] -> Nothing
  a -> return $ head a

-- all concretes for a given abstract
allConcretes :: Eq i => MGrammar i f a -> i -> [i]
allConcretes gr a = [i | (i, ModMod m) <- modules gr, mtype m == MTConcrete a]
