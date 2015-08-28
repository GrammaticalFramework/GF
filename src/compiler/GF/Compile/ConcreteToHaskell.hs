-- | Translate concrete syntax to Haskell
module GF.Compile.ConcreteToHaskell(concretes2haskell,concrete2haskell) where
import Data.List(sort,sortBy)
import Data.Function(on)
import qualified Data.Map as M
import qualified Data.Set as S
import GF.Data.ErrM
import GF.Data.Utilities(mapSnd)
import GF.Text.Pretty
import GF.Grammar.Grammar
import GF.Grammar.Lookup(lookupFunType,lookupOrigInfo,allOrigInfos)--,allParamValues
import GF.Grammar.Macros(typeForm,collectOp,collectPattOp,mkAbs,mkApp)
import GF.Grammar.Lockfield(isLockLabel)
import GF.Grammar.Predef(cPredef,cInts)
import GF.Compile.Compute.Predef(predef)
import GF.Compile.Compute.Value(Predefined(..))
import GF.Infra.Ident(Ident,identS,prefixIdent) --,moduleNameS
import GF.Infra.Option
import GF.Compile.Compute.ConcreteNew(normalForm,resourceValues)
import GF.Haskell
import Debug.Trace

-- | Generate Haskell code for the all concrete syntaxes associated with
-- the named abstract syntax in given the grammar.
concretes2haskell opts absname gr =
  [(cncname,concrete2haskell opts gr cenv absname cnc cncmod)
     | let cenv = resourceValues opts gr,
       cnc<-allConcretes gr absname,
       let cncname = render cnc ++ ".hs" :: FilePath
           Ok cncmod = lookupModule gr cnc
  ]

-- | Generate Haskell code for the given concrete module.
-- The only options that make a difference are
-- @-haskell=noprefix@ and @-haskell=variants@.
concrete2haskell opts gr cenv absname cnc modinfo =
    renderStyle style{lineLength=80,ribbonsPerLine=1} $
      haskPreamble va absname cnc $$ vcat (
      nl:Comment "--- Parameter types ---":
      neededParamTypes S.empty (params defs) ++
      nl:Comment "--- Type signatures for linearization functions ---":
      map signature (S.toList allcats)++
      nl:Comment "--- Linearization functions for empty categories ---":
      emptydefs ++
      nl:Comment "--- Linearization types and linearization functions ---":
      map ppDef defs ++
      nl:Comment "--- Type classes for projection functions ---":
      map labelClass (S.toList labels) ++
      nl:Comment "--- Record types ---":
      concatMap recordType recs)
  where
    nl = Comment ""
    labels = S.difference (S.unions (map S.fromList recs)) common_labels
    recs = S.toList (S.difference (records rhss) common_records)
    common_records = S.fromList [[label_s]]
    common_labels = S.fromList [label_s]
    label_s = ident2label (identS "s")

    rhss = map (either snd (snd.snd)) defs
    defs = sortBy (compare `on` either (const Nothing) (Just . fst)) .
           concatMap (toHaskell gId gr absname cenv) . 
           M.toList $
           jments modinfo

--  signature c = "lin"<>c<+>"::"<+>"A."<>gId c<+>"->"<+>"Lin"<>c
--  signature c = "--lin"<>c<+>":: (Applicative f,Monad f) =>"<+>"A."<>gId c<+>"->"<+>"f Lin"<>c
    signature c = TypeSig lf (Fun abs (pure lin))
      where
        abs = tcon0 (prefixIdent "A." (gId c))
        lin = tcon0 lc
        lf = prefixIdent "lin" c
        lc = prefixIdent "Lin" c

    emptydefs = map emptydef (S.toList emptyCats)
    emptydef c = Eqn (prefixIdent "lin" c,[WildP]) (Const "undefined")

    emptyCats = allcats `S.difference` cats
    cats = S.fromList [c|Right (c,_)<-defs]
    allcats = S.fromList [c|((_,c),AbsCat (Just _))<-allOrigInfos gr absname]

    params = S.toList . S.unions . map params1
    params1 (Left (_,rhs)) = paramTypes gr rhs
    params1 (Right (_,(_,rhs))) = tableTypes gr [rhs]

    ppDef (Left (lhs,rhs)) = lhs (convType va gId rhs)
    ppDef (Right (_,(lhs,rhs))) = lhs (convert va gId gr rhs)

    gId :: Ident -> Ident
    gId = if haskellOption opts HaskellNoPrefix then id else prefixIdent "G"
    va = haskellOption opts HaskellVariants
    pure = if va then ListT else id

    neededParamTypes have [] = []
    neededParamTypes have (q:qs) =
        if q `S.member` have
        then neededParamTypes have qs
        else let ((got,need),def) = paramType va gId gr q
             in def++neededParamTypes (S.union got have) (S.toList need++qs)

