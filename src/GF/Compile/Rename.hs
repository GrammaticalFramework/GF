----------------------------------------------------------------------
-- |
-- Module      : (Module)
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date $ 
-- > CVS $Author $
-- > CVS $Revision $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module Rename where

import Grammar
import Values
import Modules
import Ident
import Macros
import PrGrammar
import AppPredefined
import Lookup
import Extend
import Operations

import Monad

-- AR 14/5/2003

-- The top-level function $renameGrammar$ does several things:
-- * extends each module symbol table by indirections to extended module
-- * changes unqualified and as-qualified imports to absolutely qualified
-- * goes through the definitions and resolves names
-- Dependency analysis between modules has been performed before this pass.
-- Hence we can proceed by $fold$ing 'from left to right'.

renameGrammar :: SourceGrammar -> Err SourceGrammar
renameGrammar g = liftM (MGrammar . reverse) $ foldM renameModule [] (modules g)

-- this gives top-level access to renaming term input in the cc command
renameSourceTerm :: SourceGrammar -> Ident -> Term -> Err Term
renameSourceTerm g m t = do
  mo     <- lookupErr m (modules g)
  status <- buildStatus g m mo
  renameTerm status [] t

renameModule :: [SourceModule] -> SourceModule -> Err [SourceModule]
renameModule ms (name,mod) = errIn ("renaming module" +++ prt name) $ case mod of
  ModMod m@(Module mt st fs me ops js) -> do
    let js1 = jments m
    status <- buildStatus (MGrammar ms) name mod
    js2    <- mapMTree (renameInfo status) js1
    let mod2 = ModMod $ Module mt st fs me (map forceQualif ops) js2
    return $ (name,mod2) : ms

type Status = (StatusTree, [(OpenSpec Ident, StatusTree)])

type StatusTree = BinTree (Ident,StatusInfo)

type StatusInfo = Ident -> Term

renameIdentTerm :: Status -> Term -> Err Term
renameIdentTerm env@(act,imps) t = 
 errIn ("atomic term" +++ prt t +++ "given" +++ unwords (map (prt . fst) qualifs)) $
   case t of
  Vr c -> do
    f <- err (predefAbs c) return $ lookupTreeMany prt opens c
    return $ f c
  Cn c -> do
    f <- lookupTreeMany prt opens c
    return $ f c
  Q m' c | m' == cPredef {- && isInPredefined c -} -> return t
  Q m' c -> do
    m <- lookupErr m' qualifs
    f <- lookupTree prt c m
    return $ f c
  QC m' c | m' == cPredef {- && isInPredefined c -} -> return t
  QC m' c -> do
    m <- lookupErr m' qualifs
    f <- lookupTree prt c m
    return $ f c
  _ -> return t
 where
   opens   = act : [st  | (OSimple _ _,st) <- imps]
   qualifs = [(m, st) | (OQualif _ m _, st) <- imps] ++ 
             [(m, st) | (OSimple _ m, st) <- imps] -- qualif is always possible

   -- this facility is mainly for BWC with GF1: you need not import PredefAbs
   predefAbs c s = case c of
     IC "Int" -> return $ const $ Q cPredefAbs cInt
     IC "String" -> return $ const $ Q cPredefAbs cString
     _ -> Bad s

--- would it make sense to optimize this by inlining?
renameIdentPatt :: Status -> Patt -> Err Patt
renameIdentPatt env p = do
  let t = patt2term p
  t' <- renameIdentTerm env t
  term2patt t'

info2status :: Maybe Ident -> (Ident,Info) -> (Ident,StatusInfo)
info2status mq (c,i) = (c, case i of
  AbsFun _ (Yes EData) -> maybe Con QC mq
  ResValue _  -> maybe Con QC mq
  ResParam _  -> maybe Con QC mq
  AnyInd True m -> maybe Con (const (QC m)) mq
  AnyInd False m -> maybe Cn (const (Q m)) mq
  _           -> maybe Cn  Q mq
  )

tree2status :: OpenSpec Ident -> BinTree (Ident,Info) -> BinTree (Ident,StatusInfo)
tree2status o = case o of
  OSimple _ i   -> mapTree (info2status (Just i))
  OQualif _ i j -> mapTree (info2status (Just j))

