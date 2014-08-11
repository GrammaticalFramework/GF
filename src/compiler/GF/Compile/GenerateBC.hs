module GF.Compile.GenerateBC(generateByteCode) where

import GF.Grammar
import PGF(CId,utf8CId)
import PGF.Internal(Instr(..))
import qualified Data.Map as Map

generateByteCode :: Int -> [L Equation] -> [Instr]
generateByteCode arity eqs =
  compileEquations arity is (map (\(L _ (ps,t)) -> ([],ps,t)) eqs)
  where
    is = push_is (arity-1) arity []

compileEquations :: Int -> [Int] -> [([(Ident,Int)],[Patt],Term)] -> [Instr]
compileEquations st _  []            = [FAIL]
compileEquations st [] ((vs,[],t):_) =
  let (heap,instrs) = compileBody st vs t 0 []
  in (if heap > 0 then (ALLOC heap :) else id)
     (instrs ++ [RET st])
compileEquations st (i:is) eqs       = whilePP eqs Map.empty
  where
    whilePP []                           cns     = mkCase cns []
    whilePP ((vs, PP c ps' : ps, t):eqs) cns     = whilePP eqs (Map.insertWith (++) (Q c,length ps') [(vs,ps'++ps,t)] cns)
    whilePP ((vs, PInt n   : ps, t):eqs) cns     = whilePP eqs (Map.insertWith (++) (EInt n,0) [(vs,ps,t)] cns)
    whilePP ((vs, PString s: ps, t):eqs) cns     = whilePP eqs (Map.insertWith (++) (K s,0) [(vs,ps,t)] cns)
    whilePP ((vs, PFloat d : ps, t):eqs) cns     = whilePP eqs (Map.insertWith (++) (EFloat d,0) [(vs,ps,t)] cns)
    whilePP eqs                          cns     = whilePV eqs cns []

    whilePV []                           cns vrs = mkCase cns (reverse vrs)
    whilePV ((vs, PV x     : ps, t):eqs) cns vrs = whilePV eqs cns (((x,i):vs,ps,t) : vrs)
    whilePV ((vs, PW       : ps, t):eqs) cns vrs = whilePV eqs cns ((      vs,ps,t) : vrs)
    whilePV eqs                          cns vrs = mkCase cns (reverse vrs) ++ compileEquations st (i:is) eqs

    mkCase cns vrs
      | Map.null cns = compileEquations st is vrs
      | otherwise    = EVAL (st-i-1) :
                       concat [compileBranch t n eqs | ((t,n),eqs) <- Map.toList cns] ++
                       compileEquations st is vrs

    compileBranch t n eqs =
      let case_instr = 
            case t of
              (Q (_,id)) -> CASE (i2i id)
              (EInt n)   -> CASE_INT n
              (K s)      -> CASE_STR s
              (EFloat d) -> CASE_FLT d
          instrs = compileEquations (st+n) (push_is st n is) eqs
      in case_instr (length instrs) : instrs
        

compileBody st vs (App e1 e2) h0 os =
  case e2 of
    Vr x -> case lookup x vs of
              Just i  -> compileBody st vs e1 h0 (SET_VARIABLE (st-i-1):os)
              Nothing -> error "compileBody: unknown variable"
    e2   -> let (h1,is1) = compileBody st vs e1 h0 (SET_VALUE h1:os)
                (h2,is2) = compileBody st vs e2 h1 []
            in (h2,is1 ++ is2)
compileBody st vs (QC (_,id)) h0 os = let h1 = h0 + 2 + length os
                                      in (h1,PUT_CONSTR (i2i id) : os)
compileBody st vs (Q  (_,id)) h0 os = let h1 = h0 + 2 + length os
                                      in (h1,PUT_CONSTR (i2i id) : os)
compileBody st vs (Vr x)      h0 os = case lookup x vs of
                                        Just i  -> (h0,EVAL (st-i-1) : os)
                                        Nothing -> error "compileBody: unknown variable"
compileBody st vs (EInt n)    h0 os = let h1 = h0 + 2
                                      in (h1,PUT_INT n : os)
compileBody st vs (K s)       h0 os = let h1 = h0 + 1 + (length s + 4) `div` 4
                                      in (h1,PUT_STR s : os)
compileBody st vs (EFloat d)  h0 os = let h1 = h0 + 3
                                      in (h1,PUT_FLT d : os)
compileBody st vs t           _  _  = error (show t)

i2i :: Ident -> CId
i2i = utf8CId . ident2utf8

push_is :: Int -> Int -> [Int] -> [Int]
push_is i 0 is = is
push_is i n is = i : push_is (i-1) (n-1) is
