----------------------------------------------------------------------
-- |
-- Module      : (Module)
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/02/18 19:21:22 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.10 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module Editing where

import Abstract
import qualified GFC
import TypeCheck
import LookAbs
import AbsCompute
import Macros (errorCat)

import Operations
import Zipper

-- generic tree editing, with some grammar notions assumed. AR 18/8/2001 
-- 19/6/2003 for GFC

type CGrammar = GFC.CanonGrammar

type State = Loc TrNode

-- the "empty" state
initState :: State
initState = tree2loc uTree 

isRootState :: State -> Bool
isRootState s = case actPath s of
  Top -> True
  _ -> False

actTree :: State -> Tree
actTree (Loc (t,_)) = t

actPath :: State -> Path TrNode
actPath (Loc (_,p)) = p

actVal :: State -> Val
actVal = valNode . nodeTree . actTree

actCat :: State -> Cat
actCat = errVal errorCat . val2cat . actVal ---- undef

actAtom :: State -> Atom
actAtom = atomTree . actTree

actFun :: State -> Err Fun
actFun s = case actAtom s of
  AtC f -> return f
  t -> prtBad "active atom: expected function, found" t

actExp = tree2exp . actTree

-- current local bindings
actBinds :: State -> Binds
actBinds = bindsNode . nodeTree . actTree

-- constraints in current subtree
actConstrs :: State -> Constraints
actConstrs = allConstrsTree . actTree   

-- constraints in the whole tree
allConstrs :: State -> Constraints
allConstrs = allConstrsTree . loc2tree   

-- metas in current subtree
actMetas :: State -> [Meta]
actMetas = metasTree . actTree   

-- metas in the whole tree
allMetas :: State -> [Meta]
allMetas = metasTree . loc2tree

actTreeBody :: State -> Tree
actTreeBody = bodyTree . actTree

allPrevBinds :: State -> Binds
allPrevBinds = concatMap bindsNode . traverseCollect . actPath

allBinds :: State -> Binds
allBinds s = actBinds s ++ allPrevBinds s

actGen :: State -> Int
actGen = length . allBinds -- symbol generator for VGen

allPrevVars :: State -> [Var]
allPrevVars = map fst . allPrevBinds

allVars :: State -> [Var]
allVars = map fst . allBinds

vGenIndex = length . allBinds

actIsMeta = atomIsMeta . actAtom

actMeta :: State -> Err Meta
actMeta = getMetaAtom . actAtom

-- meta substs are not only on the actual path...
entireMetaSubst :: State -> MetaSubst
entireMetaSubst = concatMap metaSubstsNode . scanTree . loc2tree

isCompleteTree = null . filter atomIsMeta . map atomNode . scanTree 
isCompleteState = isCompleteTree . loc2tree

initStateCat :: Context -> Cat -> Err State
initStateCat cont cat = do
  return $ tree2loc (Tr (mkNode [] mAtom (cat2val cont cat) ([],[]), []))

-- this function only concerns the body of an expression...
annotateInState :: CGrammar -> Exp -> State -> Err Tree
annotateInState gr exp state = do
  let binds = allBinds state
      val   = actVal state
  annotateIn gr binds exp (Just val)

-- ...whereas this one works with lambda abstractions
annotateExpInState :: CGrammar -> Exp -> State -> Err Tree
annotateExpInState gr exp state = do
  let cont  = allPrevBinds state
      binds = actBinds state
      val   = actVal state
  typ <- mkProdVal binds val
  annotateIn gr binds exp (Just typ)
  
treeByExp :: (Exp -> Err Exp) -> CGrammar -> Exp -> State -> Err Tree
treeByExp trans gr exp0 state = do
  exp <- trans exp0
  annotateExpInState gr exp state

-- actions

type Action = State -> Err State

newCat :: CGrammar -> Cat -> Action
newCat gr cat@(m,c) _ = do
  cont <- lookupCatContext gr m c
  testErr (null cont) "start cat must have null context" -- for easier meta refresh
  initStateCat cont cat

newFun :: CGrammar -> Fun -> Action
newFun gr fun@(m,c) _ = do
  typ <- lookupFunType gr m c
  cat <- valCat typ
  st1 <- newCat gr cat initState
  refineWithAtom True gr (qq fun) st1

newTree :: Tree -> Action
newTree t _ = return $ tree2loc t

newExpTC :: CGrammar -> Exp -> Action
newExpTC gr t s = annotate gr (refreshMetas [] t) >>= flip newTree s

goNextMeta, goPrevMeta, goNextNewMeta, goPrevNewMeta, goNextMetaIfCan :: Action

goNextMeta = repeatUntilErr actIsMeta goAhead -- can be the location itself
goPrevMeta = repeatUntilErr actIsMeta goBack

goNextNewMeta s = goAhead s >>= goNextMeta    -- always goes away from location
goPrevNewMeta s = goBack  s >>= goPrevMeta

goNextMetaIfCan = actionIfPossible goNextMeta

actionIfPossible a s = return $ errVal s (a s)

