-- | Functions for computing the values of terms in the concrete syntax, in
-- | preparation for PMCFG generation.
module GF.Compile.Compute.ConcreteNew
           ( normalForm
           , Value(..), Env, eval, apply, value2term
           ) where

import GF.Grammar hiding (Env, VGen, VApp, VRecType)
import GF.Grammar.Lookup(lookupResDef,allParamValues)
import GF.Grammar.Predef(cPredef,cErrorType,cTok,cStr)
import GF.Grammar.PatternMatch(matchPattern)
import GF.Grammar.Lockfield(unlockRecord,lockLabel,isLockLabel)
import GF.Compile.Compute.Value
import GF.Compile.Compute.Predef(predefs)
import GF.Data.Str(Str,glueStr,str2strings,str,sstr,plusStr,strTok)
import GF.Data.Operations(Err,err,maybeErr,combinations)
import GF.Data.Utilities(mapSnd,mapBoth,apBoth,apSnd)
import Control.Monad(liftM,liftM2,mplus)
import Data.List (findIndex,intersect,isInfixOf,nub)
import Data.Char (isUpper,toUpper,toLower)
import Text.PrettyPrint
import qualified Data.ByteString.Char8 as BS
import qualified Data.Map as Map
import Debug.Trace(trace)

-- * Main entry points

normalForm :: SourceGrammar -> Term -> Term
normalForm gr = nfx gr []
nfx gr env = value2term gr [] . eval gr env

eval :: SourceGrammar -> Env -> Term -> Value
eval gr env t = value (gr,env) t

apply gr env = apply' (gr,env)

--------------------------------------------------------------------------------

-- * Environments

type CompleteEnv = (SourceGrammar,Env)

ext b (gr,env) = (gr,b:env)

var env x = maybe unbound id (lookup x (snd env))
  where unbound = bug ("Unknown variable: "++showIdent x)

-- * Computing values

-- | Computing the value of a top-level term
value0 gr t = eval gr [] t

-- | Computing the value of a term
value :: CompleteEnv -> Term -> Value
value env t0 =
  case t0 of
    Vr x   -> var env x
    Q x@(m,f)
      | m == cPredef -> if f==cErrorType                -- to be removed
                        then let p = identC (BS.pack "P")   
                             in value0 (fst env) (mkProd [(Implicit,p,typeType)] (Vr p) [])
                        else VApp x []
      | otherwise    -> err bug (value0 (fst env)) (lookupResDef (fst env) x)
    QC x   -> VCApp x []
    App e1 e2 -> apply' env e1 [value env e2]
    Let (x,(oty,t)) body -> value (ext (x,value env t) env) body
    Meta i -> VMeta i (snd env) []
    Prod bt x t1 t2 -> VProd bt (value env t1) x (Bind $ \ vx -> value (ext (x,vx) env) t2)
    Abs bt x t -> VAbs bt x (Bind $ \ vx -> value (ext (x,vx) env) t)
    EInt n -> VInt n
    EFloat f -> VFloat f
    K s -> VString s
    Empty -> VString ""
    Sort s | s == cTok -> VSort cStr                        -- to be removed 
           | otherwise -> VSort s
    ImplArg t -> VImplArg (value env t)
    Table p res -> VTblType (value env p) (value env res)
    RecType rs -> VRecType [(l,value env ty) | (l,ty) <- rs]
    t@(ExtR t1 t2) -> extR t (both (value env) (t1,t2))
    FV ts   -> vfv (map (value env) ts)
    R as    -> VRec [(lbl,value env t)|(lbl,(oty,t))<-as]
    T i cs  -> valueTable env i cs
    V ty ts -> VV ty (map (value env) ts)
    C t1 t2 -> vconcat (both (value env) (t1,t2))
    S t1 t2 -> select (fst env) (both (value env) (t1,t2))
    P t l   -> --maybe (bug $ "project "++show l++" from "++show v) id $
               maybe (VP v l) id $
               proj l v where v = (value env t)
    Alts t tts -> VAlts (value env t) (mapBoth (value env) tts)
    Strs ts    -> VStrs (map (value env) ts)
    Glue t1 t2 -> glue (both (value env) (t1,t2))
    ELin c r -> unlockVRec c (value env r)
    t -> ppbug (text "value"<+>ppTerm Unqualified 10 t $$ text (show t))

