----------------------------------------------------------------------
-- |
-- Module      : Modules
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/09 15:14:30 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.26 $
--
-- Datastructures and functions for modules, common to GF and GFC.
--
-- AR 29\/4\/2003
--
-- The same structure will be used in both source code and canonical.
-- The parameters tell what kind of data is involved.
-- Invariant: modules are stored in dependency order
-----------------------------------------------------------------------------

module GF.Infra.Modules (
		MGrammar(..), ModInfo(..), ModuleType(..),
		MInclude (..),
		extends, isInherited,inheritAll, 
                updateMGrammar, updateModule, replaceJudgements, addFlag,
		addOpenQualif, flagsModule, allFlags, mapModules,
		OpenSpec(..),
		ModuleStatus(..),
		openedModule, allOpens, depPathModule, allDepsModule, partOfGrammar,
		allExtends, allExtendSpecs, allExtendsPlus, allExtensions, 
                searchPathModule, addModule,
		emptyMGrammar, emptyModInfo,
		IdentM(..),
		abstractOfConcrete, abstractModOfConcrete,
		lookupModule, lookupModuleType, lookupInfo,
                lookupPosition, showPosition, ppPosition,
		isModAbs, isModRes, isModCnc, isModTrans,
		sameMType, isCompilableModule, isCompleteModule,
		allAbstracts, greatestAbstract, allResources,
		greatestResource, allConcretes, allConcreteModules
	       ) where

import GF.Infra.Ident
import GF.Infra.Option
import GF.Data.Operations

import Data.List
import Text.PrettyPrint

-- AR 29/4/2003

-- The same structure will be used in both source code and canonical.
-- The parameters tell what kind of data is involved.
-- Invariant: modules are stored in dependency order

newtype MGrammar i a = MGrammar {modules :: [(i,ModInfo i a)]}
  deriving Show

data ModInfo i a = ModInfo {
    mtype   :: ModuleType i ,
    mstatus :: ModuleStatus ,
    flags   :: Options,
    extend  :: [(i,MInclude i)],
    mwith   :: Maybe (i,MInclude i,[(i,i)]),
    opens   :: [OpenSpec i] ,
    mexdeps :: [i] ,
    jments  :: BinTree i a ,
    positions :: BinTree i (String,(Int,Int)) -- file, first line, last line
  }
  deriving Show

-- | encoding the type of the module
data ModuleType i = 
    MTAbstract 
  | MTTransfer (OpenSpec i) (OpenSpec i) 
  | MTResource
  | MTConcrete i
    -- ^ up to this, also used in GFC. Below, source only.
  | MTInterface
  | MTInstance i 
  deriving (Eq,Ord,Show)

data MInclude i = MIAll | MIOnly [i] | MIExcept [i]
  deriving (Eq,Ord,Show)

extends :: ModInfo i a -> [i]
extends = map fst . extend

isInherited :: Eq i => MInclude i -> i -> Bool
isInherited c i = case c of
  MIAll -> True
  MIOnly is -> elem i is
  MIExcept is -> notElem i is

inheritAll :: i -> (i,MInclude i)
inheritAll i = (i,MIAll)

-- destructive update

-- | dep order preserved since old cannot depend on new
updateMGrammar :: Ord i => MGrammar i a -> MGrammar i a -> MGrammar i a
updateMGrammar old new = MGrammar $ 
  [(i,m) | (i,m) <- os, notElem i (map fst ns)] ++ ns
 where
   os = modules old
   ns = modules new

updateModule :: Ord i => ModInfo i t -> i -> t -> ModInfo i t
updateModule (ModInfo mt ms fs me mw ops med js ps) i t = ModInfo mt ms fs me mw ops med (updateTree (i,t) js) ps

replaceJudgements :: ModInfo i t -> BinTree i t -> ModInfo i t
replaceJudgements (ModInfo mt ms fs me mw ops med _ ps) js = ModInfo mt ms fs me mw ops med js ps

addOpenQualif :: i -> i -> ModInfo i t -> ModInfo i t
addOpenQualif i j (ModInfo mt ms fs me mw ops med js ps) = ModInfo mt ms fs me mw (OQualif i j : ops) med js ps

addFlag :: Options -> ModInfo i t -> ModInfo i t
addFlag f mo = mo {flags = flags mo `addOptions` f} 

flagsModule :: (i,ModInfo i a) -> Options
flagsModule (_,mi) = flags mi

allFlags :: MGrammar i a -> Options
allFlags gr = concatOptions [flags m | (_,m) <- modules gr]

mapModules :: (ModInfo i a -> ModInfo i a) -> MGrammar i a -> MGrammar i a 
mapModules f (MGrammar ms) = MGrammar (map (onSnd f) ms)