haskPreamble :: Bool -> ModuleName -> ModuleName -> Doc
haskPreamble va absname cncname =
  "{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies, FlexibleInstances, LambdaCase #-}" $$
  "module" <+> cncname <+> "where" $$
  "import Prelude hiding (Ordering(..))" $$
  "import Control.Applicative((<$>),(<*>))" $$
  "import PGF.Haskell" $$
  "import qualified" <+> absname <+> "as A" $$
  "" $$
  "--- Standard definitions ---" $$
  "linString (A.GString s) ="<+>pure "R_s [TK s]" $$
  "linInt (A.GInt i) ="<+>pure "R_s [TK (show i)]" $$
  "linFloat (A.GFloat x) ="<+>pure "R_s [TK (show x)]" $$
  "" $$
  "----------------------------------------------------" $$
  "-- Automatic translation from GF to Haskell follows" $$
  "----------------------------------------------------"
  where
    pure = if va then brackets else pp

toHaskell gId gr absname cenv (name,jment) =
  case jment of
    CncCat (Just (L loc typ)) _ _ pprn _ ->
        [Left (tsyn0 (prefixIdent "Lin" name),nf loc typ)]
    CncFun (Just r@(cat,ctx,lincat)) (Just (L loc def)) pprn _ ->
--      trace (render (name<+>hcat[parens (x<>"::"<>t)|(_,x,t)<-ctx]<+>"::"<+>cat)) $
        [Right (cat,(Eqn (prefixIdent "lin" cat,lhs),coerce [] lincat rhs))]
      where
        Ok abstype = lookupFunType gr absname name
        (absctx,_abscat,_absargs) = typeForm abstype

        e' = unAbs (length params) $
             nf loc (mkAbs params (mkApp def (map Vr args)))
        params = [(b,prefixIdent "g" x)|(b,x,_)<-ctx]
        args = map snd params
        abs_args = map (prefixIdent "abs_") args
        lhs = [ConP (aId name) (map VarP abs_args)]
        rhs = foldr letlin e' (zip args absctx)
        letlin (a,(_,_,at)) =
           Let (a,(Just (con ("Lin"++render at)),(App (con ("lin"++render at)) (con ("abs_"++render a)))))
    AnyInd _ m  -> case lookupOrigInfo gr (m,name) of
                     Ok (m,jment) -> toHaskell gId gr absname cenv (name,jment)
                     _ -> []
    _ -> []
  where
    nf loc = normalForm cenv (L loc name)
    aId n = prefixIdent "A." (gId n)

    unAbs 0 t = t
    unAbs n (Abs _ _ t) = unAbs (n-1) t
    unAbs _ t = t


con = Cn . identS

tableTypes gr ts = S.unions (map tabtys ts)
  where
    tabtys t =
      case t of
        V t cc -> S.union (paramTypes gr t) (tableTypes gr cc)
        T (TTyped t) cs -> S.union (paramTypes gr t) (tableTypes gr (map snd cs))
        _ -> collectOp tabtys t

paramTypes gr t =
  case t of
    RecType fs -> S.unions (map (paramTypes gr.snd) fs)
    Table t1 t2 -> S.union (paramTypes gr t1) (paramTypes gr t2)
    App tf ta -> S.union (paramTypes gr tf) (paramTypes gr ta)
    Sort _ -> S.empty
    EInt _ -> S.empty
    Q q -> lookup q
    QC q -> lookup q
    FV ts -> S.unions (map (paramTypes gr) ts)
    _ -> ignore
  where
    lookup q = case lookupOrigInfo gr q of
                 Ok (_,ResOper  _ (Just (L _ t))) ->
                                       S.insert q (paramTypes gr t)
                 Ok (_,ResParam {}) -> S.singleton q
                 _ -> ignore

    ignore = trace ("Ignore: "++show t) S.empty



records ts = S.unions (map recs ts)
  where
    recs t =
      case t of
        R r -> S.insert (labels r) (records (map (snd.snd) r))
        RecType r -> S.insert (labels r) (records (map snd r))
        _ -> collectOp recs t

    labels = sort . filter (not . isLockLabel) . map fst


