module GF.Compile.ConcreteToHaskell where
import Data.List(sort,sortBy,(\\))
import Data.Function(on)
import qualified Data.Map as M
import qualified Data.Set as S
import GF.Data.ErrM
import GF.Data.Utilities(mapSnd)
import GF.Text.Pretty
import GF.Grammar.Grammar
import GF.Grammar.Lookup(lookupFunType,allParamValues,lookupOrigInfo,allOrigInfos)
import GF.Grammar.Macros(typeForm,collectOp)
import GF.Grammar.Lockfield(isLockLabel)
import GF.Grammar.Predef(cPredef)
import GF.Compile.Compute.Predef(predef)
import GF.Compile.Compute.Value(Predefined(..))
import GF.Infra.Ident(Ident,identS) --,moduleNameS
import GF.Infra.Option
import GF.Grammar.Printer(getAbs)
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
      haskPreamble absname cnc $+$ "" $+$
      vcat (neededParamTypes S.empty (params defs)) $+$ "" $+$
      vcat (map signature (S.toList allcats)) $+$ "" $+$
      vcat emptydefs $+$
      vcat (map ppDef defs) $+$ "" $+$
      vcat (map labelClass (S.toList (S.unions (map S.fromList rs)))) $+$ "" $+$
      vcat (map recordType rs)
  where
    rs = S.toList (S.insert [ident2label (identS "s")] (records rhss))
    rhss = map (snd.snd) defs
    defs = sortBy (compare `on` fst) .
           concatMap (toHaskell gId gr absname cenv) . 
           M.toList $
           jments modinfo

    signature c = "lin"<>c<+>"::"<+>"A."<>gId c<+>"->"<+>"Lin"<>c

    emptydefs = map emptydef (S.toList emptyCats)
    emptydef c = "lin"<>c<+>"_"<+>"="<+>"undefined"

    emptyCats = allcats `S.difference` cats
    cats = S.fromList [c|(Just c,_)<-defs]
    allcats = S.fromList [c|((_,c),AbsCat (Just _))<-allOrigInfos gr absname]
            
    params = S.toList . S.unions . map params1
    params1 (Nothing,(_,rhs)) = paramTypes gr rhs
    params1 (_,(_,rhs)) = tableTypes gr [rhs]

    ppDef (Nothing,(lhs,rhs)) = hang (lhs<+>"=") 4 (convType gId rhs)
    ppDef (_,(lhs,rhs)) = hang (lhs<+>"=") 4 (convert gId gr rhs)

    gId :: Ident -> Doc
    gId = if haskellOption opts HaskellNoPrefix then pp else  ("G"<>).pp

    neededParamTypes have [] = []
    neededParamTypes have (q:qs) =
        if q `S.member` have
        then neededParamTypes have qs
        else let ((got,need),def) = paramType gId gr q
             in def:neededParamTypes (S.union got have) (S.toList need++qs)

haskPreamble :: ModuleName -> ModuleName -> Doc
haskPreamble absname cncname =
  "{-# LANGUAGE MultiParamTypeClasses, FunctionalDependencies, FlexibleInstances, LambdaCase #-}" $+$
  "module" <+> cncname <+> "where" $+$
  "import Prelude hiding (Ordering(..))" $$
  "import qualified Data.Map as M" $+$
  "import Data.Map((!))" $+$
  "import qualified" <+> absname <+> "as A" $+$
  "----------------------------------------------------" $$
  "-- automatic translation from GF to Haskell" $$
  "----------------------------------------------------" $$
  "type Str = [String]" $$
  "linString (A.GString s) = R_s [s]" $$
  "linInt (A.GInt i) = R_s [show i]" $$
  "linFloat (A.GFloat x) = R_s [show x]" $$
  "" $$
  "table is vs = let m = M.fromList (zip is vs) in (m!)"