vconcat vv@(v1,v2) =
    case vv of
      (VError _,_) -> v1
      (VString "",_) -> v2
      (_,VError _) -> v2
      (_,VString "") -> v1
      _ -> VC v1 v2

proj l v | isLockLabel l = return (VRec [])
                ---- a workaround 18/2/2005: take this away and find the reason
                ---- why earlier compilation destroys the lock field
proj l v =
    case v of
      VFV vs -> liftM vfv (mapM (proj l) vs)
      VRec rs -> lookup l rs
      VExtR v1 v2 -> proj l v2 `mplus` proj l v1 -- hmm
      _ -> return (ok1 VP v l)

ok1 f v1@(VError {}) _ = v1
ok1 f v1 v2 = f v1 v2
 
ok2 f v1@(VError {}) _ = v1
ok2 f _ v2@(VError {}) = v2
ok2 f v1 v2 = f v1 v2

unlockVRec ::Ident -> Value -> Value
unlockVRec c v =
    case v of
--    VClosure env t -> err bug (VClosure env) (unlockRecord c t)
      VAbs bt x (Bind f) -> VAbs bt x (Bind $ \ v -> unlockVRec c (f v))
      VRec rs        -> plusVRec rs lock
      _              -> VExtR v (VRec lock) -- hmm
--    _              -> bug $ "unlock non-record "++show v
  where
    lock = [(lockLabel c,VRec [])]

-- suspicious, but backwards compatible
plusVRec rs1 rs2 = VRec ([(l,v)|(l,v)<-rs1,l `notElem` ls2] ++ rs2)
  where ls2 = map fst rs2

extR t vv =
    case vv of
      (VFV vs,v2) -> vfv [extR t (v1,v2)|v1<-vs]
      (v1,VFV vs) -> vfv [extR t (v1,v2)|v2<-vs]
      (VRecType rs1, VRecType rs2) ->
          case intersect (map fst rs1) (map fst rs2) of
            [] -> VRecType (rs1 ++ rs2)
            ls -> error $ text "clash"<+>text (show ls)
      (VRec     rs1, VRec     rs2) -> plusVRec rs1 rs2
      (v1          , VRec [(l,_)]) | isLockLabel l -> v1 -- hmm
      (VS (VV t vs) s,v2) -> VS (VV t [extR t (v1,v2)|v1<-vs]) s
      (v1,v2) -> ok2 VExtR v1 v2 -- hmm
--    (v1,v2) -> error $ text "not records" $$ text (show v1) $$ text (show v2)
  where
    error explain = ppbug $ text "The term" <+> ppTerm Unqualified 0 t
                            <+> text "is not reducible" $$ explain

glue vv = case vv of
            (VFV vs,v2) -> vfv [glue (v1,v2)|v1<-vs]
            (v1,VFV vs) -> vfv [glue (v1,v2)|v2<-vs]
            (VString s1,VString s2) -> VString (s1++s2)
            (v1,VAlts d vs) -> VAlts (glx d) [(glx v,c) | (v,c) <- vs]
               where glx v2 = glue (v1,v2)
            (v1@(VAlts {}),v2) ->
             --err (const (ok2 VGlue v1 v2)) id $
               err bug id $
               do y' <- strsFromValue v2
                  x' <- strsFromValue v1
                  return $ vfv [foldr1 VC (map VString (str2strings (glueStr v u))) | v <- x', u <- y']
            (VC va vb,v2) -> VC va (glue (vb,v2))
            (v1,VC va vb) -> VC (glue (va,va)) vb
            (VS (VV ty vs) vb,v2) -> VS (VV ty [glue (v,v2)|v<-vs]) vb
            (v1,VS (VV ty vs) vb) -> VS (VV ty [glue (v1,v)|v<-vs]) vb
