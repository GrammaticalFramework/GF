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
        openedModule, depPathModule, allDepsModule, partOfGrammar,
        allExtends, allExtendSpecs, allExtendsPlus, allExtensions, 
        searchPathModule, addModule,
        emptyMGrammar, emptyModInfo,
        abstractOfConcrete, abstractModOfConcrete,
        lookupModule, lookupModuleType, lookupInfo,
        isModAbs, isModRes, isModCnc,
        sameMType, isCompilableModule, isCompleteModule,
        allAbstracts, greatestAbstract, allResources,
        greatestResource, allConcretes, allConcreteModules
        ) where

import GF.Infra.Ident
import GF.Infra.Option
import GF.Data.Operations

import Data.List
import qualified Data.Map as Map
import Text.PrettyPrint

-- AR 29/4/2003

-- The same structure will be used in both source code and canonical.
-- The parameters tell what kind of data is involved.
-- Invariant: modules are stored in dependency order

newtype MGrammar a = MGrammar {modules :: [(Ident,ModInfo a)]}
  deriving Show

data ModInfo a = ModInfo {
    mtype   :: ModuleType,
    mstatus :: ModuleStatus,
    flags   :: Options,
    extend  :: [(Ident,MInclude)],
    mwith   :: Maybe (Ident,MInclude,[(Ident,Ident)]),
    opens   :: [OpenSpec],
    mexdeps :: [Ident],
    jments  :: Map.Map Ident a
  }
  deriving Show

-- | encoding the type of the module
data ModuleType = 
    MTAbstract 
  | MTResource
  | MTConcrete Ident
    -- ^ up to this, also used in GFO. Below, source only.
  | MTInterface
  | MTInstance Ident
  deriving (Eq,Show)

data MInclude = MIAll | MIOnly [Ident] | MIExcept [Ident]
  deriving (Eq,Show)

extends :: ModInfo a -> [Ident]
extends = map fst . extend

isInherited :: MInclude -> Ident -> Bool
isInherited c i = case c of
  MIAll -> True
  MIOnly is -> elem i is
  MIExcept is -> notElem i is

inheritAll :: Ident -> (Ident,MInclude)
inheritAll i = (i,MIAll)

-- destructive update

-- | dep order preserved since old cannot depend on new
updateMGrammar :: MGrammar a -> MGrammar a -> MGrammar a
updateMGrammar old new = MGrammar $
  [(i,m) | (i,m) <- os, notElem i (map fst ns)] ++ ns
 where
   os = modules old
   ns = modules new

updateModule :: ModInfo t -> Ident -> t -> ModInfo t
updateModule (ModInfo mt ms fs me mw ops med js) i t = ModInfo mt ms fs me mw ops med (updateTree (i,t) js)

replaceJudgements :: ModInfo t -> Map.Map Ident t -> ModInfo t
replaceJudgements (ModInfo mt ms fs me mw ops med _) js = ModInfo mt ms fs me mw ops med js

addOpenQualif :: Ident -> Ident -> ModInfo t -> ModInfo t
addOpenQualif i j (ModInfo mt ms fs me mw ops med js) = ModInfo mt ms fs me mw (OQualif i j : ops) med js

addFlag :: Options -> ModInfo t -> ModInfo t
addFlag f mo = mo {flags = flags mo `addOptions` f} 

flagsModule :: (Ident,ModInfo a) -> Options
flagsModule (_,mi) = flags mi

allFlags :: MGrammar a -> Options
allFlags gr = concatOptions [flags m | (_,m) <- modules gr]

mapModules :: (ModInfo a -> ModInfo a) -> MGrammar a -> MGrammar a 
mapModules f (MGrammar ms) = MGrammar (map (onSnd f) ms)

data OpenSpec = 
   OSimple Ident
 | OQualif Ident Ident
  deriving (Eq,Show)

data ModuleStatus = 
   MSComplete 
 | MSIncomplete 
  deriving (Eq,Ord,Show)

openedModule :: OpenSpec -> Ident
openedModule o = case o of
  OSimple m -> m
  OQualif _ m -> m

-- | initial dependency list
depPathModule :: ModInfo a -> [OpenSpec]
depPathModule m = fors m ++ exts m ++ opens m
  where
    fors m = 
      case mtype m of
        MTConcrete i   -> [OSimple i]
        MTInstance i   -> [OSimple i]
        _              -> []
    exts m = map OSimple (extends m)

-- | all dependencies
allDepsModule :: MGrammar a -> ModInfo a -> [OpenSpec]
allDepsModule gr m = iterFix add os0 where
  os0 = depPathModule m
  add os = [m | o <- os, Just n <- [lookup (openedModule o) mods], 
                m <- depPathModule n]
  mods = modules gr

-- | select just those modules that a given one depends on, including itself
partOfGrammar :: MGrammar a -> (Ident,ModInfo a) -> MGrammar a
partOfGrammar gr (i,m) = MGrammar [mo | mo@(j,_) <- mods, elem j modsFor] 
  where
    mods = modules gr
    modsFor = (i:) $ map openedModule $ allDepsModule gr m

-- | all modules that a module extends, directly or indirectly, without restricts
allExtends :: MGrammar a -> Ident -> [Ident]
allExtends gr i =
  case lookupModule gr i of
    Ok m -> case extends m of 
              [] -> [i]
              is -> i : concatMap (allExtends gr) is
    _    -> []

