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
-- Incremental chart parsing for CFG
-----------------------------------------------------------------------------
 

module GF.NewParsing.CFG.Incremental 
    (parse, Strategy) where

import GF.System.Tracing
import GF.Infra.Print

import Array

import Operations
import GF.Data.SortedList
import GF.Data.Assoc
import GF.Formalism.Utilities
import GF.Formalism.CFG
import GF.NewParsing.CFG.PInfo
import GF.NewParsing.IncrementalChart


-- | parsing strategy: (predict:(BU, TD), filter:(BU, TD))
type Strategy = ((Bool, Bool), (Bool, Bool))

parse :: (Ord n, Ord c, Ord t) => Strategy -> CFParser c n t
parse strategy grammar start = extract . 
			       tracePrt "#internal chart" (prt . length . flip chartList const) .
			       process strategy grammar start

extract :: (Ord n, Ord c, Ord t) => 
	   IChart c n t -> CFChart c n t
extract finalChart = [ CFRule (Edge j k cat) daughters name |
		       (k, Item j (CFRule cat [] name) found) <- chartList finalChart (,),
		       daughters <- path j k (reverse found) ]
    where path i k [] = [ [] | i==k ]
	  path i k (Tok tok : found) 
	      = [ Tok tok : daughters |
		  daughters <- path (i+1) k found ]
	  path i k (Cat cat : found)
	      = [ Cat (Edge i j cat) : daughters |
		  Item j _ _ <- chartLookup finalChart i (Passive cat),
		  daughters <- path j k found ]

process :: (Ord n, Ord c, Ord t) => 
	   Strategy -> CFPInfo c n t -> [c] -> Input t -> IChart c n t
process ((isPredictBU, isPredictTD), (isFilterBU, isFilterTD)) grammar start input
    = trace2 "CFParserIncremental" ((if isPredictBU then "BU-predict " else "") ++
				    (if isPredictTD then "TD-predict " else "") ++
				    (if isFilterBU  then "BU-filter " else "") ++
				    (if isFilterTD  then "TD-filter " else "")) $
      finalChart
    where finalChart = buildChart keyof rules axioms $ inputBounds input

          axioms 0 = union $ map (tdInfer 0) start
	  axioms k = union [ buInfer j k (Tok token) |
			     (token, js) <- aAssocs (inputTo input ! k), j <- js ]

          rules k (Item j (CFRule cat [] _) _)
	      = buInfer j k (Cat cat)
          rules k (Item j rule@(CFRule _ (sym@(Cat next):_) _) found) 
	      = tdInfer k next <++> 
	        -- hack for empty rules:
		[ Item j (forward rule) (sym:found) | 
		  emptyCategories grammar ?= next ]
	  rules _ _ = []

          buInfer j k next = buPredict j k next <++> buCombine j k next 
          tdInfer   k next = tdPredict   k next

	  -- the combine rule
          buCombine j k next
	      | j == k    = [] -- hack for empty rules, see rules above and tdPredict below
	      | otherwise = [ Item i (forward rule) (next:found) | 
			      Item i rule found <- (finalChart ! j) ? Active next ]

	  -- kilbury bottom-up prediction
          buPredict j k next
	      = [ Item j rule [next] | isPredictBU,
		  rule <- map forward $ bottomupRules grammar ? next,
		  buFilter rule k, 
		  tdFilter rule j k ]

	  -- top-down prediction
          tdPredict k cat
	      = [ Item k rule [] | isPredictTD || isFilterTD,
		  rule <- topdownRules grammar ? cat,
		  buFilter rule k ] <++>
		-- hack for empty rules:
		[ Item k rule [] | isPredictBU,
		  rule <- emptyLeftcornerRules grammar ? cat ]

          -- bottom up filtering: input symbol k can begin the given symbol list (first set)
	  -- leftcornerTokens DOESN'T WORK WITH EMPTY RULES!!!
	  buFilter (CFRule _ (Cat cat:_) _) k | isFilterBU
	      = k < snd (inputBounds input) && 
		hasCommonElements (leftcornerTokens grammar ? cat) 
				      (aElems (inputFrom input ! k))
	  buFilter _ _ = True

          -- top down filtering: 'cat' is reachable by an active edge ending in node j < k
          tdFilter (CFRule cat _ _) j k | isFilterTD && j < k
					    = (tdFilters ! j) ?= cat
	  tdFilter _ _ _ = True

	  tdFilters    = listArray (inputBounds input) $ 
			 map (listSet . limit leftCats . activeCats) [0..]
	  activeCats j = [ next | Active (Cat next) <- aElems (finalChart ! j) ]
	  leftCats cat = [ left | CFRule _cat (Cat left:_) _ <- topdownRules grammar ? cat ]


----------------------------------------------------------------------
-- type declarations, items & keys

data Item c n t = Item Int (CFRule c n t) [Symbol c t]
		  deriving (Eq, Ord, Show)

data IKey c t = Active (Symbol c t) | Passive c
		deriving (Eq, Ord, Show)

type IChart c n t = IncrementalChart (Item c n t) (IKey c t) 

keyof :: Item c n t -> IKey c t
keyof (Item _ (CFRule _ (next:_) _) _) = Active next
keyof (Item _ (CFRule cat [] _) _)     = Passive cat

forward :: CFRule c n t -> CFRule c n t
forward (CFRule cat (_:rest) name) = CFRule cat rest name

----------------------------------------------------------------------

instance (Print n, Print c, Print t) => Print (Item c n t) where
    prt (Item k rule syms) 
	= "<"++show k++ ": "++ prt rule++" / "++prt syms++">"

instance (Print c, Print t) => Print (IKey c t) where
    prt (Active sym) = "?" ++ prt sym
    prt (Passive cat) = "!" ++ prt cat


