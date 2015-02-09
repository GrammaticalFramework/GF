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
    render $
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
    signature c = "lin"<>c<+>"::"<+>"A."<>gId c<+>"->"<+>pure ("Lin"<>c)

    emptydefs = map emptydef (S.toList emptyCats)
    emptydef c = "lin"<>c<+>"_"<+>"="<+>"undefined"

    emptyCats = allcats `S.difference` cats
    cats = S.fromList [c|(Just c,_)<-defs]
    allcats = S.fromList [c|((_,c),AbsCat (Just _))<-allOrigInfos gr absname]
            
    params = S.toList . S.unions . map params1
    params1 (Nothing,(_,rhs)) = paramTypes gr rhs
    params1 (_,(_,rhs)) = tableTypes gr [rhs]

    ppDef (Nothing,(lhs,rhs)) = hang (lhs<+>"=") 4 (convType va gId rhs)
    ppDef (_,(lhs,rhs)) = hang (lhs<+>"=") 4 (convert va gId gr rhs)

    gId :: Ident -> Doc
    gId = if haskellOption opts HaskellNoPrefix then pp else  ("G"<>).pp
    va = haskellOption opts HaskellVariants
    pure = if va then brackets else pp

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
  "import Control.Applicative(Applicative,pure,empty,(<$>),(<*>))" $$
--"import Data.Foldable(asum)" $$
--"import Control.Monad(join)" $$
  "import qualified Data.Map as M" $$
  "import Data.Map((!))" $$
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
        lhs = if null args then aId name else parens (aId name<+>hsep abs_args)
        rhs = foldr letlin e' (zip args absctx)
        letlin (a,(_,_,at)) =
           Let (a,(Just (con ("Lin"++render at)),(App (con ("lin"++render at)) (con ("abs_"++render a)))))
    AnyInd _ m  -> case lookupOrigInfo gr (m,name) of
                     Ok (m,jment) -> toHaskell gId gr absname cenv (name,jment)
                     _ -> []
    _ -> []
  where
    nf loc = normalForm cenv (L loc name)
    aId n = "A."<>gId n

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

convert va gId = convert' False va gId []
convertA va gId = convert' True va gId []

convert' atomic va gId vs gr = if atomic then ppA else ppT
  where
    ppT0 = convert' False False gId vs gr
    ppA0 = convert' True False gId vs gr
    ppTv vs' = convert' atomic va gId vs' gr

    ppT = ppT' False
    ppT' loop t =
      case t of
        Let (x,(_,xt)) t -> sep ["let"<+>x<+>"="<+>ppT0 xt,"in"<+>ppT t]
