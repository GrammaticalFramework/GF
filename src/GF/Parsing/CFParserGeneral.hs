----------------------------------------------------------------------
-- |
-- Module      : CFParserGeneral
-- Maintainer  : Peter Ljunglöf
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/21 14:17:41 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Several implementations of CFG chart parsing
-----------------------------------------------------------------------------

module GF.Parsing.CFParserGeneral (parse,
			Strategy
		       ) where

import Tracing

import GF.Parsing.Parser
import GF.Conversion.CFGrammar
import GF.Parsing.GeneralChart 
import GF.Data.Assoc

parse :: (Ord n, Ord c, Ord t) => Strategy -> CFParser n c t
parse strategy grammar start = extract . process strategy grammar start

type Strategy = (Bool, Bool) -- (isBottomup, isTopdown)

extract :: [Item n (Symbol c t)] -> [Edge (Rule n c t)]
extract edges =
    edges'
    where edges' = [ Edge j k (Rule cat (reverse found) name) |
		     Edge j k (Cat cat, found, [], Just name) <- edges ]

process :: (Ord n, Ord c, Ord t) => Strategy -> PInfo n c t -> 
	   [c] -> Input t -> [Item n (Symbol c t)]
process (isBottomup, isTopdown) grammar start
    = trace ("CFParserGeneral" ++ 
	     (if isBottomup then " BU" else "") ++ 
	     (if isTopdown  then " TD" else "")) $
      buildChart keyof [predict, combine] . axioms 
    where axioms input = initial ++ scan input

          scan input = map (fmap mkEdge) (inputEdges input)
	  mkEdge tok = (Tok tok, [], [], Nothing)

          -- the combine rule
          combine chart (Edge j k (next, _, [], _))
	      = [ edge `forwardTo` k | edge <- chartLookup chart (Active next j) ]
          combine chart edge@(Edge _ j (_, _, next:_, _))
	      = [ edge `forwardTo` k | Edge _ k _ <- chartLookup chart (Passive next j) ]

          -- initial predictions
          initial = [ loopingEdge 0 rule | cat <- start, rule <- tdRuleLookup ? cat ]

          -- predictions
          predict chart (Edge j k (next, _, [], _)) | isBottomup 
	      = [ loopingEdge j rule `forwardTo` k | rule <- bottomupRules grammar ? next ]
	      -- - - - - - - - - -   ^^^^^^^^^^^^^ Kilbury prediction: move dot forward
	  predict chart (Edge _ k (_, _, Cat cat:_, _))
	      = [ loopingEdge k rule | rule <- tdRuleLookup ? cat ]
	  predict _ _ = []

          tdRuleLookup | isTopdown  = topdownRules grammar
		       | isBottomup = emptyLeftcornerRules grammar

-- internal representation of parse items

type Item   n s = Edge (s, [s], [s], Maybe n)
type IChart n s = Chart (Item n s) (IKey s)
data IKey     s = Active  s Int
		| Passive s Int
		  deriving (Eq, Ord, Show)

keyof (Edge _ j (_, _, next:_, _)) = Active next j
keyof (Edge j _ (cat, _, [], _))   = Passive cat j

forwardTo (Edge i j (cat, found, next:tofind, name)) k = Edge i k (cat, next:found, tofind, name)

loopingEdge k (Rule cat tofind name) = Edge k k (Cat cat, [], tofind, Just name)



