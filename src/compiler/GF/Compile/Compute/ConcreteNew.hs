-- | Functions for computing the values of terms in the concrete syntax, in
-- | preparation for PMCFG generation.
module GF.Compile.Compute.ConcreteNew
           (GlobalEnv, resourceValues, normalForm,
           --, Value(..), Env, value2term, eval, apply
           ) where

import GF.Grammar hiding (Env, VGen, VApp, VRecType)
import GF.Grammar.Lookup(lookupResDefLoc,allParamValues)
import GF.Grammar.Predef(cPredef,cErrorType,cTok,cStr,cTrace)
import GF.Grammar.PatternMatch(matchPattern,measurePatt)
import GF.Grammar.Lockfield(isLockLabel,lockRecType) --unlockRecord,lockLabel
import GF.Compile.Compute.Value hiding (Error)
import GF.Compile.Compute.Predef(predef,predefName,delta)
import GF.Data.Str(Str,glueStr,str2strings,str,sstr,plusStr,strTok)
import GF.Data.Operations(Err,err,errIn,maybeErr,combinations,mapPairsM)
import GF.Data.Utilities(mapFst,mapSnd,mapBoth)
import GF.Infra.Option
import Control.Monad(ap,liftM,liftM2) -- ,unless,mplus
import Data.List (findIndex,intersect,nub,elemIndex,(\\)) --,isInfixOf
--import Data.Char (isUpper,toUpper,toLower)
import GF.Text.Pretty
import qualified Data.Map as Map
import Debug.Trace(trace)

-- * Main entry points

normalForm :: GlobalEnv -> L Ident -> Term -> Term
normalForm (GE gr rv opts _) loc = err (bugloc loc) id . nfx (GE gr rv opts loc)

nfx env@(GE _ _ _ loc) t = value2term loc [] # eval env t

eval :: GlobalEnv -> Term -> Err Value
eval ge t = ($[]) # value (toplevel ge) t

--apply env = apply' env

--------------------------------------------------------------------------------

-- * Environments

type ResourceValues = Map.Map ModuleName (Map.Map Ident (Err Value))

data GlobalEnv = GE Grammar ResourceValues Options GLocation
data CompleteEnv = CE {srcgr::Grammar,rvs::ResourceValues,
                       opts::Options,
                       gloc::GLocation,local::LocalScope}
type GLocation = L Ident
type LocalScope = [Ident]
type Stack = [Value]
type OpenValue = Stack->Value
                            
ext b env = env{local=b:local env}
extend bs env = env{local=bs++local env}
global env = GE (srcgr env) (rvs env) (opts env) (gloc env)
toplevel (GE gr rvs opts loc) = CE gr rvs opts loc []

var :: CompleteEnv -> Ident -> Err OpenValue
var env x = maybe unbound pick' (elemIndex x (local env))
  where
    unbound = fail ("Unknown variable: "++showIdent x)
    pick' i = return $ \ vs -> maybe (err i vs) ok (pick i vs)
    err i vs = bug $ "Stack problem: "++showIdent x++": "
                    ++unwords (map showIdent (local env))
                    ++" => "++show (i,length vs)
    ok v = --trace ("var "++show x++" = "++show v) $
           v

pick :: Int -> Stack -> Maybe Value
pick 0 (v:_) = Just v
pick i (_:vs) = pick (i-1) vs
pick i vs = Nothing -- bug $ "pick "++show (i,vs)

resource env (m,c) =
--  err bug id $
    if isPredefCat c
    then value0 env =<< lockRecType c defLinType -- hmm
    else maybe e id $ Map.lookup c =<< Map.lookup m (rvs env)
  where e = fail $ "Not found: "++render m++"."++showIdent c

-- | Convert operators once, not every time they are looked up
resourceValues :: Options -> SourceGrammar -> GlobalEnv
resourceValues opts gr = env
  where
    env = GE gr rvs opts (L NoLoc identW)
    rvs = Map.mapWithKey moduleResources (moduleMap gr)
    moduleResources m = Map.mapWithKey (moduleResource m) . jments
    moduleResource m c _info = do L l t <- lookupResDefLoc gr (m,c)
                                  let loc = L l c
                                      qloc = L l (Q (m,c))
                                  eval (GE gr rvs opts loc) (traceRes qloc t)

    traceRes = if flag optTrace opts
               then traceResource
               else const id

