----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/12 10:49:45 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
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

type Constr = AbsGFC.CIdent
type Var    = Ident.Ident
type Label  = AbsGFC.Label

anyVar :: Var
anyVar = Ident.wildIdent

----------------------------------------------------------------------

-- * simple GFC

type SimpleGrammar c n t = Grammar  (Decl c) n (LinType c t) (Maybe (Term c t))
type SimpleRule    c n t = Rule     (Decl c) n (LinType c t) (Maybe (Term c t))

-- ** dependent type declarations

data Decl c = Var ::: Type c
		   deriving (Eq, Ord, Show)
data Type c = c :@ [Atom]
		   deriving (Eq, Ord, Show)
data Atom   = ACon Constr
	    | AVar Var
	      deriving (Eq, Ord, Show)

decl2cat :: Decl c -> c
decl2cat (_ ::: (cat :@ _)) = cat

-- ** linearization types and terms

data LinType c t = RecT [(Label, LinType c t)]
		 | TblT (LinType c t) (LinType c t)
		 | ConT Constr [Term c t]
		 | StrT
		   deriving (Eq, Ord, Show)

isBaseType :: LinType c t -> Bool
isBaseType (ConT _ _) = True
isBaseType (StrT) = True
isBaseType _ = False

data Term c t
    = Arg Int c (Path c t)       -- ^ argument variable, the 'Path' is a path 
			         -- pointing into the term 
    | Constr :^ [Term c t]       -- ^ constructor
    | Rec [(Label, Term c t)]    -- ^ record
    | Term c t :. Label          -- ^ record projection
    | Tbl [(Term c t, Term c t)] -- ^ table of patterns\/terms
    | Term c t :! Term c t       -- ^ table selection
    | Variants [Term c t]        -- ^ variants
    | Term c t :++ Term c t      -- ^ concatenation
    | Token t   -- ^ single token
    | Empty     -- ^ empty string
    | Wildcard  -- ^ wildcard pattern variable
    | Var Var   -- ^ bound pattern variable

     -- Res CIdent        -- ^ resource identifier
     -- Int Integer       -- ^ integer
	    deriving (Eq, Ord, Show)

-- ** calculations on terms

(+.) :: Term c t -> Label -> Term c t
Variants terms +. lbl = variants $ map (+. lbl) terms 
Rec record +. lbl = maybe err id $ lookup lbl record
    where err = error $ "(+.): label not in record"
Arg arg cat path +. lbl = Arg arg cat (path ++. lbl)
term +. lbl = term :. lbl

(+!) :: (Eq c, Eq t) => Term c t -> Term c t -> Term c t
Variants terms +! pat = variants $ map (+! pat) terms 
term +! Variants pats = variants $ map (term +!) pats 
term +! arg@(Arg _ _ _) = term :! arg
Tbl table +! pat = maybe err id $ lookup pat table
    where err = error $ "(+!): pattern not in table"
Arg arg cat path +! pat = Arg arg cat (path ++! pat)
term +! pat = term :! pat

(?++) :: Term c t -> Term c t -> Term c t
Variants terms ?++ term  = variants $ map (?++ term) terms
term  ?++ Variants terms = variants $ map (term ?++) terms
Empty ?++ term  = term
term  ?++ Empty = term
term1 ?++ term2 = term1 :++ term2

variants :: [Term c t] -> Term c t
variants terms0 = case concatMap flatten terms0 of
		    [term] -> term
		    terms  -> Variants terms
    where flatten (Variants ts) = ts
	  flatten  t      = [t]

-- ** enumerations

enumerateTerms :: (Eq c, Eq t) => Maybe (Term c t) -> LinType c t -> [Term c t]
enumerateTerms arg (StrT) = maybe err return arg
    where err = error "enumeratePatterns: parameter type should not be string"
enumerateTerms arg (ConT _ terms) = terms
enumerateTerms arg (RecT rtype) 
    = liftM Rec $ mapM enumAssign rtype
    where enumAssign (lbl, ctype) = liftM ((,) lbl) $ enumerateTerms arg ctype
enumerateTerms arg (TblT ptype ctype)
    = liftM Tbl $ mapM enumCase $ enumeratePatterns ptype
    where enumCase pat = liftM ((,) pat) $ enumerateTerms (fmap (+! pat) arg) ctype

enumeratePatterns :: (Eq c, Eq t) => LinType c t -> [Term c t]
enumeratePatterns = enumerateTerms Nothing

----------------------------------------------------------------------

-- * paths of record projections and table selections

newtype Path c t = Path [Either Label (Term c t)] deriving (Eq, Ord, Show)

emptyPath :: Path c t
emptyPath = Path []

-- ** calculations on paths

(++.) :: Path c t -> Label -> Path c t 
Path path ++. lbl = Path (Left lbl : path)

(++!) :: Path c t -> Term c t -> Path c t 
Path path ++! sel = Path (Right sel : path)

lintypeFollowPath :: Path c t -> LinType c t -> LinType c t
lintypeFollowPath (Path path) = follow path 
    where follow [] ctype = ctype
	  follow (Right pat : path) (TblT _ ctype) = follow path ctype
	  follow (Left  lbl : path) (RecT rec)
	      = maybe err (follow path) $ lookup lbl rec
	      where err = error $ "lintypeFollowPath: label not in record type"

termFollowPath :: (Eq c, Eq t) => Path c t -> Term c t -> Term c t
termFollowPath (Path path) = follow (reverse path)
    where follow [] term = term
	  follow (Right pat : path) term = follow path (term +! pat)
	  follow (Left  lbl : path) term = follow path (term +. lbl)

lintype2paths :: (Eq c, Eq t) => Path c t -> LinType c t -> [Path c t]
lintype2paths path (ConT _ _)   = []
lintype2paths path (StrT)       = [ path ]
lintype2paths path (RecT rec)   = concat [ lintype2paths (path ++. lbl) ctype |
					   (lbl, ctype) <- rec ]
lintype2paths path (TblT pt vt) = concat [ lintype2paths (path ++! pat) vt |
					   pat <- enumeratePatterns pt ]

----------------------------------------------------------------------

instance Print c => Print (Decl c) where
    prt (var ::: typ) 
	| var == anyVar = prt typ
	| otherwise     = prt var ++ ":" ++ prt typ 

instance Print c => Print (Type c) where
    prt (cat :@ ats) = prt cat ++ prtList ats

instance Print Atom where
    prt (ACon con) = prt con
    prt (AVar var) = "?" ++ prt var

instance (Print c, Print t) => Print (LinType c t) where
    prt (RecT rec) = "{" ++ concat [ prt l ++ ":" ++ prt t ++ "; " | (l,t) <- rec ] ++ "}"
    prt (TblT t1 t2) = "(" ++ prt t1 ++ " => " ++ prt t2 ++ ")"
    prt (ConT t ts) = prt t ++ "[" ++ prtSep "|" ts ++ "]"
    prt (StrT) = "Str"

instance (Print c, Print t) => Print (Term c t) where
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

instance (Print c, Print t) => Print (Path c t) where
    prt (Path path) = concatMap prtEither (reverse path)
	where prtEither (Left  lbl)  = "." ++ prt lbl
	      prtEither (Right patt) = "!" ++ prt patt
