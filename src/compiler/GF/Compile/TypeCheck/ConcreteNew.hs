module GF.Compile.TypeCheck.ConcreteNew( checkLType, inferLType ) where

-- The code here is based on the paper:
-- Simon Peyton Jones, Dimitrios Vytiniotis, Stephanie Weirich.
-- Practical type inference for arbitrary-rank types.
-- 14 September 2011

import GF.Grammar hiding (Env, VGen, VApp, VRecType)
import GF.Grammar.Lookup
import GF.Grammar.Predef
import GF.Grammar.Lockfield
import GF.Compile.Compute.ConcreteNew
import GF.Compile.Compute.Predef(predef)
import GF.Compile.TypeCheck.Primitives
import GF.Infra.CheckM
--import GF.Infra.UseIO
import GF.Data.Operations
import Control.Applicative(Applicative(..))
import Control.Monad(ap)

import GF.Text.Pretty
import Data.List (nub, (\\), tails)
import qualified Data.IntMap as IntMap

checkLType :: GlobalEnv -> Term -> Type -> Check (Term, Type)
checkLType ge t ty = runTcM $ do
  vty <- runErr (eval ge ty)
  t <- checkSigma ge [] t vty
  t <- zonkTerm t
  return (t,ty)

inferLType :: GlobalEnv -> Term -> Check (Term, Type)
inferLType ge@(GE _ _ _ gloc) t = runTcM $ do
  (t,ty) <- inferSigma ge [] t
  t  <- zonkTerm t
  ty <- zonkTerm (value2term gloc [] ty)
  return (t,ty)

inferSigma :: GlobalEnv -> Scope -> Term -> TcM (Term,Sigma)
inferSigma ge scope t = do                                      -- GEN1
  (t,ty) <- tcRho ge scope t Nothing
  let GE _ _ _ loc = ge
  env_tvs <- getMetaVars loc (scopeTypes scope)
  res_tvs <- getMetaVars loc [(scope,ty)]
  let forall_tvs = res_tvs \\ env_tvs
  quantify ge scope t forall_tvs ty

checkSigma :: GlobalEnv -> Scope -> Term -> Sigma -> TcM Term
checkSigma ge scope t sigma = do                                -- GEN2
  (abs, scope, t, rho) <- skolemise id scope t sigma
  let skol_tvs = []
  (t,rho) <- tcRho ge scope t (Just rho)
  let GE _ _ _ loc = ge
  esc_tvs <- getFreeVars loc ((scope,sigma) : scopeTypes scope)
  let bad_tvs = filter (`elem` esc_tvs) skol_tvs
  if null bad_tvs
    then return (abs t)
    else tcError (pp "Type not polymorphic enough")

Just vtypeInt   = fmap (flip VApp []) (predef cInt)
Just vtypeFloat = fmap (flip VApp []) (predef cFloat)
vtypeStr   = VSort cStr
vtypeStrs  = VSort cStrs
vtypeType  = VSort cType
vtypePType = VSort cPType

tcRho :: GlobalEnv -> Scope -> Term -> Maybe Rho -> TcM (Term, Rho)
tcRho ge scope t@(EInt _)   mb_ty = instSigma ge scope t vtypeInt   mb_ty
tcRho ge scope t@(EFloat _) mb_ty = instSigma ge scope t vtypeFloat mb_ty
tcRho ge scope t@(K _)      mb_ty = instSigma ge scope t vtypeStr   mb_ty
tcRho ge scope t@(Empty)    mb_ty = instSigma ge scope t vtypeStr   mb_ty
tcRho ge scope t@(Vr v)     mb_ty = do                          -- VAR
  case lookup v scope of
    Just v_sigma -> instSigma ge scope t v_sigma mb_ty
    Nothing      -> tcError ("Unknown variable" <+> v)
