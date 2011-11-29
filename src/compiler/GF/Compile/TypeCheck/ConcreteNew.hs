module GF.Compile.TypeCheck.ConcreteNew( checkLType, inferLType ) where

import GF.Grammar hiding (Env, VGen, VApp)
import GF.Grammar.Lookup
import GF.Compile.Compute.ConcreteNew
import GF.Infra.CheckM
import GF.Infra.UseIO
import GF.Data.Operations

import Text.PrettyPrint
import Data.List (nub, (\\))
import qualified Data.IntMap as IntMap
import qualified Data.ByteString.Char8 as BS

import GF.Grammar.Parser
import System.IO
import Debug.Trace

checkLType :: SourceGrammar -> Term -> Type -> Check (Term, Type)
checkLType gr t ty = runTcM $ do
  t <- checkSigma gr [] t (eval [] ty)
  t <- zonkTerm t
  return (t,ty)

inferLType :: SourceGrammar -> Term -> Check (Term, Type)
inferLType gr t = runTcM $ do
  (t,ty) <- inferSigma gr [] t
  t  <- zonkTerm t
  ty <- zonkTerm (value2term [] ty)
  return (t,ty)

checkSigma :: SourceGrammar -> Scope -> Term -> Sigma -> TcM Term
checkSigma gr scope t sigma = do
  (skol_tvs, rho) <- skolemise scope sigma
  (t,rho) <- tcRho gr scope t (Just rho)
  esc_tvs <- getFreeTyVars (sigma : map snd scope)
  let bad_tvs = filter (`elem` esc_tvs) skol_tvs
  if null bad_tvs
    then return t
    else tcError (text "Type not polymorphic enough")

inferSigma :: SourceGrammar -> Scope -> Term -> TcM (Term,Sigma)
inferSigma gr scope t = do
  (t,ty) <- tcRho gr scope t Nothing
  env_tvs <- getMetaVars [ty | (_,ty) <- scope]
  res_tvs <- getMetaVars [ty]
  let forall_tvs = res_tvs \\ env_tvs
  quantify scope t forall_tvs ty

tcRho :: SourceGrammar -> Scope -> Term -> Maybe Rho -> TcM (Term, Rho)
tcRho gr scope t@(EInt _)   mb_ty = instSigma scope t (eval [] typeInt)    mb_ty
tcRho gr scope t@(EFloat _) mb_ty = instSigma scope t (eval [] typeFloat)  mb_ty
tcRho gr scope t@(K _)      mb_ty = instSigma scope t (eval [] typeString) mb_ty
tcRho gr scope t@(Empty)    mb_ty = instSigma scope t (eval [] typeString) mb_ty
tcRho gr scope t@(Vr v)     mb_ty = do
  case lookup v scope of
    Just v_sigma -> instSigma scope t v_sigma mb_ty
    Nothing      -> tcError (text "Unknown variable" <+> ppIdent v)
tcRho gr scope t@(Q id)     mb_ty = do
  case lookupResType gr id of
    Ok ty   -> instSigma scope t (eval [] ty) mb_ty
    Bad err -> tcError (text err)
tcRho gr scope t@(QC id)     mb_ty = do
  case lookupResType gr id of
    Ok ty   -> instSigma scope t (eval [] ty) mb_ty
    Bad err -> tcError (text err)
tcRho gr scope (App fun arg) mb_ty = do
  (fun,fun_ty) <- tcRho gr scope fun Nothing
  (arg_ty, res_ty) <- unifyFun scope fun_ty
  arg <- checkSigma gr scope arg arg_ty
  instSigma scope (App fun arg) res_ty mb_ty
tcRho gr scope (Abs bt var body) (Just ty) = do
  trace (show ty) $ return ()
  (var_ty, body_ty) <- unifyFun scope ty 
  (body, body_ty) <- tcRho gr ((var,var_ty):scope) body (Just body_ty)
  return (Abs bt var body,ty)
tcRho gr scope (Abs bt var body) Nothing = do
  i <- newMeta (eval [] typeType)
  (body,body_ty) <- tcRho gr ((var,VMeta i (scopeEnv scope) []):scope) body Nothing
  return (Abs bt var body, (VClosure (scopeEnv scope)
                                     (Prod bt identW (Meta i) (value2term (scopeVars scope) body_ty))))
tcRho gr scope (Typed body ann_ty) mb_ty = do
  body <- checkSigma gr scope body (eval (scopeEnv scope) ann_ty)
  instSigma scope (Typed body ann_ty) (eval (scopeEnv scope) ann_ty) mb_ty
