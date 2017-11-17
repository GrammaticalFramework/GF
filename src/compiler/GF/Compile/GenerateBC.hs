{-# LANGUAGE CPP #-}
module GF.Compile.GenerateBC(generateByteCode) where

import GF.Grammar
import GF.Grammar.Lookup(lookupAbsDef,lookupFunType)
import GF.Data.Operations
import PGF.Internal(CodeLabel,Instr(..),IVal(..),TailInfo(..),Literal(..))
import qualified Data.Map as Map
import Data.List(nub,mapAccumL)
import Data.Maybe(fromMaybe)

#if C_RUNTIME
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
compileEquations gr arity st _      []        fl bs = (bs,mkFail arity st fl)
compileEquations gr arity st [] ((vs,[],t):_) fl bs = compileBody gr arity st vs t bs
compileEquations gr arity st (i:is) eqs       fl bs = whilePP eqs Map.empty
  where
    whilePP []                           cns = case Map.toList cns of
                                                 []       -> (bs,[FAIL])
                                                 (cn:cns) -> let (bs1,instrs1) = compileBranch0 fl bs cn
                                                                 bs2 = foldl (compileBranch fl) bs1 cns
                                                                 bs3 = mkFail arity st fl : bs2
                                                             in (bs3,[PUSH_FRAME, EVAL (shiftIVal (st+2) i) RecCall] ++ instrs1)
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
                                                             in (bs3,[PUSH_FRAME, EVAL (shiftIVal (st+2) i) RecCall] ++ instrs1)

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

    case_instr t =
      case t of
        (Q (_,id)) -> CASE (showIdent id)
        (EInt n)   -> CASE_LIT (LInt n)
        (K s)      -> CASE_LIT (LStr s)
        (EFloat d) -> CASE_LIT (LFlt d)

    saves n = reverse [SAVE i | i <- [0..n-1]]

    compileBranch0 fl bs ((t,n),eqs) =
      let (bs1,instrs) = compileEquations gr arity (st+n) (push_is (st+n-1) n is) eqs fl bs
      in (bs1, case_instr t (length bs1) : saves n ++ instrs)

    compileBranch l bs ((t,n),eqs) =
      let (bs1,instrs) = compileEquations gr arity (st+n) (push_is (st+n-1) n is) eqs fl ((case_instr t (length bs1) : saves n ++ instrs) : bs)
      in bs1

mkFail arity st1 Nothing
  | arity+1 /= st1 = [DROP (st1-arity), FAIL]
  | otherwise      = [FAIL]
mkFail arity st1 (Just (st0,l))
  | st1 /= st0     = [DROP (st1-st0), JUMP l]
  | otherwise      = [JUMP l]

compileBody gr arity st vs e bs =
  let eval st fun args 
        | arity == 0 = let (st1,is) = pushArgs (st+2) (reverse args)
                           fun'     = shiftIVal st1 fun
                       in [PUSH_FRAME]++is++[EVAL fun' UpdateCall]
        | otherwise  = let (st1,fun',is) = tuckArgs arity st fun args
                       in is++[EVAL fun' (TailCall (st1-length args-1))]
      (heap,bs1,is) = compileFun gr eval st vs e 0 bs []
  in (bs1,if heap > 0 then (ALLOC heap : is) else is)

compileFun gr eval st vs (Abs _ x e) h0 bs args =
  let (h1,bs1,arg,is1) = compileLambda gr st vs [x] e h0 bs
  in (h1,bs1,is1++eval st arg args)
compileFun gr eval st vs (App e1 e2) h0 bs args =
  let (h1,bs1,arg,is1) = compileArg gr st vs e2 h0 bs
      (h2,bs2,is2) = compileFun gr eval st vs e1 h1 bs1 (arg:args)
  in (h2,bs2,is1++is2)
compileFun gr eval st vs (Q (m,id))  h0 bs args =
  case lookupAbsDef gr m id of
    Ok (_,Just _)
       -> (h0,bs,eval st (GLOBAL (showIdent id)) args)
    _  -> let Ok ty = lookupFunType gr m id
              (ctxt,_,_) = typeForm ty
              c_arity    = length ctxt
              n_args = length args
              is1    = setArgs st args
              diff   = c_arity-n_args
          in if diff <= 0
               then if n_args == 0
                      then (h0,bs,eval st (GLOBAL (showIdent id)) [])
                      else let h1  = h0 + 2 + n_args
                           in (h1,bs,PUT_CONSTR (showIdent id):is1++eval st (HEAP h0) [])
               else let h1  = h0 + 1 + n_args
                        is2 = [SET (FREE_VAR i) | i <- [0..n_args-1]] ++ [SET (ARG_VAR (i+1)) | i <- [0..diff-1]]
                        b   = CHECK_ARGS diff :
                              ALLOC (c_arity+2) : 
                              PUT_CONSTR (showIdent id) : 
                              is2 ++
                              TUCK (ARG_VAR 0) diff :
                              EVAL (HEAP h0) (TailCall diff) :
                              []
                    in (h1,b:bs,PUT_CLOSURE (length bs):is1++eval st (HEAP h0) [])
compileFun gr eval st vs (QC qid)    h0 bs args =
  compileFun gr eval st vs (Q qid) h0 bs args
compileFun gr eval st vs (Vr x)      h0 bs args =
  (h0,bs,eval st (getVar vs x) args)
compileFun gr eval st vs (EInt n)    h0 bs _  =
  let h1 = h0 + 2
  in (h1,bs,PUT_LIT (LInt n) : eval st (HEAP h0) [])
compileFun gr eval st vs (K s)       h0 bs _  =
  let h1 = h0 + 2
  in (h1,bs,PUT_LIT (LStr s) : eval st (HEAP h0) [])
compileFun gr eval st vs (EFloat d)  h0 bs _  =
  let h1 = h0 + 2
  in (h1,bs,PUT_LIT (LFlt d) : eval st (HEAP h0) [])
compileFun gr eval st vs (Typed e _) h0 bs args =
  compileFun gr eval st vs e h0 bs args
compileFun gr eval st vs (Let (x, (_, e1)) e2) h0 bs args =
  let (h1,bs1,arg,is1) = compileLambda gr st vs [] e1 h0 bs
      (h2,bs2,is2) = compileFun gr eval st ((x,arg):vs) e2 h1 bs1 args
  in (h2,bs2,is1++is2)
compileFun gr eval st vs e@(Glue e1 e2) h0 bs args =
  let eval' st fun args = [PUSH_FRAME]++is++[EVAL fun' RecCall]
                          where
                            (_st1,is) = pushArgs (st+2) (reverse args)
                            fun'     = shiftIVal st fun

      flatten (Glue e1 e2) h0 bs =
        let (h1,bs1,is1) = flatten e1 h0 bs
            (h2,bs2,is2) = flatten e2 h1 bs1
        in (h2,bs2,is1++is2)
      flatten e            h0 bs =
        let (h1,bs1,is1) = compileFun gr eval' (st+3) vs e  h0 bs  args
        in (h1,bs1,is1++[ADD])

      (h1,bs1,is) = flatten e h0 bs

  in (h1,bs1,[PUSH_ACCUM (LFlt 0)]++is++[POP_ACCUM]++eval (st+1) (ARG_VAR st) [])
compileFun gr eval st vs e _ _ _ = error (show e)

compileArg gr st vs (Q(m,id)) h0 bs =
  case lookupAbsDef gr m id of
    Ok (_,Just _) -> (h0,bs,GLOBAL (showIdent id),[])
    _             -> let Ok ty = lookupFunType gr m id
                         (ctxt,_,_) = typeForm ty
                         c_arity    = length ctxt
                     in if c_arity == 0
                          then (h0,bs,GLOBAL (showIdent id),[])
                          else let is2 = [SET (ARG_VAR (i+1)) | i <- [0..c_arity-1]]
                                   b   = CHECK_ARGS c_arity :
                                         ALLOC (c_arity+2) :
                                         PUT_CONSTR (showIdent id) :
                                         is2 ++
                                         TUCK (ARG_VAR 0) c_arity :
                                         EVAL (HEAP h0) (TailCall c_arity) :
                                         []
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
                      in (h2,bs1,HEAP h1,is1 ++ (PUT_CONSTR (showIdent id) : is2))
                 else let h2  = h1 + 1 + n_args
                          is2 = [SET (FREE_VAR i) | i <- [0..n_args-1]] ++ [SET (ARG_VAR (i+1)) | i <- [0..diff-1]]
                          b   = CHECK_ARGS diff :
                                ALLOC (c_arity+2) :
                                PUT_CONSTR (showIdent id) :
                                is2 ++
                                TUCK (ARG_VAR 0) diff :
                                EVAL (HEAP h0) (TailCall diff) :
                                []
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

tuckArgs arity st fun args = (st2,shiftIVal st2 fun',is1++is2)
  where
    (st2,fun',is2) = tucks st1 0 fun tas
    (st1,is1) = pushArgs st pas
    (tas,pas) = splitAt st args'
    args' = reverse (ARG_VAR arity : args)

    tucks st i fun []             = (st,fun,[])
    tucks st i fun (arg:args)
      | arg == ARG_VAR i      = tucks st (i+1) fun args
      | otherwise             = case save st (ARG_VAR i) (fun:args) of
                                  Just (fun:args) -> let (st1,fun',is) = tucks (st+1) (i+1) fun args
                                                     in (st1, fun', PUSH (ARG_VAR (st-i-1)) :
                                                                    TUCK (shiftIVal (st+1) arg) (st-i) : is)
                                  Nothing         -> let (st1,fun',is) = tucks st (i+1) fun args
                                                     in (st1, fun', TUCK (shiftIVal st arg) (st-i-1) : is)

    save st arg0 []         = Nothing
    save st arg0 (arg:args)
      | arg0 == arg         = Just (ARG_VAR st1 : fromMaybe args (save st arg0 args))
      | otherwise           = fmap (arg :) (save st arg0 args)

setArgs st []         = []
setArgs st (arg:args) = SET (shiftIVal st arg) : setArgs st args

freeVars xs (Abs _ x e) = freeVars (x:xs) e
freeVars xs (Vr x)     
  | not (elem x xs)     = [x]
freeVars xs e           = collectOp (freeVars xs) e

push_is :: Int -> Int -> [IVal] -> [IVal]
push_is i 0 is = is
push_is i n is = ARG_VAR i : push_is (i-1) (n-1) is

#else
generateByteCode = error "generateByteCode is not implemented"
#endif