--          (v1,v2) -> ok2 VGlue v1 v2
            (v1,v2) -> bug vv
  where
    bug vv = ppbug $ text "glue"<+>text (show vv)

-- | to get a string from a value that represents a sequence of terminals
strsFromValue :: Value -> Err [Str]
strsFromValue t = case t of
  VString s   -> return [str s]
  VC s t -> do
    s' <- strsFromValue s
    t' <- strsFromValue t
    return [plusStr x y | x <- s', y <- t']
{-
  VGlue s t -> do
    s' <- strsFromValue s
    t' <- strsFromValue t
    return [glueStr x y | x <- s', y <- t']
-}
  VAlts d vs -> do
    d0 <- strsFromValue d
    v0 <- mapM (strsFromValue . fst) vs
    c0 <- mapM (strsFromValue . snd) vs
    let vs' = zip v0 c0
    return [strTok (str2strings def) vars | 
              def  <- d0,
              vars <- [[(str2strings v, map sstr c) | (v,c) <- zip vv c0] | 
                                                          vv <- combinations v0]
           ]
  VFV ts -> mapM strsFromValue ts >>= return . concat
  VStrs ts -> mapM strsFromValue ts >>= return . concat  
  _ -> fail "cannot get Str from value"

vfv vs = case nub vs of
           [v] -> v
           vs -> VFV vs

select gr vv =
    case vv of
      (v1,VFV vs) -> vfv [select gr (v1,v2)|v2<-vs]
      (VFV vs,v2) -> vfv [select gr (v1,v2)|v1<-vs]
      (v1@(VV pty rs),v2) ->
         err (const (VS v1 v2)) id $
         do ats <- allParamValues gr pty
            let vs = map (value0 gr) ats
            i <- maybeErr "no match" $ findIndex (==v2) vs
            return (rs!!i)
      (v1@(VT i cs),v2) ->
                 err bug (valueMatch gr) $ matchPattern cs (value2term gr [] v2)
      (VS (VV pty rs) v12,v2) -> VS (VV pty [select gr (v11,v2)|v11<-rs]) v12
      (v1,v2) -> ok2 VS v1 v2

valueMatch gr (Bind f,env') = f (mapSnd (value0 gr) env')

