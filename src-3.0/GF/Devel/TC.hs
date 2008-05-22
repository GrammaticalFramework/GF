----------------------------------------------------------------------
-- |
-- Module      : TC
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/10/02 20:50:19 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.11 $
--
-- Thierry Coquand's type checking algorithm that creates a trace
-----------------------------------------------------------------------------

module GF.Devel.TC (AExp(..),
	   Theory,
	   checkExp,
	   inferExp,
           checkEqs,
	   eqVal,
	   whnf
	  ) where

import GF.Data.Operations
import GF.Grammar.Predef
import GF.Grammar.Abstract

import Control.Monad
import Data.List (sortBy)

data AExp =
     AVr   Ident Val 
   | ACn   QIdent Val
   | AType 
   | AInt  Integer 
   | AFloat Double
   | AStr  String
   | AMeta MetaSymb Val
   | AApp  AExp AExp Val 
   | AAbs  Ident Val AExp 
   | AProd Ident AExp AExp 
   | AEqs  [([Exp],AExp)] --- not used
   | AData Val
  deriving (Eq,Show)

type Theory = QIdent -> Err Val

lookupConst :: Theory -> QIdent -> Err Val
lookupConst th f = th f

lookupVar :: Env -> Ident -> Err Val
lookupVar g x = maybe (prtBad "unknown variable" x) return $ lookup x ((IW,uVal):g)
-- wild card IW: no error produced, ?0 instead.

type TCEnv = (Int,Env,Env)

emptyTCEnv :: TCEnv
emptyTCEnv = (0,[],[])

whnf :: Val -> Err Val
whnf v = ---- errIn ("whnf" +++ prt v) $ ---- debug
         case v of
  VApp u w -> do
    u' <- whnf u 
    w' <- whnf w
    app u' w'
  VClos env e -> eval env e
  _ -> return v

app :: Val -> Val -> Err Val
app u v = case u of
  VClos env (Abs x e) -> eval ((x,v):env) e
  _ -> return $ VApp u v
  
eval :: Env -> Exp -> Err Val
eval env e = ---- errIn ("eval" +++ prt e +++ "in" +++ prEnv env) $ 
             case e of
  Vr x    -> lookupVar env x
  Q m c   -> return $ VCn (m,c)
  QC m c  -> return $ VCn (m,c) ---- == Q ?
  Sort c  -> return $ VType --- the only sort is Type
  App f a -> join $ liftM2 app (eval env f) (eval env a)
  _ -> return $ VClos env e

eqVal :: Int -> Val -> Val -> Err [(Val,Val)]
eqVal k u1 u2 = ---- errIn (prt u1 +++ "<>" +++ prBracket (show k) +++ prt u2) $ 
                do
  w1 <- whnf u1
  w2 <- whnf u2 
  let v = VGen k
  case (w1,w2) of
    (VApp f1 a1, VApp f2 a2) -> liftM2 (++) (eqVal k f1 f2) (eqVal k a1 a2)
    (VClos env1 (Abs x1 e1), VClos env2 (Abs x2 e2)) ->
      eqVal (k+1) (VClos ((x1,v x1):env1) e1) (VClos ((x2,v x1):env2) e2)
    (VClos env1 (Prod x1 a1 e1), VClos env2 (Prod x2 a2 e2)) ->
      liftM2 (++) 
        (eqVal k     (VClos env1          a1) (VClos env2          a2))
        (eqVal (k+1) (VClos ((x1,v x1):env1) e1) (VClos ((x2,v x1):env2) e2))
    (VGen i _, VGen j _) -> return [(w1,w2) | i /= j]
    (VCn (_, i), VCn (_,j)) -> return [(w1,w2) | i /= j] 
    --- thus ignore qualifications; valid because inheritance cannot
    --- be qualified. Simplifies annotation. AR 17/3/2005 
    _ -> return [(w1,w2) | w1 /= w2]
-- invariant: constraints are in whnf

checkType :: Theory -> TCEnv -> Exp -> Err (AExp,[(Val,Val)])
checkType th tenv e = checkExp th tenv e vType

