----------------------------------------------------------------------
-- |
-- Module      : GFCCtoProlog
-- Maintainer  : Peter Ljunglöf
-- Stability   : (stable)
-- Portability : (portable)
--
-- to write a GF grammar into a Prolog module
-----------------------------------------------------------------------------

module GF.Compile.GFCCtoProlog (grammar2prolog, grammar2prolog_abs) where

import PGF.CId
import PGF.Data
import PGF.Macros

import GF.Data.Operations
import GF.Text.UTF8

import qualified Data.Map as Map
import Data.Char (isAlphaNum, isAsciiLower, isAsciiUpper, ord)
import Data.List (isPrefixOf)

grammar2prolog, grammar2prolog_abs :: PGF -> String
grammar2prolog     = encodeUTF8 . foldr (++++) [] . pgf2clauses 
grammar2prolog_abs = encodeUTF8 . foldr (++++) [] . pgf2clauses_abs 


pgf2clauses :: PGF -> [String]
pgf2clauses (PGF absname cncnames gflags abstract concretes) =
    [":- " ++ plFact "module" [plp absname, "[]"]] ++
    clauseHeader "%% concrete(?Module)"
                     [plFact "concrete" [plp cncname] | cncname <- cncnames] ++
    clauseHeader "%% flag(?Flag, ?Value): global flags"
                     (map (plpFact2 "flag") (Map.assocs gflags)) ++
    plAbstract (absname, abstract) ++
    concatMap plConcrete (Map.assocs concretes)

pgf2clauses_abs :: PGF -> [String]
pgf2clauses_abs (PGF absname _cncnames gflags abstract _concretes) =
    [":- " ++ plFact "module" [plp absname, "[]"]] ++
    clauseHeader "%% flag(?Flag, ?Value): global flags"
                     (map (plpFact2 "flag") (Map.assocs gflags)) ++
    plAbstract (absname, abstract)

clauseHeader :: String -> [String] -> [String]
clauseHeader hdr [] = []
clauseHeader hdr clauses = "":hdr:clauses


----------------------------------------------------------------------
-- abstract syntax

plAbstract :: (CId, Abstr) -> [String]
plAbstract (name, Abstr aflags funs cats _catfuns) =
    ["", "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
     "%% abstract module: " ++ plp name] ++
    clauseHeader "%% absflag(?Flag, ?Value): flags for abstract syntax"
                     (map (plpFact2 "absflag") (Map.assocs aflags)) ++ 
    clauseHeader "%% cat(?Type, ?[X:Type,...])" 
                     (map plCat (Map.assocs cats)) ++ 
    clauseHeader "%% fun(?Fun, ?Type, ?[X:Type,...])"
                     (map plFun (Map.assocs funs)) ++
    clauseHeader "%% def(?Fun, ?Expr)" 
                     (concatMap plFundef (Map.assocs funs))

