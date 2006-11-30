module GF.Canon.CanonToJS (prCanon2js) where

import GF.Canon.GFC
import GF.Canon.CanonToGFCC
import qualified GF.Canon.GFCC.AbsGFCC as C
import qualified GF.JavaScript.AbsJS as JS
import qualified GF.JavaScript.PrintJS as JS


prCanon2js :: CanonGrammar -> String
prCanon2js = JS.printTree . gfcc2js . mkCanon2gfcc

gfcc2js :: C.Grammar -> JS.Program
gfcc2js (C.Grm _ _ cs) = concrete2js (head cs) -- FIXME

concrete2js :: C.Concrete -> JS.Program
concrete2js (C.Cnc c ds) = JS.Program (map cncdef2js ds)

cncdef2js :: C.CncDef -> JS.Element
cncdef2js (C.Lin (C.CId f) t) = 
    JS.FunDef (JS.Ident ("lin_"++f)) [children] [JS.Return (term2js t)]

term2js :: C.Term -> JS.Expr
term2js t = 
    case t of
      C.R xs           -> call "arr" (map term2js xs)
      C.P x y          -> JS.EMember (term2js x) (term2js y)
      C.S xs           -> call "seq" (map term2js xs)
      C.K t            -> tokn2js t
      C.V i            -> JS.EIndex (JS.EVar children) (JS.EInt i)
      C.C i            -> JS.EInt i
      C.F (C.CId f)    -> call ("lin_"++f) [JS.EVar children]
      C.FV xs          -> call "variants" (map term2js xs)
      C.W str x        -> call "suffix" [JS.EStr str, term2js x]
      C.RP x y         -> call "rp" [term2js x, term2js y]
      C.TM             -> call "meta" []
                        
argIdent :: Integer -> JS.Ident
argIdent n = JS.Ident ("x" ++ show n)

tokn2js :: C.Tokn -> JS.Expr
tokn2js (C.KS s) = JS.EStr s

children :: JS.Ident
children = JS.Ident "cs"

call :: String -> [JS.Expr] -> JS.Expr
call f xs = JS.ECall (JS.EVar (JS.Ident f)) xs