buildStatus :: SourceGrammar -> Ident -> SourceModInfo -> Err Status
buildStatus gr c mo = let mo' = self2status c mo in case mo of
  ModMod m -> do
    let gr1 = MGrammar $ (c,mo) : modules gr 
        ops = [OSimple OQNormal e | e <- allExtendsPlus gr1 c] ++ allOpens m
    mods <- mapM (lookupModule gr1 . openedModule) ops
    let sts = map modInfo2status $ zip ops mods    
    return $ if isModCnc m
      then (NT, reverse sts) -- the module itself does not define any names
      else (mo',reverse sts) -- so the empty ident is not needed

modInfo2status :: (OpenSpec Ident,SourceModInfo) -> (OpenSpec Ident, StatusTree)
modInfo2status (o,i) = (o,case i of
  ModMod m -> tree2status o (jments m)
  )

self2status :: Ident -> SourceModInfo -> StatusTree
self2status c i = mapTree (info2status (Just c)) js where   -- qualify internal
  js = case i of
    ModMod m 
      | isModTrans m -> sorted2tree $ filter noTrans $ tree2list $ jments m 
      | otherwise -> jments m
  noTrans (_,d) = case d of  -- to enable other than transfer js in transfer module 
    AbsTrans _ -> False
    _ -> True

forceQualif o = case o of
  OSimple q i   -> OQualif q i i
  OQualif q _ i -> OQualif q i i
  
renameInfo :: Status -> (Ident,Info) -> Err (Ident,Info)
renameInfo status (i,info) = errIn ("renaming definition of" +++ prt i) $ 
                                liftM ((,) i) $ case info of
  AbsCat pco pfs -> liftM2 AbsCat (renPerh (renameContext status) pco)
                                  (renPerh (mapM rent) pfs)
  AbsFun pty ptr -> liftM2 AbsFun (ren pty) (ren ptr)
  AbsTrans f -> liftM AbsTrans (rent f)

  ResOper pty ptr -> liftM2 ResOper (ren pty) (ren ptr)
  ResParam pp -> liftM ResParam (renPerh (mapM (renameParam status)) pp)
  ResValue t  -> liftM ResValue (ren t)
  CncCat pty ptr ppr -> liftM3 CncCat (ren pty) (ren ptr) (ren ppr)
  CncFun mt  ptr ppr -> liftM2 (CncFun mt)      (ren ptr) (ren ppr)
  _ -> return info
 where 
   ren = renPerh rent
   rent = renameTerm status []

renPerh ren pt = case pt of
  Yes t -> liftM Yes $ ren t
  _ -> return pt

renameTerm :: Status -> [Ident] -> Term -> Err Term
renameTerm env vars = ren vars where
  ren vs trm = case trm of
    Abs x b    -> liftM  (Abs x) (ren (x:vs) b)
    Prod x a b -> liftM2 (Prod x) (ren vs a) (ren (x:vs) b)
    Typed a b  -> liftM2 Typed (ren vs a) (ren vs b)
    Vr x      
      | elem x vs -> return trm
      | otherwise -> renid trm
    Cn _   -> renid trm
    Con _  -> renid trm
    Q _ _  -> renid trm
    QC _ _ -> renid trm
    Eqs eqs -> liftM Eqs $ mapM (renameEquation env vars) eqs
    T i cs -> do
      i' <- case i of
        TTyped ty -> liftM TTyped $ ren vs ty -- the only annotation in source
        _ -> return i
      liftM (T i') $ mapM (renCase vs) cs  

    Let (x,(m,a)) b -> do
      m' <- case m of
        Just ty -> liftM Just $ ren vs ty
        _ -> return m
      a' <- ren vs a
      b' <- ren (x:vs) b
      return $ Let (x,(m',a')) b'

    P t@(Vr r) l                     -- for constant t we know it is projection
      | elem r vs -> return trm                           -- var proj first
      | otherwise -> case renid (Q r (label2ident l)) of  -- qualif   second
          Ok t -> return t
          _ -> liftM (flip P l) $ renid t                 -- const proj last

    _ -> composOp (ren vs) trm

  renid = renameIdentTerm env
  renCase vs (p,t) = do
    (p',vs') <- renpatt p
    t' <- ren (vs' ++ vs) t
    return (p',t')
  renpatt = renamePattern env

-- vars not needed in env, since patterns always overshadow old vars

renamePattern :: Status -> Patt -> Err (Patt,[Ident])
renamePattern env patt = case patt of

  PC c ps -> do
    c' <- renameIdentTerm env $ Cn c
    psvss <- mapM renp ps
    let (ps',vs) = unzip psvss
    case c' of
      QC p d -> return (PP p d ps', concat vs)
      Q  p d -> return (PP p d ps', concat vs) ---- should not happen
      _ -> prtBad "unresolved pattern" c' ---- (PC c ps', concat vs)

----  PP p c ps -> (PP p c ps',concat vs') where (ps',vs') = unzip $ map renp ps

  PV x -> case renid patt of
    Ok p -> return (p,[])
    _    -> return (patt, [x])

  PR r -> do
    let (ls,ps) = unzip r
    psvss <- mapM renp ps
    let (ps',vs') = unzip psvss
    return (PR (zip ls ps'), concat vs') 

  _ -> return (patt,[])

 where 
   renp  = renamePattern env
   renid = renameIdentPatt env

renameParam :: Status -> (Ident, Context) -> Err (Ident, Context)
renameParam env (c,co) = do
  co' <- renameContext env co
  return (c,co')

renameContext :: Status -> Context -> Err Context
renameContext b = renc [] where
  renc vs cont = case cont of
    (x,t) : xts 
      | isWildIdent x -> do
          t'   <- ren vs t
          xts' <- renc vs xts
          return $ (x,t') : xts'
      | otherwise -> do
          t'   <- ren vs t
          let vs' = x:vs
          xts' <- renc vs' xts
          return $ (x,t') : xts'
    _ -> return cont
  ren = renameTerm b

-- vars not needed in env, since patterns always overshadow old vars

renameEquation :: Status -> [Ident] -> Equation -> Err Equation
renameEquation b vs (ps,t) = do
  (ps',vs') <- liftM unzip $ mapM (renamePattern b) ps
  t'        <- renameTerm b (concat vs' ++ vs) t
  return (ps',t')
