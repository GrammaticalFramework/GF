----------------------------------------------------------------------
-- |
-- Module      : AbsCompute
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/10/02 20:50:19 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.8 $
--
-- computation in abstract syntax w.r.t. explicit definitions.
--
-- old GF computation; to be updated
-----------------------------------------------------------------------------

module GF.Grammar.AbsCompute (LookDef,
		   compute, 
		   computeAbsTerm, 
		   computeAbsTermIn, 
		   beta
		  ) where

import GF.Data.Operations

import GF.Grammar.Abstract
import GF.Grammar.PrGrammar
import GF.Grammar.LookAbs
import GF.Grammar.PatternMatch
import GF.Grammar.Compute

import Debug.Trace

import Control.Monad (liftM, liftM2)

compute :: GFCGrammar -> Exp -> Err Exp
compute = computeAbsTerm

computeAbsTerm :: GFCGrammar -> Exp -> Err Exp
computeAbsTerm gr = computeAbsTermIn (lookupAbsDef gr) []

-- | a hack to make compute work on source grammar as well
type LookDef = Ident -> Ident -> Err (Maybe Term)

computeAbsTermIn :: LookDef -> [Ident] -> Exp -> Err Exp
computeAbsTermIn lookd xs e = errIn ("computing" +++ prt e) $ compt xs e where
  compt vv t = case t of
--    Prod x a b  -> liftM2 (Prod x) (compt vv a) (compt (x:vv) b)
--    Abs x b     -> liftM  (Abs  x)              (compt (x:vv) b)
    _ -> do
      let t' = beta vv t
      (yy,f,aa) <- termForm t'
      let vv' = yy ++ vv
      aa'    <- mapM (compt vv') aa
      case look f of
        Just (Eqs eqs) -> ----trace ("matching" +++ prt f) $ 
                          case findMatch eqs aa' of
          Ok (d,g) -> do
            let (xs,ts) = unzip g
            ts' <- alphaFreshAll vv' ts ---
            let g' = zip xs ts'
            d' <- compt vv' $ substTerm vv' g' d
            return $ mkAbs yy $ d'
          _ -> ---- trace ("no match" +++ prt t') $ 
               do
            let v = mkApp f aa'
            return $ mkAbs yy $ v
        Just d -> do
          da <- compt vv' $ mkApp d aa' 
          return $ mkAbs yy $ da
        _ -> do
          return $ mkAbs yy $ mkApp f aa'

  look t = case t of
     (Q m f) -> case lookd m f of
       Ok (Just EData) -> Nothing  -- canonical --- should always be QC
       Ok md -> md
       _ -> Nothing
     Eqs _ -> return t ---- for nested fn
     _ -> Nothing

beta :: [Ident] -> Exp -> Exp
beta vv c = case c of
  Let (x,(_,a)) b -> beta vv $ substTerm vv [xvv] (beta (x:vv) b) 
                                                    where xvv = (x,beta vv a) 
  App f         a -> 
    let (a',f') = (beta vv a, beta vv f) in 
    case f' of
      Abs x b -> beta vv $ substTerm vv [xvv] (beta (x:vv) b) 
                                                    where xvv = (x,beta vv a) 
      _ ->               (if a'==a && f'==f then id else beta vv) $ App f' a'
  Prod x a b      -> Prod x (beta vv a) (beta (x:vv) b)
  Abs x b         -> Abs x (beta (x:vv) b)
  _               -> c

