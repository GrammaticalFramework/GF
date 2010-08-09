module GF.Compile.PGFtoJS (pgf2js) where

import PGF.CId
import PGF.Data hiding (mkStr)
import qualified PGF.Macros as M
import qualified GF.JavaScript.AbsJS as JS
import qualified GF.JavaScript.PrintJS as JS

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
  JS.printTree $ JS.Program [JS.ElStmt $ JS.SDeclOrExpr $ JS.Decl [JS.DInit (JS.Ident n) grammar]]
 where
   n  = showCId $ absname pgf
   as = abstract pgf
   cs = Map.assocs (concretes pgf)
   start = showCId $ M.lookStartCat pgf
   grammar = new "GFGrammar" [js_abstract, js_concrete]
   js_abstract = abstract2js start as
   js_concrete = JS.EObj $ map concrete2js cs

abstract2js :: String -> Abstr -> JS.Expr
abstract2js start ds = new "GFAbstract" [JS.EStr start, JS.EObj $ map absdef2js (Map.assocs (funs ds))]

absdef2js :: (CId,(Type,Int,Maybe [Equation])) -> JS.Property
absdef2js (f,(typ,_,_)) =
  let (args,cat) = M.catSkeleton typ in 
    JS.Prop (JS.IdentPropName (JS.Ident (showCId f))) (new "Type" [JS.EArray [JS.EStr (showCId x) | x <- args], JS.EStr (showCId cat)])

lit2js (LStr s) = JS.EStr s
lit2js (LInt n) = JS.EInt n
lit2js (LFlt d) = JS.EDbl d

concrete2js :: (CId,Concr) -> JS.Property
concrete2js (c,cnc) =
  JS.Prop l (new "GFConcrete" [mapToJSObj (lit2js) $ cflags cnc,
                               JS.EObj $ [JS.Prop (JS.IntPropName cat) (JS.EArray (map frule2js (Set.toList set))) | (cat,set) <- IntMap.toList (productions cnc)],
                               JS.EArray $ (map ffun2js (Array.elems (cncfuns cnc))),
                               JS.EArray $ (map seq2js (Array.elems (sequences cnc))),
                               JS.EObj $ map cats (Map.assocs (cnccats cnc)),
                               JS.EInt (totalCats cnc)])
  where 
   l  = JS.IdentPropName (JS.Ident (showCId c))
   litslins = [JS.Prop (JS.StringPropName    "Int") (JS.EFun [children] [JS.SReturn $ new "Arr" [JS.EIndex (JS.EVar children) (JS.EInt 0)]]), 
               JS.Prop (JS.StringPropName  "Float") (JS.EFun [children] [JS.SReturn $ new "Arr" [JS.EIndex (JS.EVar children) (JS.EInt 0)]]),
               JS.Prop (JS.StringPropName "String") (JS.EFun [children] [JS.SReturn $ new "Arr" [JS.EIndex (JS.EVar children) (JS.EInt 0)]])]
   cats (c,CncCat start end _) = JS.Prop (JS.IdentPropName (JS.Ident (showCId c))) (JS.EObj [JS.Prop (JS.IdentPropName (JS.Ident "s")) (JS.EInt start)
                                                                                            ,JS.Prop (JS.IdentPropName (JS.Ident "e")) (JS.EInt end)])
mkStr :: String -> JS.Expr
mkStr s = new "Str" [JS.EStr s]

mkSeq :: [JS.Expr] -> JS.Expr
mkSeq [x] = x
mkSeq xs = new "Seq" xs

argIdent :: Integer -> JS.Ident
argIdent n = JS.Ident ("x" ++ show n)

children :: JS.Ident
children = JS.Ident "cs"

frule2js :: Production -> JS.Expr
frule2js (PApply funid args) = new "Apply"  [JS.EInt funid, JS.EArray (map farg2js args)]
frule2js (PCoerce arg)       = new "Coerce" [JS.EInt arg]

farg2js (PArg hypos fid) = new "PArg" (map (JS.EInt . snd) hypos ++ [JS.EInt fid])

ffun2js (CncFun f lins) = new "CncFun" [JS.EStr (showCId f), JS.EArray (map JS.EInt (Array.elems lins))]

seq2js :: Array.Array DotPos Symbol -> JS.Expr
seq2js seq = JS.EArray [sym2js s | s <- Array.elems seq]

sym2js :: Symbol -> JS.Expr
sym2js (SymCat n l)    = new "SymCat" [JS.EInt n, JS.EInt l]
sym2js (SymLit n l)    = new "SymLit" [JS.EInt n, JS.EInt l]
sym2js (SymVar n l)    = new "SymVar" [JS.EInt n, JS.EInt l]
sym2js (SymKS ts)      = new "SymKS"  (map JS.EStr ts)
sym2js (SymKP ts alts) = new "SymKP"  [JS.EArray (map JS.EStr ts), JS.EArray (map alt2js alts)]

alt2js (Alt ps ts) = new "Alt" [JS.EArray (map JS.EStr ps), JS.EArray (map JS.EStr ts)]

new :: String -> [JS.Expr] -> JS.Expr
new f xs = JS.ENew (JS.Ident f) xs

mapToJSObj :: (a -> JS.Expr) -> Map CId a -> JS.Expr
mapToJSObj f m = JS.EObj [ JS.Prop (JS.IdentPropName (JS.Ident (showCId k))) (f v) | (k,v) <- Map.toList m ]
