----------------------------------------------------------------------
-- |
-- Module      : ConvertGFCtoMCFG.Strict
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:56 $ 
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


module GF.OldParsing.ConvertGFCtoMCFG.Strict (convertGrammar) where

import GF.System.Tracing
-- import IOExts (unsafePerformIO)
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
    = do let ctype = lookupCType env cat
	 instArgs <- mapM (enumerateArg env) args
	 let instTerm = substitutePaths env instArgs term
	 newCat <- emcfCat env cat instTerm
	 newArgs <- mapM (extractArg env instArgs) args
	 let newTerm = strPaths env ctype instTerm >>= extractLin newArgs
	 return (Rule newCat newArgs newTerm fun)
convertDef _ _ = failure

------------------------------------------------------------

type CnvMonad a = BacktrackM () a

----------------------------------------------------------------------
-- strict conversion

extractArg :: Env -> [STerm] -> ArgVar -> CnvMonad MCFCat
extractArg env args (A cat nr) = emcfCat env cat (args !! fromInteger nr)

emcfCat :: Env -> Cat -> STerm -> CnvMonad MCFCat
emcfCat env cat term = member $ map (MCFCat cat) $ parPaths env (lookupCType env cat) term

enumerateArg :: Env -> ArgVar -> CnvMonad STerm
enumerateArg env (A cat nr) = let ctype = lookupCType env cat
			      in enumerate (SArg (fromInteger nr) cat emptyPath) ctype
    where enumerate arg (TStr) = return arg 
	  enumerate arg ctype@(Cn _) = member $ groundTerms env ctype
	  enumerate arg (RecType rtype) 
	      = liftM SRec $ sequence [ liftM ((,) lbl) $ 
					enumerate (arg +. lbl) ctype |
					lbl `Lbg` ctype <- rtype ]
	  enumerate arg (Table stype ctype)
	      = do state <- readState
		   liftM STbl $ sequence [ liftM ((,) sel) $ 
					   enumerate (arg +! sel) ctype |
					   sel <- solutions (enumerate err stype) state ]
	      where err = error "enumerate: parameter type should not be string"

-- Substitute each instantiated parameter path for its instantiation
substitutePaths :: Env -> [STerm] -> Term -> STerm
substitutePaths env arguments trm  = subst trm
    where subst (con `Con` terms) = con `SCon` map subst terms
	  subst (R record)        = SRec [ (lbl, subst term) | lbl `Ass` term <- record ]
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


termPaths :: Env -> CType -> STerm -> [(Path, (CType, STerm))]
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

parPaths :: Env -> CType -> STerm -> [[(Path, STerm)]]
parPaths env ctype term = mapM (uncurry (map . (,))) (groupPairs paths)
    where paths = nubsort [ (path, value) | (path, (Cn _, value)) <- termPaths env ctype term ]

strPaths :: Env -> CType -> STerm -> [(Path, STerm)]
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

----------------------------------------------------------------------
-- utilities 

lookupCType :: Env -> Cat -> CType
lookupCType env cat = errVal defLinType $ 
		      lookupLincat (fst env) (CIQ (snd env) cat)

lookupLabelling :: Label -> [Labelling] -> CType
lookupLabelling lbl rtyp = case [ ctyp | lbl' `Lbg` ctyp <- rtyp, lbl == lbl' ] of
			     [ctyp] -> ctyp
			     err -> error $ "lookupLabelling:" ++ show err

groundTerms :: Env -> CType -> [STerm]
groundTerms env ctype = err error (map term2spattern) $
			allParamValues (fst env) ctype

term2spattern (R rec)         = SRec [ (lbl, term2spattern term) | Ass lbl term <- rec ]
term2spattern (Con con terms) = SCon con $ map term2spattern terms

pattern2sterm :: Patt -> STerm
pattern2sterm (con `PC` patterns) = con `SCon` map pattern2sterm patterns
pattern2sterm (PR record) = SRec [ (lbl, pattern2sterm pattern) | 
				   lbl `PAss` pattern <- record ]

