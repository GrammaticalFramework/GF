----------------------------------------------------------------------
-- |
-- Module      : Rename
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/30 18:39:44 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.19 $
--
-- AR 14\/5\/2003
-- The top-level function 'renameGrammar' does several things:
--
--   - extends each module symbol table by indirections to extended module
--
--   - changes unqualified and as-qualified imports to absolutely qualified
--
--   - goes through the definitions and resolves names
--
-- Dependency analysis between modules has been performed before this pass.
-- Hence we can proceed by @fold@ing "from left to right".
-----------------------------------------------------------------------------

module GF.Compile.Rename (renameGrammar,
	       renameSourceTerm,
	       renameModule
	      ) where

import GF.Grammar.Grammar
import GF.Grammar.Values
import GF.Grammar.Predef
import GF.Infra.Modules
import GF.Infra.Ident
import GF.Grammar.Macros
import GF.Grammar.PrGrammar
import GF.Grammar.AppPredefined
import GF.Grammar.Lookup
import GF.Grammar.Printer
import GF.Data.Operations

import Control.Monad
import Data.List (nub)
import Debug.Trace (trace)
import Text.PrettyPrint

renameGrammar :: SourceGrammar -> Err SourceGrammar
renameGrammar g = liftM (MGrammar . reverse) $ foldM renameModule [] (modules g)

-- | this gives top-level access to renaming term input in the cc command
renameSourceTerm :: SourceGrammar -> Ident -> Term -> Err Term
renameSourceTerm g m t = do
  mo     <- lookupModule g m
  status <- buildStatus g m mo
  renameTerm status [] t

renameModule :: [SourceModule] -> SourceModule -> Err [SourceModule]
renameModule ms (name,mo) = errIn ("renaming module" +++ prt name) $ do
  let js1 = jments mo
  status <- buildStatus (MGrammar ms) name mo
  js2    <- mapsErrTree (renameInfo mo status) js1
  return $ (name, mo {opens = map forceQualif (opens mo), jments = js2}) : ms

type Status = (StatusTree, [(OpenSpec Ident, StatusTree)])

type StatusTree = BinTree Ident StatusInfo

type StatusInfo = Ident -> Term

renameIdentTerm :: Status -> Term -> Err Term
renameIdentTerm env@(act,imps) t = 
 errIn ("atomic term" +++ prt t +++ "given" +++ unwords (map (prt . fst) qualifs)) $
   case t of
  Vr c -> ident predefAbs c
  Cn c -> ident (\_ s -> Bad s) c
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
   opens  = [st  | (OSimple _,st) <- imps]
   qualifs = [(m, st) | (OQualif m _, st) <- imps] ++ 
             [(m, st) | (OSimple m, st) <- imps] -- qualif is always possible

   -- this facility is mainly for BWC with GF1: you need not import PredefAbs
   predefAbs c s
     | isPredefCat c = return $ Q cPredefAbs c
     | otherwise     = Bad s

   ident alt c = case lookupTree prt c act of
      Ok f -> return $ f c
      _ -> case lookupTreeManyAll prt opens c of
        [f] -> return $ f c
        []  -> alt c ("constant not found:" +++ prt c) 
        fs -> case nub [f c | f <- fs]  of
          [tr] -> return tr
          ts@(t:_) -> trace ("WARNING: conflict" +++ unwords (map prt ts)) (return t)
            -- a warning will be generated in CheckGrammar, and the head returned
            -- in next V: 
            -- Bad $ "conflicting imports:" +++ unwords (map prt ts) 


--- | would it make sense to optimize this by inlining?
renameIdentPatt :: Status -> Patt -> Err Patt
renameIdentPatt env p = do
  let t = patt2term p
  t' <- renameIdentTerm env t
  term2patt t'

info2status :: Maybe Ident -> (Ident,Info) -> StatusInfo
info2status mq (c,i) = case i of
  AbsFun _ Nothing -> maybe Con QC mq
  ResValue _  -> maybe Con QC mq
  ResParam _  -> maybe Con QC mq
  AnyInd True m -> maybe Con (const (QC m)) mq
  AnyInd False m -> maybe Cn (const (Q m)) mq
  _           -> maybe Cn  Q mq

tree2status :: OpenSpec Ident -> BinTree Ident Info -> BinTree Ident StatusInfo
tree2status o = case o of
  OSimple i   -> mapTree (info2status (Just i))
  OQualif i j -> mapTree (info2status (Just j))

