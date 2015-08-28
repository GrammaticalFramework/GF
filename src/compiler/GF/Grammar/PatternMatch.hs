----------------------------------------------------------------------
-- |
-- Module      : PatternMatch
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/10/12 12:38:29 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.7 $
--
-- pattern matching for both concrete and abstract syntax. AR -- 16\/6\/2003
-----------------------------------------------------------------------------

module GF.Grammar.PatternMatch (matchPattern,
		     testOvershadow, 
		     findMatch,
                     measurePatt
		    ) where

import GF.Data.Operations
import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Grammar.Macros
--import GF.Grammar.Printer

--import Data.List
import Control.Monad
import GF.Text.Pretty
--import Debug.Trace

matchPattern :: ErrorMonad m => [(Patt,rhs)] -> Term -> m (rhs, Substitution)
matchPattern pts term = 
  if not (isInConstantForm term)
    then raise (render ("variables occur in" <+> pp term))
  else do
    term' <- mkK term
    errIn (render ("trying patterns" <+> hsep (punctuate ',' (map fst pts)))) $
      findMatch [([p],t) | (p,t) <- pts] [term']
 where
  -- to capture all Str with string pattern matching
  mkK s = case s of
    C _ _ -> do
      s' <- getS s
      return (K (unwords s'))
    _ -> return s

  getS s = case s of
    K w -> return [w]
    C v w -> liftM2 (++) (getS v) (getS w)
    Empty -> return []
    _ -> raise (render ("cannot get string from" <+> s))

testOvershadow :: ErrorMonad m => [Patt] -> [Term] -> m [Patt]
testOvershadow pts vs = do
  let numpts = zip pts [0..]
  let cases  = [(p,EInt i) | (p,i) <- numpts]
  ts <- mapM (liftM fst . matchPattern cases) vs
  return [p | (p,i) <- numpts, notElem i [i | EInt i <- ts] ]

findMatch :: ErrorMonad m => [([Patt],rhs)] -> [Term] -> m (rhs, Substitution)
findMatch cases terms = case cases of
   [] -> raise (render ("no applicable case for" <+> hsep (punctuate ',' terms)))
   (patts,_):_ | length patts /= length terms -> 
       raise (render ("wrong number of args for patterns :" <+> hsep patts <+> 
                    "cannot take" <+> hsep terms))
   (patts,val):cc -> case mapM tryMatch (zip patts terms) of
       Ok substs -> return (val, concat substs)
       _         -> findMatch cc terms

tryMatch :: (Patt, Term) -> Err [(Ident, Term)]
tryMatch (p,t) = do 
  t' <- termForm t
  trym p t'
 where

  isInConstantFormt = True -- tested already in matchPattern
  trym p t' =
    case (p,t') of
--    (_,(x,Typed e ty,y)) -> trym p (x,e,y) -- Add this? /TH 2013-09-05
      (_,(x,Empty,y)) -> trym p (x,K [],y)   -- because "" = [""] = []
      (PW, _) | isInConstantFormt -> return [] -- optimization with wildcard
      (PV x,  _) | isInConstantFormt -> return [(x,t)]
      (PString s, ([],K i,[])) | s==i -> return []
      (PInt s, ([],EInt i,[])) | s==i -> return []
      (PFloat s,([],EFloat i,[])) | s==i -> return [] --- rounding?
      (PC p pp, ([], Con f, tt)) | 
            p `eqStrIdent` f && length pp == length tt ->
         do matches <- mapM tryMatch (zip pp tt)
            return (concat matches)

      (PP (q,p) pp, ([], QC (r,f), tt)) | 
            -- q `eqStrIdent` r &&  --- not for inherited AR 10/10/2005
            p `eqStrIdent` f && length pp == length tt ->
         do matches <- mapM tryMatch (zip pp tt)
            return (concat matches)
      ---- hack for AppPredef bug
      (PP (q,p) pp, ([], Q (r,f), tt)) | 
            -- q `eqStrIdent` r && --- 
            p `eqStrIdent` f && length pp == length tt ->
         do matches <- mapM tryMatch (zip pp tt)
            return (concat matches)

      (PR r, ([],R r',[])) |
            all (`elem` map fst r') (map fst r) ->
         do matches <- mapM tryMatch 
                            [(p,snd a) | (l,p) <- r, let Just a = lookup l r']
            return (concat matches)
      (PT _ p',_) -> trym p' t'

      (PAs x p',_) -> do
         subst <- trym p' t'
         return $ (x,t) : subst

      (PAlt p1 p2,_) -> checks [trym p1 t', trym p2 t']

      (PNeg p',_) -> case tryMatch (p',t) of
        Bad _ -> return []
        _ -> raise (render ("no match with negative pattern" <+> p))

      (PSeq p1 p2, ([],K s, [])) -> matchPSeq p1 p2 s
      (PMSeq mp1 mp2, ([],K s, [])) -> matchPMSeq mp1 mp2 s

      (PRep p1, ([],K s, [])) -> checks [
         trym (foldr (const (PSeq p1)) (PString "") 
           [1..n]) t' | n <- [0 .. length s]
        ] >>
        return []

      (PChar,  ([],K [_], [])) -> return []
      (PChars cs, ([],K [c], [])) | elem c cs -> return []

      _ -> raise (render ("no match in case expr for" <+> t))

matchPMSeq (m1,p1) (m2,p2) s = matchPSeq' m1 p1 m2 p2 s
--matchPSeq p1 p2 s = matchPSeq' (0,maxBound::Int) p1 (0,maxBound::Int) p2 s
matchPSeq p1 p2 s = matchPSeq' (lengthBounds p1) p1 (lengthBounds p2) p2 s

matchPSeq' b1@(min1,max1) p1 b2@(min2,max2) p2 s =
  do let n = length s
         lo = min1 `max` (n-max2)
         hi = (n-min2) `min` max1
         cuts = [splitAt i s | i <- [lo..hi]]
     matches <- checks [mapM tryMatch [(p1,K s1),(p2,K s2)] | (s1,s2) <- cuts]
     return (concat matches)

-- | Estimate the minimal length of the string that a pattern will match
minLength = matchLength 0 id (+) min -- safe underestimate

-- | Estimate the maximal length of the string that a pattern will match
maxLength =
    maybe maxBound id . matchLength Nothing Just (liftM2 (+)) (liftM2 max)
        -- safe overestimate

matchLength unknown known seq alt = len
  where
    len p =
      case p of
        PString s  -> known (length s)
        PSeq p1 p2 -> seq (len p1) (len p2)
        PAlt p1 p2 -> alt (len p1) (len p2)
        PChar      -> known 1
        PChars _   -> known 1
        PAs x p'   -> len p'
        PT t p'    -> len p'
        _          -> unknown

lengthBounds p = (minLength p,maxLength p)

mPatt p = (lengthBounds p,measurePatt p)

measurePatt p =
  case p of
    PSeq p1 p2 -> PMSeq (mPatt p1) (mPatt p2)
    _ -> composSafePattOp measurePatt p


isInConstantForm :: Term -> Bool
isInConstantForm trm = case trm of
    Cn _     -> True
    Con _    -> True
    Q _      -> True
    QC _     -> True
    Abs _ _ _ -> True
    C c a    -> isInConstantForm c && isInConstantForm a
    App c a  -> isInConstantForm c && isInConstantForm a
    R r      -> all (isInConstantForm . snd . snd) r
    K _      -> True
    Empty    -> True
    EInt _   -> True
    V ty ts  -> isInConstantForm ty && all isInConstantForm ts -- TH 2013-09-05
--  Typed e t-> isInConstantForm e && isInConstantForm t -- Add this? TH 2013-09-05

    _       -> False ---- isInArgVarForm trm
{- -- unused and suspicuous, see contP in GF.Compile.Compute.Concrete instead
varsOfPatt :: Patt -> [Ident]
varsOfPatt p = case p of
  PV x -> [x]
  PC _ ps -> concat $ map varsOfPatt ps
  PP _ ps -> concat $ map varsOfPatt ps
  PR r    -> concat $ map (varsOfPatt . snd) r
  PT _ q -> varsOfPatt q
  _ -> []

-- | to search matching parameter combinations in tables
isMatchingForms :: [Patt] -> [Term] -> Bool
isMatchingForms ps ts = all match (zip ps ts') where
  match (PC c cs, (Cn d, ds)) = c == d && isMatchingForms cs ds
  match _ = True
  ts' = map appForm ts

-}