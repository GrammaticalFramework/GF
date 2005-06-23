----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/06/23 09:43:40 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.10 $
--
-- Converting GFC to SimpleGFC
--
-- the conversion might fail if the GFC grammar has dependent or higher-order types,
-- or if the grammar contains bound pattern variables
-- (use -optimize=values/share/none when importing)
--
-- TODO: lift all functions to the 'Err' monad
-----------------------------------------------------------------------------

module GF.Conversion.GFCtoSimple
    (convertGrammar) where

import qualified GF.Canon.AbsGFC as A
import qualified GF.Infra.Ident as I
import GF.Formalism.GCFG
import GF.Formalism.SimpleGFC 
import GF.Formalism.Utilities
import GF.Conversion.Types

import GF.UseGrammar.Linear (expandLinTables)
import GF.Canon.GFC (CanonGrammar)
import GF.Canon.MkGFC (grammar2canon)
import qualified GF.Canon.Look as Look (lookupLin, allParamValues, lookupLincat)
import qualified GF.Canon.CMacros as CMacros (defLinType)
import GF.Data.Operations (err, errVal)
--import qualified Modules as M

import GF.System.Tracing
import GF.Infra.Print

----------------------------------------------------------------------

type Env = (CanonGrammar, I.Ident)

convertGrammar :: Env -> SGrammar
convertGrammar gram = trace2 "GFCtoSimple - concrete language" (prt (snd gram)) $
		      tracePrt "GFCtoSimple - simpleGFC rules" (prt . length) $
		      [ convertAbsFun gram fun typing |
			A.Mod (A.MTAbs modname) _ _ _ defs <- modules,
			A.AbsDFun fun typing _ <- defs ]
    where A.Gr modules = grammar2canon (fst gram)

convertAbsFun :: Env -> I.Ident -> A.Exp -> SRule
convertAbsFun gram fun typing = Rule abs cnc
    where abs = convertAbstract [] fun typing
	  cnc = convertConcrete gram abs

----------------------------------------------------------------------
-- abstract definitions

