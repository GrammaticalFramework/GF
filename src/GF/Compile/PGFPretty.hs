-- | Print a part of a PGF grammar on the human-readable format used in 
-- the paper "PGF: A Portable Run-Time Format for Type-Theoretical Grammars".
module GF.Compile.PGFPretty (prPGFPretty) where

import PGF.CId
import PGF.Data
import PGF.Macros

import GF.Data.Operations
import GF.Text.UTF8

import Data.Map (Map)
import qualified Data.Map as Map
import Text.PrettyPrint.HughesPJ


prPGFPretty :: PGF -> String
prPGFPretty pgf = render $ prAbs (abstract pgf) $$ prAll (prCnc (abstract pgf)) (concretes pgf)

prAbs :: Abstr -> Doc
prAbs a = prAll prCat (cats a) $$ prAll prFun (funs a)

prCat :: CId -> [Hypo] -> Doc
prCat c h | isLiteralCat c = empty
          | otherwise = text "cat" <+> text (prCId c)

prFun :: CId -> (Type,Expr) -> Doc
prFun f (t,_) = text "fun" <+> text (prCId f) <+> text ":" <+> prType t

prType :: Type -> Doc
prType t = parens (hsep (punctuate (text ",") (map (text . prCId) cs))) <+> text "->" <+> text (prCId c)
  where (cs,c) = catSkeleton t


-- FIXME: show concrete name
-- FIXME: inline opers first
prCnc :: Abstr -> CId -> Concr -> Doc
prCnc abstr name c = prAll prLinCat (lincats c) $$ prAll prLin (lins (expand c))
  where
    prLinCat :: CId -> Term -> Doc
    prLinCat c t | isLiteralCat c = empty
                 | otherwise = text "lincat" <+> text (prCId c) <+> text "=" <+> pr t
        where
          pr (R ts) = hsep (punctuate (text " *") (map pr ts))
          pr (S []) = text "Str"
          pr (C n) = text "Int_" <> text (show (n+1))

    prLin :: CId -> Term -> Doc
    prLin f t = text "lin" <+> text (prCId f) <+> text "=" <+> pr 0 t
        where
          pr :: Int -> Term -> Doc
          pr p (R ts) = text "<" <+> hsep (punctuate (text ",") (map (pr 0) ts)) <+> text ">"
          pr p (P t1 t2) = prec p 3 (pr 3 t1 <> text "!" <> pr 3 t2)
          pr p (S ts) = prec p 2 (hsep (punctuate (text " ++") (map (pr 2) ts)))
          pr p (K (KS t)) = doubleQuotes (text t)
          pr p (V i) = text ("argv_" ++ show (i+1))
          pr p (C i) = text (show (i+1))
          pr p (FV ts) = prec p 1 (hsep (punctuate (text " |") (map (pr 1) ts)))
          pr _ t = error $ "PGFPretty.prLin " ++ show t

linCat :: Concr -> CId -> Term
linCat cnc c = Map.findWithDefault (error $ "lincat: " ++ prCId c) c (lincats cnc)

prec :: Int -> Int -> Doc -> Doc
prec p m | p >= m = parens
         | otherwise = id

expand :: Concr -> Concr
expand cnc = cnc { lins = Map.map (f "") (lins cnc) }
  where 
    -- FIXME: handle KP
    f :: String -> Term -> Term
    f w (R ts) = R (map (f w) ts)
    f w (P t1 t2) = P (f w t1) (f w t2)
    f w (S []) = S (if null w then [] else [K (KS w)])
    f w (S (t:ts)) = S (f w t : map (f "") ts)
    f w (FV ts) = FV (map (f w) ts)
    f w (W s t) = f (w++s) t
    f w (K (KS t)) = K (KS (w++t))
    f w (F o) = f w (Map.findWithDefault (error $ "Bad oper: " ++ prCId o) o (opers cnc))
    f w t = t

-- Utilities

prAll :: (a -> b -> Doc) -> Map a b -> Doc
prAll p m = vcat [ p k v | (k,v) <- Map.toList m]