tcRho ge scope t@(Q id)     mb_ty =
  let GE gr _ _ _ = ge
  in case lookupResType gr id of
       Ok ty   -> do vty <- runErr (eval ge ty)
                     instSigma ge scope t vty mb_ty
       Bad err -> tcError (pp err)
tcRho ge scope t@(QC id)     mb_ty =
  let GE gr _ _ _ = ge
  in case lookupResType gr id of
       Ok ty   -> do vty <- runErr (eval ge ty)
                     instSigma ge scope t vty mb_ty
       Bad err -> tcError (pp err)
tcRho ge scope (App fun arg) mb_ty = do                         -- APP
  (fun,fun_ty) <- tcRho ge scope fun Nothing
  varg <- runErr (value (toplevel ge) arg)
  let GE _ _ _ loc = ge
  (arg_ty, res_ty) <- unifyFun loc scope (varg (scopeStack scope)) fun_ty
  arg <- checkSigma ge scope arg arg_ty
  instSigma ge scope (App fun arg) res_ty mb_ty
tcRho gr scope (Abs bt var body) Nothing = do                   -- ABS1
  i <- newMeta vtypeType
  let arg_ty = VMeta i (scopeEnv scope) []
  (body,body_ty) <- tcRho gr ((var,arg_ty):scope) body Nothing
  return (Abs bt var body, (VProd bt arg_ty identW (Bind (const body_ty))))
tcRho ge scope (Abs bt var body) (Just ty) = do                 -- ABS2
  let GE _ _ _ loc = ge
  (var_ty, body_ty) <- unifyFun loc scope (VGen (length scope) []) ty
  (body, body_ty) <- tcRho ge ((var,var_ty):scope) body (Just body_ty)
  return (Abs bt var body,ty)
tcRho ge scope (Let (var, (mb_ann_ty, rhs)) body) mb_ty = do    -- LET
  (rhs,var_ty) <- case mb_ann_ty of
                    Nothing     -> inferSigma ge scope rhs
                    Just ann_ty -> do (ann_ty, _) <- tcRho ge scope ann_ty (Just vtypeType)
                                      ov_ann_ty <- runErr (value (toplevel ge) ann_ty)
                                      let v_ann_ty = ov_ann_ty (scopeStack scope)
                                      rhs <- checkSigma ge scope rhs v_ann_ty
                                      return (rhs, v_ann_ty)
  (body, body_ty) <- tcRho ge ((var,var_ty):scope) body mb_ty
  let GE _ _ _ loc = ge
  return (Let (var, (Just (value2term loc (scopeVars scope) var_ty), rhs)) body, body_ty)
tcRho ge scope (Typed body ann_ty) mb_ty = do                   -- ANNOT
  (ann_ty, _) <- tcRho ge scope ann_ty (Just vtypeType)
  ov_ann_ty <- runErr (value (toplevel ge) ann_ty)
  let v_ann_ty = ov_ann_ty (scopeStack scope)
  body <- checkSigma ge scope body v_ann_ty
  instSigma ge scope (Typed body ann_ty) v_ann_ty mb_ty
tcRho ge scope (FV ts) mb_ty = do
  case ts of
    []     -> do i <- newMeta vtypeType
                 instSigma ge scope (FV []) (VMeta i (scopeEnv scope) []) mb_ty
    (t:ts) -> do (t,ty) <- tcRho ge scope t mb_ty
    
                 let go []     ty = return ([],ty)
                     go (t:ts) ty = do (t, ty) <- tcRho ge scope t (Just ty)
                                       (ts,ty) <- go ts ty
                                       return (t:ts,ty)

                 (ts,ty) <- go ts ty
                 return (FV (t:ts), ty)
tcRho ge scope t@(Sort s) mb_ty = do
  instSigma ge scope t vtypeType mb_ty
tcRho ge scope t@(RecType rs) mb_ty = do
  mapM_ (\(l,ty) -> tcRho ge scope ty (Just vtypeType)) rs
  instSigma ge scope t vtypeType mb_ty
