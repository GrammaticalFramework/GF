----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/13 12:40:19 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.6 $
--
-- Basic type declarations and functions for grammar formalisms
-----------------------------------------------------------------------------


module GF.Formalism.Utilities where

import Control.Monad
import Data.Array
import Data.List (groupBy)

import GF.Data.SortedList
import GF.Data.Assoc
import GF.Data.Utilities (sameLength, foldMerge, splitBy)

import GF.Infra.PrintClass


------------------------------------------------------------
-- ranges as single pairs

type RangeRec = [Range]

data Range = Range {-# UNPACK #-} !Int {-# UNPACK #-} !Int
	   | EmptyRange
             deriving (Eq, Ord)

makeRange :: Int -> Int -> Range
makeRange = Range 

concatRange :: Range -> Range -> [Range]
concatRange EmptyRange  rng          = return rng
concatRange rng         EmptyRange   = return rng
concatRange (Range i j) (Range j' k) = [Range i k | j==j']

minRange :: Range -> Int
minRange (Range i j) = i

maxRange :: Range -> Int
maxRange (Range i j) = j


------------------------------------------------------------
-- * representaions of input tokens

data Input t = MkInput { inputBounds :: (Int, Int),
			 inputToken  :: Assoc t [Range]
		       }

input     :: Ord t => [t] -> Input t
input toks = MkInput inBounds inToken
  where
    inBounds = (0, length toks)
    inToken  = accumAssoc id [ (tok, makeRange i j) | (i,j,tok) <- zip3 [0..] [1..] toks ]

inputMany :: Ord t => [[t]] -> Input t
inputMany toks = MkInput inBounds inToken
  where
    inBounds = (0, length toks)
    inToken  = accumAssoc id [ (tok, makeRange i j) | (i,j,ts) <- zip3 [0..] [1..] toks, tok <- ts ]


------------------------------------------------------------
-- * representations of syntactical analyses

-- ** charts as finite maps over edges

-- | The values of the chart, a list of key-daughters pairs,
-- has unique keys. In essence, it is a map from 'n' to daughters.
-- The daughters should be a set (not necessarily sorted) of rhs's.
type SyntaxChart n e = Assoc e [SyntaxNode n [e]]

data SyntaxNode n e = SMeta
                    | SNode n [e]
                    | SString String
                    | SInt    Integer
                    | SFloat  Double
                    deriving (Eq,Ord)

groupSyntaxNodes :: Ord n => [SyntaxNode n e] -> [SyntaxNode n [e]]
groupSyntaxNodes []                =  []
groupSyntaxNodes (SNode n0 es0:xs) = (SNode n0 (es0:ess)) : groupSyntaxNodes xs'
  where 
    (ess,xs') = span xs

    span []       = ([],[])
    span xs@(SNode n es:xs')
      | n0 == n   = let (ess,xs) = span xs' in (es:ess,xs)
      | otherwise = ([],xs)
groupSyntaxNodes (SString s:xs) = (SString s) : groupSyntaxNodes xs
groupSyntaxNodes (SInt    n:xs) = (SInt    n) : groupSyntaxNodes xs
groupSyntaxNodes (SFloat  f:xs) = (SFloat  f) : groupSyntaxNodes xs

-- better(?) representation of forests:
-- data Forest n = F (SMap n (SList [Forest n])) Bool
-- ==
-- type Forest n = GeneralTrie n (SList [Forest n]) Bool
-- (the Bool == isMeta)

-- ** syntax forests

data SyntaxForest n = FMeta 
		    | FNode n [[SyntaxForest n]]
                      -- ^ The outer list should be a set (not necessarily sorted)
		      -- of possible alternatives. Ie. the outer list 
		      -- is a disjunctive node, and the inner lists 
		      -- are (conjunctive) concatenative nodes
		    | FString String
		    | FInt    Integer
		    | FFloat  Double
		      deriving (Eq, Ord, Show)

instance Functor SyntaxForest where
    fmap f (FNode n forests) = FNode (f n) $ map (map (fmap f)) forests
    fmap _ (FString s) = FString s
    fmap _ (FInt    n) = FInt    n
    fmap _ (FFloat  f) = FFloat  f
    fmap _ (FMeta)     = FMeta

forestName :: SyntaxForest n -> Maybe n
forestName (FNode n _) = Just n
forestName _           = Nothing

unifyManyForests :: (Monad m, Eq n) => [SyntaxForest n] -> m (SyntaxForest n)
unifyManyForests = foldM unifyForests FMeta

-- | two forests can be unified, if either is 'FMeta', or both have the same parent, 
-- and all children can be unified
unifyForests :: (Monad m, Eq n) => SyntaxForest n -> SyntaxForest n -> m (SyntaxForest n)
unifyForests FMeta  forest = return forest
unifyForests forest FMeta  = return forest
unifyForests (FNode name1 children1) (FNode name2 children2)
    | name1 == name2 && not (null children) = return $ FNode name1 children
    where children = [ forests | forests1 <- children1, forests2 <- children2,
		       sameLength forests1 forests2,
		       forests <- zipWithM unifyForests forests1 forests2 ]
unifyForests (FString s1) (FString s2)
    | s1 == s2  = return $ FString s1
unifyForests (FInt n1) (FInt n2)
    | n1 == n2  = return $ FInt n1
unifyForests (FFloat f1) (FFloat f2)
    | f1 == f2  = return $ FFloat f1
unifyForests _ _ = fail "forest unification failure"

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

-- ** syntax trees

data SyntaxTree n = TMeta
                  | TNode n [SyntaxTree n]
                  | TString  String
                  | TInt     Integer
                  | TFloat   Double
		  deriving (Eq, Ord, Show)

instance Functor SyntaxTree where
    fmap f (TNode n trees) = TNode (f n) $ map (fmap f) trees
    fmap _ (TString s)     = TString s
    fmap _ (TInt    n)     = TInt    n
    fmap _ (TFloat  f)     = TFloat  f
    fmap _ (TMeta)         = TMeta 

treeName :: SyntaxTree n -> Maybe n
treeName (TNode n _) = Just n
treeName (TMeta)     = Nothing

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
unifyTrees (TString s1) (TString s2)
    | s1 == s2 = return (TString s1)
unifyTrees (TInt n1) (TInt n2)
    | n1 == n2 = return (TInt n1)
unifyTrees (TFloat f1) (TFloat f2)
    | f1 == f2 = return (TFloat f1)
unifyTrees _ _ = fail "tree unification failure"

-- ** conversions between representations

chart2forests :: (Ord n, Ord e) => 
		 SyntaxChart n e  -- ^ The complete chart
	      -> (e -> Bool)      -- ^ When is an edge 'FMeta'?
	      -> [e]              -- ^ The starting edges
	      -> SList (SyntaxForest n) -- ^ The result has unique keys, ie. all 'n' are joined together.
					-- In essence, the result is a map from 'n' to forest daughters

-- simplest implementation

chart2forests chart isMeta = concatMap (edge2forests [])
    where edge2forests edges edge
              | isMeta edge       = [FMeta]
              | edge `elem` edges = []
              | otherwise         = map (item2forest (edge:edges)) $ chart ? edge
          item2forest edges (SMeta)               = FMeta
          item2forest edges (SNode name children) = 
                                    FNode name $ children >>= mapM (edge2forests edges)
          item2forest edges (SString s)           = FString s
          item2forest edges (SInt    n)           = FInt    n
          item2forest edges (SFloat  f)           = FFloat  f

{- -before AR inserted peb's patch 8/7/2007, this was:

chart2forests chart isMeta  = concatMap edge2forests
    where edge2forests edge = if isMeta edge then [FMeta]
			      else map item2forest $ chart ? edge
	  item2forest (SMeta)               = FMeta
	  item2forest (SNode name children) = FNode name $ children >>= mapM edge2forests
	  item2forest (SString s)           = FString s
	  item2forest (SInt    n)           = FInt    n
	  item2forest (SFloat  f)           = FFloat  f
	  
-}

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


forest2trees :: SyntaxForest n -> SList (SyntaxTree n)
forest2trees (FNode n forests) = map (TNode n) $ forests >>= mapM forest2trees
forest2trees (FString s) = [TString s]
forest2trees (FInt    n) = [TInt    n]
forest2trees (FFloat  f) = [TFloat  f]
forest2trees (FMeta)     = [TMeta]

------------------------------------------------------------
-- pretty-printing

instance Print Range where
    prt (Range i j)  = "(" ++ show i ++ "-" ++ show j ++ ")"
    prt (EmptyRange) = "(?)"


instance (Print s) => Print (SyntaxTree s) where
    prt (TNode s trees)
	| null trees = prt s
	| otherwise  = "(" ++ prt s ++ prtBefore " " trees ++ ")"
    prt (TString  s) = show s
    prt (TInt     n) = show n
    prt (TFloat   f) = show f
    prt (TMeta)      = "?"
    prtList = prtAfter "\n"

instance (Print s) => Print (SyntaxForest s) where
    prt (FNode s []) = "(" ++ prt s ++ " - ERROR: null forests)"
    prt (FNode s [[]]) = prt s
    prt (FNode s [forests]) = "(" ++ prt s ++ prtBefore " " forests ++ ")"
    prt (FNode s children) = "{" ++ prtSep " | " [ prt s ++ prtBefore " " forests | 
						   forests <- children ] ++ "}"
    prt (FString s) = show s
    prt (FInt    n) = show n
    prt (FFloat  f) = show f
    prt (FMeta)     = "?"
    prtList = prtAfter "\n"
