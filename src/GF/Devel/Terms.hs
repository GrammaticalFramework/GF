module GF.Devel.Terms where

import GF.Data.Str
import GF.Infra.Ident
import GF.Infra.Option ---
import GF.Infra.Modules

import GF.Data.Operations

type Type = Term
type Cat  = QIdent
type Fun  = QIdent

type QIdent = (Ident,Ident)

data Term =
   Vr Ident             -- ^ variable
 | Con Ident            -- ^ constructor
 | EData                -- ^ to mark in definition that a fun is a constructor
 | Sort String          -- ^ predefined type
 | EInt Integer         -- ^ integer literal
 | EFloat Double        -- ^ floating point literal
 | K String             -- ^ string literal or token: @\"foo\"@
 | Empty                -- ^ the empty string @[]@

 | App Term Term        -- ^ application: @f a@
 | Abs Ident Term       -- ^ abstraction: @\x -> b@
 | Meta MetaSymb        -- ^ metavariable: @?i@ (only parsable: ? = ?0)
 | Prod Ident Term Term -- ^ function type: @(x : A) -> B@
 | Eqs [Equation]       -- ^ abstraction by cases: @fn {x y -> b ; z u -> c}@
                        --   only used in internal representation
 | Typed Term Term      -- ^ type-annotated term
--
-- /below this, the constructors are only for concrete syntax/
 | Example Term String  -- ^ example-based term: @in M.C "foo"
 | RecType [Labelling]  -- ^ record type: @{ p : A ; ...}@
 | R [Assign]           -- ^ record:      @{ p = a ; ...}@
 | P Term Label         -- ^ projection:  @r.p@
 | PI Term Label Int    -- ^ index-annotated projection
 | ExtR Term Term       -- ^ extension:   @R ** {x : A}@ (both types and terms)
 
 | Table Term Term      -- ^ table type:  @P => A@
 | T TInfo [Case]       -- ^ table:       @table {p => c ; ...}@
 | V Type [Term]        -- ^ course of values: @table T [c1 ; ... ; cn]@
 | S Term Term          -- ^ selection:   @t ! p@
 | Val Type Int         -- ^ parameter value number: @T # i#

 | Let LocalDef Term    -- ^ local definition: @let {t : T = a} in b@

 | Q  Ident Ident       -- ^ qualified constant from a module
 | QC Ident Ident       -- ^ qualified constructor from a module

 | C Term Term          -- ^ concatenation: @s ++ t@
 | Glue Term Term       -- ^ agglutination: @s + t@

 | FV [Term]            -- ^ free variation: @variants { s ; ... }@

 | Alts (Term, [(Term, Term)]) -- ^ prefix-dependent: @pre {t ; s\/c ; ...}@

  deriving (Read, Show, Eq, Ord)

data Patt =
   PC Ident [Patt]        -- ^ constructor pattern: @C p1 ... pn@    @C@ 
 | PP Ident Ident [Patt]  -- ^ qualified constr patt: @P.C p1 ... pn@    @P.C@ 
 | PV Ident               -- ^ variable pattern: @x@
 | PW                     -- ^ wild card pattern: @_@
 | PR [(Label,Patt)]      -- ^ record pattern: @{r = p ; ...}@
 | PString String         -- ^ string literal pattern: @\"foo\"@
 | PInt    Integer        -- ^ integer literal pattern: @12@
 | PFloat Double          -- ^ float literal pattern: @1.2@
 | PT Type Patt           -- ^ type-annotated pattern
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
 | TTyped Type  -- ^ type annotated, but can be anything
 | TComp Type   -- ^ expanded
 | TWild Type   -- ^ just one wild card pattern, no need to expand 
  deriving (Read, Show, Eq, Ord)

-- | record label
data Label = 
    LIdent String
  | LVar Int
   deriving (Read, Show, Eq, Ord)

type MetaSymb = Int

type Decl         = (Ident,Term)  -- (x:A)  (_:A)  A
type Context      = [Decl]        -- (x:A)(y:B)   (x,y:A)   (_,_:A)
type Substitution = [(Ident, Term)]
type Equation     = ([Patt],Term) 

type Labelling = (Label, Term) 
type Assign    = (Label, (Maybe Type, Term)) 
type Case      = (Patt, Term) 
type LocalDef  = (Ident, (Maybe Type, Term))


-- | branches à la Alfa
newtype Branch = Branch (Con,([Ident],Term)) deriving (Eq, Ord,Show,Read)
type Con = Ident ---

varLabel :: Int -> Label
varLabel = LVar

wildPatt :: Patt
wildPatt = PW

type Trm = Term
