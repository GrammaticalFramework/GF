----------------------------------------------------------------------
-- |
-- Module      : ConvertGFCtoMCFGnondet
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/21 22:31:54 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Converting GFC grammars to MCFG grammars, nondeterministically.
--
-- the resulting grammars might be /very large/
--
-- the conversion is only equivalent if the GFC grammar has a context-free backbone.
-- (also, the conversion might fail if the GFC grammar has dependent or higher-order types)
-----------------------------------------------------------------------------


module GF.Conversion.ConvertGFCtoMCFG.Utils where

import Tracing
import IOExts (unsafePerformIO)
import GF.Printing.PrintParser
import GF.Printing.PrintSimplifiedTerm
-- import PrintGFC
-- import qualified PrGrammar as PG

import Monad
import Ident (Ident(..))
import AbsGFC
import GFC
import Look
import Operations
import qualified Modules as M
import CMacros (defLinType)
import MkGFC (grammar2canon)
import GF.Parsing.Parser
import GF.Parsing.GrammarTypes 
import GF.Parsing.MCFGrammar (Grammar, Rule(..), Lin(..))
import GF.Data.SortedList
-- import Maybe (listToMaybe)
import List (groupBy) -- , transpose)

import GF.Data.BacktrackM

----------------------------------------------------------------------

type GrammarEnv  = (CanonGrammar, Ident)

buildConversion :: (Def -> BacktrackM GrammarEnv state MCFRule)
		-> GrammarEnv -> MCFGrammar
buildConversion cnvDef env = trace2 "language" (prt (snd gram)) $
			     trace2 "modules" (prtSep " " modnames) $
			     tracePrt "#mcf-rules total" (prt . length) $
			     solutions conversion env undefined
    where Gr modules = grammar2canon (fst gram)
	  modnames   = uncurry M.allExtends gram
	  conversion = member modules >>= convertModule
	  convertModule (Mod (MTCnc modname _) _ _ _ defs)
	      | modname `elem` modnames = member defs >>= cnvDef cnvtype
	  convertModule _ = failure


----------------------------------------------------------------------
-- strict conversion

extractArg :: [STerm] -> ArgVar -> CnvMonad MCFCat
extractArg args (A cat nr) = emcfCat cat (args !! fromInteger nr)

emcfCat :: Cat -> STerm -> CnvMonad MCFCat
emcfCat cat term = do env <- readEnv
		      member $ map (MCFCat cat) $ parPaths env (lookupCType env cat) term

enumerateArg :: ArgVar -> CnvMonad STerm
enumerateArg (A cat nr) = do env <- readEnv
			     let ctype = lookupCType env cat
			     enumerate (SArg (fromInteger nr) cat emptyPath) ctype
    where enumerate arg (TStr) = return arg 
	  enumerate arg ctype@(Cn _) = do env <- readEnv 
					  member $ groundTerms env ctype
	  enumerate arg (RecType rtype) 
	      = liftM SRec $ sequence [ liftM ((,) lbl) $ 
					enumerate (arg +. lbl) ctype |
					lbl `Lbg` ctype <- rtype ]
	  enumerate arg (Table stype ctype)
	      = do env <- readEnv
		   state <- readState
		   liftM STbl $ sequence [ liftM ((,) sel) $ 
					   enumerate (arg +! sel) ctype |
					   sel <- solutions (enumerate err stype) env state ]
	      where err = error "enumerate: parameter type should not be string"

