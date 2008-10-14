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


module PGF.Parsing.FCFG.Utilities where

import Control.Monad
import Data.Array
import Data.List (groupBy)

import PGF.CId
import PGF.Data
import GF.Data.Assoc
import GF.Data.Utilities (sameLength, foldMerge, splitBy)


------------------------------------------------------------
-- ranges as single pairs

type RangeRec = [Range]

data Range = Range {-# UNPACK #-} !Int {-# UNPACK #-} !Int
	   | EmptyRange
             deriving (Eq, Ord, Show)

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
                    deriving (Eq,Ord,Show)

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


-- ** conversions between representations

chart2forests :: (Ord n, Ord e) => 
		 SyntaxChart n e  -- ^ The complete chart
	      -> (e -> Bool)      -- ^ When is an edge 'FMeta'?
	      -> [e]              -- ^ The starting edges
	      -> [SyntaxForest n] -- ^ The result has unique keys, ie. all 'n' are joined together.
				  -- In essence, the result is a map from 'n' to forest daughters
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


applyProfileToForest :: SyntaxForest (CId,[Profile]) -> [SyntaxForest CId]
applyProfileToForest (FNode (fun,profiles) children) 
    | fun == wildCId = concat chForests
    | otherwise      = [ FNode fun chForests | not (null chForests) ]
    where chForests  = concat [ mapM (unifyManyForests . map (forests !!)) profiles |
			        forests0 <- children,
			        forests <- mapM applyProfileToForest forests0 ]
applyProfileToForest (FString s) = [FString s]
applyProfileToForest (FInt    n) = [FInt    n]
applyProfileToForest (FFloat  f) = [FFloat  f]
applyProfileToForest (FMeta)     = [FMeta]


forest2trees :: SyntaxForest CId -> [Tree]
forest2trees (FNode n forests) = map (Fun n) $ forests >>= mapM forest2trees
forest2trees (FString s) = [Lit (LStr s)]
forest2trees (FInt    n) = [Lit (LInt n)]
forest2trees (FFloat  f) = [Lit (LFlt f)]
forest2trees (FMeta)     = [Meta 0]