-- * Tracing

-- | Insert a call to the trace function under the top-level lambdas
traceResource (L l q) t =
  case termFormCnc t of
    (abs,body) -> mkAbs abs (mkApp traceQ [args,body])
      where
        args = R $ tuple2record (K lstr:[Vr x|(bt,x)<-abs,bt==Explicit])
        lstr = render (l<>":"<>ppTerm Qualified 0 q)
        traceQ = Q (cPredef,cTrace)

-- * Computing values

-- | Computing the value of a top-level term
value0 :: CompleteEnv -> Term -> Err Value
value0 = eval . global

-- | Computing the value of a term
value :: CompleteEnv -> Term -> Err OpenValue
value env t0 =
  -- Each terms is traversed only once by this function, using only statically
  -- available information. Notably, the values of lambda bound variables 
  -- will be unknown during the term traversal phase.
  -- The result is an OpenValue, which is a function that may be applied many
  -- times to different dynamic values, but without the term traversal overhead
  -- and without recomputing other statically known information.
  -- For this to work, there should be no recursive calls under lambdas here.
  -- Whenever we need to construct the OpenValue function with an explicit
  -- lambda, we have to lift the recursive calls outside the lambda.
  -- (See e.g. the rules for Let, Prod and Abs)
{-
  trace (render $ text "value"<+>sep [ppL (gloc env)<>text ":",
                                      brackets (fsep (map ppIdent (local env))),
                                      ppT 10 t0]) $
--}
  errIn (render t0) $
  case t0 of
    Vr x   -> var env x
    Q x@(m,f)
      | m == cPredef -> if f==cErrorType                -- to be removed
                        then let p = identS "P"
                             in const # value0 env (mkProd [(Implicit,p,typeType)] (Vr p) [])
                        else const . flip VApp [] # predef f
      | otherwise    -> const # resource env x --valueResDef (fst env) x
    QC x   -> return $ const (VCApp x [])
    App e1 e2 -> apply' env e1 . (:[]) =<< value env e2
    Let (x,(oty,t)) body -> do vb <- value (ext x env) body
                               vt <- value env t
                               return $ \ vs -> vb (vt vs:vs)
    Meta i -> return $ \ vs -> VMeta i (zip (local env) vs) []
    Prod bt x t1 t2 ->
       do vt1 <- value env t1
          vt2 <- value (ext x env) t2
          return $ \ vs -> VProd bt (vt1 vs) x $ Bind $ \ vx -> vt2 (vx:vs)
    Abs bt x t -> do vt <- value (ext x env) t
                     return $ VAbs bt x . Bind . \ vs vx -> vt (vx:vs)
    EInt n -> return $ const (VInt n)
    EFloat f -> return $ const (VFloat f)
    K s -> return $ const (VString s)
    Empty -> return $ const (VString "")
    Sort s | s == cTok -> return $ const (VSort cStr)        -- to be removed 
           | otherwise -> return $ const (VSort s)
    ImplArg t -> (VImplArg.) # value env t
    Table p res -> liftM2 VTblType # value env p <# value env res
    RecType rs -> do lovs <- mapPairsM (value env) rs
                     return $ \vs->VRecType $ mapSnd ($vs) lovs
    t@(ExtR t1 t2) -> ((extR t.)# both id) # both (value env) (t1,t2)
    FV ts   -> ((vfv .) # sequence) # mapM (value env) ts
    R as    -> do lovs <- mapPairsM (value env.snd) as
                  return $ \ vs->VRec $ mapSnd ($vs) lovs
    T i cs  -> valueTable env i cs
    V ty ts -> do pvs <- paramValues env ty
                  ((VV ty pvs .) . sequence) # mapM (value env) ts
    C t1 t2 -> ((ok2p vconcat.) # both id) # both (value env) (t1,t2)
    S t1 t2 -> ((select env.) # both id) # both (value env) (t1,t2)
    P t l   -> --maybe (bug $ "project "++show l++" from "++show v) id $
               do ov <- value env t
                  return $ \ vs -> let v = ov vs
                                   in maybe (VP v l) id (proj l v)
    Alts t tts -> (\v vts -> VAlts # v <# mapM (both id) vts) # value env t <# mapM (both (value env)) tts
    Strs ts    -> ((VStrs.) # sequence) # mapM (value env) ts
    Glue t1 t2 -> ((ok2p (glue env).) # both id) # both (value env) (t1,t2)
    ELin c r -> (unlockVRec (gloc env) c.) # value env r
    EPatt p  -> return $ const (VPatt p) -- hmm
    t -> fail.render $ "value"<+>ppT 10 t $$ show t

vconcat vv@(v1,v2) =
    case vv of
      (VString "",_) -> v2
      (_,VString "") -> v1
      (VApp NonExist _,_) -> v1
      (_,VApp NonExist _) -> v2
      _ -> VC v1 v2

proj l v | isLockLabel l = return (VRec [])
                ---- a workaround 18/2/2005: take this away and find the reason
                ---- why earlier compilation destroys the lock field
proj l v =
    case v of
      VFV vs -> liftM vfv (mapM (proj l) vs)
      VRec rs -> lookup l rs
--    VExtR v1 v2 -> proj l v2 `mplus` proj l v1 -- hmm
      VS (VV pty pvs rs) v2 -> flip VS v2 . VV pty pvs # mapM (proj l) rs
      _ -> return (ok1 VP v l)

ok1 f v1@(VError {}) _ = v1
ok1 f v1 v2 = f v1 v2
 
ok2 f v1@(VError {}) _ = v1
ok2 f _ v2@(VError {}) = v2
ok2 f v1 v2 = f v1 v2

ok2p f (v1@VError {},_) = v1
ok2p f (_,v2@VError {}) = v2
ok2p f vv = f vv

unlockVRec loc c0 v0 = v0
{-
unlockVRec loc c0 v0 = unlockVRec' c0 v0
  where
    unlockVRec' ::Ident -> Value -> Value
    unlockVRec' c v =
        case v of
    --    VClosure env t -> err bug (VClosure env) (unlockRecord c t)
          VAbs bt x (Bind f) -> VAbs bt x (Bind $ \ v -> unlockVRec' c (f v))
          VRec rs        -> plusVRec rs lock
    --    _              -> VExtR v (VRec lock) -- hmm
          _              -> {-trace (render $ ppL loc $ "unlock non-record "++show v0)-} v -- hmm
    --    _              -> bugloc loc $ "unlock non-record "++show v0
      where
        lock = [(lockLabel c,VRec [])]
-}

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
            ls -> error $ "clash"<+>show ls
      (VRec     rs1, VRec     rs2) -> plusVRec rs1 rs2
      (v1          , VRec [(l,_)]) | isLockLabel l -> v1 -- hmm
      (VS (VV t pvs vs) s,v2) -> VS (VV t pvs [extR t (v1,v2)|v1<-vs]) s
--    (v1,v2) -> ok2 VExtR v1 v2 -- hmm
      (v1,v2) -> error $ "not records" $$ show v1 $$ show v2
  where
    error explain = ppbug $ "The term" <+> t
                            <+> "is not reducible" $$ explain

glue env (v1,v2) = glu v1 v2
  where
    glu v1 v2 =
        case (v1,v2) of
          (VFV vs,v2) -> vfv [glu v1 v2|v1<-vs]
          (v1,VFV vs) -> vfv [glu v1 v2|v2<-vs]
          (VString s1,VString s2) -> VString (s1++s2)
          (v1,VAlts d vs) -> VAlts (glx d) [(glx v,c) | (v,c) <- vs]
             where glx v2 = glu v1 v2
          (v1@(VAlts {}),v2) ->
           --err (const (ok2 VGlue v1 v2)) id $
             err bug id $
             do y' <- strsFromValue v2
                x' <- strsFromValue v1
                return $ vfv [foldr1 VC (map VString (str2strings (glueStr v u))) | v <- x', u <- y']
          (VC va vb,v2) -> VC va (glu vb v2)
          (v1,VC va vb) -> VC (glu v1 va) vb
          (VS (VV ty pvs vs) vb,v2) -> VS (VV ty pvs [glu v v2|v<-vs]) vb
          (v1,VS (VV ty pvs vs) vb) -> VS (VV ty pvs [glu v1 v|v<-vs]) vb
          (v1@(VApp NonExist _),_) -> v1
          (_,v2@(VApp NonExist _)) -> v2
--        (v1,v2) -> ok2 VGlue v1 v2
          (v1,v2) -> if flag optPlusAsBind (opts env)
                       then VC v1 (VC (VApp BIND []) v2)
                       else error . render $
                                      ppL loc (hang "unsupported token gluing:" 4
                                                    (Glue (vt v1) (vt v2)))

    vt = value2term loc (local env)
    loc = gloc env

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
  --let vs' = zip v0 c0
    return [strTok (str2strings def) vars | 
              def  <- d0,
              vars <- [[(str2strings v, map sstr c) | (v,c) <- zip vv c0] | 
                                                          vv <- combinations v0]
           ]
  VFV ts -> mapM strsFromValue ts >>= return . concat
  VStrs ts -> mapM strsFromValue ts >>= return . concat  

  _ -> fail ("cannot get Str from value " ++ show t)

vfv vs = case nub vs of
           [v] -> v
           vs -> VFV vs

select env vv =
    case vv of
      (v1,VFV vs) -> vfv [select env (v1,v2)|v2<-vs]
      (VFV vs,v2) -> vfv [select env (v1,v2)|v1<-vs]
      (v1@(VV pty vs rs),v2) ->
         err (const (VS v1 v2)) id $
         do --ats <- allParamValues (srcgr env) pty
            --let vs = map (value0 env) ats
            i <- maybeErr "no match" $ findIndex (==v2) vs
            return (ix (gloc env) "select" rs i)
      (VT _ _ [(PW,Bind b)],_) -> {-trace "eliminate wild card table" $-} b []
      (v1@(VT _ _ cs),v2) ->
                 err (\_->ok2 VS v1 v2) (err bug id . valueMatch env) $
                 match (gloc env) cs v2
      (VS (VV pty pvs rs) v12,v2) -> VS (VV pty pvs [select env (v11,v2)|v11<-rs]) v12
      (v1,v2) -> ok2 VS v1 v2

match loc cs = err bad return . matchPattern cs . value2term loc []
  where
    bad = fail . ("In pattern matching: "++)

valueMatch :: CompleteEnv -> (Bind Env,Substitution) -> Err Value
valueMatch env (Bind f,env') = f # mapPairsM (value0 env) env'

valueTable :: CompleteEnv -> TInfo -> [Case] -> Err OpenValue
valueTable env i cs =
    case i of
      TComp ty -> do pvs <- paramValues env ty
                     ((VV ty pvs .) # sequence) # mapM (value env.snd) cs
      _ -> do ty <- getTableType i
              cs' <- mapM valueCase cs
              err (dynamic cs' ty) return (convert cs' ty)
  where
    dynamic cs' ty _ = cases cs' # value env ty

    cases cs' vty vs = err keep ($vs) (convertv cs' (vty vs))
      where
        keep msg = --trace (msg++"\n"++render (ppT 0 (T i cs))) $
                   VT wild (vty vs) (mapSnd ($vs) cs')

    wild = case i of TWild _ -> True; _ -> False

    convertv cs' vty = convert' cs' =<< paramValues'' env pty
      where pty = value2term (gloc env) [] vty

    convert cs' ty = convert' cs' =<< paramValues' env ty

    convert' cs' ((pty,vs),pvs) =
      do sts  <- mapM (matchPattern cs') vs
         return $ \ vs -> VV pty pvs $ map (err bug id . valueMatch env)
                                           (mapFst ($vs) sts)

    valueCase (p,t) = do p' <- measurePatt # inlinePattMacro p
                         pvs <- linPattVars p'
                         vt <- value (extend pvs env) t
                         return (p',\vs-> Bind $ \bs-> vt (push' p' bs pvs vs))

    inlinePattMacro p =
        case p of
          PM qc -> do r <- resource env qc
                      case r of
                        VPatt p' -> inlinePattMacro p'
                        _ -> ppbug $ hang "Expected pattern macro:" 4
                                          (show r)
          _ -> composPattOp inlinePattMacro p


paramValues env ty = snd # paramValues' env ty

paramValues' env ty = paramValues'' env =<< nfx (global env) ty

paramValues'' env pty = do ats <- allParamValues (srcgr env) pty
                           pvs <- mapM (eval (global env)) ats
                           return ((pty,ats),pvs)

push' p bs xs = if length bs/=length xs
                then bug $ "push "++show (p,bs,xs)
                else push bs xs

push :: Env -> LocalScope -> Stack -> Stack
push bs [] vs = vs
push bs (x:xs) vs = maybe err id (lookup x bs):push bs xs vs
  where  err = bug $ "Unbound pattern variable "++showIdent x

apply' :: CompleteEnv -> Term -> [OpenValue] -> Err OpenValue
apply' env t [] = value env t
apply' env t vs =
  case t of
    QC x                   -> return $ \ svs -> VCApp x (map ($svs) vs)
{-
    Q x@(m,f) | m==cPredef -> return $
                              let constr = --trace ("predef "++show x) .
                                           VApp x 
                              in \ svs -> maybe constr id (Map.lookup f predefs)
                                          $ map ($svs) vs
              | otherwise  -> do r <- resource env x
                                 return $ \ svs -> vapply (gloc env) r (map ($svs) vs)
-}
    App t1 t2              -> apply' env t1 . (:vs) =<< value env t2
    _                      -> do fv <- value env t
                                 return $ \ svs -> vapply (gloc env) (fv svs) (map ($svs) vs)

vapply :: GLocation -> Value -> [Value] -> Value
vapply loc v [] = v
vapply loc v vs =
  case v of
    VError {} -> v
--  VClosure env (Abs b x t) -> beta gr env b x t vs
    VAbs bt _ (Bind f) -> vbeta loc bt f vs
    VApp pre vs1 -> delta' pre (vs1++vs)
      where
        delta' Trace (v1:v2:vs) = let vr = vapply loc v2 vs
                                  in vtrace loc v1 vr
        delta' pre vs = err msg vfv $ mapM (delta pre) (varyList vs)
        --msg = const (VApp pre (vs1++vs))
        msg = bug . (("Applying Predef."++showIdent (predefName pre)++": ")++)
    VS (VV t pvs fs) s -> VS (VV t pvs [vapply loc f vs|f<-fs]) s
    VFV fs -> vfv [vapply loc f vs|f<-fs]
    VCApp f vs0 -> VCApp f (vs0++vs)
    v -> bug $ "vapply "++show v++" "++show vs

vbeta loc bt f (v:vs) =
  case (bt,v) of
    (Implicit,VImplArg v) -> ap v
    (Explicit,         v) -> ap v
  where
    ap (VFV avs) = vfv [vapply loc (f v) vs|v<-avs]
    ap v         = vapply loc (f v) vs

vary (VFV vs) = vs
vary v = [v]
varyList = mapM vary

{-
beta env b x t (v:vs) =
  case (b,v) of
    (Implicit,VImplArg v) -> apply' (ext (x,v) env) t vs
    (Explicit,         v) -> apply' (ext (x,v) env) t vs
-}

vtrace loc arg res = trace (render (hang (pv arg) 4 ("->"<+>pv res))) res
  where
    pv v = case v of
             VRec (f:as) -> hang (pf f) 4 (fsep (map pa as))
             _ -> ppV v
    pf (_,VString n) = pp n
    pf (_,v) = ppV v
    pa (_,v) = ppV v
    ppV v = ppT 10 (trace2term loc [] v)

--  tr s f vs = trace (s++" "++show vs++" = "++show r) r where r = f vs

-- | When tracing, we need to avoid printing under lambdas...
trace2term = value2term' True

-- | Convert a value back to a term
value2term :: GLocation -> [Ident] -> Value -> Term
value2term = value2term' False
value2term' stop loc xs v0 =
  case v0 of
    VApp pre vs    -> foldl App (Q (cPredef,predefName pre)) (map v2t vs)
    VCApp f vs     -> foldl App (QC f)                 (map v2t vs)
--  VGen j vs      -> foldl App (Vr (ix loc "value2term" (reverse xs) j)) (map v2t vs)
    VGen j vs      -> foldl App (var j) (map v2t vs)
    VMeta j env vs -> foldl App (Meta j)               (map v2t vs)
--  VClosure env (Prod bt x t1 t2) -> Prod bt x (v2t  (eval gr env t1))
--                                              (nf gr (push x (env,xs)) t2)
--  VClosure env (Abs  bt x t)     -> Abs  bt x (nf gr (push x (env,xs)) t)
    VProd bt v x f -> Prod bt x (v2t v) (v2t' x f)
    VAbs  bt   x f -> Abs  bt x         (v2t' x f)
    VInt n         -> EInt n
    VFloat f       -> EFloat f
    VString s      -> if null s then Empty else K s
    VSort s        -> Sort s
    VImplArg v     -> ImplArg (v2t v)
    VTblType p res -> Table (v2t p) (v2t res)
    VRecType rs    -> RecType [(l,v2t v) | (l,v) <- rs]
    VRec as        -> R [(l,(Nothing,v2t v))|(l,v) <- as]
    VV t _ vs      -> V t (map v2t vs)
    VT wild v cs   -> T ((if wild then TWild else TTyped) (v2t v))
                        (map nfcase cs)
    VFV vs         -> FV (map v2t vs)
    VC v1 v2       -> C (v2t v1) (v2t v2)
    VS v1 v2       -> S (v2t v1) (v2t v2)
    VP v l         -> P (v2t v) l
    VPatt p        -> EPatt p -- hmm
--  VPattType v    -> ...
    VAlts v vvs    -> Alts (v2t v) (mapBoth v2t vvs)
    VStrs vs       -> Strs (map v2t vs)
--  VGlue v1 v2    -> Glue (v2t v1) (v2t v2)
--  VExtR v1 v2    -> ExtR (v2t v1) (v2t v2)
    VError err     -> Error err
    _              -> bug ("value2term "++show loc++" : "++show v0)
  where
    v2t = v2txs xs
    v2txs = value2term' stop loc
    v2t' x f = v2txs (x:xs) (bind f (gen xs))

    var j = if j<n
            then Vr (reverse xs !! j)
            else Error ("VGen "++show j++" "++show xs) -- bug hunting
      where n = length xs

    pushs xs e = foldr push e xs
    push x (env,xs) = ((x,gen xs):env,x:xs)
    gen xs = VGen (length xs) []

    nfcase (p,f) = (p,v2txs xs' (bind f env'))
      where (env',xs') = pushs (pattVars p) ([],xs)

    bind (Bind f) x = if stop
                      then VSort (identS "...") -- hmm
                      else f x
--  nf gr (env,xs) = value2term xs . eval gr env

linPattVars p =
    if null dups
    then return pvs
    else fail.render $ hang "Pattern is not linear:" 4 (ppPatt Unqualified 0 p)
  where
    allpvs = allPattVars p
    pvs = nub allpvs
    dups = allpvs \\ pvs

pattVars = nub . allPattVars
allPattVars p =
    case p of
      PV i    -> [i]
      PAs i p -> i:allPattVars p
      _       -> collectPattOp allPattVars p

---
ix loc fn xs i =
    if i<n
    then xs !! i
    else bugloc loc $ "(!!): index too large in "++fn++", "++show i++"<"++show n
  where n = length xs

infixl 1 #,<# --,@@

f # x = fmap f x
mf <# mx  = ap mf mx
--m1 @@ m2 = (m1 =<<) . m2

both f (x,y) = (,) # f x <# f y

ppT = ppTerm Unqualified

bugloc loc s = ppbug $ ppL loc s

bug msg = ppbug msg
ppbug doc = error $ render $ hang "Internal error in Compute.ConcreteNew:" 4 doc
