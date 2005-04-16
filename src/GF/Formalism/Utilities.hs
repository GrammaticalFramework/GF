----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/16 05:40:49 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.3 $
--
-- Basic type declarations and functions for grammar formalisms
-----------------------------------------------------------------------------


module GF.Formalism.Utilities where

import Monad
import Array
import List (groupBy)

import GF.Data.SortedList
import GF.Data.Assoc
import GF.Data.Utilities (sameLength, foldMerge, splitBy)

import GF.Infra.Print

------------------------------------------------------------
-- * symbols

data Symbol c t = Cat c | Tok t
		  deriving (Eq, Ord, Show)

symbol :: (c -> a) -> (t -> a) -> Symbol c t -> a
symbol fc ft (Cat cat) = fc cat
symbol fc ft (Tok tok) = ft tok

mapSymbol :: (c -> d) -> (t -> u) -> Symbol c t -> Symbol d u
mapSymbol fc ft = symbol (Cat . fc) (Tok . ft)

filterCats :: [Symbol c t] -> [c]
filterCats syms = [ cat | Cat cat <- syms ]

filterToks :: [Symbol c t] -> [t]
filterToks syms = [ tok | Tok tok <- syms ]


------------------------------------------------------------
-- * edges

data Edge s = Edge Int Int s
	      deriving (Eq, Ord, Show)

instance Functor Edge where
    fmap f (Edge i j s) = Edge i j (f s)


------------------------------------------------------------
-- * representaions of input tokens

data Input t = MkInput { inputEdges  :: [Edge t],
			 inputBounds :: (Int, Int),
			 inputFrom   :: Array Int (Assoc t [Int]),
			 inputTo     :: Array Int (Assoc t [Int]),
			 inputToken  :: Assoc t [(Int, Int)]
		       }

makeInput :: Ord t => [Edge t] -> Input t
input     :: Ord t =>  [t]     -> Input t
inputMany :: Ord t => [[t]]    -> Input t

instance Show t => Show (Input t) where
    show input = "makeInput " ++ show (inputEdges input)

----------

makeInput inEdges  | null inEdges = input []
		   | otherwise    = MkInput inEdges inBounds inFrom inTo inToken
    where inBounds = foldr1 minmax [ (i, j) | Edge i j _ <- inEdges ]
	      where minmax (a, b) (a', b') = (min a a', max b b')
	  inFrom   = fmap (accumAssoc id) $ accumArray (<++>) [] inBounds $
		     [ (i, [(tok, j)]) | Edge i j tok <- inEdges ]
	  inTo     = fmap (accumAssoc id) $ accumArray (<++>) [] inBounds
		     [ (j, [(tok, i)]) | Edge i j tok <- inEdges ]
	  inToken  = accumAssoc id [ (tok, (i, j)) | Edge i j tok <- inEdges ]

input toks         = MkInput inEdges inBounds inFrom inTo inToken
    where inEdges  = zipWith3 Edge [0..] [1..] toks
	  inBounds = (0, length toks)
	  inFrom   = listArray inBounds $
		     [ listAssoc [(tok, [j])] | (tok, j) <- zip toks [1..] ] ++ [ listAssoc [] ]
	  inTo     = listArray inBounds $
		     [ listAssoc [] ] ++ [ listAssoc [(tok, [i])] | (tok, i) <- zip toks [0..] ]
	  inToken  = accumAssoc id [ (tok, (i, j)) | Edge i j tok <- inEdges ]

inputMany toks     = MkInput inEdges inBounds inFrom inTo inToken
    where inEdges  = [ Edge i j t | (i, j, ts) <- zip3 [0..] [1..] toks, t <- ts ]
	  inBounds = (0, length toks)
	  inFrom   = listArray inBounds $
		     [ listAssoc [ (t, [j]) | t <- nubsort ts ] | (ts, j) <- zip toks [1..] ]
		     ++ [ listAssoc [] ]
	  inTo     = listArray inBounds $
		     [ listAssoc [] ] ++ 
		     [ listAssoc [ (t, [i]) | t <- nubsort ts ] | (ts, i) <- zip toks [0..] ]
	  inToken  = accumAssoc id [ (tok, (i, j)) | Edge i j tok <- inEdges ]


