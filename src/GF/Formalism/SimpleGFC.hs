----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/11 13:52:50 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Simplistic GFC format
-----------------------------------------------------------------------------

module GF.Formalism.SimpleGFC where

import Monad (liftM)
import qualified AbsGFC 
import qualified Ident 
import GF.Formalism.GCFG
import GF.Infra.Print

----------------------------------------------------------------------

-- * basic (leaf) types

type Name   = Ident.Ident
type Cat    = Ident.Ident
type Constr = AbsGFC.CIdent
type Var    = Ident.Ident
type Token  = String
type Label  = AbsGFC.Label

-- ** type coercions etc

constr2name :: Constr -> Name
constr2name (AbsGFC.CIQ _ name) = name

anyVar :: Var
anyVar = Ident.wildIdent

----------------------------------------------------------------------

-- * simple GFC

type SimpleGrammar = Grammar Decl Name LinType (Maybe Term)
type SimpleRule    = Rule    Decl Name LinType (Maybe Term)

-- ** dependent type declarations

data Decl = Var ::: Type
	    deriving (Eq, Ord, Show)
data Type = Cat :@ [Atom]
	    deriving (Eq, Ord, Show)
data Atom = ACon Constr
	  | AVar Var
	    deriving (Eq, Ord, Show)

decl2cat :: Decl -> Cat
decl2cat (_ ::: (cat :@ _)) = cat

-- ** linearization types and terms

data LinType = RecT [(Label, LinType)]
	     | TblT LinType LinType
	     | ConT Constr [Term]
	     | StrT
	       deriving (Eq, Ord, Show)

isBaseType :: LinType -> Bool
isBaseType (ConT _ _) = True
isBaseType (StrT) = True
isBaseType _ = False

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

-- ** calculations on terms

(+.) :: Term -> Label -> Term
Variants terms +. lbl = variants $ map (+. lbl) terms 
Rec record +. lbl = maybe err id $ lookup lbl record
    where err = error $ "(+.), label not in record: " ++ show (Rec record) ++ " +. " ++ show lbl
Arg arg cat path +. lbl = Arg arg cat (path ++. lbl)
term +. lbl = term :. lbl

(+!) :: Term -> Term -> Term
Variants terms +! pat = variants $ map (+! pat) terms 
term +! Variants pats = variants $ map (term +!) pats 
term +! arg@(Arg _ _ _) = term :! arg
Tbl table +! pat = maybe err id $ lookup pat table
    where err = error $ "(+!), pattern not in table: " ++ show (Tbl table) ++ " +! " ++ show pat
Arg arg cat path +! pat = Arg arg cat (path ++! pat)
term +! pat = term :! pat

(?++) :: Term -> Term -> Term
Variants terms ?++ term  = variants $ map (?++ term) terms
term  ?++ Variants terms = variants $ map (term ?++) terms
Empty ?++ term  = term
term  ?++ Empty = term
term1 ?++ term2 = term1 :++ term2

variants :: [Term] -> Term
variants terms0 = case concatMap flatten terms0 of
		    [term] -> term
		    terms  -> Variants terms
    where flatten (Variants ts) = ts
	  flatten  t      = [t]

-- ** enumerations

enumerateTerms :: Maybe Term -> LinType -> [Term]
enumerateTerms arg (StrT) = maybe err return arg
    where err = error "enumeratePatterns: parameter type should not be string"
enumerateTerms arg (ConT _ terms) = terms
enumerateTerms arg (RecT rtype) 
    = liftM Rec $ mapM enumAssign rtype
    where enumAssign (lbl, ctype) = liftM ((,) lbl) $ enumerateTerms arg ctype
enumerateTerms arg (TblT ptype ctype)
    = liftM Tbl $ mapM enumCase $ enumeratePatterns ptype
    where enumCase pat = liftM ((,) pat) $ enumerateTerms (fmap (+! pat) arg) ctype

enumeratePatterns :: LinType -> [Term]
enumeratePatterns = enumerateTerms Nothing

----------------------------------------------------------------------

-- * paths of record projections and table selections

newtype Path = Path [Either Label Term] deriving (Eq, Ord, Show)

emptyPath :: Path
emptyPath = Path []

-- ** calculations on paths

(++.) :: Path -> Label -> Path 
Path path ++. lbl = Path (Left lbl : path)

(++!) :: Path -> Term -> Path 
Path path ++! sel = Path (Right sel : path)

lintypeFollowPath :: Path -> LinType -> LinType
lintypeFollowPath (Path path) = follow path 
    where follow [] ctype = ctype
	  follow (Right pat : path) (TblT _ ctype) = follow path ctype
	  follow (Left  lbl : path) (RecT rec)
	      = maybe err (follow path) $ lookup lbl rec
	      where err = error $ "follow: " ++ prt rec ++ " . " ++ prt lbl

termFollowPath :: Path -> Term -> Term
termFollowPath (Path path) = follow (reverse path)
    where follow [] term = term
	  follow (Right pat : path) term = follow path (term +! pat)
	  follow (Left  lbl : path) term = follow path (term +. lbl)

lintype2paths :: Path -> LinType -> [Path]
lintype2paths path (ConT _ _)   = []
lintype2paths path (StrT)       = [ path ]
lintype2paths path (RecT rec)   = concat [ lintype2paths (path ++. lbl) ctype |
					   (lbl, ctype) <- rec ]
lintype2paths path (TblT pt vt) = concat [ lintype2paths (path ++! pat) vt |
					   pat <- enumeratePatterns pt ]

----------------------------------------------------------------------

instance Print Decl where
    prt (var ::: typ) 
	| var == anyVar = prt typ
	| otherwise     = prt var ++ ":" ++ prt typ 

instance Print Type where
    prt (cat :@ ats) = prt cat ++ prtList ats

instance Print Atom where
    prt (ACon con) = prt con
    prt (AVar var) = "?" ++ prt var

instance Print LinType where
    prt (RecT rec) = "{" ++ concat [ prt l ++ ":" ++ prt t ++ "; " | (l,t) <- rec ] ++ "}"
    prt (TblT t1 t2) = "(" ++ prt t1 ++ " => " ++ prt t2 ++ ")"
    prt (ConT t ts) = prt t ++ "[" ++ prtSep "|" ts ++ "]"
    prt (StrT) = "Str"

instance Print Term where
    prt (Arg n c p) = prt c ++ "@" ++ prt n ++ "(" ++ prt p ++ ")"
    prt (c :^ [])  = prt c 
    prt (c :^ ts)  = prt c ++ prtList ts
    prt (Rec rec)   = "{" ++ concat [ prt l ++ "=" ++ prt t ++ "; " | (l,t) <- rec ] ++ "}"
    prt (Tbl tbl)   = "[" ++ concat [ prt p ++ "=>" ++ prt t ++ "; " | (p,t) <- tbl ] ++ "]"
    prt (Variants ts)  = "{| " ++ prtSep " | " ts ++ " |}"
    prt (t1 :++ t2) = prt t1 ++ "++" ++ prt t2
    prt (Token t)   = prt t
    prt (Empty)     = "[]"
    prt (Wildcard)  = "_"
    prt (term :. lbl) = prt term ++ "." ++ prt lbl
    prt (term :! sel) = prt term ++ "!" ++ prt sel
    prt (Var var) = "?" ++ prt var

instance Print Path where
    prt (Path path) = concatMap prtEither (reverse path)
	where prtEither (Left  lbl)  = "." ++ prt lbl
	      prtEither (Right patt) = "!" ++ prt patt