data OpenSpec i = 
   OSimple i 
 | OQualif i i
  deriving (Eq,Ord,Show)

data ModuleStatus = 
   MSComplete 
 | MSIncomplete 
  deriving (Eq,Ord,Show)

openedModule :: OpenSpec i -> i
openedModule o = case o of
  OSimple m -> m
  OQualif _ m -> m

allOpens :: ModInfo i a -> [OpenSpec i]
allOpens m = case mtype m of
  MTTransfer a b -> a : b : opens m
  _ -> opens m

-- | initial dependency list
depPathModule :: Ord i => ModInfo i a -> [OpenSpec i]
depPathModule m = fors m ++ exts m ++ opens m
  where
    fors m = 
      case mtype m of
        MTTransfer i j -> [i,j]
        MTConcrete i   -> [OSimple i]
        MTInstance i   -> [OSimple i]
        _              -> []
    exts m = map OSimple (extends m)

-- | all dependencies
allDepsModule :: Ord i => MGrammar i a -> ModInfo i a -> [OpenSpec i]
allDepsModule gr m = iterFix add os0 where
  os0 = depPathModule m
  add os = [m | o <- os, Just n <- [lookup (openedModule o) mods], 
                m <- depPathModule n]
  mods = modules gr

-- | select just those modules that a given one depends on, including itself
partOfGrammar :: Ord i => MGrammar i a -> (i,ModInfo i a) -> MGrammar i a
partOfGrammar gr (i,m) = MGrammar [mo | mo@(j,_) <- mods, elem j modsFor] 
  where
    mods = modules gr
    modsFor = (i:) $ map openedModule $ allDepsModule gr m

-- | all modules that a module extends, directly or indirectly, without restricts
allExtends :: (Show i,Ord i) => MGrammar i a -> i -> [i]
allExtends gr i =
  case lookupModule gr i of
    Ok m -> case extends m of 
              [] -> [i]
              is -> i : concatMap (allExtends gr) is
    _    -> []

-- | all modules that a module extends, directly or indirectly, with restricts
allExtendSpecs :: (Show i,Ord i) => MGrammar i a -> i -> [(i,MInclude i)]
allExtendSpecs gr i =
  case lookupModule gr i of
    Ok m -> case extend m of 
              [] -> [(i,MIAll)]
              is ->  (i,MIAll) : concatMap (allExtendSpecs gr . fst) is
    _    -> []

-- | this plus that an instance extends its interface
allExtendsPlus :: (Show i,Ord i) => MGrammar i a -> i -> [i]
allExtendsPlus gr i =
  case lookupModule gr i of
    Ok m -> i : concatMap (allExtendsPlus gr) (exts m)
    _    -> []
  where
    exts m = extends m ++ [j | MTInstance j <- [mtype m]]

-- | conversely: all modules that extend a given module, incl. instances of interface
allExtensions :: (Show i,Ord i) => MGrammar i a -> i -> [i]
allExtensions gr i =
  case lookupModule gr i of
    Ok m -> let es = exts i in es ++ concatMap (allExtensions gr) es
    _    -> []
 where
   exts i = [j | (j,m) <- mods, elem i (extends m) 
                             || elem (MTInstance i) [mtype m]]
   mods = modules gr

-- | initial search path: the nonqualified dependencies
searchPathModule :: Ord i => ModInfo i a -> [i]
searchPathModule m = [i | OSimple i <- depPathModule m]

-- | a new module can safely be added to the end, since nothing old can depend on it
addModule :: Ord i => 
             MGrammar i a -> i -> ModInfo i a -> MGrammar i a
addModule gr name mi = MGrammar $ (modules gr ++ [(name,mi)])

emptyMGrammar :: MGrammar i a
emptyMGrammar = MGrammar []

emptyModInfo :: ModInfo i a
emptyModInfo = ModInfo MTResource MSComplete noOptions [] Nothing [] [] emptyBinTree emptyBinTree

-- | we store the module type with the identifier
data IdentM i = IdentM {
  identM :: i ,
  typeM  :: ModuleType i
  }
  deriving (Eq,Ord,Show)

abstractOfConcrete :: (Show i, Eq i) => MGrammar i a -> i -> Err i
abstractOfConcrete gr c = do
  n <- lookupModule gr c
  case mtype n of
    MTConcrete a -> return a
    _ -> Bad $ "expected concrete" +++ show c

abstractModOfConcrete :: (Show i, Eq i) => 
                         MGrammar i a -> i -> Err (ModInfo i a)
abstractModOfConcrete gr c = do
  a <- abstractOfConcrete gr c
  lookupModule gr a


-- the canonical file name

--- canonFileName s = prt s ++ ".gfc"

