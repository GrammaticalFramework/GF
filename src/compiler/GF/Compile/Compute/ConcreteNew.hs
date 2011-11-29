module GF.Compile.Compute.ConcreteNew ( Value(..), Env, eval, apply, value2term ) where

import GF.Grammar hiding (Env, VGen, VApp)

data Value
  = VApp QIdent [Value]
  | VGen Int [Value]
  | VMeta MetaId Env [Value]
  | VClosure Env Term
  | VSort Ident
  deriving Show

type Env = [(Ident,Value)]

eval :: Env -> Term -> Value
eval env (Vr x)   = case lookup x env of
                      Just v  -> v
                      Nothing -> error ("Unknown variable "++showIdent x)
eval env (Q x)    = VApp x []
eval env (Meta i) = VMeta i env []
eval env t@(Prod _ _ _ _) = VClosure env t
eval env t@(Abs _ _ _) = VClosure env t
eval env (Sort s) = VSort s
eval env t = error (show t)

apply env t vs = undefined

value2term :: [Ident] -> Value -> Term
value2term xs (VApp f vs)      = foldl App (Q f)                  (map (value2term xs) vs)
value2term xs (VGen j vs)      = foldl App (Vr (reverse xs !! j)) (map (value2term xs) vs)
value2term xs (VMeta j env vs) = foldl App (Meta j)               (map (value2term xs) vs)
value2term xs (VClosure env (Prod bt x t1 t2)) = Prod bt x (value2term    xs  (eval env t1))
                                                           (value2term (x:xs) (eval ((x,VGen (length xs) []) : env) t2))
value2term xs (VClosure env (Abs  bt x t))     = Abs  bt x (value2term (x:xs) (eval ((x,VGen (length xs) []) : env) t))
value2term xs (VSort s) = Sort s
value2term xs v = error (show v)
