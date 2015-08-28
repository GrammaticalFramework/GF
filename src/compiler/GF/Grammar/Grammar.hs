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
        -- ** Grammar modules
        Grammar, ModuleName, Module, ModuleInfo(..),
        SourceGrammar, SourceModInfo, SourceModule,
        ModuleType(..),
        emptyGrammar, mGrammar, modules, prependModule, moduleMap,

        MInclude (..), OpenSpec(..),
        extends, isInherited, inheritAll,
        openedModule, allDepsModule, partOfGrammar, depPathModule,
        allExtends, allExtendsPlus, --searchPathModule,
        
        lookupModule,
        isModAbs, isModRes, isModCnc,
        sameMType, isCompilableModule, isCompleteModule,
        allAbstracts, greatestAbstract, allResources,
        greatestResource, allConcretes, allConcreteModules,
        abstractOfConcrete,

        ModuleStatus(..),

        -- ** Judgements
        Info(..),
        -- ** Terms
        Term(..),
        Type,
        Cat,
        Fun,
        QIdent,
        BindType(..),
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
        ident2label, label2ident,
        -- ** Source locations
        Location(..), L(..), unLoc, noLoc, ppLocation, ppL,

        -- ** PMCFG        
        PMCFG(..), Production(..), FId, FunId, SeqId, LIndex, Sequence
        ) where

import GF.Infra.Ident
import GF.Infra.Option ---
import GF.Infra.Location

import GF.Data.Operations

import PGF.Internal (FId, FunId, SeqId, LIndex, Sequence, BindType(..))

import Data.Array.IArray(Array)
import Data.Array.Unboxed(UArray)
import qualified Data.Map as Map
import GF.Text.Pretty


-- | A grammar is a self-contained collection of grammar modules
data Grammar = MGrammar { 
    moduleMap :: Map.Map ModuleName ModuleInfo,
    modules :: [Module]
  }

-- | Modules
type Module = (ModuleName, ModuleInfo)

data ModuleInfo = ModInfo {
    mtype   :: ModuleType,
    mstatus :: ModuleStatus,
    mflags  :: Options,
    mextend :: [(ModuleName,MInclude)],
    mwith   :: Maybe (ModuleName,MInclude,[(ModuleName,ModuleName)]),
    mopens  :: [OpenSpec],
    mexdeps :: [ModuleName],
    msrc    :: FilePath,
    mseqs   :: Maybe (Array SeqId Sequence),
    jments  :: Map.Map Ident Info
  }

type SourceGrammar = Grammar
type SourceModule = Module
type SourceModInfo = ModuleInfo

instance HasSourcePath ModuleInfo where sourcePath = msrc

-- | encoding the type of the module
data ModuleType = 
    MTAbstract 
  | MTResource
  | MTConcrete ModuleName
  | MTInterface
  | MTInstance (ModuleName,MInclude)
  deriving (Eq,Show)

data MInclude = MIAll | MIOnly [Ident] | MIExcept [Ident]
  deriving (Eq,Show)

extends :: ModuleInfo -> [ModuleName]
extends = map fst . mextend

isInherited :: MInclude -> Ident -> Bool
isInherited c i = case c of
  MIAll -> True
  MIOnly is -> elem i is
  MIExcept is -> notElem i is

inheritAll :: ModuleName -> (ModuleName,MInclude)
inheritAll i = (i,MIAll)

data OpenSpec = 
   OSimple ModuleName
 | OQualif ModuleName ModuleName
  deriving (Eq,Show)

data ModuleStatus = 
   MSComplete 
 | MSIncomplete 
  deriving (Eq,Ord,Show)

openedModule :: OpenSpec -> ModuleName
openedModule o = case o of
  OSimple m -> m
  OQualif _ m -> m

-- | initial dependency list
depPathModule :: ModuleInfo -> [OpenSpec]
depPathModule m = fors m ++ exts m ++ mopens m
  where
    fors m = 
      case mtype m of
        MTConcrete i   -> [OSimple i]
        MTInstance (i,_)   -> [OSimple i]
        _              -> []
    exts m = map OSimple (extends m)

-- | all dependencies
allDepsModule :: Grammar -> ModuleInfo -> [OpenSpec]
allDepsModule gr m = iterFix add os0 where
  os0 = depPathModule m
  add os = [m | o <- os, Just n <- [lookup (openedModule o) mods], 
                m <- depPathModule n]
  mods = modules gr

-- | select just those modules that a given one depends on, including itself
partOfGrammar :: Grammar -> Module -> Grammar
partOfGrammar gr (i,m) = mGrammar [mo | mo@(j,_) <- mods, elem j modsFor]
  where
    mods = modules gr
    modsFor = (i:) $ map openedModule $ allDepsModule gr m

-- | all modules that a module extends, directly or indirectly, with restricts
allExtends :: Grammar -> ModuleName -> [Module]
allExtends gr m =
  case lookupModule gr m of
    Ok mi -> (m,mi) : concatMap (allExtends gr . fst) (mextend mi)
    _     -> []

