module GF.Compile.TypeCheck.ConcreteNew( checkLType, inferLType ) where

import GF.Grammar hiding (Env, VGen, VApp, VRecType)
import GF.Grammar.Lookup
import GF.Grammar.Predef
import GF.Grammar.Lockfield
import GF.Compile.Compute.ConcreteNew1
import GF.Compile.Compute.AppPredefined
import GF.Infra.CheckM
import GF.Infra.UseIO
import GF.Data.Operations

import Text.PrettyPrint
import Data.List (nub, (\\), tails)
import qualified Data.IntMap as IntMap
import qualified Data.ByteString.Char8 as BS

import GF.Grammar.Parser
import System.IO
import Debug.Trace

checkLType :: SourceGrammar -> Term -> Type -> Check (Term, Type)
checkLType gr t ty = runTcM $ do
  t <- checkSigma gr [] t (eval gr [] ty)
  t <- zonkTerm t
  return (t,ty)

inferLType :: SourceGrammar -> Term -> Check (Term, Type)
inferLType gr t = runTcM $ do
  (t,ty) <- inferSigma gr [] t
  t  <- zonkTerm t
  ty <- zonkTerm (value2term gr [] ty)
  return (t,ty)

inferSigma :: SourceGrammar -> Scope -> Term -> TcM (Term,Sigma)
inferSigma gr scope t = do                                      -- GEN1
  (t,ty) <- tcRho gr scope t Nothing
  env_tvs <- getMetaVars gr (scopeTypes scope)
  res_tvs <- getMetaVars gr [(scope,ty)]
  let forall_tvs = res_tvs \\ env_tvs
  quantify gr scope t forall_tvs ty

checkSigma :: SourceGrammar -> Scope -> Term -> Sigma -> TcM Term
checkSigma gr scope t sigma = do                                -- GEN2
  (abs, scope, t, rho) <- skolemise id gr scope t sigma
  let skol_tvs = []
  (t,rho) <- tcRho gr scope t (Just rho)
  esc_tvs <- getFreeVars gr ((scope,sigma) : scopeTypes scope)
  let bad_tvs = filter (`elem` esc_tvs) skol_tvs
  if null bad_tvs
    then return (abs t)
    else tcError (text "Type not polymorphic enough")

tcRho :: SourceGrammar -> Scope -> Term -> Maybe Rho -> TcM (Term, Rho)
tcRho gr scope t@(EInt _)   mb_ty = instSigma gr scope t (eval gr [] typeInt)   mb_ty
tcRho gr scope t@(EFloat _) mb_ty = instSigma gr scope t (eval gr [] typeFloat) mb_ty
tcRho gr scope t@(K _)      mb_ty = instSigma gr scope t (eval gr [] typeStr)   mb_ty
tcRho gr scope t@(Empty)    mb_ty = instSigma gr scope t (eval gr [] typeStr)   mb_ty
tcRho gr scope t@(Vr v)     mb_ty = do                          -- VAR
  case lookup v scope of
    Just v_sigma -> instSigma gr scope t v_sigma mb_ty
    Nothing      -> tcError (text "Unknown variable" <+> ppIdent v)
tcRho gr scope t@(Q id)     mb_ty
  | elem (fst id) [cPredef,cPredefAbs] = 
      case typPredefined (snd id) of
        Just ty -> instSigma gr scope t (eval gr [] ty) mb_ty
        Nothing -> tcError (text "unknown in Predef:" <+> ppQIdent Qualified id)
  | otherwise = do
      case lookupResType gr id of
        Ok ty   -> instSigma gr scope t (eval gr [] ty) mb_ty
        Bad err -> tcError (text err)
tcRho gr scope t@(QC id)     mb_ty = do
  case lookupResType gr id of
    Ok ty   -> instSigma gr scope t (eval gr [] ty) mb_ty
    Bad err -> tcError (text err)
tcRho gr scope (App fun arg) mb_ty = do                         -- APP
  (fun,fun_ty) <- tcRho gr scope fun Nothing
  (arg_ty, res_ty) <- unifyFun gr scope (eval gr (scopeEnv scope) arg) fun_ty
  arg <- checkSigma gr scope arg arg_ty
  instSigma gr scope (App fun arg) res_ty mb_ty
