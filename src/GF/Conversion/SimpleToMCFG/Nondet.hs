----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/08/17 08:27:29 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.7 $
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

import Control.Monad

import GF.Formalism.Utilities
import GF.Formalism.GCFG 
import GF.Formalism.MCFG 
import GF.Formalism.SimpleGFC 
import GF.Conversion.Types

import GF.Data.BacktrackM
import GF.Data.Utilities (notLongerThan, updateNthM)

------------------------------------------------------------
-- type declarations

type CnvMonad a = BacktrackM Env a

type Env    = (ECat, [ECat], LinRec, [SLinType]) -- variable bindings: [(Var, STerm)]
type LinRec = [Lin SCat MLabel Token]


----------------------------------------------------------------------
-- main conversion function

maxNrRules :: Int
maxNrRules = 5000

convertGrammar :: SGrammar -> EGrammar 
convertGrammar rules = traceCalcFirst rules' $
		       tracePrt "SimpleToMCFG.Nondet - MCFG rules" (prt . length) $
		       rules'
    where rules' = rules >>= convertRule
--		       solutions conversion undefined
--    where conversion = member rules >>= convertRule

convertRule :: SRule -> [ERule] -- CnvMonad ERule
convertRule (Rule (Abs decl decls fun) (Cnc ctype ctypes (Just term))) =
--    | prt(name2fun fun) `elem` 
--      words "UseCl PosTP TPast ASimul SPredV IndefOneNP DefOneNP UseN2 mother_N2 jump_V" =
    if notLongerThan maxNrRules rules 
       then tracePrt ("SimpeToMCFG.Nondet - MCFG rules for " ++ prt fun) (prt . length) $
	    rules
       else trace2 "SimpeToMCFG.Nondet - TOO MANY RULES, function not converted" 
		("More than " ++ show maxNrRules ++ " MCFG rules for " ++ prt fun) $
            []
    where rules = flip solutions undefined $
		  do let cat : args = map decl2cat (decl : decls)
		     writeState (initialECat cat, map initialECat args, [], ctypes)
		     rterm <- simplifyTerm term
		     reduceTerm ctype emptyPath rterm
		     (newCat, newArgs, linRec, _) <- readState
		     let newLinRec = map (instantiateArgs newArgs) linRec
			 catPaths : argsPaths = map (lintype2paths emptyPath) (ctype : ctypes)
		     -- checkLinRec argsPaths catPaths newLinRec
		     return $ Rule (Abs newCat newArgs fun) (Cnc catPaths argsPaths newLinRec) 
convertRule _ = [] -- failure


----------------------------------------------------------------------
-- "type-checking" the resulting linearization
-- should not be necessary, if the algorithms (type-checking and conversion) are correct

checkLinRec args lbls = mapM (checkLin args lbls) 

checkLin args lbls (Lin lbl lin) 
    | lbl `elem` lbls = mapM (symbol (checkArg args) (const (return ()))) lin
    | otherwise = trace2 "SimpleToMCFG.Nondet - ERROR" "Label mismatch" $
		  failure

checkArg args (_cat, lbl, nr) 
    | lbl `elem` (args !! nr) = return ()
--    | otherwise = trace2 "SimpleToMCFG.Nondet - ERROR" ("Label mismatch in arg " ++ prt nr) $
--		  failure
    | otherwise = trace2 ("SimpleToMCFG.Nondet - ERROR: Label mismatch in arg " ++ prt nr) 
		  (prt lbl ++ " `notElem` " ++ prt (args!!nr)) $
		  failure


----------------------------------------------------------------------
-- term simplification

