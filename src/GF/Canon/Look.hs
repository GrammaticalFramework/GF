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

module Look where

import AbsGFC
import GFC
import PrGrammar
import CMacros
----import Values
import MMacros
import qualified Modules as M
import qualified CanonToGrammar as CG

import Operations
import Option

import Monad
import List

-- lookup in GFC. AR 2003

-- linearization lookup

lookupCncInfo :: CanonGrammar -> CIdent -> Err Info
lookupCncInfo gr f@(CIQ m c) = do
  mt <- M.lookupModule gr m
  case mt of
    M.ModMod a -> errIn ("module" +++ prt m) $ 
                  lookupTree prt c $ M.jments a 
    _ -> prtBad "not concrete module" m

lookupLin :: CanonGrammar -> CIdent -> Err Term
lookupLin gr f = do
  info <- lookupCncInfo gr f
  case info of
    CncFun _ _ t _ -> return t
    CncCat _ t _ -> return t
    AnyInd _ n -> lookupLin gr $ redirectIdent n f

lookupLincat :: CanonGrammar -> CIdent -> Err CType
lookupLincat gr f = do
  info <- lookupCncInfo gr f
  case info of
    CncCat t _ _ -> return t
    AnyInd _ n -> lookupLincat gr $ redirectIdent n f
    _ -> prtBad "no lincat found for" f

lookupPrintname :: CanonGrammar -> CIdent -> Err Term
lookupPrintname gr f = do
  info <- lookupCncInfo gr f
  case info of
    CncFun _ _ _ t -> return t
    CncCat _ _ t -> return t
    AnyInd _ n -> lookupPrintname gr $ redirectIdent n f

lookupResInfo :: CanonGrammar -> CIdent -> Err Info
lookupResInfo gr f@(CIQ m c) = do
  mt <- M.lookupModule gr m
  case mt of
    M.ModMod a -> lookupTree prt c $ M.jments a 
    _ -> prtBad "not resource module" m

lookupGlobal :: CanonGrammar -> CIdent -> Err Term
lookupGlobal gr f = do
  info <- lookupResInfo gr f
  case info of
    ResOper _ t -> return t
    AnyInd _ n -> lookupGlobal gr $ redirectIdent n f
    _ -> prtBad "cannot find global" f

lookupOptionsCan :: CanonGrammar -> Err Options
lookupOptionsCan gr = do
  let fs = M.allFlags gr
  os <- mapM CG.redFlag fs
  return $ options os

lookupParamValues :: CanonGrammar -> CIdent -> Err [Term]
lookupParamValues gr pt@(CIQ m _) = do
  info <- lookupResInfo gr pt
  case info of
    ResPar ps -> liftM concat $ mapM mkPar ps
    AnyInd _ n -> lookupParamValues gr $ redirectIdent n pt
    _ -> prtBad "cannot find parameter type" pt
 where
   mkPar (ParD f co) = do
     vs <- liftM combinations $ mapM (allParamValues gr) co
     return $ map (Con (CIQ m f)) vs

-- this is needed since param type can also be a record type

allParamValues :: CanonGrammar -> CType -> Err [Term]
allParamValues cnc ptyp = case ptyp of
  Cn pc -> lookupParamValues cnc pc
  RecType r -> do
    let (ls,tys) = unzip [(l,t) | Lbg l t <- r]
    tss <- mapM allPV tys
    return [R (map (uncurry Ass) (zip ls ts)) | ts <- combinations tss]
  _ -> prtBad "cannot possibly find parameter values for" ptyp
 where
   allPV = allParamValues cnc

-- runtime computation on GFC objects

ccompute :: CanonGrammar -> [Term] -> Term -> Err Term
ccompute cnc = comp [] 
 where
  comp g xs t = case t of
    Arg (A _ i)    -> errIn ("argument list") $ xs !? fromInteger i
    Arg (AB _ _ i) -> errIn ("argument list for binding") $ xs !? fromInteger i
    I c     -> look c 
    LI c    -> lookVar c g

    -- short-cut computation of selections: compute the table only if needed
    S u v   -> do
      u' <- compt u
      case u' of
        T _ [Cas [PW] b] -> compt b  
        T _ [Cas [PV x] b] -> do
          v' <- compt v
          comp ((x,v') : g) xs b  
        T _ cs -> do
          v' <- compt v
          if noVar v' 
             then matchPatt cs v' >>= compt
             else return $ S u' v'
        FV ccs -> do
          v' <- compt v
          mapM (\c -> compt (S c v')) ccs >>= return . FV

        _      -> liftM (S u') $ compt v

    P u l  -> do
      u' <- compt u
      case u' of
        R rs -> maybe (Bad ("unknown label" +++ prt l +++ "in" +++ prt u'))
                      return $ 
                        lookup l [ (x,y) | Ass x y <- rs]
        _    -> return $ P u' l
    FV ts    -> liftM FV (mapM compt ts)
    C E b    -> compt b
    C a E    -> compt a
    C a b    -> do
      a' <- compt a
      b' <- compt b
      return $ case (a',b') of
        (E,_) -> b'
        (_,E) -> a'
        _     -> C a' b'
    R rs     -> liftM (R . map (uncurry Ass)) $ 
                  mapPairsM compt [(l,r) | Ass l r <- rs]

    -- only expand the table when the table is really needed: use expandLin
    T ty rs -> liftM (T ty . map (uncurry Cas)) $ 
                  mapPairsM compt [(l,r) | Cas l r <- rs]

    V ptyp ts -> do
      vs0 <- allParamValues cnc ptyp
      vs  <- mapM term2patt vs0
      let cc = [Cas [p] u | (p,u) <- zip vs ts]
      compt $ T ptyp cc

    Con c xs -> liftM (Con c) $ mapM compt xs

    K (KS []) -> return E --- should not be needed

    _        -> return t  
   where
     compt = comp g xs
     look c = lookupGlobal cnc c

     lookVar c co = case lookup c co of
       Just t -> return t
       _ -> return $ LI c --- Bad $ "unknown local variable" +++ prt c --- 

     noVar v = case v of
       LI _ -> False
       R rs -> all noVar [t | Ass _ t <- rs]
       Con _ ts -> all noVar ts
       FV ts -> all noVar ts
       S x y -> noVar x && noVar y
       _    -> True --- other cases that can be values to pattern match?
