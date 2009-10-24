----------------------------------------------------------------------
-- |
-- Module      : GF.Compile.Abstract.Compute
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

module GF.Compile.Abstract.Compute (LookDef,
		   compute, 
		   computeAbsTerm, 
		   computeAbsTermIn, 
		   beta
		  ) where

import GF.Data.Operations

import GF.Grammar
import GF.Grammar.Lookup

import Debug.Trace
import Data.List(intersperse)
import Control.Monad (liftM, liftM2)
import Text.PrettyPrint

-- for debugging
tracd m t = t 
-- tracd = trace

compute :: SourceGrammar -> Exp -> Err Exp
compute = computeAbsTerm

computeAbsTerm :: SourceGrammar -> Exp -> Err Exp
computeAbsTerm gr = computeAbsTermIn (lookupAbsDef gr) []

-- | a hack to make compute work on source grammar as well
type LookDef = Ident -> Ident -> Err (Maybe Int,Maybe [Equation])

computeAbsTermIn :: LookDef -> [Ident] -> Exp -> Err Exp
computeAbsTermIn lookd xs e = errIn (render (text "computing" <+> ppTerm Unqualified 0 e)) $ compt xs e where
  compt vv t = case t of
--    Prod x a b  -> liftM2 (Prod x) (compt vv a) (compt (x:vv) b)
--    Abs x b     -> liftM  (Abs  x)              (compt (x:vv) b)
    _ -> do
      let t' = beta vv t
      (yy,f,aa) <- termForm t'
      let vv' = map snd yy ++ vv
      aa'    <- mapM (compt vv') aa
      case look f of
        Just eqs -> tracd (text "\nmatching" <+> ppTerm Unqualified 0 f) $ 
                          case findMatch eqs aa' of
          Ok (d,g) -> do
            --- let (xs,ts) = unzip g
            --- ts' <- alphaFreshAll vv' ts
            let g' = g --- zip xs ts'
            d' <- compt vv' $ substTerm vv' g' d
            tracd (text "by Egs:" <+> ppTerm Unqualified 0 d') $ return $ mkAbs yy $ d'
          _ -> tracd (text "no match" <+> ppTerm Unqualified 0 t') $ 
               do
            let v = mkApp f aa'
            return $ mkAbs yy $ v
        _ -> do
          let t2 = mkAbs yy $ mkApp f aa'
          tracd (text "not defined" <+> ppTerm Unqualified 0 t2) $ return t2

  look t = case t of
     (Q m f) -> case lookd m f of
       Ok (_,md) -> md
       _ -> Nothing
     _ -> Nothing

beta :: [Ident] -> Exp -> Exp
beta vv c = case c of
  Let (x,(_,a)) b -> beta vv $ substTerm vv [(x,beta vv a)] (beta (x:vv) b) 
  App f         a -> 
    let (a',f') = (beta vv a, beta vv f) in 
    case f' of
      Abs _ x b -> beta vv $ substTerm vv [(x,a')] (beta (x:vv) b) 
      _ ->               (if a'==a && f'==f then id else beta vv) $ App f' a'
  Prod b x a t      -> Prod b x (beta vv a) (beta (x:vv) t)
  Abs b x t       -> Abs b x (beta (x:vv) t)
  _               -> c

-- special version of pattern matching, to deal with comp under lambda

findMatch :: [([Patt],Term)] -> [Term] -> Err (Term, Substitution)
findMatch cases terms = case cases of
  [] -> Bad $ render (text "no applicable case for" <+> hcat (punctuate comma (map (ppTerm Unqualified 0) terms)))
  (patts,_):_ | length patts /= length terms -> 
       Bad (render (text "wrong number of args for patterns :" <+> 
                    hsep (map (ppPatt Unqualified 0) patts) <+> text "cannot take" <+> hsep (map (ppTerm Unqualified 0) terms)))
  (patts,val):cc -> case mapM tryMatch (zip patts terms) of
     Ok substs -> return (tracd (text "value" <+> ppTerm Unqualified 0 val) val, concat substs)
     _         -> findMatch cc terms

tryMatch :: (Patt, Term) -> Err [(Ident, Term)]
tryMatch (p,t) = do 
  t' <- termForm t
  trym p t'
 where

  trym p t' = err (\s -> tracd s (Bad s)) (\t -> tracd (prtm p t) (return t)) $ ---- 
              case (p,t') of
    (PW,    _) | notMeta t -> return [] -- optimization with wildcard
    (PV x,  _) | notMeta t -> return [(x,t)]
    (PString s, ([],K i,[])) | s==i -> return []
    (PInt s, ([],EInt i,[])) | s==i -> return []
    (PFloat s,([],EFloat i,[])) | s==i -> return [] --- rounding?
    (PP q p pp, ([], QC r f, tt)) | 
       p `eqStrIdent` f && length pp == length tt -> do
         matches <- mapM tryMatch (zip pp tt)
         return (concat matches)
    (PP q p pp, ([], Q r f, tt)) | 
       p `eqStrIdent` f && length pp == length tt -> do
         matches <- mapM tryMatch (zip pp tt)
         return (concat matches)
    (PT _ p',_) -> trym p' t'
    (_, ([],Alias _ _ d,[])) -> tryMatch (p,d)
    (PAs x p',_) -> do
       subst <- trym p' t'
       return $ (x,t) : subst
    _ -> Bad (render (text "no match in pattern" <+> ppPatt Unqualified 0 p <+> text "for" <+> ppTerm Unqualified 0 t))

  notMeta e = case e of
    Meta _  -> False
    App f a -> notMeta f &&  notMeta a  
    Abs _ _ b -> notMeta b
    _ -> True

  prtm p g = 
    ppPatt Unqualified 0 p <+> colon $$ hsep (punctuate semi [ppIdent x <+> char '=' <+> ppTerm Unqualified 0 y | (x,y) <- g])
