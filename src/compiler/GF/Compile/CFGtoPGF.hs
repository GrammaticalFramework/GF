module GF.Compile.CFGtoPGF (cf2gf) where

import GF.Grammar.Grammar hiding (Cat)
import GF.Grammar.Macros
import GF.Grammar.CFG
import GF.Infra.Ident(Ident,identS)
import GF.Infra.Option
import GF.Infra.UseIO

import GF.Data.Operations

import PGF(showCId)

import qualified Data.Set as Set
import qualified Data.Map as Map


--------------------------
-- the compiler ----------
--------------------------

cf2gf :: FilePath -> CFG -> SourceGrammar
cf2gf fpath cf = mGrammar [
  (aname, ModInfo MTAbstract MSComplete (modifyFlags (\fs -> fs{optStartCat = Just cat})) [] Nothing [] [] fpath Nothing abs),
  (cname, ModInfo (MTConcrete aname) MSComplete noOptions [] Nothing [] [] fpath Nothing cnc)
  ]
 where
   name = justModuleName fpath
   (abs,cnc,cat) = cf2grammar cf
   aname = identS $ name ++ "Abs"
   cname = identS name


cf2grammar :: CFG -> (BinTree Ident Info, BinTree Ident Info, String)
cf2grammar cfg = (buildTree abs, buildTree conc, cfgStartCat cfg) where
  abs   = cats ++ funs
  conc  = lincats ++ lins
  cats  = [(identS cat, AbsCat (Just (L NoLoc []))) | cat <- Map.keys (cfgRules cfg)]
  lincats = [(cat, CncCat (Just (L loc defLinType)) Nothing Nothing Nothing Nothing) | (cat,AbsCat (Just (L loc _))) <- cats]
  (funs,lins) = unzip (map cf2rule (concatMap Set.toList (Map.elems (cfgRules cfg))))

cf2rule :: CFRule -> ((Ident,Info),(Ident,Info))
cf2rule (CFRule cat items (CFObj fun _)) = (def,ldef) where
  f     = identS (showCId fun)
  def   = (f, AbsFun (Just (L NoLoc (mkProd args' (Cn (identS cat)) []))) Nothing Nothing (Just True))
  args0 = zip (map (identS . ("x" ++) . show) [0..]) items
  args  = [((Explicit,v), Cn (identS c)) | (v, NonTerminal c) <- args0]
  args' = [(Explicit,identS "_", Cn (identS c)) | (_, NonTerminal c) <- args0]
  ldef  = (f, CncFun 
               Nothing 
               (Just (L NoLoc (mkAbs (map fst args) 
                      (mkRecord (const theLinLabel) [foldconcat (map mkIt args0)]))))
               Nothing
               Nothing)
  mkIt (v, NonTerminal _) = P (Vr v) theLinLabel
  mkIt (_, Terminal a) = K a
  foldconcat [] = K ""
  foldconcat tt = foldr1 C tt
