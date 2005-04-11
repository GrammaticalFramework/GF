----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/11 13:52:49 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Converting SimpleGFC grammars to MCFG grammars, nondeterministically.
-- Afterwards, the grammar has to be extended with coercion functions,
-- from the module 'GF.Conversion.SimpleToMCFG.Coercions'
--
-- the resulting grammars might be /very large/
--
-- the conversion is only equivalent if the GFC grammar has a context-free backbone.
-----------------------------------------------------------------------------


module GF.Conversion.SimpleToMCFG.Nondet 
    (convertGrammar) where

import GF.System.Tracing
import GF.Infra.Print

import Monad

import GF.Formalism.Utilities
import GF.Formalism.GCFG 
import GF.Formalism.MCFG 
import GF.Formalism.SimpleGFC 
import GF.Conversion.Types

import GF.Data.BacktrackM


------------------------------------------------------------
-- type declarations

type CnvMonad a = BacktrackM Env a

type Env    = (MCat, [MCat], LinRec, [LinType])
type LinRec = [Lin Cat MLabel Token]


----------------------------------------------------------------------
-- main conversion function

convertGrammar :: SimpleGrammar -> MGrammar 
convertGrammar rules = tracePrt "Nondet conversion: #MCFG rules" (prt . length) $
		       solutions conversion undefined
    where conversion = member rules >>= convertRule

convertRule :: SimpleRule -> CnvMonad MRule
convertRule (Rule (Abs decl decls fun) (Cnc ctype ctypes (Just term)))
    = do let cat : args = map decl2cat (decl : decls)
	 writeState (initialMCat cat, map initialMCat args, [], ctypes)
	 rterm <- simplifyTerm term
	 reduceTerm ctype emptyPath rterm
	 (newCat, newArgs, linRec, _) <- readState
	 let newLinRec = map (instantiateArgs newArgs) linRec
	     catPaths : argsPaths = map (lintype2paths emptyPath) (ctype : ctypes)
	 return $ Rule (Abs newCat newArgs fun) (Cnc catPaths argsPaths newLinRec) 
convertRule _ = failure


----------------------------------------------------------------------
-- term simplification

