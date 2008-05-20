----------------------------------------------------------------------
-- |
-- Module      : RelationQC
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/10/26 17:13:13 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.1 $
--
-- QuickCheck properties for GF.Speech.Relation
-----------------------------------------------------------------------------

module GF.Speech.RelationQC where

import GF.Speech.Relation

import Test.QuickCheck

prop_transitiveClosure_trans :: [(Int,Int)] -> Bool
prop_transitiveClosure_trans ps = isTransitive (transitiveClosure (mkRel ps))

prop_symmetricSubrelation_symm :: [(Int,Int)] -> Bool
prop_symmetricSubrelation_symm ps = isSymmetric (symmetricSubrelation (mkRel ps))

prop_symmetricSubrelation_sub :: [(Int,Int)] -> Bool
prop_symmetricSubrelation_sub ps = symmetricSubrelation r `isSubRelationOf` r
  where r = mkRel ps

prop_symmetricClosure_symm :: [(Int,Int)] -> Bool
prop_symmetricClosure_symm ps = isSymmetric (symmetricClosure (mkRel ps))

prop_reflexiveClosure_refl :: [(Int,Int)] -> Bool
prop_reflexiveClosure_refl ps = isReflexive (reflexiveClosure (mkRel ps))

prop_mkEquiv_equiv :: [(Int,Int)] -> Bool
prop_mkEquiv_equiv ps = isEquivalence (mkEquiv ps)
  where mkEquiv = transitiveClosure . symmetricClosure . reflexiveClosure . mkRel
