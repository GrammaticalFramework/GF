module GF.Canon.CanonToJS (prCanon2js) where

import GF.Canon.GFC
import GF.Canon.CanonToGFCC
import qualified GF.Canon.GFCC.AbsGFCC as C
import qualified GF.JavaScript.AbsJS as JS
import qualified GF.JavaScript.PrintJS as JS


prCanon2js :: CanonGrammar -> String
prCanon2js gr = unlines [trees, terms, linearize, utils, (gfcc2js $ mkCanon2gfcc gr)]

gfcc2js :: C.Grammar -> String
gfcc2js (C.Grm _ _ cs) = JS.printTree (concrete2js (head cs)) -- FIXME

concrete2js :: C.Concrete -> JS.Program
concrete2js (C.Cnc c ds) = JS.Program ([JS.ElStmt $ JS.SDeclOrExpr $ JS.Decl [JS.DInit (JS.Ident "lin") (new "Array" [])]] 
                                       ++ concatMap cncdef2js ds)

cncdef2js :: C.CncDef -> [JS.Element]
cncdef2js (C.Lin (C.CId f) t) = 
    [JS.ElStmt $ JS.SDeclOrExpr $ JS.DExpr $ JS.EAssign (lin (JS.EStr f)) (JS.EFun [children] [JS.SReturn (term2js t)])]

term2js :: C.Term -> JS.Expr
term2js t = 
    case t of
      C.R xs           -> new "Arr" (map term2js xs)
      C.P x y          -> JS.ECall (JS.EMember (term2js x) (JS.Ident "sel")) [term2js y]
      C.S xs           -> new "Seq" (map term2js xs)
      C.K t            -> tokn2js t
      C.V i            -> JS.EIndex (JS.EVar children) (JS.EInt i)
      C.C i            -> new "Int" [JS.EInt i]
      C.F (C.CId f)    -> JS.ECall (lin (JS.EStr f)) [JS.EVar children]
      C.FV xs          -> new "Variants" (map term2js xs)
      C.W str x        -> new "Suffix" [JS.EStr str, term2js x]
      C.RP x y         -> new "Rp" [term2js x, term2js y]
      C.TM             -> new "Meta" []

argIdent :: Integer -> JS.Ident
argIdent n = JS.Ident ("x" ++ show n)

tokn2js :: C.Tokn -> JS.Expr
tokn2js (C.KS s) = new "Str" [JS.EStr s]
tokn2js (C.KP ss vs) = new "Seq" (map JS.EStr ss) -- FIXME

children :: JS.Ident
children = JS.Ident "cs"

lin :: JS.Expr -> JS.Expr
lin = JS.EIndex (JS.EVar (JS.Ident "lin")) 

new :: String -> [JS.Expr] -> JS.Expr
new f xs = JS.ENew (JS.Ident f) xs

trees :: String
trees = unlines
      [
       "function Fun(name) {",
	"  this.name = name;",
	"  this.children = copy_arguments(arguments, 1);",
       "}"
      ]

terms :: String
terms = unlines
      [
       "function Arr() {  this.values = copy_arguments(arguments, 0); }",
       "Arr.prototype.print = function() { return this.values[0].print(); }",
       "Arr.prototype.sel = function(i) { return this.values[i.toIndex()]; }",
       "function Seq() {  this.values = copy_arguments(arguments, 0); }",
       "Seq.prototype.print = function() { return join_print(this.values, \" \"); }",
       "function Variants() {  this.values = copy_arguments(arguments, 0); }",
       "Variants.prototype.print = function() { return join_print(this.values, \"/\"); }",
       "function Glue() {  this.values = copy_arguments(arguments, 0); }",
       "Glue.prototype.print = function() { return join_print(this.values, \"\"); }",
       "function Rp(index,value) { this.index = index; this.value = value; }",
       "Rp.prototype.print = function() { return this.index; }",
       "Rp.prototype.toIndex = function() { return this.index.toIndex(); }",
       "function Suffix(prefix,suffix) { this.prefix = prefix; this.suffix = suffix; }",
       "Suffix.prototype.print = function() { return this.prefix.print() + this.suffix.print(); }",
       "Suffix.prototype.sel = function(i) { new Glue(this.prefix, this.suffix.sel(i)); }",
       "function Meta() { }",
       "Meta.prototype.print = function() { return \"?\"; }",
       "Meta.prototype.toIndex = function() { return 0; }",
       "Meta.prototype.sel = function(i) { return this; }",
       "function Str(value) { this.value = value; }",
       "Str.prototype.print = function() { return this.value; }",
       "function Int(value) { this.value = value; }",
       "Int.prototype.print = function() { return this.value; }",
       "Int.prototype.toIndex = function() { return this.value; }"
      ]

linearize :: String
linearize = unlines 
      [
       "function linearize(tree) { return linearizeToTerm(tree).print(); }",
       "function linearizeToTerm(tree) {",
       "  var cs = new Array();",
       "  for (var i = 0; i < tree.children.length; i++) {",
       "    cs[i] = linearizeToTerm(tree.children[i]);",
       "  }",
       "  return lin[tree.name](cs);",
       "}"
      ]

utils :: String
utils = unlines
      [
       "function copy_arguments(args, start) {",
       "  var arr = new Array();",
       "  for (var i = 0; i < args.length - start; i++) {",
       "    arr[i] = args[i + start];",
       "  }",
       "  return arr;",
       "}",
       "",
       "function join_print(values, glue) {",
       "  var str = \"\";",
       "  for (var i = 0; i < values.length; i++) {",
       "    str += values[i].print();",
       "    if (i < values.length - 1) {",
       "      str += glue;",
       "    }",
       "  }",
       "  return str;",
       "}"
      ]
