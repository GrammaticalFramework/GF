----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/16 05:40:49 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
--
-- CFG parsing with a general chart
-----------------------------------------------------------------------------

module GF.NewParsing.CFG.General
    (parse, Strategy) where

import GF.System.Tracing
import GF.Infra.Print

import GF.Formalism.Utilities
import GF.Formalism.CFG
import GF.NewParsing.CFG.PInfo
import GF.NewParsing.GeneralChart 
import GF.Data.Assoc
import Monad

parse :: (Ord n, Ord c, Ord t) => Strategy -> CFParser c n t
parse strategy grammar start = extract .
			       tracePrt "#internal chart" (prt . length . chartList) .
      			       process strategy grammar start 

-- | parsing strategy: (isBottomup, isTopdown)
type Strategy = (Bool, Bool)

extract :: (Ord n, Ord c, Ord t) =>
	   IChart n (Symbol c t) -> CFChart c n t
extract chart = [ CFRule (Edge j k cat) daughters name |
		  Edge j k (Cat cat, found, [], Just name) <- chartList chart,
		  daughters <- path j k (reverse found) ]
    where path i k [] = [ [] | i==k ]
	  path i k (Tok tok : found) 
	      = [ Tok tok : daughters |
		  daughters <- path (i+1) k found ]
	  path i k (Cat cat : found)
	      = [ Cat (Edge i j cat) : daughters |
		  Edge _i j _cat <- chartLookup chart (Passive (Cat cat) i),
		  daughters <- path j k found ]


process :: (Ord n, Ord c, Ord t) => 
	   Strategy         -- ^ (isBottomup, isTopdown) :: (Bool, Bool)
	-> CFPInfo c n t    -- ^ parser information (= grammar)
	-> [c]              -- ^ list of starting categories
	-> Input t          -- ^ input string
	-> IChart n (Symbol c t)
process (isBottomup, isTopdown) grammar start
    = trace2 "CFParserGeneral" ((if isBottomup then " BU" else "") ++ 
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
type IChart n s = ParseChart (Item n s) (IKey s)
data IKey     s = Active  s Int
		| Passive s Int
		  deriving (Eq, Ord, Show)

keyof (Edge _ j (_, _, next:_, _)) = Active next j
keyof (Edge j _ (cat, _, [], _))   = Passive cat j

forwardTo (Edge i j (cat, found, next:tofind, name)) k 
    = Edge i k (cat, next:found, tofind, name)

loopingEdge k (CFRule cat tofind name) = Edge k k (Cat cat, [], tofind, Just name)



