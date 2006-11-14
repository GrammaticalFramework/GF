----------------------------------------------------------------------
-- |
-- Module      : PrOld
-- Maintainer  : GF
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:21:44 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.8 $
--
-- a hack to print gf2 into gf1 readable files
-- Works only for canonical grammars, printed into GFC. Otherwise we would have
-- problems with qualified names.
-- --- printnames are not preserved, nor are lindefs
-----------------------------------------------------------------------------

module GF.Compile.PrOld (printGrammarOld, stripTerm) where

import GF.Grammar.PrGrammar
import GF.Canon.CanonToGrammar
import qualified GF.Canon.GFC as GFC
import GF.Grammar.Grammar
import GF.Infra.Ident
import GF.Grammar.Macros
import GF.Infra.Modules
import qualified GF.Source.PrintGF as P
import GF.Source.GrammarToSource

import Data.List
import GF.Data.Operations
import GF.Infra.UseIO

printGrammarOld :: GFC.CanonGrammar -> String
printGrammarOld gr = err id id $ do
  as0 <- mapM canon2sourceModule [im | im@(_,ModMod m) <- modules gr, isModAbs m]
  cs0 <- mapM canon2sourceModule 
           [im | im@(_,ModMod m) <- modules gr, isModCnc m || isModRes m]
  as1 <- return $ concatMap stripInfo $ concatMap (tree2list . js . snd) as0
  cs1 <- return $ concatMap stripInfo $ concatMap (tree2list . js . snd) cs0
  return $ unlines $ map prj $ srt as1 ++ srt cs1
 where
   js (ModMod m) = jments m
   srt = sortBy (\ (i,_) (j,_) -> compare i j)
   prj ii = P.printTree $ trAnyDef ii

stripInfo :: (Ident,Info) -> [(Ident,Info)]
stripInfo (c,i) = case i of
  AbsCat   (Yes co) (Yes fs) -> rc $ AbsCat (Yes (stripContext co)) nope
  AbsFun   (Yes ty) (Yes tr) -> rc $ AbsFun (Yes (stripTerm ty)) (Yes(stripTerm tr))
  AbsFun   (Yes ty) _ -> rc $ AbsFun (Yes (stripTerm ty)) nope
  ResParam (Yes (ps,m))       -> rc $ ResParam (Yes ([(c,stripContext co) | (c,co)<- ps],Nothing))
  CncCat   (Yes ty) _ _ -> rc $
    CncCat (Yes (stripTerm ty)) nope nope
  CncFun   _ (Yes tr) _ -> rc $ CncFun Nothing (Yes (stripTerm tr)) nope
  _ -> []
 where
   rc j = [(c,j)]

stripContext co = [(x, stripTerm t) | (x,t) <- co]

stripTerm :: Term -> Term
stripTerm t = case t of
  Q _ c -> Vr c
  QC _ c -> Vr c
  T ti cs -> T ti' [(stripPattern p, stripTerm c) | (p,c) <- cs] where
               ti' = case ti of
                  TTyped ty -> TTyped $ stripTerm ty
                  TComp ty -> TComp $ stripTerm ty
                  TWild ty -> TWild $ stripTerm ty
                  _ -> ti
----  R [] -> EInt 8      --- GF 1.2 parser doesn't accept empty records 
----  RecType [] -> Cn (zIdent "Int") ---
  _ -> composSafeOp stripTerm t

stripPattern p = case p of
  PC c [] -> PV c
  PP _ c [] -> PV c
  PC c ps -> PC c (map stripPattern ps)
  PP _ c ps -> PC c (map stripPattern ps)
  PR lps -> PR [(l, stripPattern p) | (l,p) <- lps]
  PT t p -> PT (stripTerm t) (stripPattern p)
  _ -> p