goFirstMeta, goLastMeta :: Action
goFirstMeta s = goNextMeta $ goRoot s
goLastMeta  s = goLast s >>= goPrevMeta

noMoreMetas :: State -> Bool
noMoreMetas = err (const True) (const False) . goNextMeta 

replaceSubTree :: Tree -> Action
replaceSubTree tree state = changeLoc state tree

refineOrReplaceWithTree :: Bool -> CGrammar -> Tree -> Action
refineOrReplaceWithTree der gr tree state = case actMeta state of
  Ok m -> refineWithTreeReal der gr tree m state
  _ -> do
    let tree1 = addBinds (actBinds state) $ tree
    state' <- replaceSubTree tree1 state
    reCheckState gr state'

refineWithTree :: Bool -> CGrammar -> Tree -> Action
refineWithTree der gr tree state = do
  m <- errIn "move pointer to meta" $ actMeta state
  refineWithTreeReal der gr tree m state

refineWithTreeReal :: Bool -> CGrammar -> Tree -> Meta -> Action
refineWithTreeReal der gr tree m state = do
  state' <- replaceSubTree tree state
  let cs0     = allConstrs state'
      (cs,ms) = splitConstraints gr cs0
      v       = vClos $ tree2exp (bodyTree tree)
      msubst  = (m,v) : ms
  metaSubstRefinements gr msubst $ 
    mapLoc (reduceConstraintsNode gr . performMetaSubstNode msubst) state'

  -- without dep. types, no constraints, no grammar needed - simply: do
  --   testErr (actIsMeta state) "move pointer to meta"
  --   replaceSubTree tree state