tcRho gr scope (Abs bt var body) Nothing = do                   -- ABS1
  i <- newMeta (eval gr [] typeType)
  (body,body_ty) <- tcRho gr ((var,VMeta i (scopeEnv scope) []):scope) body Nothing
  return (Abs bt var body, (VClosure (scopeEnv scope)
                                     (Prod bt identW (Meta i) (value2term gr (scopeVars scope) body_ty))))
tcRho gr scope (Abs bt var body) (Just ty) = do                 -- ABS2
  (var_ty, body_ty) <- unifyFun gr scope (VGen (length scope) []) ty 
  (body, body_ty) <- tcRho gr ((var,var_ty):scope) body (Just body_ty)
  return (Abs bt var body,ty)
tcRho gr scope (Let (var, (mb_ann_ty, rhs)) body) mb_ty = do    -- LET
  (rhs,var_ty) <- case mb_ann_ty of
                    Nothing     -> inferSigma gr scope rhs
                    Just ann_ty -> do (ann_ty, _) <- tcRho gr scope ann_ty (Just (eval gr [] typeType))
                                      let v_ann_ty = eval gr (scopeEnv scope) ann_ty
                                      rhs <- checkSigma gr scope rhs v_ann_ty
                                      return (rhs, v_ann_ty)
  (body, body_ty) <- tcRho gr ((var,var_ty):scope) body mb_ty
  return (Let (var, (Just (value2term gr (scopeVars scope) var_ty), rhs)) body, body_ty)
tcRho gr scope (Typed body ann_ty) mb_ty = do                   -- ANNOT
  (ann_ty, _) <- tcRho gr scope ann_ty (Just (eval gr [] typeType))
  let v_ann_ty = eval gr (scopeEnv scope) ann_ty
  body <- checkSigma gr scope body v_ann_ty
  instSigma gr scope (Typed body ann_ty) v_ann_ty mb_ty
tcRho gr scope (FV ts) mb_ty = do
  case ts of
    []     -> do i <- newMeta (eval gr [] typeType)
                 instSigma gr scope (FV []) (VMeta i (scopeEnv scope) []) mb_ty
    (t:ts) -> do (t,ty) <- tcRho gr scope t mb_ty
    
                 let go []     ty = return ([],ty)
                     go (t:ts) ty = do (t, ty) <- tcRho gr scope t (Just ty)
                                       (ts,ty) <- go ts ty
                                       return (t:ts,ty)
                  
                 (ts,ty) <- go ts ty
                 return (FV (t:ts), ty)
tcRho gr scope t@(Sort s) mb_ty = do
  instSigma gr scope t (eval gr [] typeType) mb_ty
tcRho gr scope t@(RecType rs) mb_ty = do
  mapM_ (\(l,ty) -> tcRho gr scope ty (Just (eval gr [] typeType))) rs
  instSigma gr scope t (eval gr [] typeType) mb_ty
tcRho gr scope t@(Table p res) mb_ty = do
  (p,  p_ty)   <- tcRho gr scope p   (Just (eval gr [] typePType))
  (res,res_ty) <- tcRho gr scope res Nothing
  subsCheckRho gr scope t res_ty (eval gr [] typeType)
  instSigma gr scope (Table p res) res_ty mb_ty
tcRho gr scope (Prod bt x ty1 ty2) mb_ty = do
  (ty1,ty1_ty) <- tcRho gr scope ty1 (Just (eval gr [] typeType))
  (ty2,ty2_ty) <- tcRho gr ((x,eval gr (scopeEnv scope) ty1):scope) ty2 (Just (eval gr [] typeType))
  instSigma gr scope (Prod bt x ty1 ty2) (eval gr [] typeType) mb_ty
tcRho gr scope (S t p) mb_ty = do
  p_ty   <- fmap Meta $ newMeta (eval gr [] typePType)
  res_ty <- fmap Meta $ newMeta (eval gr [] typeType)
  let t_ty = eval gr (scopeEnv scope) (Table p_ty res_ty)
  (t,t_ty) <- tcRho gr scope t (Just t_ty)
  p <- checkSigma gr scope p (eval gr (scopeEnv scope) p_ty)
  instSigma gr scope (S t p) (eval gr (scopeEnv scope) res_ty) mb_ty
