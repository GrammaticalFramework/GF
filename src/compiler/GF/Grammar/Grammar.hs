----------------------------------------------------------------------
-- |
-- Module      : Grammar
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:20 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.8 $
--
-- GF source abstract syntax used internally in compilation.
--
-- AR 23\/1\/2000 -- 30\/5\/2001 -- 4\/5\/2003
-----------------------------------------------------------------------------

module GF.Grammar.Grammar (
        SourceGrammar, SourceModInfo(..), SourceModule, ModuleType(..),
        emptySourceGrammar, mGrammar, modules, prependModule, moduleMap,

        MInclude (..), OpenSpec(..),
        extends, isInherited, inheritAll,
        openedModule, depPathModule, allDepsModule, partOfGrammar,
        allExtends, allExtendSpecs, allExtendsPlus, allExtensions, 
        searchPathModule,
        
        lookupModule,
        isModAbs, isModRes, isModCnc,
        sameMType, isCompilableModule, isCompleteModule,
        allAbstracts, greatestAbstract, allResources,
        greatestResource, allConcretes, allConcreteModules,
        abstractOfConcrete,

        ModuleStatus(..),
        
        PMCFG(..), Production(..), FId, FunId, SeqId, LIndex, Sequence,
        
        Info(..),
        Location(..), L(..), unLoc, noLoc,
        Type,
        Cat,
        Fun,
        QIdent,
        BindType(..),
        Term(..),
        Patt(..),
        TInfo(..),
        Label(..),
        MetaId,
        Hypo,
        Context,
        Equation,
        Labelling,
        Assign,
        Case,
        LocalDef,
        Param,
        Altern,
        Substitution,
        varLabel, tupleLabel, linLabel, theLinLabel,
        ident2label, label2ident
        ) where

import GF.Infra.Ident
import GF.Infra.Option ---

import GF.Data.Operations

import PGF.Data (FId, FunId, SeqId, LIndex, Sequence, BindType(..))

import Data.List
import Data.Array.IArray
import Data.Array.Unboxed
import qualified Data.Map as Map
import qualified Data.Set as Set
import qualified Data.IntMap as IntMap
import qualified Data.ByteString.Char8 as BS
import Text.PrettyPrint
import System.FilePath
import Control.Monad.Identity



data SourceGrammar = MGrammar { 
    moduleMap :: Map.Map Ident SourceModInfo,
    modules :: [(Ident,SourceModInfo)]
  }

data SourceModInfo = ModInfo {
    mtype   :: ModuleType,
    mstatus :: ModuleStatus,
    mflags  :: Options,
    mextend :: [(Ident,MInclude)],
    mwith   :: Maybe (Ident,MInclude,[(Ident,Ident)]),
    mopens  :: [OpenSpec],
    mexdeps :: [Ident],
    msrc    :: FilePath,
    mseqs   :: Maybe (Array SeqId Sequence),
    jments  :: Map.Map Ident Info
  }

type SourceModule = (Ident, SourceModInfo)

-- | encoding the type of the module
data ModuleType = 
    MTAbstract 
  | MTResource
  | MTConcrete Ident
  | MTInterface
  | MTInstance (Ident,MInclude)
  deriving (Eq,Show)

data MInclude = MIAll | MIOnly [Ident] | MIExcept [Ident]
  deriving (Eq,Show)

extends :: SourceModInfo -> [Ident]
extends = map fst . mextend

isInherited :: MInclude -> Ident -> Bool
isInherited c i = case c of
  MIAll -> True
  MIOnly is -> elem i is
  MIExcept is -> notElem i is

inheritAll :: Ident -> (Ident,MInclude)
inheritAll i = (i,MIAll)

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
depPathModule :: SourceModInfo -> [OpenSpec]
depPathModule m = fors m ++ exts m ++ mopens m
  where
    fors m = 
      case mtype m of
        MTConcrete i   -> [OSimple i]
        MTInstance (i,_)   -> [OSimple i]
        _              -> []
    exts m = map OSimple (extends m)

-- | all dependencies
allDepsModule :: SourceGrammar -> SourceModInfo -> [OpenSpec]
allDepsModule gr m = iterFix add os0 where
  os0 = depPathModule m
  add os = [m | o <- os, Just n <- [lookup (openedModule o) mods], 
                m <- depPathModule n]
  mods = modules gr

-- | select just those modules that a given one depends on, including itself
partOfGrammar :: SourceGrammar -> (Ident,SourceModInfo) -> SourceGrammar
partOfGrammar gr (i,m) = mGrammar [mo | mo@(j,_) <- mods, elem j modsFor]
  where
    mods = modules gr
    modsFor = (i:) $ map openedModule $ allDepsModule gr m

