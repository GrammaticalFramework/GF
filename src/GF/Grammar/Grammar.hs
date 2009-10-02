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

module GF.Grammar.Grammar (SourceGrammar,
        emptySourceGrammar,                
        SourceModInfo,
        SourceModule,
        mapSourceModule,
        Info(..),
        PValues,
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
        Cases,
        LocalDef,
        Param,
        Altern,
        Substitution,
        varLabel, tupleLabel, linLabel, theLinLabel,
        ident2label, label2ident
        ) where

import GF.Infra.Ident
import GF.Infra.Option ---
import GF.Infra.Modules

import GF.Data.Operations

import qualified Data.ByteString.Char8 as BS

-- | grammar as presented to the compiler
type SourceGrammar = MGrammar Ident Info

emptySourceGrammar = MGrammar []

type SourceModInfo = ModInfo Ident Info

type SourceModule = (Ident, SourceModInfo)

mapSourceModule :: (SourceModInfo -> SourceModInfo) -> (SourceModule -> SourceModule)
mapSourceModule f (i,mi) = (i, f mi)

-- this is created in CheckGrammar, and so are Val and PVal
type PValues = [Term]

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
   AbsCat   (Maybe Context) (Maybe [Term])               -- ^ (/ABS/) the second parameter is list of constructors - must be 'Id' or 'QId'
 | AbsFun   (Maybe Type) (Maybe Int) (Maybe [Equation])  -- ^ (/ABS/) type, arrity and definition of function

-- judgements in resource
 | ResParam (Maybe ([Param],Maybe PValues))  -- ^ (/RES/)
 | ResValue (Maybe (Type,Maybe Int))         -- ^ (/RES/) to mark parameter constructors for lookup
 | ResOper  (Maybe Type) (Maybe Term)        -- ^ (/RES/)

 | ResOverload [Ident] [(Type,Term)]         -- ^ (/RES/) idents: modules inherited

-- judgements in concrete syntax
 | CncCat  (Maybe Type)                   (Maybe Term) (Maybe Term)  -- ^ (/CNC/) lindef ini'zed, 
 | CncFun  (Maybe (Ident,(Context,Type))) (Maybe Term) (Maybe Term)  -- ^ (/CNC/) type info added at 'TC'

-- indirection to module Ident
 | AnyInd Bool Ident                         -- ^ (/INDIR/) the 'Bool' says if canonical
  deriving Show

type Type = Term
type Cat  = QIdent
type Fun  = QIdent

type QIdent = (Ident,Ident)

data BindType = 
    Explicit
  | Implicit
  deriving (Eq,Ord,Show)

data Term =
   Vr Ident                      -- ^ variable
 | Cn Ident                      -- ^ constant
 | Con Ident                     -- ^ constructor
 | Sort Ident                    -- ^ basic type
 | EInt Integer                  -- ^ integer literal
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
 | PI Term Label Int             -- ^ index-annotated projection
 | ExtR Term Term                -- ^ extension:   @R ** {x : A}@ (both types and terms)
 
 | Table Term Term               -- ^ table type:  @P => A@
 | T TInfo [Case]                -- ^ table:       @table {p => c ; ...}@
 | TSh TInfo [Cases]             -- ^ table with disjunctive patters (only back end opt)
 | V Type [Term]                 -- ^ table given as course of values: @table T [c1 ; ... ; cn]@
 | S Term Term                   -- ^ selection:   @t ! p@
 | Val Term Type Int             -- ^ parameter value number: @T # i#

 | Let LocalDef Term             -- ^ local definition: @let {t : T = a} in b@

 | Alias Ident Type Term         -- ^ constant and its definition, used in inlining

 | Q  Ident Ident                -- ^ qualified constant from a package
 | QC Ident Ident                -- ^ qualified constructor from a package

 | C Term Term                   -- ^ concatenation: @s ++ t@
 | Glue Term Term                -- ^ agglutination: @s + t@

 | EPatt Patt                    -- ^ pattern (in macro definition): # p
 | EPattType Term                -- ^ pattern type: pattern T

 | ELincat Ident Term            -- ^ boxed linearization type of Ident
 | ELin Ident Term               -- ^ boxed linearization of type Ident

 | FV [Term]                     -- ^ alternatives in free variation: @variants { s ; ... }@

 | Alts (Term, [(Term, Term)])   -- ^ alternatives by prefix: @pre {t ; s\/c ; ...}@
 | Strs [Term]                   -- ^ conditioning prefix strings: @strs {s ; ...}@

  deriving (Show, Eq, Ord)

data Patt =
   PC Ident [Patt]        -- ^ constructor pattern: @C p1 ... pn@    @C@ 
 | PP Ident Ident [Patt]  -- ^ package constructor pattern: @P.C p1 ... pn@    @P.C@ 
 | PV Ident               -- ^ variable pattern: @x@
 | PW                     -- ^ wild card pattern: @_@
 | PR [(Label,Patt)]      -- ^ record pattern: @{r = p ; ...}@  -- only concrete
 | PString String         -- ^ string literal pattern: @\"foo\"@  -- only abstract
 | PInt    Integer        -- ^ integer literal pattern: @12@    -- only abstract
 | PFloat Double          -- ^ float literal pattern: @1.2@    -- only abstract
 | PT Type Patt           -- ^ type-annotated pattern

 | PVal Patt Type Int     -- ^ parameter value number: @T # i#

 | PAs Ident Patt         -- ^ as-pattern: x@p
 
 | PImplArg Patt          -- ^ placeholder for pattern for implicit argument @{p}@

 -- regular expression patterns
 | PNeg Patt              -- ^ negated pattern: -p
 | PAlt Patt Patt         -- ^ disjunctive pattern: p1 | p2
 | PSeq Patt Patt         -- ^ sequence of token parts: p + q
 | PRep Patt              -- ^ repetition of token part: p*
 | PChar                  -- ^ string of length one: ?
 | PChars [Char]          -- ^ character list: ["aeiou"]
 | PMacro Ident           -- #p
 | PM Ident Ident         -- #m.p

  deriving (Show, Eq, Ord)

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

type Labelling = (Label, Term) 
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