tcRho gr scope (T tt ps) mb_ty = do
  p_ty   <- case tt of
              TRaw      -> fmap Meta $ newMeta (eval gr [] typePType)
              TTyped ty -> do (ty, _) <- tcRho gr scope ty (Just (eval gr [] typeType))
                              return ty
  res_ty <- fmap Meta $ newMeta (eval gr [] typeType)
  ps <- mapM (tcCase gr scope (eval gr (scopeEnv scope) p_ty) (eval gr (scopeEnv scope) res_ty)) ps
  instSigma gr scope (T (TTyped p_ty) ps) (eval gr (scopeEnv scope) (Table p_ty res_ty)) mb_ty
tcRho gr scope t@(R rs) mb_ty = do
  lttys <- case mb_ty of
             Nothing -> inferRecFields gr scope rs
             Just ty -> case ty of
                          VRecType ltys -> checkRecFields gr scope rs ltys
                          VMeta _ _ _   -> inferRecFields gr scope rs
                          _             -> tcError (text "Record type is inferred but:" $$
                                                    nest 2 (ppTerm Unqualified 0 (value2term gr (scopeVars scope) ty)) $$
                                                    text "is expected in the expresion:" $$
                                                    nest 2 (ppTerm Unqualified 0 t))
  return (R        [(l, (Just (value2term gr (scopeVars scope) ty), t)) | (l,t,ty) <- lttys], 
          VRecType [(l, ty)                                             | (l,t,ty) <- lttys]
         )
tcRho gr scope (P t l) mb_ty = do
  x_ty   <- case mb_ty of
              Just ty -> return ty
              Nothing -> do i <- newMeta (eval gr [] typeType)
                            return (VMeta i (scopeEnv scope) [])
  (t,t_ty) <- tcRho gr scope t (Just (VRecType [(l,x_ty)]))
  return (P t l,x_ty)
tcRho gr scope (C t1 t2) mb_ty = do
  (t1,t1_ty) <- tcRho gr scope t1 (Just (eval gr [] typeStr))
  (t2,t2_ty) <- tcRho gr scope t2 (Just (eval gr [] typeStr))
  instSigma gr scope (C t1 t2) (eval gr [] typeStr) mb_ty
tcRho gr scope (Glue t1 t2) mb_ty = do
  (t1,t1_ty) <- tcRho gr scope t1 (Just (eval gr [] typeStr))
  (t2,t2_ty) <- tcRho gr scope t2 (Just (eval gr [] typeStr))
  instSigma gr scope (Glue t1 t2) (eval gr [] typeStr) mb_ty
tcRho gr scope t@(ExtR t1 t2) mb_ty = do
  (t1,t1_ty) <- tcRho gr scope t1 Nothing
  (t2,t2_ty) <- tcRho gr scope t2 Nothing
  case (t1_ty,t2_ty) of
    (VSort s1,VSort s2)
       | s1 == cType && s2 == cType -> instSigma gr scope (ExtR t1 t2) (VSort cType) mb_ty
    (VRecType rs1, VRecType rs2) 
       | otherwise                  -> do tcWarn (text "bbbb")
                                          instSigma gr scope (ExtR t1 t2) (VRecType (rs1 ++ rs2)) mb_ty
    _                               -> tcError (text "Cannot type check" <+> ppTerm Unqualified 0 t)
tcRho gr scope (ELin cat t) mb_ty = do  -- this could be done earlier, i.e. in the parser
  tcRho gr scope (ExtR t (R [(lockLabel cat,(Just (RecType []),R []))])) mb_ty
tcRho gr scope (ELincat cat t) mb_ty = do  -- this could be done earlier, i.e. in the parser
  tcRho gr scope (ExtR t (RecType [(lockLabel cat,RecType [])])) mb_ty
