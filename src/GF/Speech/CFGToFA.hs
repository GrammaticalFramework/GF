----------------------------------------------------------------------
-- |
-- Module      : GF.Speech.CFGToFA
--
-- Approximates CFGs with finite state networks.
----------------------------------------------------------------------
module GF.Speech.CFGToFA (cfgToFA, makeSimpleRegular,
                          MFA(..), cfgToMFA, cfgToFA') where

import Data.List
import Data.Maybe
import Data.Map (Map)
import qualified Data.Map as Map
import Data.Set (Set)
import qualified Data.Set as Set

import PGF.CId
import PGF.Data
import GF.Data.Utilities
import GF.Speech.CFG
import GF.Speech.PGFToCFG
import GF.Infra.Ident (Ident)

import GF.Speech.FiniteState
import GF.Speech.Graph
import GF.Speech.Relation
import GF.Speech.CFG

data Recursivity = RightR | LeftR | NotR

data MutRecSet = MutRecSet {
                            mrCats :: Set Cat,
                            mrNonRecRules :: [CFRule],
                            mrRecRules :: [CFRule],
                            mrRec :: Recursivity
                           }


type MutRecSets = Map Cat MutRecSet

--
-- * Multiple DFA type
--

data MFA = MFA Cat [(Cat,DFA CFSymbol)]



cfgToFA :: CFG -> DFA Token
cfgToFA = minimize . compileAutomaton . makeSimpleRegular


--
-- * Compile strongly regular grammars to NFAs
--

-- Convert a strongly regular grammar to a finite automaton.
compileAutomaton :: CFG -> NFA Token
compileAutomaton g = make_fa (g,ns) s [NonTerminal (cfgStartCat g)] f fa
  where 
  (fa,s,f) = newFA_
  ns = mutRecSets g $ mutRecCats False g

-- | The make_fa algorithm from \"Regular approximation of CFLs: a grammatical view\",
--   Mark-Jan Nederhof, Advances in Probabilistic and other Parsing Technologies, 2000.
make_fa :: (CFG,MutRecSets) -> State -> [CFSymbol] -> State 
          -> NFA Token -> NFA Token
make_fa c@(g,ns) q0 alpha q1 fa = 
   case alpha of
        []              -> newTransition q0 q1 Nothing fa
        [Terminal t]    -> newTransition q0 q1 (Just t) fa
        [NonTerminal a] -> 
            case Map.lookup a ns of
              -- a is recursive
              Just n@(MutRecSet { mrCats = ni, mrNonRecRules = nrs, mrRecRules = rs} ) -> 
                  case mrRec n of
                    -- the set Ni is right-recursive or cyclic
                    RightR ->
                        let new = [(getState c, xs, q1) | CFRule c xs _ <- nrs]
                                  ++ [(getState c, xs, getState d) | CFRule c ss _ <- rs, 
                                       let (xs,NonTerminal d) = (init ss,last ss)]
                         in make_fas new $ newTransition q0 (getState a) Nothing fa'
                    -- the set Ni is left-recursive                         
                    LeftR ->
                        let new = [(q0, xs, getState c) | CFRule c xs _ <- nrs]
                                  ++ [(getState d, xs, getState c) | CFRule c (NonTerminal d:xs) _ <- rs]
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

cfgToMFA :: CFG -> MFA
cfgToMFA  = buildMFA . makeSimpleRegular

-- | Build a DFA by building and expanding an MFA
cfgToFA' :: CFG -> DFA Token
cfgToFA' = mfaToDFA . cfgToMFA

buildMFA :: CFG -> MFA
buildMFA g = sortSubLats $ removeUnusedSubLats mfa
  where fas = compileAutomata g
        mfa = MFA (cfgStartCat g) [(c, minimize fa) | (c,fa) <- fas]

mfaStartDFA :: MFA -> DFA CFSymbol
mfaStartDFA (MFA start subs) = 
    fromMaybe (error $ "Bad start MFA: " ++ start) $ lookup start subs

mfaToDFA :: MFA -> DFA Token
mfaToDFA mfa@(MFA _ subs) = minimize $ expand $ dfa2nfa $ mfaStartDFA mfa
  where
  subs' = Map.fromList [(c, dfa2nfa n) | (c,n) <- subs]
  getSub l = fromJust $ Map.lookup l subs'
  expand (FA (Graph c ns es) s f) 
      = foldl' expandEdge (FA (Graph c ns []) s f) es
  expandEdge fa (f,t,x) = 
      case x of
        Nothing              -> newTransition f t Nothing  fa
        Just (Terminal s)    -> newTransition f t (Just s) fa
        Just (NonTerminal l) -> insertNFA fa (f,t) (expand $ getSub l)

removeUnusedSubLats :: MFA -> MFA
removeUnusedSubLats mfa@(MFA start subs) = MFA start [(c,s) | (c,s) <- subs, isUsed c]
  where
  usedMap = subLatUseMap mfa
  used = growUsedSet (Set.singleton start)
  isUsed c = c `Set.member` used
  growUsedSet = fix (\s -> foldl Set.union s $ mapMaybe (flip Map.lookup usedMap) $ Set.toList s)

subLatUseMap :: MFA -> Map Cat (Set Cat)
subLatUseMap (MFA _ subs) = Map.fromList [(c,usedSubLats n) | (c,n) <- subs]

usedSubLats :: DFA CFSymbol -> Set Cat
usedSubLats fa = Set.fromList [s | (_,_,NonTerminal s) <- transitions fa]

-- | Sort sub-networks topologically.
sortSubLats :: MFA -> MFA
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
compileAutomata :: CFG
                 -> [(Cat,NFA CFSymbol)]
                    -- ^ A map of non-terminals and their automata.
compileAutomata g = [(c, makeOneFA c) | c <- allCats g]
  where
  mrs = mutRecSets g $ mutRecCats True g
  makeOneFA c = make_fa1 mr s [NonTerminal c] f fa 
    where (fa,s,f) = newFA_
          mr = fromJust (Map.lookup c mrs)


-- | The make_fa algorithm from \"Regular approximation of CFLs: a grammatical view\",
--   Mark-Jan Nederhof, Advances in Probabilistic and other Parsing Technologies, 2000,
--   adapted to build a finite automaton for a single (mutually recursive) set only.
--   Categories not in the set will result in category-labelled edges.
make_fa1 :: MutRecSet -- ^ The set of (mutually recursive) categories for which
                      --   we are building the automaton.
         -> State     -- ^ State to come from
         -> [CFSymbol] -- ^ Symbols to accept
         -> State     -- ^ State to end up in
         -> NFA CFSymbol -- ^ FA to add to.
         -> NFA CFSymbol
make_fa1 mr q0 alpha q1 fa = 
   case alpha of
        []        -> newTransition q0 q1 Nothing fa
        [t@(Terminal _)] -> newTransition q0 q1 (Just t) fa
        [c@(NonTerminal a)] | not (a `Set.member` mrCats mr) -> newTransition q0 q1 (Just c) fa
        [NonTerminal a] ->
            case mrRec mr of
                NotR -> -- the set is a non-recursive (always singleton) set of categories
                        -- so the set of category rules is the set of rules for the whole set
                    make_fas [(q0, b, q1) | CFRule _ b _ <- mrNonRecRules mr] fa
                RightR -> -- the set is right-recursive or cyclic
                    let new = [(getState c, xs, q1) | CFRule c xs _ <- mrNonRecRules mr]
                              ++ [(getState c, xs, getState d) | CFRule c ss _ <- mrRecRules mr, 
                                                                 let (xs,NonTerminal d) = (init ss,last ss)]
                     in make_fas new $ newTransition q0 (getState a) Nothing fa'
                LeftR -> -- the set is left-recursive
                    let new = [(q0, xs, getState c) | CFRule c xs _ <- mrNonRecRules mr]
                              ++ [(getState d, xs, getState c) | CFRule c (NonTerminal d:xs) _ <- mrRecRules mr]
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

mutRecSets :: CFG -> [Set Cat] -> MutRecSets
mutRecSets g = Map.fromList . concatMap mkMutRecSet
  where 
  mkMutRecSet cs = [ (c,ms) | c <- csl ]
   where csl = Set.toList cs
         rs = catSetRules g cs
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

-- | Add a state for the given NFA for each of the categories
--   in the given set. Returns a map of categories to their
--   corresponding states.
addStatesForCats :: Set Cat -> NFA t -> (NFA t, Map Cat State)
addStatesForCats cs fa = (fa', m)
  where (fa', ns) = newStates (replicate (Set.size cs) ()) fa
        m = Map.fromList (zip (Set.toList cs) (map fst ns))

revMultiMap :: (Ord a, Ord b) => Map a (Set b) -> Map b (Set a)
revMultiMap m = Map.fromListWith Set.union [ (y,Set.singleton x) | (x,s) <- Map.toList m, y <- Set.toList s]
