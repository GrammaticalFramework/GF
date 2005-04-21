----------------------------------------------------------------------
-- |
-- Module      : ConvertGFCtoMCFG.Nondet
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:55 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- Converting GFC grammars to MCFG grammars, nondeterministically.
--
-- the resulting grammars might be /very large/
--
-- the conversion is only equivalent if the GFC grammar has a context-free backbone.
-- (also, the conversion might fail if the GFC grammar has dependent or higher-order types)
-----------------------------------------------------------------------------


module GF.OldParsing.ConvertGFCtoMCFG.Nondet (convertGrammar) where

import GF.System.Tracing
import GF.Printing.PrintParser
import GF.Printing.PrintSimplifiedTerm
-- import PrintGFC
-- import qualified PrGrammar as PG

import Control.Monad
import GF.Infra.Ident (Ident(..))
import GF.Canon.AbsGFC
import GF.Canon.GFC
import GF.Canon.Look
import GF.Data.Operations
import qualified GF.Infra.Modules as M
import GF.Canon.CMacros (defLinType)
import GF.Canon.MkGFC (grammar2canon)
import GF.OldParsing.Utilities
import GF.OldParsing.GrammarTypes 
import GF.OldParsing.MCFGrammar (Grammar, Rule(..), Lin(..))
import GF.Data.SortedList
-- import Maybe (listToMaybe)
import Data.List (groupBy) -- , transpose)

import GF.Data.BacktrackM

----------------------------------------------------------------------

type Env  = (CanonGrammar, Ident)

convertGrammar :: Env -- ^ the canonical grammar, together with the selected language
	       -> MCFGrammar -- ^ the resulting MCF grammar
convertGrammar gram = trace2 "language" (prt (snd gram)) $
		      trace2 "modules" (prtSep " " modnames) $
		      tracePrt "#mcf-rules total" (prt . length) $
		      solutions conversion undefined
    where Gr modules = grammar2canon (fst gram)
	  modnames   = uncurry M.allExtends gram
	  conversion = member modules >>= convertModule
	  convertModule (Mod (MTCnc modname _) _ _ _ defs)
	      | modname `elem` modnames = member defs >>= convertDef gram
	  convertModule _ = failure

convertDef :: Env -> Def -> CnvMonad MCFRule
convertDef env (CncDFun fun (CIQ _ cat) args term _)
    | trace2 "converting function" (prt fun) True
    = do let iCat : iArgs = map initialMCat (cat : map catOfArg args)
	 writeState (iCat, iArgs, [])
	 convertTerm env cat term
	 (newCat, newArgs, linRec) <- readState
	 let newTerm = map (instLin newArgs) linRec
	 return (Rule newCat newArgs newTerm fun)
convertDef _ _ = failure

instLin newArgs (Lin lbl lin) = Lin lbl (map instSym lin)
    where instSym = mapSymbol instCat id
	  instCat (_, lbl, arg) = (newArgs !! arg, lbl, arg)

convertTerm :: Env -> Cat -> Term -> CnvMonad ()
convertTerm env cat term = do rterm <- simplTerm env term
			      let ctype = lookupCType env cat
			      reduceT env ctype rterm emptyPath

------------------------------------------------------------

type CnvMonad a = BacktrackM CMRule a

type CMRule = (MCFCat, [MCFCat], LinRec)
type LinRec = [Lin Cat Path Tokn]

initialMCat :: Cat -> MCFCat
initialMCat cat = MCFCat cat []

----------------------------------------------------------------------