------------------------------------------------------------
-- * charts, forests & trees

-- | The values of the chart, a list of key-daughters pairs,
-- has unique keys. In essence, it is a map from 'n' to daughters.
-- The daughters should be a set (not necessarily sorted) of rhs's.
type SyntaxChart n e = Assoc e [(n, [[e]])]

-- better(?) representation of forests:
-- data Forest n = F (SMap n (SList [Forest n])) Bool
-- ==
-- type Forest n = GeneralTrie n (SList [Forest n]) Bool
-- (the Bool == isMeta)

data SyntaxForest n = FMeta 
		    | FNode n [[SyntaxForest n]]
                      -- ^ The outer list should be a set (not necessarily sorted)
		      -- of possible alternatives. Ie. the outer list 
		      -- is a disjunctive node, and the inner lists 
		      -- are (conjunctive) concatenative nodes
		      deriving (Eq, Ord, Show)

data SyntaxTree n = TMeta | TNode n [SyntaxTree n] 
		    deriving (Eq, Ord, Show)

forestName :: SyntaxForest n -> Maybe n
forestName (FNode n _) = Just n
forestName (FMeta)     = Nothing

treeName :: SyntaxTree n -> Maybe n
treeName (TNode n _) = Just n
treeName (TMeta)     = Nothing

instance Functor SyntaxTree where
    fmap f (TNode n trees) = TNode (f n) $ map (fmap f) trees
    fmap f (TMeta) = TMeta 

instance Functor SyntaxForest where
    fmap f (FNode n forests) = FNode (f n) $ map (map (fmap f)) forests
    fmap f (FMeta) = FMeta 

{- måste tänka mer på detta:
compactForests :: Ord n => [SyntaxForest n] -> SList (SyntaxForest n)
compactForests = map joinForests . groupBy eqNames . sortForests
    where eqNames f g    = forestName f == forestName g
	  sortForests    = foldMerge mergeForests [] . map return 
	  mergeForests [] gs = gs
	  mergeForests fs [] = fs
	  mergeForests fs@(f:fs') gs@(g:gs') 
	      = case forestName f `compare` forestName g of
		  LT ->     f : mergeForests fs' gs
		  GT ->     g : mergeForests fs  gs'
		  EQ -> f : g : mergeForests fs' gs'
	  joinForests fs = case forestName (head fs) of
			     Nothing   -> FMeta
			     Just name -> FNode name $
					  compactDaughters $
					  concat [ fss | FNode _ fss <- fs ]
	  compactDaughters fss = case head fss of
				   []  -> [[]]
				   [_] -> map return $ compactForests $ concat fss
				   _   -> nubsort fss
-}

-- ** conversions between representations

forest2trees :: SyntaxForest n -> SList (SyntaxTree n)
forest2trees (FNode n forests) = map (TNode n) $ forests >>= mapM forest2trees
forest2trees (FMeta) = [TMeta]

chart2forests :: (Ord n, Ord e) => 
		 SyntaxChart n e  -- ^ The complete chart
	      -> (e -> Bool)      -- ^ When is an edge 'FMeta'?
	      -> [e]              -- ^ The starting edges
	      -> SList (SyntaxForest n) -- ^ The result has unique keys, ie. all 'n' are joined together.
					-- In essence, the result is a map from 'n' to forest daughters

-- simplest implementation
chart2forests chart isMeta  = concatMap edge2forests
    where edge2forests edge = if isMeta edge then [FMeta]
			      else map item2forest $ chart ? edge
	  item2forest (name, children) = FNode name $ children >>= mapM edge2forests