-- | all modules that a module extends, directly or indirectly, without restricts
allExtends :: SourceGrammar -> Ident -> [Ident]
allExtends gr i =
  case lookupModule gr i of
    Ok m -> case extends m of 
              [] -> [i]
              is -> i : concatMap (allExtends gr) is
    _    -> []

-- | all modules that a module extends, directly or indirectly, with restricts
allExtendSpecs :: SourceGrammar -> Ident -> [(Ident,MInclude)]
allExtendSpecs gr i =
  case lookupModule gr i of
    Ok m -> case mextend m of 
              [] -> [(i,MIAll)]
              is ->  (i,MIAll) : concatMap (allExtendSpecs gr . fst) is
    _    -> []

-- | this plus that an instance extends its interface
allExtendsPlus :: SourceGrammar -> Ident -> [Ident]
allExtendsPlus gr i =
  case lookupModule gr i of
    Ok m -> i : concatMap (allExtendsPlus gr) (exts m)
    _    -> []
  where
    exts m = extends m ++ [j | MTInstance (j,_) <- [mtype m]]

-- | conversely: all modules that extend a given module, incl. instances of interface
allExtensions :: SourceGrammar -> Ident -> [Ident]
allExtensions gr i =
  case lookupModule gr i of
    Ok m -> let es = exts i in es ++ concatMap (allExtensions gr) es
    _    -> []
 where
   exts i = [j | (j,m) <- mods, elem i (extends m) || isInstanceOf i m]
   mods = modules gr
   isInstanceOf i m = case mtype m of
     MTInstance (j,_) -> j == i
     _ -> False

-- | initial search path: the nonqualified dependencies
searchPathModule :: SourceModInfo -> [Ident]
searchPathModule m = [i | OSimple i <- depPathModule m]

prependModule (MGrammar mm ms) im@(i,m) = MGrammar (Map.insert i m mm) (im:ms)

emptySourceGrammar :: SourceGrammar
emptySourceGrammar = mGrammar []

mGrammar ms = MGrammar (Map.fromList ms) ms


-- | we store the module type with the identifier

abstractOfConcrete :: SourceGrammar -> Ident -> Err Ident
abstractOfConcrete gr c = do
  n <- lookupModule gr c
  case mtype n of
    MTConcrete a -> return a
    _ -> Bad $ render (text "expected concrete" <+> ppIdent c)

lookupModule :: SourceGrammar -> Ident -> Err SourceModInfo
lookupModule gr m = case Map.lookup m (moduleMap gr) of
  Just i  -> return i
  Nothing -> Bad $ render (text "unknown module" <+> ppIdent m <+> text "among" <+> hsep (map (ppIdent . fst) (modules gr)))

isModAbs :: SourceModInfo -> Bool
isModAbs m =
  case mtype m of
    MTAbstract -> True
    _          -> False

isModRes :: SourceModInfo -> Bool
isModRes m =
  case mtype m of
    MTResource   -> True
    MTInterface  -> True ---
    MTInstance _ -> True
    _            -> False

isModCnc :: SourceModInfo -> Bool
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
isCompilableModule :: SourceModInfo -> Bool
isCompilableModule m =
  case mtype m of
    MTInterface -> False
    _           -> mstatus m == MSComplete

-- | interface and "incomplete M" are not complete
isCompleteModule :: SourceModInfo -> Bool
isCompleteModule m = mstatus m == MSComplete && mtype m /= MTInterface


-- | all abstract modules sorted from least to most dependent
allAbstracts :: SourceGrammar -> [Ident]
allAbstracts gr = 
 case topoTest [(i,extends m) | (i,m) <- modules gr, mtype m == MTAbstract] of
   Left  is     -> is
   Right cycles -> error $ render (text "Cyclic abstract modules:" <+> vcat (map (hsep . map ppIdent) cycles))

-- | the last abstract in dependency order (head of list)
greatestAbstract :: SourceGrammar -> Maybe Ident
greatestAbstract gr =
  case allAbstracts gr of
    [] -> Nothing
    as -> return $ last as

-- | all resource modules
allResources :: SourceGrammar -> [Ident]
allResources gr = [i | (i,m) <- modules gr, isModRes m || isModCnc m]

-- | the greatest resource in dependency order
greatestResource :: SourceGrammar -> Maybe Ident
greatestResource gr =
  case allResources gr of
    [] -> Nothing
    a  -> return $ head a ---- why not last as in Abstract? works though AR 24/5/2008

