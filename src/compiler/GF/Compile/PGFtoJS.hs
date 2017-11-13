module GF.Compile.PGFtoJS (pgf2js) where

import PGF
import PGF.Internal
import qualified GF.JavaScript.AbsJS as JS
import qualified GF.JavaScript.PrintJS as JS
import Data.Map (Map)
import qualified Data.Set as Set
import qualified Data.Map as Map
import qualified Data.IntMap as IntMap

pgf2js :: PGF -> String
pgf2js pgf =
  JS.printTree $ JS.Program [JS.ElStmt $ JS.SDeclOrExpr $ JS.Decl [JS.DInit (JS.Ident n) grammar]]
 where
   n  = showCId $ abstractName pgf
   start = showType [] $ startCat pgf
   grammar = new "GFGrammar" [js_abstract, js_concrete]
   js_abstract = abstract2js start pgf
   js_concrete = JS.EObj $ map (concrete2js pgf) (languages pgf)

abstract2js :: String -> PGF -> JS.Expr
abstract2js start pgf = new "GFAbstract" [JS.EStr start, JS.EObj [absdef2js f ty | f <- functions pgf, Just ty <- [functionType pgf f]]]

absdef2js :: CId -> Type -> JS.Property
absdef2js f typ =
  let (hypos,cat,_) = unType typ
      args          = [cat | (_,_,typ) <- hypos, let (hypos,cat,_) = unType typ]
  in JS.Prop (JS.IdentPropName (JS.Ident (showCId f))) (new "Type" [JS.EArray [JS.EStr (showCId x) | x <- args], JS.EStr (showCId cat)])

lit2js (LStr s) = JS.EStr s
lit2js (LInt n) = JS.EInt n
lit2js (LFlt d) = JS.EDbl d

concrete2js :: PGF -> Language -> JS.Property
concrete2js pgf lang =
  JS.Prop l (new "GFConcrete" [mapToJSObj (lit2js) $ concrFlags cnc,
                               JS.EObj [JS.Prop (JS.IntPropName cat) (JS.EArray (map frule2js (concrProductions cnc cat))) | cat <- [0..concrTotalCats cnc]],
                               JS.EArray [ffun2js (concrFunction cnc funid) | funid <- [0..concrTotalFuns cnc]],
                               JS.EArray [seq2js (concrSequence cnc seqid) | seqid <- [0..concrTotalSeqs cnc]],
                               JS.EObj $ map cats (concrCategories cnc),
                               JS.EInt (concrTotalCats cnc)])
  where
   cnc = lookConcr pgf lang
   l  = JS.IdentPropName (JS.Ident (showCId lang))

   litslins = [JS.Prop (JS.StringPropName    "Int") (JS.EFun [children] [JS.SReturn $ new "Arr" [JS.EIndex (JS.EVar children) (JS.EInt 0)]]), 
               JS.Prop (JS.StringPropName  "Float") (JS.EFun [children] [JS.SReturn $ new "Arr" [JS.EIndex (JS.EVar children) (JS.EInt 0)]]),
               JS.Prop (JS.StringPropName "String") (JS.EFun [children] [JS.SReturn $ new "Arr" [JS.EIndex (JS.EVar children) (JS.EInt 0)]])]

   cats (c,start,end,_) = JS.Prop (JS.IdentPropName (JS.Ident (showCId c))) (JS.EObj [JS.Prop (JS.IdentPropName (JS.Ident "s")) (JS.EInt start)
                                                                                     ,JS.Prop (JS.IdentPropName (JS.Ident "e")) (JS.EInt end)])

children :: JS.Ident
children = JS.Ident "cs"

frule2js :: Production -> JS.Expr
frule2js (PApply funid args) = new "Apply"  [JS.EInt funid, JS.EArray (map farg2js args)]
frule2js (PCoerce arg)       = new "Coerce" [JS.EInt arg]

farg2js (PArg hypos fid) = new "PArg" (map (JS.EInt . snd) hypos ++ [JS.EInt fid])

ffun2js (f,lins) = new "CncFun" [JS.EStr (showCId f), JS.EArray (map JS.EInt lins)]

seq2js :: [Symbol] -> JS.Expr
seq2js seq = JS.EArray [sym2js s | s <- seq]

sym2js :: Symbol -> JS.Expr
sym2js (SymCat n l)    = new "SymCat" [JS.EInt n, JS.EInt l]
sym2js (SymLit n l)    = new "SymLit" [JS.EInt n, JS.EInt l]
sym2js (SymVar n l)    = new "SymVar" [JS.EInt n, JS.EInt l]
sym2js (SymKS t)       = new "SymKS"  [JS.EStr t]
sym2js (SymKP ts alts) = new "SymKP"  [JS.EArray (map sym2js ts), JS.EArray (map alt2js alts)]
sym2js SymBIND         = new "SymKS"  [JS.EStr "&+"]
sym2js SymSOFT_BIND    = new "SymKS"  [JS.EStr "&+"]
sym2js SymSOFT_SPACE   = new "SymKS"  [JS.EStr "&+"]
sym2js SymCAPIT        = new "SymKS"  [JS.EStr "&|"]
sym2js SymALL_CAPIT    = new "SymKS"  [JS.EStr "&|"]
sym2js SymNE           = new "SymNE"  []

alt2js (ps,ts) = new "Alt" [JS.EArray (map sym2js ps), JS.EArray (map JS.EStr ts)]

new :: String -> [JS.Expr] -> JS.Expr
new f xs = JS.ENew (JS.Ident f) xs

mapToJSObj :: (a -> JS.Expr) -> Map CId a -> JS.Expr
mapToJSObj f m = JS.EObj [ JS.Prop (JS.IdentPropName (JS.Ident (showCId k))) (f v) | (k,v) <- Map.toList m ]

