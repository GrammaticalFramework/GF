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
import qualified GF.Canon.Look as Look
import qualified GF.Canon.GFCC.AbsGFCC as C
import qualified GF.Canon.GFCC.PrintGFCC as Pr
import GF.Canon.GFC
import GF.Canon.Share
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
import Debug.Trace ----

-- the main function: generate GFCC from GFCM.

prCanon2gfcc :: CanonGrammar -> String
prCanon2gfcc = 
  Pr.printTree . canon2gfcc . reorder . canon2canon . normalize

-- This is needed to reorganize the grammar. GFCC has its own back-end optimization.
-- But we need to have the canonical order in tables, created by valOpt
normalize :: CanonGrammar -> CanonGrammar
normalize = share . unoptimizeCanon where
  share = M.MGrammar . map (shareModule allOpt) . M.modules --- valOpt

-- Generate GFCC from GFCM.
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
  T _ [Cas [PV (IC x)] t] -> C.A (C.CId x) (mkTerm t) -- abstraction
  T _ cs   -> C.R [mkTerm t | Cas _ t <- cs] --- should not appear after values opt
  V _ cs   -> C.R [mkTerm t | t <- cs]
  S t p    -> C.P (mkTerm t) (mkTerm p)
  C s t    -> C.S [mkTerm x | x <- [s,t]]
  LI(IC x) -> C.L (C.CId x)
  FV ts    -> C.FV [mkTerm t | t <- ts]
  K (KS s) -> C.K (C.KS s)
  K (KP ss _) -> C.K (C.KP ss []) ---- TODO: prefix variants
  E -> C.S []
  Par _ _  -> prtTrace tr $ C.C 66661            ---- just for debugging
  _ -> C.S [C.K (C.KS (A.prt tr +++ "66662"))] ---- just for debugging
 where
   mkLab (L (IC l)) = case l of
     '_':ds -> (read ds) :: Integer
     _ -> prtTrace tr $ 66663

-- return just one module per language

reorder :: CanonGrammar -> CanonGrammar
reorder cg = M.MGrammar $ 
    (abs, M.ModMod $ 
          M.Module M.MTAbstract M.MSComplete [] [] [] adefs):
      [(c, M.ModMod $ 
          M.Module (M.MTConcrete abs) M.MSComplete [] [] [] (sorted2tree js)) 
            | (c,js) <- cncs] 
     where
       abs = maybe (error "no abstract") id $ M.greatestAbstract cg
       mos = M.allModMod cg
       adefs = 
         sorted2tree $ sortBy (\ (f,_) (g,_) -> compare f g) 
            [finfo | 
              (i,mo) <- M.allModMod cg, M.isModAbs mo, 
              finfo <- tree2list (M.jments mo)]
       cncs = sortBy (\ (x,_) (y,_) -> compare x y)
            [(lang, concr lang) | lang <- M.allConcretes cg abs]
       concr la = sortBy (\ (f,_) (g,_) -> compare f g) 
            [finfo | 
              (i,mo) <- mos, M.isModCnc mo, ----- TODO: separate langs 
              finfo <- tree2list (M.jments mo)]

-- translate tables and records to arrays, parameters and labels to indices

canon2canon :: CanonGrammar -> CanonGrammar
canon2canon cg = tr $ M.MGrammar $ map c2c $ M.modules cg where
  c2c (c,m) = case m of
    M.ModMod mo@(M.Module _ _ _ _ _ js) ->
      (c, M.ModMod $ M.replaceJudgements mo $ mapTree j2j js)
    _ -> (c,m)
  j2j (f,j) = case j of
    GFC.CncFun x y tr z -> (f,GFC.CncFun x y (t2t tr) z)
    _ -> (f,j)
  t2t = term2term cg pv
  pv@(labels,_,_) = paramValues cg
  tr = trace 
   (unlines [A.prt c ++ "." ++ unwords (map A.prt l) +++ "=" +++ show i  | 
       ((c,l),i) <- Map.toList labels])

type ParamEnv =
  (Map.Map (Ident,[Label]) Integer,      -- numbered labels
   Map.Map Term Integer,                 -- untyped terms to values
   Map.Map CType (Map.Map Term Integer)) -- types to their terms to values

