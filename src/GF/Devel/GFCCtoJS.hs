module GF.Devel.GFCCtoJS (gfcc2js,gfcc2grammarRef) where

import qualified GF.GFCC.Macros as M
import qualified GF.GFCC.DataGFCC as D
import GF.GFCC.CId
import qualified GF.JavaScript.AbsJS as JS
import qualified GF.JavaScript.PrintJS as JS

import GF.Formalism.FCFG
import GF.Parsing.FCFG.PInfo
import GF.Formalism.Utilities (NameProfile(..), Profile(..), SyntaxForest(..))

import GF.Text.UTF8
import GF.Data.ErrM
import GF.Infra.Option

import Control.Monad (mplus)
import Data.Array (Array)
import qualified Data.Array as Array
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

abstract2js :: String -> CId -> D.Abstr -> [JS.Element]
abstract2js start (CId n) ds = 
    [JS.ElStmt $ JS.SDeclOrExpr $ JS.Decl [JS.DInit a (new "Abstract" [JS.EStr start])]] 
    ++ concatMap (absdef2js a) (Map.assocs (D.funs ds))
  where a = JS.Ident n

absdef2js :: JS.Ident -> (CId,(D.Type,D.Exp)) -> [JS.Element]
absdef2js a (CId f,(typ,_)) =
  let (args,CId cat) = M.catSkeleton typ in 
    [JS.ElStmt $ JS.SDeclOrExpr $ JS.DExpr $ JS.ECall (JS.EMember (JS.EVar a) (JS.Ident "addType")) 
           [JS.EStr f, JS.EArray [JS.EStr x | CId x <- args], JS.EStr cat]]

concrete2js :: CId -> (CId,D.Concr) -> [JS.Element]
concrete2js (CId a) (CId c, cnc) =
    [JS.ElStmt $ JS.SDeclOrExpr $ JS.Decl [JS.DInit l (new "Concrete" [JS.EVar (JS.Ident a)])]] 
    ++ concatMap (cncdef2js l) ds
    ++ fromMaybe [] (fmap (parser2js l) (D.parser cnc))
  where 
   l  = JS.Ident c
   ds = concatMap Map.assocs [D.lins cnc, D.opers cnc, D.lindefs cnc]

cncdef2js :: JS.Ident -> (CId,D.Term) -> [JS.Element]
cncdef2js l (CId f, t) = 
    [JS.ElStmt $ JS.SDeclOrExpr $ JS.DExpr $ JS.ECall (JS.EMember (JS.EVar l) (JS.Ident "addRule")) [JS.EStr f, JS.EFun [children] [JS.SReturn (term2js l t)]]]

term2js :: JS.Ident -> D.Term -> JS.Expr
term2js l t = f t
  where 
  f t = 
    case t of
      D.R xs           -> new "Arr" (map f xs)
      D.P x y          -> JS.ECall (JS.EMember (f x) (JS.Ident "sel")) [f y]
      D.S xs           -> mkSeq (map f xs)
      D.K t            -> tokn2js t
      D.V i            -> JS.EIndex (JS.EVar children) (JS.EInt i)
      D.C i            -> new "Int" [JS.EInt i]
      D.F (CId f)    -> JS.ECall (JS.EMember (JS.EVar l) (JS.Ident "rule")) [JS.EStr f, JS.EVar children]
      D.FV xs          -> new "Variants" (map f xs)
      D.W str x        -> new "Suffix" [JS.EStr str, f x]
      D.RP x y         -> new "Rp" [f x, f y]
      D.TM _           -> new "Meta" []

tokn2js :: D.Tokn -> JS.Expr
tokn2js (D.KS s) = mkStr s
tokn2js (D.KP ss vs) = mkSeq (map mkStr ss) -- FIXME

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

parser2js :: JS.Ident -> FCFPInfo -> [JS.Element]
parser2js l p = [JS.ElStmt $ JS.SDeclOrExpr $ JS.DExpr $ JS.EAssign parser (new "Parser" [])]
              ++ map (addRule . frule2js) (Array.elems (allRules p))
              ++ map addCat (Map.assocs (startupCats p))
    where 
      parser = JS.EMember (JS.EVar l) (JS.Ident "parser")
      addRule r = JS.ElStmt $ JS.SDeclOrExpr $ JS.DExpr $ JS.ECall (JS.EMember parser (JS.Ident "addRule")) [r]
      addCat (CId c,is) = JS.ElStmt $ JS.SDeclOrExpr $ JS.DExpr $ JS.ECall (JS.EMember parser (JS.Ident "addCat")) [JS.EStr c, JS.EArray (map JS.EInt is)]

frule2js :: FRule -> JS.Expr
frule2js (FRule n args res lins) = 
    new "Rule" [JS.EInt res, name2js n, JS.EArray (map JS.EInt args), lins2js lins]

-- FIXME: inclue full profile
name2js :: FName -> JS.Expr
name2js (Name (CId f) _) = JS.EStr f

lins2js :: Array FIndex (Array FPointPos FSymbol) -> JS.Expr
lins2js ls = JS.EArray [ JS.EArray [ sym2js s | s <- Array.elems l] | l <- Array.elems ls]

sym2js :: FSymbol -> JS.Expr
sym2js (FSymCat _ l n) = new "ArgProj" [JS.EInt n, JS.EInt l]
sym2js (FSymTok t) = JS.EStr t

new :: String -> [JS.Expr] -> JS.Expr
new f xs = JS.ENew (JS.Ident f) xs

-- grammar reference file for js applications. AR 10/11/2007

gfcc2grammarRef :: D.GFCC -> String
gfcc2grammarRef gfcc =
  encodeUTF8 $ refs
 where
   CId abstr = D.absname gfcc
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
        | CId c <- D.cncnames gfcc]

