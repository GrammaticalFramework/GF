module GF.Devel.GFCCtoJS (gfcc2js) where

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
  encodeUTF8 $ JS.printTree $ JS.Program [JS.ElStmt $ JS.SDeclOrExpr $ JS.Decl [JS.DInit (JS.Ident n) grammar]]
 where
   n  = D.printCId $ D.absname gfcc
   as = D.abstract gfcc
   cs = Map.assocs (D.concretes gfcc)
   start = M.lookStartCat gfcc
   grammar = new "GFGrammar" [abstract, concrete]
   abstract = abstract2js start as
   concrete = JS.EObj $ map (concrete2js start n) cs

abstract2js :: String -> D.Abstr -> JS.Expr
abstract2js start ds = new "GFAbstract" [JS.EStr start, JS.EObj $ map absdef2js (Map.assocs (D.funs ds))]

absdef2js :: (CId,(D.Type,D.Exp)) -> JS.Property
absdef2js (CId f,(typ,_)) =
  let (args,CId cat) = M.catSkeleton typ in 
    JS.Prop (JS.Ident f) (new "Type" [JS.EArray [JS.EStr x | CId x <- args], JS.EStr cat])

concrete2js :: String -> String -> (CId,D.Concr) -> JS.Property
concrete2js start n (CId c, cnc) =
    JS.Prop l (new "GFConcrete" ([(JS.EObj $ ((map (cncdef2js n c) ds) ++ litslins))] ++
                                 maybe [] (parser2js start) (D.parser cnc)))
  where 
   l  = JS.Ident c
   ds = concatMap Map.assocs [D.lins cnc, D.opers cnc, D.lindefs cnc]
   litslins = [JS.Prop (JS.Ident    "Int") (JS.EFun [children] [JS.SReturn $ new "Arr" [JS.EIndex (JS.EVar children) (JS.EInt 0)]]), 
               JS.Prop (JS.Ident  "Float") (JS.EFun [children] [JS.SReturn $ new "Arr" [JS.EIndex (JS.EVar children) (JS.EInt 0)]]),
               JS.Prop (JS.Ident "String") (JS.EFun [children] [JS.SReturn $ new "Arr" [JS.EIndex (JS.EVar children) (JS.EInt 0)]])]

cncdef2js :: String -> String -> (CId,D.Term) -> JS.Property
cncdef2js n l (CId f, t) = JS.Prop (JS.Ident f) (JS.EFun [children] [JS.SReturn (term2js n l t)])

term2js :: String -> String -> D.Term -> JS.Expr
term2js n l t = f t
  where 
  f t = 
    case t of
      D.R xs           -> new "Arr" (map f xs)
      D.P x y          -> JS.ECall (JS.EMember (f x) (JS.Ident "sel")) [f y]
      D.S xs           -> mkSeq (map f xs)
      D.K t            -> tokn2js t
      D.V i            -> JS.EIndex (JS.EVar children) (JS.EInt i)
      D.C i            -> new "Int" [JS.EInt i]
      D.F (CId f)      -> JS.ECall (JS.EMember (JS.EIndex (JS.EMember (JS.EVar $ JS.Ident n) (JS.Ident "concretes")) (JS.EStr l)) (JS.Ident "rule")) [JS.EStr f, JS.EVar children]
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
parser2js :: String -> FCFPInfo -> [JS.Expr]
parser2js start p  = [new "Parser" [JS.EStr start,
                                    JS.EArray $ map frule2js (Array.elems (allRules p)),
                                    JS.EObj $ map cats (Map.assocs (startupCats p))]]
  where 
    cats (CId c,is) = JS.Prop (JS.Ident c) (JS.EArray (map JS.EInt is))

frule2js :: FRule -> JS.Expr
frule2js (FRule n args res lins) = new "Rule" [JS.EInt res, name2js n, JS.EArray (map JS.EInt args), lins2js lins]

name2js :: FName -> JS.Expr
name2js n = case n of
              Name (CId "_") [p] -> fromProfile p
              Name f ps          -> new "FunApp" $ [JS.EStr $ prCId f, JS.EArray (map fromProfile ps)]
  where
    fromProfile :: Profile (SyntaxForest CId) -> JS.Expr
    fromProfile (Unify []) = new "MetaVar" []
    fromProfile (Unify [x]) = daughter x
    fromProfile (Unify args) = new "Unify" [JS.EArray (map daughter args)]
    fromProfile (Constant forest) = fromSyntaxForest forest

    daughter i = new "Arg" [JS.EInt i]

    fromSyntaxForest :: SyntaxForest CId -> JS.Expr
    fromSyntaxForest FMeta = new "MetaVar" []
    -- FIXME: is there always just one element here?
    fromSyntaxForest (FNode n [args]) = new "FunApp" $ [JS.EStr $ prCId n, JS.EArray (map fromSyntaxForest args)]
    fromSyntaxForest (FString s) = new "Lit" $ [JS.EStr s]
    fromSyntaxForest (FInt i) = new "Lit" $ [JS.EInt $ fromIntegral i]
    fromSyntaxForest (FFloat f) = new "Lit" $ [JS.EDbl f]

lins2js :: Array FIndex (Array FPointPos FSymbol) -> JS.Expr
lins2js ls = JS.EArray [ JS.EArray [ sym2js s | s <- Array.elems l] | l <- Array.elems ls]

sym2js :: FSymbol -> JS.Expr
sym2js (FSymCat _ l n) = new "ArgProj" [JS.EInt n, JS.EInt l]
sym2js (FSymTok t) = new "Terminal" [JS.EStr t]

new :: String -> [JS.Expr] -> JS.Expr
new f xs = JS.ENew (JS.Ident f) xs
