module Grammar where

import Str
import Ident
import Option ---
import Modules

import Operations

-- AR 23/1/2000 -- 30/5/2001 -- 4/5/2003

-- grammar as presented to the compiler

type SourceGrammar = MGrammar Ident Option Info

type SourceModInfo = ModInfo Ident Option Info

type SourceModule = (Ident, SourceModInfo)

type SourceAbs = Module Ident Option Info
type SourceRes = Module Ident Option Info
type SourceCnc = Module Ident Option Info

-- judgements in abstract syntax

data Info =                  
   AbsCat   (Perh Context) (Perh [Term])   -- constructors; must be Id or QId
 | AbsFun   (Perh Type) (Perh Term)        -- Yes f = canonical
 | AbsTrans Term

-- judgements in resource
 | ResParam (Perh [Param])
 | ResValue (Perh Type) -- to mark parameter constructors for lookup
 | ResOper  (Perh Type) (Perh Term)

-- judgements in concrete syntax
 | CncCat  (Perh Type) (Perh Term) MPr -- lindef ini'zed, 
 | CncFun  (Maybe (Ident,(Context,Type))) (Perh Term) MPr  -- type info added at TC

-- indirection to module Ident; the Bool says if canonical
 | AnyInd Bool Ident 
  deriving (Read, Show)

type Perh a = Perhaps a Ident -- to express indirection to other module

type MPr = Perhaps Term Ident -- printname

type Type = Term
type Cat  = QIdent
type Fun  = QIdent

type QIdent = (Ident,Ident)

data Term =
   Vr Ident             -- variable
 | Cn Ident             -- constant
 | Con Ident            -- constructor
 | EData                -- to mark in definition that a fun is a constructor
 | Sort String          -- basic type
 | EInt Int             -- integer literal
 | K String             -- string literal or token: "foo"
 | Empty                -- the empty string []

 | App Term Term        -- application: f a
 | Abs Ident Term       -- abstraction: \x -> b
 | Meta MetaSymb        -- metavariable: ?i (only parsable: ? = ?0)
 | Prod Ident Term Term -- function type: (x : A) -> B
 | Eqs [Equation]       -- abstraction by cases: fn {x y -> b ; z u -> c}
                        -- only used in internal representation
 | Typed Term Term      -- type-annotated term

-- below this only for concrete syntax
 | RecType [Labelling]  -- record type: { p : A ; ...}
 | R [Assign]           -- record:      { p = a ; ...}
 | P Term Label         -- projection:  r.p
 | ExtR Term Term       -- extension:   R ** {x : A} (both types and terms)
 
 | Table Term Term      -- table type:  P => A
 | T TInfo [Case]       -- table:       table {p => c ; ...}
 | S Term Term          -- selection:   t ! p

 | Let LocalDef Term    -- local definition: let {t : T = a} in b

 | Alias Ident Type Term  -- constant and its definition, used in inlining

 | Q  Ident Ident        -- qualified constant from a package
 | QC Ident Ident        -- qualified constructor from a package

 | C Term Term    -- concatenation: s ++ t
 | Glue Term Term -- agglutination: s + t

 | FV [Term]      -- alternatives in free variation: variants { s ; ... }

 | Alts (Term, [(Term, Term)]) -- alternatives by prefix: pre {t ; s/c ; ...}
 | Strs [Term]                 -- conditioning prefix strings: strs {s ; ...} 

 --- these three are obsolete
 | LiT Ident      -- linearization type
 | Ready Str      -- result of compiling; not to be parsed ...
 | Computed Term  -- result of computing: not to be reopened nor parsed

  deriving (Read, Show, Eq, Ord)

data Patt =
   PC Ident [Patt]        -- constructor pattern: C p1 ... pn    C 
 | PP Ident Ident [Patt]  -- package constructor pattern: P.C p1 ... pn    P.C 
 | PV Ident               -- variable pattern: x
 | PW                     -- wild card pattern: _
 | PR [(Label,Patt)]      -- record pattern: {r = p ; ...}  -- only concrete
 | PString String         -- string literal pattern: "foo"  -- only abstract
 | PInt    Int            -- integer literal pattern: 12    -- only abstract
 | PT Type Patt           -- type-annotated pattern
  deriving (Read, Show, Eq, Ord)

-- to guide computation and type checking of tables
data TInfo = 
   TRaw         -- received from parser; can be anything
 | TTyped Type  -- type annontated, but can be anything
 | TComp Type   -- expanded
 | TWild Type   -- just one wild card pattern, no need to expand 
  deriving (Read, Show, Eq, Ord)

data Label = 
    LIdent String
  | LVar Int
   deriving (Read, Show, Eq, Ord) -- record label

newtype MetaSymb = MetaSymb Int    deriving (Read, Show, Eq, Ord)

type Decl     = (Ident,Term)  -- (x:A)  (_:A)  A
type Context  = [Decl]        -- (x:A)(y:B)   (x,y:A)   (_,_:A)
type Equation = ([Patt],Term) 

type Labelling = (Label, Term) 
type Assign = (Label, (Maybe Type, Term)) 
type Case = (Patt, Term) 
type LocalDef = (Ident, (Maybe Type, Term))

type Param = (Ident, Context) 
type Altern = (Term, [(Term, Term)])

type Substitution =  [(Ident, Term)]

-- branches à la Alfa
newtype Branch = Branch (Con,([Ident],Term)) deriving (Eq, Ord,Show,Read)
type Con = Ident ---

varLabel = LVar

wildPatt :: Patt
wildPatt = PV wildIdent

type Trm = Term