tcRho gr scope (FV ts) mb_ty = do
  case ts of
    [] -> do i <- newMeta (eval [] typeType)
             instSigma scope (FV []) (VMeta i (scopeEnv scope) []) mb_ty
    (t:ts) -> do (t,ty) <- tcRho gr scope t mb_ty
    
                 let go []     ty = return ([],ty)
                     go (t:ts) ty = do (t, ty) <- tcRho gr scope t (Just ty)
                                       (ts,ty) <- go ts ty
                                       return (t:ts,ty)
                  
                 (ts,ty) <- go ts ty
                 return (FV (t:ts), ty)
tcRho gr scope t _ = error ("tcRho "++show t)

-- | Invariant: if the third argument is (Just rho),
-- 	            then rho is in weak-prenex form
instSigma :: Scope -> Term -> Sigma -> Maybe Rho -> TcM (Term, Rho)
instSigma scope t ty1 (Just ty2) = do t <- subsCheckRho scope t ty1 ty2
                                      return (t,ty2)
instSigma scope t ty1 Nothing    = instantiate t ty1

-- | (subsCheck scope args off exp) checks that 
--     'off' is at least as polymorphic as 'args -> exp'
subsCheck :: Scope -> Term -> Sigma -> Sigma -> TcM Term
subsCheck scope t sigma1 sigma2 = do       -- Rule DEEP-SKOL
  (skol_tvs, rho2) <- skolemise scope sigma2
  t <- subsCheckRho scope t sigma1 rho2
  esc_tvs <- getFreeTyVars [sigma1,sigma2]
  let bad_tvs = filter (`elem` esc_tvs) skol_tvs
  if null bad_tvs
    then return ()
    else tcError (vcat [text "Subsumption check failed:",
                        nest 2 (ppTerm Unqualified 0 (value2term [] sigma1)),
                        text "is not as polymorphic as",
                        nest 2 (ppTerm Unqualified 0 (value2term [] sigma2))])
  return t


-- | Invariant: the second argument is in weak-prenex form
subsCheckRho :: Scope -> Term -> Sigma -> Rho -> TcM Term
subsCheckRho scope t sigma1@(VClosure env (Prod Implicit _ _ _)) rho2 = do   -- Rule SPEC
  (t,rho1) <- instantiate t sigma1
  subsCheckRho scope t rho1 rho2
subsCheckRho scope t rho1 (VClosure env (Prod Explicit _ a2 r2)) = do        -- Rule FUN
  (a1,r1) <- unifyFun scope rho1
  subsCheckFun scope t a1 r1 (eval env a2) (eval env r2)
subsCheckRho scope t (VClosure env (Prod Explicit _ a1 r1)) rho2 = do        -- Rule FUN
  (a2,r2) <- unifyFun scope rho2
  subsCheckFun scope t (eval env a1) (eval env r1) a2 r2
subsCheckRho scope t tau1 tau2 = do                                          -- Rule MONO
  unify scope tau1 tau2                                 -- Revert to ordinary unification
  return t

subsCheckFun :: Scope -> Term -> Sigma -> Rho -> Sigma -> Rho -> TcM Term
subsCheckFun scope t a1 r1 a2 r2 = do
  let v = newVar scope
  vt <- subsCheck scope (Vr v) a2 a1
  t  <- subsCheckRho ((v,eval [] typeType):scope) (App t vt) r1 r2 ;
  return (Abs Implicit v t)


-----------------------------------------------------------------------
-- Unification
-----------------------------------------------------------------------

unifyFun :: Scope -> Rho -> TcM (Sigma, Rho)
unifyFun scope (VClosure env (Prod Explicit x arg res))
  | x /= identW = return (eval env arg,eval ((x,VGen (length scope) []):env) res)
  | otherwise   = return (eval env arg,eval                             env  res)
unifyFun scope tau                                      = do
  arg_ty <- newMeta (eval [] typeType)
  res_ty <- newMeta (eval [] typeType)
  unify scope tau (VClosure [] (Prod Explicit identW (Meta arg_ty) (Meta res_ty)))
  return (VMeta arg_ty [] [], VMeta res_ty [] [])

unify scope (VApp f1 vs1)      (VApp f2 vs2)
  | f1 == f2                   = sequence_ (zipWith (unify scope) vs1 vs2)