plCat :: (CId, [Hypo]) -> String
plCat (cat, hypos) = plFact "cat" (plTypeWithHypos typ) 
    where ((_,subst), hypos') = alphaConvert emptyEnv hypos
          args = reverse [EVar x | (_,x) <- subst]
          typ = wildcardUnusedVars $ DTyp hypos' cat args

plFun :: (CId, (Type, Expr)) -> String
plFun (fun, (typ, _)) = plFact "fun" (plp fun : plTypeWithHypos typ')
    where typ' = wildcardUnusedVars $ snd $ alphaConvert emptyEnv typ

plTypeWithHypos :: Type -> [String]
plTypeWithHypos (DTyp hypos cat args) = [plTerm (plp cat) (map plp args), plp hypos]

plFundef :: (CId, (Type, Expr)) -> [String]
plFundef (fun, (_, EEq [])) = []
plFundef (fun, (_, fundef)) = [plFact "def" [plp fun, plp fundef']]
    where fundef' = snd $ alphaConvert emptyEnv fundef


----------------------------------------------------------------------
-- concrete syntax

plConcrete :: (CId, Concr) -> [String]
plConcrete (cncname, Concr cflags lins opers lincats lindefs 
                   _printnames _paramlincats _parser) =
    ["", "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
     "%% concrete module: " ++ plp cncname] ++
    clauseHeader "%% cncflag(?Flag, ?Value): flags for concrete syntax"
                     (map (mod . plpFact2 "cncflag") (Map.assocs cflags)) ++ 
    clauseHeader "%% lincat(?Cat, ?Linearization type)"
                     (map (mod . plpFact2 "lincat") (Map.assocs lincats)) ++ 
    clauseHeader "%% lindef(?Cat, ?Linearization default)"
                     (map (mod . plpFact2 "lindef") (Map.assocs lindefs)) ++ 
    clauseHeader "%% lin(?Fun, ?Linearization)"
                     (map (mod . plpFact2 "lin") (Map.assocs lins)) ++
    clauseHeader "%% oper(?Oper, ?Linearization)"
                     (map (mod . plpFact2 "oper") (Map.assocs opers))
    where mod clause = plp cncname ++ ": " ++ clause


----------------------------------------------------------------------
-- prolog-printing pgf datatypes

instance PLPrint Type where
    plp (DTyp hypos cat args) | null hypos = result
                              | otherwise  = plOper " -> " (plp hypos) result
        where result = plTerm (plp cat) (map plp args)

instance PLPrint Hypo where
    plp (Hyp var typ) = plOper ":" (plp var) (plp typ)

instance PLPrint Expr where
    plp (EVar x)    = plp x
    plp (EAbs x e)  = plOper "^" (plp x) (plp e)
    plp (EApp e e') = plOper " * " (plp e) (plp e')
    plp (ELit lit)  = plp lit
    plp (EMeta n)   = "Meta_" ++ show n
    plp (EEq eqs)   = plList [plOper ":" (plp patterns) (plp result) | 
                              Equ patterns result <- eqs]

instance PLPrint Term where
    plp (S terms)  = plList (map plp terms)
    plp (C n)      = show n
    plp (K token)  = plp token
    plp (FV terms) = prCurlyList (map plp terms)
    plp (P t1 t2)  = plOper "/" (plp t1) (plp t2)
    plp (W s trm)  = plOper "+" (plp s) (plp trm)
    plp (R terms)  = plTerm "r" (map plp terms)
    plp (F oper)   = plTerm "f" [plp oper]
    plp (V n)      = plTerm "arg"  [show n]
    plp (TM str)   = plTerm "meta" [plp str]

{-- alternative prolog syntax for PGF terms:
instance PLPrint Term where
    plp (R terms) = plTerm "r"  [plp terms]
    plp (P t1 t2) = plTerm "p"  [plp t1, plp t2]
    plp (S terms) = plTerm "s"  [plp terms]
    plp (K tokn)  = plTerm "k"  [plp tokn]
    plp (V n)     = plTerm "v"  [show n]
    plp (C n)     = plTerm "c"  [show n]
    plp (F oper)  = plTerm "f"  [plp oper]
    plp (FV trms) = plTerm "fv" [plp trms]
    plp (W s trm) = plTerm "w"  [plp s, plp trm]
    plp (TM str)  = plTerm "tm" [plp str]
--}

instance PLPrint CId where
    plp cid | isLogicalVariable str || 
              cid == wildCId = plVar str
            | otherwise      = plAtom str
        where str = prCId cid

instance PLPrint Literal where
    plp (LStr s) = plp s
    plp (LInt n) = plp (show n)
    plp (LFlt f) = plp (show f)

instance PLPrint Tokn where
    plp (KS tokn) = plp tokn
    plp (KP strs alts) = plTerm "kp" [plp strs, plList [plOper "/" (plp ss1) (plp ss2) |
                                                        Alt ss1 ss2 <- alts]]

----------------------------------------------------------------------
-- basic prolog-printing

class PLPrint a where
    plp :: a -> String
    plps :: [a] -> String
    plps = plList . map plp

instance PLPrint Char where
    plp  c = plAtom [c]
    plps s = plAtom s

instance PLPrint a => PLPrint [a] where
    plp = plps

plpFact2 :: (PLPrint a, PLPrint b) => String -> (a, b) -> String
plpFact2 fun (arg1, arg2) = plFact fun [plp arg1, plp arg2]

plFact :: String -> [String] -> String
plFact fun args = plTerm fun args ++ "."

plTerm :: String -> [String] -> String
plTerm fun args = plAtom fun ++ prParenth (prTList ", " args)

plList :: [String] -> String
plList = prBracket . prTList "," 

plOper :: String -> String -> String -> String
plOper op a b = prParenth (a ++ op ++ b)

plVar :: String -> String
plVar = varPrefix  . concatMap changeNonAlphaNum 
    where varPrefix var@(c:_) | isAsciiUpper c || c=='_' = var
                              | otherwise = "_" ++ var
          changeNonAlphaNum c | isAlphaNumUnderscore c = [c]
                              | otherwise = "_" ++ show (ord c) ++ "_"

plAtom :: String -> String
plAtom "" = "''"
plAtom atom@(c:cs) | isAsciiLower c && all isAlphaNumUnderscore cs 
                     || c == '\'' && last cs == '\''               = atom
                   | otherwise = "'" ++ concatMap changeQuote atom ++ "'"
    where changeQuote '\'' = "\\'"
          changeQuote c = [c]

isAlphaNumUnderscore :: Char -> Bool
isAlphaNumUnderscore c = isAlphaNum c || c == '_'


----------------------------------------------------------------------
-- prolog variables 

createLogicalVariable :: Int -> CId
createLogicalVariable n = mkCId (logicalVariablePrefix ++ show n)

isLogicalVariable :: String -> Bool
isLogicalVariable = isPrefixOf logicalVariablePrefix 

logicalVariablePrefix :: String 
logicalVariablePrefix = "X"

----------------------------------------------------------------------
-- alpha convert variables to (unique) logical variables
-- * this is needed if we want to translate variables to Prolog variables
-- * used for abstract syntax, not concrete
-- * not (yet?) used for variables bound in pattern equations

type ConvertEnv = (Int, [(CId,CId)])

emptyEnv :: ConvertEnv
emptyEnv = (0, [])

class AlphaConvert a where
    alphaConvert :: ConvertEnv -> a -> (ConvertEnv, a)

instance AlphaConvert a => AlphaConvert [a] where
    alphaConvert env [] = (env, [])
    alphaConvert env (a:as) = (env'', a':as')
        where (env',  a')  = alphaConvert env  a
              (env'', as') = alphaConvert env' as

instance AlphaConvert Type where
    alphaConvert env@(_,subst) (DTyp hypos cat args) 
        = ((ctr,subst), DTyp hypos' cat args')
        where (env',   hypos') = alphaConvert env hypos
              ((ctr,_), args') = alphaConvert env' args

instance AlphaConvert Hypo where
    alphaConvert env (Hyp x typ) = ((ctr+1,(x,x'):subst), Hyp x' typ')
        where ((ctr,subst), typ') = alphaConvert env typ
              x' = createLogicalVariable ctr

instance AlphaConvert Expr where
    alphaConvert (ctr,subst) (EAbs x e) = ((ctr',subst), EAbs x' e')
        where ((ctr',_), e') = alphaConvert (ctr+1,(x,x'):subst) e
              x' = createLogicalVariable ctr
    alphaConvert env (EApp e1 e2) = (env'', EApp e1' e2')
        where (env',  e1') = alphaConvert env  e1
              (env'', e2') = alphaConvert env' e2
    alphaConvert env expr@(EVar i) = (env, maybe expr EVar (lookup i (snd env)))
    alphaConvert env (EEq eqs) = (env', EEq eqs')
        where (env', eqs') = alphaConvert env eqs
    alphaConvert env expr = (env, expr)

-- pattern variables are not alpha converted
-- (but they probably should be...)
instance AlphaConvert Equation where
    alphaConvert env@(_,subst) (Equ patterns result)
        = ((ctr,subst), Equ patterns' result')
        where (env',  patterns') = alphaConvert env patterns
              ((ctr,_), result') = alphaConvert env' result

----------------------------------------------------------------------
-- translate unused variables to wildcards

wildcardUnusedVars :: Type -> Type
wildcardUnusedVars typ@(DTyp hypos cat args) = DTyp hypos' cat args
    where hypos' = [Hyp x' (wildcardUnusedVars typ') | 
                    Hyp x typ' <- hypos,
                    let x' = if unusedInType x typ then wildCId else x]

          unusedInType x (DTyp hypos _cat args) 
              = and [unusedInType x typ | Hyp _ typ <- hypos] &&
                and [unusedInExpr x exp | exp <- args]

          unusedInExpr x (EAbs y e)  = unusedInExpr x e
          unusedInExpr x (EApp e e') = unusedInExpr x e && unusedInExpr x e'
          unusedInExpr x (EVar y)    = x/=y
          unusedInExpr x (EEq eqs)   = and [all (unusedInExpr x) (result:patterns) |
                                            Equ patterns result <- eqs]
          unusedInExpr x expr        = True
