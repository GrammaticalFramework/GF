module GF.Compile.ConcreteToHaskell where
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
import Debug.Trace

concretes2haskell opts absname gr =
  [(cncname,concrete2haskell opts gr cenv absname cnc cncmod)
     | let cenv = resourceValues gr,
       cnc<-allConcretes gr absname,
       let cncname = render cnc ++ ".hs"
           Ok cncmod = lookupModule gr cnc
  ]

concrete2haskell opts gr cenv absname cnc modinfo =
    renderStyle style{lineLength=80,ribbonsPerLine=1} $
      haskPreamble va absname cnc $$ "" $$
      "--- Parameter types ---" $$
      vcat (neededParamTypes S.empty (params defs)) $$ "" $$
      "--- Type signatures for linearization functions ---" $$
      vcat (map signature (S.toList allcats)) $$ "" $$
      "--- Linearization functions for empty categories ---" $$
      vcat emptydefs $$ "" $$
      "--- Linearization types and linearization functions ---" $$
      vcat (map ppDef defs) $$ "" $$
      "--- Type classes for projection functions ---" $$
      vcat (map labelClass (S.toList labels)) $$ "" $$
      "--- Record types ---" $$
      vcat (map recordType recs)
  where
    labels = S.difference (S.unions (map S.fromList recs)) common_labels
    recs = S.toList (S.difference (records rhss) common_records)
    common_records = S.fromList [[label_s]]
    common_labels = S.fromList [label_s]
    label_s = ident2label (identS "s")

    rhss = map (snd.snd) defs
    defs = sortBy (compare `on` fst) .
           concatMap (toHaskell gId gr absname cenv) . 
           M.toList $
           jments modinfo

--  signature c = "lin"<>c<+>"::"<+>"A."<>gId c<+>"->"<+>"Lin"<>c
--  signature c = "--lin"<>c<+>":: (Applicative f,Monad f) =>"<+>"A."<>gId c<+>"->"<+>"f Lin"<>c
    signature c = "lin"<>c<+>"::"<+>Fun abs (pure lin)
      where
        abs = tcon0 (prefixIdent "A." (gId c))
        lin = tcon0 (prefixIdent "Lin" c)

    emptydefs = map emptydef (S.toList emptyCats)
    emptydef c = "lin"<>c<+>"_"<+>"="<+>"undefined"

    emptyCats = allcats `S.difference` cats
    cats = S.fromList [c|(Just c,_)<-defs]
    allcats = S.fromList [c|((_,c),AbsCat (Just _))<-allOrigInfos gr absname]
            
    params = S.toList . S.unions . map params1
    params1 (Nothing,(_,rhs)) = paramTypes gr rhs
    params1 (_,(_,rhs)) = tableTypes gr [rhs]

    ppDef (Nothing,(lhs,rhs)) = hang (lhs<+>"=") 2 (convType va gId rhs)
    ppDef (_,(lhs,rhs)) = hang (lhs<+>"=") 2 (convert va gId gr rhs)

    gId :: Ident -> Ident
    gId = if haskellOption opts HaskellNoPrefix then id else prefixIdent "G"
    va = haskellOption opts HaskellVariants
    pure = if va then ListT else id

    neededParamTypes have [] = []
    neededParamTypes have (q:qs) =
        if q `S.member` have
        then neededParamTypes have qs
        else let ((got,need),def) = paramType va gId gr q
             in def:neededParamTypes (S.union got have) (S.toList need++qs)

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
        [(Nothing,("type"<+>"Lin"<>name,nf loc typ))]
    CncFun (Just r@(cat,ctx,lincat)) (Just (L loc def)) pprn _ ->
--      trace (render (name<+>hcat[parens (x<>"::"<>t)|(_,x,t)<-ctx]<+>"::"<+>cat)) $
        [(Just cat,("lin"<>cat<+>lhs,coerce [] lincat rhs))]
      where
        Ok abstype = lookupFunType gr absname name
        (absctx,abscat,absargs) = typeForm abstype

        e' = unAbs (length params) $
             nf loc (mkAbs params (mkApp def (map Vr args)))
        params = [(b,prefixIdent "g" x)|(b,x,_)<-ctx]
        args = map snd params
        abs_args = map ("abs_"<>) args
        lhs = if null args then pp (aId name)
                           else parens (aId name<+>hsep abs_args)
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
        Ok BIND      -> single (c "BIND")
        Ok SOFT_BIND -> single (c "SOFT_BIND")
        Ok CAPIT     -> single (c "CAPIT")
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

proj l = con ("proj_"++render l)
rcon = con . rcon_name
rcon' = identS . rcon_name
rcon_name ls = "R"++concat (sort ['_':render l|l<-ls,not (isLockLabel l)])
to_rcon = con . ("to_"++) . rcon_name

