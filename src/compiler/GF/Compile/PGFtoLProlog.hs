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
  vcat [ppClauses cat fns | (cat,fs) <- Map.toList (catfuns (abstract pgf)),
                            let fns = [(f,fromJust (Map.lookup f (funs (abstract pgf)))) | f <- fs]]
  where
    ppClauses cat fns =
      text "/*" <+> ppCId cat <+> text "*/" $$
      vcat [ppClause 0 1 [] f ty <> dot | (f,(ty,_,_)) <- fns] $$
      space

grammar2lambdaprolog_sig pgf = render $
  text "sig" <+> ppCId (absname pgf) <> char '.' $$
  space $$
  vcat [ppCat c hyps <> dot | (c,hyps) <- Map.toList (cats (abstract pgf))] $$
  space $$
  vcat [ppFun f ty <> dot | (f,(ty,_,_)) <- Map.toList (funs (abstract pgf))] $$
  space $$
  vcat [ppExport c hyps <> dot | (c,hyps) <- Map.toList (cats (abstract pgf))]

ppCat :: CId -> [Hypo] -> Doc
ppCat c hyps = text "kind" <+> ppKind c <+> text "type"

ppFun :: CId -> Type -> Doc
ppFun f ty = text "type" <+> ppCId f <+> ppType 0 ty

ppExport :: CId -> [Hypo] -> Doc
ppExport c hyps = text "exportdef" <+> ppPred c <+> foldr (\hyp doc -> ppHypo 1 hyp <+> text "->" <+> doc) (text "o") (hyp:hyps)
  where
    hyp = (Explicit,wildCId,DTyp [] c [])

ppClause :: Int -> Int -> [CId] -> CId -> Type -> Doc
ppClause d i scope f (DTyp hyps cat args)
  | null hyps = let res = EFun f
                in ppRes i scope cat (res : args)
  | otherwise = let ((i',vars,scope'),hdocs) = mapAccumL (ppGoal 1) (i,[],scope) hyps
                    res  = foldl EApp (EFun f) (map EFun (reverse vars))
                    quants = hsep (map (\v -> text "pi" <+> ppCId v <+> char '\\') vars)
                in ppParens (d > 0) (quants <+> ppRes i' scope' cat (res : args) <+> text ":-" <+> hsep (punctuate comma hdocs))
  where
    ppRes i scope cat es = ppParens (d > 3) (ppPred cat <+> hsep (map (ppExpr 4 i scope) es))

    ppGoal :: Int -> (Int,[CId],[CId]) -> (BindType,CId,Type) -> ((Int,[CId],[CId]),Doc)
    ppGoal d (i,vars,scope) (_,x,typ)
      | x == wildCId = ((i+1,v:vars,  scope),ppClause d (i+1) scope v typ)
      | otherwise    = ((i+1,v:vars,v:scope),ppClause d (i+1) scope v typ)
      where
        v = mkCId ("X_"++show i)

ppPred :: CId -> Doc
ppPred cat = text "p_" <> ppCId cat

ppKind :: CId -> Doc
ppKind cat = text "k_" <> ppCId cat

ppType :: Int -> Type -> Doc
ppType d (DTyp hyps cat args)
  | null hyps = ppKind cat
  | otherwise = ppParens (d > 0) (foldr (\hyp doc -> ppHypo 1 hyp <+> text "->" <+> doc) (ppKind cat) hyps)

ppHypo d (_,_,typ) = ppType d typ

ppExpr d i scope (EAbs b x e) = let v = mkCId ("X_"++show i)
                                in ppParens (d > 1) (ppCId v <+> char '\\' <+> ppExpr 1 (i+1) (v:scope) e)
ppExpr d i scope (EApp e1 e2) = ppParens (d > 3) ((ppExpr 3 i scope e1) <+> (ppExpr 4 i scope e2))
ppExpr d i scope (ELit l)     = ppLit l
ppExpr d i scope (EMeta n)    = ppMeta n
ppExpr d i scope (EFun f)     = ppCId f
ppExpr d i scope (EVar j)     = ppCId (scope !! j)
ppExpr d i scope (ETyped e ty)= ppExpr d i scope e
ppExpr d i scope (EImplArg e) = ppExpr 0 i scope e

dot = char '.'