tcRho gr scope (Alts t ss) mb_ty = do
  (t,_) <- tcRho gr scope t (Just (eval gr [] typeStr))
  ss    <- flip mapM ss $ \(t1,t2) -> do
              (t1,_) <- tcRho gr scope t1 (Just (eval gr [] typeStr))
              (t2,_) <- tcRho gr scope t2 (Just (eval gr [] typeStrs))
              return (t1,t2)
  instSigma gr scope (Alts t ss) (eval gr [] typeStr) mb_ty
tcRho gr scope (Strs ss) mb_ty = do
  ss <- flip mapM ss $ \t -> do
           (t,_) <- tcRho gr scope t (Just (eval gr [] typeStr))
           return t
  instSigma gr scope (Strs ss) (eval gr [] typeStrs) mb_ty
tcRho gr scope t _ = error ("tcRho "++show t)

tcCase gr scope p_ty res_ty (p,t) = do
  scope <- tcPatt gr scope p p_ty
  (t,res_ty) <- tcRho gr scope t (Just res_ty)
  return (p,t)

tcPatt gr scope PW        ty0 =
  return scope
tcPatt gr scope (PV x)    ty0 =
  return ((x,ty0):scope)
tcPatt gr scope (PP c ps) ty0 = 
  case lookupResType gr c of
    Ok ty  -> do let go scope ty []     = return (scope,ty)
                     go scope ty (p:ps) = do (arg_ty,res_ty) <- unifyFun gr scope (VGen (length scope) []) ty
                                             scope <- tcPatt gr scope p arg_ty
                                             go scope res_ty ps
                 (scope,ty) <- go scope (eval gr [] ty) ps
                 unify gr scope ty0 ty
                 return scope
    Bad err -> tcError (text err)
tcPatt gr scope (PString s) ty0 = do
  unify gr scope ty0 (eval gr [] typeStr)
  return scope
tcPatt gr scope PChar ty0 = do
  unify gr scope ty0 (eval gr [] typeStr)
  return scope
tcPatt gr scope (PSeq p1 p2) ty0 = do
  unify gr scope ty0 (eval gr [] typeStr)
  scope <- tcPatt gr scope p1 (eval gr [] typeStr)
  scope <- tcPatt gr scope p2 (eval gr [] typeStr)
  return scope
tcPatt gr scope (PAs x p) ty0 = do
  tcPatt gr ((x,ty0):scope) p ty0
