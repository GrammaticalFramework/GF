module GF.Compile.GenerateBC(generateByteCode) where

import GF.Grammar
import GF.Grammar.Lookup(lookupAbsDef)
import GF.Data.Operations
import PGF(CId,utf8CId)
import PGF.Internal(Instr(..))
import qualified Data.Map as Map
import Data.List(nub)

generateByteCode :: SourceGrammar -> Int -> [L Equation] -> [[Instr]]
generateByteCode gr arity eqs =
  let (bs,instrs) = compileEquations gr arity is (map (\(L _ (ps,t)) -> ([],ps,t)) eqs) [ENTER:instrs]
  in reverse bs
  where
    is = push_is (arity-1) arity []

compileEquations :: SourceGrammar -> Int -> [Int] -> [([(Ident,Int)],[Patt],Term)] -> [[Instr]] -> ([[Instr]],[Instr])
compileEquations gr st _  []            bs = (bs,[FAIL])
compileEquations gr st [] ((vs,[],t):_) bs = compileBody gr st vs [] t bs []
compileEquations gr st (i:is) eqs       bs = whilePP eqs Map.empty
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
    whilePV eqs                          cns vrs = let (bs1,instrs1) = mkCase cns (reverse vrs)
                                                       (bs2,instrs2) = compileEquations gr st (i:is) eqs (instrs2:bs1)
                                                   in (bs2,instrs1)

    mkCase cns vrs =
      case Map.toList cns of
        []       -> compileEquations gr st is vrs bs
        (cn:cns) -> let (bs1,instrs1) = compileBranch0 cn bs
                        bs2 = foldr compileBranch bs1 cns
                        (bs3,instrs3) = compileEquations gr st is vrs (instrs3:bs2)
                    in (bs3,instrs1)

    compileBranch0 ((t,n),eqs) bs =
      let case_instr = 
            case t of
              (Q (_,id)) -> CASE (i2i id)
              (EInt n)   -> CASE_INT n
              (K s)      -> CASE_STR s
              (EFloat d) -> CASE_FLT d
          (bs1,instrs) = compileEquations gr (st+n) (push_is st n is) eqs bs
      in (bs1, EVAL_ARG_VAR (st-i-1) : case_instr (length bs1) : instrs)

    compileBranch ((t,n),eqs) bs =
      let case_instr =
            case t of
              (Q (_,id)) -> CASE (i2i id)
              (EInt n)   -> CASE_INT n
              (K s)      -> CASE_STR s
              (EFloat d) -> CASE_FLT d
          (bs1,instrs) = compileEquations gr (st+n) (push_is st n is) eqs ((case_instr (length bs1) : instrs) : bs)
      in bs1

compileBody gr st avs fvs e bs es =
  let (heap,bs1,instrs) = compileFun gr st avs fvs e 0 bs es
  in (bs1,((if heap > 0 then (ALLOC heap :) else id) .
           (instrs ++) .
           (if st == 0 then (UPDATE :) else id))
          [RET st])

compileFun gr st avs fvs (App e1 e2) h0 bs es =
  compileFun gr st avs fvs e1 h0 bs (e2:es)
compileFun gr st avs fvs (Q (m,id))  h0 bs es =
  case lookupAbsDef gr m id of
    Ok (_,Just _)
       -> let (h1,bs1,is1,is2,is3) = compileArgs gr st st avs fvs h0 bs (reverse es)
          in (h1,bs1,is3 ++ is2 ++ [TAIL_CALL (i2i id)])
    _  -> let h1 = h0 + 2 + length es
              (h2,bs2,is1,is2,is3) = compileArgs gr st st avs fvs h1 bs es
          in (h2,bs2,PUT_CONSTR (i2i id) : is1 ++ is3)
compileFun gr st avs fvs (QC qid)    h0 bs es =
  compileFun gr st avs fvs (Q qid) h0 bs es
compileFun gr st avs fvs (Vr x)      h0 bs es =
  let (h1,bs1,is1,is2,is3)  = compileArgs gr st st avs fvs h0 bs (reverse es)
      i = case lookup x avs of
            Just i  -> EVAL_ARG_VAR (st-i-1)
            Nothing -> case lookup x fvs of
                         Just i  -> EVAL_FREE_VAR i
                         Nothing -> error "compileFun: unknown variable"
  in (h1,bs1,is3 ++ is2 ++ [i])
