-- | Abstract syntax and a pretty printer for a subset of Haskell
{-# LANGUAGE DeriveFunctor #-}
module GF.Haskell where
import Prelude hiding ((<>)) -- GHC 8.4.1 clash with Text.PrettyPrint
import GF.Infra.Ident(Ident,identS)
import GF.Text.Pretty

-- | Top-level declarations
data Dec = Comment String
         | Type (ConAp Ident) Ty
         | Data (ConAp Ident) [ConAp Ty] Deriving
         | Class [ConAp Ident] (ConAp Ident) FunDeps [(Ident,Ty)]
         | Instance [Ty] Ty [(Lhs,Exp)]
         | TypeSig Ident Ty
         | Eqn Lhs Exp

-- | A type constructor applied to some arguments
data ConAp a = ConAp Ident [a] deriving Functor
conap0 n = ConAp n []
tsyn0 = Type . conap0

type Deriving = [Const]
type FunDeps = [([Ident],[Ident])]
type Lhs = (Ident,[Pat])
lhs0 s = (identS s,[])

-- | Type expressions
data Ty  = TId Ident | TAp Ty Ty | Fun Ty Ty | ListT Ty

-- | Expressions
data Exp = Var Ident | Const Const | Ap Exp Exp | Op Exp Const Exp
         | List [Exp] | Pair Exp Exp
         | Lets [(Ident,Exp)] Exp | LambdaCase [(Pat,Exp)]
type Const = String

-- | Patterns
data Pat = WildP | VarP Ident | Lit String | ConP Ident [Pat] | AsP Ident Pat

tvar = TId
tcon0 = TId
tcon c = foldl TAp (TId c)

let1 x xe e = Lets [(x,xe)] e
single x = List [x]

plusplus (List ts1) (List ts2) = List (ts1++ts2)
plusplus (List [t]) t2 = Op t ":" t2
plusplus t1 t2 = Op t1 "++" t2

-- | Pretty print atomically (i.e. wrap it in parentheses if necessary)
class Pretty a => PPA a where ppA :: a -> Doc

instance PPA Ident where ppA = pp

instance Pretty Dec where
  ppList = vcat
  pp d =
    case d of
      Comment s -> pp s
      Type lhs rhs -> hang ("type"<+>lhs<+>"=") 4 rhs
      Data lhs cons ds ->
        hang ("data"<+>lhs) 4
             (sep (zipWith (<+>) ("=":repeat "|") cons++
                  ["deriving"<+>parens (punctuate "," ds)|not (null ds)]))
      Class ctx cls fds sigs ->
        hang ("class"<+>sep [ppctx ctx,pp cls]<+>ppfds fds <+>"where") 4
             (vcat (map ppSig sigs))
      Instance ctx inst eqns ->
        hang ("instance"<+>sep [ppctx ctx,pp inst]<+>"where") 4
             (vcat (map ppEqn eqns))
      TypeSig f ty -> hang (f<+>"::") 4 ty
      Eqn lhs rhs -> ppEqn (lhs,rhs)
    where
      ppctx ctx = case ctx of
                    [] -> empty
                    [p] -> p <+> "=>"
                    ps -> parens (fsep (punctuate "," ps)) <+> "=>"

      ppfds [] = empty
      ppfds fds = "|"<+>fsep (punctuate "," [hsep as<+>"->"<+>bs|(as,bs)<-fds])

      ppEqn ((f,ps),e) = hang (f<+>fsep (map ppA ps)<+>"=") 4 e

      ppSig (f,ty) = f<+>"::"<+>ty

instance PPA a => Pretty (ConAp a) where
  pp (ConAp c as) = c<+>fsep (map ppA as)

instance Pretty Ty where
  pp = ppT
    where
      ppT t = case flatFun t of t:ts -> sep (ppB t:["->"<+>ppB t|t<-ts])
      ppB t = case flatTAp t of t:ts -> ppA t<+>sep (map ppA ts)

      flatFun (Fun t1 t2) = t1:flatFun t2 -- right associative
      flatFun t = [t]

      flatTAp (TAp t1 t2) = flatTAp t1++[t2] -- left associative
      flatTAp t = [t]

instance PPA Ty where
  ppA t =
    case t of
      TId c -> pp c
      ListT t -> brackets t
      _ -> parens t

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

      flatAp (Ap t1 t2) = flatAp t1++[t2] -- left associative
      flatAp t = [t]

instance PPA Exp where
  ppA e =
    case e of
      Var x -> pp x
      Const n -> pp n
      Pair e1 e2 -> parens (e1<>","<>e2)
      List es -> brackets (fsep (punctuate "," es))
      _ -> parens e

instance Pretty Pat where
  pp p =
    case p of
      ConP c ps -> c<+>fsep (map ppA ps)
      _ -> ppA p

instance PPA Pat where
  ppA p =
    case p of
      WildP -> pp "_"
      VarP x -> pp x
      Lit s -> pp s
      ConP c [] -> pp c
      AsP x p -> x<>"@"<>ppA p
      _ -> parens p