simplifyTerm :: STerm -> CnvMonad STerm
simplifyTerm (term :! sel)      
    = do sterm <- simplifyTerm term
	 ssel <- simplifyTerm sel
	 case sterm of
	   Tbl table  -> do (pat, val) <- member table
			    pat =?= ssel
			    return val
	   _ -> do sel' <- expandTerm ssel
		   return (sterm +! sel')
-- simplifyTerm (Var x)           = readBinding x
simplifyTerm (con :^ terms)    = liftM (con :^) $ mapM simplifyTerm terms
simplifyTerm (Rec record)      = liftM Rec      $ mapM simplifyAssign record
simplifyTerm (term :. lbl)     = liftM (+. lbl) $      simplifyTerm term
simplifyTerm (Tbl table)       = liftM Tbl      $ mapM simplifyCase table
simplifyTerm (Variants terms)  = liftM Variants $ mapM simplifyTerm terms
simplifyTerm (term1 :++ term2) = liftM2 (:++) (simplifyTerm term1) (simplifyTerm term2)
simplifyTerm term              = return term

simplifyAssign :: (Label, STerm) -> CnvMonad (Label, STerm)
simplifyAssign (lbl, term) = liftM ((,) lbl) $ simplifyTerm term

simplifyCase :: (STerm, STerm) -> CnvMonad (STerm, STerm)
simplifyCase (pat, term) = liftM2 (,) (simplifyTerm pat) (simplifyTerm term)


------------------------------------------------------------
-- reducing simplified terms, collecting MCF rules

reduceTerm :: SLinType -> SPath -> STerm -> CnvMonad ()
--reduceTerm ctype path (Variants terms) 
--    = member terms >>= reduceTerm ctype path
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

expandTerm :: STerm -> CnvMonad STerm
expandTerm arg@(Arg nr _ path) 
    = do ctypes <- readArgCTypes
	 unifyPType arg $ lintypeFollowPath path $ ctypes !! nr
-- expandTerm arg@(Arg nr _ path) 
--     = do ctypes <- readArgCTypes
-- 	 pat <- member $ enumeratePatterns $ lintypeFollowPath path $ ctypes !! nr
-- 	 pat =?= arg
-- 	 return pat
expandTerm (con :^ terms)   = liftM (con :^) $ mapM expandTerm terms
expandTerm (Rec record)     = liftM  Rec     $ mapM expandAssign record
--expandTerm (Variants terms) = liftM Variants $ mapM expandTerm terms  
expandTerm (Variants terms) = member terms >>= expandTerm  
expandTerm term = error $ "expandTerm: " ++ prt term

expandAssign :: (Label, STerm) -> CnvMonad (Label, STerm)
expandAssign (lbl, term) = liftM ((,) lbl) $ expandTerm term

unifyPType :: STerm -> SLinType -> CnvMonad STerm
unifyPType arg (RecT prec) = 
    liftM Rec $
    sequence [ liftM ((,) lbl) $
	       unifyPType (arg +. lbl) ptype |
	       (lbl, ptype) <- prec ]
unifyPType (Arg nr _ path) (ConT con terms) = 
    do (_, args, _, _) <- readState
       case lookup path (ecatConstraints (args !! nr)) of
         Just term -> return term
         Nothing -> do term <- member terms
		       updateArg nr (path, term)
		       return term

------------------------------------------------------------
-- unification of patterns and selection terms

(=?=) :: STerm -> STerm -> CnvMonad ()
-- Wildcard      =?= _               = return ()
-- Var x         =?= term            = addBinding x term
Rec precord   =?= arg@(Arg _ _ _) = sequence_ [ pat =?= (arg +. lbl) |
						(lbl, pat) <- precord ]
pat           =?= Arg nr _ path   = updateArg nr (path, pat)
(con :^ pats) =?= (con' :^ terms) = do guard (con==con' && length pats==length terms)
				       sequence_ $ zipWith (=?=) pats terms
Rec precord   =?= Rec record      = sequence_ [ maybe mzero (pat =?=) mterm |
						(lbl, pat) <- precord,
						let mterm = lookup lbl record ]
-- variants are not allowed in patterns, but in selection terms:
term =?= Variants terms = member terms >>= (term =?=)
pat =?= term = error $ "(=?=): " ++ prt pat ++ " =?= " ++ prt term

----------------------------------------------------------------------
-- variable bindings (does not work correctly)
{-
addBinding x term = do (a, b, c, d, bindings) <- readState
		       writeState (a, b, c, d, (x,term):bindings)

readBinding x = do (_, _, _, _, bindings) <- readState
		   return $ maybe (Var x) id $ lookup x bindings
-}

------------------------------------------------------------
-- updating the MCF rule

readArgCTypes :: CnvMonad [SLinType]
readArgCTypes = do (_, _, _, env) <- readState
		   return env

updateArg :: Int -> Constraint -> CnvMonad ()
updateArg arg cn
    = do (head, args, lins, env) <- readState 
	 args' <- updateNthM (addToECat cn) arg args
	 writeState (head, args', lins, env)

updateHead :: Constraint -> CnvMonad ()
updateHead cn
    = do (head, args, lins, env) <- readState
	 head' <- addToECat cn head
	 writeState (head', args, lins, env)

updateLin :: Constraint -> CnvMonad ()
updateLin (path, term) 
    = do let newLins = term2lins term
	 (head, args, lins, env) <- readState
	 let lins' = lins ++ map (Lin path) newLins
	 writeState (head, args, lins', env)

term2lins :: STerm -> [[Symbol (SCat, SPath, Int) Token]]
term2lins (Arg nr cat path) = return [Cat (cat, path, nr)]
term2lins (Token str)       = return [Tok str]
term2lins (t1 :++ t2)       = liftM2 (++) (term2lins t1) (term2lins t2)
term2lins (Empty)           = return []
term2lins (Variants terms)  = terms >>= term2lins
term2lins term = error $ "term2lins: " ++ show term

addToECat :: Constraint -> ECat -> CnvMonad ECat
addToECat cn (ECat cat cns) = liftM (ECat cat) $ addConstraint cn cns

addConstraint :: Constraint -> [Constraint] -> CnvMonad [Constraint]
addConstraint cn0 (cn : cns)
    | fst cn0 >  fst cn = liftM (cn:) (addConstraint cn0 cns)
    | fst cn0 == fst cn = guard (snd cn0 == snd cn) >>
			  return (cn : cns)
addConstraint cn0 cns   = return (cn0 : cns)



