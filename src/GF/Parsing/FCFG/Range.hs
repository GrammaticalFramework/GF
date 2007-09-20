---------------------------------------------------------------------
-- |
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-- Definitions of ranges, and operations on ranges
-----------------------------------------------------------------------------

module GF.Parsing.FCFG.Range
    ( RangeRec, Range(..), makeRange, concatRange, rangeEdge, edgeRange, minRange, maxRange,
    ) where


-- GF modules
import GF.Formalism.Utilities
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

rangeEdge :: a -> Range -> Edge a
rangeEdge a (Range i j) = Edge i j a

edgeRange :: Edge a -> Range
edgeRange (Edge i j _) = Range i j

minRange :: Range -> Int
minRange (Range i j) = i

maxRange :: Range -> Int
maxRange (Range i j) = j

instance Print Range where
    prt (Range i j)  = "(" ++ show i ++ "-" ++ show j ++ ")"
    prt (EmptyRange) = "(?)"