-- | all concretes for a given abstract
allConcretes :: SourceGrammar -> Ident -> [Ident]
allConcretes gr a =
  [i | (i, m) <- modules gr, mtype m == MTConcrete a, isCompleteModule m]

-- | all concrete modules for any abstract
allConcreteModules :: SourceGrammar -> [Ident]
allConcreteModules gr =
  [i | (i, m) <- modules gr, MTConcrete _ <- [mtype m], isCompleteModule m]


data Production = Production {-# UNPACK #-} !FId
                             {-# UNPACK #-} !FunId
                             [[FId]]
                  deriving (Eq,Ord,Show)

data PMCFG = PMCFG [Production]
                   (Array FunId (UArray LIndex SeqId)) 
             deriving (Eq,Show)

-- | the constructors are judgements in 
--
--   - abstract syntax (/ABS/)
-- 
--   - resource (/RES/)
--
--   - concrete syntax (/CNC/)
--
-- and indirection to module (/INDIR/)
data Info =
-- judgements in abstract syntax
   AbsCat   (Maybe (L Context))                                            -- ^ (/ABS/) context of a category
 | AbsFun   (Maybe (L Type)) (Maybe Int) (Maybe [L Equation]) (Maybe Bool) -- ^ (/ABS/) type, arrity and definition of a function

-- judgements in resource
 | ResParam (Maybe (L [Param])) (Maybe [Term])   -- ^ (/RES/) the second parameter is list of all possible values
 | ResValue (L Type)                             -- ^ (/RES/) to mark parameter constructors for lookup
 | ResOper  (Maybe (L Type)) (Maybe (L Term))    -- ^ (/RES/)

 | ResOverload [Ident] [(L Type,L Term)]         -- ^ (/RES/) idents: modules inherited

-- judgements in concrete syntax
 | CncCat  (Maybe (L Type))             (Maybe (L Term)) (Maybe (L Term)) (Maybe PMCFG) -- ^ (/CNC/) lindef ini'zed, 
 | CncFun  (Maybe (Ident,Context,Type)) (Maybe (L Term)) (Maybe (L Term)) (Maybe PMCFG) -- ^ (/CNC/) type info added at 'TC'

-- indirection to module Ident
 | AnyInd Bool Ident                         -- ^ (/INDIR/) the 'Bool' says if canonical
  deriving Show

data Location 
  = NoLoc
  | Local Int Int
  | External FilePath Location
  deriving (Show,Eq,Ord)

data L a = L Location a  -- location information
  deriving Show

instance Functor L where
  fmap f (L loc x) = L loc (f x)

unLoc :: L a -> a
unLoc (L _ x) = x

noLoc = L NoLoc

type Type = Term
type Cat  = QIdent
type Fun  = QIdent

type QIdent = (Ident,Ident)

data Term =
   Vr Ident                      -- ^ variable
 | Cn Ident                      -- ^ constant
 | Con Ident                     -- ^ constructor
 | Sort Ident                    -- ^ basic type
 | EInt Int                      -- ^ integer literal
 | EFloat Double                 -- ^ floating point literal
 | K String                      -- ^ string literal or token: @\"foo\"@
 | Empty                         -- ^ the empty string @[]@

 | App Term Term                 -- ^ application: @f a@
 | Abs BindType Ident Term       -- ^ abstraction: @\x -> b@
 | Meta {-# UNPACK #-} !MetaId   -- ^ metavariable: @?i@ (only parsable: ? = ?0)
 | ImplArg Term                  -- ^ placeholder for implicit argument @{t}@
 | Prod BindType Ident Term Term -- ^ function type: @(x : A) -> B@, @A -> B@, @({x} : A) -> B@
 | Typed Term Term               -- ^ type-annotated term
--
-- /below this, the constructors are only for concrete syntax/
 | Example Term String           -- ^ example-based term: @in M.C "foo"
 | RecType [Labelling]           -- ^ record type: @{ p : A ; ...}@
 | R [Assign]                    -- ^ record:      @{ p = a ; ...}@
 | P Term Label                  -- ^ projection:  @r.p@
 | ExtR Term Term                -- ^ extension:   @R ** {x : A}@ (both types and terms)
 
 | Table Term Term               -- ^ table type:  @P => A@
 | T TInfo [Case]                -- ^ table:       @table {p => c ; ...}@
 | V Type [Term]                 -- ^ table given as course of values: @table T [c1 ; ... ; cn]@
 | S Term Term                   -- ^ selection:   @t ! p@

 | Let LocalDef Term             -- ^ local definition: @let {t : T = a} in b@

 | Q  QIdent                     -- ^ qualified constant from a package
 | QC QIdent                     -- ^ qualified constructor from a package

 | C Term Term                   -- ^ concatenation: @s ++ t@
 | Glue Term Term                -- ^ agglutination: @s + t@

 | EPatt Patt                    -- ^ pattern (in macro definition): # p
 | EPattType Term                -- ^ pattern type: pattern T

 | ELincat Ident Term            -- ^ boxed linearization type of Ident
 | ELin Ident Term               -- ^ boxed linearization of type Ident

 | FV [Term]                     -- ^ alternatives in free variation: @variants { s ; ... }@

 | Alts Term [(Term, Term)]      -- ^ alternatives by prefix: @pre {t ; s\/c ; ...}@
 | Strs [Term]                   -- ^ conditioning prefix strings: @strs {s ; ...}@
 | Error String                  -- ^ error values returned by Predef.error
  deriving (Show, Eq, Ord)

-- | Patterns
data Patt =
   PC Ident [Patt]        -- ^ constructor pattern: @C p1 ... pn@    @C@ 
 | PP QIdent [Patt]       -- ^ package constructor pattern: @P.C p1 ... pn@    @P.C@ 
 | PV Ident               -- ^ variable pattern: @x@
 | PW                     -- ^ wild card pattern: @_@
 | PR [(Label,Patt)]      -- ^ record pattern: @{r = p ; ...}@  -- only concrete
 | PString String         -- ^ string literal pattern: @\"foo\"@  -- only abstract
 | PInt    Int            -- ^ integer literal pattern: @12@    -- only abstract
 | PFloat Double          -- ^ float literal pattern: @1.2@    -- only abstract
 | PT Type Patt           -- ^ type-annotated pattern

 | PAs Ident Patt         -- ^ as-pattern: x@p
 
 | PImplArg Patt          -- ^ placeholder for pattern for implicit argument @{p}@
 | PTilde   Term          -- ^ inaccessible pattern

 -- regular expression patterns
 | PNeg Patt              -- ^ negated pattern: -p
 | PAlt Patt Patt         -- ^ disjunctive pattern: p1 | p2
 | PSeq Patt Patt         -- ^ sequence of token parts: p + q
 | PMSeq MPatt MPatt      -- ^ sequence of token parts: p + q
 | PRep Patt              -- ^ repetition of token part: p*
 | PChar                  -- ^ string of length one: ?
 | PChars [Char]          -- ^ character list: ["aeiou"]
 | PMacro Ident           -- #p
 | PM QIdent              -- #m.p
  deriving (Show, Eq, Ord)

-- | Measured pattern (paired with the min & max matching length)
type MPatt = ((Int,Int),Patt)

-- | to guide computation and type checking of tables
data TInfo = 
   TRaw         -- ^ received from parser; can be anything
 | TTyped Type  -- ^ type annontated, but can be anything
 | TComp Type   -- ^ expanded
 | TWild Type   -- ^ just one wild card pattern, no need to expand 
  deriving (Show, Eq, Ord)

-- | record label
data Label = 
    LIdent BS.ByteString
  | LVar Int
   deriving (Show, Eq, Ord)

type MetaId = Int

type Hypo     = (BindType,Ident,Term)   -- (x:A)  (_:A)  A  ({x}:A)
type Context  = [Hypo]                  -- (x:A)(y:B)   (x,y:A)   (_,_:A)
type Equation = ([Patt],Term) 

type Labelling = (Label, Type) 
type Assign = (Label, (Maybe Type, Term)) 
type Case = (Patt, Term) 
type Cases = ([Patt], Term) 
type LocalDef = (Ident, (Maybe Type, Term))

type Param = (Ident, Context) 
type Altern = (Term, [(Term, Term)])

type Substitution =  [(Ident, Term)]

varLabel :: Int -> Label
varLabel = LVar

tupleLabel, linLabel :: Int -> Label
tupleLabel i = LIdent $! BS.pack ('p':show i)
linLabel   i = LIdent $! BS.pack ('s':show i)

theLinLabel :: Label
theLinLabel = LIdent (BS.singleton 's')

ident2label :: Ident -> Label
ident2label c = LIdent (ident2bs c)

label2ident :: Label -> Ident
label2ident (LIdent s) = identC s
label2ident (LVar i)   = identC (BS.pack ('$':show i))

