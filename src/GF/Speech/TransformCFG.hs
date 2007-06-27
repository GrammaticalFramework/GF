----------------------------------------------------------------------
-- |
-- Module      : TransformCFG
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/01 20:09:04 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.24 $
--
--  This module does some useful transformations on CFGs.
--
-- peb thinks: most of this module should be moved to GF.Conversion...
-----------------------------------------------------------------------------

module GF.Speech.TransformCFG where

import GF.Canon.CanonToGFCC (mkCanon2gfcc)
import qualified GF.Canon.GFCC.AbsGFCC as C
import GF.Canon.GFCC.DataGFCC (GFCC, mkGFCC, lookType)
import GF.Conversion.Types
import GF.CF.PPrCF (prCFCat)
import GF.Data.Utilities
import GF.Formalism.CFG 
import GF.Formalism.Utilities (Symbol(..), mapSymbol, filterCats, symbol, 
			       NameProfile(..), Profile(..), name2fun, forestName)
import GF.Infra.Ident
import GF.Infra.Option
import GF.Infra.Print
import GF.Speech.Relation
import GF.Compile.ShellState (StateGrammar, stateCFG, stateGrammarST, startCatStateOpts, stateOptions)

import Control.Monad
import Control.Monad.State (State, get, put, evalState)
import Data.Map (Map)
import qualified Data.Map as Map
import Data.List
import Data.Maybe (fromMaybe)
import Data.Monoid (mconcat)
import Data.Set (Set)
import qualified Data.Set as Set

-- not very nice to replace the structured CFCat type with a simple string
type CFRule_ = CFRule Cat_ CFTerm Token

data CFTerm
    = CFObj Fun [CFTerm] -- ^ an abstract syntax function with arguments
    | CFAbs Int CFTerm -- ^ A lambda abstraction. The Int is the variable id.
    | CFApp CFTerm CFTerm -- ^ Application
    | CFRes Int -- ^ The result of the n:th (0-based) non-terminal
    | CFVar Int -- ^ A lambda-bound variable
    | CFMeta String -- ^ A metavariable
  deriving (Eq,Ord,Show)

type Cat_ = String
type CFSymbol_ = Symbol Cat_ Token

type CFRules = [(Cat_,[CFRule_])]


cfgToCFRules :: StateGrammar -> CFRules
cfgToCFRules s = 
    groupProds [CFRule (catToString c) (map symb r) (nameToTerm n) 
                    | CFRule c r n <- cfg]
    where cfg = stateCFG s
          symb = mapSymbol catToString id
	  catToString = prt
          gfcc = stateGFCC s
          nameToTerm (Name IW [Unify [n]]) = CFRes n
          nameToTerm (Name f@(IC c) prs) = 
              CFObj f (zipWith profileToTerm args prs)
            where C.Typ args _ = lookType gfcc (C.CId c)
          nameToTerm n = error $ "cfgToCFRules.nameToTerm" ++ show n
          profileToTerm (C.CId t) (Unify []) = CFMeta t
          profileToTerm _ (Unify xs) = CFRes (last xs) -- FIXME: unify
          profileToTerm (C.CId t) (Constant f) = maybe (CFMeta t) (\x -> CFObj x []) (forestName f)

