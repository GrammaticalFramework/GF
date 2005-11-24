----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/08/11 14:11:46 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.7 $
--
-- Simplistic GFC format
-----------------------------------------------------------------------------

module GF.Formalism.SimpleGFC where

import Control.Monad (liftM)
import qualified GF.Canon.AbsGFC as AbsGFC
import qualified GF.Infra.Ident as Ident
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

-- | 'Decl x c ts' == x is of type (c applied to ts)
data Decl c = Decl Var c [TTerm]
	      deriving (Eq, Ord, Show)
data TTerm  = Constr :@ [TTerm]
	    | TVar Var
	      deriving (Eq, Ord, Show)

decl2cat :: Decl c -> c
decl2cat (Decl _ cat _) = cat

varsInTTerm :: TTerm -> [Var]
varsInTTerm tterm = vars tterm []
    where vars (TVar x)  = (x:)
	  vars (_ :@ ts) = foldr (.) id $ map vars ts

tterm2term :: TTerm -> Term c t
tterm2term (con :@ terms) = con :^ map tterm2term terms
-- tterm2term (TVar x) = Var x
tterm2term term = error $ "tterm2term: illegal term"

term2tterm :: Term c t -> TTerm
term2tterm (con :^ terms) = con :@ map term2tterm terms
-- term2tterm (Var x) = TVar x
term2tterm term = error $ "term2tterm: illegal term"

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
    ---- | Wildcard  -- ^ wildcard pattern variable
    ---- | Var Var   -- ^ bound pattern variable

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
Arg arg cat path +! pat = Arg arg cat (path ++! pat)
-- cannot handle tables with pattern variales or wildcards (yet):
term@(Tbl table) +! pat = maybe (term :! pat) id $ lookup pat table
term +! pat = term :! pat

{- does not work correctly:
lookupTbl term [] _ = term
lookupTbl _ ((Wildcard, term) : _) _ = term
lookupTbl _ ((Var x, term) : _) pat = subst x pat term
lookupTbl _ ((pat', term) : _) pat | pat == pat' = term
lookupTbl term (_ : tbl) pat = lookupTbl term tbl pat

subst x a (Arg n c (Path path)) = Arg n c (Path (map substP path))
    where substP (Right (Var y)) | x==y = Right a
	  substP p = p
subst x a (con :^ ts) = con :^ map (subst x a) ts
subst x a (Rec rec) = Rec [ (l, subst x a t) | (l, t) <- rec ]
subst x a (t :. l) = subst x a t +. l
subst x a (Tbl tbl) = Tbl [ (subst x a p, subst x a t) | (p, t) <- tbl ]
subst x a (t :! s) = subst x a t +! subst x a s
subst x a (Variants ts) = variants $ map (subst x a) ts
subst x a (t1 :++ t2) = subst x a t1 ?++ subst x a t2
subst x a (Var y) | x==y = a
subst x a t = t
-}

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
enumeratePatterns t = enumerateTerms Nothing t

----------------------------------------------------------------------
-- * paths of record projections and table selections

-- | Note that the list of labels/selection terms is /reversed/
newtype Path c t = Path [Either Label (Term c t)] deriving (Eq, Ord, Show)

emptyPath :: Path c t
emptyPath = Path []

-- ** calculations on paths

(++.) :: Path c t -> Label -> Path c t 
Path path ++. lbl = Path (Left lbl : path)

(++!) :: Path c t -> Term c t -> Path c t 
Path path ++! sel = Path (Right sel : path)

lintypeFollowPath :: (Print c,Print t) => Path c t -> LinType c t -> LinType c t
lintypeFollowPath (Path path0) ctype0 = follow (reverse path0) ctype0
    where follow [] ctype = ctype
	  follow (Right pat : path) (TblT _ ctype) = follow path ctype
	  follow (Left  lbl : path) (RecT rec)
	      = maybe err (follow path) $ lookup lbl rec
	      where err = error $ "lintypeFollowPath: label not in record type"
			    ++ "\nOriginal Path:  " ++ prt (Path path0)
			    ++ "\nOriginal CType: " ++ prt ctype0
                            ++ "\nCurrent Label:  " ++ prt lbl
                            ++ "\nCurrent RType:  " ++ prt (RecT rec)
                          --- by AR for debugging 23/11/2005

termFollowPath :: (Eq c, Eq t) => Path c t -> Term c t -> Term c t
termFollowPath (Path path0) = follow (reverse path0)
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
-- * pretty-printing

instance Print c => Print (Decl c) where
    prt (Decl var cat args) 
	| null args = prVar ++ prt cat
	| otherwise = "(" ++ prVar ++ prt cat ++ prtBefore " " args ++ ")"
	where prVar | var == anyVar = ""
		    | otherwise     = "?" ++ prt var ++ ":"

instance Print TTerm where
    prt (con :@ args)
	| null args = prt con
	| otherwise = "(" ++ prt con ++ prtBefore " " args ++ ")"
    prt (TVar var)  = "?" ++ prt var

instance (Print c, Print t) => Print (LinType c t) where
    prt (RecT rec) = "{" ++ prtPairList ":" "; " rec ++ "}"
    prt (TblT t1 t2) = "(" ++ prt t1 ++ " => " ++ prt t2 ++ ")"
    prt (ConT t ts) = prt t ++ "[" ++ prtSep "|" ts ++ "]"
    prt (StrT) = "Str"

instance (Print c, Print t) => Print (Term c t) where
    prt (Arg n c p) = prt c ++ prt n ++ prt p
    prt (c :^ [])  = prt c 
    prt (c :^ ts)  = "(" ++ prt c ++ prtBefore " " ts ++ ")"
    prt (Rec rec)   = "{" ++ prtPairList "=" "; " rec ++ "}"
    prt (Tbl tbl)   = "[" ++ prtPairList "=>" "; " tbl ++ "]"
    prt (Variants ts)  = "{| " ++ prtSep " | " ts ++ " |}"
    prt (t1 :++ t2) = prt t1 ++ "++" ++ prt t2
    prt (Token t)   = "'" ++ prt t ++ "'"
    prt (Empty)     = "[]"
    prt (term :. lbl) = prt term ++ "." ++ prt lbl
    prt (term :! sel) = prt term ++ "!" ++ prt sel
--    prt (Wildcard)  = "_"
--    prt (Var var) = "?" ++ prt var

instance (Print c, Print t) => Print (Path c t) where
    prt (Path path) = concatMap prtEither (reverse path)
	where prtEither (Left  lbl)  = "." ++ prt lbl
	      prtEither (Right patt) = "!" ++ prt patt
