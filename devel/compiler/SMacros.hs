module SMacros where

import AbsSrc

apps :: Exp -> (Exp,[Exp])
apps e = (f,reverse xs) where
  (f,xs) = aps e
  aps e = case e of
    EApp f x -> let (f',xs) = aps f in (f',x:xs)
    _ -> (e,[])

constr :: Ident -> [Exp] -> Exp
constr = ECst

mkApp :: Exp -> [Exp] -> Exp
mkApp f = foldl EApp f