valueTable env@(gr,bs) i cs =
    case i of
      TComp ty -> VV ty (map (value env.snd) cs)
      _ -> err keep id convert
  where
    keep _ = VT i (err bug id $ mapM valueCase cs)

    valueCase (p,t) = do p' <- inlinePattMacro p
                         return (p',Bind $ \ bs' -> value (gr,bs'++bs) t)

    convert = do ty <- getTableType i
                 let pty = nfx gr bs ty
                 vs   <- allParamValues gr pty
                 cs'  <- mapM valueCase cs
                 sts  <- mapM (matchPattern cs') vs 
                 return $ VV pty (map (valueMatch gr) sts)

    inlinePattMacro p = case p of
                          PM qc -> do EPatt p' <- lookupResDef gr qc
                                      inlinePattMacro p'
                          _ -> composPattOp inlinePattMacro p

apply' env t           []     = value env t
apply' env t vs =
  case t of
    QC x                   -> VCApp x vs
    Q x@(m,f) | m==cPredef -> let constr = --trace ("predef "++show x) .
                                           VApp x 
                              in maybe constr id (Map.lookup f predefs) vs
              | otherwise  -> err bug (\t->apply' (fst env,[]) t vs)
                                        (lookupResDef (fst env) x)
    App t1 t2              -> apply' env t1 (value env t2 : vs)
--  Abs b x t              -> beta env b x t vs
    _                      -> vapply (value env t) vs

vapply v [] = v
vapply v vs =
  case v of
    VError {} -> v
--  VClosure env (Abs b x t) -> beta gr env b x t vs
    VAbs bt _ (Bind f) -> vbeta bt f vs
    VS (VV t fs) s -> VS (VV t [vapply f vs|f<-fs]) s
    v -> bug $ "vapply "++show v++" "++show vs

vbeta bt f (v:vs) =
  case (bt,v) of
    (Implicit,VImplArg v) -> ap v
    (Explicit,         v) -> ap v
  where
    ap (VFV avs) = VFV [vapply (f v) vs|v<-avs]
    ap v         = vapply (f v) vs

{-
beta env b x t (v:vs) =
  case (b,v) of
    (Implicit,VImplArg v) -> apply' (ext (x,v) env) t vs
    (Explicit,         v) -> apply' (ext (x,v) env) t vs
-}

--  tr s f vs = trace (s++" "++show vs++" = "++show r) r where r = f vs

-- | Convert a value back to a term
value2term :: SourceGrammar -> [Ident] -> Value -> Term
value2term gr xs v0 =
  case v0 of
    VApp f vs      -> foldl App (Q f)                  (map v2t vs)
    VCApp f vs     -> foldl App (QC f)                 (map v2t vs)
    VGen j vs      -> foldl App (Vr (reverse xs !! j)) (map v2t vs)
    VMeta j env vs -> foldl App (Meta j)               (map v2t vs)
--  VClosure env (Prod bt x t1 t2) -> Prod bt x (v2t  (eval gr env t1))
--                                              (nf gr (push x (env,xs)) t2)
--  VClosure env (Abs  bt x t)     -> Abs  bt x (nf gr (push x (env,xs)) t)
    VProd bt v x (Bind f) -> Prod bt x (v2t v) (v2t' x f)
    VAbs  bt   x (Bind f) -> Abs  bt x         (v2t' x f)
    VInt n         -> EInt n
    VFloat f       -> EFloat f
    VString s      -> if null s then Empty else K s
    VSort s        -> Sort s
    VImplArg v     -> ImplArg (v2t v)
    VTblType p res -> Table (v2t p) (v2t res)
    VRecType rs    -> RecType [(l,v2t v) | (l,v) <- rs]
    VRec as        -> R [(l,(Nothing,v2t v))|(l,v) <- as]
    VV t vs        -> V t (map v2t vs)
    VT i cs        -> T i (map nfcase cs)
    VFV vs         -> FV (map v2t vs)
    VC v1 v2       -> C (v2t v1) (v2t v2)
    VS v1 v2       -> S (v2t v1) (v2t v2)
    VP v l         -> P (v2t v) l
    VAlts v vvs    -> Alts (v2t v) (mapBoth v2t vvs)
    VStrs vs       -> Strs (map v2t vs)
--  VGlue v1 v2    -> Glue (v2t v1) (v2t v2)
    VExtR v1 v2    -> ExtR (v2t v1) (v2t v2)
    VError err     -> Error err
    _              -> bug ("value2term "++show v0)
  where
    v2t = value2term gr xs
    v2t' x f = value2term gr (x:xs) (f (gen xs))

    pushs xs e = foldr push e xs
    push x (env,xs) = ((x,gen xs):env,x:xs)
    gen xs = VGen (length xs) []

    nfcase (p,Bind f) = (p,value2term gr xs' (f env'))
      where (env',xs') = pushs (pattVars p) ([],xs)

--  nf gr (env,xs) = value2term gr xs . eval gr env

pattVars = nub . pv
  where
    pv p = case p of
             PV i -> [i]
             PAs i p -> i:pv p
             _ -> collectPattOp pv p

---

both = apBoth

bug msg = ppbug (text msg)
ppbug doc = error $ render $
                    hang (text "Internal error in Compute.ConcreteNew2:") 4 doc