refineAllNodes :: Action -> Action
refineAllNodes act state = do  
  let estate0 = goFirstMeta state
  case estate0 of
    Bad _ -> return state
    Ok state0 -> do 
      (state',n) <- tryRefine 0 state0
      if n==0 
        then return state
        else actionIfPossible goFirstMeta state'
 where
   tryRefine n state = err (const $ return (state,n)) return $ do 
     state' <- goNextMeta state
     meta   <- actMeta state'
     case act state' of
       Ok state2 -> tryRefine (n+1) state2
       _ -> err (const $ return (state',n)) return $ do
         state2 <- goNextNewMeta state' 
         tryRefine n state2

uniqueRefinements :: CGrammar -> Action
uniqueRefinements = refineAllNodes . uniqueRefine

metaSubstRefinements :: CGrammar -> MetaSubst -> Action
metaSubstRefinements gr = refineAllNodes . metaSubstRefine gr

contextRefinements :: CGrammar -> Action
contextRefinements gr = refineAllNodes contextRefine where
  contextRefine state = case varRefinementsState state of
    [(e,_)] -> refineWithAtom False gr e state
    _ -> Bad "no unique refinement in context"
  varRefinementsState state = 
    [r | r@(e,_) <- refinementsState gr state, isVariable e]

uniqueRefine :: CGrammar -> Action
uniqueRefine gr state = case refinementsState gr state of
  [(e,(_,True))] -> Bad "only circular refinement"
  [(e,_)] -> refineWithAtom False gr e state
  _ -> Bad "no unique refinement"

metaSubstRefine :: CGrammar -> MetaSubst -> Action
metaSubstRefine gr msubst state = do
  m <- errIn "move pointer to meta" $ actMeta state
  case lookup m msubst of
    Just v -> do
       e <- val2expSafe v
       refineWithExpTC False gr e state
    _ -> Bad "no metavariable substitution available"

refineWithExpTC :: Bool -> CGrammar -> Exp -> Action
refineWithExpTC der gr exp0 state = do
  let oldmetas = allMetas state
      exp = refreshMetas oldmetas exp0
  tree0 <- annotateInState gr exp state
  let tree = addBinds (actBinds state) $ tree0
  refineWithTree der gr tree state

refineWithAtom :: Bool -> CGrammar -> Ref -> Action -- function or variable
refineWithAtom der gr at state = do
  val <- lookupRef gr (allBinds state) at
  typ <- val2exp val
  let oldvars  = allVars state
  exp <- ref2exp oldvars typ at
  refineWithExpTC der gr exp state

-- in this command, we know that the result is well-typed, since computation
-- rules have been type checked and the result is equal

computeSubTree :: CGrammar -> Action
computeSubTree gr state = do
  let exp = tree2exp (actTree state)
  tree <- treeByExp (compute gr) gr exp state
  replaceSubTree tree state

-- but here we don't, since the transfer flag isn't type checked,
-- and computing the transfer function is not checked to preserve equality

transferSubTree :: Maybe Fun -> CGrammar -> Action
transferSubTree Nothing _ s = return s
transferSubTree (Just fun) gr state = do
  let exp = mkApp (qq fun) [tree2exp $ actTree state]
  tree <- treeByExp (compute gr) gr exp state
  state' <- replaceSubTree tree state
  reCheckState gr state'

deleteSubTree :: CGrammar -> Action
deleteSubTree gr state = 
  if isRootState state
     then do
       let cat = actCat state
       newCat gr cat state
     else do
       let metas = allMetas state
           binds = actBinds state
           exp = refreshMetas metas mExp0
       tree <- annotateInState gr exp state
       state' <- replaceSubTree (addBinds binds tree) state
       reCheckState gr state' --- must be unfortunately done. 20/11/2001

wrapWithFun :: CGrammar -> (Fun,Int) -> Action
wrapWithFun gr (f@(m,c),i) state = do
  typ <- lookupFunType gr m c
  let olds = allPrevVars state
      oldmetas = allMetas state
  exp0  <- fun2wrap olds ((f,i),typ) (tree2exp (actTreeBody state))
  let exp = refreshMetas oldmetas exp0
  tree0 <- annotateInState gr exp state  
  let tree = addBinds (actBinds state) $ tree0
  state' <- replaceSubTree tree state
  reCheckState gr state' --- must be unfortunately done. 20/11/2001

alphaConvert :: CGrammar -> (Var,Var) -> Action
alphaConvert gr (x,x') state = do
  let oldvars = allPrevVars state
  testErr (notElem x' oldvars) ("clash with previous bindings" +++ show x')
  let binds0  = actBinds state
      vars0   = map fst binds0
  testErr (notElem x' vars0) ("clash with other bindings" +++ show x')
  let binds   = [(if z==x then x' else z, t) | (z,t) <- binds0]
      vars    = map fst binds
  exp' <- alphaConv (vars ++ oldvars) (x,x') (tree2exp (actTreeBody state))
  let exp = mkAbs vars exp'
  tree <- annotateExpInState gr exp state
  replaceSubTree tree state

changeFunHead :: CGrammar -> Fun -> Action
changeFunHead gr f state = do
  let state' = changeNode (changeAtom (const (atomC f))) state
  reCheckState gr state' --- must be done because of constraints elsewhere

peelFunHead :: CGrammar -> (Fun,Int) -> Action
peelFunHead gr (f@(m,c),i) state = do
  tree0 <- nthSubtree i $ actTree state
  let tree = addBinds (actBinds state) $ tree0
  state' <- replaceSubTree tree state
  reCheckState gr state' --- must be unfortunately done. 20/11/2001

-- an expensive operation
reCheckState :: CGrammar -> State -> Err State
reCheckState gr st = annotate gr (tree2exp (loc2tree st)) >>= return . tree2loc

-- extract metasubstitutions from constraints and solve them
solveAll :: CGrammar -> State -> Err State
solveAll gr st = solve st >>= solve where 
  solve st0 = do ---- why need twice?
    st <- reCheckState gr st0
    let cs0     = allConstrs st
        (cs,ms) = splitConstraints gr cs0
    metaSubstRefinements gr ms $ 
      mapLoc (reduceConstraintsNode gr . performMetaSubstNode ms) st

-- active refinements

refinementsState :: CGrammar -> State -> [(Term,(Val,Bool))]
refinementsState gr state = 
  let filt = possibleRefVal gr state in 
  if actIsMeta state 
     then refsForType filt gr (allBinds state) (actVal state)
     else []

wrappingsState :: CGrammar -> State -> [((Fun,Int),Type)]
wrappingsState gr state
  | actIsMeta state = []
  | isRootState state = funs 
  | otherwise = [rule | rule@(_,typ) <- funs, possibleRefVal gr state aval typ]
 where 
   funs = funsOnType (possibleRefVal gr state) gr aval
   aval = actVal state

peelingsState :: CGrammar -> State -> [(Fun,Int)]
peelingsState gr state
  | actIsMeta state = []
  | isRootState state = 
      err (const []) (\f -> [(f,i) | i <- [0 .. arityTree tree - 1]]) $ actFun state
  | otherwise = 
      err (const []) 
          (\f -> [fi | (fi@(g,_),typ) <- funs, 
                       possibleRefVal gr state aval typ,g==f]) $ actFun state
 where 
   funs = funsOnType (possibleRefVal gr state) gr aval
   aval = actVal state
   tree = actTree state

headChangesState :: CGrammar -> State -> [Fun]
headChangesState gr state = errVal [] $ do 
  f@(m,c) <-  funAtom (actAtom state)
  typ0 <- lookupFunType gr m c
  return [fun | (fun,typ) <- funRulesOf gr, fun /= f, typ == typ0] 
                                                          --- alpha-conv !

possibleRefVal :: CGrammar -> State -> Val -> Type -> Bool
possibleRefVal gr state val typ = errVal True $ do --- was False
  vtyp <- valType typ
  let gen = actGen state
  cs   <- return [(val, vClos vtyp)] --- eqVal gen val (vClos vtyp) --- only poss cs
  return $ possibleConstraints gr cs --- a simple heuristic

possibleTreeVal :: CGrammar -> State -> Tree -> Bool
possibleTreeVal gr state tree = errVal True $ do --- was False
  let aval = actVal state
  let gval = valTree tree
  let gen = actGen state
  cs  <- return [(aval, gval)] --- eqVal gen val (vClos vtyp) --- only poss cs
  return $ possibleConstraints gr cs --- a simple heuristic

