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

module GF.Compile.Rename (
	       renameSourceTerm,
	       renameModule
	      ) where

import GF.Grammar.Grammar
import GF.Grammar.Values
import GF.Grammar.Predef
import GF.Infra.Modules
import GF.Infra.Ident
import GF.Infra.CheckM
import GF.Grammar.Macros
import GF.Grammar.Printer
import GF.Grammar.Lookup
import GF.Grammar.Printer
import GF.Data.Operations

import Control.Monad
import Data.List (nub)
import Text.PrettyPrint

-- | this gives top-level access to renaming term input in the cc command
renameSourceTerm :: SourceGrammar -> Ident -> Term -> Check Term
renameSourceTerm g m t = do
  mo     <- checkErr $ lookupModule g m
  status <- buildStatus g m mo
  renameTerm status [] t

renameModule :: [SourceModule] -> SourceModule -> Check SourceModule
renameModule ms (name,mo) = checkIn (text "renaming module" <+> ppIdent name) $ do
  let js1 = jments mo
  status <- buildStatus (MGrammar ms) name mo
  js2    <- checkMap (renameInfo status name) js1
  return (name, mo {opens = map forceQualif (opens mo), jments = js2})

type Status = (StatusTree, [(OpenSpec, StatusTree)])

type StatusTree = BinTree Ident StatusInfo

type StatusInfo = Ident -> Term

