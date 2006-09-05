----------------------------------------------------------------------
-- |
-- Module      : CanonToGFCC
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/06/17 14:15:17 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.15 $
--
-- a decompiler. AR 12/6/2003 -- 19/4/2004
-----------------------------------------------------------------------------

module GF.Canon.CanonToGFCC (prCanon2gfcc) where

import GF.Canon.AbsGFC
import qualified GF.Canon.GFC as GFC
import qualified GF.Canon.GFCC.AbsGFCC as C
import qualified GF.Canon.GFCC.PrintGFCC as Pr
import GF.Canon.GFC
import qualified GF.Grammar.Abstract as A
import qualified GF.Grammar.Macros as GM
import GF.Canon.MkGFC
import GF.Canon.CMacros
import qualified GF.Infra.Modules as M
import qualified GF.Infra.Option as O
import GF.UseGrammar.Linear (unoptimizeCanon)

import GF.Infra.Ident
import GF.Data.Operations

import Data.List
import qualified Data.Map as Map


prCanon2gfcc :: CanonGrammar -> String
prCanon2gfcc = Pr.printTree . canon2gfcc . canon2canon . unoptimizeCanon

-- this assumes a grammar translated by canon2canon

canon2gfcc :: CanonGrammar -> C.Grammar
canon2gfcc cgr@(M.MGrammar ((a,M.ModMod abm):cms)) = 
     C.Grm (C.Hdr (i2i a) cs) (C.Abs adefs) cncs where
  cs  = map (i2i . fst) cms
  adefs = [C.Fun f' (mkType ty) (C.Tr (C.AC f') []) | 
            (f,GFC.AbsFun ty _) <- tree2list (M.jments abm), let f' = i2i f]
  cncs  = [C.Cnc (i2i lang) (concr m) | (lang,M.ModMod m) <- cms]
  concr mo = optConcrete 
               [C.Lin (i2i f) (mkTerm tr) | 
                 (f,GFC.CncFun _ _ tr _) <- tree2list (M.jments mo)]

i2i :: Ident -> C.CId
i2i (IC c) = C.CId c

mkType :: A.Type -> C.Type
mkType t = case GM.catSkeleton t of
  Ok (cs,c) -> C.Typ (map (i2i . snd) cs) (i2i $ snd c)

mkTerm :: Term -> C.Term
mkTerm tr = case tr of
  Arg (A _ i) -> C.V i
  EInt i      -> C.C i
  R rs     -> C.R [mkTerm t | Ass _ t <- rs]
  P t l    -> C.P (mkTerm t) (C.C (mkLab l))
  T _ cs   -> C.R [mkTerm t | Cas _ t <- cs]
  V _ cs   -> C.R [mkTerm t | t <- cs]
  S t p    -> C.P (mkTerm t) (mkTerm p)
  C s t    -> C.S [mkTerm x | x <- [s,t]]
  FV ts    -> C.FV [mkTerm t | t <- ts]
  K (KS s) -> C.K (C.KS s)
  K (KP ss _) -> C.K (C.KP ss []) ---- TODO: prefix variants
  E -> C.S []
  Par _ _  -> C.C 123              ---- just for debugging
  _ -> C.S [C.K (C.KS (A.prt tr))] ---- just for debugging
 where
   mkLab (L (IC l)) = case l of
     '_':ds -> (read ds) :: Integer
     _ -> 789

-- translate tables and records to arrays, return just one module per language
canon2canon :: CanonGrammar -> CanonGrammar
canon2canon cgr = M.MGrammar $ reorder $ map c2c $ M.modules cgr where
  reorder cgr = 
    (abs, M.ModMod $ 
           M.Module M.MTAbstract M.MSComplete [] [] [] (sorted2tree adefs)):
      [(c, M.ModMod $ 
           M.Module (M.MTConcrete abs) M.MSComplete [] [] [] (sorted2tree js)) 
            | (c,js) <- cncs] 
  abs  = maybe (error "no abstract") id $ M.greatestAbstract cgr
  cns  = M.allConcretes cgr abs
  adefs = sortBy (\ (f,_) (g,_) -> compare f g) 
            [finfo | 
              (i,mo) <- mos, M.isModAbs mo, 
              finfo <- tree2list (M.jments mo)]
  cncs = sortBy (\ (x,_) (y,_) -> compare x y)
            [(lang, concr lang) | lang <- cns]
  mos = M.allModMod cgr
  concr la = sortBy (\ (f,_) (g,_) -> compare f g) 
            [finfo | 
              (i,mo) <- mos, M.isModCnc mo, ----- 
              finfo <- tree2list (M.jments mo)]

  c2c (c,m) = case m of
    M.ModMod mo@(M.Module (M.MTConcrete _) M.MSComplete _ _ _ js) ->
      (c, M.ModMod $ M.replaceJudgements mo $ mapTree (j2j c) js)
    _ -> (c,m)
  j2j c (f,j) = case j of
    GFC.CncFun x y tr z -> (f,GFC.CncFun x y (t2t c tr) z)
    _ -> (f,j)
  t2t = term2term cgr