{-
-- more intelligent(?) implementation,
-- requiring that charts and forests are sorted maps and sorted sets
chart2forests chart isMeta = es2fs
    where e2fs  e  = if isMeta e then [FMeta] else map i2f $ chart ? e
	  es2fs es = if null metas then fs else FMeta : fs
	      where (metas, nonMetas) = splitBy isMeta es
		    fs = map i2f $ unionMap (<++>) $ map (chart ?) nonMetas
	  i2f (name, children) = FNode name $ 
				 case head children of
				   []  -> [[]]
				   [_] -> map return $ es2fs $ concat children
				   _   -> children >>= mapM e2fs
-}


-- ** operations on forests

unifyManyForests :: (Monad m, Eq n) => [SyntaxForest n] -> m (SyntaxForest n)
unifyManyForests = foldM unifyForests FMeta

-- | two forests can be unified, if either is 'FMeta', or both have the same parent, 
-- and all children can be unified
unifyForests :: (Monad m, Eq n) => SyntaxForest n -> SyntaxForest n -> m (SyntaxForest n)
unifyForests FMeta  forest = return forest
unifyForests forest FMeta  = return forest
unifyForests (FNode name1 children1) (FNode name2 children2)
    | name1 == name2 && not (null children) = return $ FNode name1 children
    | otherwise    = fail "forest unification failure"
    where children = [ forests | forests1 <- children1, forests2 <- children2,
		       sameLength forests1 forests2,
		       forests <- zipWithM unifyForests forests1 forests2 ]


-- ** operations on trees 

unifyManyTrees :: (Monad m, Eq n) => [SyntaxTree n] -> m (SyntaxTree n)
unifyManyTrees = foldM unifyTrees TMeta

-- | two trees can be unified, if either is 'TMeta', 
-- or both have the same parent, and their children can be unified
unifyTrees :: (Monad m, Eq n) => SyntaxTree n -> SyntaxTree n -> m (SyntaxTree n)
unifyTrees TMeta tree = return tree
unifyTrees tree TMeta = return tree
unifyTrees (TNode name1 children1) (TNode name2 children2)
    | name1 == name2 && sameLength children1 children2 
	= liftM (TNode name1) $ zipWithM unifyTrees children1 children2 
    | otherwise = fail "tree unification failure"



------------------------------------------------------------
-- pretty-printing

instance (Print c, Print t) => Print (Symbol c t) where
    prt = symbol prt (simpleShow . prt)
	where simpleShow str = "\"" ++ concatMap mkEsc str ++ "\""
	      mkEsc '\\' = "\\\\"
	      mkEsc '\"' = "\\\""
	      mkEsc '\n' = "\\n"
	      mkEsc '\t' = "\\t"
	      mkEsc chr  = [chr]
    prtList = prtSep " "

instance Print t => Print (Input t) where
    prt input = "input " ++ prt (inputEdges input)

instance (Print s) => Print (Edge s) where
    prt (Edge i j s) = "[" ++ show i ++ "-" ++ show j ++ ": " ++ prt s ++ "]"
    prtList = prtSep ""

instance (Print s) => Print (SyntaxTree s) where
    prt (TNode s trees)
	| null trees = prt s
	| otherwise  = "(" ++ prt s ++ prtBefore " " trees ++ ")"
    prt (TMeta) = "?"
    prtList = prtAfter "\n"

instance (Print s) => Print (SyntaxForest s) where
    prt (FNode s []) = "(" ++ prt s ++ " - ERROR: null forests)"
    prt (FNode s [[]]) = prt s
    prt (FNode s [forests]) = "(" ++ prt s ++ prtBefore " " forests ++ ")"
    prt (FNode s children) = "{" ++ prtSep " | " [ prt s ++ prtBefore " " forests | 
						   forests <- children ] ++ "}"
    prt (FMeta) = "?"
    prtList = prtAfter "\n"


