module Match where

import AbsSrc
import AbsTgt

import Env
import STM

match :: [Case] -> Exp -> STM Env Exp
match cs v = checks $ map (tryMatch v) cs

---- return substitution  
tryMatch :: Exp -> Case -> STM Env Exp
tryMatch e (Cas p v) = if fit (e, p) then return v else raise "no fit" where
  fit (exp,patt) = case (exp,patt) of
    (ECst c es, PCon d ps) ->
      c == d  &&
      length es == length ps &&
      all fit (zip es ps)
    (_,PVar _) -> True ---- not is exp contains variables

