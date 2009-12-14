module GF.Compile.PGFtoJS (pgf2js) where

import PGF.CId
import PGF.Data hiding (mkStr)
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
   n  = showCId $ absname pgf
   as = abstract pgf
   cs = Map.assocs (concretes pgf)
   start = showCId $ M.lookStartCat pgf
   grammar = new "GFGrammar" [js_abstract, js_concrete]
   js_abstract = abstract2js start as
   js_concrete = JS.EObj $ map (concrete2js n) cs

abstract2js :: String -> Abstr -> JS.Expr
abstract2js start ds = new "GFAbstract" [JS.EStr start, JS.EObj $ map absdef2js (Map.assocs (funs ds))]

absdef2js :: (CId,(Type,Int,[Equation])) -> JS.Property
absdef2js (f,(typ,_,_)) =
  let (args,cat) = M.catSkeleton typ in 
    JS.Prop (JS.IdentPropName (JS.Ident (showCId f))) (new "Type" [JS.EArray [JS.EStr (showCId x) | x <- args], JS.EStr (showCId cat)])

concrete2js :: String -> (CId,Concr) -> JS.Property
concrete2js n (c, cnc) =
    JS.Prop l (new "GFConcrete" ([flags,(JS.EObj $ ((map (cncdef2js n (showCId c)) ds) ++ litslins))] ++
                                 maybe [] parser2js (parser cnc)))
  where 
   flags = mapToJSObj JS.EStr $ cflags cnc
   l  = JS.IdentPropName (JS.Ident (showCId c))
   ds = concatMap Map.assocs [lins cnc, opers cnc, lindefs cnc]
   litslins = [JS.Prop (JS.StringPropName    "Int") (JS.EFun [children] [JS.SReturn $ new "Arr" [JS.EIndex (JS.EVar children) (JS.EInt 0)]]), 
               JS.Prop (JS.StringPropName  "Float") (JS.EFun [children] [JS.SReturn $ new "Arr" [JS.EIndex (JS.EVar children) (JS.EInt 0)]]),
               JS.Prop (JS.StringPropName "String") (JS.EFun [children] [JS.SReturn $ new "Arr" [JS.EIndex (JS.EVar children) (JS.EInt 0)]])]


cncdef2js :: String -> String -> (CId,Term) -> JS.Property
cncdef2js n l (f, t) = JS.Prop (JS.IdentPropName (JS.Ident (showCId f))) (JS.EFun [children] [JS.SReturn (term2js n l t)])

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
      F f            -> JS.ECall (JS.EMember (JS.EIndex (JS.EMember (JS.EVar $ JS.Ident n) (JS.Ident "concretes")) (JS.EStr l)) (JS.Ident "rule")) [JS.EStr (showCId f), JS.EVar children]
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
parser2js :: ParserInfo -> [JS.Expr]
parser2js p  = [new "Parser" [JS.EObj $ [JS.Prop (JS.IntPropName cat) (JS.EArray (map frule2js (Set.toList set))) | (cat,set) <- IntMap.toList (productions0 p)],
                              JS.EArray $ (map ffun2js (Array.elems (functions p))),
                              JS.EArray $ (map seq2js (Array.elems (sequences p))),
                              JS.EObj $ map cats (Map.assocs (startCats p)),
                              JS.EInt (totalCats p)]]
  where 
    cats (c,is) = JS.Prop (JS.IdentPropName (JS.Ident (showCId c))) (JS.EArray (map JS.EInt is))

frule2js :: Production -> JS.Expr
frule2js (FApply funid args) = new "Rule"   [JS.EInt funid, JS.EArray (map JS.EInt args)]
frule2js (FCoerce arg)       = new "Coerce" [JS.EInt arg]

ffun2js (FFun f _ lins) = new "FFun" [JS.EStr (showCId f), JS.EArray (map JS.EInt (Array.elems lins))]

seq2js :: Array.Array FIndex FSymbol -> JS.Expr
seq2js seq = JS.EArray [sym2js s | s <- Array.elems seq]

sym2js :: FSymbol -> JS.Expr
sym2js (FSymCat n l)    = new "Arg" [JS.EInt n, JS.EInt l]
sym2js (FSymLit n l)    = new "Lit" [JS.EInt n, JS.EInt l]
sym2js (FSymKS ts)      = new "KS"  (map JS.EStr ts)
sym2js (FSymKP ts alts) = new "KP"  [JS.EArray (map JS.EStr ts), JS.EArray (map alt2js alts)]

alt2js (Alt ps ts) = new "Alt" [JS.EArray (map JS.EStr ps), JS.EArray (map JS.EStr ts)]

new :: String -> [JS.Expr] -> JS.Expr
new f xs = JS.ENew (JS.Ident f) xs

mapToJSObj :: (a -> JS.Expr) -> Map CId a -> JS.Expr
mapToJSObj f m = JS.EObj [ JS.Prop (JS.IdentPropName (JS.Ident (showCId k))) (f v) | (k,v) <- Map.toList m ]