convertAbstract :: [SDecl] -> Fun -> A.Exp -> Abstract SDecl Name
convertAbstract env fun (A.EProd x a b) 
    = convertAbstract (convertType x' [] a : env) fun b
    where x' = if x==I.identC "h_" then anyVar else x
convertAbstract env fun a 
    = Abs (convertType anyVar [] a) (reverse env) name
    where name = Name fun [ Unify [n] | n <- [0 .. length env-1] ]

convertType :: Var -> [TTerm] -> A.Exp -> SDecl
convertType x args (A.EApp a b) = convertType x (convertExp [] b : args) a
convertType x args (A.EAtom at) = Decl x (convertCat at) args
convertType x args exp          = error $ "GFCtoSimple.convertType: " ++ prt exp

convertExp :: [TTerm] -> A.Exp -> TTerm
convertExp args (A.EAtom at) = convertAtom args at
convertExp args (A.EApp a b) = convertExp (convertExp [] b : args) a
convertExp args exp          = error $ "GFCtoSimple.convertExp: " ++ prt exp

convertAtom :: [TTerm] -> A.Atom -> TTerm
convertAtom args (A.AC con) = con :@ reverse args
convertAtom []   (A.AV var) = TVar var
convertAtom args atom       = error $ "GFCtoSimple.convertAtom: " ++ prt args ++ " " ++ prt atom

convertCat :: A.Atom -> SCat
convertCat (A.AC (A.CIQ _ cat)) = cat
convertCat atom                 = error $ "GFCtoSimple.convertCat: " ++ show atom

----------------------------------------------------------------------
-- concrete definitions

convertConcrete :: Env -> Abstract SDecl Name -> Concrete SLinType (Maybe STerm)
convertConcrete gram (Abs decl args name) = Cnc ltyp largs term
    where term = fmap (convertTerm gram . expandTerm gram) $ lookupLin gram $ name2fun name
	  ltyp : largs = map (convertCType gram . lookupCType gram) (decl : args)

expandTerm :: Env -> A.Term -> A.Term
expandTerm gram term = err error id $ expandLinTables (fst gram) term

convertCType :: Env -> A.CType -> SLinType
convertCType gram (A.RecType rec) = RecT [ (lbl, convertCType gram ctype) | A.Lbg lbl ctype <- rec ]
convertCType gram (A.Table pt vt) = TblT (convertCType gram pt) (convertCType gram vt)
convertCType gram ct@(A.Cn con)   = ConT con $ map (convertTerm gram) $ groundTerms gram ct
convertCType gram (A.TStr)        = StrT
convertCType gram (A.TInts n)     = error "GFCtoSimple.convertCType: cannot handle 'TInts' constructor"

convertTerm :: Env -> A.Term -> STerm
convertTerm gram (A.Arg arg)       = convertArgVar arg
convertTerm gram (A.Par con terms) = con :^ map (convertTerm gram) terms
-- convertTerm gram (A.LI var)        = Var var
convertTerm gram (A.R rec)         = Rec [ (lbl, convertTerm gram term) | A.Ass lbl term <- rec ]
convertTerm gram (A.P term lbl)    = convertTerm gram term +. lbl
convertTerm gram (A.V ctype terms) = Tbl [ (convertTerm gram pat, convertTerm gram term) |
					  (pat, term) <- zip (groundTerms gram ctype) terms ]
convertTerm gram (A.T ctype tbl)   = Tbl [ (convertPatt pat, convertTerm gram term) |
					   A.Cas pats term <- tbl, pat <- pats ]
convertTerm gram (A.S term sel)    = convertTerm gram term :! convertTerm gram sel
convertTerm gram (A.C term1 term2) = convertTerm gram term1 ?++ convertTerm gram term2
convertTerm gram (A.FV terms)      = variants (map (convertTerm gram) terms)
convertTerm gram (A.E)             = Empty
convertTerm gram (A.K (A.KS tok))  = Token tok
-- 'pre' tokens are converted to variants (over-generating):
convertTerm gram (A.K (A.KP strs vars))
                                   = variants $ map conc $ strs : [ vs | A.Var vs _ <- vars ]
    where conc [] = Empty
	  conc ts = foldr1 (?++) $ map Token ts
convertTerm gram (A.I con)         = error "GFCtoSimple.convertTerm: cannot handle 'I' constructor"
convertTerm gram (A.EInt int)      = error "GFCtoSimple.convertTerm: cannot handle 'EInt' constructor"

convertArgVar :: A.ArgVar -> STerm
convertArgVar (A.A cat nr)           = Arg (fromInteger nr) cat emptyPath
convertArgVar (A.AB cat bindings nr) = Arg (fromInteger nr) cat emptyPath

convertPatt (A.PC con pats) = con :^ map convertPatt pats
-- convertPatt (A.PV x)        = Var x
-- convertPatt (A.PW)          = Wildcard
convertPatt (A.PR rec)      = Rec [ (lbl, convertPatt pat) | A.PAss lbl pat <- rec ]
convertPatt (A.PI n)        = error "GFCtoSimple.convertPatt: cannot handle 'PI' constructor"

----------------------------------------------------------------------

lookupLin :: Env -> Fun -> Maybe A.Term
lookupLin gram fun = err fail Just $
		     Look.lookupLin (fst gram) (A.CIQ (snd gram) fun)

lookupCType :: Env -> SDecl -> A.CType
lookupCType env decl
    = errVal CMacros.defLinType $ 
      Look.lookupLincat (fst env) (A.CIQ (snd env) (decl2cat decl))

groundTerms :: Env -> A.CType -> [A.Term]
groundTerms gram ctype = err error id $
			 Look.allParamValues (fst gram) ctype