simplTerm :: Env -> Term -> CnvMonad STerm
simplTerm env = simplifyTerm
 where
  simplifyTerm :: Term -> CnvMonad STerm
  simplifyTerm (Arg (A cat nr))  = return (SArg (fromInteger nr) cat emptyPath)
  simplifyTerm (Con con terms)   = liftM (SCon con) $ mapM simplifyTerm terms
  simplifyTerm (R record)        = liftM SRec       $ mapM simplifyAssign record
  simplifyTerm (P term lbl)      = liftM (+. lbl)   $      simplifyTerm term
  simplifyTerm (T ct table)      = liftM STbl $ sequence $ concatMap simplifyCase table
  simplifyTerm (V ct terms)  
      = liftM STbl $ sequence [ liftM ((,) pat) (simplifyTerm term) |
				(pat, term) <- zip (groundTerms env ct) terms ]
  simplifyTerm (S term sel)      
      = do sterm <- simplifyTerm term
	   ssel <- simplifyTerm sel
	   case sterm of
	     STbl table  -> do (pat, val) <- member table
			       pat =?= ssel
			       return val
	     _ -> do sel' <- expandTerm env ssel
		     return (sterm +! sel')
  simplifyTerm (FV terms)        = liftM SVariants $ mapM simplifyTerm terms
  simplifyTerm (term1 `C` term2) = liftM2 (SConcat) (simplifyTerm term1) (simplifyTerm term2)
  simplifyTerm (K tokn)          = return $ SToken tokn
  simplifyTerm (E)               = return $ SEmpty
  simplifyTerm x                 = error $ "simplifyTerm: " ++ show x
-- error constructors:
--   (I CIdent) - from resource
--   (LI Ident) - pattern variable
--   (EInt Integer) - integer

  simplifyAssign :: Assign -> CnvMonad (Label, STerm)
  simplifyAssign (Ass lbl term) = liftM ((,) lbl) $ simplifyTerm term

  simplifyCase :: Case -> [CnvMonad (STerm, STerm)]
  simplifyCase (Cas pats term) = [ liftM2 (,) (simplifyPattern pat) (simplifyTerm term) |
				 pat <- pats ]

  simplifyPattern :: Patt -> CnvMonad STerm
  simplifyPattern (PC con pats) = liftM (SCon con) $ mapM simplifyPattern pats
  simplifyPattern (PW)          = return SWildcard
  simplifyPattern (PR record)   = do record' <- mapM simplifyPattAssign record
				     case filter (\row -> snd row /= SWildcard) record' of
				       []       -> return SWildcard
				       record'' -> return (SRec record')
  simplifyPattern x = error $ "simplifyPattern: " ++ show x
-- error constructors:
--   (PV Ident) - pattern variable

  simplifyPattAssign :: PattAssign -> CnvMonad (Label, STerm)
  simplifyPattAssign (PAss lbl pat) = liftM ((,) lbl) $ simplifyPattern pat


------------------------------------------------------------
-- reducing simplified terms, collecting mcf rules

reduceT :: Env -> CType -> STerm -> Path -> CnvMonad ()
reduceT env = reduce
 where
  reduce :: CType -> STerm -> Path -> CnvMonad ()
  reduce TStr   term path = updateLin (path, term)
  reduce (Cn _) term path
      = do pat <- expandTerm env term
	   updateHead (path, pat)
  reduce ctype (SVariants terms) path 
      = do term <- member terms
	   reduce ctype term path
  reduce (RecType rtype) term path
      = sequence_ [ reduce ctype (term +. lbl) (path ++. lbl) |
		    Lbg lbl ctype <- rtype ]
  reduce (Table _ ctype) (STbl table) path
      = sequence_ [ reduce ctype term (path ++! pat) |
		    (pat, term) <- table ]
  reduce (Table ptype vtype) arg@(SArg _ _ _) path 
      = sequence_ [ reduce vtype (arg +! pat) (path ++! pat) |
		    pat <- groundTerms env ptype ]
  reduce ctype term path = error ("reduce:\n  ctype = (" ++ show ctype ++ 
				  ")\n  term = (" ++ show term ++ 
				  ")\n  path = (" ++ show path ++ ")\n")


------------------------------------------------------------
-- expanding a term to ground terms

expandTerm :: Env -> STerm -> CnvMonad STerm
expandTerm env arg@(SArg _ _ _) 
    = do pat <- member $ groundTerms env $ cTypeForArg env arg
	 pat =?= arg
	 return pat
expandTerm env (SCon con terms)  = liftM (SCon con) $ mapM (expandTerm env) terms
expandTerm env (SRec record)     = liftM  SRec      $ mapM (expandAssign env) record
expandTerm env (SVariants terms) = member terms >>= expandTerm env
expandTerm env term = error $ "expandTerm: " ++ show term

expandAssign :: Env -> (Label, STerm) -> CnvMonad (Label, STerm)
expandAssign env (lbl, term)   = liftM ((,) lbl) $ expandTerm env term

------------------------------------------------------------
-- unification of patterns and selection terms

(=?=) :: STerm -> STerm -> CnvMonad ()
SWildcard     =?= _                = return ()
SRec precord  =?= arg@(SArg _ _ _) = sequence_ [ pat =?= (arg +. lbl) |
						 (lbl, pat) <- precord ]
pat           =?= SArg arg _ path  = updateArg arg (path, pat)
SCon con pats =?= SCon con' terms  = do guard (con==con' && length pats==length terms)
					sequence_ $ zipWith (=?=) pats terms
SRec precord  =?= SRec record      = sequence_ [ maybe mzero (pat =?=) mterm |
						 (lbl, pat) <- precord,
						 let mterm = lookup lbl record ]
pat =?= term = error $ "(=?=): " ++ show pat ++ " =?= " ++ show term


------------------------------------------------------------
-- updating the mcf rule

updateArg :: Int -> Constraint -> CnvMonad ()
updateArg arg cn
    = do (head, args, lins) <- readState 
	 args' <- updateNth (addToMCFCat cn) arg args
	 writeState (head, args', lins)

updateHead :: Constraint -> CnvMonad ()
updateHead cn
    = do (head, args, lins) <- readState
	 head' <- addToMCFCat cn head
	 writeState (head', args, lins)

updateLin :: Constraint -> CnvMonad ()
updateLin (path, term) 
    = do let newLins = term2lins term
	 (head, args, lins) <- readState
	 let lins' = lins ++ map (Lin path) newLins
	 writeState (head, args, lins')

term2lins :: STerm -> [[Symbol (Cat, Path, Int) Tokn]]
term2lins (SArg arg cat path) = return [Cat (cat, path, arg)]
term2lins (SToken str)        = return [Tok str]
term2lins (SConcat t1 t2)     = liftM2 (++) (term2lins t1) (term2lins t2)
term2lins (SEmpty)            = return []
term2lins (SVariants terms)   = terms >>= term2lins
term2lins term = error $ "term2lins: " ++ show term

addToMCFCat :: Constraint -> MCFCat -> CnvMonad MCFCat
addToMCFCat cn (MCFCat cat cns) = liftM (MCFCat cat) $ addConstraint cn cns

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

catOfArg (A aCat _) = aCat
catOfArg (AB aCat _ _) = aCat

lookupCType :: Env -> Cat -> CType
lookupCType env cat = errVal defLinType $ 
		      lookupLincat (fst env) (CIQ (snd env) cat)

groundTerms :: Env -> CType -> [STerm]
groundTerms env ctype = err error (map term2spattern) $
			allParamValues (fst env) ctype

cTypeForArg :: Env -> STerm -> CType
cTypeForArg env (SArg nr cat (Path path))
    = follow path $ lookupCType env cat
    where follow [] ctype = ctype
	  follow (Right pat : path) (Table _ ctype) = follow path ctype
	  follow (Left lbl : path) (RecType rec)
	      = case [ ctype | Lbg lbl' ctype <- rec, lbl == lbl' ] of
		  [ctype] -> follow path ctype
		  err     -> error $ "follow: " ++ show rec ++ " . " ++ show lbl ++ 
			             " results in " ++ show err

term2spattern (R rec)         = SRec [ (lbl, term2spattern term) | Ass lbl term <- rec ]
term2spattern (Con con terms) = SCon con $ map term2spattern terms

