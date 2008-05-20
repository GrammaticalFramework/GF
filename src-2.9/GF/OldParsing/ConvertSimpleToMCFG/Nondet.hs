----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:58 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- Converting SimpleGFC grammars to MCFG grammars, nondeterministically.
--
-- the resulting grammars might be /very large/
--
-- the conversion is only equivalent if the GFC grammar has a context-free backbone.
-----------------------------------------------------------------------------


module GF.OldParsing.ConvertSimpleToMCFG.Nondet (convertGrammar) where

import GF.System.Tracing
import GF.Printing.PrintParser
import GF.Printing.PrintSimplifiedTerm
-- import PrintGFC
-- import qualified PrGrammar as PG

import Control.Monad
-- import Ident (Ident(..))
import qualified GF.Canon.AbsGFC as AbsGFC
-- import GFC
import GF.Canon.Look
import GF.Data.Operations
-- import qualified Modules as M
import GF.Canon.CMacros (defLinType)
-- import MkGFC (grammar2canon)
import GF.OldParsing.Utilities
-- import GF.OldParsing.GrammarTypes 
import GF.Data.SortedList
import qualified GF.OldParsing.MCFGrammar as MCF (Grammar, Rule(..), Lin(..)) 
import GF.OldParsing.SimpleGFC 
-- import Maybe (listToMaybe)
import Data.List (groupBy) -- , transpose)

import GF.Data.BacktrackM

----------------------------------------------------------------------

--convertGrammar :: Grammar -> MCF.Grammar
convertGrammar rules = tracePrt "#mcf-rules total" (prt . length) $
		       solutions conversion rules undefined
    where conversion = member rules >>= convertRule

--convertRule :: Rule -> CnvMonad MCF.Rule
convertRule (Rule fun (cat :@ _, decls) (Just (term, ctype)))
    = do let args = [ arg | _ ::: (arg :@ _) <- decls ]
	 writeState (initialMCat cat, map initialMCat args, [])
	 convertTerm cat term
	 (newCat, newArgs, linRec) <- readState
	 let newTerm = map (instLin newArgs) linRec
	 return (MCF.Rule newCat newArgs newTerm fun)	 
convertRule _ = failure

instLin newArgs (MCF.Lin lbl lin) = MCF.Lin lbl (map instSym lin)
    where instSym = mapSymbol instCat id
	  instCat (_, lbl, arg) = (newArgs !! arg, lbl, arg)

--convertTerm :: Cat -> Term -> CnvMonad ()
convertTerm cat term = do rterm <- simplifyTerm term
			  env <- readEnv
			  let ctype = lookupCType env cat
			  reduce ctype rterm emptyPath

------------------------------------------------------------

{-
type CnvMonad a = BacktrackM Grammar CMRule a

type CMRule = (MCFCat, [MCFCat], LinRec)
type LinRec = [Lin Cat Path Tokn]
-}

--initialMCat :: Cat -> MCFCat
initialMCat cat = (cat, []) --MCFCat cat []

----------------------------------------------------------------------

