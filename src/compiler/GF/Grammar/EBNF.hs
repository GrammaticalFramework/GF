----------------------------------------------------------------------
-- |
-- Module      : EBNF
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:21:13 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.5 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module GF.Grammar.EBNF (EBNF, ERule, ERHS(..), ebnf2cf) where

import GF.Data.Operations
import GF.Grammar.CFG
import PGF (mkCId)

import Data.List

type EBNF = [ERule]
type ERule = (ECat, ERHS)
type ECat = (String,[Int])
type ETok = String

data ERHS =
   ETerm ETok
 | ENonTerm ECat
 | ESeq  ERHS ERHS
 | EAlt  ERHS ERHS
 | EStar ERHS
 | EPlus ERHS
 | EOpt  ERHS
 | EEmpty

type CFRHS = [CFSymbol]
type CFJustRule = (Cat, CFRHS)

ebnf2cf :: EBNF -> [CFRule]
ebnf2cf ebnf = 
  [CFRule cat items (mkCFF i cat) | (i,(cat,items)) <- zip [0..] (normEBNF ebnf)]
  where
    mkCFF i c = CFObj (mkCId ("Mk" ++ c ++ "_" ++ show i)) []

normEBNF :: EBNF -> [CFJustRule]
normEBNF erules = let
  erules1 = [normERule ([i],r) | (i,r) <- zip [0..] erules]
  erules2 = erules1 ---refreshECats erules1 --- this seems to be just bad !
  erules3 = concat (map pickERules erules2)
--erules4 = nubERules erules3
 in [(mkCFCatE cat, map eitem2cfitem its) | (cat,itss) <- erules3, its <- itss]
{-
refreshECats :: [NormERule] -> [NormERule]
refreshECats rules = [recas [i] rule | (i,rule) <- zip [0..] rules] where
 recas ii (cat,its) = (updECat ii cat, [recss ii 0 s | s <- its])
 recss ii n [] = []
 recss ii n (s:ss) = recit (ii ++ [n]) s : recss ii (n+1) ss
 recit ii it = case it of
   EINonTerm cat  -> EINonTerm (updECat ii cat)
   EIStar (cat,t) -> EIStar (updECat ii cat, [recss ii 0 s | s <- t])
   EIPlus (cat,t) -> EIPlus (updECat ii cat, [recss ii 0 s | s <- t])
   EIOpt  (cat,t) -> EIOpt  (updECat ii cat, [recss ii 0 s | s <- t])
   _ -> it
-}
pickERules :: NormERule -> [NormERule]
pickERules rule@(cat,alts) = rule : concat (map pics (concat alts)) where
 pics it = case it of
   EIStar ru@(cat,t) -> mkEStarRules cat ++ pickERules ru
   EIPlus ru@(cat,t) -> mkEPlusRules cat ++ pickERules ru
   EIOpt  ru@(cat,t) -> mkEOptRules cat ++ pickERules ru
   _ -> []
 mkEStarRules cat = [(cat', [[],[EINonTerm cat, EINonTerm cat']])] 
                                        where cat' = mkNewECat cat "Star"
 mkEPlusRules cat = [(cat', [[EINonTerm cat],[EINonTerm cat, EINonTerm cat']])] 
                                        where cat' = mkNewECat cat "Plus"
 mkEOptRules cat  = [(cat', [[],[EINonTerm cat]])] 
                                        where cat' = mkNewECat cat "Opt"
{-
nubERules :: [NormERule] -> [NormERule]
nubERules rules = nub optim where 
  optim = map (substERules (map mkSubst replaces)) irreducibles
  (replaces,irreducibles) = partition reducible rules
  reducible (cat,[items]) = isNewCat cat && all isOldIt items
  reducible _ = False
  isNewCat (_,ints) = ints == []
  isOldIt (EITerm _) = True
  isOldIt (EINonTerm cat) = not (isNewCat cat)
  isOldIt _ = False
  mkSubst (cat,its) = (cat, head its) -- def of reducible: its must be singleton
--- the optimization assumes each cat has at most one EBNF rule.

substERules :: [(ECat,[EItem])] -> NormERule -> NormERule
substERules g (cat,itss) = (cat, map sub itss) where
  sub [] = []
  sub (i@(EINonTerm cat') : ii) = case lookup cat g of
                                    Just its -> its ++ sub ii 
                                    _ -> i : sub ii
  sub (EIStar r : ii) = EIStar (substERules g r) : ii
  sub (EIPlus r : ii) = EIPlus (substERules g r) : ii
  sub (EIOpt r : ii)  = EIOpt  (substERules g r) : ii
-}
eitem2cfitem :: EItem -> CFSymbol
eitem2cfitem it = case it of
  EITerm a       -> Terminal a
  EINonTerm cat  -> NonTerminal (mkCFCatE cat)
  EIStar (cat,_) -> NonTerminal (mkCFCatE (mkNewECat cat "Star"))
  EIPlus (cat,_) -> NonTerminal (mkCFCatE (mkNewECat cat "Plus"))
  EIOpt  (cat,_) -> NonTerminal (mkCFCatE (mkNewECat cat "Opt"))

type NormERule = (ECat,[[EItem]]) -- disjunction of sequences of items

data EItem =
   EITerm String
 | EINonTerm ECat
 | EIStar NormERule
 | EIPlus NormERule
 | EIOpt  NormERule
  deriving Eq

normERule :: ([Int],ERule) -> NormERule
normERule (ii,(cat,rhs)) = 
 (cat,[map (mkEItem (ii ++ [i])) r' | (i,r') <- zip [0..] (disjNorm rhs)]) where
  disjNorm r = case r of
    ESeq r1 r2 -> [x ++ y | x <- disjNorm r1, y <- disjNorm r2]
    EAlt r1 r2 -> disjNorm r1 ++ disjNorm r2
    EEmpty -> [[]]
    _ -> [[r]]

mkEItem :: [Int] -> ERHS -> EItem
mkEItem ii rhs = case rhs of
  ETerm a -> EITerm a
  ENonTerm cat -> EINonTerm cat
  EStar r -> EIStar (normERule (ii,(mkECat ii, r)))
  EPlus r -> EIPlus (normERule (ii,(mkECat ii, r)))
  EOpt  r -> EIOpt  (normERule (ii,(mkECat ii, r)))
  _ -> EINonTerm ("?????",[])
--  _ -> error "should not happen in ebnf" ---

mkECat ints = ("C", ints)

prECat (c,[]) = c
prECat (c,ints) = c ++ "_" ++ prTList "_" (map show ints)

mkCFCatE :: ECat -> Cat
mkCFCatE = prECat
{-
updECat _ (c,[]) = (c,[])
updECat ii (c,_) = (c,ii)
-}
mkNewECat (c,ii) str = (c ++ str,ii)
