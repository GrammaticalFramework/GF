----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/09 09:28:44 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.5 $
--
-- Converting SimpleGFC grammars to MCFG grammars, deterministic.
--
-- the resulting grammars might be /very large/
--
-- the conversion is only equivalent if the GFC grammar has a context-free backbone.
-----------------------------------------------------------------------------


module GF.Conversion.SimpleToMCFG.Strict
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
import GF.Data.SortedList

----------------------------------------------------------------------
-- main conversion function

type CnvMonad a = BacktrackM () a

convertGrammar :: SGrammar -> EGrammar 
convertGrammar rules = tracePrt "SimpleToMCFG.Strict - MCFG rules" (prt . length) $
		       solutions conversion undefined
    where conversion = member rules >>= convertRule

convertRule :: SRule -> CnvMonad ERule
convertRule (Rule (Abs decl decls fun) (Cnc ctype ctypes (Just term)))
    = do let cat : args  = map decl2cat (decl : decls)
	     args_ctypes = zip3 [0..] args ctypes
	 instArgs <- mapM enumerateArg args_ctypes
	 let instTerm = substitutePaths instArgs term
	 newCat <- extractECat cat ctype instTerm
	 newArgs <- mapM (extractArg instArgs) args_ctypes
	 let linRec = strPaths ctype instTerm >>= extractLin newArgs
	 let newLinRec = map (instantiateArgs newArgs) linRec
	     catPaths : argsPaths = map (lintype2paths emptyPath) (ctype : ctypes)
	 return $ Rule (Abs newCat newArgs fun) (Cnc catPaths argsPaths newLinRec) 
convertRule _ = failure

----------------------------------------------------------------------
-- category extraction

extractArg :: [STerm] -> (Int, SCat, SLinType) -> CnvMonad ECat
extractArg args (nr, cat, ctype) = extractECat cat ctype (args !! nr)

extractECat :: SCat -> SLinType -> STerm -> CnvMonad ECat
extractECat cat ctype term = member $ map (ECat cat) $ parPaths ctype term

enumerateArg :: (Int, SCat, SLinType) -> CnvMonad STerm
enumerateArg (nr, cat, ctype) = member $ enumerateTerms (Just (Arg nr cat emptyPath)) ctype

----------------------------------------------------------------------
-- Substitute each instantiated parameter path for its instantiation

substitutePaths :: [STerm] -> STerm -> STerm
substitutePaths arguments = subst 
    where subst (Arg nr _ path)  = termFollowPath path (arguments !! nr)
	  subst (con :^ terms)   = con :^ map subst terms
	  subst (Rec record)     = Rec [ (lbl, subst term) | (lbl, term) <- record ]
	  subst (term :. lbl)    = subst term +. lbl
	  subst (Tbl table)      = Tbl [ (pat, subst term) | 
				      (pat, term) <- table ]
	  subst (term :! select) = subst term +! subst select
	  subst (term :++ term') = subst term ?++ subst term'
	  subst (Variants terms) = Variants $ map subst terms
	  subst term = term

----------------------------------------------------------------------
-- term paths extaction

termPaths :: SLinType -> STerm -> [(SPath, (SLinType, STerm))]
termPaths ctype (Variants terms) = terms >>= termPaths ctype
termPaths (RecT rtype) (Rec record) 
    = [ (path ++. lbl, value) |
	(lbl, term) <- record,
	let Just ctype = lookup lbl rtype,
	(path, value) <- termPaths ctype term ]
termPaths (TblT _ ctype) (Tbl table)
    = [ (path ++! pat, value) |
	(pat, term) <- table,
	(path, value) <- termPaths ctype term ]
termPaths ctype term | isBaseType ctype = [ (emptyPath, (ctype, term)) ]

{- ^^^ variants are pushed inside (not equivalent -- but see record-variants.txt):
{a=a1; b=b1}  | {a=a2; b=b2}   ==>  {a=a1|a2; b=b1|b2}
[p=>p1;q=>q1] | [p=>p2;q=>q2]  ==>  [p=>p1|p2;q=>q1|q2]
-}

parPaths :: SLinType -> STerm -> [[(SPath, STerm)]]
parPaths ctype term = mapM (uncurry (map . (,))) $ groupPairs $
		      nubsort [ (path, value) | 
				(path, (ConT _ _, value)) <- termPaths ctype term ]

strPaths :: SLinType -> STerm -> [(SPath, STerm)]
strPaths ctype term = [ (path, variants values) | (path, values) <- groupPairs paths ]
    where paths = nubsort [ (path, value) | (path, (StrT, value)) <- termPaths ctype term ]

----------------------------------------------------------------------
-- linearization extraction

extractLin :: [ECat] -> (SPath, STerm) -> [Lin ECat MLabel Token]
extractLin args (path, term) = map (Lin path) (convertLin term)
    where convertLin (t1 :++ t2) = liftM2 (++) (convertLin t1) (convertLin t2)
	  convertLin (Empty) = [[]]
	  convertLin (Token tok) = [[Tok tok]]
	  convertLin (Variants terms) = concatMap convertLin terms
	  convertLin (Arg nr _ path) = [[Cat (args !! nr, path, nr)]]
	  convertLin t = error $ "convertLin: " ++ prt t ++ "  " ++ prt (args, path)