--simplifyTerm :: Term -> CnvMonad STerm
simplifyTerm (con :^ terms) = liftM (con :^) $ mapM simplifyTerm terms
simplifyTerm (Rec record)   = liftM Rec      $ mapM simplifyAssign record
simplifyTerm (term :. lbl)  = liftM (+. lbl) $      simplifyTerm term
simplifyTerm (Tbl table)    = Tbl $ mapM simplifyCase table
simplifyTerm (term :! sel)      
    = do sterm <- simplifyTerm term
	 ssel <- simplifyTerm sel
	 case sterm of
	   Tbl table  -> do (pat, val) <- member table
			    pat =?= ssel
			    return val
	   _ -> do sel' <- expandTerm ssel
		   return (sterm +! sel')
simplifyTerm (Variants terms)  = liftM Variants $ mapM simplifyTerm terms
simplifyTerm (term1 :++ term2) = liftM2 (:++) (simplifyTerm term1) (simplifyTerm term2)
simplifyTerm term              = return term
-- error constructors:
--   (I CIdent) - from resource
--   (LI Ident) - pattern variable
--   (EInt Integer) - integer

--simplifyAssign :: Assign -> CnvMonad (Label, STerm)
simplifyAssign (lbl, term) = liftM ((,) lbl) $ simplifyTerm term

--simplifyCase :: Case -> [CnvMonad (STerm, STerm)]
simplifyCase (pat, term) = liftM2 (,) (simplifyTerm pat) (simplifyTerm term)


------------------------------------------------------------
-- reducing simplified terms, collecting mcf rules

--reduce :: CType -> STerm -> Path -> CnvMonad ()
reduce StrT   term path = updateLin (path, term)
reduce (ConT _) term path
    = do pat <- expandTerm term
	 updateHead (path, pat)
reduce ctype (Variants terms) path 
    = do term <- member terms
	 reduce ctype term path
reduce (RecT rtype) term path
    = sequence_ [ reduce ctype (term +. lbl) (path ++. lbl) |
		  (lbl, ctype) <- rtype ]
reduce (TblT _ ctype) (Tbl table) path
    = sequence_ [ reduce ctype term (path ++! pat) |
		  (pat, term) <- table ]
reduce (TblT ptype vtype) arg@(Arg _ _ _) path 
    = do env <- readEnv
	 sequence_ [ reduce vtype (arg +! pat) (path ++! pat) |
		     pat <- groundTerms ptype ]
reduce ctype term path = error ("reduce:\n  ctype = (" ++ show ctype ++ 
				")\n  term = (" ++ show term ++ 
				")\n  path = (" ++ show path ++ ")\n")


------------------------------------------------------------
-- expanding a term to ground terms

--expandTerm :: STerm -> CnvMonad STerm
expandTerm arg@(Arg _ _ _) 
    = do env <- readEnv
	 pat <- member $ groundTerms $ cTypeForArg env arg
	 pat =?= arg
	 return pat
expandTerm (con :^ terms)  = liftM (con :^) $ mapM expandTerm terms
expandTerm (Rec record)     = liftM  Rec      $ mapM expandAssign record
expandTerm (Variants terms) = member terms >>= expandTerm
expandTerm term = error $ "expandTerm: " ++ show term

--expandAssign :: (Label, STerm) -> CnvMonad (Label, STerm)
expandAssign (lbl, term)   = liftM ((,) lbl) $ expandTerm term

------------------------------------------------------------
-- unification of patterns and selection terms

--(=?=) :: STerm -> STerm -> CnvMonad ()
Wildcard     =?= _                = return ()
Rec precord  =?= arg@(Arg _ _ _) = sequence_ [ pat =?= (arg +. lbl) |
						 (lbl, pat) <- precord ]
pat           =?= Arg arg _ path  = updateArg arg (path, pat)
(con :^ pats) =?= (con' :^ terms)  = do guard (con==con' && length pats==length terms)
					sequence_ $ zipWith (=?=) pats terms
Rec precord  =?= Rec record      = sequence_ [ maybe mzero (pat =?=) mterm |
						 (lbl, pat) <- precord,
						 let mterm = lookup lbl record ]
pat =?= term = error $ "(=?=): " ++ show pat ++ " =?= " ++ show term


------------------------------------------------------------
-- updating the mcf rule

--updateArg :: Int -> Constraint -> CnvMonad ()
updateArg arg cn
    = do (head, args, lins) <- readState 
	 args' <- updateNth (addToMCFCat cn) arg args
	 writeState (head, args', lins)

--updateHead :: Constraint -> CnvMonad ()
updateHead cn
    = do (head, args, lins) <- readState
	 head' <- addToMCFCat cn head
	 writeState (head', args, lins)

--updateLin :: Constraint -> CnvMonad ()
updateLin (path, term) 
    = do let newLins = term2lins term
	 (head, args, lins) <- readState
	 let lins' = lins ++ map (MCF.Lin path) newLins
	 writeState (head, args, lins')

--term2lins :: STerm -> [[Symbol (Cat, Path, Int) Tokn]]
term2lins (Arg arg cat path) = return [Cat (cat, path, arg)]
term2lins (Token str)        = return [Tok str]
term2lins (t1 :++ t2)     = liftM2 (++) (term2lins t1) (term2lins t2)
term2lins (Empty)            = return []
term2lins (Variants terms)   = terms >>= term2lins
term2lins term = error $ "term2lins: " ++ show term

--addToMCFCat :: Constraint -> MCFCat -> CnvMonad MCFCat
addToMCFCat cn ({-MCFCat-} cat, cns) = liftM ({-MCFCat-} (,) cat) $ addConstraint cn cns

--addConstraint :: Constraint -> [Constraint] -> CnvMonad [Constraint]
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

--lookupCType :: GrammarEnv -> Cat -> CType
lookupCType env cat = errVal defLinType $ 
		      lookupLincat (fst env) (AbsGFC.CIQ (snd env) cat)

--groundTerms :: GrammarEnv -> CType -> [STerm]
groundTerms env ctype = err error (map term2spattern) $
			allParamValues (fst env) ctype

--cTypeForArg :: GrammarEnv -> STerm -> CType
cTypeForArg env (Arg nr cat (Path path))
    = follow path $ lookupCType env cat
    where follow [] ctype = ctype
	  follow (Right pat : path) (TblT _ ctype) = follow path ctype
	  follow (Left lbl : path) (RecT rec)
	      = case [ ctype | (lbl', ctype) <- rec, lbl == lbl' ] of
		  [ctype] -> follow path ctype
		  err     -> error $ "follow: " ++ show rec ++ " . " ++ show lbl ++ 
			             " results in " ++ show err

term2spattern (AbsGFC.R rec)         = Rec [ (lbl, term2spattern term) | 
					     AbsGFC.Ass lbl term <- rec ]
term2spattern (AbsGFC.Con con terms) = con :^ map term2spattern terms