buildStatus :: SourceGrammar -> Ident -> SourceModInfo -> Err Status
buildStatus gr c mo = let mo' = self2status c mo in do
    let gr1 = MGrammar ((c,mo) : modules gr)
        ops = [OSimple e | e <- allExtends gr1 c] ++ allOpens mo
    mods <- mapM (lookupModule gr1 . openedModule) ops
    let sts = map modInfo2status $ zip ops mods    
    return $ if isModCnc mo
      then (emptyBinTree, reverse sts) -- the module itself does not define any names
      else (mo',reverse sts) -- so the empty ident is not needed

modInfo2status :: (OpenSpec Ident,SourceModInfo) -> (OpenSpec Ident, StatusTree)
modInfo2status (o,mo) = (o,tree2status o (jments mo))

self2status :: Ident -> SourceModInfo -> StatusTree
self2status c m = mapTree (info2status (Just c)) js where   -- qualify internal
  js | isModTrans m = sorted2tree $ tree2list $ jments m 
     | otherwise    = jments m

forceQualif o = case o of
  OSimple i   -> OQualif i i
  OQualif _ i -> OQualif i i
  
renameInfo :: SourceModInfo -> Status -> (Ident,Info) -> Err (Ident,Info)
renameInfo mo status (i,info) = errIn 
    ("renaming definition of" +++ prt i +++ showPosition mo i) $ 
                                liftM ((,) i) $ case info of
  AbsCat pco pfs -> liftM2 AbsCat (renPerh (renameContext status) pco)
                                  (renPerh (mapM rent) pfs)
  AbsFun  pty ptr -> liftM2 AbsFun (ren pty) (renPerh (mapM (renameEquation status [])) ptr)
  ResOper pty ptr -> liftM2 ResOper (ren pty) (ren ptr)
  ResOverload os tysts -> 
    liftM (ResOverload os) (mapM (pairM rent) tysts)

  ResParam (Just (pp,m)) -> do
    pp' <- mapM (renameParam status) pp
    return $ ResParam $ Just (pp',m)
  ResValue (Just (t,m)) -> do
    t' <- rent t
    return $ ResValue $ Just (t',m)
  CncCat pty ptr ppr -> liftM3 CncCat (ren pty) (ren ptr) (ren ppr)
  CncFun mt  ptr ppr -> liftM2 (CncFun mt)      (ren ptr) (ren ppr)
  _ -> return info
 where 
   ren = renPerh rent
   rent = renameTerm status []

renPerh ren (Just t) = liftM Just $ ren t
renPerh ren Nothing  = return Nothing

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
          _ -> case liftM (flip P l) $ renid t of
            Ok t -> return t                              -- const proj last
            _ -> prtBad "unknown qualified constant" trm

    EPatt p -> do
      (p',_) <- renpatt p
      return $ EPatt p'

    _ -> composOp (ren vs) trm

  renid = renameIdentTerm env
  renCase vs (p,t) = do
    (p',vs') <- renpatt p
    t' <- ren (vs' ++ vs) t
    return (p',t')
  renpatt = renamePattern env

-- | vars not needed in env, since patterns always overshadow old vars
renamePattern :: Status -> Patt -> Err (Patt,[Ident])
renamePattern env patt = case patt of

  PMacro c -> do
    c' <- renid $ Vr c
    case c' of
      Q p d -> renp $ PM p d
      _ -> prtBad "unresolved pattern" patt

  PC c ps -> do
    c' <- renid $ Cn c
    case c' of
      QC m c -> renp $ PP m c ps
      Q  _ _ -> Bad $ render (text "data constructor expected but" <+> ppTerm Qualified 0 c' <+> text "is found instead")
      _      -> Bad $ render (text "unresolved data constructor" <+> ppTerm Qualified 0 c')

  PP p c ps -> do

    (p', c') <- case renid (QC p c) of
      Ok (QC p' c') -> return (p',c')
      _ -> return (p,c) --- temporarily, for bw compat
    psvss <- mapM renp ps
    let (ps',vs) = unzip psvss
    return (PP p' c' ps', concat vs)

  PM p c -> do
    (p', c') <- case renid (Q p c) of
      Ok (Q p' c') -> return (p',c')
      _ -> prtBad "not a pattern macro" patt
    return (PM p' c', [])

  PV x -> do case renid (Vr x) of
               Ok (QC m c) -> return (PP m c [],[])
               Ok (Q  m c) -> Bad $ render (text "data constructor expected but" <+> ppTerm Qualified 0 (Q  m c) <+> text "is found instead")
               _           -> return (patt, [x])

  PR r -> do
    let (ls,ps) = unzip r
    psvss <- mapM renp ps
    let (ps',vs') = unzip psvss
    return (PR (zip ls ps'), concat vs') 

  PAlt p q -> do
    (p',vs) <- renp p
    (q',ws) <- renp q
    return (PAlt p' q', vs ++ ws)

  PSeq p q -> do
    (p',vs) <- renp p
    (q',ws) <- renp q
    return (PSeq p' q', vs ++ ws)

  PRep p -> do
    (p',vs) <- renp p
    return (PRep p', vs)

  PNeg p -> do
    (p',vs) <- renp p
    return (PNeg p', vs)

  PAs x p -> do
    (p',vs) <- renp p
    return (PAs x p', x:vs)

  _ -> return (patt,[])

 where 
   renp  = renamePattern env
   renid = renameIdentTerm env

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

-- | vars not needed in env, since patterns always overshadow old vars
renameEquation :: Status -> [Ident] -> Equation -> Err Equation
renameEquation b vs (ps,t) = do
  (ps',vs') <- liftM unzip $ mapM (renamePattern b) ps
  t'        <- renameTerm b (concat vs' ++ vs) t
  return (ps',t')
