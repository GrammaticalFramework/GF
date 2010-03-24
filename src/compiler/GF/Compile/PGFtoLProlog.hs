module GF.Compile.PGFtoLProlog(grammar2lambdaprolog_mod, grammar2lambdaprolog_sig) where

import PGF.CId
import PGF.Data hiding (ppExpr, ppType, ppHypo)
import PGF.Macros
import Data.List
import Data.Maybe
import Text.PrettyPrint
import qualified Data.Map as Map
import Debug.Trace

grammar2lambdaprolog_mod pgf = render $
  text "module" <+> ppCId (absname pgf) <> char '.' $$
  space $$
  vcat [ppClauses cat fns | (cat,(_,fs)) <- Map.toList (cats (abstract pgf)),
                            let fns = [(f,fromJust (Map.lookup f (funs (abstract pgf)))) | f <- fs]]
  where
    ppClauses cat fns =
      text "/*" <+> ppCId cat <+> text "*/" $$
      vcat [snd (ppClause (abstract pgf) 0 1 [] f ty) <> dot | (f,(ty,_,Nothing)) <- fns] $$
      space $$
      vcat [vcat (map (\eq -> equation2clause (abstract pgf) f eq <> dot) eqs) | (f,(_,_,Just eqs)) <- fns] $$
      space

grammar2lambdaprolog_sig pgf = render $
  text "sig" <+> ppCId (absname pgf) <> char '.' $$
  space $$
  vcat [ppCat c hyps <> dot | (c,(hyps,_)) <- Map.toList (cats (abstract pgf))] $$
  space $$
  vcat [ppFun f ty <> dot | (f,(ty,_,Nothing)) <- Map.toList (funs (abstract pgf))] $$
  space $$
  vcat [ppExport c hyps <> dot | (c,(hyps,_)) <- Map.toList (cats (abstract pgf))] $$
  vcat [ppFunPred f (hyps ++ [(Explicit,wildCId,DTyp [] c es)]) <> dot | (f,(DTyp hyps c es,_,Just _)) <- Map.toList (funs (abstract pgf))]

ppCat :: CId -> [Hypo] -> Doc
ppCat c hyps = text "kind" <+> ppKind c <+> text "type"

ppFun :: CId -> Type -> Doc
ppFun f ty = text "type" <+> ppCId f <+> ppType 0 ty

ppExport :: CId -> [Hypo] -> Doc
ppExport c hyps = text "exportdef" <+> ppPred c <+> foldr (\hyp doc -> ppHypo 1 hyp <+> text "->" <+> doc) (text "o") (hyp:hyps)
  where
    hyp = (Explicit,wildCId,DTyp [] c [])

ppFunPred :: CId -> [Hypo] -> Doc
ppFunPred c hyps = text "exportdef" <+> ppCId c <+> foldr (\hyp doc -> ppHypo 1 hyp <+> text "->" <+> doc) (text "o") hyps