-- Substitute each instantiated parameter path for its instantiation
substitutePaths :: GrammarEnv -> [STerm] -> Term -> STerm
substitutePaths env arguments trm  = subst trm
    where subst (con `Con` terms) = con `SCon` map subst terms
	  subst (R record)        = SRec [ (lbl, subst term) | lbl `Ass` term <- record ]
	  subst (term `P` lbl)    = subst term +. lbl
	  subst (T ptype table)   = STbl [ (pattern2sterm pat, subst term) | 
					   pats `Cas` term <- table, pat <- pats ]
	  subst (V ptype table)   = STbl [ (pat, subst term) | 
					   (pat, term) <- zip (groundTerms env ptype) table ]
	  subst (term `S` select) = subst term +! subst select
	  subst (term `C` term')  = subst term `SConcat` subst term'
	  subst (K str)           = SToken str
	  subst (E)               = SEmpty
	  subst (FV terms)        = evalFV $ map subst terms
	  subst (Arg (A _ arg))   = arguments !! fromInteger arg


termPaths :: GrammarEnv -> CType -> STerm -> [(Path, (CType, STerm))]
termPaths env (TStr) term = [ (emptyPath, (TStr, term)) ]
termPaths env (RecType rtype) (SRec record) 
    = [ (path ++. lbl, value) |
	(lbl, term) <- record,
	let ctype = lookupLabelling lbl rtype,
	(path, value) <- termPaths env ctype term ]
termPaths env (Table _ ctype) (STbl table)
    = [ (path ++! pat, value) |
	(pat, term) <- table,
	(path, value) <- termPaths env ctype term ]
termPaths env ctype (SVariants terms)
    = terms >>= termPaths env ctype
termPaths env (Cn pc) term = [ (emptyPath, (Cn pc, term)) ]

{- ^^^ variants are pushed inside (not equivalent -- but see record-variants.txt):
{a=a1; b=b1}  | {a=a2; b=b2}   ==>  {a=a1|a2; b=b1|b2}
[p=>p1;q=>q1] | [p=>p2;q=>q2]  ==>  [p=>p1|p2;q=>q1|q2]
-}

parPaths :: GrammarEnv -> CType -> STerm -> [[(Path, STerm)]]
parPaths env ctype term = mapM (uncurry (map . (,))) (groupPairs paths)
    where paths = nubsort [ (path, value) | (path, (Cn _, value)) <- termPaths env ctype term ]

strPaths :: GrammarEnv -> CType -> STerm -> [(Path, STerm)]
strPaths env ctype term = [ (path, evalFV values) | (path, values) <- groupPairs paths ]
    where paths = nubsort [ (path, value) | (path, (TStr, value)) <- termPaths env ctype term ]

extractLin :: [MCFCat] -> (Path, STerm) -> [Lin MCFCat MCFLabel Tokn]
extractLin args (path, term) = map (Lin path) (convertLin term)
    where convertLin (t1 `SConcat` t2) = liftM2 (++) (convertLin t1) (convertLin t2)
	  convertLin (SEmpty) = [[]]
	  convertLin (SToken tok) = [[Tok tok]]
	  convertLin (SVariants terms) = concatMap convertLin terms
	  convertLin (SArg nr _ path) = [[Cat (args !! nr, path, nr)]]

evalFV terms0 = case nubsort (concatMap flattenFV terms0) of
	          [term] -> term
		  terms  -> SVariants terms
    where flattenFV (SVariants ts) = ts
	  flattenFV  t      = [t]

lookupLabelling :: Label -> [Labelling] -> CType
lookupLabelling lbl rtyp = case [ ctyp | lbl' `Lbg` ctyp <- rtyp, lbl == lbl' ] of
			     [ctyp] -> ctyp
			     err -> error $ "lookupLabelling:" ++ show err

pattern2sterm :: Patt -> STerm
pattern2sterm (con `PC` patterns) = con `SCon` map pattern2sterm patterns
pattern2sterm (PR record) = SRec [ (lbl, pattern2sterm pattern) | 
				   lbl `PAss` pattern <- record ]

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

lookupCType :: GrammarEnv -> Cat -> CType
lookupCType env cat = errVal defLinType $ 
		      lookupLincat (fst env) (CIQ (snd env) cat)

groundTerms :: GrammarEnv -> CType -> [STerm]
groundTerms env ctype = err error (map term2spattern) $
			allParamValues (fst env) ctype

cTypeForArg :: GrammarEnv -> STerm -> CType
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