checkExp :: Theory -> TCEnv -> Exp -> Val -> Err (AExp, [(Val,Val)])
checkExp th tenv@(k,rho,gamma) e ty = do
  typ <- whnf ty
  let v = VGen k
  case e of
    Meta m -> return $ (AMeta m typ,[])
    EData -> return $ (AData typ,[])

    Abs x t -> case typ of
      VClos env (Prod y a b) -> do
	a' <- whnf $ VClos env a ---
	(t',cs) <- checkExp th 
                           (k+1,(x,v x):rho, (x,a'):gamma) t (VClos ((y,v x):env) b)
	return (AAbs x a' t', cs)
      _ -> prtBad ("function type expected for" +++ prt e +++ "instead of") typ

-- {- --- to get deprec when checkEqs works (15/9/2005)
    Eqs es -> do
      bcs <- mapM (\b -> checkBranch th tenv b typ) es
      let (bs,css) = unzip bcs
      return (AEqs bs, concat css) 
-- - }
    Prod x a b -> do
      testErr (typ == vType) "expected Type"
      (a',csa) <- checkType th tenv a
      (b',csb) <- checkType th (k+1, (x,v x):rho, (x,VClos rho a):gamma) b
      return (AProd x a' b', csa ++ csb)

    _ -> checkInferExp th tenv e typ

checkInferExp :: Theory -> TCEnv -> Exp -> Val -> Err (AExp, [(Val,Val)])
checkInferExp th tenv@(k,_,_) e typ = do
  (e',w,cs1) <- inferExp th tenv e
  cs2 <- eqVal k w typ
  return (e',cs1 ++ cs2)
      
inferExp :: Theory -> TCEnv -> Exp -> Err (AExp, Val, [(Val,Val)])
inferExp th tenv@(k,rho,gamma) e = case e of
   Vr x -> mkAnnot (AVr x) $ noConstr $ lookupVar gamma x
   Q m c | m == cPredefAbs && isPredefCat c
                     -> return (ACn (m,c) vType, vType, [])
         | otherwise -> mkAnnot (ACn (m,c)) $ noConstr $ lookupConst th (m,c)
   QC m c -> mkAnnot (ACn (m,c)) $ noConstr $ lookupConst th (m,c) ----
   EInt i -> return (AInt i, valAbsInt, [])
   EFloat i -> return (AFloat i, valAbsFloat, [])
   K i -> return (AStr i, valAbsString, [])
   Sort _ -> return (AType, vType, [])
   App f t -> do
    (f',w,csf) <- inferExp th tenv f 
    typ <- whnf w
    case typ of
      VClos env (Prod x a b) -> do
        (a',csa) <- checkExp th tenv t (VClos env a)
	b' <- whnf $ VClos ((x,VClos rho t):env) b
	return $ (AApp f' a' b', b', csf ++ csa)
      _ -> prtBad ("Prod expected for function" +++ prt f +++ "instead of") typ
   _ -> prtBad "cannot infer type of expression" e

checkEqs :: Theory -> TCEnv -> (Fun,Trm) -> Val -> Err [(Val,Val)]
checkEqs th tenv@(k,rho,gamma) (fun@(m,f),def) val = case def of
  Eqs es -> liftM concat $ mapM checkBranch es
  _      -> liftM snd $ checkExp th tenv def val
 where
  checkBranch (ps,df) = 
   let
      (ps',_,vars) = foldr p2t ([],0,[]) ps
      fps        = mkApp (Q m f) ps'
   in errIn ("branch" +++ prt fps) $ do
    (aexp, typ, cs1) <- inferExp th tenv fps
    let
      bds = binds vars aexp 
      tenv' = (k, rho, bds ++ gamma) 
    (_,cs2)  <- errIn (show bds) $ checkExp th tenv' df typ
    return $ (cs1 ++ cs2)
  p2t p (ps,i,g) = case p of
     PW      -> (Meta (MetaSymb i) : ps, i+1,        g) 
     PV IW   -> (Meta (MetaSymb i) : ps, i+1,        g) 
     PV x    -> (Meta (MetaSymb i) : ps, i+1,upd x i g)
     PString s -> (            K s : ps, i,          g)
     PInt n -> (EInt n : ps, i, g)
     PFloat n -> (EFloat n : ps, i, g)
     PP m c xs -> (mkApp (qq (m,c)) xss : ps, i', g') 
                    where (xss,i',g') = foldr p2t ([],i,g) xs
     _ -> error $ "undefined p2t case" +++ prt p +++ "in checkBranch"
  upd x i g = (x,i) : g --- to annotate pattern variables: treat as metas
  
  -- notice: in vars, the sequence 0.. is sorted. In subst aexp, all
  -- this occurs and nothing else.
  binds vars aexp = [(x,v) | ((x,_),v) <- zip vars metas] where
    metas = map snd $ sortBy (\ (x,_) (y,_) -> compare x y) $ subst aexp
  subst aexp = case aexp of
   AMeta (MetaSymb i) v -> [(i,v)]
   AApp  c a _ -> subst c ++ subst a
   _ -> [] -- never matter in patterns

checkBranch :: Theory -> TCEnv -> Equation -> Val -> Err (([Exp],AExp),[(Val,Val)])
checkBranch th tenv b@(ps,t) ty = errIn ("branch" +++ show b) $ 
                                  chB tenv' ps' ty 
 where 

  (ps',_,rho2,k') = ps2ts k ps
  tenv' = (k, rho2++rho, gamma) ---- k' ?
  (k,rho,gamma) = tenv

  chB tenv@(k,rho,gamma) ps ty = case ps of
    p:ps2 -> do
      typ <- whnf ty
      case typ of
        VClos env (Prod y a b) -> do
	  a' <- whnf $ VClos env a
          (p', sigma, binds, cs1) <- checkP tenv p y a'
          let tenv' = (length binds, sigma ++ rho, binds ++ gamma)
          ((ps',exp),cs2) <- chB tenv' ps2 (VClos ((y,p'):env) b)
	  return ((p:ps',exp), cs1 ++ cs2) -- don't change the patt
        _ -> prtBad ("Product expected for definiens" +++prt t +++ "instead of") typ
    [] -> do
      (e,cs) <- checkExp th tenv t ty
      return (([],e),cs)
  checkP env@(k,rho,gamma) t x a = do
     (delta,cs) <- checkPatt th env t a
     let sigma = [(x, VGen i x) | ((x,_),i) <- zip delta [k..]]
     return (VClos sigma t, sigma, delta, cs)

  ps2ts k = foldr p2t ([],0,[],k) 
  p2t p (ps,i,g,k) = case p of
     PW      -> (Meta (MetaSymb i) : ps, i+1,g,k) 
     PV IW   -> (Meta (MetaSymb i) : ps, i+1,g,k) 
     PV x    -> (Vr x   : ps, i, upd x k g,k+1)
     PString s -> (K s : ps, i, g, k)
     PInt n -> (EInt n : ps, i, g, k)
     PFloat n -> (EFloat n : ps, i, g, k)
     PP m c xs -> (mkApp (qq (m,c)) xss : ps, j, g',k') 
                    where (xss,j,g',k') = foldr p2t ([],i,g,k) xs
     _ -> error $ "undefined p2t case" +++ prt p +++ "in checkBranch"

  upd x k g = (x, VGen k x) : g --- hack to recognize pattern variables


checkPatt :: Theory -> TCEnv -> Exp -> Val -> Err (Binds,[(Val,Val)])
checkPatt th tenv exp val = do
  (aexp,_,cs) <- checkExpP tenv exp val
  let binds = extrBinds aexp
  return (binds,cs)
 where
   extrBinds aexp = case aexp of
     AVr i v    -> [(i,v)]
     AApp f a _ -> extrBinds f ++ extrBinds a
     _ -> [] -- no other cases are possible

--- ad hoc, to find types of variables
   checkExpP tenv@(k,rho,gamma) exp val = case exp of
     Meta m -> return $ (AMeta m val, val, [])
     Vr x   -> return $ (AVr   x val, val, [])
     EInt i -> return (AInt i, valAbsInt, [])
     EFloat i -> return (AFloat i, valAbsFloat, [])
     K s    -> return (AStr s, valAbsString, [])

     Q m c  -> do
       typ <- lookupConst th (m,c)
       return $ (ACn (m,c) typ, typ, [])
     QC m c  -> do
       typ <- lookupConst th (m,c)
       return $ (ACn (m,c) typ, typ, []) ----
     App f t -> do
       (f',w,csf) <- checkExpP tenv f val
       typ <- whnf w
       case typ of
         VClos env (Prod x a b) -> do
           (a',_,csa) <- checkExpP tenv t (VClos env a)
	   b' <- whnf $ VClos ((x,VClos rho t):env) b
	   return $ (AApp f' a' b', b', csf ++ csa)
         _ -> prtBad ("Prod expected for function" +++ prt f +++ "instead of") typ
     _ -> prtBad "cannot typecheck pattern" exp

-- auxiliaries

noConstr :: Err Val -> Err (Val,[(Val,Val)])
noConstr er = er >>= (\v -> return (v,[]))

mkAnnot :: (Val -> AExp) -> Err (Val,[(Val,Val)]) -> Err (AExp,Val,[(Val,Val)])
mkAnnot a ti = do
  (v,cs) <- ti
  return (a v, v, cs)

