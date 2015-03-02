{-# LANGUAGE PatternGuards #-}
----------------------------------------------------------------------
-- |
-- Module      : Optimize
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/09/16 13:56:13 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.18 $
--
-- Top-level partial evaluation for GF source modules.
-----------------------------------------------------------------------------

module GF.Compile.Optimize (optimizeModule) where

import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Grammar.Printer
import GF.Grammar.Macros
import GF.Grammar.Lookup
import GF.Grammar.Predef
--import GF.Compile.Refresh
--import GF.Compile.Compute.Concrete
import GF.Compile.Compute.ConcreteNew(GlobalEnv,normalForm,resourceValues)
--import GF.Compile.CheckGrammar
--import GF.Compile.Update

import GF.Data.Operations
--import GF.Infra.CheckM
import GF.Infra.Option

import Control.Monad
--import Data.List
import qualified Data.Set as Set
import GF.Text.Pretty
import Debug.Trace


-- | partial evaluation of concrete syntax. AR 6\/2001 -- 16\/5\/2003 -- 5\/2\/2005.

optimizeModule :: Options -> SourceGrammar -> SourceModule -> Err SourceModule
optimizeModule opts sgr m@(name,mi)
  | mstatus mi == MSComplete = do
      ids <- topoSortJments m
      mi <- foldM updateEvalInfo mi ids
      return (name,mi)
  | otherwise = return m
 where
   oopts = opts `addOptions` mflags mi

   resenv = resourceValues oopts sgr

   updateEvalInfo mi (i,info) = do
     info <- evalInfo oopts resenv sgr (name,mi) i info
     return (mi{jments=updateTree (i,info) (jments mi)})

evalInfo :: Options -> GlobalEnv -> SourceGrammar -> SourceModule -> Ident -> Info -> Err Info
evalInfo opts resenv sgr m c info = do

 (if verbAtLeast opts Verbose then trace (" " ++ showIdent c) else id) return ()

 errIn ("optimizing " ++ showIdent c) $ case info of

  CncCat ptyp pde pre ppr mpmcfg -> do
    pde' <- case (ptyp,pde) of
      (Just (L _ typ), Just (L loc de)) -> do
        de <- partEval opts gr ([(Explicit, varStr, typeStr)], typ) de
        return (Just (L loc (factor param c 0 de)))
      (Just (L loc typ), Nothing) -> do
        de <- mkLinDefault gr typ
        de <- partEval opts gr ([(Explicit, varStr, typeStr)], typ) de
        return (Just (L loc (factor param c 0 de)))
      _ -> return pde   -- indirection

    pre' <- case (ptyp,pre) of
      (Just (L _ typ), Just (L loc re)) -> do
        re <- partEval opts gr ([(Explicit, varStr, typ)], typeStr) re
        return (Just (L loc (factor param c 0 re)))
      (Just (L loc typ), Nothing) -> do
        re <- mkLinReference gr typ
        re <- partEval opts gr ([(Explicit, varStr, typ)], typeStr) re
        return (Just (L loc (factor param c 0 re)))
      _ -> return pre   -- indirection

    let ppr' = fmap (evalPrintname resenv c) ppr

    return (CncCat ptyp pde' pre' ppr' mpmcfg)

  CncFun (mt@(Just (_,cont,val))) pde ppr mpmcfg -> --trace (prt c) $
       eIn ("linearization in type" <+> mkProd cont val [] $$ "of function") $ do
    pde' <- case pde of
      Just (L loc de) -> do de <- partEval opts gr (cont,val) de
                            return (Just (L loc (factor param c 0 de)))
      Nothing -> return pde
    let ppr' = fmap (evalPrintname resenv c) ppr
    return $ CncFun mt pde' ppr' mpmcfg -- only cat in type actually needed
{-
  ResOper pty pde 
    | not new && OptExpand `Set.member` optim -> do
         pde' <- case pde of
                   Just (L loc de) -> do de <- computeConcrete gr de
                                         return (Just (L loc (factor param c 0 de)))
                   Nothing -> return Nothing
         return $ ResOper pty pde'
-}
  _ ->  return info
 where
-- new = flag optNewComp opts -- computations moved to GF.Compile.GeneratePMCFG

   gr = prependModule sgr m
   optim = flag optOptimizations opts
   param = OptParametrize `Set.member` optim
   eIn cat = errIn (render ("Error optimizing" <+> cat <+> c <+> ':'))

-- | the main function for compiling linearizations
partEval :: Options -> SourceGrammar -> (Context,Type) -> Term -> Err Term
partEval opts = {-if flag optNewComp opts
                then-} partEvalNew opts
                {-else partEvalOld opts-}

partEvalNew opts gr (context, val) trm =
    errIn (render ("partial evaluation" <+> ppTerm Qualified 0 trm)) $
    checkPredefError trm
{-
partEvalOld opts gr (context, val) trm = errIn (render (text "partial evaluation" <+> ppTerm Qualified 0 trm)) $ do
  let vars  = map (\(bt,x,t) -> x) context
      args  = map Vr vars
      subst = [(v, Vr v) | v <- vars]
      trm1 = mkApp trm args
  trm2 <- computeTerm gr subst trm1
  trm3 <- if rightType trm2
          then computeTerm gr subst trm2 -- compute twice??
          else recordExpand val trm2 >>= computeTerm gr subst
  trm4 <- checkPredefError trm3
  return $ mkAbs [(Explicit,v) | v <- vars] trm4
  where
    -- don't eta expand records of right length (correct by type checking)
    rightType (R rs) = case val of
                         RecType ts -> length rs == length ts
                         _          -> False
    rightType _      = False


-- here we must be careful not to reduce
--   variants {{s = "Auto" ; g = N} ; {s = "Wagen" ; g = M}}
--   {s  = variants {"Auto" ; "Wagen"} ; g  = variants {N ; M}} ;

recordExpand :: Type -> Term -> Err Term
recordExpand typ trm = case typ of
  RecType tys -> case trm of
    FV rs -> return $ FV [R [assign lab (P r lab) | (lab,_) <- tys] | r <- rs]
    _ -> return $ R [assign lab (P trm lab) | (lab,_) <- tys]
  _ -> return trm

-}
-- | auxiliaries for compiling the resource

mkLinDefault :: SourceGrammar -> Type -> Err Term
mkLinDefault gr typ = liftM (Abs Explicit varStr) $ mkDefField typ
 where
   mkDefField typ = case typ of
     Table p t  -> do
       t' <- mkDefField t
       let T _ cs = mkWildCases t'
       return $ T (TWild p) cs
     Sort s | s == cStr -> return $ Vr varStr
     QC p           -> do vs <- lookupParamValues gr p
                          case vs of
                            v:_ -> return v
                            _   -> Bad (render ("no parameter values given to type" <+> ppQIdent Qualified p))
     RecType r  -> do
       let (ls,ts) = unzip r
       ts <- mapM mkDefField ts
       return $ R (zipWith assign ls ts)
     _ | Just _ <- isTypeInts typ -> return $ EInt 0 -- exists in all as first val
     _ -> Bad (render ("linearization type field cannot be" <+> typ))

mkLinReference :: SourceGrammar -> Type -> Err Term
mkLinReference gr typ = 
 liftM (Abs Explicit varStr) $ 
   case mkDefField typ (Vr varStr) of
     Bad "no string" -> return Empty
     x               -> x
 where
   mkDefField ty trm = 
     case ty of
       Table pty ty -> do ps <- allParamValues gr pty
                          case ps of
                            []     -> Bad "no string"
                            (p:ps) -> mkDefField ty (S trm p)
       Sort s | s == cStr -> return trm
       QC p       -> Bad "no string"
       RecType [] -> Bad "no string"
       RecType rs -> do
         msum (map (\(l,ty) -> mkDefField ty (P trm l)) (sortRec rs))
           `mplus` Bad "no string"
       _ | Just _ <- isTypeInts typ -> Bad "no string"
       _ -> Bad (render ("linearization type field cannot be" <+> typ))

evalPrintname :: GlobalEnv -> Ident -> L Term -> L Term
evalPrintname resenv c (L loc pr) = L loc (normalForm resenv (L loc c) pr)

-- do even more: factor parametric branches

factor :: Bool -> Ident -> Int -> Term -> Term
factor param c i t =
  case t of
    T (TComp ty) cs -> factors ty [(p, factor param c (i+1) v) | (p, v) <- cs]
    _               -> composSafeOp (factor param c i) t
  where
    factors ty pvs0  
                 | not param = V ty (map snd pvs0)
    factors ty []            = V ty []
    factors ty pvs0@[(p,v)]  = V ty [v]
    factors ty pvs0@(pv:pvs) =
      let t  = mkFun pv
          ts = map mkFun pvs
      in if all (==t) ts
           then T (TTyped ty) (mkCases t)
           else V ty (map snd pvs0)

    --- we hope this will be fresh and don't check... in GFC would be safe
    qvar = identS ("q_" ++ showIdent c ++ "__" ++ show i)

    mkFun (patt, val) = replace (patt2term patt) (Vr qvar) val
    mkCases t = [(PV qvar, t)]

--  we need to replace subterms
replace :: Term -> Term -> Term -> Term
replace old new trm =
  case trm of
    -- these are the important cases, since they can correspond to patterns  
    QC _     | trm == old -> new
    App _ _  | trm == old -> new
    R _      | trm == old -> new
    App x y               -> App (replace old new x) (replace old new y)
    _                     -> composSafeOp (replace old new) trm