renameIdentTerm :: Status -> Term -> Check Term
renameIdentTerm env@(act,imps) t = 
 checkIn (text "atomic term" <+> ppTerm Qualified 0 t $$ text "given" <+> hsep (punctuate comma (map (ppIdent . fst) qualifs))) $
   case t of
  Vr c -> ident predefAbs c
  Cn c -> ident (\_ s -> checkError s) c
  Q m' c | m' == cPredef {- && isInPredefined c -} -> return t
  Q m' c -> do
    m <- checkErr (lookupErr m' qualifs)
    f <- lookupTree showIdent c m
    return $ f c
  QC m' c | m' == cPredef {- && isInPredefined c -} -> return t
  QC m' c -> do
    m <- checkErr (lookupErr m' qualifs)
    f <- lookupTree showIdent c m
    return $ f c
  _ -> return t
 where
   opens  = [st  | (OSimple _,st) <- imps]
   qualifs = [(m, st) | (OQualif m _, st) <- imps] ++ 
             [(m, st) | (OSimple m, st) <- imps] -- qualif is always possible

   -- this facility is mainly for BWC with GF1: you need not import PredefAbs
   predefAbs c s
     | isPredefCat c = return $ Q cPredefAbs c
     | otherwise     = checkError s

   ident alt c = case lookupTree showIdent c act of
      Ok f -> return $ f c
      _ -> case lookupTreeManyAll showIdent opens c of
        [f] -> return $ f c
        []  -> alt c (text "constant not found:" <+> ppIdent c)
        fs -> case nub [f c | f <- fs]  of
          [tr] -> return tr
          ts@(t:_) -> do checkWarn (text "conflict" <+> hsep (punctuate comma (map (ppTerm Qualified 0) ts)))
                         return t
            -- a warning will be generated in CheckGrammar, and the head returned
            -- in next V: 
            -- Bad $ "conflicting imports:" +++ unwords (map prt ts) 

info2status :: Maybe Ident -> (Ident,Info) -> StatusInfo
info2status mq (c,i) = case i of
  AbsFun _ _ Nothing -> maybe Con QC mq
  ResValue _  -> maybe Con QC mq
  ResParam _ _  -> maybe Con QC mq
  AnyInd True m -> maybe Con (const (QC m)) mq
  AnyInd False m -> maybe Cn (const (Q m)) mq
  _           -> maybe Cn  Q mq

tree2status :: OpenSpec -> BinTree Ident Info -> BinTree Ident StatusInfo
tree2status o = case o of
  OSimple i   -> mapTree (info2status (Just i))
  OQualif i j -> mapTree (info2status (Just j))

buildStatus :: SourceGrammar -> Ident -> SourceModInfo -> Check Status
buildStatus gr c mo = let mo' = self2status c mo in do
    let gr1 = MGrammar ((c,mo) : modules gr)
        ops = [OSimple e | e <- allExtends gr1 c] ++ opens mo
    mods <- checkErr $ mapM (lookupModule gr1 . openedModule) ops
    let sts = map modInfo2status $ zip ops mods    
    return $ if isModCnc mo
      then (emptyBinTree, reverse sts) -- the module itself does not define any names
      else (mo',reverse sts) -- so the empty ident is not needed

modInfo2status :: (OpenSpec,SourceModInfo) -> (OpenSpec, StatusTree)
modInfo2status (o,mo) = (o,tree2status o (jments mo))

self2status :: Ident -> SourceModInfo -> StatusTree
self2status c m = mapTree (info2status (Just c)) (jments m)

forceQualif o = case o of
  OSimple i   -> OQualif i i
  OQualif _ i -> OQualif i i
  
renameInfo :: Status -> Ident -> Ident -> Info -> Check Info
renameInfo status m i info =
  case info of
    AbsCat pco -> liftM AbsCat (renPerh (renameContext status) pco)
    AbsFun  pty pa ptr -> liftM3 AbsFun (renTerm pty) (return pa) (renMaybe (mapM (renLoc (renEquation status))) ptr)
    ResOper pty ptr -> liftM2 ResOper (renTerm pty) (renTerm ptr)
    ResOverload os tysts -> liftM (ResOverload os) (mapM (renPair (renameTerm status [])) tysts)
    ResParam (Just pp) m -> do
      pp' <- mapM (renLoc (renParam status)) pp
      return (ResParam (Just pp') m)
    ResValue t -> do
      t <- renLoc (renameTerm status []) t
      return (ResValue t)
    CncCat pty ptr ppr -> liftM3 CncCat (renTerm pty) (renTerm ptr) (renTerm ppr)
    CncFun mt  ptr ppr -> liftM2 (CncFun mt)          (renTerm ptr) (renTerm ppr)
    _ -> return info
  where
    renTerm = renPerh (renameTerm status [])

    renPerh ren = renMaybe (renLoc ren)

    renMaybe ren (Just x) = ren x >>= return . Just
    renMaybe ren Nothing  = return Nothing

    renLoc ren (L loc x) =
      checkIn (text "renaming of" <+> ppIdent i <+> ppPosition m loc) $ do
        x <- ren x
        return (L loc x)

    renPair ren (L locx x, L locy y) = do x <- ren x
                                          y <- ren y
                                          return (L locx x, L locy y)

    renEquation :: Status -> Equation -> Check Equation
    renEquation b (ps,t) = do
        (ps',vs) <- liftM unzip $ mapM (renamePattern b) ps
        t'       <- renameTerm b (concat vs) t
        return (ps',t')

    renParam :: Status -> Param -> Check Param
    renParam env (c,co) = do
      co' <- renameContext env co
      return (c,co')

renameTerm :: Status -> [Ident] -> Term -> Check Term
renameTerm env vars = ren vars where
  ren vs trm = case trm of
    Abs b x t    -> liftM  (Abs b x) (ren (x:vs) t)
    Prod bt x a b -> liftM2 (Prod bt x) (ren vs a) (ren (x:vs) b)
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

    P t@(Vr r) l                                               -- Here we have $r.l$ and this is ambiguous it could be either 
                                                               -- record projection from variable or constant $r$ or qualified expression with module $r$
      | elem r vs -> return trm                                -- try var proj first ..
      | otherwise -> checks [ renid (Q r (label2ident l))      -- .. and qualified expression second.
                            , renid t >>= \t -> return (P t l) -- try as a constant at the end
                            , checkError (text "unknown qualified constant" <+> ppTerm Unqualified 0 trm)
                            ]

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
renamePattern :: Status -> Patt -> Check (Patt,[Ident])
renamePattern env patt = case patt of

  PMacro c -> do
    c' <- renid $ Vr c
    case c' of
      Q p d -> renp $ PM p d
      _ -> checkError (text "unresolved pattern" <+> ppPatt Unqualified 0 patt)

  PC c ps -> do
    c' <- renid $ Cn c
    case c' of
      QC m c -> do psvss <- mapM renp ps
                   let (ps,vs) = unzip psvss
                   return (PP m c ps, concat vs)
      Q  _ _ -> checkError (text "data constructor expected but" <+> ppTerm Qualified 0 c' <+> text "is found instead")
      _      -> checkError (text "unresolved data constructor" <+> ppTerm Qualified 0 c')

  PP p c ps -> do
    (QC p' c') <- renid (QC p c)
    psvss <- mapM renp ps
    let (ps',vs) = unzip psvss
    return (PP p' c' ps', concat vs)

  PM p c -> do
    x <- renid (Q p c)
    (p',c') <- case x of
                 (Q p' c') -> return (p',c')
                 _         -> checkError (text "not a pattern macro" <+> ppPatt Qualified 0 patt)
    return (PM p' c', [])

  PV x -> checks [ renid (Vr x) >>= \t' -> case t' of
                                             QC m c -> return (PP m c [],[])
                                             _      -> checkError (text "not a constructor")
                 , return (patt, [x])
                 ]

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

renameContext :: Status -> Context -> Check Context
renameContext b = renc [] where
  renc vs cont = case cont of
    (bt,x,t) : xts 
      | isWildIdent x -> do
          t'   <- ren vs t
          xts' <- renc vs xts
          return $ (bt,x,t') : xts'
      | otherwise -> do
          t'   <- ren vs t
          let vs' = x:vs
          xts' <- renc vs' xts
          return $ (bt,x,t') : xts'
    _ -> return cont
  ren = renameTerm b
