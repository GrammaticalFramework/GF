module AbsCompute where

import Operations

import Abstract
import PrGrammar
import LookAbs
import PatternMatch
import Compute

import Monad (liftM, liftM2)

-- computation in abstract syntax w.r.t. explicit definitions.
--- old GF computation; to be updated

compute :: GFCGrammar -> Exp -> Err Exp
compute = computeAbsTerm

computeAbsTerm :: GFCGrammar -> Exp -> Err Exp
computeAbsTerm gr = computeAbsTermIn (lookupAbsDef gr) []

--- a hack to make compute work on source grammar as well
type LookDef = Ident -> Ident -> Err (Maybe Term)

computeAbsTermIn :: LookDef -> [Ident] -> Exp -> Err Exp
computeAbsTermIn lookd xs e = errIn ("computing" +++ prt e) $ compt xs e where
  compt vv t = case t of
    Prod x a b  -> liftM2 (Prod x) (compt vv a) (compt (x:vv) b)
    Abs x b     -> liftM  (Abs  x)              (compt (x:vv) b)
    _ -> do
      let t' = beta vv t
      (yy,f,aa) <- termForm t'
      let vv' = yy ++ vv
      aa'    <- mapM (compt vv') aa
      case look f of
        Just (Eqs eqs) -> case findMatch eqs aa' of
          Ok (d,g) -> do
            let (xs,ts) = unzip g
            ts' <- alphaFreshAll vv' ts ---
            let g' = zip xs ts'
            d' <- compt vv' $ substTerm vv' g' d
            return $ mkAbs yy $ d'
          _ -> do
            return $ mkAbs yy $ mkApp f aa'
        Just d -> do
          d' <- compt vv' d
          da <- ifNull (return d') (compt vv' . mkApp d') aa' 
          return $ mkAbs yy $ da
        _ -> do
          return $ mkAbs yy $ mkApp f aa'

  look t = case t of
     (Q m f) -> case lookd m f of
       Ok (Just EData) -> Nothing  -- canonical --- should always be QC
       Ok md -> md
       _ -> Nothing
     _ -> Nothing

beta :: [Ident] -> Exp -> Exp
beta vv c = case c of
  App (Abs x b) a -> beta vv $ substTerm vv [xvv] (beta (x:vv) b) 
                                                    where xvv = (x,beta vv a) 
  App f         a -> let (a',f') = (beta vv a, beta vv f) in 
                     (if a'==a && f'==f then id else beta vv) $ App f' a'
  Prod x a b      -> Prod x (beta vv a) (beta (x:vv) b)
  Abs x b         -> Abs x (beta (x:vv) b)
  _               -> c

