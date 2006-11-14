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
		SourceModInfo,
		SourceModule,
		SourceAbs,
		SourceRes,
		SourceCnc,
		Info(..),
                PValues,
		Perh,
		MPr,
		Type,
		Cat,
		Fun,
		QIdent,
		Term(..),
		Patt(..),
		TInfo(..),
		Label(..),
		MetaSymb(..),
		Decl,
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
		Branch(..),
		Con,
		Trm,
		wildPatt,
		varLabel
	       ) where

import GF.Data.Str
import GF.Infra.Ident
import GF.Infra.Option ---
import GF.Infra.Modules

import GF.Data.Operations

-- | grammar as presented to the compiler
type SourceGrammar = MGrammar Ident Option Info

type SourceModInfo = ModInfo Ident Option Info

type SourceModule = (Ident, SourceModInfo)

type SourceAbs = Module Ident Option Info
type SourceRes = Module Ident Option Info
type SourceCnc = Module Ident Option Info

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
   AbsCat   (Perh Context) (Perh [Term])   -- ^ (/ABS/) constructors; must be 'Id' or 'QId'
 | AbsFun   (Perh Type) (Perh Term)        -- ^ (/ABS/) 'Yes f' = canonical
 | AbsTrans Term                           -- ^ (/ABS/)

-- judgements in resource
 | ResParam (Perh ([Param],Maybe PValues)) -- ^ (/RES/)
 | ResValue (Perh (Type,Maybe Int))        -- ^ (/RES/) to mark parameter constructors for lookup
 | ResOper  (Perh Type) (Perh Term)        -- ^ (/RES/)

-- judgements in concrete syntax
 | CncCat  (Perh Type) (Perh Term) MPr     -- ^ (/CNC/) lindef ini'zed, 
 | CncFun  (Maybe (Ident,(Context,Type))) (Perh Term) MPr  -- (/CNC/) type info added at 'TC'

-- indirection to module Ident
 | AnyInd Bool Ident                       -- ^ (/INDIR/) the 'Bool' says if canonical
  deriving (Read, Show)

-- | to express indirection to other module
type Perh a = Perhaps a Ident

-- | printname
type MPr = Perhaps Term Ident

type Type = Term
type Cat  = QIdent
type Fun  = QIdent

type QIdent = (Ident,Ident)

data Term =
   Vr Ident             -- ^ variable
 | Cn Ident             -- ^ constant
 | Con Ident            -- ^ constructor
 | EData                -- ^ to mark in definition that a fun is a constructor
 | Sort String          -- ^ basic type
 | EInt Integer         -- ^ integer literal
 | EFloat Double        -- ^ floating point literal
 | K String             -- ^ string literal or token: @\"foo\"@
 | Empty                -- ^ the empty string @[]@

 | App Term Term        -- ^ application: @f a@
 | Abs Ident Term       -- ^ abstraction: @\x -> b@
 | Meta MetaSymb        -- ^ metavariable: @?i@ (only parsable: ? = ?0)
 | Prod Ident Term Term -- ^ function type: @(x : A) -> B@
 | Eqs [Equation]       -- ^ abstraction by cases: @fn {x y -> b ; z u -> c}@
                        -- only used in internal representation
 | Typed Term Term      -- ^ type-annotated term
--
-- /below this, the constructors are only for concrete syntax/
 | Example Term String  -- ^ example-based term: @in M.C "foo"
 | RecType [Labelling]  -- ^ record type: @{ p : A ; ...}@
 | R [Assign]           -- ^ record:      @{ p = a ; ...}@
 | P Term Label         -- ^ projection:  @r.p@
 | ExtR Term Term       -- ^ extension:   @R ** {x : A}@ (both types and terms)
 
 | Table Term Term      -- ^ table type:  @P => A@
 | T TInfo [Case]       -- ^ table:       @table {p => c ; ...}@
 | TSh TInfo [Cases]    -- ^ table with discjunctive patters (only back end opt)
 | V Type [Term]        -- ^ table given as course of values: @table T [c1 ; ... ; cn]@
 | S Term Term          -- ^ selection:   @t ! p@
 | Val Type Int         -- ^ parameter value number: @T # i#

 | Let LocalDef Term    -- ^ local definition: @let {t : T = a} in b@

 | Alias Ident Type Term  -- ^ constant and its definition, used in inlining

 | Q  Ident Ident        -- ^ qualified constant from a package
 | QC Ident Ident        -- ^ qualified constructor from a package

 | C Term Term    -- ^ concatenation: @s ++ t@
 | Glue Term Term -- ^ agglutination: @s + t@

 | FV [Term]      -- ^ alternatives in free variation: @variants { s ; ... }@

 | Alts (Term, [(Term, Term)]) -- ^ alternatives by prefix: @pre {t ; s\/c ; ...}@
 | Strs [Term]                 -- ^ conditioning prefix strings: @strs {s ; ...}@
-- 
-- /below this, the last three constructors are obsolete/
 | LiT Ident      -- ^ linearization type
 | Ready Str      -- ^ result of compiling; not to be parsed ...
 | Computed Term  -- ^ result of computing: not to be reopened nor parsed

  deriving (Read, Show, Eq, Ord)

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

 | PVal Type Int          -- ^ parameter value number: @T # i#

 | PAs Ident Patt         -- ^ as-pattern: x@p

 -- regular expression patterns
 | PNeg Patt              -- ^ negated pattern: -p
 | PAlt Patt Patt         -- ^ disjunctive pattern: p1 | p2
 | PSeq Patt Patt         -- ^ sequence of token parts: p + q
 | PRep Patt              -- ^ repetition of token part: p*

  deriving (Read, Show, Eq, Ord)

-- | to guide computation and type checking of tables
data TInfo = 
   TRaw         -- ^ received from parser; can be anything
 | TTyped Type  -- ^ type annontated, but can be anything
 | TComp Type   -- ^ expanded
 | TWild Type   -- ^ just one wild card pattern, no need to expand 
  deriving (Read, Show, Eq, Ord)

-- | record label
data Label = 
    LIdent String
  | LVar Int
   deriving (Read, Show, Eq, Ord)

newtype MetaSymb = MetaSymb Int    deriving (Read, Show, Eq, Ord)

type Decl     = (Ident,Term)  -- (x:A)  (_:A)  A
type Context  = [Decl]        -- (x:A)(y:B)   (x,y:A)   (_,_:A)
type Equation = ([Patt],Term) 

type Labelling = (Label, Term) 
type Assign = (Label, (Maybe Type, Term)) 
type Case = (Patt, Term) 
type Cases = ([Patt], Term) 
type LocalDef = (Ident, (Maybe Type, Term))

type Param = (Ident, Context) 
type Altern = (Term, [(Term, Term)])

type Substitution =  [(Ident, Term)]

-- | branches à la Alfa
newtype Branch = Branch (Con,([Ident],Term)) deriving (Eq, Ord,Show,Read)
type Con = Ident ---

varLabel :: Int -> Label
varLabel = LVar

wildPatt :: Patt
wildPatt = PV wildIdent

type Trm = Term