coerce env ty t =
  case (ty,t) of 
    (_,Let d t) -> Let d (coerce (extend env d) ty t)
    (_,FV ts) -> FV (map (coerce env ty) ts)
    (Table ti tv,V _ ts) -> V ti (map (coerce env tv) ts)
    (Table ti tv,T (TTyped _) cs) -> T (TTyped ti) (mapSnd (coerce env tv) cs)
    (RecType rt,R r) ->
      R [(l,(Just ft,coerce env ft f))|(l,(_,f))<-r,Just ft<-[lookup l rt]]
    (RecType rt,Vr x)->
      case lookup x env of
        Just ty' | ty'/=ty -> -- better to compare to normal form of ty'
          --trace ("coerce "++render ty'++" to "++render ty) $
          App (to_rcon (map fst rt)) t
        _ -> trace ("no coerce to "++render ty) t
    _ -> t
  where
    extend env (x,(Just ty,rhs)) = (x,ty):env
    extend env _ = env

convert va gId gr = convert' va gId [] gr

convert' va gId vs gr = ppT
  where
    ppT0 = convert' False gId vs gr
    ppTv vs' = convert' va gId vs' gr

    ppT t =
      case t of
         -- Only for 'let' inserted on the top-level by this converter:
        Let (x,(_,xt)) t -> let1 x (ppT0 xt) (ppT t)
--      Abs b x t -> ...
        V ty ts -> pure (c "table" `Ap` dedup ts)
        T (TTyped ty) cs -> pure (LambdaCase (map ppCase cs))
        S t p -> select (ppT t) (ppT p)
        C t1 t2 -> concat (ppT t1) (ppT t2)
        App f a -> ap (ppT f) (ppT a)
        R r -> aps (ppT (rcon (map fst r))) (fields r)
        P t l -> ap (ppT (proj l)) (ppT t)
        FV [] -> empty
        Vr x -> if x `elem` vs then pure (Var x) else Var x
        Cn x -> pure (Var x)
        Con c -> pure (Var (gId c))
        Sort k -> pure (Var k)
        EInt n -> pure (lit n)
        Q (m,n) -> if m==cPredef then pure (ppPredef n) else Var (qual m n)
        QC (m,n) -> pure (Var (gId (qual m n)))
        K s -> pure (token s)
        Empty -> pure (List [])
        FV ts@(_:_) -> variants ts
        Alts t' vs -> pure (alts t' vs)

    ppCase (p,t) = (ppP p,ppTv (patVars p++vs) t)

    ppPredef n =
      case predef n of
        Ok BIND       -> single (c "BIND")
        Ok SOFT_BIND  -> single (c "SOFT_BIND")
        Ok SOFT_SPACE -> single (c "SOFT_SPACE")
        Ok CAPIT      -> single (c "CAPIT")
        Ok ALL_CAPIT  -> single (c "ALL_CAPIT")
        _ -> Var n

    ppP p =
      case p of
        PC c ps -> ConP (gId c) (map ppP ps)
        PP (_,c) ps -> ConP (gId c) (map ppP ps)
        PR r -> ConP (rcon' (map fst r)) (map (ppP.snd) (filter (not.isLockLabel.fst) r))
        PW -> WildP
        PV x -> VarP x
        PString s -> Lit (show s) -- !!
        PInt i -> Lit (show i)
        PFloat x -> Lit (show x)
        PT _ p -> ppP p
        PAs x p -> AsP x (ppP p)
        
    token s = single (c "TK" `Ap` lit s)

    alts t' vs = single (c "TP" `Ap` List (map alt vs) `Ap` ppT0 t')
      where
        alt (t,p) = Pair (List (pre p)) (ppT0 t)

        pre (K s) = [lit s]
        pre (Strs ts) = concatMap pre ts
        pre (EPatt p) = pat p
        pre t = error $ "pre "++show t

        pat (PString s) = [lit s]
        pat (PAlt p1 p2) = pat p1++pat p2
        pat p = error $ "pat "++show p

    fields = map (ppT.snd.snd) . sort . filter (not.isLockLabel.fst)

    c = Const
    lit s = c (show s) -- hmm
    concat = if va then concat' else plusplus
      where
        concat' (List [List ts1]) (List [List ts2]) = List [List (ts1++ts2)]
        concat' t1 t2 = Op t1 "+++" t2
    pure = if va then single else id
    pure' = single -- forcing the list monad

    select = if va then select' else Ap
    select' (List [t]) (List [p]) = Op t "!" p
    select' (List [t]) p = Op t "!$" p
    select' t p = Op t "!*" p

    ap = if va then ap' else Ap
      where
        ap' (List [f]) x = fmap f x
        ap' f x = Op f "<*>" x
        fmap f (List [x]) = pure' (Ap f x)
        fmap f x = Op f "<$>" x

--  join = if va then join' else id
    join' (List [x]) = x
    join' x = c "concat" `Ap` x

    empty = if va then List [] else c "error" `Ap` c (show "empty variant")
    variants = if va then \ ts -> join' (List (map ppT ts))
                     else \ (t:_) -> ppT t

    aps f [] = f
    aps f (a:as) = aps (ap f a) as

    dedup ts =
        if M.null dups
        then List (map ppT ts)
        else Lets [(ev i,ppT t)|(i,t)<-defs] (List (zipWith entry ts is))
      where
        entry t i = maybe (ppT t) (Var . ev) (M.lookup i dups)
        ev i = identS ("e'"++show i)

        defs = [(i1,t)|(t,i1:_:_)<-ms]
        dups = M.fromList [(i2,i1)|(_,i1:is@(_:_))<-ms,i2<-i1:is]
        ms = M.toList m
        m = fmap sort (M.fromListWith (++) (zip ts [[i]|i<-is]))
        is = [0..]::[Int]

