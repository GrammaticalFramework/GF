----------------------------------------------------------------------
-- |
-- Module      : PGFtoProlog
-- Maintainer  : Peter Ljunglöf
-- Stability   : (stable)
-- Portability : (portable)
--
-- to write a GF grammar into a Prolog module
-----------------------------------------------------------------------------

module GF.Compile.PGFtoProlog (grammar2prolog, grammar2prolog_abs) where

import PGF.CId
import PGF.Data
import PGF.Macros

import GF.Data.Operations

import qualified Data.Map as Map
import Data.Char (isAlphaNum, isAsciiLower, isAsciiUpper, ord)
import Data.List (isPrefixOf,mapAccumL)

grammar2prolog, grammar2prolog_abs :: PGF -> String
-- Most prologs have problems with UTF8 encodings, so we skip that:
grammar2prolog     = {- encodeUTF8 . -} foldr (++++) [] . pgf2clauses 
grammar2prolog_abs = {- encodeUTF8 . -} foldr (++++) [] . pgf2clauses_abs 


pgf2clauses :: PGF -> [String]
pgf2clauses (PGF gflags absname abstract concretes) =
    [":- " ++ plFact "module" [plp absname, "[]"]] ++
    clauseHeader "%% flag(?Flag, ?Value): global flags"
                     (map (plpFact2 "flag") (Map.assocs gflags)) ++
    plAbstract (absname, abstract) ++
    concatMap plConcrete (Map.assocs concretes)

pgf2clauses_abs :: PGF -> [String]
pgf2clauses_abs (PGF gflags absname abstract _concretes) =
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
plAbstract (name, Abstr aflags funs cats) =
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

plCat :: (CId, ([Hypo],[CId])) -> String
plCat (cat, (hypos,_)) = plFact "cat" (plTypeWithHypos typ) 
    where ((_,subst), hypos') = mapAccumL alphaConvertHypo emptyEnv hypos
          args = reverse [EFun x | (_,x) <- subst]
          typ = DTyp hypos' cat args

plFun :: (CId, (Type, Int, Maybe [Equation])) -> String
plFun (fun, (typ,_,_)) = plFact "fun" (plp fun : plTypeWithHypos typ')
    where typ' = snd $ alphaConvert emptyEnv typ

plTypeWithHypos :: Type -> [String]
plTypeWithHypos (DTyp hypos cat args) = [plTerm (plp cat) (map plp args), plList (map (\(_,x,ty) -> plOper ":" (plp x) (plp ty)) hypos)]

plFundef :: (CId, (Type,Int,Maybe [Equation])) -> [String]
plFundef (fun, (_,_,Nothing )) = []
plFundef (fun, (_,_,Just eqs)) = [plFact "def" [plp fun, plp fundef']]
    where fundef' = snd $ alphaConvert emptyEnv eqs


----------------------------------------------------------------------
-- concrete syntax

plConcrete :: (CId, Concr) -> [String]
plConcrete (cncname, cnc) =
    ["", "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%",
     "%% concrete module: " ++ plp cncname] ++
    clauseHeader "%% cncflag(?Flag, ?Value): flags for concrete syntax"
                     (map (mod . plpFact2 "cncflag") (Map.assocs (cflags cnc)))
    where mod clause = plp cncname ++ ": " ++ clause


----------------------------------------------------------------------
-- prolog-printing pgf datatypes

instance PLPrint Type where
    plp (DTyp hypos cat args) | null hypos = result
                              | otherwise  = plOper " -> " (plList (map (\(_,x,ty) -> plOper ":" (plp x) (plp ty)) hypos)) result
        where result = plTerm (plp cat) (map plp args)

instance PLPrint Expr where
    plp (EFun x)    = plp x
    plp (EAbs _ x e)= plOper "^" (plp x) (plp e)
    plp (EApp e e') = plOper " * " (plp e) (plp e')
    plp (ELit lit)  = plp lit
    plp (EMeta n)   = "Meta_" ++ show n

instance PLPrint Patt where
    plp (PVar x)    = plp x
    plp (PApp f ps) = plOper " * " (plp f) (plp ps)
    plp (PLit lit)  = plp lit

instance PLPrint Equation where
    plp (Equ patterns result)   = plOper ":" (plp patterns) (plp result)

instance PLPrint CId where
    plp cid | isLogicalVariable str || 
              cid == wildCId = plVar str
            | otherwise      = plAtom str
        where str = showCId cid

instance PLPrint Literal where
    plp (LStr s) = plp s
    plp (LInt n) = plp (show n)
    plp (LFlt f) = plp (show f)

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
                     || c == '\'' && cs /= "" && last cs == '\''   = atom
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
        where (env',   hypos') = mapAccumL alphaConvertHypo env hypos
              ((ctr,_), args') = alphaConvert env' args

alphaConvertHypo env (b,x,typ) = ((ctr+1,(x,x'):subst), (b,x',typ'))
    where ((ctr,subst), typ') = alphaConvert env typ
          x' = createLogicalVariable ctr

instance AlphaConvert Expr where
    alphaConvert (ctr,subst) (EAbs b x e) = ((ctr',subst), EAbs b x' e')
        where ((ctr',_), e') = alphaConvert (ctr+1,(x,x'):subst) e
              x' = createLogicalVariable ctr
    alphaConvert env (EApp e1 e2) = (env'', EApp e1' e2')
        where (env',  e1') = alphaConvert env  e1
              (env'', e2') = alphaConvert env' e2
    alphaConvert env expr@(EFun i) = (env, maybe expr EFun (lookup i (snd env)))
    alphaConvert env expr = (env, expr)

-- pattern variables are not alpha converted
-- (but they probably should be...)
instance AlphaConvert Equation where
    alphaConvert env@(_,subst) (Equ patterns result)
        = ((ctr,subst), Equ patterns result')
        where ((ctr,_), result') = alphaConvert env result
