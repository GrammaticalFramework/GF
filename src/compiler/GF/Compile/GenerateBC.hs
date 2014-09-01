module GF.Compile.GenerateBC(generateByteCode) where

import GF.Grammar
import GF.Grammar.Lookup(lookupAbsDef)
import GF.Data.Operations
import PGF(CId,utf8CId)
import PGF.Internal(Instr(..))
import qualified Data.Map as Map
import Data.List(mapAccumL)

generateByteCode :: SourceGrammar -> Int -> [L Equation] -> [Instr]
generateByteCode gr arity eqs =
  compileEquations gr arity is (map (\(L _ (ps,t)) -> ([],ps,t)) eqs)
  where
    is = push_is (arity-1) arity []

compileEquations :: SourceGrammar -> Int -> [Int] -> [([(Ident,Int)],[Patt],Term)] -> [Instr]
compileEquations gr st _  []            = [FAIL]
compileEquations gr st [] ((vs,[],t):_) =
  let (heap,instrs) = compileBody gr st vs t 0 []
  in (if heap > 0 then (ALLOC heap :) else id)
     (instrs ++ [RET st])
compileEquations gr st (i:is) eqs       = whilePP eqs Map.empty
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
    whilePV eqs                          cns vrs = mkCase cns (reverse vrs) ++ compileEquations gr st (i:is) eqs

    mkCase cns vrs
      | Map.null cns = compileEquations gr st is vrs
      | otherwise    = EVAL (st-i-1) :
                       concat [compileBranch t n eqs | ((t,n),eqs) <- Map.toList cns] ++
                       compileEquations gr st is vrs

    compileBranch t n eqs =
      let case_instr = 
            case t of
              (Q (_,id)) -> CASE (i2i id)
              (EInt n)   -> CASE_INT n
              (K s)      -> CASE_STR s
              (EFloat d) -> CASE_FLT d
          instrs = compileEquations gr (st+n) (push_is st n is) eqs
      in case_instr (length instrs) : instrs

compileBody gr st vs (App e1 e2) h0 es = compileBody gr st vs e1 h0 (e2:es)
compileBody gr st vs (Q (m,id))  h0 es = case lookupAbsDef gr m id of
                                           Ok (Just _,Just _) 
                                              -> let ((h1,st1),iis) = mapAccumL (compileArg gr st vs) (h0,st) (reverse es)
                                                     (is1,is2,is3) = unzip3 iis
                                                 in (h1,concat is3 ++ is2 ++ [TAIL_CALL (i2i id)])
                                           _  -> let h1 = h0 + 2 + length es
                                                     ((h2,st1),iis)  = mapAccumL (compileArg gr st vs) (h1,st) es
                                                     (is1,is2,is3) = unzip3 iis
                                                 in (h2,PUT_CONSTR (i2i id) : concat (is1:is3))
compileBody gr st vs (QC qid)    h0 es = compileBody gr st vs (Q qid) h0 es
compileBody gr st vs (Vr x)      h0 es = case lookup x vs of
                                           Just i  -> let ((h1,st1),iis)  = mapAccumL (compileArg gr st vs) (h0,st) (reverse es)
                                                          (is1,is2,is3) = unzip3 iis
                                                      in (h1,concat is3 ++ is2 ++ [EVAL (st-i-1)])
                                           Nothing -> error "compileBody: unknown variable"
compileBody gr st vs (EInt n)    h0 _  = let h1 = h0 + 2
                                         in (h1,[PUT_INT n])
compileBody gr st vs (K s)       h0 _  = let h1 = h0 + 1 + (length s + 4) `div` 4
                                         in (h1,[PUT_STR s])
compileBody gr st vs (EFloat d)  h0 _  = let h1 = h0 + 3
                                         in (h1,[PUT_FLT d])

compileArg gr st vs (h0,st0) (Vr x) =
  case lookup x vs of
    Just i  -> ((h0,st0+1),(SET_VARIABLE (st-i-1),PUSH_VARIABLE (st0-i-1),[]))
    Nothing -> error "compileFunArg: unknown variable"
compileArg gr st vs (h0,st0) e =
  let (h1,is2) = compileBody gr st vs e h0 []
  in ((h1,st0+1),(SET_VALUE h0,PUSH_VALUE h0,is2))

i2i :: Ident -> CId
i2i = utf8CId . ident2utf8

push_is :: Int -> Int -> [Int] -> [Int]
push_is i 0 is = is
push_is i n is = i : push_is (i-1) (n-1) is
