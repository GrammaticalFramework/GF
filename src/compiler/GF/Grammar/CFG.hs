----------------------------------------------------------------------
-- |
-- Module      : GF.Grammar.CFG
--
-- Context-free grammar representation and manipulation.
----------------------------------------------------------------------
module GF.Grammar.CFG where

import GF.Data.Utilities
import PGF
import GF.Data.Relation

import Data.Map (Map)
import qualified Data.Map as Map
import Data.List
import Data.Set (Set)
import qualified Data.Set as Set

--
-- * Types
--

type Cat = String

data Symbol c t = NonTerminal c | Terminal t
  deriving (Eq, Ord, Show)

data Rule c t = Rule { 
      ruleLhs  :: c,
      ruleRhs  :: [Symbol c t],
      ruleName :: CFTerm 
    }
  deriving (Eq, Ord, Show)

data Grammar c t = Grammar { 
      cfgStartCat     :: c,
      cfgExternalCats :: Set c,
      cfgRules        :: Map c (Set (Rule c t)) }
  deriving (Eq, Ord, Show)

data CFTerm
    = CFObj CId [CFTerm] -- ^ an abstract syntax function with arguments
    | CFAbs Int CFTerm -- ^ A lambda abstraction. The Int is the variable id.
    | CFApp CFTerm CFTerm -- ^ Application
    | CFRes Int -- ^ The result of the n:th (0-based) non-terminal
    | CFVar Int -- ^ A lambda-bound variable
    | CFMeta CId -- ^ A metavariable
  deriving (Eq, Ord, Show)

type CFSymbol = Symbol  Cat Token
type CFRule   = Rule    Cat Token
type CFG      = Grammar Cat Token

type Param         = Int
type ParamCFSymbol = Symbol (Cat,[Param]) Token
type ParamCFRule   = Rule    (Cat,[Param]) Token
type ParamCFG      = Grammar (Cat,[Param]) Token

--
-- * Grammar filtering
--

