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

module GF.Speech.CFGToFiniteState (cfgToFA, makeSimpleRegular,
                                   MFALabel(..), MFA(..), cfgToMFA,cfgToFA') where

import Data.List
import Data.Maybe
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
import GF.Speech.Graph
import GF.Speech.Relation
import GF.Speech.TransformCFG

data Recursivity = RightR | LeftR | NotR

data MutRecSet = MutRecSet {
                            mrCats :: Set Cat_,
                            mrNonRecRules :: [CFRule_],
                            mrRecRules :: [CFRule_],
                            mrRec :: Recursivity
                           }


type MutRecSets = Map Cat_ MutRecSet

--
-- * Multiple DFA type
--

data MFALabel a = MFASym a | MFASub String
                deriving Eq

data MFA a = MFA (DFA (MFALabel a)) [(String,DFA (MFALabel a))]



cfgToFA :: Options -> CGrammar -> DFA String
cfgToFA opts = minimize . compileAutomaton start . makeSimpleRegular
  where start = getStartCat opts

makeSimpleRegular :: CGrammar -> CFRules
makeSimpleRegular = makeRegular . removeIdenticalRules . removeEmptyCats . cfgToCFRules

--
-- * Approximate context-free grammars with regular grammars.
--

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
                              [] -> newRule b' (xs ++ [Cat (newCat c)]) n -- no non-terminals left
                              (Cat b:zs) -> newRule b' (xs ++ [Cat b]) n 
                                        ++ makeRightLinearRules (newCat b) (CFRule c zs n)
                      where (xs,ys) = break (`catElem` cs) ss
                            -- don't add rules on the form A -> A
                            newRule c rhs n | rhs == [Cat c] = []
                                            | otherwise = [CFRule c rhs n]
        newCat c = c ++ "$"

-- | Get the sets of mutually recursive non-terminals for a grammar.
mutRecCats :: Bool    -- ^ If true, all categories will be in some set.
                      --   If false, only recursive categories will be included.
           -> CFRules -> [Set Cat_]
mutRecCats incAll g = equivalenceClasses $ refl $ symmetricSubrelation $ transitiveClosure r
  where r = mkRel [(c,c') | (_,rs) <- g, CFRule c ss _ <- rs, Cat c' <- ss]
        allCats = map fst g
        refl = if incAll then reflexiveClosure_ allCats else reflexiveSubrelation

--
-- * Compile strongly regular grammars to NFAs
--

-- Convert a strongly regular grammar to a finite automaton.
compileAutomaton :: Cat_ -- ^ Start category
                 -> CFRules
                 -> NFA Token
compileAutomaton start g = make_fa (g,ns) s [Cat start] f fa
  where 
  (fa,s,f) = newFA_
  ns = mutRecSets g $ mutRecCats False g

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
                              case mrRec n of
                               RightR ->
                                -- the set Ni is right-recursive or cyclic
                                let new = [(getState c, xs, q1) | CFRule c xs _ <- nrs]
                                          ++ [(getState c, xs, getState d) | CFRule c ss _ <- rs, 
                                                                             let (xs,Cat d) = (init ss,last ss)]
                                 in make_fas new $ newTransition q0 (getState a) Nothing fa'
                               LeftR ->
                                -- the set Ni is left-recursive
                                let new = [(q0, xs, getState c) | CFRule c xs _ <- nrs]
                                          ++ [(getState d, xs, getState c) | CFRule c (Cat d:xs) _ <- rs]
                                 in make_fas new $ newTransition (getState a) q1 Nothing fa'
                          where
                          (fa',stateMap) = addStatesForCats ni fa
                          getState x = Map.findWithDefault 
                                       (error $ "CFGToFiniteState: No state for " ++ x) 
                                       x stateMap
                        -- a is not recursive
                        Nothing -> let rs = catRules g a
                                    in foldl' (\f (CFRule _ b _) -> make_fa_ q0 b q1 f) fa rs
        (x:beta) -> let (fa',q) = newState () fa
                     in make_fa_ q beta q1 $ make_fa_ q0 [x] q fa'
  where
  make_fa_ = make_fa c
  make_fas xs fa = foldl' (\f' (s1,xs,s2) -> make_fa_ s1 xs s2 f') fa xs

--
-- * Compile a strongly regular grammar to a DFA with sub-automata
--

cfgToMFA :: Options -> CGrammar -> MFA String
cfgToMFA opts g = buildMFA start g
  where start = getStartCat opts

-- | Build a DFA by building and expanding an MFA
cfgToFA' :: Options -> CGrammar -> DFA String
cfgToFA' opts g = mfaToDFA $ cfgToMFA opts g

buildMFA :: Cat_ -- ^ Start category
         -> CGrammar -> MFA String
buildMFA start g = sortSubLats $ removeUnusedSubLats mfa
  where startFA = let (fa,s,f) = newFA_
                   in newTransition s f (MFASub start) fa
        fas = compileAutomata $ makeSimpleRegular g
        mkMFALabel (Cat c) = MFASub c
        mkMFALabel (Tok t) = MFASym t
        toMFA = mapTransitions mkMFALabel
        mfa = MFA startFA [(c, toMFA (minimize fa)) | (c,fa) <- fas]

mfaToDFA :: Ord a => MFA a -> DFA a
mfaToDFA (MFA main subs) = minimize $ expand $ dfa2nfa main
  where
  subs' = Map.fromList [(c, dfa2nfa n) | (c,n) <- subs]
  getSub l = fromJust $ Map.lookup l subs'
  expand (FA (Graph c ns es) s f) 
      = foldl' expandEdge (FA (Graph c ns []) s f) es
  expandEdge fa (f,t,x) = 
      case x of
             Nothing         -> newTransition f t Nothing  fa
             Just (MFASym s) -> newTransition f t (Just s) fa
             Just (MFASub l) -> insertNFA fa (f,t) (expand $ getSub l)

removeUnusedSubLats :: MFA a -> MFA a
removeUnusedSubLats mfa@(MFA main subs) = MFA main [(c,s) | (c,s) <- subs, isUsed c]
  where
  usedMap = subLatUseMap mfa
  used = growUsedSet (usedSubLats main)
  isUsed c = c `Set.member` used
  growUsedSet = fix (\s -> foldl Set.union s $ mapMaybe (flip Map.lookup usedMap) $ Set.toList s)

subLatUseMap :: MFA a -> Map String (Set String)
subLatUseMap (MFA _ subs) = Map.fromList [(c,usedSubLats n) | (c,n) <- subs]

usedSubLats :: DFA (MFALabel a) -> Set String
usedSubLats fa = Set.fromList [s | (_,_,MFASub s) <- transitions fa]

revMultiMap :: (Ord a, Ord b) => Map a (Set b) -> Map b (Set a)
revMultiMap m = Map.fromListWith Set.union [ (y,Set.singleton x) | (x,s) <- Map.toList m, y <- Set.toList s]

-- | Sort sub-networks topologically.
sortSubLats :: MFA a -> MFA a
sortSubLats mfa@(MFA main subs) = MFA main (reverse $ sortLats usedByMap subs)
  where
  usedByMap = revMultiMap (subLatUseMap mfa)
  sortLats _ [] = []
  sortLats ub ls = xs ++ sortLats ub' ys
      where (xs,ys) = partition ((==0) . indeg) ls
            ub' = Map.map (Set.\\ Set.fromList (map fst xs)) ub
            indeg (c,_) = maybe 0 Set.size $ Map.lookup c ub

-- | Convert a strongly regular grammar to a number of finite automata,
--   one for each non-terminal.
--   The edges in the automata accept tokens, or name another automaton to use.
compileAutomata :: CFRules
                 -> [(Cat_,NFA (Symbol Cat_ Token))]
                    -- ^ A map of non-terminals and their automata.
compileAutomata g = [(c, makeOneFA c) | c <- allCats g]
  where
  mrs = mutRecSets g $ mutRecCats True g
  makeOneFA c = make_fa1 mr s [Cat c] f fa 
    where (fa,s,f) = newFA_
          mr = fromJust (Map.lookup c mrs)


-- | The make_fa algorithm from \"Regular approximation of CFLs: a grammatical view\",
--   Mark-Jan Nederhof. International Workshop on Parsing Technologies, 1997,
--   adapted to build a finite automaton for a single (mutually recursive) set only.
--   Categories not in the set (fromJustMap.lookup c mrs)will result in category-labelled edges.
make_fa1 :: MutRecSet -- ^ The set of (mutually recursive) categories for which
                      --   we are building the automaton.
         -> State     -- ^ State to come from
         -> [Symbol Cat_ Token] -- ^ Symbols to accept
         -> State     -- ^ State to end up in
         -> NFA (Symbol Cat_ Token) -- ^ FA to add to.
         -> NFA (Symbol Cat_ Token)
make_fa1 mr q0 alpha q1 fa = 
   case alpha of
        []        -> newTransition q0 q1 Nothing fa
        [t@(Tok _)] -> newTransition q0 q1 (Just t) fa
        [c@(Cat a)] | not (a `Set.member` mrCats mr) -> newTransition q0 q1 (Just c) fa
        [Cat a] ->
            case mrRec mr of
                NotR -> -- the set is a non-recursive (always singleton) set of categories
                        -- so the set of category rules is the set of rules for the whole set
                    make_fas [(q0, b, q1) | CFRule _ b _ <- mrNonRecRules mr] fa
                RightR -> -- the set is right-recursive or cyclic
                    let new = [(getState c, xs, q1) | CFRule c xs _ <- mrNonRecRules mr]
                              ++ [(getState c, xs, getState d) | CFRule c ss _ <- mrRecRules mr, 
                                                                 let (xs,Cat d) = (init ss,last ss)]
                     in make_fas new $ newTransition q0 (getState a) Nothing fa'
                LeftR -> -- the set is left-recursive
                    let new = [(q0, xs, getState c) | CFRule c xs _ <- mrNonRecRules mr]
                              ++ [(getState d, xs, getState c) | CFRule c (Cat d:xs) _ <- mrRecRules mr]
                     in make_fas new $ newTransition (getState a) q1 Nothing fa'
             where
             (fa',stateMap) = addStatesForCats (mrCats mr) fa
             getState x = Map.findWithDefault 
                          (error $ "CFGToFiniteState: No state for " ++ x) 
                          x stateMap
        (x:beta) -> let (fa',q) = newState () fa
                     in make_fas [(q0,[x],q),(q,beta,q1)] fa'
  where
  make_fas xs fa = foldl' (\f' (s1,xs,s2) -> make_fa1 mr s1 xs s2 f') fa xs

mutRecSets :: CFRules -> [Set Cat_] -> MutRecSets
mutRecSets g = Map.fromList . concatMap mkMutRecSet
  where 
  mkMutRecSet cs = [ (c,ms) | c <- csl ]
   where csl = Set.toList cs
         rs = catSetRules g csl
         (nrs,rrs) = partition (ruleIsNonRecursive cs) rs
         ms = MutRecSet {
                         mrCats = cs,
                         mrNonRecRules = nrs,
                         mrRecRules = rrs,
                         mrRec = rec
                        }
         rec | null rrs = NotR
             | all (isRightLinear cs) rrs = RightR
             | otherwise = LeftR

--
-- * Utilities
--

-- | Create a new finite automaton with an initial and a final state.
newFA_ :: Enum n => (FA n () b, n, n)
newFA_ = (fa'', s, f)
    where fa = newFA ()
          s = startState fa
          (fa',f) = newState () fa
          fa'' = addFinalState f fa'

-- | Add a state for the given NFA for each of the categories
--   in the given set. Returns a map of categories to their
--   corresponding states.
addStatesForCats :: Set Cat_ -> NFA t -> (NFA t, Map Cat_ State)
addStatesForCats cs fa = (fa', m)
  where (fa', ns) = newStates (replicate (Set.size cs) ()) fa
        m = Map.fromList (zip (Set.toList cs) (map fst ns))

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