unify scope (VMeta i env1 vs1) (VMeta j env2 vs2)
  | i  == j                    = sequence_ (zipWith (unify scope) vs1 vs2)
  | otherwise                  = do mv <- getMeta j
                                    case mv of
                                      Bound t2  -> unify scope (VMeta i env1 vs1) (apply env2 t2 vs2)
                                      Unbound _ -> setMeta i (Bound (Meta j))
unify scope (VMeta i env vs) v = unifyVar scope i env vs v
unify scope v (VMeta i env vs) = unifyVar scope i env vs v
unify scope v1 v2 = do
  v1 <- zonkTerm (value2term (scopeVars scope) v1)
  v2 <- zonkTerm (value2term (scopeVars scope) v2)
  tcError (text "Cannot unify types:" <+> (ppTerm Unqualified 0 v1 $$ 
                                           ppTerm Unqualified 0 v2))

-- | Invariant: tv1 is a flexible type variable
unifyVar :: Scope -> MetaId -> Env -> [Value] -> Tau -> TcM ()
unifyVar scope i env vs ty2 = do            -- Check whether i is bound
  mv <- getMeta i
  case mv of
    Bound ty1 -> unify scope (apply env ty1 vs) ty2
    Unbound _ -> do let ty2' = value2term [] ty2
                    ms2 <- getMetaVars [ty2]
                    if i `elem` ms2
                      then tcError (text "Occurs check for" <+> ppMeta i <+> text "in:" $$
                                    nest 2 (ppTerm Unqualified 0 ty2'))
                      else setMeta i (Bound ty2')


-----------------------------------------------------------------------
-- Instantiation and quantification
-----------------------------------------------------------------------

-- | Instantiate the topmost for-alls of the argument type
-- with metavariables
instantiate :: Term -> Sigma -> TcM (Term,Rho)
instantiate t (VClosure env (Prod Implicit x ty1 ty2)) = do
  i <- newMeta (eval env ty1)
  instantiate (App t (ImplArg (Meta i))) (eval ((x,VMeta i [] []):env) ty2)
instantiate t ty = do
  return (t,ty)

skolemise scope (VClosure env (Prod Implicit x arg_ty res_ty)) = do    -- Rule PRPOLY
  sk <- newSkolemTyVar arg_ty
  (sks, res_ty) <- skolemise scope (eval ((x,undefined):env) res_ty)
  return (sk : sks, res_ty)
skolemise scope (VClosure env (Prod Explicit x arg_ty res_ty)) = do    -- Rule PRFUN
  (sks, res_ty) <- if x /= identW
                     then skolemise scope (eval ((x,VGen (length scope) []):env) res_ty)
                     else skolemise scope (eval env                              res_ty)
  return (sks, VClosure env (Prod Explicit x arg_ty (value2term [] res_ty)))
skolemise scope ty                                                     -- Rule PRMONO
  = return ([], ty)

newSkolemTyVar _ = undefined

-- Quantify over the specified type variables (all flexible)
quantify :: Scope -> Term -> [MetaId] -> Rho -> TcM (Term,Sigma)
quantify scope t tvs ty0 = do
  mapM_ bind (tvs `zip` new_bndrs)   -- 'bind' is just a cunning way 
  ty <- zonkTerm ty                  -- of doing the substitution
  return (foldr (Abs Implicit) t new_bndrs
         ,eval [] (foldr (\v ty -> Prod Implicit v typeType ty) ty new_bndrs)
         )
  where
    ty = value2term (scopeVars scope) ty0
    
    used_bndrs = nub (bndrs ty)  -- Avoid quantified type variables in use
    new_bndrs  = take (length tvs) (allBinders \\ used_bndrs)
    bind (i, name) = setMeta i (Bound (Vr name))

    bndrs (Prod _ x t1 t2) = [x] ++ bndrs t1  ++ bndrs t2
    bndrs _                = []

allBinders :: [Ident]    -- a,b,..z, a1, b1,... z1, a2, b2,... 
allBinders = [ identC (BS.pack [x])          | x <- ['a'..'z'] ] ++
             [ identC (BS.pack (x : show i)) | i <- [1 :: Integer ..], x <- ['a'..'z']]


-----------------------------------------------------------------------
-- The Monad
-----------------------------------------------------------------------

type Scope = [(Ident,Value)]

type Sigma = Value
type Rho   = Value	-- No top-level ForAll
type Tau   = Value	-- No ForAlls anywhere

data MetaValue
  = Unbound Sigma
  | Bound   Term
type MetaStore = IntMap.IntMap MetaValue
data TcResult a
  = TcOk   MetaStore a
  | TcFail Doc
newtype TcM a = TcM {unTcM :: MetaStore -> TcResult a}

instance Monad TcM where
  return x = TcM (\ms -> TcOk ms x)
  f >>= g  = TcM (\ms -> case unTcM f ms of
                           TcOk ms x  -> unTcM (g x) ms
                           TcFail msg -> TcFail msg)
  fail     = tcError . text

tcError :: Message -> TcM a
tcError msg = TcM (\ms -> TcFail msg)

runTcM :: TcM a -> Check a
runTcM f = case unTcM f IntMap.empty of
             TcOk _ x -> return x
             TcFail s -> checkError s

newMeta :: Sigma -> TcM MetaId
newMeta ty = TcM (\ms -> let i = IntMap.size ms
                         in TcOk (IntMap.insert i (Unbound ty) ms) i)

getMeta :: MetaId -> TcM MetaValue
getMeta i = TcM (\ms -> 
  case IntMap.lookup i ms of
    Just mv -> TcOk ms mv
    Nothing -> TcFail (text "Unknown metavariable" <+> ppMeta i))

setMeta :: MetaId -> MetaValue -> TcM ()
setMeta i mv = TcM (\ms -> TcOk (IntMap.insert i mv ms) ())

newVar :: Scope -> Ident
newVar scope = head [x | i <- [1..], 
                         let x = identC (BS.pack ('v':show i)), 
                         isFree scope x]
  where
    isFree []            x = True
    isFree ((y,_):scope) x = x /= y && isFree scope x

scopeEnv  scope = zipWith (\(x,ty) i -> (x,VGen i [])) (reverse scope) [0..]
scopeVars scope = map fst scope

-- | This function takes account of zonking, and returns a set
-- (no duplicates) of unbound meta-type variables
getMetaVars :: [Sigma] -> TcM [MetaId]
getMetaVars tys = do
  tys <- mapM (zonkTerm . value2term []) tys
  return (foldr go [] tys)
  where
    -- Get the MetaIds from a term; no duplicates in result
    go (Vr tv)    acc = acc 
    go (Meta i)   acc
	  | i `elem` acc  = acc
	  | otherwise	  = i : acc
    go (Q _)      acc = acc
    go (QC _)     acc = acc
    go (Sort _)   acc = acc
    go (Prod _ _ arg res) acc = go arg (go res acc)
    go t acc = error ("go "++show t)

-- | This function takes account of zonking, and returns a set
-- (no duplicates) of free type variables
getFreeTyVars :: [Sigma] -> TcM [Ident]
getFreeTyVars tys = do
  tys <- mapM (zonkTerm . value2term []) tys
  return (foldr (go []) [] tys)
  where 
    go bound (Vr tv)            acc 
	  | tv `elem` bound             = acc
	  | tv `elem` acc               = acc
	  | otherwise                   = tv : acc
    go bound (Meta _)           acc = acc
    go bound (Q _)              acc = acc
    go bound (QC _)             acc = acc
    go bound (Prod _ x arg res) acc = go bound arg (go (x : bound) res acc)

-- | Eliminate any substitutions in a term
zonkTerm :: Term -> TcM Term
zonkTerm (Prod bt x t1 t2) = do 
  t1 <- zonkTerm t1
  t2 <- zonkTerm t2
  return (Prod bt x t1 t2)
zonkTerm (Q  n) = return (Q n)
zonkTerm (QC n) = return (QC n)
zonkTerm (EInt n) = return (EInt n)
zonkTerm (EFloat f) = return (EFloat f)
zonkTerm (K s) = return (K s)
zonkTerm (Empty) = return (Empty)
zonkTerm (Sort s) = return (Sort s)
zonkTerm (App arg res) = do
  arg <- zonkTerm arg 
  res <- zonkTerm res
  return (App arg res)
zonkTerm (Abs bt x body) = do
  body <- zonkTerm body
  return (Abs bt x body)
zonkTerm (Typed body ty) = do
  body <- zonkTerm body 
  ty   <- zonkTerm ty
  return (Typed body ty)
zonkTerm (Vr x) = return (Vr x)
zonkTerm (Meta i) = do
  mv <- getMeta i
  case mv of
    Unbound _ -> return (Meta i)
    Bound t   -> do t <- zonkTerm t
                    setMeta i (Bound t)       -- "Short out" multiple hops
                    return t
zonkTerm (ImplArg t) = do
  t <- zonkTerm t
  return (ImplArg t)
zonkTerm (FV ts) = do
  ts <- mapM zonkTerm ts
  return (FV ts)
zonkTerm t = error ("zonkTerm "++show t)