getStartCat :: Options -> StateGrammar -> String
getStartCat opts sgr = prCFCat (startCatStateOpts opts' sgr)
  where opts' = addOptions opts (stateOptions sgr)

getStartCatCF :: Options -> StateGrammar -> String
getStartCatCF opts sgr = getStartCat opts sgr ++ "{}.s"

stateGFCC :: StateGrammar -> GFCC
stateGFCC = mkGFCC . mkCanon2gfcc . stateGrammarST

-- * Grammar filtering

-- | Removes all directly and indirectly cyclic productions.
--   FIXME: this may be too aggressive, only one production
--   needs to be removed to break a given cycle. But which
--   one should we pick?
--   FIXME: Does not (yet) remove productions which are cyclic
--   because of empty productions.
removeCycles :: CFRules -> CFRules 
removeCycles = groupProds . f . ungroupProds
  where f rs = filter (not . isCycle) rs
          where alias = transitiveClosure $ mkRel [(c,c') | CFRule c [Cat c'] _ <- rs]
                isCycle (CFRule c [Cat c'] _) = isRelatedTo alias c' c
                isCycle _ = False

-- | Removes productions which use categories which have no productions.
-- Only does one pass through the grammar.
bottomUpFilter_old :: CFRules -> CFRules
bottomUpFilter_old rs = k'
	where
	keep = filter (not . null . snd) rs
	allCats = nub [c | (_,r) <- rs, CFRule _ rhs _ <- r, Cat c <- rhs]
	emptyCats = filter (nothingOrNull . flip lookup rs) allCats
	k' = map (\ (c,xs) -> (c, filter (not . anyUsedBy emptyCats) xs)) keep

-- | Better bottom-up filter that also removes categories which contain no finite
-- strings.
bottomUpFilter :: CFRules -> CFRules
bottomUpFilter gr = fix grow []
  where grow g = g `unionCFRules` filterCFRules (all (okSym g) . ruleRhs) gr
        okSym g = symbol (`elem` allCats g) (const True)

-- | Removes categories which are not reachable from the start category.
-- Only does one pass through the grammar.
topDownFilter :: Cat_ -> CFRules -> CFRules
topDownFilter start rules = filter ((`Set.member` keep) . fst) rules
  where
    rhsCats = [ (c, c') | (c,rs) <- rules, r <- rs, c' <- filterCats (ruleRhs r) ]
    uses = reflexiveClosure_ (allCats rules) $ transitiveClosure $ mkRel rhsCats
    keep = allRelated uses start

-- | Merges categories with identical right-hand-sides.
-- FIXME: handle probabilities
mergeIdentical :: CFRules -> CFRules
mergeIdentical g = sortNubBy (compareBy fst) [(substCat c, map subst rs) | (c,rs) <- g]
  where
    -- maps categories to their replacement
    m = Map.fromList [(y,concat (intersperse "+" xs)) | (_,xs) <- buildMultiMap [(rulesKey rs,c) | (c,rs) <- g], y <- xs]
    -- build data to compare for each category: a set of name,rhs pairs
    rulesKey rs = Set.fromList [(n,r) | CFRule _ r n <- rs]
    subst (CFRule c r n) = CFRule (substCat c) (map (mapSymbol substCat id) r) n
    substCat c = Map.findWithDefault (error $ "mergeIdentical: " ++ c) c m

-- * Removing left recursion

-- The LC_LR algorithm from
-- http://research.microsoft.com/users/bobmoore/naacl2k-proc-rev.pdf
removeLeftRecursion :: Cat_ -> CFRules -> CFRules
removeLeftRecursion start gr 
    = groupProds $ concat [scheme1, scheme2, scheme3, scheme4]
  where
    scheme1 = [CFRule a [x,Cat a_x] n' | 
               a <- retainedLeftRecursive, 
               x <- properLeftCornersOf a,
               not (isLeftRecursive x),
               let a_x = mkCat (Cat a) x,
               -- this is an extension of LC_LR to avoid generating
               -- A-X categories for which there are no productions:
               a_x `Set.member` newCats,
               let n' = symbol (\_ -> CFApp (CFRes 1) (CFRes 0))
                               (\_ -> CFRes 0) x] 
    scheme2 = [CFRule a_x (beta++[Cat a_b]) n' | 
               a <- retainedLeftRecursive, 
               b@(Cat b') <- properLeftCornersOf a,
               isLeftRecursive b,
               CFRule _ (x:beta) n <- catRules gr b', 
               let a_x = mkCat (Cat a) x,
               let a_b = mkCat (Cat a) b,
               let i = length $ filterCats beta,
               let n' = symbol (\_ -> CFAbs 1 (CFApp (CFRes i) (shiftTerm n)))
                               (\_ -> CFApp (CFRes i) n) x]
    scheme3 = [CFRule a_x beta n' |
               a <- retainedLeftRecursive, 
               x <- properLeftCornersOf a,
               CFRule _ (x':beta) n <- catRules gr a,
               x == x',
               let a_x = mkCat (Cat a) x,
               let n' = symbol (\_ -> CFAbs 1 (shiftTerm n)) 
                               (\_ -> n) x]
    scheme4 = catSetRules gr $ Set.fromList $ filter (not . isLeftRecursive . Cat) cats

    newCats = Set.fromList (map lhsCat (scheme2 ++ scheme3))

    shiftTerm :: CFTerm -> CFTerm
    shiftTerm (CFObj f ts) = CFObj f (map shiftTerm ts)
    shiftTerm (CFRes 0) = CFVar 1
    shiftTerm (CFRes n) = CFRes (n-1)
    shiftTerm t = t
    -- note: the rest don't occur in the original grammar

    cats = allCats gr
    rules = ungroupProds gr

    directLeftCorner = mkRel' [(Cat s,[t | CFRule _ (t:_) _ <- rs]) | (s,rs) <- gr]
    leftCorner = reflexiveClosure_ (map Cat cats) $ transitiveClosure directLeftCorner
    properLeftCorner = transitiveClosure directLeftCorner
    properLeftCornersOf = Set.toList . allRelated properLeftCorner . Cat
    isProperLeftCornerOf = flip (isRelatedTo properLeftCorner)

    leftRecursive = reflexiveElements properLeftCorner
    isLeftRecursive = (`Set.member` leftRecursive)

    retained = start `Set.insert`
                Set.fromList [a | (c,rs) <- gr, not (isLeftRecursive (Cat c)), 
                                   r <- rs, Cat a <- ruleRhs r]
    isRetained = (`Set.member` retained)

    retainedLeftRecursive = filter (isLeftRecursive . Cat) $ Set.toList retained

mkCat :: CFSymbol_ -> CFSymbol_ -> Cat_
mkCat x y = showSymbol x ++ "-" ++ showSymbol y
  where showSymbol = symbol id show

{-

-- Paull's algorithm, see
-- http://research.microsoft.com/users/bobmoore/naacl2k-proc-rev.pdf
removeLeftRecursion :: Cat_ -> CFRules -> CFRules
removeLeftRecursion start rs = removeDirectLeftRecursions $ map handleProds rs
    where 
    handleProds (c, r) = (c, concatMap handleProd r)
    handleProd (CFRule ai (Cat aj:alpha) n) | aj < ai  =
              -- FIXME: for non-recursive categories, this changes
	      -- the grammar unneccessarily, maybe we can use mutRecCats
	      -- to make this less invasive
              -- FIXME: this will give multiple rules with the same name,
	      -- which may mess up the probabilities.
             [CFRule ai (beta ++ alpha) n | CFRule _ beta _ <- lookup' aj rs]
    handleProd r = [r]

removeDirectLeftRecursions :: CFRules -> CFRules
removeDirectLeftRecursions = concat . flip evalState 0 . mapM removeDirectLeftRecursion

removeDirectLeftRecursion :: (Cat_,[CFRule_]) -- ^ All productions for a category
			  -> State Int CFRules
removeDirectLeftRecursion (a,rs) 
    | null dr = return [(a,rs)]
    | otherwise = 
        do
        a' <- fresh a
        let as = maybeEndWithA' nr
            is = [CFRule a' (tail r) n | CFRule _ r n <- dr]
            a's = maybeEndWithA' is
            -- the not null constraint here avoids creating new 
            -- left recursive (cyclic) rules.
            maybeEndWithA' xs = xs ++ [CFRule c (r++[Cat a']) n | CFRule c r n <- xs, 
                                                                  not (null r)] 
        return [(a, as), (a', a's)]
    where 
    (dr,nr) = partition isDirectLeftRecursive rs
    fresh x = do { n <- get; put (n+1); return $ x ++ "-" ++ show n }

isDirectLeftRecursive :: CFRule_ -> Bool
isDirectLeftRecursive (CFRule c (Cat c':_) _) = c == c'
isDirectLeftRecursive _ = False

-}

-- | Get the sets of mutually recursive non-terminals for a grammar.
mutRecCats :: Bool    -- ^ If true, all categories will be in some set.
                      --   If false, only recursive categories will be included.
           -> CFRules -> [Set Cat_]
mutRecCats incAll g = equivalenceClasses $ refl $ symmetricSubrelation $ transitiveClosure r
  where r = mkRel [(c,c') | (_,rs) <- g, CFRule c ss _ <- rs, Cat c' <- ss]
        allCats = map fst g
        refl = if incAll then reflexiveClosure_ allCats else reflexiveSubrelation

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
                  rs = catSetRules g cs
                  handleCat c = [CFRule c' [] (mkCFTerm (c++"-empty"))] -- introduce A' -> e
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

--
-- * CFG rule utilities
--

-- | Group productions by their lhs categories
groupProds :: [CFRule_] -> CFRules
groupProds = buildMultiMap . map (\r -> (lhsCat r,r))

ungroupProds :: CFRules -> [CFRule_]
ungroupProds = concat . map snd

allCats :: CFRules -> [Cat_]
allCats = map fst

catRules :: CFRules -> Cat_ -> [CFRule_]
catRules rs c = fromMaybe [] (lookup c rs)

catSetRules :: CFRules -> Set Cat_ -> [CFRule_]
catSetRules g cs = concat [rs | (c,rs) <- g, c `Set.member` cs]

unionCFRules :: CFRules -> CFRules -> CFRules
unionCFRules x y = Map.toList $ Map.map Set.toList $ Map.unionWith Set.union (fromCFRules x) (fromCFRules y)
  where 
    fromCFRules :: CFRules -> Map Cat_ (Set CFRule_)
    fromCFRules g = Map.fromListWith Set.union [(c, Set.fromList rs) | (c,rs) <- g]

filterCFRules :: (CFRule_ -> Bool) -> CFRules -> CFRules
filterCFRules p gr = [(c,rs') | (c,rs) <- gr, let rs' = filter p rs, not (null rs')]

lhsCat :: CFRule c n t -> c
lhsCat (CFRule c _ _) = c

ruleRhs :: CFRule c n t ->  [Symbol c t]
ruleRhs (CFRule _ ss _) = ss

ruleFun :: CFRule_ -> Fun
ruleFun (CFRule _ _ t) = f t
  where f (CFObj n _) = n
        f (CFApp _ x) = f x
        f (CFAbs _ x) = f x
        f _ = IC ""

-- | Checks if a symbol is a non-terminal of one of the given categories.
catElem :: Ord c => Symbol c t -> Set c -> Bool
catElem s cs = symbol (`Set.member` cs) (const False) s

-- | Check if any of the categories used on the right-hand side
--   are in the given list of categories.
anyUsedBy :: Eq c => [c] -> CFRule c n t -> Bool
anyUsedBy cs (CFRule _ ss _) = any (`elem` cs) (filterCats ss)

mkCFTerm :: String -> CFTerm
mkCFTerm n = CFObj (IC n) []

ruleIsNonRecursive :: Ord c => Set c -> CFRule c n t -> Bool
ruleIsNonRecursive cs = noCatsInSet cs . ruleRhs

noCatsInSet :: Ord c => Set c -> [Symbol c t] -> Bool
noCatsInSet cs = not . any (`catElem` cs)

-- | Check if all the rules are right-linear, or all the rules are
--   left-linear, with respect to given categories.
allXLinear :: Ord c => Set c -> [CFRule c n t] -> Bool
allXLinear cs rs = all (isRightLinear cs) rs || all (isLeftLinear cs) rs

-- | Checks if a context-free rule is right-linear.
isRightLinear :: Ord c => 
                 Set c  -- ^ The categories to consider
              -> CFRule c n t   -- ^ The rule to check for right-linearity
              -> Bool
isRightLinear cs = noCatsInSet cs . safeInit . ruleRhs

-- | Checks if a context-free rule is left-linear.
isLeftLinear :: Ord c => 
                Set c  -- ^ The categories to consider
             -> CFRule c n t   -- ^ The rule to check for left-linearity
             -> Bool
isLeftLinear cs = noCatsInSet cs . drop 1 . ruleRhs