tcPatt gr scope (PR rs) ty0 = do
  let go scope []         = return (scope,[])
      go scope ((l,p):rs) = do i <- newMeta (eval gr [] typePType)
                               let ty = VMeta i (scopeEnv scope) []
                               scope <- tcPatt gr scope p ty
                               (scope,rs) <- go scope rs
                               return (scope,(l,ty) : rs)
  (scope',rs) <- go scope rs
  unify gr scope ty0 (VRecType rs)
  return scope'
tcPatt gr scope (PAlt p1 p2) ty0 = do
  tcPatt gr scope p1 ty0
  tcPatt gr scope p2 ty0
  return scope
tcPatt gr scope p ty = unimplemented ("tcPatt "++show p)


inferRecFields gr scope rs = 
  mapM (\(l,r) -> tcRecField gr scope l r Nothing) rs

checkRecFields gr scope []          ltys
  | null ltys                            = return []
  | otherwise                            = tcError (text "Missing fields:" <+> hsep (map (ppLabel . fst) ltys))
checkRecFields gr scope ((l,t):lts) ltys =
  case takeIt l ltys of
    (Just ty,ltys) -> do ltty  <- tcRecField gr scope l t (Just ty)
                         lttys <- checkRecFields gr scope lts ltys
                         return (ltty : lttys)
    (Nothing,ltys) -> do tcWarn (text "Discarded field:" <+> ppLabel l)
                         ltty  <- tcRecField gr scope l t Nothing
                         lttys <- checkRecFields gr scope lts ltys
                         return lttys     -- ignore the field
  where
    takeIt l1 []  = (Nothing, [])
    takeIt l1 (lty@(l2,ty):ltys)
      | l1 == l2  = (Just ty,ltys) 
      | otherwise = let (mb_ty,ltys') = takeIt l1 ltys
                    in (mb_ty,lty:ltys')

tcRecField gr scope l (mb_ann_ty,t) mb_ty = do
  (t,ty) <- case mb_ann_ty of
              Just ann_ty -> do (ann_ty, _) <- tcRho gr scope ann_ty (Just (eval gr [] typeType))
                                let v_ann_ty = eval gr (scopeEnv scope) ann_ty
                                t <- checkSigma gr scope t v_ann_ty
                                instSigma gr scope t v_ann_ty mb_ty
              Nothing     -> tcRho gr scope t mb_ty
  return (l,t,ty)


-- | Invariant: if the third argument is (Just rho),
-- 	            then rho is in weak-prenex form
instSigma :: SourceGrammar -> Scope -> Term -> Sigma -> Maybe Rho -> TcM (Term, Rho)
instSigma gr scope t ty1 Nothing    = instantiate gr t ty1      -- INST1
instSigma gr scope t ty1 (Just ty2) = do                        -- INST2
  t <- subsCheckRho gr scope t ty1 ty2
  return (t,ty2)

-- | (subsCheck scope args off exp) checks that 
--     'off' is at least as polymorphic as 'args -> exp'
subsCheck :: SourceGrammar -> Scope -> Term -> Sigma -> Sigma -> TcM Term
subsCheck gr scope t sigma1 sigma2 = do                        -- DEEP-SKOL
  (abs, scope, t, rho2) <- skolemise id gr scope t sigma2
  let skol_tvs = []
  t <- subsCheckRho gr scope t sigma1 rho2
  esc_tvs <- getFreeVars gr [(scope,sigma1),(scope,sigma2)]
  let bad_tvs = filter (`elem` esc_tvs) skol_tvs
  if null bad_tvs
    then return (abs t)
    else tcError (vcat [text "Subsumption check failed:",
                        nest 2 (ppTerm Unqualified 0 (value2term gr (scopeVars scope) sigma1)),
                        text "is not as polymorphic as",
                        nest 2 (ppTerm Unqualified 0 (value2term gr (scopeVars scope) sigma2))])


-- | Invariant: the second argument is in weak-prenex form
subsCheckRho :: SourceGrammar -> Scope -> Term -> Sigma -> Rho -> TcM Term
subsCheckRho gr scope t sigma1@(VClosure env (Prod Implicit _ _ _)) rho2 = do   -- Rule SPEC
  (t,rho1) <- instantiate gr t sigma1
  subsCheckRho gr scope t rho1 rho2
subsCheckRho gr scope t rho1 (VClosure env (Prod Explicit _ a2 r2)) = do        -- Rule FUN
  (a1,r1) <- unifyFun gr scope (VGen (length scope) []) rho1
  subsCheckFun gr scope t a1 r1 (eval gr env a2) (eval gr env r2)
subsCheckRho gr scope t (VClosure env (Prod Explicit _ a1 r1)) rho2 = do        -- Rule FUN
  (a2,r2) <- unifyFun gr scope (VGen (length scope) []) rho2
  subsCheckFun gr scope t (eval gr env a1) (eval gr env r1) a2 r2
subsCheckRho gr scope t (VSort s1) (VSort s2)
  | s1 == cPType && s2 == cType = return t
subsCheckRho gr scope t tau1 tau2 = do                                          -- Rule MONO
  unify gr scope tau1 tau2                                 -- Revert to ordinary unification
  return t

subsCheckFun :: SourceGrammar -> Scope -> Term -> Sigma -> Rho -> Sigma -> Rho -> TcM Term
subsCheckFun gr scope t a1 r1 a2 r2 = do
  let v = newVar scope
  vt <- subsCheck gr scope (Vr v) a2 a1
  t  <- subsCheckRho gr ((v,eval gr [] typeType):scope) (App t vt) r1 r2 ;
  return (Abs Explicit v t)


-----------------------------------------------------------------------
-- Unification
-----------------------------------------------------------------------

unifyFun :: SourceGrammar -> Scope -> Value -> Rho -> TcM (Sigma, Rho)
unifyFun gr scope arg_v (VClosure env (Prod Explicit x arg res))
  | x /= identW = return (eval gr env arg,eval gr ((x,arg_v):env) res)
  | otherwise   = return (eval gr env arg,eval gr            env  res)
unifyFun gr scope arg_v tau = do
  arg_ty <- newMeta (eval gr [] typeType)
  res_ty <- newMeta (eval gr [] typeType)
  unify gr scope tau (VClosure [] (Prod Explicit identW (Meta arg_ty) (Meta res_ty)))
  return (VMeta arg_ty [] [], VMeta res_ty [] [])

unify gr scope (VApp f1 vs1)      (VApp f2 vs2)
  | f1 == f2                   = sequence_ (zipWith (unify gr scope) vs1 vs2)
unify gr scope (VSort s1)         (VSort s2)
  | s1 == s2                   = return ()
unify gr scope (VGen i vs1)       (VGen j vs2)
  | i == j                     = sequence_ (zipWith (unify gr scope) vs1 vs2)
unify gr scope (VMeta i env1 vs1) (VMeta j env2 vs2)
  | i  == j                    = sequence_ (zipWith (unify gr scope) vs1 vs2)
  | otherwise                  = do mv <- getMeta j
                                    case mv of
                                      Bound t2  -> unify gr scope (VMeta i env1 vs1) (apply gr env2 t2 vs2)
                                      Unbound _ -> setMeta i (Bound (Meta j))
unify gr scope (VMeta i env vs) v = unifyVar gr scope i env vs v
unify gr scope v (VMeta i env vs) = unifyVar gr scope i env vs v
unify gr scope (VTblType p1 res1) (VTblType p2 res2) = do
  unify gr scope p1   p2
  unify gr scope res1 res2
unify gr scope (VRecType rs1) (VRecType rs2) = do
  sequence_ [unify gr scope ty1 ty2 | (l,ty1) <- rs1, Just ty2 <- [lookup l rs2]]
unify gr scope v1 v2 = do
  t1 <- zonkTerm (value2term gr (scopeVars scope) v1)
  t2 <- zonkTerm (value2term gr (scopeVars scope) v2)
  tcError (text "Cannot unify types:" <+> (ppTerm Unqualified 0 t1 $$ 
                                           ppTerm Unqualified 0 t2))

-- | Invariant: tv1 is a flexible type variable
unifyVar :: SourceGrammar -> Scope -> MetaId -> Env -> [Value] -> Tau -> TcM ()
unifyVar gr scope i env vs ty2 = do            -- Check whether i is bound
  mv <- getMeta i
  case mv of
    Bound ty1 -> unify gr scope (apply gr env ty1 vs) ty2
    Unbound _ -> do let ty2' = value2term gr (scopeVars scope) ty2
                    ms2 <- getMetaVars gr [(scope,ty2)]
                    if i `elem` ms2
                      then tcError (text "Occurs check for" <+> ppMeta i <+> text "in:" $$
                                    nest 2 (ppTerm Unqualified 0 ty2'))
                      else setMeta i (Bound ty2')


-----------------------------------------------------------------------
-- Instantiation and quantification
-----------------------------------------------------------------------

-- | Instantiate the topmost for-alls of the argument type
-- with metavariables
instantiate :: SourceGrammar -> Term -> Sigma -> TcM (Term,Rho)
instantiate gr t (VClosure env (Prod Implicit x ty1 ty2)) = do
  i <- newMeta (eval gr env ty1)
  instantiate gr (App t (ImplArg (Meta i))) (eval gr ((x,VMeta i [] []):env) ty2)
instantiate gr t ty = do
  return (t,ty)

skolemise f gr scope t (VClosure env (Prod Implicit x arg_ty res_ty))   -- Rule PRPOLY
  | x /= identW = 
      let (y,body) = case t of
                       Abs Implicit y body -> (y, body)
                       body                -> (newVar scope, body)
      in skolemise (f . Abs Implicit y)
                   gr
                   ((y,eval gr env arg_ty):scope) body
                   (eval gr ((x,VGen (length scope) []):env) res_ty)
skolemise f gr scope t (VClosure env (Prod Explicit x arg_ty res_ty))   -- Rule PRFUN
  | x /= identW = 
      let (y,body) = case t of
                       Abs Explicit y body -> (y, body)
                       body                -> let y = newVar scope
                                              in (y, App body (Vr y))
      in skolemise (f . Abs Explicit y)
                   gr
                   ((y,eval gr env arg_ty):scope) body
                   (eval gr ((x,VGen (length scope) []):env) res_ty)
skolemise f gr scope t ty                                               -- Rule PRMONO
  = return (f, scope, t, ty)


-- | Quantify over the specified type variables (all flexible)
quantify :: SourceGrammar -> Scope -> Term -> [MetaId] -> Rho -> TcM (Term,Sigma)
quantify gr scope t tvs ty0 = do
  mapM_ bind (tvs `zip` new_bndrs)   -- 'bind' is just a cunning way 
  ty <- zonkTerm ty                  -- of doing the substitution
  return (foldr (Abs Implicit) t new_bndrs
         ,eval gr [] (foldr (\v ty -> Prod Implicit v typeType ty) ty new_bndrs)
         )
  where
    ty = value2term gr (scopeVars scope) ty0
    
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
  = TcOk   a MetaStore [Message]
  | TcFail             [Message] -- First msg is error, the rest are warnings?
newtype TcM a = TcM {unTcM :: MetaStore -> [Message] -> TcResult a}

instance Monad TcM where
  return x = TcM (\ms msgs -> TcOk x ms msgs)
  f >>= g  = TcM (\ms msgs -> case unTcM f ms msgs of
                                TcOk x ms msgs -> unTcM (g x) ms msgs
                                TcFail    msgs -> TcFail msgs)
  fail     = tcError . text

instance Functor TcM where
  fmap f g = TcM (\ms msgs -> case unTcM g ms msgs of
                           TcOk x ms msgs -> TcOk (f x) ms msgs
                           TcFail msgs    -> TcFail msgs)

tcError :: Message -> TcM a
tcError msg = TcM (\ms msgs -> TcFail (msg : msgs))

tcWarn :: Message -> TcM ()
tcWarn msg = TcM (\ms msgs -> TcOk () ms ((text "Warning:" <+> msg) : msgs))

unimplemented str = fail ("Unimplemented: "++str)

runTcM :: TcM a -> Check a
runTcM f = case unTcM f IntMap.empty [] of
             TcOk x _ msgs -> do checkWarnings msgs; return x
             TcFail (msg:msgs) -> do checkWarnings msgs; checkError msg

newMeta :: Sigma -> TcM MetaId
newMeta ty = TcM (\ms msgs -> 
  let i = IntMap.size ms
  in TcOk i (IntMap.insert i (Unbound ty) ms) msgs)

getMeta :: MetaId -> TcM MetaValue
getMeta i = TcM (\ms msgs -> 
  case IntMap.lookup i ms of
    Just mv -> TcOk mv ms msgs
    Nothing -> TcFail ((text "Unknown metavariable" <+> ppMeta i) : msgs))

setMeta :: MetaId -> MetaValue -> TcM ()
setMeta i mv = TcM (\ms msgs -> TcOk () (IntMap.insert i mv ms) msgs)

newVar :: Scope -> Ident
newVar scope = head [x | i <- [1..], 
                         let x = identC (BS.pack ('v':show i)), 
                         isFree scope x]
  where
    isFree []            x = True
    isFree ((y,_):scope) x = x /= y && isFree scope x

scopeEnv   scope = zipWith (\(x,ty) i -> (x,VGen i [])) (reverse scope) [0..]
scopeVars  scope = map fst scope
scopeTypes scope = zipWith (\(_,ty) scope -> (scope,ty)) scope (tails scope)

-- | This function takes account of zonking, and returns a set
-- (no duplicates) of unbound meta-type variables
getMetaVars :: SourceGrammar -> [(Scope,Sigma)] -> TcM [MetaId]
getMetaVars gr sc_tys = do
  tys <- mapM (\(scope,ty) -> zonkTerm (value2term gr (scopeVars scope) ty)) sc_tys
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
getFreeVars :: SourceGrammar -> [(Scope,Sigma)] -> TcM [Ident]
getFreeVars gr sc_tys = do
  tys <- mapM (\(scope,ty) -> zonkTerm (value2term gr (scopeVars scope) ty)) sc_tys
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