simplifyTerm :: Term -> CnvMonad Term
simplifyTerm (term :! sel)      
    = do sterm <- simplifyTerm term
	 ssel <- simplifyTerm sel
	 case sterm of
	   Tbl table  -> do (pat, val) <- member table
			    pat =?= ssel
			    return val
	   _ -> do sel' <- expandTerm ssel
		   return (sterm +! sel')
simplifyTerm (con :^ terms)    = liftM (con :^) $ mapM simplifyTerm terms
simplifyTerm (Rec record)      = liftM Rec      $ mapM simplifyAssign record
simplifyTerm (term :. lbl)     = liftM (+. lbl) $      simplifyTerm term
simplifyTerm (Tbl table)       = liftM Tbl      $ mapM simplifyCase table
simplifyTerm (Variants terms)  = liftM Variants $ mapM simplifyTerm terms
simplifyTerm (term1 :++ term2) = liftM2 (:++) (simplifyTerm term1) (simplifyTerm term2)
simplifyTerm term              = return term
-- error constructors:
--   (I CIdent) - from resource
--   (LI Ident) - pattern variable
--   (EInt Integer) - integer

simplifyAssign :: (Label, Term) -> CnvMonad (Label, Term)
simplifyAssign (lbl, term) = liftM ((,) lbl) $ simplifyTerm term

simplifyCase :: (Term, Term) -> CnvMonad (Term, Term)
simplifyCase (pat, term) = liftM2 (,) (simplifyTerm pat) (simplifyTerm term)


------------------------------------------------------------
-- reducing simplified terms, collecting MCF rules

reduceTerm :: LinType -> Path -> Term -> CnvMonad ()
reduceTerm ctype path (Variants terms) 
    = member terms >>= reduceTerm ctype path
reduceTerm (StrT)     path term = updateLin (path, term)
reduceTerm (ConT _ _) path term = do pat <- expandTerm term
				     updateHead (path, pat)
reduceTerm (RecT rtype) path term
    = sequence_ [ reduceTerm ctype (path ++. lbl) (term +. lbl) |
		  (lbl, ctype) <- rtype ]
reduceTerm (TblT ptype vtype) path table 
    = sequence_ [ reduceTerm vtype (path ++! pat) (table +! pat) |
		  pat <- enumeratePatterns ptype ]


------------------------------------------------------------
-- expanding a term to ground terms

expandTerm :: Term -> CnvMonad Term
expandTerm arg@(Arg nr _ path) 
    = do ctypes <- readArgCTypes
	 pat <- member $ enumeratePatterns $ lintypeFollowPath path $ ctypes !! nr
	 pat =?= arg
	 return pat
expandTerm (con :^ terms)   = liftM (con :^) $ mapM expandTerm terms
expandTerm (Rec record)     = liftM  Rec     $ mapM expandAssign record
expandTerm (Variants terms) = member terms >>= expandTerm  
expandTerm term = error $ "expandTerm: " ++ prt term

expandAssign :: (Label, Term) -> CnvMonad (Label, Term)
expandAssign (lbl, term) = liftM ((,) lbl) $ expandTerm term


------------------------------------------------------------
-- unification of patterns and selection terms

(=?=) :: Term -> Term -> CnvMonad ()
Wildcard      =?= _               = return ()
Rec precord   =?= arg@(Arg _ _ _) = sequence_ [ pat =?= (arg +. lbl) |
						(lbl, pat) <- precord ]
pat           =?= Arg nr _ path   = updateArg nr (path, pat)
(con :^ pats) =?= (con' :^ terms) = do guard (con==con' && length pats==length terms)
				       sequence_ $ zipWith (=?=) pats terms
Rec precord   =?= Rec record      = sequence_ [ maybe mzero (pat =?=) mterm |
						(lbl, pat) <- precord,
						let mterm = lookup lbl record ]
pat =?= term = error $ "(=?=): " ++ prt pat ++ " =?= " ++ prt term


------------------------------------------------------------
-- updating the MCF rule

readArgCTypes :: CnvMonad [LinType]
readArgCTypes = do (_, _, _, env) <- readState
		   return env

updateArg :: Int -> Constraint -> CnvMonad ()
updateArg arg cn
    = do (head, args, lins, env) <- readState 
	 args' <- updateNth (addToMCat cn) arg args
	 writeState (head, args', lins, env)

updateHead :: Constraint -> CnvMonad ()
updateHead cn
    = do (head, args, lins, env) <- readState
	 head' <- addToMCat cn head
	 writeState (head', args, lins, env)

updateLin :: Constraint -> CnvMonad ()
updateLin (path, term) 
    = do let newLins = term2lins term
	 (head, args, lins, env) <- readState
	 let lins' = lins ++ map (Lin path) newLins
	 writeState (head, args, lins', env)

term2lins :: Term -> [[Symbol (Cat, Path, Int) Token]]
term2lins (Arg nr cat path) = return [Cat (cat, path, nr)]
term2lins (Token str)       = return [Tok str]
term2lins (t1 :++ t2)       = liftM2 (++) (term2lins t1) (term2lins t2)
term2lins (Empty)           = return []
term2lins (Variants terms)  = terms >>= term2lins
term2lins term = error $ "term2lins: " ++ show term

addToMCat :: Constraint -> MCat -> CnvMonad MCat
addToMCat cn (MCat cat cns) = liftM (MCat cat) $ addConstraint cn cns

addConstraint :: Constraint -> [Constraint] -> CnvMonad [Constraint]
addConstraint cn0 (cn : cns)
    | fst cn0 >  fst cn = liftM (cn:) (addConstraint cn0 cns)
    | fst cn0 == fst cn = guard (snd cn0 == snd cn) >>
			  return (cn : cns)
addConstraint cn0 cns   = return (cn0 : cns)


----------------------------------------------------------------------
-- utilities 

updateNth :: Monad m => (a -> m a) -> Int -> [a] -> m [a]
updateNth update 0 (a : as) = liftM (:as) (update a)
updateNth update n (a : as) = liftM (a:)  (updateNth update (n-1) as)


