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
		     findMatch
		    ) where

import GF.Data.Operations
import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Grammar.Macros
import GF.Grammar.PrGrammar

import Data.List
import Control.Monad


matchPattern :: [(Patt,Term)] -> Term -> Err (Term, Substitution)
matchPattern pts term = 
  errIn ("trying patterns" +++ unwords (intersperse "," (map (prt . fst) pts))) $
  findMatch [([p],t) | (p,t) <- pts] [term]

testOvershadow :: [Patt] -> [Term] -> Err [Patt]
testOvershadow pts vs = do
  let numpts = zip pts [0..]
  let cases  = [(p,EInt i) | (p,i) <- numpts]
  ts <- mapM (liftM fst . matchPattern cases) vs
  return $ [p | (p,i) <- numpts, notElem i [i | EInt i <- ts] ]

findMatch :: [([Patt],Term)] -> [Term] -> Err (Term, Substitution)
findMatch cases terms = case cases of
   [] -> Bad $"no applicable case for" +++ unwords (intersperse "," (map prt terms))
   (patts,_):_ | length patts /= length terms -> 
       Bad ("wrong number of args for patterns :" +++ 
            unwords (map prt patts) +++ "cannot take" +++ unwords (map prt terms))
   (patts,val):cc -> case mapM tryMatch (zip patts terms) of
       Ok substs -> return (val, concat substs)
       _         -> findMatch cc terms

tryMatch :: (Patt, Term) -> Err [(Ident, Term)]
tryMatch (p,t) = do 
  t' <- termForm t
  trym p t'
 where
  trym p t' =
    case (p,t') of
      (PV IW, _) | isInConstantForm t -> return [] -- optimization with wildcard
      (PV x,  _) | isInConstantForm t -> return [(x,t)]
      (PString s, ([],K i,[])) | s==i -> return []
      (PInt s, ([],EInt i,[])) | s==i -> return []
      (PC p pp, ([], Con f, tt)) | 
            p `eqStrIdent` f && length pp == length tt ->
         do matches <- mapM tryMatch (zip pp tt)
            return (concat matches)
      (PP q p pp, ([], QC r f, tt)) | 
            -- q `eqStrIdent` r &&  --- not for inherited AR 10/10/2005
            p `eqStrIdent` f && length pp == length tt ->
         do matches <- mapM tryMatch (zip pp tt)
            return (concat matches)
      ---- hack for AppPredef bug
      (PP q p pp, ([], Q r f, tt)) | 
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
      (_, ([],Alias _ _ d,[])) -> tryMatch (p,d)
      _ -> prtBad "no match in case expr for" t
  
isInConstantForm :: Term -> Bool
isInConstantForm trm = case trm of
    Cn _     -> True
    Con _    -> True
    Q _ _    -> True
    QC _ _   -> True
    Abs _ _  -> True
    App c a  -> isInConstantForm c && isInConstantForm a
    R r      -> all (isInConstantForm . snd . snd) r
    K _      -> True
    Alias _ _ t -> isInConstantForm t
    EInt _   -> True
    _       -> False ---- isInArgVarForm trm

varsOfPatt :: Patt -> [Ident]
varsOfPatt p = case p of
  PV x -> [x | not (isWildIdent x)]
  PC _ ps -> concat $ map varsOfPatt ps
  PP _ _ ps -> concat $ map varsOfPatt ps
  PR r    -> concat $ map (varsOfPatt . snd) r
  PT _ q -> varsOfPatt q
  _ -> []

-- | to search matching parameter combinations in tables
isMatchingForms :: [Patt] -> [Term] -> Bool
isMatchingForms ps ts = all match (zip ps ts') where
  match (PC c cs, (Cn d, ds)) = c == d && isMatchingForms cs ds
  match _ = True
  ts' = map appForm ts

