module GF.Compile.GFCCtoJS (pgf2js) where

import PGF.CId
import PGF.Data
import qualified PGF.Macros as M
import qualified GF.JavaScript.AbsJS as JS
import qualified GF.JavaScript.PrintJS as JS

import GF.Text.UTF8
import GF.Data.ErrM
import GF.Infra.Option

import Control.Monad (mplus)
import Data.Array.Unboxed (UArray)
import qualified Data.Array.IArray as Array
import Data.Maybe (fromMaybe)
import Data.Map (Map)
import qualified Data.Set as Set
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap

pgf2js :: PGF -> String
pgf2js pgf =
  encodeUTF8 $ JS.printTree $ JS.Program [JS.ElStmt $ JS.SDeclOrExpr $ JS.Decl [JS.DInit (JS.Ident n) grammar]]
 where
   n  = prCId $ absname pgf
   as = abstract pgf
   cs = Map.assocs (concretes pgf)
   start = prCId $ M.lookStartCat pgf
   grammar = new "GFGrammar" [js_abstract, js_concrete]
   js_abstract = abstract2js start as
   js_concrete = JS.EObj $ map (concrete2js start n) cs

abstract2js :: String -> Abstr -> JS.Expr
abstract2js start ds = new "GFAbstract" [JS.EStr start, JS.EObj $ map absdef2js (Map.assocs (funs ds))]

absdef2js :: (CId,(Type,[Equation])) -> JS.Property
absdef2js (f,(typ,_)) =
  let (args,cat) = M.catSkeleton typ in 
    JS.Prop (JS.IdentPropName (JS.Ident (prCId f))) (new "Type" [JS.EArray [JS.EStr (prCId x) | x <- args], JS.EStr (prCId cat)])

concrete2js :: String -> String -> (CId,Concr) -> JS.Property
concrete2js start n (c, cnc) =
    JS.Prop l (new "GFConcrete" ([flags,(JS.EObj $ ((map (cncdef2js n (prCId c)) ds) ++ litslins))] ++
                                 maybe [] (parser2js start) (parser cnc)))
  where 
   flags = mapToJSObj JS.EStr $ cflags cnc
   l  = JS.IdentPropName (JS.Ident (prCId c))
   ds = concatMap Map.assocs [lins cnc, opers cnc, lindefs cnc]
   litslins = [JS.Prop (JS.StringPropName    "Int") (JS.EFun [children] [JS.SReturn $ new "Arr" [JS.EIndex (JS.EVar children) (JS.EInt 0)]]), 
               JS.Prop (JS.StringPropName  "Float") (JS.EFun [children] [JS.SReturn $ new "Arr" [JS.EIndex (JS.EVar children) (JS.EInt 0)]]),
               JS.Prop (JS.StringPropName "String") (JS.EFun [children] [JS.SReturn $ new "Arr" [JS.EIndex (JS.EVar children) (JS.EInt 0)]])]


cncdef2js :: String -> String -> (CId,Term) -> JS.Property
cncdef2js n l (f, t) = JS.Prop (JS.IdentPropName (JS.Ident (prCId f))) (JS.EFun [children] [JS.SReturn (term2js n l t)])

term2js :: String -> String -> Term -> JS.Expr
term2js n l t = f t
  where 
  f t = 
    case t of
      R xs           -> new "Arr" (map f xs)
      P x y          -> JS.ECall (JS.EMember (f x) (JS.Ident "sel")) [f y]
      S xs           -> mkSeq (map f xs)
      K t            -> tokn2js t
      V i            -> JS.EIndex (JS.EVar children) (JS.EInt i)
      C i            -> new "Int" [JS.EInt i]
      F f            -> JS.ECall (JS.EMember (JS.EIndex (JS.EMember (JS.EVar $ JS.Ident n) (JS.Ident "concretes")) (JS.EStr l)) (JS.Ident "rule")) [JS.EStr (prCId f), JS.EVar children]
      FV xs          -> new "Variants" (map f xs)
      W str x        -> new "Suffix" [JS.EStr str, f x]
      TM _           -> new "Meta" []

tokn2js :: Tokn -> JS.Expr
tokn2js (KS s) = mkStr s
tokn2js (KP ss vs) = mkSeq (map mkStr ss) -- FIXME

mkStr :: String -> JS.Expr
mkStr s = new "Str" [JS.EStr s]

mkSeq :: [JS.Expr] -> JS.Expr
mkSeq [x] = x
mkSeq xs = new "Seq" xs

argIdent :: Integer -> JS.Ident
argIdent n = JS.Ident ("x" ++ show n)

children :: JS.Ident
children = JS.Ident "cs"

-- Parser
parser2js :: String -> ParserInfo -> [JS.Expr]
parser2js start p  = [new "Parser" [JS.EStr start,
                                    JS.EArray $ [frule2js p cat prod | (cat,set) <- IntMap.toList (productions p), prod <- Set.toList set],
                                    JS.EObj $ map cats (Map.assocs (startCats p))]]
  where 
    cats (c,is) = JS.Prop (JS.IdentPropName (JS.Ident (prCId c))) (JS.EArray (map JS.EInt is))

frule2js :: ParserInfo -> FCat -> Production -> JS.Expr
frule2js p res (FApply funid args) = new "Rule" [JS.EInt res, name2js (f,ps), JS.EArray (map JS.EInt args), lins2js p lins]
  where
    FFun f ps lins = functions p Array.! funid
frule2js p res (FCoerce arg) = new "Rule" [JS.EInt res, daughter 0, JS.EArray [JS.EInt arg], JS.EArray [JS.EArray [sym2js (FSymCat 0 i)] | i <- [0..catLinArity arg-1]]]
  where
    catLinArity :: FCat -> Int
    catLinArity c = maximum (1:[Array.rangeSize (Array.bounds rhs) | (FFun _ _ rhs, _) <- topdownRules c])

    topdownRules cat = f cat []
      where
        f cat rules = maybe rules (Set.fold g rules) (IntMap.lookup cat (productions p))
	 
        g (FApply funid args) rules = (functions p Array.! funid,args) : rules
        g (FCoerce cat)       rules = f cat rules


name2js :: (CId,[Profile]) -> JS.Expr
name2js (f,ps) = new "FunApp" $ [JS.EStr $ prCId f, JS.EArray (map fromProfile ps)]
  where
    fromProfile :: Profile -> JS.Expr
    fromProfile []   = new "MetaVar" []
    fromProfile [x]  = daughter x
    fromProfile args = new "Unify" [JS.EArray (map daughter args)]

daughter i = new "Arg" [JS.EInt i]

lins2js :: ParserInfo -> UArray FIndex SeqId -> JS.Expr
lins2js p ls = JS.EArray [JS.EArray [sym2js s | s <- Array.elems (sequences p Array.! seqid)] | seqid <- Array.elems ls]

sym2js :: FSymbol -> JS.Expr
sym2js (FSymCat n l) = new "ArgProj" [JS.EInt n, JS.EInt l]
sym2js (FSymLit n l) = new "ArgProj" [JS.EInt n, JS.EInt l]
sym2js (FSymTok (KS t)) = new "Terminal" [JS.EStr t]

new :: String -> [JS.Expr] -> JS.Expr
new f xs = JS.ENew (JS.Ident f) xs

mapToJSObj :: (a -> JS.Expr) -> Map CId a -> JS.Expr
mapToJSObj f m = JS.EObj [ JS.Prop (JS.IdentPropName (JS.Ident (prCId k))) (f v) | (k,v) <- Map.toList m ]
