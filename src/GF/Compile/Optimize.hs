module Optimize where

import Grammar
import Ident
import Modules
import PrGrammar
import Macros
import Lookup
import Refresh
import Compute
import CheckGrammar
import Update

import Operations
import CheckM

import Monad
import List

-- partial evaluation of concrete syntax. AR 6/2001 -- 16/5/2003
{-
evalGrammar :: SourceGrammar -> Err SourceGrammar
evalGrammar gr = do
  gr2 <- refreshGrammar gr
  mos <- foldM evalModule [] $ modules gr2
  return $ MGrammar $ reverse mos 
-}
evalModule :: [(Ident,SourceModInfo)] -> (Ident,SourceModInfo) -> 
               Err [(Ident,SourceModInfo)]
evalModule ms mo@(name,mod) = case mod of

  ModMod m0@(Module mt st fs me ops js) | st == MSComplete -> case mt of
    _ | isModRes m0 -> do
      let deps = allOperDependencies name js
      ids <- topoSortOpers deps
      MGrammar (mod' : _) <- foldM evalOp gr ids
      return $ mod' : ms
    MTConcrete a -> do
      js' <- mapMTree (evalCncInfo gr0 name a) js
      return $ (name, ModMod (Module mt st fs me ops js')) : ms

    _ -> return $ (name,mod):ms
  _ -> return $ (name,mod):ms
 where
   gr0 = MGrammar $ ms
   gr  = MGrammar $ (name,mod) : ms

   evalOp g@(MGrammar ((_, ModMod m) : _)) i = do
     info  <- lookupTree prt i $ jments m
     info' <- evalResInfo gr (i,info)
     return $ updateRes g name i info'

-- only operations need be compiled in a resource, and this is local to each
-- definition since the module is traversed in topological order

evalResInfo :: SourceGrammar -> (Ident,Info) -> Err Info
evalResInfo gr (c,info) = case info of

  ResOper pty pde -> eIn "operation" $ do
    pde' <- case pde of
       Yes de -> liftM yes $ comp de
       _ -> return pde
    return $ ResOper pty pde'

  _ ->  return info
 where
   comp = computeConcrete gr
   eIn cat = errIn ("Error optimizing" +++ cat +++ prt c +++ ":")


evalCncInfo :: 
  SourceGrammar -> Ident -> Ident -> (Ident,Info) -> Err (Ident,Info)
evalCncInfo gr cnc abs (c,info) = case info of

  CncCat ptyp pde ppr -> do

    pde' <- case (ptyp,pde) of
      (Yes typ, Yes de) -> 
        liftM yes $ pEval ([(strVar, typeStr)], typ) de
      (Yes typ, Nope)   -> 
        liftM yes $ mkLinDefault gr typ >>= pEval ([(strVar, typeStr)],typ)
      (May b, Nope) ->
        return $ May b
      _ -> return pde   -- indirection

    ppr' <- liftM yes $ evalPrintname gr c ppr (yes $ K $ prt c)

    return (c, CncCat ptyp pde' ppr')

  CncFun (mt@(Just (_,ty))) pde ppr -> eIn ("linearization in type" +++  
                                             show ty +++ "of") $ do
    pde' <- case pde of
      Yes de -> do
        liftM yes $ pEval ty de
      _ -> return pde
    ppr' <-  liftM yes $ evalPrintname gr c ppr pde'
    return $ (c, CncFun mt pde' ppr') -- only cat in type actually needed

  _ ->  return (c,info)
 where
   comp = computeConcrete gr
   pEval = partEval gr
   eIn cat = errIn ("Error optimizing" +++ cat +++ prt c +++ ":")

-- the main function for compiling linearizations

partEval :: SourceGrammar -> (Context,Type) -> Term -> Err Term
partEval gr (context, val) trm = do
  let vars  = map fst context
      args  = map Vr vars
      subst = [(v, Vr v) | v <- vars]
      trm1  = mkApp trm args
  trm2 <- etaExpand val trm1 
  trm3 <- comp subst trm2
  return $ mkAbs vars trm3

 where 

   comp g t = {- refreshTerm t >>= -} computeTerm gr g t

   etaExpand val t = recordExpand val t   --- >>= caseEx  -- done by comp

-- here we must be careful not to reduce
--   variants {{s = "Auto" ; g = N} ; {s = "Wagen" ; g = M}}
--   {s  = variants {"Auto" ; "Wagen"} ; g  = variants {N ; M}} ;

recordExpand :: Type -> Term -> Err Term
recordExpand typ trm = case unComputed typ of
  RecType tys -> case trm of
    FV rs -> return $ FV [R [assign lab (P r lab) | (lab,_) <- tys] | r <- rs]
    _ -> return $ R [assign lab (P trm lab) | (lab,_) <- tys]
  _ -> return trm


-- auxiliaries for compiling the resource

allOperDependencies :: Ident -> BinTree (Ident,Info) -> [(Ident,[Ident])]
allOperDependencies m b = 
  [(f, nub (opty pty ++ opty pt)) | (f, ResOper pty pt) <- tree2list b]
  where
    opersIn t = case t of
      Q n c | n == m -> [c]
      _ -> collectOp opersIn t
    opty (Yes ty) = opersIn ty
    opty _ = []

topoSortOpers :: [(Ident,[Ident])] -> Err [Ident]
topoSortOpers st = do
  let eops = topoTest st
  either return (\ops -> Bad ("circular operations" +++ unwords (map prt (head ops)))) eops

mkLinDefault :: SourceGrammar -> Type -> Err Term
mkLinDefault gr typ = do
  case unComputed typ of
    RecType lts -> mapPairsM mkDefField lts >>= (return . Abs strVar . R . mkAssign)
    _ -> prtBad "linearization type must be a record type, not" typ
 where
   mkDefField typ = case unComputed typ of
     Table p t  -> do
       t' <- mkDefField t
       let T _ cs = mkWildCases t'
       return $ T (TWild p) cs 
     Sort "Str" -> return $ Vr strVar
     QC q p     -> lookupFirstTag gr q p
     RecType r  -> do
       let (ls,ts) = unzip r
       ts' <- mapM mkDefField ts
       return $ R $ [assign l t | (l,t) <- zip ls ts']
     _ | isTypeInts typ -> return $ EInt 0 -- exists in all as first val
     _ -> prtBad "linearization type field cannot be" typ

-- Form the printname: if given, compute. If not, use the computed
-- lin for functions, cat name for cats (dispatch made in evalCncDef above).
--- We cannot use linearization at this stage, since we do not know the
--- defaults we would need for question marks - and we're not yet in canon.

evalPrintname :: SourceGrammar -> Ident -> MPr -> Perh Term -> Err Term
evalPrintname gr c ppr lin =
  case ppr of
    Yes pr -> comp pr
    _ -> case lin of
      Yes t -> return $ K $ clean $ prt $ oneBranch t ---- stringFromTerm
      _ -> return $ K $ prt c ----
 where
   comp = computeConcrete gr

   oneBranch t = case t of
     Abs _ b   -> oneBranch b
     R   (r:_) -> oneBranch $ snd $ snd r
     T _ (c:_) -> oneBranch $ snd c
     FV  (t:_) -> oneBranch t
     C x y     -> C (oneBranch x) (oneBranch y)
     S x _     -> oneBranch x
     P x _     -> oneBranch x
     Alts (d,_) -> oneBranch d
     _ -> t

  --- very unclean cleaner
   clean s = case s of
     '+':'+':' ':cs -> clean cs
     '"':cs -> clean cs
     c:cs -> c: clean cs
     _ -> s

