module TypeCheck where

import Operations
import Zipper

import Abstract
import AbsCompute
import Refresh
import LookAbs

import TC

import Unify ---

import Monad (foldM, liftM, liftM2)

-- top-level type checking functions; TC should not be called directly.

annotate :: GFCGrammar -> Exp -> Err Tree
annotate gr exp = annotateIn gr [] exp Nothing 

-- type check in empty context, return a list of constraints
justTypeCheck :: GFCGrammar -> Exp -> Val -> Err Constraints
justTypeCheck gr e v = do
  (_,constrs0) <- checkExp (grammar2theory gr) (initTCEnv []) e v
  constrs1     <- reduceConstraints gr 0 constrs0
  return $ fst $ splitConstraints constrs1

-- type check in empty context, return the expression itself if valid
checkIfValidExp :: GFCGrammar -> Exp -> Err Exp
checkIfValidExp gr e = do
  (_,_,constrs0) <- inferExp (grammar2theory gr) (initTCEnv []) e
  constrs1       <- reduceConstraints gr 0 constrs0
  ifNull (return e) (Bad  . unwords . prConstrs) constrs1

annotateIn :: GFCGrammar -> Binds -> Exp -> Maybe Val -> Err Tree
annotateIn gr gamma exp = maybe (infer exp) (check exp) where
  infer e = do 
    (a,_,cs) <- inferExp theory env e
    aexp2treeC (a,cs)
  check e v = do
    (a,cs) <- checkExp theory env e v
    aexp2treeC (a,cs)
  env = initTCEnv gamma
  theory = grammar2theory gr 
  aexp2treeC (a,c) = do
    c' <- reduceConstraints gr (length gamma) c
    aexp2tree (a,c')

-- invariant way of creating TCEnv from context
initTCEnv gamma = 
  (length gamma,[(x,VGen i x) | ((x,_),i) <- zip gamma [0..]], gamma) 

-- process constraints after eqVal by computing by defs
reduceConstraints :: GFCGrammar -> Int -> Constraints -> Err Constraints
reduceConstraints gr i = liftM concat . mapM redOne where
  redOne (u,v) = do
    u' <- computeVal gr u
    v' <- computeVal gr v
    eqVal i u' v' 

computeVal :: GFCGrammar -> Val -> Err Val
computeVal gr v = case v of
  VClos g@(_:_) e -> do
    e' <- compt (map fst g) e          --- bindings of g in e?
    whnf $ VClos g e'
  VApp f c -> liftM2 VApp (compv f) (compv c) >>= whnf
  _ -> whnf v
 where
   compt = computeAbsTermIn gr
   compv = computeVal gr

-- take apart constraints that have the form (? <> t), usable as solutions
splitConstraints :: Constraints -> (Constraints,MetaSubst)
splitConstraints cs = csmsu where

  csmsu     = unif (csf,msf)  -- alternative: filter first
  (csf,msf) = foldr mkOne ([],[]) cs

  csmsf     = foldr mkOne ([],msu) csu
  (csu,msu) = unif (cs,[])    -- alternative: unify first

  mkOne (u,v) = case (u,v) of
    (VClos g (Meta m), v) | null g -> sub m v
    (v, VClos g (Meta m)) | null g -> sub m v
    -- do nothing if meta has nonempty closure; null g || isConstVal v WAS WRONG
    c -> con c
  con c (cs,ms) = (c:cs,ms)
  sub m v (cs,ms) = (cs,(m,v):ms)

  unifo = id -- alternative: don't use unification

  unif cm@(cs,ms) = errVal cm $ do --- alternative: use unification  
    (cs',ms') <- unifyVal cs
    return (cs', ms' ++ ms)

performMetaSubstNode :: MetaSubst -> TrNode -> TrNode
performMetaSubstNode subst n@(N (b,a,v,(c,m),s)) = let
  v' = metaSubstVal v
  b' = [(x,metaSubstVal v) | (x,v) <- b]
  c' = [(u',v') | (u,v) <- c, 
                  let (u',v') = (metaSubstVal u, metaSubstVal v), u' /= v']
  in N (b',a,v',(c',m),s)
 where
   metaSubstVal u = errVal u $ whnf $ case u of
     VApp  f a -> VApp  (metaSubstVal f) (metaSubstVal a)
     VClos g e -> VClos [(x,metaSubstVal v) | (x,v) <- g] (metaSubstExp e)
     _ -> u
   metaSubstExp e = case e of
     Meta m -> errVal e $ maybe (return e) val2expSafe $ lookup m subst
     _ -> composSafeOp metaSubstExp e

-- weak heuristic to narrow down menus; not used for TC. 15/11/2001
-- the age-old method from GF 0.9
possibleConstraints :: GFCGrammar -> Constraints -> Bool
possibleConstraints gr = and . map (possibleConstraint gr)

possibleConstraint :: GFCGrammar -> (Val,Val) -> Bool
possibleConstraint gr (u,v) = errVal True $ do
    u' <- val2exp u >>= compute gr
    v' <- val2exp v >>= compute gr
    return $ cts u' v'
 where
  cts t u = isUnknown t || isUnknown u || case (t,u) of
    (Q m c,      Q n d)      -> c == d || notCan (m,c) || notCan (n,d)
    (QC m c,     QC n d)     -> c == d
    (App f a,    App g b)    -> cts f g && cts a b
    (Abs x b,    Abs y c)    -> cts b c
    (Prod x a f, Prod y b g) -> cts a b && cts f g
    (_         , _)          -> False

  isUnknown t = case t of
    Vr _ -> True
    Meta _ -> True
    _ -> False

  notCan = not . isPrimitiveFun gr

-- interface to TC type checker

type2val :: Type -> Val
type2val = VClos []

aexp2tree :: (AExp,[(Val,Val)]) -> Err Tree
aexp2tree (aexp,cs) = do
  (bi,at,vt,ts) <- treeForm aexp
  ts' <- mapM aexp2tree [(t,[]) | t <- ts]
  return $ Tr (N (bi,at,vt,(cs,[]),False),ts')
 where
  treeForm a = case a of
     AAbs x v b  -> do
       (bi, at, vt, args) <- treeForm b
       v' <- whnf v ---- should not be needed...
       return ((x,v') : bi, at, vt, args)
     AApp c a v -> do
       (_,at,_,args) <- treeForm c
       v' <- whnf v ---- 
       return ([],at,v',args ++ [a]) 
     AVr x v -> do
       v' <- whnf v ---- 
       return ([],AtV x,v',[])
     ACn c v -> do
       v' <- whnf v ---- 
       return ([],AtC c,v',[])
     AMeta m v -> do
       v' <- whnf v ---- 
       return ([],AtM m,v',[])
     _ -> Bad "illegal tree" -- AProd

grammar2theory :: GFCGrammar -> Theory
grammar2theory gr (m,f) = case lookupFunType gr m f of
  Ok t -> return $ type2val t
  Bad s -> case lookupCatContext gr m f of
    Ok cont -> return $ cont2val cont
    _ -> Bad s

cont2exp :: Context -> Exp
cont2exp c = mkProd (c, eType, []) -- to check a context

cont2val :: Context -> Val
cont2val = type2val . cont2exp

-- some top-level batch-mode checkers for the compiler

justTypeCheckSrc :: Grammar -> Exp -> Val -> Err Constraints
justTypeCheckSrc gr e v = do
  (_,constrs0) <- checkExp (grammar2theorySrc gr) (initTCEnv []) e v
-----  constrs1     <- reduceConstraints gr 0 constrs0
  return $ fst $ splitConstraints constrs0

grammar2theorySrc :: Grammar -> Theory
grammar2theorySrc gr (m,f) = case lookupFunTypeSrc gr m f of
  Ok t -> return $ type2val t
  Bad s -> case lookupCatContextSrc gr m f of
    Ok cont -> return $ cont2val cont
    _ -> Bad s

checkContext :: Grammar -> Context -> [String]
checkContext st = checkTyp st . cont2exp

checkTyp :: Grammar -> Type -> [String]
checkTyp gr typ = err singleton prConstrs $ justTypeCheckSrc gr typ vType

checkEquation :: Grammar -> Fun -> Trm -> [String]
checkEquation gr (m,fun) def = err singleton id $ do
  typ  <- lookupFunTypeSrc gr m fun
  cs   <- justTypeCheckSrc gr def (vClos typ)
  let cs1 = cs ----- filter (not . possibleConstraint gr) cs ----
  return $ ifNull [] (singleton . prConstraints) cs1

checkConstrs :: Grammar -> Cat -> [Ident] -> [String]
checkConstrs gr cat _ = [] ---- check constructors!





 
{- ----
err singleton concat . mapM checkOne where
  checkOne con = do
    typ   <- lookupFunType gr con
    typ'  <- computeAbsTerm gr typ
    vcat  <- valCat typ'
    return $ if (cat == vcat) then [] else ["wrong type in constructor" +++ prt con]
-}

editAsTermCommand :: GFCGrammar -> (Loc TrNode -> Err (Loc TrNode)) -> Exp -> [Exp]
editAsTermCommand gr c e = err (const []) singleton $ do
  t  <- annotate gr $ refreshMetas [] e
  t' <- c $ tree2loc t
  return $ tree2exp $ loc2tree t'

exp2termCommand :: GFCGrammar -> (Exp -> Err Exp) -> Tree -> Err Tree
exp2termCommand gr f t = errIn ("modifying term" +++ prt t) $ do
  let exp = tree2exp t
  exp2 <- f exp
  annotate gr exp2
