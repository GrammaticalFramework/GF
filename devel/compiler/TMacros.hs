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
      (r',p') -> VPro r' p' ---- not at runtime
    VArg j
      | i < length args -> args !! i ---- not needed at runtime
      | otherwise -> val   ---- not the right thing at compiletime either
          where i = fromInteger j
    VCat x y -> VCat (comp x) (comp y)
    _ -> val