toHaskell gId gr absname cenv (name,jment) =
  case jment of
    CncCat (Just (L loc typ)) _ _ pprn _ ->
        [(Nothing,("type"<+>"Lin"<>name,nf loc typ))]
    CncFun (Just r@(cat,ctx,lincat)) (Just (L loc def)) pprn _ ->
        [(Just cat,("lin"<>cat<+>lhs,coerce lincat rhs))]
      where
        Ok abstype = lookupFunType gr absname name
        (absctx,abscat,absargs) = typeForm abstype

        (xs,e') = getAbs (nf loc def)
        args = map snd xs
        abs_args = map ("abs_"<>) args
        lhs = if null args then aId name else parens (aId name<+>hsep abs_args)
        rhs = foldr letlin e' (zip args absctx)
        letlin (a,(_,_,at)) =
           Let (a,(Nothing,(App (con ("lin"++render at)) (con ("abs_"++render a)))))
    AnyInd _ m  -> case lookupOrigInfo gr (m,name) of
                     Ok (m,jment) -> toHaskell gId gr absname cenv (name,jment)
                     _ -> []
    _ -> []
  where
    nf loc = normalForm cenv (L loc name)
    aId n = "A."<>gId n

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
    Sort _ -> S.empty
    Q q -> lookup q
    QC q -> lookup q
    _ -> ignore
  where
    lookup q = case lookupOrigInfo gr q of
                 Ok (_,ResOper  _ (Just (L _ t))) -> paramTypes gr t
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


coerce ty t =
  case (ty,t) of 
    (_,Let d t) -> Let d (coerce ty t)
    (_,FV ts) -> FV (map (coerce ty) ts)
    (Table ti tv,V _ ts) -> V ti (map (coerce tv) ts)
    (Table ti tv,T (TTyped _) cs) -> T (TTyped ti) (mapSnd (coerce tv) cs)
    (RecType rt,R r) ->
      R [(l,(Just ft,coerce ft f))|(l,(_,f))<-r,Just ft<-[lookup l rt]]
    _ -> t


convert gId = convert' False gId
convertA gId = convert' True gId

convert' atomic gId gr = if atomic then ppA else ppT
  where
    ppT t =
      case t of
        Let (x,(_,xt)) t -> sep ["let"<+>x<+>"="<+>ppT xt,"in"<+>ppT t]
        Abs b x t -> "\\"<+>x<+>"->"<+>ppT t
        V ty ts -> hang "table" 4 (sep [list (enumAll ty),list ts])
        T (TTyped ty) cs -> hang "\\case" 2 (vcat (map ppCase cs))
        S t p -> hang (ppB t) 4 (ppA p)
        C t1 t2 -> hang (ppA t1<+>"++") 4 (ppA t2)
        _ -> ppB t

    ppCase (p,t) = hang (ppP p <+> "->") 4 (ppT t)

    ppB t =
      case t of
        App f a -> ppB f<+>ppA a
        R r -> rcon (map fst r)<+>fsep (fields r)
        P t l -> ppB (proj l)<+>ppA t
        FV [] -> "error"<+>doubleQuotes "empty variant"
        _ -> ppA t

    ppA t =
      case t of
        Vr x -> pp x
        Cn x -> pp x
        Con c -> gId c
        Sort k -> pp k
        Q (m,n) -> if m==cPredef
                   then ppPredef n
                   else pp n
        QC (m,n) -> gId n
        K s -> token s
        Empty -> pp "[]"
        FV (t:ts) -> ppA t -- !!
        Alts t _ -> ppA t -- !!!
        _ -> {-trace (show t) $-} parens (ppT t)

    ppPredef n =
      case predef n of
        Ok BIND -> token "&+"
        Ok SOFT_BIND -> token "SOFT_BIND" -- hmm
        Ok CAPIT -> token "CAPIT" -- hmm
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
        
    token = brackets . doubleQuotes

    list = brackets . fsep . punctuate "," . map ppT

    fields = map (ppA.snd.snd) . sort . filter (not.isLockLabel.fst)

    enumAll ty = case allParamValues gr ty of
                   Ok ts -> ts

convType gId = ppT
  where
    ppT t =
      case t of
        Table ti tv -> ppB ti <+> "->" <+> ppT tv
        _ -> ppB t

    ppB t =
      case t of
        RecType rt -> rcon (map fst rt)<+>fsep (fields rt)
        _ -> ppA t

    ppA t =
      case t of
        Sort k -> pp k
        QC (m,n) -> gId n
        _ -> {-trace (show t) $-} parens (ppT t)

    fields = map (ppA.snd) . sort . filter (not.isLockLabel.fst)

proj l = con ("proj_"++render l)
rcon ls = con ("R"++concat (sort ['_':render l|l<-ls,not (isLockLabel l)]))

recordType ls =
    "data"<+>app<+>"="<+>app <+> "deriving (Eq,Ord,Show)" $+$
    vcat (map projection ls) $+$ ""
  where
    n = rcon ls
    app = n<+>ls

    projection l = 
       hang ("instance"<+>"Has_"<>l<+>parens app<+>l<+>"where") 4
            (proj l<+>parens app<+>"="<+>l)

labelClass l =
    hang ("class"<+>"Has_"<>l<+>"r"<+>"a"<+>"| r -> a"<+>"where") 4
         (proj l<+>"::"<+>"r -> a")

paramType gId gr q@(_,n) =
    case lookupOrigInfo gr q of
      Ok (m,ResParam (Just (L _ ps)) _)
       | True {-m/=cPredef && m/=moduleNameS "Prelude"-} ->
         ((S.singleton (m,n),argTypes ps),
          "data"<+>gId (snd q)<+>"="<+>
               sep [fsep (punctuate " |" (map param ps)),
                    pp "deriving (Eq,Ord,Show)"])
      _ -> ((S.empty,S.empty),empty)
  where
    param (n,ctx) = gId n<+>[convertA gId gr t|(_,_,t)<-ctx]
    argTypes = S.unions . map argTypes1
    argTypes1 (n,ctx) = S.unions [paramTypes gr t|(_,_,t)<-ctx]
