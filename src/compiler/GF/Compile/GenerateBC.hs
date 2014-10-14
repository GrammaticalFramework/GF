module GF.Compile.GenerateBC(generateByteCode) where

import GF.Grammar
import GF.Grammar.Lookup(lookupAbsDef,lookupFunType)
import GF.Data.Operations
import PGF(CId,utf8CId)
import PGF.Internal(CodeLabel,Instr(..),IVal(..),TailInfo(..),Literal(..))
import qualified Data.Map as Map
import Data.List(nub,mapAccumL)

generateByteCode :: SourceGrammar -> Int -> [L Equation] -> [[Instr]]
generateByteCode gr arity eqs =
  let (bs,instrs) = compileEquations gr arity (arity+1) is 
                                     (map (\(L _ (ps,t)) -> ([],ps,t)) eqs) 
                                     Nothing
                                     [b]
      b = if arity == 0 || null eqs
            then instrs
            else CHECK_ARGS arity:instrs
  in case bs of
       [[FAIL]] -> []         -- in the runtime this is a more efficient variant of [[FAIL]]
       _        -> reverse bs
  where
    is = push_is (arity-1) arity []

compileEquations :: SourceGrammar -> Int -> Int -> [IVal] -> [([(Ident,IVal)],[Patt],Term)] -> Maybe (Int,CodeLabel) -> [[Instr]] -> ([[Instr]],[Instr])
compileEquations gr arity st _      []        fl bs = (bs,[mkFail st fl])
compileEquations gr arity st [] ((vs,[],t):_) fl bs = compileBody gr arity st vs t bs
compileEquations gr arity st (i:is) eqs       fl bs = whilePP eqs Map.empty
  where
    whilePP []                           cns = case Map.toList cns of
                                                 []       -> (bs,[FAIL])
                                                 (cn:cns) -> let (bs1,instrs1) = compileBranch0 fl bs cn
                                                                 bs2 = foldl (compileBranch fl) bs1 cns
                                                                 bs3 = [mkFail st fl]:bs2
                                                             in (bs3,EVAL (shiftIVal st i) RecCall : instrs1)
    whilePP ((vs, PP c ps' : ps, t):eqs) cns = whilePP eqs (Map.insertWith (++) (Q c,length ps') [(vs,ps'++ps,t)] cns)
    whilePP ((vs, PInt n   : ps, t):eqs) cns = whilePP eqs (Map.insertWith (++) (EInt n,0) [(vs,ps,t)] cns)
    whilePP ((vs, PString s: ps, t):eqs) cns = whilePP eqs (Map.insertWith (++) (K s,0) [(vs,ps,t)] cns)
    whilePP ((vs, PFloat d : ps, t):eqs) cns = whilePP eqs (Map.insertWith (++) (EFloat d,0) [(vs,ps,t)] cns)
    whilePP ((vs, PImplArg p:ps, t):eqs) cns = whilePP ((vs,p:ps,t):eqs) cns
    whilePP ((vs, PT _ p   : ps, t):eqs) cns = whilePP ((vs,p:ps,t):eqs) cns
    whilePP ((vs, PAs x p  : ps, t):eqs) cns = whilePP (((x,i):vs,p:ps,t):eqs) cns
    whilePP eqs                          cns = case Map.toList cns of
                                                 []       -> whilePV eqs []
                                                 (cn:cns) -> let fl1 = Just (st,length bs2)
                                                                 (bs1,instrs1) = compileBranch0 fl1 bs cn
                                                                 bs2 = foldl (compileBranch fl1) bs1 cns
                                                                 (bs3,instrs3) = compileEquations gr arity st (i:is) eqs fl (instrs3:bs2)
                                                             in (bs3,EVAL (shiftIVal st i) RecCall : instrs1)

    whilePV []                           vrs = compileEquations gr arity st is vrs fl bs
    whilePV ((vs, PV x     : ps, t):eqs) vrs = whilePV eqs (((x,i):vs,ps,t) : vrs)
    whilePV ((vs, PW       : ps, t):eqs) vrs = whilePV eqs ((      vs,ps,t) : vrs)
    whilePV ((vs, PTilde _ : ps, t):eqs) vrs = whilePV eqs ((      vs,ps,t) : vrs)
    whilePV ((vs, PImplArg p:ps, t):eqs) vrs = whilePV ((vs,p:ps,t):eqs) vrs
    whilePV ((vs, PT _ p   : ps, t):eqs) vrs = whilePV ((vs,p:ps,t):eqs) vrs
    whilePV eqs                          vrs = let fl1 = Just (st,length bs1)
                                                   (bs1,instrs1) = compileEquations gr arity st is vrs fl1 bs
                                                   (bs2,instrs2) = compileEquations gr arity st (i:is) eqs fl (instrs2:bs1)
                                               in (bs2,instrs1)

    case_instr t n =
      case t of
        (Q (_,id)) -> CASE (i2i id) n
        (EInt n)   -> CASE_LIT (LInt n)
        (K s)      -> CASE_LIT (LStr s)
        (EFloat d) -> CASE_LIT (LFlt d)

    compileBranch0 fl bs ((t,n),eqs) =
      let (bs1,instrs) = compileEquations gr arity (st+n) (push_is (st+n-1) n is) eqs fl bs
      in (bs1, case_instr t n (length bs1) : instrs)

    compileBranch l bs ((t,n),eqs) =
      let (bs1,instrs) = compileEquations gr arity (st+n) (push_is (st+n-1) n is) eqs fl ((case_instr t n (length bs1) : instrs) : bs)
      in bs1

mkFail st1 Nothing        = FAIL
mkFail st1 (Just (st0,l)) = DROP (st1-st0) l

compileBody gr arity st vs e bs =
  let (heap,bs1,is) = compileFun gr arity st vs e 0 bs []
  in (bs1,if heap > 0 then (ALLOC heap : is) else is)

compileFun gr arity st vs (Abs _ x e) h0 bs args =
  let (h1,bs1,arg,is1) = compileLambda gr st vs [x] e h0 bs
      (st1,is3)        = pushArgs st (reverse args)
  in (h1,bs1,is1++is3++[EVAL arg (if arity == 0 then (UpdateCall st st1) else (TailCall arity st st1))])
compileFun gr arity st vs (App e1 e2) h0 bs args =
  let (h1,bs1,arg,is1) = compileArg gr st vs e2 h0 bs
      (h2,bs2,is2) = compileFun gr arity st vs e1 h1 bs1 (arg:args)
  in (h2,bs2,is1++is2)
compileFun gr arity st vs (Q (m,id))  h0 bs args =
  case lookupAbsDef gr m id of
    Ok (_,Just _)
       -> let (st1,is1) = pushArgs st (reverse args)
          in (h0,bs,is1++[EVAL (GLOBAL (i2i id)) (if arity == 0 then (UpdateCall st st1) else (TailCall arity st st1))])
    _  -> let Ok ty = lookupFunType gr m id
              (ctxt,_,_) = typeForm ty
              c_arity    = length ctxt
              n_args = length args
              is1    = setArgs st args
              diff   = c_arity-n_args
          in if diff <= 0
               then if n_args == 0
                      then (h0,bs,[EVAL (GLOBAL (i2i id)) (if arity == 0 then (UpdateCall st st) else (TailCall arity st st))])
                      else let h1  = h0 + 2 + n_args
                           in (h1,bs,PUT_CONSTR (i2i id):is1++[EVAL (HEAP h0) (if arity == 0 then (UpdateCall st st) else (TailCall arity st st))])
               else let h1  = h0 + 1 + n_args
                        is2 = [SET (FREE_VAR i) | i <- [0..n_args-1]] ++ [SET (ARG_VAR (i+1)) | i <- [0..diff-1]]
                        b   = CHECK_ARGS diff : ALLOC (c_arity+2) : PUT_CONSTR (i2i id) : is2 ++ [EVAL (HEAP h0) (TailCall diff (diff+1) (diff+1))]
                    in (h1,b:bs,PUT_CLOSURE (length bs):is1++[EVAL (HEAP h0) (if arity == 0 then (UpdateCall st st) else (TailCall arity st st))])
compileFun gr arity st vs (QC qid)    h0 bs args =
  compileFun gr arity st vs (Q qid) h0 bs args
compileFun gr arity st vs (Vr x)      h0 bs args =
  let (st1,is1) = pushArgs st (reverse args)
      arg       = (shiftIVal st1 . getVar vs) x
  in (h0,bs,is1++[EVAL arg (if arity == 0 then (UpdateCall st st1) else (TailCall arity st st1))])
compileFun gr arity st vs (EInt n)    h0 bs _  =
  let h1 = h0 + 2
  in (h1,bs,[PUT_LIT (LInt n), EVAL (HEAP h0) (if arity == 0 then (UpdateCall st st) else (TailCall arity st st))])
compileFun gr arity st vs (K s)       h0 bs _  =
  let h1 = h0 + 2
  in (h1,bs,[PUT_LIT (LStr s), EVAL (HEAP h0) (if arity == 0 then (UpdateCall st st) else (TailCall arity st st))])
compileFun gr arity st vs (EFloat d)  h0 bs _  =
  let h1 = h0 + 2
  in (h1,bs,[PUT_LIT (LFlt d), EVAL (HEAP h0) (if arity == 0 then (UpdateCall st st) else (TailCall arity st st))])
compileFun gr arity st vs (Typed e _) h0 bs args =
  compileFun gr arity st vs e h0 bs args
compileFun gr arity st vs (Let (x, (_, e1)) e2) h0 bs args =
  let (h1,bs1,arg,is1) = compileLambda gr st vs [] e1 h0 bs
      (h2,bs2,is2) = compileFun gr arity st ((x,arg):vs) e2 h1 bs1 args
  in (h2,bs2,is1++is2)
compileFun gr arity st vs (Glue e1 e2) h0 bs args =
  let (h1,bs1,arg1,is1) = compileArg gr st vs e1 h0 bs
      (h2,bs2,arg2,is2) = compileArg gr st vs e2 h1 bs1
      (st1,is3) = pushArgs st [arg2,arg1]
  in (h2,bs2,is1++is2++is3++[ADD])
compileFun gr arity st vs e _ _ _ = error (show e)

compileArg gr st vs (Q(m,id)) h0 bs =
  case lookupAbsDef gr m id of
    Ok (_,Just _) -> (h0,bs,GLOBAL (i2i id),[])
    _             -> let Ok ty = lookupFunType gr m id
                         (ctxt,_,_) = typeForm ty
                         c_arity    = length ctxt
                     in if c_arity == 0
                          then (h0,bs,GLOBAL (i2i id),[])
                          else let is2 = [SET (ARG_VAR (i+1)) | i <- [0..c_arity-1]]
                                   b   = CHECK_ARGS c_arity : ALLOC (c_arity+2) : PUT_CONSTR (i2i id) : is2 ++ [EVAL (HEAP h0) (TailCall c_arity (c_arity+1) (c_arity+1))]
                                   h1  = h0 + 2
                               in (h1,b:bs,HEAP h0,[PUT_CLOSURE (length bs),SET_PAD])
compileArg gr st vs (QC qid)    h0 bs =
  compileArg gr st vs (Q qid) h0 bs
compileArg gr st vs (Vr x)      h0 bs =
  (h0,bs,getVar vs x,[])
compileArg gr st vs (EInt n)    h0 bs =
  let h1 = h0 + 2
  in (h1,bs,HEAP h0,[PUT_LIT (LInt n)])
compileArg gr st vs (K s)       h0 bs =
  let h1 = h0 + 2
  in (h1,bs,HEAP h0,[PUT_LIT (LStr s)])
compileArg gr st vs (EFloat d)  h0 bs =
  let h1 = h0 + 2
  in (h1,bs,HEAP h0,[PUT_LIT (LFlt d)])
compileArg gr st vs (Typed e _) h0 bs =
  compileArg gr st vs e h0 bs
compileArg gr st vs (ImplArg e) h0 bs =
  compileArg gr st vs e h0 bs
compileArg gr st vs e           h0 bs =
  let (f,es)   = appForm e
      isConstr = case f of
                   Q c@(m,id) -> case lookupAbsDef gr m id of
                                   Ok (_,Just _) -> Nothing
                                   _             -> Just c
                   QC c@(m,id) -> case lookupAbsDef gr m id of
                                    Ok (_,Just _) -> Nothing
                                    _             -> Just c
                   _        -> Nothing
  in case isConstr of
       Just (m,id) ->
            let Ok ty = lookupFunType gr m id
                (ctxt,_,_) = typeForm ty
                c_arity    = length ctxt
                ((h1,bs1,is1),args) = mapAccumL (\(h,bs,is) e -> let (h1,bs1,arg,is1) = compileArg gr st vs e h bs
                                                                 in ((h1,bs1,is++is1),arg)) 
                                                (h0,bs,[])
                                                es
                n_args = length args
                is2 = setArgs st args
                diff   = c_arity-n_args
            in if diff <= 0
                 then let h2  = h1 + 2 + n_args
                      in (h2,bs1,HEAP h1,is1 ++ (PUT_CONSTR (i2i id) : is2))
                 else let h2  = h1 + 1 + n_args
                          is2 = [SET (FREE_VAR i) | i <- [0..n_args-1]] ++ [SET (ARG_VAR (i+1)) | i <- [0..diff-1]]
                          b   = CHECK_ARGS diff : ALLOC (c_arity+2) : PUT_CONSTR (i2i id) : is2 ++ [EVAL (HEAP h0) (TailCall diff (diff+1) (diff+1))]
                      in (h2,b:bs1,HEAP h1,is1 ++ (PUT_CLOSURE (length bs):is2))
       Nothing -> compileLambda gr st vs [] e h0 bs

compileLambda gr st vs xs (Abs _ x e) h0 bs =
  compileLambda gr st vs (x:xs) e h0 bs
compileLambda gr st vs xs e           h0 bs =
  let ys      = nub (freeVars xs e)
      arity   = length xs
      (bs1,b) = compileBody gr arity
                               (arity+1)
                               (zip xs (map ARG_VAR  [0..]) ++
                                zip ys (map FREE_VAR [0..]))
                               e (b1:bs)
      b1 = if arity == 0
             then b
             else CHECK_ARGS arity:b
      is = if null ys
             then [SET_PAD]
             else map (SET . shiftIVal st . getVar vs) ys
      h1 = h0 + 1 + length is
  in (h1,bs1,HEAP h0,PUT_CLOSURE (length bs) : is)

getVar vs x =
  case lookup x vs of
    Just arg         -> arg
    Nothing          -> error "compileVar: unknown variable"

shiftIVal st (ARG_VAR i) = ARG_VAR (st-i-1)
shiftIVal st arg         = arg

pushArgs st []         = (st,[])
pushArgs st (arg:args) = let (st1,is) = pushArgs (st+1) args
                         in (st1, PUSH (shiftIVal st arg) : is)

setArgs st []         = []
setArgs st (arg:args) = SET (shiftIVal st arg) : setArgs st args

freeVars xs (Abs _ x e) = freeVars (x:xs) e
freeVars xs (Vr x)     
  | not (elem x xs)     = [x]
freeVars xs e           = collectOp (freeVars xs) e

i2i :: Ident -> CId
i2i = utf8CId . ident2utf8

push_is :: Int -> Int -> [IVal] -> [IVal]
push_is i 0 is = is
push_is i n is = ARG_VAR i : push_is (i-1) (n-1) is
