module GF.Devel.GFCCtoJS (gfcc2js,gfcc2grammarRef) where

import qualified GF.GFCC.Macros as M
import qualified GF.GFCC.DataGFCC as D
import qualified GF.GFCC.AbsGFCC as C
import qualified GF.JavaScript.AbsJS as JS
import qualified GF.JavaScript.PrintJS as JS

import GF.Text.UTF8
import GF.Data.ErrM
import GF.Infra.Option

import Control.Monad (mplus)
import Data.Maybe (fromMaybe)
import qualified Data.Map as Map

gfcc2js :: D.GFCC -> String
gfcc2js gfcc =
  encodeUTF8 $ JS.printTree $ JS.Program $ abstract2js start n as ++ 
  concatMap (concrete2js n) cs
 where
   n  = D.absname gfcc
   as = D.abstract gfcc
   cs = Map.assocs (D.concretes gfcc)
   start = M.lookAbsFlag gfcc (M.cid "startcat")

abstract2js :: String -> C.CId -> D.Abstr -> [JS.Element]
abstract2js start (C.CId n) ds = 
    [JS.ElStmt $ JS.SDeclOrExpr $ JS.Decl [JS.DInit a (new "Abstract" [JS.EStr start])]] 
    ++ concatMap (absdef2js a) (Map.assocs (D.funs ds))
  where a = JS.Ident n

absdef2js :: JS.Ident -> (C.CId,(C.Type,C.Exp)) -> [JS.Element]
absdef2js a (C.CId f,(typ,_)) =
  let (args,C.CId cat) = M.catSkeleton typ in 
    [JS.ElStmt $ JS.SDeclOrExpr $ JS.DExpr $ JS.ECall (JS.EMember (JS.EVar a) (JS.Ident "addType")) 
           [JS.EStr f, JS.EArray [JS.EStr x | C.CId x <- args], JS.EStr cat]]

concrete2js :: C.CId -> (C.CId,D.Concr) -> [JS.Element]
concrete2js (C.CId a) (C.CId c, cnc) =
    [JS.ElStmt $ JS.SDeclOrExpr $ JS.Decl [JS.DInit l (new "Concrete" [JS.EVar (JS.Ident a)])]] 
    ++ concatMap (cncdef2js l) ds
  where 
   l  = JS.Ident c
   ds = concatMap Map.assocs [D.lins cnc, D.opers cnc, D.lindefs cnc]

cncdef2js :: JS.Ident -> (C.CId,C.Term) -> [JS.Element]
cncdef2js l (C.CId f, t) = 
    [JS.ElStmt $ JS.SDeclOrExpr $ JS.DExpr $ JS.ECall (JS.EMember (JS.EVar l) (JS.Ident "addRule")) [JS.EStr f, JS.EFun [children] [JS.SReturn (term2js l t)]]]

term2js :: JS.Ident -> C.Term -> JS.Expr
term2js l t = f t
  where 
  f t = 
    case t of
      C.R xs           -> new "Arr" (map f xs)
      C.P x y          -> JS.ECall (JS.EMember (f x) (JS.Ident "sel")) [f y]
      C.S xs           -> mkSeq (map f xs)
      C.K t            -> tokn2js t
      C.V i            -> JS.EIndex (JS.EVar children) (JS.EInt i)
      C.C i            -> new "Int" [JS.EInt i]
      C.F (C.CId f)    -> JS.ECall (JS.EMember (JS.EVar l) (JS.Ident "rule")) [JS.EStr f, JS.EVar children]
      C.FV xs          -> new "Variants" (map f xs)
      C.W str x        -> new "Suffix" [JS.EStr str, f x]
      C.RP x y         -> new "Rp" [f x, f y]
      C.TM             -> new "Meta" []

tokn2js :: C.Tokn -> JS.Expr
tokn2js (C.KS s) = mkStr s
tokn2js (C.KP ss vs) = mkSeq (map mkStr ss) -- FIXME

mkStr :: String -> JS.Expr
mkStr s = new "Str" [JS.EStr s]

mkSeq :: [JS.Expr] -> JS.Expr
mkSeq [x] = x
mkSeq xs = new "Seq" xs

argIdent :: Integer -> JS.Ident
argIdent n = JS.Ident ("x" ++ show n)

children :: JS.Ident
children = JS.Ident "cs"

new :: String -> [JS.Expr] -> JS.Expr
new f xs = JS.ENew (JS.Ident f) xs

-- grammar reference file for js applications. AR 10/11/2007

gfcc2grammarRef :: D.GFCC -> String
gfcc2grammarRef gfcc =
  encodeUTF8 $ refs
 where
   C.CId abstr = D.absname gfcc
   refs = unlines $ [
     "// Grammar Reference",
     "function concreteReference(concreteSyntax, concreteSyntaxName) {",
     "this.concreteSyntax = concreteSyntax;",
     "this.concreteSyntaxName = concreteSyntaxName;",
     "}",
     "var myAbstract = " ++ abstr ++ " ;",
     "var myConcrete = new Array();"
     ] ++ [
     "myConcrete.push(new concreteReference(" ++ c ++ ",\"" ++ c ++ "\"));" 
        | C.CId c <- D.cncnames gfcc]

