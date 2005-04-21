----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:52 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- Simplistic GFC format
-----------------------------------------------------------------------------

module GF.OldParsing.SimpleGFC where

import qualified GF.Canon.AbsGFC as AbsGFC
import qualified GF.Infra.Ident as Ident

import GF.Printing.PrintParser
import GF.Printing.PrintSimplifiedTerm

import GF.Data.Operations (ifNull)

----------------------------------------------------------------------

type Name   = Ident.Ident
type Cat    = Ident.Ident
type Constr = AbsGFC.CIdent
type Var    = Ident.Ident
type Token  = AbsGFC.Tokn
type Label  = AbsGFC.Label

constr2name :: Constr -> Name
constr2name (AbsGFC.CIQ _ name) = name

----------------------------------------------------------------------

type Grammar  = [Rule]
data Rule     = Rule Name Typing (Maybe (Term, CType))
		deriving (Eq, Ord, Show)

type Typing = (Type, [Decl])

data Decl = Var ::: Type
	    deriving (Eq, Ord, Show)
data Type = Cat :@ [Atom]
	    deriving (Eq, Ord, Show)
data Atom = ACon Constr
	  | AVar Var
	    deriving (Eq, Ord, Show)

data CType = RecT [(Label, CType)]
	   | TblT CType CType
	   | ConT Constr [Term]
	   | StrT
	     deriving (Eq, Ord, Show)


data Term = Arg Int Cat Path     -- ^ argument variable, the 'Path' is a path 
				 -- pointing into the term 
	  | Constr :^ [Term]     -- ^ constructor
	  | Rec [(Label, Term)]  -- ^ record
	  | Term :. Label        -- ^ record projection
	  | Tbl [(Term, Term)]   -- ^ table of patterns\/terms
	  | Term :! Term         -- ^ table selection
	  | Variants [Term]      -- ^ variants
	  | Term :++ Term        -- ^ concatenation
	  | Token Token          -- ^ single token
	  | Empty                -- ^ empty string
	  | Wildcard             -- ^ wildcard pattern variable
	  | Var Var              -- ^ bound pattern variable

	    -- Res CIdent        -- resource identifier
	    -- Int Integer       -- integer
	    deriving (Eq, Ord, Show)


----------------------------------------------------------------------

(+.) :: Term -> Label -> Term
Variants terms +. lbl = Variants $ map (+. lbl) terms 
Rec record +. lbl = maybe err id $ lookup lbl record
    where err = error $ "(+.), label not in record: " ++ show (Rec record) ++ " +. " ++ show lbl
Arg arg cat path +. lbl = Arg arg cat (path ++. lbl)
term +. lbl = term :. lbl

(+!) :: Term -> Term -> Term
Variants terms +! pat = Variants $ map (+! pat) terms 
term +! Variants pats = Variants $ map (term +!) pats 
Tbl table +! pat = maybe err id $ lookup pat table
    where err = error $ "(+!), pattern not in table: " ++ show (Tbl table) ++ " +! " ++ show pat
Arg arg cat path +! pat = Arg arg cat (path ++! pat)
term +! pat = term :! pat

(?++) :: Term -> Term -> Term
Variants terms ?++ term  = Variants $ map (?++ term) terms
term  ?++ Variants terms = Variants $ map (term ?++) terms
Empty ?++ term  = term
term  ?++ Empty = term
term1 ?++ term2 = term1 :++ term2

----------------------------------------------------------------------

newtype Path = Path [Either Label Term] deriving (Eq, Ord, Show)

emptyPath :: Path
emptyPath = Path []

(++.) :: Path -> Label -> Path 
Path path ++. lbl = Path (Left lbl : path)

(++!) :: Path -> Term -> Path 
Path path ++! sel = Path (Right sel : path)

----------------------------------------------------------------------

instance Print Rule where
    prt (Rule name (typ, args) term) 
	= prt name ++ " : " ++ 
	  prtAfter " " args ++ 
	  (if null args then "" else "-> ") ++
	  prt typ ++ 
	  maybe "" (\(t,c) -> " := " ++ prt t ++ " : " ++ prt c) term ++
          "\n"
    prtList = concatMap prt

instance Print Decl where
    prt (var ::: typ) = "(" ++ prt var ++ ":" ++ prt typ ++ ")"

instance Print Type where
    prt (cat :@ ats) = prt cat ++ prtList ats

instance Print Atom where
    prt (ACon con) = prt con
    prt (AVar var) = "?" ++ prt var

instance Print CType where
    prt (RecT rec) = "{" ++ concat [ prt l ++ ":" ++ prt t ++ "; " | (l,t) <- rec ] ++ "}"
    prt (TblT t1 t2) = "(" ++ prt t1 ++ " => " ++ prt t2 ++ ")"
    prt (ConT t ts) = prt t ++ "(|" ++ prtSep "|" ts ++ "|)"
    prt (StrT) = "Str"

instance Print Term where
    prt (Arg n c p) = prt c ++ "@" ++ prt n ++ prt p
    prt (c :^ [])  = prt c 
    prt (c :^ ts)  = prt c ++ prtList ts
    prt (Rec rec)   = "{" ++ concat [ prt l ++ "=" ++ prt t ++ "; " | (l,t) <- rec ] ++ "}"
    prt (Tbl tbl)   = "[" ++ concat [ prt p ++ "=>" ++ prt t ++ "; " | (p,t) <- tbl ] ++ "}"
    prt (Variants ts)  = "{| " ++ prtSep " | " ts ++ " |}"
    prt (t1 :++ t2) = prt t1 ++ "++" ++ prt t2
    prt (Token t)   = prt t
    prt (Empty)     = "[]"
    prt (Wildcard)  = "_"
    prt (term :. lbl) = prt term ++ "." ++ prt lbl
    prt (term :! sel) = prt term ++ " ! " ++ prt sel
    prt (Var var) = "?" ++ prt var

instance Print Path where
    prt (Path path) = concatMap prtEither (reverse path)
	where prtEither (Left  lbl)  = "." ++ prt lbl
	      prtEither (Right patt) = "!" ++ prt patt