tcRho ge scope t@(Table p res) mb_ty = do
  (p,  p_ty)   <- tcRho ge scope p   (Just vtypePType)
  (res,res_ty) <- tcRho ge scope res Nothing
  let GE _ _ _ loc = ge
  subsCheckRho loc scope t res_ty vtypeType
  instSigma ge scope (Table p res) res_ty mb_ty
tcRho ge scope (Prod bt x ty1 ty2) mb_ty = do
  (ty1,ty1_ty) <- tcRho ge scope ty1 (Just vtypeType)
  ov_ty1 <- runErr (value (toplevel ge) ty1)
  let vty1 = ov_ty1 (scopeStack scope)
  (ty2,ty2_ty) <- tcRho ge ((x,vty1):scope) ty2 (Just vtypeType)
  instSigma ge scope (Prod bt x ty1 ty2) vtypeType mb_ty
tcRho ge scope (S t p) mb_ty = do
  p_ty   <- fmap (\i -> VMeta i (scopeEnv scope) []) $ newMeta vtypePType
  res_ty <- fmap (\i -> VMeta i (scopeEnv scope) []) $ newMeta vtypeType
  let t_ty = VTblType p_ty res_ty
  (t,t_ty) <- tcRho ge scope t (Just t_ty)
  p <- checkSigma ge scope p p_ty
  instSigma ge scope (S t p) res_ty mb_ty
tcRho ge scope (T tt ps) mb_ty = do
  p_ty   <- case tt of
              TRaw      -> fmap (\i -> VMeta i (scopeEnv scope) []) $ newMeta vtypePType
              TTyped ty -> do (ty, _) <- tcRho ge scope ty (Just vtypeType)
                              ov_arg <- runErr (value (toplevel ge) ty)
                              return (ov_arg (scopeStack scope))
  res_ty <- fmap (\i -> VMeta i (scopeEnv scope) []) $ newMeta vtypeType
  ps <- mapM (tcCase ge scope p_ty res_ty) ps
  let GE _ _ _ loc = ge
  instSigma ge scope (T (TTyped (value2term loc [] p_ty)) ps) (VTblType p_ty res_ty) mb_ty
tcRho ge scope t@(R rs) mb_ty = do
  let GE _ _ _ loc = ge
  lttys <- case mb_ty of
             Nothing -> inferRecFields ge scope rs
             Just ty -> case ty of
                          VRecType ltys -> checkRecFields ge scope rs ltys
                          VMeta _ _ _   -> inferRecFields ge scope rs
                          _             -> tcError ("Record type is inferred but:" $$
                                                    nest 2 (ppTerm Unqualified 0 (value2term loc (scopeVars scope) ty)) $$
                                                    "is expected in the expresion:" $$
                                                    nest 2 (ppTerm Unqualified 0 t))
  return (R        [(l, (Just (value2term loc (scopeVars scope) ty), t)) | (l,t,ty) <- lttys], 
          VRecType [(l, ty)                                              | (l,t,ty) <- lttys]
         )
tcRho ge scope (P t l) mb_ty = do
  x_ty   <- case mb_ty of
              Just ty -> return ty
              Nothing -> do i <- newMeta vtypeType
                            return (VMeta i (scopeEnv scope) [])
  (t,t_ty) <- tcRho ge scope t (Just (VRecType [(l,x_ty)]))
  return (P t l,x_ty)
tcRho ge scope (C t1 t2) mb_ty = do
  (t1,t1_ty) <- tcRho ge scope t1 (Just vtypeStr)
  (t2,t2_ty) <- tcRho ge scope t2 (Just vtypeStr)
  instSigma ge scope (C t1 t2) vtypeStr mb_ty
tcRho ge scope (Glue t1 t2) mb_ty = do
  (t1,t1_ty) <- tcRho ge scope t1 (Just vtypeStr)
  (t2,t2_ty) <- tcRho ge scope t2 (Just vtypeStr)
  instSigma ge scope (Glue t1 t2) vtypeStr mb_ty
