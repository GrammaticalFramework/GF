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
  | ModMod (Module i f a)
  deriving Show

data Module i f a = Module {
    mtype   :: ModuleType i ,
    flags   :: [f] ,
    extends :: Maybe i ,
    opens   :: [OpenSpec i] ,
    jments  :: BinTree (i,a)
  }
  deriving Show

-- destructive update

--- dep order preserved since old cannot depend on new
updateMGrammar :: Ord i => MGrammar i f a -> MGrammar i f a -> MGrammar i f a
updateMGrammar old new = MGrammar $ 
  [(i,m) | (i,m) <- os, notElem i (map fst ns)] ++ ns
 where
   os = modules old
   ns = modules new

updateModule :: Ord i => Module i f t -> i -> t -> Module i f t
updateModule (Module  mt fs me ops js) i t = 
  Module mt fs me ops (updateTree (i,t) js)

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

data OpenSpec i = OSimple i | OQualif i i
  deriving (Eq,Show)

openedModule :: OpenSpec i -> i
openedModule o = case o of
  OSimple m -> m
  OQualif _ m -> m

-- initial dependency list
depPathModule :: Ord i => Module i f a -> [OpenSpec i]
depPathModule m = fors m ++ exts m ++ opens m where
  fors m = case mtype m of
    MTTransfer i j -> [i,j]
    MTConcrete i   -> [OSimple i]
    _              -> []
  exts m = map OSimple $ maybe [] return $ extends m

-- all modules that a module extends, directly or indirectly
allExtends :: (Show i,Ord i) => MGrammar i f a -> i -> [i]
allExtends gr i = case lookupModule gr i of
  Ok (ModMod m) -> case extends m of 
    Just i1 -> i : allExtends gr i1
    _ -> [i]
  _ -> []

-- initial search path: the nonqualified dependencies
searchPathModule :: Ord i => Module i f a -> [i]
searchPathModule m = [i | OSimple i <- depPathModule m]

-- a new module can safely be added to the end, since nothing old can depend on it
addModule :: Ord i => 
             MGrammar i f a -> i -> ModInfo i f a -> MGrammar i f a
addModule gr name mi = MGrammar $ (modules gr ++ [(name,mi)])

emptyMGrammar :: MGrammar i f a
emptyMGrammar = MGrammar []


-- we store the module type with the identifier

data IdentM i = IdentM {
  identM :: i ,
  typeM  :: ModuleType i
  }
  deriving (Eq,Show)

-- encoding the type of the module
data ModuleType i = 
    MTAbstract 
  | MTTransfer (OpenSpec i) (OpenSpec i) 
  | MTResource
  | MTResourceInt
  | MTResourceImpl i 
  | MTConcrete i
  | MTConcreteInt i i 
  | MTConcreteImpl i i i
  | MTReuse i
  deriving (Eq,Show)

typeOfModule mi = case mi of
  ModMod m -> mtype m

isResourceModule mi = case typeOfModule mi of
  MTResource -> True
  MTReuse _ -> True
  MTResourceInt -> True
  MTResourceImpl _ -> True
  _ -> False

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

lookupInfo :: (Show i, Ord i) => Module i f a -> i -> Err a
lookupInfo mo i = lookupTree show i (jments mo)

isModAbs m = case mtype m of
  MTAbstract -> True
  _ -> False

isModRes m = case mtype m of
  MTResource -> True
  _ -> False

isModCnc m = case mtype m of
  MTConcrete _ -> True
  _ -> False

sameMType m n = case (m,n) of
  (MTConcrete _, MTConcrete _) -> True
  _ -> m == n
