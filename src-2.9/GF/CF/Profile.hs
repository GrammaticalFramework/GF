----------------------------------------------------------------------
-- |
-- Module      : Profile
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:21:14 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.8 $
--
-- restoring parse trees for discontinuous constituents, bindings, etc. AR 25/1/2001
-- revised 8/4/2002 for the new profile structure
-----------------------------------------------------------------------------

module GF.CF.Profile (postParse) where

import GF.Canon.AbsGFC
import GF.Canon.GFC
import qualified GF.Infra.Ident as I
import GF.Canon.CMacros
---import MMacros
import GF.CF.CF
import GF.CF.CFIdent
import GF.CF.PPrCF -- for error msg
import GF.Grammar.PrGrammar

import GF.Data.Operations

import Control.Monad
import Data.List (nub)

-- | the job is done in two passes: 
-- 
--   1. tree2term: restore constituent order from Profile 
-- 
--   2. term2trm:  restore Bindings from Binds
postParse :: CFTree -> Err Exp
postParse tree = do
  iterm <- errIn ("postprocessing parse tree" +++ prCFTree tree) $ tree2term tree
  return $ term2trm  iterm

-- | an intermediate data structure
data ITerm = ITerm (Atom, BindVs) [ITerm] | IMeta   deriving (Eq,Show)
type BindVs = [[I.Ident]]

-- | (1) restore constituent order from Profile 
tree2term :: CFTree -> Err ITerm
-- tree2term (CFTree (f,(_,[t]))) | f == dummyCFFun = tree2term t -- not used
tree2term (CFTree (cff@(CFFun (fun,pro)), (_,trees))) = case fun of
  AM _ -> return IMeta
  _ -> do
    args  <- mapM mkArg pro
    binds <- mapM mkBinds pro
    return $ ITerm (fun, binds) args
 where
   mkArg (_,arg) = case arg of
     [x] -> do               -- one occurrence
       trx <- trees !? x
       tree2term trx
     []  -> return IMeta     -- suppression
     _   -> do               -- reduplication
       trees' <- mapM (trees !?) arg
       xs1    <- mapM tree2term trees' 
       xs2    <- checkArity xs1
       unif xs2

   checkArity xs = if length (nub [length xx | ITerm _ xx <- xs']) > 1 
                   then Bad "arity error" 
                   else return xs'
           where xs' = [t | t@(ITerm _ _) <- xs]
   unif xs = case [t | t@(ITerm _ _) <- xs] of 
    [] -> return $ IMeta
    (ITerm fp@(f,_) xx : ts) -> do
      let hs = [h | ITerm (h,_) _ <- ts, h /= f]
      testErr (null hs)                 -- if fails, hs must be nonempty
              ("unification expects" +++ prt f +++ "but found" +++ prt (head hs))
      xx' <- mapM unifArg [0 .. length xx - 1]
      return $ ITerm fp xx'
    where
      unifArg i = unif [zz !! i | ITerm _ zz <- xs]

   mkBinds (xss,_) = mapM mkBind xss
   mkBind xs = do
     ts <- mapM (trees !?) xs
     let vs = [x | CFTree (CFFun (AV x,_),(_,[])) <- ts]
     testErr (length ts == length vs) "non-variable in bound position"
     case vs of
       [x]  -> return x
       []   -> return $ I.identC "h_" ---- uBoundVar
       y:ys -> do
         testErr (all (==y) ys) ("fail to unify bindings of" +++ prt y)
         return y

-- | (2) restore Bindings from Binds
term2trm :: ITerm -> Exp 
term2trm IMeta = EAtom (AM 0) ---- mExp0
term2trm (ITerm (fun, binds) terms) =
  let bterms = zip binds terms
  in mkAppAtom fun [mkAbsR xs (term2trm t) |  (xs,t) <- bterms]

 --- these are deprecated
 where
   mkAbsR c e = foldr EAbs e c
   mkAppAtom a = mkApp (EAtom a)
   mkApp = foldl EApp