tcRho ge scope t@(ExtR t1 t2) mb_ty = do
  (t1,t1_ty) <- tcRho ge scope t1 Nothing
  (t2,t2_ty) <- tcRho ge scope t2 Nothing
  case (t1_ty,t2_ty) of
    (VSort s1,VSort s2)
       | s1 == cType && s2 == cType -> instSigma ge scope (ExtR t1 t2) (VSort cType) mb_ty
    (VRecType rs1, VRecType rs2) 
       | otherwise                  -> do tcWarn (pp "bbbb")
                                          instSigma ge scope (ExtR t1 t2) (VRecType (rs1 ++ rs2)) mb_ty
    _                               -> tcError ("Cannot type check" <+> ppTerm Unqualified 0 t)
tcRho ge scope (ELin cat t) mb_ty = do  -- this could be done earlier, i.e. in the parser
  tcRho ge scope (ExtR t (R [(lockLabel cat,(Just (RecType []),R []))])) mb_ty
tcRho ge scope (ELincat cat t) mb_ty = do  -- this could be done earlier, i.e. in the parser
  tcRho ge scope (ExtR t (RecType [(lockLabel cat,RecType [])])) mb_ty
tcRho ge scope (Alts t ss) mb_ty = do
  (t,_) <- tcRho ge scope t (Just vtypeStr)
  ss    <- flip mapM ss $ \(t1,t2) -> do
              (t1,_) <- tcRho ge scope t1 (Just vtypeStr)
              (t2,_) <- tcRho ge scope t2 (Just vtypeStrs)
              return (t1,t2)
  instSigma ge scope (Alts t ss) vtypeStr mb_ty
tcRho ge scope (Strs ss) mb_ty = do
  ss <- flip mapM ss $ \t -> do
           (t,_) <- tcRho ge scope t (Just vtypeStr)
           return t
  instSigma ge scope (Strs ss) vtypeStrs mb_ty
tcRho gr scope t _ = error ("tcRho "++show t)

tcCase ge scope p_ty res_ty (p,t) = do
  scope <- tcPatt ge scope p p_ty
  (t,res_ty) <- tcRho ge scope t (Just res_ty)
  return (p,t)

tcPatt ge scope PW        ty0 =
  return scope
tcPatt ge scope (PV x)    ty0 =
  return ((x,ty0):scope)
tcPatt ge scope (PP c ps) ty0 = 
  let GE gr _ _ loc = ge
  in case lookupResType gr c of
       Ok ty  -> do let go scope ty []     = return (scope,ty)
                        go scope ty (p:ps) = do (arg_ty,res_ty) <- unifyFun loc scope (VGen (length scope) []) ty
                                                scope <- tcPatt ge scope p arg_ty
                                                go scope res_ty ps
                    vty <- runErr (eval ge ty)
                    (scope,ty) <- go scope vty ps
                    unify loc scope ty0 ty
                    return scope
       Bad err -> tcError (pp err)
tcPatt ge scope (PString s) ty0 = do
  let GE _ _ _ loc = ge
  unify loc scope ty0 vtypeStr
  return scope
tcPatt ge scope PChar ty0 = do
  let GE _ _ _ loc = ge
  unify loc scope ty0 vtypeStr
  return scope
tcPatt ge scope (PSeq p1 p2) ty0 = do
  let GE _ _ _ loc = ge
  unify loc scope ty0 vtypeStr
  scope <- tcPatt ge scope p1 vtypeStr
  scope <- tcPatt ge scope p2 vtypeStr
  return scope
tcPatt ge scope (PAs x p) ty0 = do
  tcPatt ge ((x,ty0):scope) p ty0
