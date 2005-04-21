----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:45 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- Converting GFC to SimpleGFC
--
-- the conversion might fail if the GFC grammar has dependent or higher-order types
-----------------------------------------------------------------------------

module GF.OldParsing.ConvertGFCtoSimple where

import qualified GF.Canon.AbsGFC as A
import qualified GF.Infra.Ident as I
import GF.OldParsing.SimpleGFC 

import GF.Canon.GFC
import GF.Canon.MkGFC (grammar2canon)
import qualified GF.Canon.Look as Look (lookupLin, allParamValues, lookupLincat)
import qualified GF.Canon.CMacros as CMacros (defLinType)
import GF.Data.Operations (err, errVal)
import qualified GF.Infra.Modules as M

import GF.System.Tracing
import GF.Printing.PrintParser
import GF.Printing.PrintSimplifiedTerm

----------------------------------------------------------------------

type Env = (CanonGrammar, I.Ident)

convertGrammar :: Env -> Grammar
convertGrammar gram = trace2 "language" (show (snd gram)) $
		      tracePrt "#simple-rules total" (show . length) $
		      [ convertAbsFun gram fun typing |
			A.Mod (A.MTAbs modname) _ _ _ defs <- modules,
			A.AbsDFun fun typing _ <- defs ]
    where A.Gr modules = grammar2canon (fst gram)

convertAbsFun :: Env -> I.Ident -> A.Exp -> Rule
convertAbsFun gram fun aTyping 
    = -- trace2 "absFun" (show fun) $
      Rule fun sTyping sTerm
    where sTyping = convertTyping [] aTyping
	  sTerm = do lin <- lookupLin gram fun
		     return (convertTerm gram lin, convertCType gram cType)
	  cType = lookupCType gram sTyping

convertTyping :: [Decl] -> A.Exp -> Typing
-- convertTyping env tp | trace2 "typing" (prt env ++ " / " ++ prt tp) False = undefined
convertTyping env (A.EProd x a b) 
    = convertTyping ((x ::: convertType [] a) : env) b
convertTyping env a = (convertType [] a, reverse env)

convertType :: [Atom] -> A.Exp -> Type
-- convertType args tp | trace2 "type" (prt args ++ " / " ++ prt tp) False = undefined
convertType args (A.EApp a (A.EAtom at)) = convertType (convertAtom at : args) a
convertType args (A.EAtom at) = convertCat at :@ args

convertAtom :: A.Atom -> Atom
convertAtom (A.AC con) = ACon con
convertAtom (A.AV var) = AVar var

convertCat :: A.Atom -> Cat
convertCat (A.AC (A.CIQ _ cat)) = cat
convertCat at = error $ "convertCat: " ++ show at

convertCType :: Env -> A.CType -> CType
convertCType gram (A.RecType rec) 
    = RecT [ (lbl, convertCType gram ctype) | A.Lbg lbl ctype <- rec ]
convertCType gram (A.Table ptype vtype) 
    = TblT (convertCType gram ptype) (convertCType gram vtype)
convertCType gram ct@(A.Cn con) = ConT con $ map (convertTerm gram) $ groundTerms gram ct
convertCType gram (A.TStr) = StrT
convertCType gram (A.TInts n) = error "convertCType: cannot handle 'TInts' constructor"

convertTerm :: Env -> A.Term -> Term
convertTerm gram (A.Arg arg) = convertArgVar arg
convertTerm gram (A.Con con terms) = con :^ map (convertTerm gram) terms
convertTerm gram (A.LI var) = Var var
convertTerm gram (A.R rec) = Rec [ (lbl, convertTerm gram term) | A.Ass lbl term <- rec ]
convertTerm gram (A.P term lbl) = convertTerm gram term +. lbl
convertTerm gram (A.V ctype terms) = Tbl [ (convertTerm gram pat, convertTerm gram term) |
					  (pat, term) <- zip (groundTerms gram ctype) terms ]
convertTerm gram (A.T ctype tbl) = Tbl [ (convertPatt pat, convertTerm gram term) |
					A.Cas pats term <- tbl, pat <- pats ]
convertTerm gram (A.S term sel) = convertTerm gram term +! convertTerm gram sel
convertTerm gram (A.C term1 term2) = convertTerm gram term1 ?++ convertTerm gram term2
convertTerm gram (A.FV terms) = Variants (map (convertTerm gram) terms)
convertTerm gram (A.K tok) = Token tok
convertTerm gram (A.E) = Empty
convertTerm gram (A.I con) = error "convertTerm: cannot handle 'I' constructor"
convertTerm gram (A.EInt int) = error "convertTerm: cannot handle 'EInt' constructor"

convertArgVar :: A.ArgVar -> Term
convertArgVar (A.A cat nr) = Arg (fromInteger nr) cat emptyPath
convertArgVar (A.AB cat bindings nr) = Arg (fromInteger nr) cat emptyPath

convertPatt (A.PC con pats) = con :^ map convertPatt pats
convertPatt (A.PV x) = Var x
convertPatt (A.PW) = Wildcard
convertPatt (A.PR rec) = Rec [ (lbl, convertPatt pat) | A.PAss lbl pat <- rec ]
convertPatt (A.PI n) = error "convertPatt: cannot handle 'PI' constructor"

----------------------------------------------------------------------

lookupLin gram fun = err fail Just $
		     Look.lookupLin (fst gram) (A.CIQ (snd gram) fun)

--lookupCType :: Env -> Typing -> CType
lookupCType env (cat :@ _, _) = errVal CMacros.defLinType $ 
				Look.lookupLincat (fst env) (A.CIQ (snd env) cat)

groundTerms :: Env -> A.CType -> [A.Term]
groundTerms gram ctype = err error id $
			 Look.allParamValues (fst gram) ctype