term2term :: CanonGrammar -> Ident -> Term -> Term
term2term cgr c tr = case tr of
  Par (CIQ _ c) _ -> EInt 456 ----
  R rs     -> R [Ass (l2l l) (t2t t) | Ass l t <- rs] ----
  P t l    -> P (t2t t) (l2l l)
  T ty cs  -> V ty [t2t t | Cas _ t <- cs]
  S t p    -> S (t2t t) (t2t p)
  _ -> composSafeOp t2t tr
 where
   t2t = term2term cgr c
   l2l l = L (IC "_123") ----

optConcrete :: [C.CncDef] -> [C.CncDef]
optConcrete defs = subex [C.Lin f (optTerm t) | C.Lin f t <- defs]

-- analyse word form lists into prefix + suffixes
-- suffix sets can later be shared by subex elim
optTerm :: C.Term -> C.Term  
optTerm tr = case tr of
    C.R ts@(_:_) | all isK ts -> mkSuff $ optToks [s | C.K (C.KS s) <- ts]
    C.R ts  -> C.R $ map optTerm ts
    C.P t v -> C.P (optTerm t) v
    _ -> tr
 where
  optToks ss = prf : suffs where
    prf = pref (sort ss)
    suffs = map (drop (length prf)) ss
    pref ss = longestPref (head ss) (last ss)
    longestPref w u = if isPrefixOf w u then w else longestPref (init w) u
  isK t = case t of
    C.K (C.KS _) -> True
    _ -> False

  mkSuff (p:ws) = C.W p (C.R (map (C.K . C.KS) ws))



subex :: [C.CncDef] -> [C.CncDef]
subex js = errVal js $ do
  (tree,_) <- appSTM (getSubtermsMod js) (Map.empty,0)
  return $ addSubexpConsts tree js

-- implementation

type TermList = Map.Map C.Term (Int,Int) -- number of occs, id
type TermM a = STM (TermList,Int) a

addSubexpConsts :: TermList -> [C.CncDef] -> [C.CncDef]
addSubexpConsts tree lins =
  let opers = sortBy (\ (C.Lin f _) (C.Lin g _) -> compare f g)
                [C.Lin (fid id) trm | (trm,(_,id)) <- list]
  in map mkOne $ opers ++ lins
 where
   mkOne (C.Lin f trm) = (C.Lin f (recomp f trm))
   recomp f t = case Map.lookup t tree of
     Just (_,id) | fid id /= f -> C.F $ fid id -- not to replace oper itself
     _ -> case t of
       C.R ts  -> C.R $ map (recomp f) ts
       C.S ts  -> C.S $ map (recomp f) ts
       C.W s t -> C.W s (recomp f t)
       C.P t p -> C.P (recomp f t) (recomp f p)
       _ -> t
   fid n = C.CId $ "_" ++ show n
   list = Map.toList tree

getSubtermsMod :: [C.CncDef] -> TermM TermList
getSubtermsMod js = do
  mapM (getInfo collectSubterms) js
  (tree0,_) <- readSTM
  return $ Map.filter (\ (nu,_) -> nu > 1) tree0
 where
   getInfo get (C.Lin f trm) = do
     get trm
     return ()

collectSubterms :: C.Term -> TermM ()
collectSubterms t = case t of
  C.R ts -> do
    mapM collectSubterms ts
    add t
  C.S ts -> do
    mapM collectSubterms ts
    add t
  C.W s u -> do
    collectSubterms u
    add t
  _ -> return ()
 where
   add t = do
     (ts,i) <- readSTM
     let 
       ((count,id),next) = case Map.lookup t ts of
         Just (nu,id) -> ((nu+1,id), i)
         _ ->            ((1,   i ), i+1)
     writeSTM (Map.insert t (count,id) ts, next)








{-
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
     e'  <- return $ M.extend m
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
      cat'  <- redIdent cat
      return $ G.CncFun (Just (cat', ([],F.typeStr))) -- Nothing 
        (Yes (F.mkAbs xx' body')) (Yes ppr')

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
  Par cident terms  -> liftM2 F.mkApp 
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
    let (ps,ts) = unzip [(ps,t) | Cas ps t <- cases]
    ps' <- mapM (mapM redPatt) ps
    ts' <- mapM redCTerm ts
    let tinfo = case ps' of
                  [[G.PV _]] -> G.TTyped ctype'
                  _ -> G.TComp ctype'
    return $ G.TSh tinfo $ zip ps' ts'
  V ctype ts  -> do
    ctype' <- redCType ctype
    ts' <- mapM redCTerm ts
    return $ G.V ctype' ts'
  S term0 term  -> liftM2 G.S (redCTerm term0) (redCTerm term)
  C term0 term  -> liftM2 G.C (redCTerm term0) (redCTerm term)
  FV terms  -> liftM G.FV $ mapM redCTerm terms
  K (KS str) -> return $ G.K str
  EInt i     -> return $ G.EInt i
  EFloat i   -> return $ G.EFloat i
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
  PI i -> return $ G.PInt i
  PF i -> return $ G.PFloat i
  _ -> Bad $ "cannot recompile pattern" +++ show p

-}