tcPatt ge scope (PR rs) ty0 = do
  let go scope []         = return (scope,[])
      go scope ((l,p):rs) = do i <- newMeta vtypePType
                               let ty = VMeta i (scopeEnv scope) []
                               scope <- tcPatt ge scope p ty
                               (scope,rs) <- go scope rs
                               return (scope,(l,ty) : rs)
  (scope',rs) <- go scope rs
  let GE _ _ _ loc = ge
  unify loc scope ty0 (VRecType rs)
  return scope'
tcPatt gr scope (PAlt p1 p2) ty0 = do
  tcPatt gr scope p1 ty0
  tcPatt gr scope p2 ty0
  return scope
tcPatt ge scope p ty = unimplemented ("tcPatt "++show p)

inferRecFields ge scope rs = 
  mapM (\(l,r) -> tcRecField ge scope l r Nothing) rs

checkRecFields ge scope []          ltys
  | null ltys                            = return []
  | otherwise                            = tcError ("Missing fields:" <+> hsep (map fst ltys))
checkRecFields ge scope ((l,t):lts) ltys =
  case takeIt l ltys of
    (Just ty,ltys) -> do ltty  <- tcRecField ge scope l t (Just ty)
                         lttys <- checkRecFields ge scope lts ltys
                         return (ltty : lttys)
    (Nothing,ltys) -> do tcWarn ("Discarded field:" <+> l)
                         ltty  <- tcRecField ge scope l t Nothing
                         lttys <- checkRecFields ge scope lts ltys
                         return lttys     -- ignore the field
  where
    takeIt l1 []  = (Nothing, [])
    takeIt l1 (lty@(l2,ty):ltys)
      | l1 == l2  = (Just ty,ltys) 
      | otherwise = let (mb_ty,ltys') = takeIt l1 ltys
                    in (mb_ty,lty:ltys')

tcRecField ge scope l (mb_ann_ty,t) mb_ty = do
  (t,ty) <- case mb_ann_ty of
              Just ann_ty -> do (ann_ty, _) <- tcRho ge scope ann_ty (Just vtypeType)
                                ov_ann_ty <- runErr (value (toplevel ge) ann_ty)
                                let v_ann_ty = ov_ann_ty (scopeStack scope)
                                t <- checkSigma ge scope t v_ann_ty
                                instSigma ge scope t v_ann_ty mb_ty
              Nothing     -> tcRho ge scope t mb_ty
  return (l,t,ty)


-- | Invariant: if the third argument is (Just rho),
-- 	            then rho is in weak-prenex form
instSigma :: GlobalEnv -> Scope -> Term -> Sigma -> Maybe Rho -> TcM (Term, Rho)
instSigma ge scope t ty1 Nothing    = instantiate t ty1      -- INST1
instSigma ge scope t ty1 (Just ty2) = do                     -- INST2
  let GE _ _ _ loc = ge
  t <- subsCheckRho loc scope t ty1 ty2
  return (t,ty2)

-- | (subsCheck scope args off exp) checks that 
--     'off' is at least as polymorphic as 'args -> exp'
subsCheck :: GLocation -> Scope -> Term -> Sigma -> Sigma -> TcM Term
subsCheck loc scope t sigma1 sigma2 = do                        -- DEEP-SKOL
  (abs, scope, t, rho2) <- skolemise id scope t sigma2
  let skol_tvs = []
  t <- subsCheckRho loc scope t sigma1 rho2
  esc_tvs <- getFreeVars loc [(scope,sigma1),(scope,sigma2)]
  let bad_tvs = filter (`elem` esc_tvs) skol_tvs
  if null bad_tvs
    then return (abs t)
    else tcError (vcat [pp "Subsumption check failed:",
                        nest 2 (ppTerm Unqualified 0 (value2term loc (scopeVars scope) sigma1)),
                        pp "is not as polymorphic as",
                        nest 2 (ppTerm Unqualified 0 (value2term loc (scopeVars scope) sigma2))])

-- | Invariant: the second argument is in weak-prenex form
subsCheckRho :: GLocation -> Scope -> Term -> Sigma -> Rho -> TcM Term
subsCheckRho loc scope t sigma1@(VProd Implicit _ _ _) rho2 = do        -- Rule SPEC
  (t,rho1) <- instantiate t sigma1
  subsCheckRho loc scope t rho1 rho2
subsCheckRho loc scope t rho1 (VProd Explicit a2 _ (Bind r2)) = do      -- Rule FUN
  (a1,r1) <- unifyFun loc scope (VGen (length scope) []) rho1
  subsCheckFun loc scope t a1 r1 a2 (r2 (VGen (length scope) []))
subsCheckRho loc scope t (VProd Explicit a1 _ (Bind r1)) rho2 = do      -- Rule FUN
  (a2,r2) <- unifyFun loc scope (VGen (length scope) []) rho2
  subsCheckFun loc scope t a1 (r1 (VGen (length scope) [])) a2 r2
subsCheckRho loc scope t (VSort s1) (VSort s2)
  | s1 == cPType && s2 == cType = return t
subsCheckRho loc scope t tau1 tau2 = do                                     -- Rule MONO
  unify loc scope tau1 tau2                                 -- Revert to ordinary unification
  return t

subsCheckFun :: GLocation -> Scope -> Term -> Sigma -> Rho -> Sigma -> Rho -> TcM Term
subsCheckFun loc scope t a1 r1 a2 r2 = do
  let v = newVar scope
  vt <- subsCheck loc scope (Vr v) a2 a1
  t  <- subsCheckRho loc ((v,vtypeType):scope) (App t vt) r1 r2 ;
  return (Abs Explicit v t)


-----------------------------------------------------------------------
-- Unification
-----------------------------------------------------------------------

unifyFun :: GLocation -> Scope -> Value -> Rho -> TcM (Sigma, Rho)
unifyFun loc scope arg_v (VProd Explicit arg x (Bind res)) =
  return (arg,res arg_v)
unifyFun loc scope arg_v tau = do
  arg_ty <- newMeta vtypeType
  res_ty <- newMeta vtypeType
  unify loc scope tau (VProd Explicit (VMeta arg_ty [] []) identW (Bind (const (VMeta arg_ty [] []))))
  return (VMeta arg_ty [] [], VMeta res_ty [] [])

unify loc scope (VApp f1 vs1)      (VApp f2 vs2)
  | f1 == f2                   = sequence_ (zipWith (unify loc scope) vs1 vs2)
unify loc scope (VSort s1)         (VSort s2)
  | s1 == s2                   = return ()
unify loc scope (VGen i vs1)       (VGen j vs2)
  | i == j                     = sequence_ (zipWith (unify loc scope) vs1 vs2)
unify loc scope (VMeta i env1 vs1) (VMeta j env2 vs2)
  | i  == j                    = sequence_ (zipWith (unify loc scope) vs1 vs2)
  | otherwise                  = do mv <- getMeta j
                                    case mv of
                                      --Bound t2  -> unify gr scope (VMeta i env1 vs1) (apply gr env2 t2 vs2)
                                      Unbound _ -> setMeta i (Bound (Meta j))
unify loc scope (VMeta i env vs) v = unifyVar loc scope i env vs v
unify loc scope v (VMeta i env vs) = unifyVar loc scope i env vs v
unify loc scope (VTblType p1 res1) (VTblType p2 res2) = do
  unify loc scope p1   p2
  unify loc scope res1 res2
unify loc scope (VRecType rs1) (VRecType rs2) = do
  sequence_ [unify loc scope ty1 ty2 | (l,ty1) <- rs1, Just ty2 <- [lookup l rs2]]
unify loc scope v1 v2 = do
  t1 <- zonkTerm (value2term loc (scopeVars scope) v1)
  t2 <- zonkTerm (value2term loc (scopeVars scope) v2)
  tcError ("Cannot unify types:" <+> (ppTerm Unqualified 0 t1 $$ 
                                      ppTerm Unqualified 0 t2))

-- | Invariant: tv1 is a flexible type variable
unifyVar :: GLocation -> Scope -> MetaId -> Env -> [Value] -> Tau -> TcM ()
unifyVar loc scope i env vs ty2 = do            -- Check whether i is bound
  mv <- getMeta i
  case mv of
--    Bound ty1 -> unify gr scope (apply gr env ty1 vs) ty2
    Unbound _ -> do let ty2' = value2term loc (scopeVars scope) ty2
                    ms2 <- getMetaVars loc [(scope,ty2)]
                    if i `elem` ms2
                      then tcError ("Occurs check for" <+> ppMeta i <+> "in:" $$
                                    nest 2 (ppTerm Unqualified 0 ty2'))
                      else setMeta i (Bound ty2')

-----------------------------------------------------------------------
-- Instantiation and quantification
-----------------------------------------------------------------------

-- | Instantiate the topmost for-alls of the argument type
-- with metavariables
instantiate :: Term -> Sigma -> TcM (Term,Rho)
instantiate t (VProd Implicit ty1 x (Bind ty2)) = do
  i <- newMeta ty1
  instantiate (App t (ImplArg (Meta i))) (ty2 (VMeta i [] []))
instantiate t ty = do
  return (t,ty)

skolemise f scope t (VProd Implicit arg_ty x (Bind res_ty))   -- Rule PRPOLY
  | x /= identW = 
      let (y,body) = case t of
                       Abs Implicit y body -> (y, body)
                       body                -> (newVar scope, body)
      in skolemise (f . Abs Implicit y)
                   ((y,arg_ty):scope) body
                   (res_ty (VGen (length scope) []))
skolemise f scope t (VProd Explicit arg_ty x (Bind res_ty))   -- Rule PRFUN
  | x /= identW =
      let (y,body) = case t of
                       Abs Explicit y body -> (y, body)
                       body                -> let y = newVar scope
                                              in (y, App body (Vr y))
      in skolemise (f . Abs Explicit y)
                   ((y,arg_ty):scope) body
                   (res_ty (VGen (length scope) []))
skolemise f scope t ty                                        -- Rule PRMONO
  = return (f, scope, t, ty)

-- | Quantify over the specified type variables (all flexible)
quantify :: GlobalEnv -> Scope -> Term -> [MetaId] -> Rho -> TcM (Term,Sigma)
quantify ge scope t tvs ty0 = do
  mapM_ bind (tvs `zip` new_bndrs)   -- 'bind' is just a cunning way 
  ty <- zonkTerm ty                  -- of doing the substitution
  vty <- runErr (eval ge (foldr (\v ty -> Prod Implicit v typeType ty) ty new_bndrs))
  return (foldr (Abs Implicit) t new_bndrs,vty)
  where
    GE _ _ _ loc = ge
    ty = value2term loc (scopeVars scope) ty0

    used_bndrs = nub (bndrs ty)  -- Avoid quantified type variables in use
    new_bndrs  = take (length tvs) (allBinders \\ used_bndrs)
    bind (i, name) = setMeta i (Bound (Vr name))

    bndrs (Prod _ x t1 t2) = [x] ++ bndrs t1  ++ bndrs t2
    bndrs _                = []

allBinders :: [Ident]    -- a,b,..z, a1, b1,... z1, a2, b2,... 
allBinders = [ identS [x]          | x <- ['a'..'z'] ] ++
             [ identS (x : show i) | i <- [1 :: Integer ..], x <- ['a'..'z']]


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
  = TcOk   a MetaStore [Message]
  | TcFail             [Message] -- First msg is error, the rest are warnings?
newtype TcM a = TcM {unTcM :: MetaStore -> [Message] -> TcResult a}

instance Monad TcM where
  return x = TcM (\ms msgs -> TcOk x ms msgs)
  f >>= g  = TcM (\ms msgs -> case unTcM f ms msgs of
                                TcOk x ms msgs -> unTcM (g x) ms msgs
                                TcFail    msgs -> TcFail msgs)
  fail     = tcError . pp

instance Applicative TcM where
  pure = return
  (<*>) = ap

instance Functor TcM where
  fmap f g = TcM (\ms msgs -> case unTcM g ms msgs of
                           TcOk x ms msgs -> TcOk (f x) ms msgs
                           TcFail msgs    -> TcFail msgs)

tcError :: Message -> TcM a
tcError msg = TcM (\ms msgs -> TcFail (msg : msgs))

tcWarn :: Message -> TcM ()
tcWarn msg = TcM (\ms msgs -> TcOk () ms (("Warning:" <+> msg) : msgs))

unimplemented str = fail ("Unimplemented: "++str)

runTcM :: TcM a -> Check a
runTcM f = case unTcM f IntMap.empty [] of
             TcOk x _ msgs -> do checkWarnings msgs; return x
             TcFail (msg:msgs) -> do checkWarnings msgs; checkError msg

runErr :: Err a -> TcM a
runErr (Bad msg) = TcM (\ms msgs -> TcFail (pp msg:msgs))
runErr (Ok x)    = TcM (\ms msgs -> TcOk x ms msgs)

newMeta :: Sigma -> TcM MetaId
newMeta ty = TcM (\ms msgs -> 
  let i = IntMap.size ms
  in TcOk i (IntMap.insert i (Unbound ty) ms) msgs)

getMeta :: MetaId -> TcM MetaValue
getMeta i = TcM (\ms msgs -> 
  case IntMap.lookup i ms of
    Just mv -> TcOk mv ms msgs
    Nothing -> TcFail (("Unknown metavariable" <+> ppMeta i) : msgs))

setMeta :: MetaId -> MetaValue -> TcM ()
setMeta i mv = TcM (\ms msgs -> TcOk () (IntMap.insert i mv ms) msgs)

newVar :: Scope -> Ident
newVar scope = head [x | i <- [1..], 
                         let x = identS ('v':show i),
                         isFree scope x]
  where
    isFree []            x = True
    isFree ((y,_):scope) x = x /= y && isFree scope x

scopeEnv   scope = zipWith (\(x,ty) i -> (x,VGen i [])) (reverse scope) [0..]
scopeStack scope = zipWith (\(x,ty) i -> VGen i []) (reverse scope) [0..]
scopeVars  scope = map fst scope
scopeTypes scope = zipWith (\(_,ty) scope -> (scope,ty)) scope (tails scope)

-- | This function takes account of zonking, and returns a set
-- (no duplicates) of unbound meta-type variables
getMetaVars :: GLocation -> [(Scope,Sigma)] -> TcM [MetaId]
getMetaVars loc sc_tys = do
  tys <- mapM (\(scope,ty) -> zonkTerm (value2term loc (scopeVars scope) ty)) sc_tys
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
    go (Table p t) acc = go p (go t acc)
    go (RecType rs) acc = foldl (\acc (l,ty) -> go ty acc) acc rs
    go t acc = error ("go "++show t)

-- | This function takes account of zonking, and returns a set
-- (no duplicates) of free type variables
getFreeVars :: GLocation -> [(Scope,Sigma)] -> TcM [Ident]
getFreeVars loc sc_tys = do
  tys <- mapM (\(scope,ty) -> zonkTerm (value2term loc (scopeVars scope) ty)) sc_tys
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
    go bound (RecType rs) acc = foldl (\acc (l,ty) -> go bound ty acc) acc rs
    go bound (Table p t)        acc = go bound p (go bound t acc)

-- | Eliminate any substitutions in a term
zonkTerm :: Term -> TcM Term
zonkTerm (Meta i) = do
  mv <- getMeta i
  case mv of
    Unbound _ -> return (Meta i)
    Bound t   -> do t <- zonkTerm t
                    setMeta i (Bound t)       -- "Short out" multiple hops
                    return t
zonkTerm t = composOp zonkTerm t