-- | all modules that a module extends, directly or indirectly, with restricts
allExtendSpecs :: MGrammar a -> Ident -> [(Ident,MInclude)]
allExtendSpecs gr i =
  case lookupModule gr i of
    Ok m -> case extend m of 
              [] -> [(i,MIAll)]
              is ->  (i,MIAll) : concatMap (allExtendSpecs gr . fst) is
    _    -> []

-- | this plus that an instance extends its interface
allExtendsPlus :: MGrammar a -> Ident -> [Ident]
allExtendsPlus gr i =
  case lookupModule gr i of
    Ok m -> i : concatMap (allExtendsPlus gr) (exts m)
    _    -> []
  where
    exts m = extends m ++ [j | MTInstance j <- [mtype m]]

-- | conversely: all modules that extend a given module, incl. instances of interface
allExtensions :: MGrammar a -> Ident -> [Ident]
allExtensions gr i =
  case lookupModule gr i of
    Ok m -> let es = exts i in es ++ concatMap (allExtensions gr) es
    _    -> []
 where
   exts i = [j | (j,m) <- mods, elem i (extends m) 
                             || elem (MTInstance i) [mtype m]]
   mods = modules gr

-- | initial search path: the nonqualified dependencies
searchPathModule :: ModInfo a -> [Ident]
searchPathModule m = [i | OSimple i <- depPathModule m]

-- | a new module can safely be added to the end, since nothing old can depend on it
addModule :: MGrammar a -> Ident -> ModInfo a -> MGrammar a
addModule gr name mi = MGrammar $ (modules gr ++ [(name,mi)])

emptyMGrammar :: MGrammar a
emptyMGrammar = MGrammar []

emptyModInfo :: ModInfo a
emptyModInfo = ModInfo MTResource MSComplete noOptions [] Nothing [] [] emptyBinTree

-- | we store the module type with the identifier

abstractOfConcrete :: MGrammar a -> Ident -> Err Ident
abstractOfConcrete gr c = do
  n <- lookupModule gr c
  case mtype n of
    MTConcrete a -> return a
    _ -> Bad $ render (text "expected concrete" <+> ppIdent c)

abstractModOfConcrete :: MGrammar a -> Ident -> Err (ModInfo a)
abstractModOfConcrete gr c = do
  a <- abstractOfConcrete gr c
  lookupModule gr a


-- the canonical file name

--- canonFileName s = prt s ++ ".gfc"

lookupModule :: MGrammar a -> Ident -> Err (ModInfo a)
lookupModule gr m = case lookup m (modules gr) of
  Just i  -> return i
  Nothing -> Bad $ render (text "unknown module" <+> ppIdent m <+> text "among" <+> hsep (map (ppIdent . fst) (modules gr)))

lookupModuleType :: MGrammar a -> Ident -> Err ModuleType
lookupModuleType gr m = do
  mi <- lookupModule gr m
  return $ mtype mi

lookupInfo :: ModInfo a -> Ident -> Err a
lookupInfo mo i = lookupTree showIdent i (jments mo)

isModAbs :: ModInfo a -> Bool
isModAbs m =
  case mtype m of
    MTAbstract -> True
    _          -> False

isModRes :: ModInfo a -> Bool
isModRes m =
  case mtype m of
    MTResource   -> True
    MTInterface  -> True ---
    MTInstance _ -> True
    _            -> False

isModCnc :: ModInfo a -> Bool
isModCnc m =
  case mtype m of
    MTConcrete _ -> True
    _            -> False

sameMType :: ModuleType -> ModuleType -> Bool
sameMType m n =
  case (n,m) of
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

    _                            -> m == n

-- | don't generate code for interfaces and for incomplete modules
isCompilableModule :: ModInfo a -> Bool
isCompilableModule m =
  case mtype m of
    MTInterface -> False
    _           -> mstatus m == MSComplete

-- | interface and "incomplete M" are not complete
isCompleteModule :: ModInfo a -> Bool
isCompleteModule m = mstatus m == MSComplete && mtype m /= MTInterface


-- | all abstract modules sorted from least to most dependent
allAbstracts :: MGrammar a -> [Ident]
allAbstracts gr = 
 case topoTest [(i,extends m) | (i,m) <- modules gr, mtype m == MTAbstract] of
   Left  is     -> is
   Right cycles -> error $ render (text "Cyclic abstract modules:" <+> vcat (map (hsep . map ppIdent) cycles))

-- | the last abstract in dependency order (head of list)
greatestAbstract :: MGrammar a -> Maybe Ident
greatestAbstract gr =
  case allAbstracts gr of
    [] -> Nothing
    as -> return $ last as

-- | all resource modules
allResources :: MGrammar a -> [Ident]
allResources gr = [i | (i,m) <- modules gr, isModRes m || isModCnc m]

-- | the greatest resource in dependency order
greatestResource :: MGrammar a -> Maybe Ident
greatestResource gr =
  case allResources gr of
    [] -> Nothing
    a  -> return $ head a ---- why not last as in Abstract? works though AR 24/5/2008

-- | all concretes for a given abstract
allConcretes :: MGrammar a -> Ident -> [Ident]
allConcretes gr a =
  [i | (i, m) <- modules gr, mtype m == MTConcrete a, isCompleteModule m]

-- | all concrete modules for any abstract
allConcreteModules :: MGrammar a -> [Ident]
allConcreteModules gr =
  [i | (i, m) <- modules gr, MTConcrete _ <- [mtype m], isCompleteModule m]