--      Abs b x t -> "\\"<+>x<+>"->"<+>ppT t
--      V ty ts -> hang "table" 4 (sep [list (enumAll ty),list ts])
        V ty ts -> pure (hang "table" 4 (dedup ts))
        T (TTyped ty) cs -> pure (hang "\\case" 2 (vcat (map ppCase cs)))
        S t p -> join (ap t p)
        C t1 t2 -> hang (ppA t1<+>concat) 4 (ppA t2)
        _ -> ppB' loop t

    ppCase (p,t) = hang (ppP p <+> "->") 4 (ppTv (patVars p++vs) t)

    ppB = ppB' False
    ppB' loop t =
      case t of
        App f a -> ap f a
        R r -> aps (ppA (rcon (map fst r))) (fields r)
        P t l -> ap (proj l) t
        FV [] -> empty
        _ -> ppA' loop t

    ppA = ppA' False

    ppA' True t = error $ "Missing case in convert': "++show t
    ppA' loop t =
      case t of
        Vr x -> if x `elem` vs then pureA (pp x) else pp x
        Cn x -> pureA (pp x)
        Con c -> pureA (gId c)
        Sort k -> pureA (pp k)
        EInt n -> pureA (pp n)
        Q (m,n) -> if m==cPredef
                   then pureA (ppPredef n)
                   else pp (qual m n)
        QC (m,n) -> pureA (gId (qual m n))
        K s -> pureA (token s)
        Empty -> pureA (pp "[]")
        FV ts@(_:_) -> variants ts
        Alts t' vs -> pureA (alts t' vs)
        _ -> parens (ppT' True t)

    ppPredef n =
      case predef n of
        Ok BIND      -> brackets "BIND"
        Ok SOFT_BIND -> brackets "SOFT_BIND"
        Ok CAPIT     -> brackets "CAPIT"
        _ -> pp n

    ppP p =
      case p of
        PC c ps -> gId c<+>fsep (map ppAP ps)
        PP (_,c) ps -> gId c<+>fsep (map ppAP ps)
        PR r -> rcon (map fst r)<+>fsep (map (ppAP.snd) (filter (not.isLockLabel.fst) r))
        _ -> ppAP p

    ppAP p =
      case p of
        PW -> pp "_"
        PV x -> pp x
        PString s -> doubleQuotes s
        PInt i -> pp i
        PFloat x -> pp x
        PT _ p -> ppAP p
        PAs x p -> x<>"@"<>ppAP p
        _ -> parens (ppAP p)
        
    token s = brackets ("TK"<+>doubleQuotes s)

    alts t' vs = brackets ("TP" <+> list' (map alt vs) <+> ppA0 t')
      where
        alt (t,p) = parens (show (pre p)<>","<>ppT0 t)

        pre (K s) = [s]
        pre (Strs ts) = concatMap pre ts
        pre (EPatt p) = pat p
        pre t = error $ "pre "++show t

        pat (PString s) = [s]
        pat (PAlt p1 p2) = pat p1++pat p2
        pat p = error $ "pat "++show p

    fields = map (ppA.snd.snd) . sort . filter (not.isLockLabel.fst)

    concat = if va then "+++" else "++"
--  pure = if va then \ x -> "pure"<+>parens x else id
--  pureA = if va then \ x -> parens ("pure"<+>x) else id
    pure = if va then \ x -> brackets x else id -- forcing the list monad
    pureA = pure
    ap = if va then \ f x -> hang (ppA f<+>"<*>") 4 (ppA x)
               else \ f x -> hang (ppB f) 4 (ppA x)
    join = if va then \ x -> parens ("concat"<+>parens x) else id
--  sequence = if va then \ x -> parens ("sequence"<+>parens x) else id
    empty = if va then pp "[]" else "error"<+>doubleQuotes "empty variant"
    variants = if va then \ ts -> "concat"<+>list ts
                     else \ (t:_) -> "{-variants-}"<>ppA t -- !!

    aps f [] = f
    aps f (a:as) = aps (if va then hang (f<+>"<*>") 4 a else hang f 4 a) as

--  enumAll ty = case allParamValues gr ty of Ok ts -> ts

    list = brackets . fsep . punctuate "," . map ppT
    list' = brackets . fsep . punctuate ","

    dedup ts =
        if M.null dups
        then list ts
        else parens $
             "let"<+>vcat [ev i<+>"="<+>ppT t|(i,t)<-defs] $$
             "in"<+>list' (zipWith entry ts is)
      where
        entry t i = maybe (ppT t) ev (M.lookup i dups)
        ev i = "e'"<>i

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

convType = convType' False
convTypeA = convType' True

convType' atomic va gId = if atomic then ppA else ppT
  where
    ppT = ppT' False
    ppT' loop t =
      case t of
        Table ti tv -> ppB ti <+> "->" <+>
                       if va then brackets (ppT tv) else ppT tv
        _ -> ppB' loop t

    ppB = ppB' False
    ppB' loop t =
      case t of
        RecType rt -> rcon (map fst rt)<+>fsep (fields rt)
        App tf ta -> ppB tf <+> ppA ta
        FV [] -> pp "({-empty variant-})"
        _ -> ppA' loop t

    ppA = ppA' False
    ppA' True t = error $ "Missing case in convType for: "++show t
    ppA' loop t =
      case t of
        Sort k -> pp k
        EInt n -> parens ("{-"<>n<>"-}") -- type level numeric literal
        FV (t:ts) -> "{-variants-}"<>ppA t -- !!
        QC (m,n) -> gId (qual m n)
        Q (m,n) -> gId (qual m n)
        _ -> {-trace (show t) $-} parens (ppT' True t)

    fields = map (ppA.snd) . sort . filter (not.isLockLabel.fst)

proj l = con ("proj_"++render l)
rcon = con . rcon_name
rcon_name ls = "R"++concat (sort ['_':render l|l<-ls,not (isLockLabel l)])
to_rcon = con . ("to_"++) . rcon_name

recordType ls =
    "data"<+>app<+>"="<+>app <+> "deriving (Eq,Ord,Show)" $$
    enumAllInstance $$
    vcat (zipWith projection vs ls) $$
    to_rcon ls<+>"r"<+>"="<+>cn<+>fsep [parens (proj l<+>"r")|l<-ls] $$ ""
  where
    cn = rcon ls
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
            ("enumAll"<+>"="<+>enumCon cn n)
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
          "data"<+>gId (qual m n)<+>"="<+>
               sep [fsep (punctuate " |" (map (param m) ps)),
                    pp "deriving (Eq,Ord,Show)"] $$
          hang ("instance EnumAll"<+>gId (qual m n)<+>"where") 4
               ("enumAll"<+>"="<+>sep (punctuate " ++" (map (enumParam m) ps)))
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
    param m (n,ctx) = gId (qual m n)<+>[convTypeA va gId t|(_,_,t)<-ctx]
    argTypes = S.unions . map argTypes1
    argTypes1 (n,ctx) = S.unions [paramTypes gr t|(_,_,t)<-ctx]

    enumParam m (n,ctx) = enumCon (gId (qual m n)) (length ctx)

enumCon name arity =
    if arity==0
    then brackets name
    else parens $
         fsep ((name<+>"<$>"):punctuate " <*>" (replicate arity (pp "enumAll")))

qual :: ModuleName -> Ident -> Ident
qual m = prefixIdent (render m++"_")
