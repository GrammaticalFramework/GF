----------------------------------------------------------------------
-- |
-- Module      : AbsCompute
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- computation in abstract syntax with def definitions.
--
-- modified from src GF computation
-----------------------------------------------------------------------------

module PGF.AbsCompute (
		   compute
		  ) where

import PGF.Data
import PGF.Macros (lookDef,isData)
import PGF.Expr
import PGF.CId

compute :: PGF -> Tree -> Tree
compute pgf = computeAbsTermIn pgf []

computeAbsTermIn :: PGF -> [CId] -> Tree -> Tree
computeAbsTermIn pgf vv = expr2tree . compt vv . tree2expr where
  compt vv t = 
      let 
        t'        = beta vv t
        (yy,f,aa) = exprForm t'
        vv'       = yy ++ vv
        aa'       = map (compt vv') aa
      in 
      mkAbs yy $ case look f of
        Left (EEq eqs) -> case match eqs aa' of
          Just (d,g) -> compt vv' $ subst vv' g d
          _ -> mkApp f aa'
        Left (EMeta _) -> mkApp f aa' -- canonical or primitive
        Left d -> compt vv' $ mkApp d aa'
        _ -> mkApp f aa' -- literal
  look f = case f of
    EVar c -> Left $ lookDef pgf c
    _ -> Right f
  match = findMatch pgf

beta :: [CId] -> Expr -> Expr
beta vv c = case c of
  EApp f a -> 
    let (a',f') = (beta vv a, beta vv f) in 
    case f' of
      EAbs x b -> beta vv $ subst vv [(x,a')] (beta (x:vv) b) 
      _        -> (if a'==a && f'==f then id else beta vv) $ EApp f' a'
  EAbs x b     -> EAbs x (beta (x:vv) b)
  _            -> c


subst :: [CId] -> Subst -> Expr -> Expr
subst xs g e = case e of
  EAbs x b -> EAbs x (subst (x:xs) g e) ---- TODO: refresh variables
  EApp f a -> EApp (substg f) (substg a)
  EVar x -> maybe e id $ lookup x g
  _ -> e
 where
  substg = subst xs g

type Subst = [(CId,Expr)]
type Patt = Expr


exprForm :: Expr -> ([CId],Expr,[Expr])
exprForm exp = upd ([],exp,[]) where
  upd (xs,f,es) = case f of
    EAbs x b -> upd (x:xs,b,es)
    EApp c a -> upd (xs,c,a:es)
    _        -> (reverse xs,f,es)

mkAbs xs b = foldr EAbs b xs
mkApp f es = foldl EApp f es

-- special version of pattern matching, to deal with comp under lambda

findMatch :: PGF -> [Equation] -> [Expr] -> Maybe (Expr, Subst)
findMatch pgf cases terms = case cases of
  [] -> Nothing
  (Equ patts _):_ | length patts /= length terms -> Nothing 
  (Equ patts val):cc -> case mapM tryMatch (zip patts terms) of
     Just substs -> return (val, concat substs)
     _           -> findMatch pgf cc terms
 where
  
  tryMatch (p,t) = case (exprForm p, exprForm t) of
    (([],EVar c,[]),_) | constructor c -> if p==t then return [] else Nothing
    (([],EVar x,[]),_) | notMeta t     -> return [(x,t)]
    (([],p, pp), ([], f, tt)) | p == f && length pp == length tt -> do
         matches <- mapM tryMatch (zip pp tt)
         return (concat matches)
    _ -> if p==t then return [] else Nothing

  notMeta e = case e of
    EMeta _  -> False
    EApp f a -> notMeta f &&  notMeta a  
    EAbs _ b -> notMeta b
    _ -> True

  constructor = isData pgf