recordType ls =
    "data"<+>app<+>"="<+>app <+> "deriving (Eq,Ord,Show)" $$
    enumAllInstance $$
    vcat (zipWith projection vs ls) $$
    hang (to_rcon ls<+>"r"<+>"=") 4
         (cn<+>fsep [parens (proj l<+>"r")|l<-ls]) $$ ""
  where
    cn = rcon ls
    cn' = rcon' ls
 -- Not all record labels are syntactically correct as type variables in Haskell
 -- app = cn<+>ls
    app = cn<+>hsep vs -- don't reuse record labels
    vs = ["t"<>i|i<-[1..n]]
    n = length ls

    projection v l =
       hang ("instance"<+>"Has_"<>l<+>parens app<+>v<+>"where") 4
            (proj l<+>parens app<+>"="<+>v)

    enumAllInstance =
       hang ("instance"<+>ctx<+>"EnumAll"<+>parens app<+>"where") 4
            (hang ("enumAll"<+>"=") 4 (enumCon cn' n))
      where
        ctx = if n==0
              then empty
              else parens (fsep (punctuate "," ["EnumAll"<+>v|v<-vs]))<+>"=>"

labelClass l =
    hang ("class"<+>"Has_"<>l<+>"r"<+>"a"<+>"| r -> a"<+>"where") 4
         (proj l<+>"::"<+>"r -> a")

paramType va gId gr q@(_,n) =
    case lookupOrigInfo gr q of
      Ok (m,ResParam (Just (L _ ps)) _)
       {- - | m/=cPredef && m/=moduleNameS "Prelude"-} ->
         ((S.singleton (m,n),argTypes ps),
          hang ("data"<+>gId (qual m n)<+>"=") 7
               (sep [fsep (punctuate " |" (map (param m) ps)),
                    pp "deriving (Eq,Ord,Show)"]) $$
          hang ("instance EnumAll"<+>gId (qual m n)<+>"where") 4
               ("enumAll"<+>"="<+>foldr1 plusplus (map (enumParam m) ps))
         )
      Ok (m,ResOper  _ (Just (L _ t)))
        | m==cPredef && n==cInts ->
           ((S.singleton (m,n),S.empty),
            "type"<+>gId (qual m n)<+>"n = Int")
        | otherwise ->
           ((S.singleton (m,n),paramTypes gr t),
            "type"<+>gId (qual m n)<+>"="<+>convType va gId t)
      _ -> ((S.empty,S.empty),empty)
  where
    param m (n,ctx) = tcon (gId (qual m n)) [convType va gId t|(_,_,t)<-ctx]
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

--------------------------------------------------------------------------------
-- ** A Haskell subset

data Ty  = TId Ident | TAp Ty Ty | Fun Ty Ty | ListT Ty

data Exp = Var Ident | Const String | Ap Exp Exp | Op Exp String Exp
         | List [Exp] | Pair Exp Exp
         | Lets [(Ident,Exp)] Exp | LambdaCase [(Pat,Exp)]

data Pat = WildP | VarP Ident | Lit String | ConP Ident [Pat] | AsP Ident Pat

tvar = TId
tcon0 = TId
tcon c = foldl TAp (TId c)

let1 x xe e = Lets [(x,xe)] e
single x = List [x]

plusplus (List ts1) (List ts2) = List (ts1++ts2)
plusplus (List [t]) t2 = Op t ":" t2
plusplus t1 t2 = Op t1 "++" t2

instance Pretty Ty where
  pp = ppT
    where
      ppT t = case flatFun t of t:ts -> sep (ppB t:["->"<+>ppB t|t<-ts])
      ppB t = case flatTAp t of t:ts -> ppA t<+>sep (map ppA ts)

      ppA t =
        case t of
          TId c -> pp c
          ListT t -> brackets t
          _ -> parens t

      flatFun (Fun t1 t2) = t1:flatFun t2 -- right associative
      flatFun t = [t]

      flatTAp (TAp t1 t2) = flatTAp t1++[t2] -- left associative
      flatTAp t = [t]

instance Pretty Exp where
  pp = ppT
    where
      ppT e =
        case e of
          Op e1 op e2 -> hang (ppB e1<+>op) 2 (ppB e2)
          Lets bs e -> sep ["let"<+>vcat [hang (x<+>"=") 2 xe|(x,xe)<-bs],
                            "in" <+>e]
          LambdaCase alts -> hang "\\case" 4 (vcat [p<+>"->"<+>e|(p,e)<-alts])
          _ -> ppB e

      ppB e = case flatAp e of f:as -> hang (ppA f) 2 (sep (map ppA as))

      ppA e =
        case e of
          Var x -> pp x
          Const n -> pp n
          Pair e1 e2 -> parens (e1<>","<>e2)
          List es -> brackets (fsep (punctuate "," es))
          _ -> parens e

      flatAp (Ap t1 t2) = flatAp t1++[t2] -- left associative
      flatAp t = [t]

instance Pretty Pat where
  pp = ppP
    where
      ppP p =
        case p of
          ConP c ps -> c<+>fsep (map ppPA ps)
          _ -> ppPA p
      ppPA p =
        case p of
          WildP -> pp "_"
          VarP x -> pp x
          Lit s -> pp s
          AsP x p -> x<>"@"<>parens p
          _ -> parens p