ppClause :: Abstr -> Int -> Int -> [CId] -> CId -> Type -> (Int,Doc)
ppClause abstr d i scope f ty@(DTyp hyps cat args)
  | null hyps = let res = EFun f
                    (goals,i',head) = ppRes i scope cat (res : args)
                in (i',(if null goals
                          then empty
                          else hsep (punctuate comma (map (ppExpr 0 i' scope) goals)) <> comma)
                       <+>
                       head)
  | otherwise = let (i',vars,scope',hdocs) = ppHypos i [] scope hyps (depType [] ty)
                    res  = foldl EApp (EFun f) (map EFun (reverse vars))
                    quants = if d > 0
                               then hsep (map (\v -> text "pi" <+> ppCId v <+> char '\\') vars)
                               else empty
                    (goals,i'',head) = ppRes i' scope' cat (res : args)
                    docs = map (ppExpr 0 i'' scope') goals ++ hdocs
                in (i'',ppParens (d > 0) (quants <+> head <+> 
                                          (if null docs
                                             then empty
                                             else text ":-" <+> hsep (punctuate comma docs))))
  where
    ppRes i scope cat es = 
       let ((goals,i'),es') = mapAccumL (\(goals,i) e -> let (goals',i',e') = expr2goal abstr scope goals i e []
                                                         in ((goals',i'),e')) ([],i) es
       in (goals,i',ppParens (d > 3) (ppPred cat <+> hsep (map (ppExpr 4 i' scope) es')))

    ppHypos :: Int -> [CId] -> [CId] -> [(BindType,CId,Type)] -> [Int] -> (Int,[CId],[CId],[Doc])
    ppHypos i vars scope [] []
                     = (i,vars,scope,[])
    ppHypos i vars scope ((_,x,typ):hyps) (c:cs)
      | x /= wildCId = let v = mkVar i
                           (i',doc) = ppClause abstr 1 (i+1) scope v typ
                           (i'',vars',scope',docs) = ppHypos i' (v:vars) (v:scope) hyps cs
                       in (i'',vars',scope',if c == 0 then doc : docs else docs)
    ppHypos i vars scope ((_,x,typ):hyps)    cs
                     = let v = mkVar i
                           (i',doc) = ppClause abstr 1 (i+1) scope v typ
                           (i'',vars',scope',docs) = ppHypos i' (v:vars)    scope  hyps cs
                       in (i'',vars',scope',doc : docs)

mkVar i = mkCId ("X_"++show i)

ppPred :: CId -> Doc
ppPred cat = text "p_" <> ppCId cat

ppKind :: CId -> Doc
ppKind cat = text "k_" <> ppCId cat

ppType :: Int -> Type -> Doc
ppType d (DTyp hyps cat args)
  | null hyps = ppKind cat
  | otherwise = ppParens (d > 0) (foldr (\hyp doc -> ppHypo 1 hyp <+> text "->" <+> doc) (ppKind cat) hyps)

ppHypo d (_,_,typ) = ppType d typ

ppExpr d i scope (EAbs b x e) = let v = mkVar i
                                in ppParens (d > 1) (ppCId v <+> char '\\' <+> ppExpr 1 (i+1) (v:scope) e)
ppExpr d i scope (EApp e1 e2) = ppParens (d > 3) ((ppExpr 3 i scope e1) <+> (ppExpr 4 i scope e2))
ppExpr d i scope (ELit l)     = ppLit l
ppExpr d i scope (EMeta n)    = ppMeta n
ppExpr d i scope (EFun f)     = ppCId f
ppExpr d i scope (EVar j)     = ppCId (scope !! j)
ppExpr d i scope (ETyped e ty)= ppExpr d i scope e
ppExpr d i scope (EImplArg e) = ppExpr 0 i scope e

dot = char '.'

depType counts (DTyp hyps cat es) =
  foldl' depExpr (foldl' depHypo counts hyps) es

depHypo counts (_,x,ty)
  | x == wildCId =   depType counts ty
  | otherwise    = 0:depType counts ty

depExpr counts (EAbs b x e) = tail (depExpr (0:counts) e)
depExpr counts (EApp e1 e2) = depExpr (depExpr counts e1) e2
depExpr counts (ELit l)     = counts
depExpr counts (EMeta n)    = counts
depExpr counts (EFun f)     = counts
depExpr counts (EVar j)     = let (xs,c:ys) = splitAt j counts
                              in xs++(c+1):ys
depExpr counts (ETyped e ty)= depExpr counts e
depExpr counts (EImplArg e) = depExpr counts e

equation2clause abstr f (Equ ps e) =
  let scope0 = foldl pattScope [] ps
      scope  = [mkVar i | i <- [0..n-1]]
      n = length scope0
      
      es = map (patt2expr scope0) ps

      (goals,_,goal) = expr2goal abstr scope [] n e []

  in ppCId f <+> hsep (map (ppExpr 4 n scope) (es++[goal])) <+> 
     if null goals
       then empty
       else text ":-" <+> hsep (punctuate comma (map (ppExpr 0 n scope) (reverse goals)))


patt2expr scope (PApp f ps) = foldl EApp (EFun f) (map (patt2expr scope) ps)
patt2expr scope (PLit l)    = ELit l
patt2expr scope (PVar x)    = case findIndex (==x) scope of
                                Just i  -> EVar i
                                Nothing -> error ("unknown variable "++showCId x)
patt2expr scope (PImplArg p)= EImplArg (patt2expr scope p)

expr2goal abstr scope goals i (EApp e1 e2) args =
  let (goals',i',e2') = expr2goal abstr scope goals i e2 []
  in expr2goal abstr scope goals' i' e1 (e2':args)
expr2goal abstr scope goals i (EFun f)     args =
  case Map.lookup f (funs abstr) of
    Just (_,_,Just _) -> let e = EFun (mkVar i)
                         in (foldl EApp (EFun f) (args++[e]) : goals, i+1, e)
    _                 -> (goals,i,foldl EApp (EFun f) args)
expr2goal abstr scope goals i (EVar j)     args =
  (goals,i,foldl EApp (EVar j) args)
