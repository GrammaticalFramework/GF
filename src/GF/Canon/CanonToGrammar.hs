module CanonToGrammar where

import AbsGFC
import GFC
import MkGFC
---import CMacros
import qualified Modules as M
import qualified Option  as O
import qualified Grammar as G
import qualified Macros  as F

import Ident
import Operations

import Monad

-- a decompiler. AR 12/6/2003 -- 19/4/2004

canon2sourceGrammar :: CanonGrammar -> Err G.SourceGrammar
canon2sourceGrammar gr = do
  ms' <- mapM canon2sourceModule $ M.modules gr
  return $ M.MGrammar ms'

canon2sourceModule :: CanonModule -> Err G.SourceModule
canon2sourceModule (i,mi) = do
  i'    <- redIdent i 
  info' <- case mi of
    M.ModMod m -> do
      (e,os) <- redExtOpen m
      flags  <- mapM redFlag $ M.flags m 
      (abstr,mt)  <- case M.mtype m of
          M.MTConcrete a -> do
            a' <- redIdent a
            return (a', M.MTConcrete a') 
          M.MTAbstract -> return (i',M.MTAbstract) --- c' not needed
          M.MTResource -> return (i',M.MTResource) --- c' not needed
          M.MTTransfer x y -> return (i',M.MTTransfer x y) --- c' not needed
      defs   <- mapMTree redInfo $ M.jments m
      return $ M.ModMod $ M.Module mt (M.mstatus m) flags e os defs
    _ -> Bad $ "cannot decompile module type"
  return (i',info')
 where
   redExtOpen m = do
     e' <- mapM redIdent $ M.extends m
     os' <- mapM (\ (M.OSimple q i) -> liftM (\i -> M.OQualif q i i) (redIdent i)) $ 
                 M.opens m
     return (e',os')

redInfo :: (Ident,Info) -> Err (Ident,G.Info)
redInfo (c,info) = errIn ("decompiling abstract" +++ show c) $ do
  c' <- redIdent c 
  info' <- case info of
    AbsCat cont fs -> do
      return $ G.AbsCat (Yes cont) (Yes (map (uncurry G.Q) fs))
    AbsFun typ df -> do
      return $ G.AbsFun (Yes typ) (Yes df)
    AbsTrans t -> do
      return $ G.AbsTrans t

    ResPar par -> liftM (G.ResParam . Yes) $ mapM redParam par

    CncCat pty ptr ppr -> do
      ty'  <- redCType pty
      trm' <- redCTerm ptr
      ppr' <- redCTerm ppr 
      return $ G.CncCat (Yes ty') (Yes trm') (Yes ppr')      
    CncFun (CIQ abstr cat) xx body ppr -> do
      xx'   <- mapM redArgVar xx
      body' <- redCTerm body
      ppr'  <- redCTerm ppr
      return $ G.CncFun Nothing (Yes (F.mkAbs xx' body')) (Yes ppr')

    AnyInd b c -> liftM (G.AnyInd b) $ redIdent c

  return (c',info')

redQIdent :: CIdent -> Err G.QIdent
redQIdent (CIQ m c) = liftM2 (,) (redIdent m) (redIdent c)

redIdent :: Ident -> Err Ident
redIdent = return

redFlag :: Flag -> Err O.Option
redFlag (Flg f x) = return $ O.Opt (prIdent f,[prIdent x])

redDecl :: Decl -> Err G.Decl
redDecl (Decl x a) = liftM2 (,) (redIdent x) (redTerm a)

redType :: Exp -> Err G.Type
redType = redTerm

redTerm :: Exp -> Err G.Term
redTerm t = return $ trExp t

-- resource

redParam (ParD c cont) = do
  c'    <- redIdent c
  cont' <- mapM redCType cont
  return $ (c', [(IW,t) | t <- cont'])

-- concrete syntax

redCType :: CType -> Err G.Type
redCType t = case t of
  RecType lbs -> do
    let (ls,ts) = unzip [(l,t) | Lbg l t <- lbs]
        ls' = map redLabel ls
    ts' <- mapM redCType ts
    return $ G.RecType $ zip ls' ts'
  Table p v  -> liftM2 G.Table (redCType p) (redCType v)
  Cn mc  -> liftM (uncurry G.QC) $ redQIdent mc
  TStr -> return $ F.typeStr
  TInts i -> return $ F.typeInts (fromInteger i)

redCTerm :: Term -> Err G.Term
redCTerm x = case x of
  Arg argvar  -> liftM G.Vr $ redArgVar argvar
  I cident  -> liftM (uncurry G.Q) $ redQIdent cident
  Con cident terms  -> liftM2 F.mkApp 
                         (liftM (uncurry G.QC) $ redQIdent cident) 
                         (mapM redCTerm terms)
  LI id  -> liftM G.Vr $ redIdent id
  R assigns  -> do
    let (ls,ts) = unzip [(l,t) | Ass l t <- assigns]
    let ls' = map redLabel ls
    ts' <- mapM redCTerm ts
    return $ G.R [(l,(Nothing,t)) | (l,t) <- zip ls' ts']
  P term label  -> liftM2 G.P (redCTerm term) (return $ redLabel label)
  T ctype cases  -> do
    ctype' <- redCType ctype
    let (ps,ts) = unzip [(p,t) | Cas ps t <- cases, p <- ps] --- destroys sharing
    ps' <- mapM redPatt ps
    ts' <- mapM redCTerm ts                   --- duplicates work for shared rhss
    let tinfo = case ps' of
                  [G.PV _] -> G.TTyped ctype'
                  _ -> G.TComp ctype'
    return $ G.T tinfo $ zip ps' ts'
  V ctype ts  -> do
    ctype' <- redCType ctype
    ts' <- mapM redCTerm ts
    return $ G.V ctype' ts'
  S term0 term  -> liftM2 G.S (redCTerm term0) (redCTerm term)
  C term0 term  -> liftM2 G.C (redCTerm term0) (redCTerm term)
  FV terms  -> liftM G.FV $ mapM redCTerm terms
  K (KS str) -> return $ G.K str
  EInt i     -> return $ G.EInt $ fromInteger i
  E  -> return $ G.Empty
  K (KP d vs)  -> return $ 
                    G.Alts (tList d,[(tList s, G.Strs $ map G.K v) | Var s v <- vs])
 where
   tList ss = case ss of --- this should be in Macros
     [] -> G.Empty
     _ -> foldr1 G.C $ map G.K ss

failure x = Bad $ "not yet" +++ show x ----

redArgVar :: ArgVar -> Err Ident
redArgVar x = case x of
  A x i -> return $ IA (prIdent x, fromInteger i)
  AB x b i -> return $ IAV (prIdent x, fromInteger b, fromInteger i)

redLabel :: Label -> G.Label
redLabel (L x) = G.LIdent $ prIdent x
redLabel (LV i) = G.LVar $ fromInteger i

redPatt :: Patt -> Err G.Patt
redPatt p = case p of
  PV x -> liftM G.PV $ redIdent x
  PC mc ps -> do
    (m,c) <- redQIdent mc
    liftM (G.PP m c) (mapM redPatt ps) 
  PR rs -> do
    let (ls,ts) = unzip [(l,t) | PAss l t <- rs]
        ls' = map redLabel ls
    ts <- mapM redPatt ts
    return $ G.PR $ zip ls' ts
  PI i -> return $ G.PInt (fromInteger i)
  _ -> Bad $ "cannot recompile pattern" +++ show p