lookupModule :: (Show i,Eq i) => MGrammar i a -> i -> Err (ModInfo i a)
lookupModule gr m = case lookup m (modules gr) of
  Just i -> return i
  _ -> Bad $ "unknown module" +++ show m 
             +++ "among" +++ unwords (map (show . fst) (modules gr)) ---- debug

lookupModuleType :: (Show i,Eq i) => MGrammar i a -> i -> Err (ModuleType i)
lookupModuleType gr m = do
  mi <- lookupModule gr m
  return $ mtype mi

lookupInfo :: (Show i, Ord i) => ModInfo i a -> i -> Err a
lookupInfo mo i = lookupTree show i (jments mo)

lookupPosition :: (Show i, Ord i) => ModInfo i a -> i -> Err (String,(Int,Int))
lookupPosition mo i = lookupTree show i (positions mo)

showPosition :: (Show i, Ord i) => ModInfo i a -> i -> String
showPosition mo i = case lookupPosition mo i of
  Ok (f,(b,e)) | b == e -> "in" +++ f ++ ", line" +++ show b
  Ok (f,(b,e)) -> "in" +++ f ++ ", lines" +++ show b ++ "-" ++ show e
  _ -> ""

ppPosition :: (Show i, Ord i) => ModInfo i a -> i -> Doc
ppPosition mo i = case lookupPosition mo i of
  Ok (f,(b,e)) | b == e    -> text "in" <+> text f <> text ", line" <+> int b
               | otherwise -> text "in" <+> text f <> text ", lines" <+> int b <> text "-" <> int e
  _ -> empty

isModAbs :: ModInfo i a -> Bool
isModAbs m = case mtype m of
  MTAbstract -> True
----  MTUnion t -> isModAbs t
  _ -> False

isModRes :: ModInfo i a -> Bool
isModRes m = case mtype m of
  MTResource -> True
  MTInterface -> True ---
  MTInstance _ -> True
  _ -> False

isModCnc :: ModInfo i a -> Bool
isModCnc m = case mtype m of
  MTConcrete _ -> True
  _ -> False

isModTrans :: ModInfo i a -> Bool
isModTrans m = case mtype m of
  MTTransfer _ _ -> True
  _ -> False

sameMType :: Eq i => ModuleType i -> ModuleType i -> Bool
sameMType m n = case (n,m) of
  (MTConcrete _, MTConcrete _) -> True

  (MTInstance _, MTInstance _) -> True
  (MTInstance _, MTResource)   -> True
  (MTInstance _, MTConcrete _) -> True

  (MTInterface,  MTInstance _) -> True
  (MTInterface,  MTResource)   -> True    -- for reuse
  (MTInterface,  MTAbstract)   -> True    -- for reuse
  (MTInterface,  MTConcrete _) -> True    -- for reuse

  (MTResource,   MTInstance _) -> True
  (MTResource,   MTConcrete _) -> True    -- for reuse

  _ -> m == n

-- | don't generate code for interfaces and for incomplete modules
isCompilableModule :: ModInfo i a -> Bool
isCompilableModule m =
  case mtype m of
    MTInterface -> False
    _           -> mstatus m == MSComplete

-- | interface and "incomplete M" are not complete
isCompleteModule :: (Eq i) =>  ModInfo i a -> Bool
isCompleteModule m = mstatus m == MSComplete && mtype m /= MTInterface


-- | all abstract modules sorted from least to most dependent
allAbstracts :: (Ord i, Show i) => MGrammar i a -> [i]
allAbstracts gr = 
 case topoTest [(i,extends m) | (i,m) <- modules gr, mtype m == MTAbstract] of
   Left is -> is
   Right cycles -> error $ "Cyclic abstract modules: " ++ show cycles

-- | the last abstract in dependency order (head of list)
greatestAbstract :: (Ord i, Show i) => MGrammar i a -> Maybe i
greatestAbstract gr = case allAbstracts gr of
  [] -> Nothing
  as -> return $ last as

-- | all resource modules
allResources :: MGrammar i a -> [i]
allResources gr = [i | (i,m) <- modules gr, isModRes m || isModCnc m]

-- | the greatest resource in dependency order
greatestResource :: MGrammar i a -> Maybe i
greatestResource gr = case allResources gr of
  [] -> Nothing
  a -> return $ head a ---- why not last as in Abstract? works though AR 24/5/2008

-- | all concretes for a given abstract
allConcretes :: Eq i => MGrammar i a -> i -> [i]
allConcretes gr a = 
  [i | (i, m) <- modules gr, mtype m == MTConcrete a, isCompleteModule m]

-- | all concrete modules for any abstract
allConcreteModules :: Eq i => MGrammar i a -> [i]
allConcreteModules gr = 
  [i | (i, m) <- modules gr, MTConcrete _ <- [mtype m], isCompleteModule m]