-- | the same as 'allExtends' plus that an instance extends its interface
allExtendsPlus :: Grammar -> ModuleName -> [ModuleName]
allExtendsPlus gr i =
  case lookupModule gr i of
    Ok m -> i : concatMap (allExtendsPlus gr) (exts m)
    _    -> []
  where
    exts m = extends m ++ [j | MTInstance (j,_) <- [mtype m]]

-- -- | initial search path: the nonqualified dependencies
-- searchPathModule :: ModuleInfo -> [ModuleName]
-- searchPathModule m = [i | OSimple i <- depPathModule m]

prependModule :: Grammar -> Module -> Grammar
prependModule (MGrammar mm ms) im@(i,m) = MGrammar (Map.insert i m mm) (im:ms)

emptyGrammar = mGrammar []

mGrammar :: [Module] -> Grammar
mGrammar ms = MGrammar (Map.fromList ms) ms


-- | we store the module type with the identifier

abstractOfConcrete :: ErrorMonad m => Grammar -> ModuleName -> m ModuleName
abstractOfConcrete gr c = do
  n <- lookupModule gr c
  case mtype n of
    MTConcrete a -> return a
    _ -> raise $ render ("expected concrete" <+> c)

lookupModule :: ErrorMonad m => Grammar -> ModuleName -> m ModuleInfo
lookupModule gr m = case Map.lookup m (moduleMap gr) of
  Just i  -> return i
  Nothing -> raise $ render ("unknown module" <+> m <+> "among" <+> hsep (map fst (modules gr)))

isModAbs :: ModuleInfo -> Bool
isModAbs m =
  case mtype m of
    MTAbstract -> True
    _          -> False

isModRes :: ModuleInfo -> Bool
isModRes m =
  case mtype m of
    MTResource   -> True
    MTInterface  -> True ---
    MTInstance _ -> True
    _            -> False

isModCnc :: ModuleInfo -> Bool
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
isCompilableModule :: ModuleInfo -> Bool
isCompilableModule m =
  case mtype m of
    MTInterface -> False
    _           -> mstatus m == MSComplete

-- | interface and "incomplete M" are not complete
isCompleteModule :: ModuleInfo -> Bool
isCompleteModule m = mstatus m == MSComplete && mtype m /= MTInterface


-- | all abstract modules sorted from least to most dependent
allAbstracts :: Grammar -> [ModuleName]
allAbstracts gr = 
 case topoTest [(i,extends m) | (i,m) <- modules gr, mtype m == MTAbstract] of
   Left  is     -> is
   Right cycles -> error $ render ("Cyclic abstract modules:" <+> vcat (map hsep cycles))

-- | the last abstract in dependency order (head of list)
greatestAbstract :: Grammar -> Maybe ModuleName
greatestAbstract gr =
  case allAbstracts gr of
    [] -> Nothing
    as -> return $ last as

-- | all resource modules
allResources :: Grammar -> [ModuleName]
allResources gr = [i | (i,m) <- modules gr, isModRes m || isModCnc m]

-- | the greatest resource in dependency order
greatestResource :: Grammar -> Maybe ModuleName
greatestResource gr =
  case allResources gr of
    [] -> Nothing
    a  -> return $ head a ---- why not last as in Abstract? works though AR 24/5/2008

-- | all concretes for a given abstract
allConcretes :: Grammar -> ModuleName -> [ModuleName]
allConcretes gr a =
  [i | (i, m) <- modules gr, mtype m == MTConcrete a, isCompleteModule m]

-- | all concrete modules for any abstract
allConcreteModules :: Grammar -> [ModuleName]
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

 | ResOverload [ModuleName] [(L Type,L Term)]         -- ^ (/RES/) idents: modules inherited

-- judgements in concrete syntax
 | CncCat  (Maybe (L Type))             (Maybe (L Term)) (Maybe (L Term)) (Maybe (L Term)) (Maybe PMCFG) -- ^ (/CNC/) lindef ini'zed, 
 | CncFun  (Maybe (Ident,Context,Type)) (Maybe (L Term))                  (Maybe (L Term)) (Maybe PMCFG) -- ^ (/CNC/) type info added at 'TC'

-- indirection to module Ident
 | AnyInd Bool ModuleName                        -- ^ (/INDIR/) the 'Bool' says if canonical
  deriving Show

type Type = Term
type Cat  = QIdent
type Fun  = QIdent

type QIdent = (ModuleName,Ident)

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

 | AdHocOverload [Term]          -- ^ ad hoc overloading generated in Rename

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
    LIdent RawIdent
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
tupleLabel i = LIdent $! rawIdentS ('p':show i)
linLabel   i = LIdent $! rawIdentS ('s':show i)

theLinLabel :: Label
theLinLabel = LIdent (rawIdentS "s")

ident2label :: Ident -> Label
ident2label c = LIdent (ident2raw c)

label2ident :: Label -> Ident
label2ident (LIdent s) = identC s
label2ident (LVar i)   = identS ('$':show i)
