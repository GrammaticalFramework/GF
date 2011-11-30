module GF.Compile.Compute.ConcreteNew
           ( normalForm
           , Value(..), Env, eval, apply, value2term
           ) where

import GF.Grammar hiding (Env, VGen, VApp, VRecType)

normalForm :: SourceGrammar -> Term -> Term
normalForm gr t = value2term gr [] (eval gr [] t)

data Value
  = VApp QIdent [Value]
  | VGen Int [Value]
  | VMeta MetaId Env [Value]
  | VClosure Env Term
  | VSort Ident
  | VTblType Value Value
  | VRecType [(Label,Value)]
  deriving Show

type Env = [(Ident,Value)]

eval :: SourceGrammar -> Env -> Term -> Value
eval gr env (Vr x)   = case lookup x env of
                         Just v  -> v
                         Nothing -> error ("Unknown variable "++showIdent x)
eval gr env (Q x)    = VApp x []
eval gr env (QC x)   = VApp x []
eval gr env (Meta i) = VMeta i env []
eval gr env t@(Prod _ _ _ _) = VClosure env t
eval gr env t@(Abs _ _ _) = VClosure env t
eval gr env (Sort s) = VSort s
eval gr env (Table p res) = VTblType (eval gr env p) (eval gr env res)
eval gr env (RecType rs) = VRecType [(l,eval gr env ty) | (l,ty) <- rs]
eval gr env t = error ("eval "++show t)

apply gr env t [] = eval gr env t
apply gr env t vs = error ("apply "++show t)

value2term :: SourceGrammar -> [Ident] -> Value -> Term
value2term gr xs (VApp f vs)      = foldl App (Q f)                  (map (value2term gr xs) vs)
value2term gr xs (VGen j vs)      = foldl App (Vr (reverse xs !! j)) (map (value2term gr xs) vs)
value2term gr xs (VMeta j env vs) = foldl App (Meta j)               (map (value2term gr xs) vs)
value2term gr xs (VClosure env (Prod bt x t1 t2)) = Prod bt x (value2term gr    xs  (eval gr env t1))
                                                              (value2term gr (x:xs) (eval gr ((x,VGen (length xs) []) : env) t2))
value2term gr xs (VClosure env (Abs  bt x t))     = Abs  bt x (value2term gr (x:xs) (eval gr ((x,VGen (length xs) []) : env) t))
value2term gr xs (VSort s) = Sort s
value2term gr xs (VTblType p res) = Table (value2term gr xs p) (value2term gr xs res)
value2term gr xs (VRecType rs) = RecType [(l,value2term gr xs v) | (l,v) <- rs]
value2term gr xs v = error ("value2term "++show v)
