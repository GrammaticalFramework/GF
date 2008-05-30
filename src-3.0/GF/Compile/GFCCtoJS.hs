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
import Data.Array (Array)
import qualified Data.Array as Array
import Data.Maybe (fromMaybe)
import qualified Data.Map as Map

pgf2js :: PGF -> String
pgf2js pgf =
  encodeUTF8 $ JS.printTree $ JS.Program [JS.ElStmt $ JS.SDeclOrExpr $ JS.Decl [JS.DInit (JS.Ident n) grammar]]
 where
   n  = prCId $ absname pgf
   as = abstract pgf
   cs = Map.assocs (concretes pgf)
   start = M.lookStartCat pgf
   grammar = new "GFGrammar" [js_abstract, js_concrete]
   js_abstract = abstract2js start as
   js_concrete = JS.EObj $ map (concrete2js start n) cs

abstract2js :: String -> Abstr -> JS.Expr
abstract2js start ds = new "GFAbstract" [JS.EStr start, JS.EObj $ map absdef2js (Map.assocs (funs ds))]

absdef2js :: (CId,(Type,Exp)) -> JS.Property
absdef2js (f,(typ,_)) =
  let (args,cat) = M.catSkeleton typ in 
    JS.Prop (JS.IdentPropName (JS.Ident (prCId f))) (new "Type" [JS.EArray [JS.EStr (prCId x) | x <- args], JS.EStr (prCId cat)])

concrete2js :: String -> String -> (CId,Concr) -> JS.Property
concrete2js start n (c, cnc) =
    JS.Prop l (new "GFConcrete" ([(JS.EObj $ ((map (cncdef2js n (prCId c)) ds) ++ litslins))] ++
                                 maybe [] (parser2js start) (parser cnc)))
  where 
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
                                    JS.EArray $ map frule2js (Array.elems (allRules p)),
                                    JS.EObj $ map cats (Map.assocs (startupCats p))]]
  where 
    cats (c,is) = JS.Prop (JS.IdentPropName (JS.Ident (prCId c))) (JS.EArray (map JS.EInt is))

frule2js :: FRule -> JS.Expr
frule2js (FRule f ps args res lins) = new "Rule" [JS.EInt res, name2js (f,ps), JS.EArray (map JS.EInt args), lins2js lins]

name2js :: (CId,[Profile]) -> JS.Expr
name2js (f,ps) | f == wildCId = fromProfile (head ps)
               | otherwise    = new "FunApp" $ [JS.EStr $ prCId f, JS.EArray (map fromProfile ps)]
  where
    fromProfile :: Profile -> JS.Expr
    fromProfile []   = new "MetaVar" []
    fromProfile [x]  = daughter x
    fromProfile args = new "Unify" [JS.EArray (map daughter args)]

    daughter i = new "Arg" [JS.EInt i]

lins2js :: Array FIndex (Array FPointPos FSymbol) -> JS.Expr
lins2js ls = JS.EArray [ JS.EArray [ sym2js s | s <- Array.elems l] | l <- Array.elems ls]

sym2js :: FSymbol -> JS.Expr
sym2js (FSymCat l n) = new "ArgProj" [JS.EInt n, JS.EInt l]
sym2js (FSymTok t) = new "Terminal" [JS.EStr t]

new :: String -> [JS.Expr] -> JS.Expr
new f xs = JS.ENew (JS.Ident f) xs