-- | Removes all directly and indirectly cyclic productions.
--   FIXME: this may be too aggressive, only one production
--   needs to be removed to break a given cycle. But which
--   one should we pick?
--   FIXME: Does not (yet) remove productions which are cyclic
--   because of empty productions.
removeCycles :: (Ord c,Ord t) => Grammar c t -> Grammar c t
removeCycles = onRules f
  where f rs = filter (not . isCycle) rs
          where alias = transitiveClosure $ mkRel [(c,c') | Rule c [NonTerminal c'] _ <- rs]
                isCycle (Rule c [NonTerminal c'] _) = isRelatedTo alias c' c
                isCycle _ = False

-- | Better bottom-up filter that also removes categories which contain no finite
-- strings.
bottomUpFilter :: (Ord c,Ord t) => Grammar c t -> Grammar c t
bottomUpFilter gr = fix grow (gr { cfgRules = Map.empty })
  where grow g = g `unionCFG` filterCFG (all (okSym g) . ruleRhs) gr
        okSym g = symbol (`elem` allCats g) (const True)

-- | Removes categories which are not reachable from any external category.
topDownFilter :: (Ord c,Ord t) => Grammar c t -> Grammar c t
topDownFilter cfg = filterCFGCats (`Set.member` keep) cfg
  where
    rhsCats = [ (ruleLhs r, c') | r <- allRules cfg, c' <- filterCats (ruleRhs r) ]
    uses = reflexiveClosure_ (allCats cfg) $ transitiveClosure $ mkRel rhsCats
    keep = Set.unions $ map (allRelated uses) $ Set.toList $ cfgExternalCats cfg

-- | Merges categories with identical right-hand-sides.
-- FIXME: handle probabilities
mergeIdentical :: CFG -> CFG
mergeIdentical g = onRules (map subst) g
  where
    -- maps categories to their replacement
    m = Map.fromList [(y,concat (intersperse "+" xs)) 
                          | (_,xs) <- buildMultiMap [(rulesKey rs,c) | (c,rs) <- Map.toList (cfgRules g)], y <- xs]
    -- build data to compare for each category: a set of name,rhs pairs
    rulesKey = Set.map (\ (Rule _ r n) -> (n,r))
    subst (Rule c r n) = Rule (substCat c) (map (mapSymbol substCat id) r) n
    substCat c = Map.findWithDefault (error $ "mergeIdentical: " ++ c) c m

-- | Keeps only the start category as an external category.
purgeExternalCats :: Grammar c t -> Grammar c t
purgeExternalCats cfg = cfg { cfgExternalCats = Set.singleton (cfgStartCat cfg) }

--
-- * Removing left recursion
--

-- The LC_LR algorithm from
-- http://research.microsoft.com/users/bobmoore/naacl2k-proc-rev.pdf
removeLeftRecursion :: CFG -> CFG
removeLeftRecursion gr 
    = gr { cfgRules = groupProds $ concat [scheme1, scheme2, scheme3, scheme4] }
  where
    scheme1 = [Rule a [x,NonTerminal a_x] n' | 
               a <- retainedLeftRecursive, 
               x <- properLeftCornersOf a,
               not (isLeftRecursive x),
               let a_x = mkCat (NonTerminal a) x,
               -- this is an extension of LC_LR to avoid generating
               -- A-X categories for which there are no productions:
               a_x `Set.member` newCats,
               let n' = symbol (\_ -> CFApp (CFRes 1) (CFRes 0))
                               (\_ -> CFRes 0) x] 
    scheme2 = [Rule a_x (beta++[NonTerminal a_b]) n' | 
               a <- retainedLeftRecursive, 
               b@(NonTerminal b') <- properLeftCornersOf a,
               isLeftRecursive b,
               Rule _ (x:beta) n <- catRules gr b', 
               let a_x = mkCat (NonTerminal a) x,
               let a_b = mkCat (NonTerminal a) b,
               let i = length $ filterCats beta,
               let n' = symbol (\_ -> CFAbs 1 (CFApp (CFRes i) (shiftTerm n)))
                               (\_ -> CFApp (CFRes i) n) x]
    scheme3 = [Rule a_x beta n' |
               a <- retainedLeftRecursive, 
               x <- properLeftCornersOf a,
               Rule _ (x':beta) n <- catRules gr a,
               x == x',
               let a_x = mkCat (NonTerminal a) x,
               let n' = symbol (\_ -> CFAbs 1 (shiftTerm n)) 
                               (\_ -> n) x]
    scheme4 = catSetRules gr $ Set.fromList $ filter (not . isLeftRecursive . NonTerminal) cats

    newCats = Set.fromList (map ruleLhs (scheme2 ++ scheme3))

    shiftTerm :: CFTerm -> CFTerm
    shiftTerm (CFObj f ts) = CFObj f (map shiftTerm ts)
    shiftTerm (CFRes 0) = CFVar 1
    shiftTerm (CFRes n) = CFRes (n-1)
    shiftTerm t = t
    -- note: the rest don't occur in the original grammar

    cats = allCats gr
--  rules = allRules gr

    directLeftCorner = mkRel [(NonTerminal c,t) | Rule c (t:_) _ <- allRules gr]
--  leftCorner = reflexiveClosure_ (map NonTerminal cats) $ transitiveClosure directLeftCorner
    properLeftCorner = transitiveClosure directLeftCorner
    properLeftCornersOf = Set.toList . allRelated properLeftCorner . NonTerminal
--  isProperLeftCornerOf = flip (isRelatedTo properLeftCorner)

    leftRecursive = reflexiveElements properLeftCorner
    isLeftRecursive = (`Set.member` leftRecursive)

    retained = cfgStartCat gr `Set.insert`
                Set.fromList [a | r <- allRules (filterCFGCats (not . isLeftRecursive . NonTerminal) gr),
                                  NonTerminal a <- ruleRhs r]
--  isRetained = (`Set.member` retained)

    retainedLeftRecursive = filter (isLeftRecursive . NonTerminal) $ Set.toList retained

    mkCat :: CFSymbol -> CFSymbol -> Cat
    mkCat x y = showSymbol x ++ "-" ++ showSymbol y
        where showSymbol = symbol id show

-- | Get the sets of mutually recursive non-terminals for a grammar.
mutRecCats :: Ord c
           => Bool    -- ^ If true, all categories will be in some set.
                      --   If false, only recursive categories will be included.
           -> Grammar c t -> [Set c]
mutRecCats incAll g = equivalenceClasses $ refl $ symmetricSubrelation $ transitiveClosure r
  where r = mkRel [(c,c') | Rule c ss _ <- allRules g, NonTerminal c' <- ss]
        refl = if incAll then reflexiveClosure_ (allCats g) else reflexiveSubrelation

--
-- * Approximate context-free grammars with regular grammars.
--

makeSimpleRegular :: CFG -> CFG
makeSimpleRegular = makeRegular . topDownFilter . bottomUpFilter . removeCycles

-- Use the transformation algorithm from \"Regular Approximation of Context-free
-- Grammars through Approximation\", Mohri and Nederhof, 2000
-- to create an over-generating regular grammar for a context-free 
-- grammar
makeRegular :: CFG -> CFG
makeRegular g = g { cfgRules = groupProds $ concatMap trSet (mutRecCats True g) }
  where trSet cs | allXLinear cs rs = rs
                 | otherwise = concatMap handleCat (Set.toList cs)
            where rs = catSetRules g cs
                  handleCat c = [Rule c' [] (mkCFTerm (c++"-empty"))] -- introduce A' -> e
                                ++ concatMap (makeRightLinearRules c) (catRules g c)
                      where c' = newCat c
                  makeRightLinearRules b' (Rule c ss n) = 
                      case ys of
                              [] -> newRule b' (xs ++ [NonTerminal (newCat c)]) n -- no non-terminals left
                              (NonTerminal b:zs) -> newRule b' (xs ++ [NonTerminal b]) n 
                                        ++ makeRightLinearRules (newCat b) (Rule c zs n)
                      where (xs,ys) = break (`catElem` cs) ss
                            -- don't add rules on the form A -> A
                            newRule c rhs n | rhs == [NonTerminal c] = []
                                            | otherwise = [Rule c rhs n]
        newCat c = c ++ "$"

--
-- * CFG Utilities
--

mkCFG :: (Ord c,Ord t) => c -> Set c -> [Rule c t] -> Grammar c t
mkCFG start ext rs = Grammar { cfgStartCat = start, cfgExternalCats = ext, cfgRules = groupProds rs }

groupProds :: (Ord c,Ord t) => [Rule c t] -> Map c (Set (Rule c t))
groupProds = Map.fromListWith Set.union . map (\r -> (ruleLhs r,Set.singleton r))

uniqueFuns :: [Rule c t] -> [Rule c t]
uniqueFuns = snd . mapAccumL uniqueFun Set.empty
  where
    uniqueFun funs (Rule cat items (CFObj fun args)) = (Set.insert fun' funs,Rule cat items (CFObj fun' args))
      where
        fun' = head [fun'|suffix<-"":map show ([2..]::[Int]),
                          let fun'=mkCId (showCId fun++suffix),
                          not (fun' `Set.member` funs)]

-- | Gets all rules in a CFG.
allRules :: Grammar c t -> [Rule c t]
allRules = concatMap Set.toList . Map.elems . cfgRules

-- | Gets all rules in a CFG, grouped by their LHS categories.
allRulesGrouped :: Grammar c t -> [(c,[Rule c t])]
allRulesGrouped = Map.toList . Map.map Set.toList . cfgRules

-- | Gets all categories which have rules.
allCats :: Grammar c t -> [c]
allCats = Map.keys . cfgRules

-- | Gets all categories which have rules or occur in a RHS.
allCats' :: (Ord c,Ord t) => Grammar c t -> [c]
allCats' cfg = Set.toList (Map.keysSet (cfgRules cfg) `Set.union` 
                           Set.fromList [c | rs <- Map.elems (cfgRules cfg), 
                                             r  <- Set.toList rs, 
                                             NonTerminal c <- ruleRhs r])

-- | Gets all rules for the given category.
catRules :: Ord c => Grammar c t -> c -> [Rule c t]
catRules gr c = Set.toList $ Map.findWithDefault Set.empty c (cfgRules gr)

-- | Gets all rules for categories in the given set.
catSetRules :: CFG -> Set Cat -> [CFRule]
catSetRules gr cs = allRules $ filterCFGCats (`Set.member` cs) gr

mapCFGCats :: (Ord c,Ord c',Ord t) => (c -> c') -> Grammar c t -> Grammar c' t
mapCFGCats f cfg = Grammar (f (cfgStartCat cfg)) 
                           (Set.map f (cfgExternalCats cfg))
                           (groupProds [Rule (f lhs) (map (mapSymbol f id) rhs) t | Rule lhs rhs t <- allRules cfg])

onRules :: (Ord c,Ord t) => ([Rule c t] -> [Rule c t]) -> Grammar c t -> Grammar c t
onRules f cfg = cfg { cfgRules = groupProds $ f $ allRules cfg }

-- | Clean up CFG after rules have been removed.
cleanCFG :: Ord c => Grammar c t -> Grammar c t
cleanCFG cfg = cfg{ cfgRules = Map.filter (not . Set.null) (cfgRules cfg) }

-- | Combine two CFGs.
unionCFG :: (Ord c,Ord t) => Grammar c t -> Grammar c t -> Grammar c t
unionCFG x y = x { cfgRules = Map.unionWith Set.union (cfgRules x) (cfgRules y) }

filterCFG :: (Rule c t -> Bool) -> Grammar c t -> Grammar c t
filterCFG p cfg = cfg { cfgRules = Map.mapMaybe filterRules (cfgRules cfg) }
  where
    filterRules rules = 
      let rules' = Set.filter p rules
      in if Set.null rules' then Nothing else Just rules'

filterCFGCats :: (c -> Bool) -> Grammar c t -> Grammar c t
filterCFGCats p cfg = cfg { cfgRules = Map.filterWithKey (\c _ -> p c) (cfgRules cfg) }

countCats :: Ord c => Grammar c t -> Int
countCats = Map.size . cfgRules . cleanCFG

countRules :: Grammar c t -> Int
countRules = length . allRules

prCFG :: CFG -> String
prCFG = prProductions . map prRule . allRules
    where 
      prRule r = (ruleLhs r, unwords (map prSym (ruleRhs r)))
      prSym = symbol id (\t -> "\""++ t ++"\"")

prProductions :: [(Cat,String)] -> String
prProductions prods = 
    unlines [rpad maxLHSWidth lhs ++ " ::= " ++ rhs | (lhs,rhs) <- prods]
    where
      maxLHSWidth = maximum $ 0:(map (length . fst) prods)
      rpad n s = s ++ replicate (n - length s) ' '

prCFTerm :: CFTerm -> String
prCFTerm = pr 0
  where
    pr p (CFObj f args) = paren p (showCId f ++ " (" ++ concat (intersperse "," (map (pr 0) args)) ++ ")")
    pr p (CFAbs i t) = paren p ("\\x" ++ show i ++ ". " ++ pr 0 t)
    pr p (CFApp t1 t2) = paren p (pr 1 t1 ++ "(" ++ pr 0 t2 ++ ")")
    pr _ (CFRes i) = "$" ++ show i
    pr _ (CFVar i) = "x" ++ show i
    pr _ (CFMeta c) = "?" ++ showCId c
    paren 0 x = x
    paren 1 x = "(" ++ x ++ ")"

--
-- * CFRule Utilities
--

ruleFun :: Rule c t -> CId
ruleFun (Rule _ _ t) = f t
  where f (CFObj n _) = n
        f (CFApp _ x) = f x
        f (CFAbs _ x) = f x
        f _ = mkCId ""

-- | Check if any of the categories used on the right-hand side
--   are in the given list of categories.
anyUsedBy :: Eq c => [c] -> Rule c t -> Bool
anyUsedBy cs (Rule _ ss _) = any (`elem` cs) (filterCats ss)

mkCFTerm :: String -> CFTerm
mkCFTerm n = CFObj (mkCId n) []

ruleIsNonRecursive :: Ord c => Set c -> Rule c t -> Bool
ruleIsNonRecursive cs = noCatsInSet cs . ruleRhs

-- | Check if all the rules are right-linear, or all the rules are
--   left-linear, with respect to given categories.
allXLinear :: Ord c => Set c -> [Rule c t] -> Bool
allXLinear cs rs = all (isRightLinear cs) rs || all (isLeftLinear cs) rs

-- | Checks if a context-free rule is right-linear.
isRightLinear :: Ord c
              => Set c    -- ^ The categories to consider
              -> Rule c t -- ^ The rule to check for right-linearity
              -> Bool
isRightLinear cs = noCatsInSet cs . safeInit . ruleRhs

-- | Checks if a context-free rule is left-linear.
isLeftLinear :: Ord c
             => Set c    -- ^ The categories to consider
             -> Rule c t -- ^ The rule to check for left-linearity
             -> Bool
isLeftLinear cs = noCatsInSet cs . drop 1 . ruleRhs


--
-- * Symbol utilities
--

symbol :: (c -> a) -> (t -> a) -> Symbol c t -> a
symbol fc ft (NonTerminal cat) = fc cat
symbol fc ft (Terminal tok) = ft tok

mapSymbol :: (c -> c') -> (t -> t') -> Symbol c t -> Symbol c' t'
mapSymbol fc ft = symbol (NonTerminal . fc) (Terminal . ft)

filterCats :: [Symbol c t] -> [c]
filterCats syms = [ cat | NonTerminal cat <- syms ]

filterToks :: [Symbol c t] -> [t]
filterToks syms = [ tok | Terminal tok <- syms ]

-- | Checks if a symbol is a non-terminal of one of the given categories.
catElem :: Ord c => Symbol c t -> Set c -> Bool
catElem s cs = symbol (`Set.member` cs) (const False) s

noCatsInSet :: Ord c => Set c -> [Symbol c t] -> Bool
noCatsInSet cs = not . any (`catElem` cs)