patVars p =
  case p of
    PV x -> [x]
    PAs x p -> x:patVars p
    _ -> collectPattOp patVars p

convType va gId = ppT
  where
    ppT t =
      case t of
        Table ti tv -> Fun (ppT ti) (if va then ListT (ppT tv) else ppT tv)
        RecType rt -> tcon (rcon' (map fst rt)) (fields rt)
        App tf ta -> TAp (ppT tf) (ppT ta)
        FV [] -> tcon0 (identS "({-empty variant-})")
        Sort k -> tcon0 k
        EInt n -> tcon0 (identS ("({-"++show n++"-})")) -- type level numeric literal
        FV (t:ts) -> ppT t -- !!
        QC (m,n) -> tcon0 (gId (qual m n))
        Q (m,n) -> tcon0 (gId (qual m n))
        _ -> error $ "Missing case in convType for: "++show t

    fields = map (ppT.snd) . sort . filter (not.isLockLabel.fst)

proj = con . proj'
proj' l = "proj_"++render l
rcon = con . rcon_name
rcon' = identS . rcon_name
rcon_name ls = "R"++concat (sort ['_':render l|l<-ls,not (isLockLabel l)])
to_rcon = con . to_rcon'
to_rcon' = ("to_"++) . rcon_name

recordType ls =
    Data lhs [app] ["Eq","Ord","Show"]:
    enumAllInstance:
    zipWith projection vs ls ++
    [Eqn (identS (to_rcon' ls),[VarP r])
         (foldl Ap (Var cn) [Var (identS (proj' l)) `Ap` Var r|l<-ls])]
  where
    r = identS "r"
    cn = rcon' ls
 -- Not all record labels are syntactically correct as type variables in Haskell
 -- app = cn<+>ls
    lhs = ConAp cn vs -- don't reuse record labels
    app = fmap TId lhs
    tapp = foldl TAp (TId cn) (map TId vs)
    vs = [identS ('t':show i)|i<-[1..n]]
    n = length ls

    projection v l = Instance [] (TId name `TAp` tapp `TAp` TId v)
                              [((prj,[papp]),Var v)]
     where
       name = identS ("Has_"++render l)
       prj = identS (proj' l)
       papp = ConP cn (map VarP vs)

    enumAllInstance =
       Instance ctx (tEnumAll `TAp` tapp)[(lhs0 "enumAll",enumCon cn n)]
      where
        ctx =  [tEnumAll `TAp` TId v|v<-vs]
        tEnumAll = TId (identS "EnumAll")

labelClass l =
    Class [] (ConAp name [r,a]) [([r],[a])]
          [(identS (proj' l),TId r `Fun` TId a)]
  where
    name = identS ("Has_"++render l)
    r = identS "r"
    a = identS "a"

paramType va gId gr q@(_,n) =
    case lookupOrigInfo gr q of
      Ok (m,ResParam (Just (L _ ps)) _)
       {- - | m/=cPredef && m/=moduleNameS "Prelude"-} ->
         ((S.singleton (m,n),argTypes ps),
          [Data (conap0 name) (map (param m) ps)["Eq","Ord","Show"],
           Instance [] (TId (identS "EnumAll") `TAp` TId name)
              [(lhs0 "enumAll",foldr1 plusplus (map (enumParam m) ps))]]
         )
       where name = gId (qual m n)
      Ok (m,ResOper  _ (Just (L _ t)))
        | m==cPredef && n==cInts ->
           ((S.singleton (m,n),S.empty),
            [Type (ConAp (gId (qual m n)) [identS "n"]) (TId (identS "Int"))])
        | otherwise ->
           ((S.singleton (m,n),paramTypes gr t),
            [Type (conap0 (gId (qual m n))) (convType va gId t)])
      _ -> ((S.empty,S.empty),[])
  where
    param m (n,ctx) = ConAp (gId (qual m n)) [convType va gId t|(_,_,t)<-ctx]
    argTypes = S.unions . map argTypes1
    argTypes1 (n,ctx) = S.unions [paramTypes gr t|(_,_,t)<-ctx]

    enumParam m (n,ctx) = enumCon (gId (qual m n)) (length ctx)

enumCon name arity =
    if arity==0
    then single (Var name)
    else foldl ap (single (Var name)) (replicate arity (Const "enumAll"))
  where
    ap (List [f]) a = Op f "<$>" a
    ap f a = Op f "<*>" a

qual :: ModuleName -> Ident -> Ident
qual m = prefixIdent (render m++"_")
