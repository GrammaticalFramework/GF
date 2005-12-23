----------------------------------------------------------------------
-- |
-- Module      : CFGToFiniteState
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/10 16:43:44 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.6 $
--
-- Approximates CFGs with finite state networks.
-----------------------------------------------------------------------------

module GF.Speech.CFGToFiniteState (cfgToFA, makeSimpleRegular) where

import Data.List
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Set (Set)
import qualified Data.Set as Set

import GF.Data.Utilities
import GF.Formalism.CFG 
import GF.Formalism.Utilities (Symbol(..), mapSymbol, filterCats, symbol, NameProfile(..))
import GF.Conversion.Types
import GF.Infra.Ident (Ident)
import GF.Infra.Option (Options)

import GF.Speech.FiniteState
import GF.Speech.Relation
import GF.Speech.TransformCFG

data MutRecSet = MutRecSet {
                            mrCats :: [Cat_],
                            mrNonRecRules :: [CFRule_],
                            mrRecRules :: [CFRule_],
                            mrIsRightRec :: Bool
                           }


type MutRecSets = Map Cat_ MutRecSet

cfgToFA :: Options -> CGrammar -> DFA String
cfgToFA opts = minimize . compileAutomaton start . makeSimpleRegular
  where start = getStartCat opts

makeSimpleRegular :: CGrammar -> CFRules
makeSimpleRegular = makeRegular . removeIdenticalRules . removeEmptyCats . cfgToCFRules

-- Use the transformation algorithm from \"Regular Approximation of Context-free
-- Grammars through Approximation\", Mohri and Nederhof, 2000
-- to create an over-generating regular frammar for a context-free 
-- grammar
makeRegular :: CFRules -> CFRules
makeRegular g = groupProds $ concatMap trSet (mutRecCats True g)
  where trSet cs | allXLinear cs rs = rs
                 | otherwise = concatMap handleCat csl
            where csl = Set.toList cs 
                  rs = catSetRules g csl
                  handleCat c = [CFRule c' [] (mkName (c++"-empty"))] -- introduce A' -> e
                                ++ concatMap (makeRightLinearRules c) (catRules g c)
                      where c' = newCat c
                  makeRightLinearRules b' (CFRule c ss n) = 
                      case ys of
                              [] -> [CFRule b' (xs ++ [Cat (newCat c)]) n] -- no non-terminals left
                              (Cat b:zs) -> CFRule b' (xs ++ [Cat b]) n 
                                        : makeRightLinearRules (newCat b) (CFRule c zs n)
                      where (xs,ys) = break (`catElem` cs) ss
        newCat c = c ++ "$"


-- | Get the sets of mutually recursive non-terminals for a grammar.
mutRecCats :: Bool    -- ^ If true, all categories will be in some set.
                      --   If false, only recursive categories will be included.
           -> CFRules -> [Set Cat_]
mutRecCats incAll g = equivalenceClasses $ refl $ symmetricSubrelation $ transitiveClosure r
  where r = mkRel [(c,c') | (_,rs) <- g, CFRule c ss _ <- rs, Cat c' <- ss]
        allCats = map fst g
        refl = if incAll then reflexiveClosure_ allCats else reflexiveSubrelation

-- Convert a strongly regular grammar to a finite automaton.
compileAutomaton :: Cat_ -- ^ Start category
                 -> CFRules
                 -> NFA Token
compileAutomaton start g = make_fa (g,ns) s [Cat start] f fa''
  where 
  fa = newFA ()
  s = startState fa
  (fa',f) = newState () fa
  fa'' = addFinalState f fa'
  ns = mutRecSets g $ mutRecCats False g

mutRecSets :: CFRules -> [Set Cat_] -> MutRecSets
mutRecSets g = Map.fromList . concatMap mkMutRecSet
  where 
  mkMutRecSet cs = [ (c,ms) | c <- csl ]
   where csl = Set.toList cs
         rs = catSetRules g csl
         (nrs,rrs) = partition (ruleIsNonRecursive cs) rs
         ms = MutRecSet {
                         mrCats = csl,
                         mrNonRecRules = nrs,
                         mrRecRules = rrs,
                         mrIsRightRec = all (isRightLinear cs) rrs
                        }

-- | The make_fa algorithm from \"Regular approximation of CFLs: a grammatical view\",
--   Mark-Jan Nederhof. International Workshop on Parsing Technologies, 1997.
make_fa :: (CFRules,MutRecSets) -> State -> [Symbol Cat_ Token] -> State 
          -> NFA Token -> NFA Token
make_fa c@(g,ns) q0 alpha q1 fa = 
     case alpha of
        []       -> newTransition q0 q1 Nothing fa
        [Tok t]  -> newTransition q0 q1 (Just t) fa
        [Cat a]  -> case Map.lookup a ns of
                        -- a is recursive
                        Just n@(MutRecSet { mrCats = ni, mrNonRecRules = nrs, mrRecRules = rs} ) -> 
                              if mrIsRightRec n
                               then
                                -- the set Ni is right-recursive or cyclic
                                let fa''  = foldl (\ f (CFRule c xs _) -> make_fa_ (getState c) xs q1 f) fa' nrs
                                    fa''' = foldl (\ f (CFRule c ss _) -> 
                                                       let (xs,Cat d) = (init ss,last ss)
                                                        in make_fa_ (getState c) xs (getState d) f) fa'' rs
                                 in newTransition q0 (getState a) Nothing fa'''
                               else
                                -- the set Ni is left-recursive
                                let fa'' = foldl (\f (CFRule c xs _) -> make_fa_ q0 xs (getState c) f) fa' nrs
                                    fa''' = foldl (\f (CFRule c (Cat d:xs) _) -> make_fa_ (getState d) xs (getState c) f) fa'' rs
                                in newTransition (getState a) q1 Nothing fa'''
                          where
                          (fa',ss) = addStatesForCats ni fa
                          getState x = lookup' x ss
                        -- a is not recursive
                        Nothing -> let rs = catRules g a
                                    in foldl (\fa -> \ (CFRule _ b _) -> make_fa_ q0 b q1 fa) fa rs
        (x:beta) -> let (fa',q) = newState () fa
                     in make_fa_ q beta q1 $! make_fa_ q0 [x] q fa'
  where
  make_fa_ = make_fa c

addStatesForCats :: [Cat_] -> NFA Token -> (NFA Token, [(Cat_,State)])
addStatesForCats cs fa = (fa', zip cs (map fst ns))
  where (fa', ns) = newStates (replicate (length cs) ()) fa

ruleIsNonRecursive :: Set Cat_ -> CFRule_ -> Bool
ruleIsNonRecursive cs = noCatsInSet cs . ruleRhs



noCatsInSet :: Set Cat_ -> [Symbol Cat_ t] -> Bool
noCatsInSet cs = not . any (`catElem` cs)

-- | Check if all the rules are right-linear, or all the rules are
--   left-linear, with respect to given categories.
allXLinear :: Set Cat_ -> [CFRule_] -> Bool
allXLinear cs rs = all (isRightLinear cs) rs || all (isLeftLinear cs) rs

-- | Checks if a context-free rule is right-linear.
isRightLinear :: Set Cat_  -- ^ The categories to consider
              -> CFRule_   -- ^ The rule to check for right-linearity
              -> Bool
isRightLinear cs = noCatsInSet cs . safeInit . ruleRhs

-- | Checks if a context-free rule is left-linear.
isLeftLinear ::  Set Cat_  -- ^ The categories to consider
              -> CFRule_   -- ^ The rule to check for right-linearity
              -> Bool
isLeftLinear cs = noCatsInSet cs . drop 1 . ruleRhs