compileFun gr st avs fvs (EInt n)    h0 bs _  =
  let h1 = h0 + 2
  in (h1,bs,[PUT_INT n])
compileFun gr st avs fvs (K s)       h0 bs _  =
  let h1 = h0 + 1 + (length s + 4) `div` 4
  in (h1,bs,[PUT_STR s])
compileFun gr st avs fvs (EFloat d)  h0 bs _  =
  let h1 = h0 + 3
  in (h1,bs,[PUT_FLT d])

compileArgs gr st st0 avs fvs h0 bs []     =
  (h0,bs,[],[],[])
compileArgs gr st st0 avs fvs h0 bs (e:es) =
  (h2,bs2,i1:is1,i2:is2,is++is3)
  where 
    (h1,bs1,i1,i2,is)    = compileArg gr st st0 avs fvs e h0 bs []
    (h2,bs2,is1,is2,is3) = compileArgs gr st (st0+1) avs fvs h1 bs1 es

compileArg gr st st0 avs fvs (App e1 e2) h0 bs es = compileArg gr st st0 avs fvs e1 h0 bs (e2:es)
compileArg gr st st0 avs fvs e@(Q(m,id)) h0 bs es =
  case lookupAbsDef gr m id of
    Ok (_,Just _)
       -> if null es
            then let h1 = h0 + 2
                 in (h1,bs,SET_VALUE h0,PUSH_VALUE h0,[PUT_FUN (i2i id),SET_PAD])
            else let es_fvs = nub (foldr freeVars [] es)
                     h1 = h0 + 1 + length is
                     (bs1,b) = compileBody gr 0 [] (zip es_fvs [0..]) e bs es
                     is = if null es_fvs
                            then [SET_PAD]
                            else map (fst . compileVar st st0 avs fvs) es_fvs
                 in (h1,(ENTER:b):bs1,SET_VALUE h0,PUSH_VALUE h0,PUT_CLOSURE (length bs) : is)
    _  -> let h1 = h0 + 2 + length es
              (h2,bs2,is1,is2,is3) = compileArgs gr st st avs fvs h1 bs es
          in (h2,bs2,SET_VALUE h0,PUSH_VALUE h0,PUT_CONSTR (i2i id) : is1 ++ is3)
compileArg gr st st0 avs fvs (QC qid)    h0 bs es = compileArg gr st st0 avs fvs (Q qid) h0 bs es
compileArg gr st st0 avs fvs (Vr x)      h0 bs es =
  let (i1,i2) = compileVar st st0 avs fvs x
  in (h0,bs,i1,i2,[])
compileArg gr st st0 avs fvs (EInt n)    h0 bs _  = 
  let h1 = h0 + 2
  in (h1,bs,SET_VALUE h0,PUSH_VALUE h0,[PUT_INT n])
compileArg gr st st0 avs fvs (K s)       h0 bs _  =
  let h1 = h0 + 1 + (length s + 4) `div` 4
  in (h1,bs,SET_VALUE h0,PUSH_VALUE h0,[PUT_STR s])
compileArg gr st st0 avs fvs (EFloat d)  h0 bs _  =
  let h1 = h0 + 3
  in (h1,bs,SET_VALUE h0,PUSH_VALUE h0,[PUT_FLT d])

compileVar st st0 avs fvs x =
  case lookup x avs of
    Just i  -> (SET_ARG_VAR (st-i-1),PUSH_ARG_VAR (st0-i-1))
    Nothing -> case lookup x fvs of
                 Just i  -> (SET_FREE_VAR i,PUSH_FREE_VAR i)
                 Nothing -> error "compileVar: unknown variable"

freeVars (App e1 e2) vs = (freeVars e1 . freeVars e2) vs
freeVars (Vr x)      vs = x:vs
freeVars _           vs = vs

i2i :: Ident -> CId
i2i = utf8CId . ident2utf8

push_is :: Int -> Int -> [Int] -> [Int]
push_is i 0 is = is
push_is i n is = i : push_is (i-1) (n-1) is