--- gathers those param types that are actually used in lincats
paramValues :: CanonGrammar -> ParamEnv
paramValues cgr = (labels,untyps,typs) where
  params = [(ty, errVal [] $ Look.allParamValues cgr ty) | ty <- partyps]
  partyps = nub $ [ty | 
              (_,(_,CncCat (RecType ls) _ _)) <- jments,
              ty <- [ty | Lbg _ ty <- ls]
            ] ++ [
             Cn (CIQ m ty) | 
              (m,(ty,ResPar _)) <- jments
            ]
  jments = [(m,j) | (m,mo) <- M.allModMod cgr, j <- tree2list $ M.jments mo]
  typs = Map.fromList [(ci,Map.fromList (zip vs [0..])) | (ci,vs) <- params]
  untyps = Map.fromList $ concatMap Map.toList [typ | (_,typ) <- Map.toList typs]
  lincats = [(cat,ls) | (_,(cat,CncCat (RecType ls) _ _)) <- jments]
  labels = Map.fromList $ concat 
    [((cat,[lab]),i): 
      [((cat,[lab,lab2]),j) | 
        rs <- getRec typ, (Lbg lab2 _,j) <- zip rs [0..]] 
      | 
        (cat,ls) <- lincats, (Lbg lab typ,i) <- zip ls [0..]]
    -- go to tables recursively
    ---- TODO: even go to deeper records
   where
     getRec typ = case typ of
       RecType rs -> [rs]
       Table _ t  -> getRec t
       _ -> []

term2term :: CanonGrammar -> ParamEnv -> Term -> Term
term2term cgr env@(labels,untyps,typs) tr = case tr of
  Par c ps | any isVar ps -> mkCase c ps
  Par _ _  -> valNum tr
  R rs | any (isStr . trmAss) rs -> 
    R [Ass (mkLab i) (t2t t) | (i,Ass l t) <- zip [0..] rs, not (isLock l t)]
  R rs     -> valNum tr
  P t l    -> r2r tr
  T i [Cas p t] -> T i [Cas p (t2t t)]
  T ty cs  -> V ty [t2t t | Cas _ t <- cs]
  S t p    -> S (t2t t) (t2t p)
  _ -> composSafeOp t2t tr
 where
   t2t = term2term cgr env
   -- Conj@0.s
   r2r tr = case tr of
     P x@(Arg (A cat i)) lab ->
        P x . mkLab $ maybe (prtTrace tr $ 66664) id $ 
          Map.lookup (cat,[lab]) labels
     P p lab2 -> case getLab p of
       Just (cat,lab1) -> P (r2r p) . mkLab $ maybe (prtTrace tr $ 66664) id $ 
          Map.lookup (cat,[lab1,lab2]) labels
       _ -> P (t2t p) $ mkLab (prtTrace tr 66665)
     _ -> tr ----
     -- this goes recursively in tables
     ---- TODO: also recursive in records to get longer lists of labels
   getLab tr = case tr of
     P (Arg (A cat i)) lab1 -> return (cat,lab1)
     S p _ -> getLab p
     _ -> Nothing
   mkLab k = L (IC ("_" ++ show k))
   valNum tr = maybe (K (KS (A.prt tr +++ prtTrace tr "66667"))) EInt $ 
     Map.lookup tr untyps
   isStr tr = case tr of
     Par _ _ -> False
     EInt _  -> False
     R rs    -> any (isStr . trmAss) rs
     FV ts   -> any isStr ts
     P t r   -> True      ---- TODO
     _ -> True
   isLock l t = case t of --- need not look at l
     R [] -> True
     _ -> False
   trmAss (Ass _ t) = t
   isVar p = case p of
     Arg _ -> True
     P q _ -> isVar q
     _ -> False
   mkCase c ps = EInt (prtTrace tr 66668) ---- TODO: expand param constr with var
     
prtTrace tr n = n ----trace ("-- ERROR" +++ A.prt tr +++ show n +++ show tr) n
prTrace  tr n = trace ("-- OBSERVE" +++ A.prt tr +++ show n +++ show tr) n

-- back-end optimization: 
-- suffix analysis followed by common subexpression elimination

optConcrete :: [C.CncDef] -> [C.CncDef]
optConcrete defs = subex [C.Lin f (optTerm t) | C.Lin f t <- defs]

-- analyse word form lists into prefix + suffixes
-- suffix sets can later be shared by subex elim

optTerm :: C.Term -> C.Term  
optTerm tr = case tr of
    C.R ts@(_:_:_) | all isK ts -> mkSuff $ optToks [s | C.K (C.KS s) <- ts]
    C.R ts  -> C.R $ map optTerm ts
    C.P t v -> C.P (optTerm t) v
    C.A x t -> C.A x (optTerm t)
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
  mkSuff ("":ws) = C.R (map (C.K . C.KS) ws)
  mkSuff (p:ws) = C.W p (C.R (map (C.K . C.KS) ws))


-- common subexpression elimination; see ./Subexpression.hs for the idea

subex :: [C.CncDef] -> [C.CncDef]
subex js = errVal js $ do
  (tree,_) <- appSTM (getSubtermsMod js) (Map.empty,0)
  return $ addSubexpConsts tree js

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
       C.A x t -> C.A x (recomp f t)
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
  C.A x b -> do
    collectSubterms b -- t itself can only occur once in a grammar
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

