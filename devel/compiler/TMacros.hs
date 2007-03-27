module TMacros where

import AbsTgt

appVal :: Val -> [Val] -> Val
appVal v vs = compVal vs v

compVal :: [Val] -> Val -> Val
compVal args = comp where
  comp val = case val of
    VRec vs  -> VRec $ map comp vs
    VPro r p -> case (comp r, comp p) of
      (VRec vs, VPar i) -> vs !! fromInteger i 
    VArg i   -> args !! fromInteger i
    VCat x y -> VCat (comp x) (comp y)
    _ -> val
