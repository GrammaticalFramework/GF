----------------------------------------------------------------------
-- |
-- Module      : ParseCFG.Incremental
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:23:01 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- Incremental chart parsing for context-free grammars
-----------------------------------------------------------------------------

 

module GF.OldParsing.ParseCFG.Incremental
    (parse, Strategy) where

import GF.System.Tracing
import GF.Printing.PrintParser

-- haskell modules:
import Data.Array
-- gf modules:
import GF.Data.SortedList
import GF.Data.Assoc
import GF.Data.Operations
-- parser modules:
import GF.OldParsing.Utilities
import GF.OldParsing.CFGrammar
import GF.OldParsing.IncrementalChart


type Strategy = ((Bool, Bool), (Bool, Bool)) -- (predict:(BU, TD), filter:(BU, TD))

parse :: (Ord n, Ord c, Ord t, Show t) => 
	 Strategy -> CFParser n c t
parse ((isPredictBU, isPredictTD), (isFilterBU, isFilterTD)) grammar start input =
    trace2 "CFParserIncremental" 
	       ((if isPredictBU then "BU-predict " else "") ++
		(if isPredictTD then "TD-predict " else "") ++
		(if isFilterBU  then "BU-filter " else "") ++
		(if isFilterTD  then "TD-filter " else "")) $
    finalEdges
    where finalEdges = [ Edge j k (Rule cat (reverse found) name) |
			 (k, state) <- 
			   tracePrt "#passiveChart"
			   (prt . map (length . (?Passive) . snd)) $
			   tracePrt "#activeChart" 
			   (prt . map (length . concatMap snd . aAssocs . snd)) $
			   assocs finalChart,
			 Item j (Rule cat _Nil name) found <- state ? Passive ]

	  finalChart = buildChart keyof rules axioms $ inputBounds input

          axioms 0 = --tracePrt ("axioms 0") (prtSep "\n") $
		     union $ map (tdInfer 0) start
	  axioms k = --tracePrt ("axioms "++show k) (prtSep "\n") $
		     union [ buInfer j k (Tok token) |
			     (token, js) <- aAssocs (inputTo input ! k), j <- js ]

          rules k (Item j (Rule cat [] _) _)
	      = buInfer j k (Cat cat)
          rules k (Item j rule@(Rule _ (Cat next:_) _) found) 
	      = tdInfer k next <++> 
	        -- hack for empty rules:
		[ Item j (forward rule) (Cat next:found) | 
		  emptyCategories grammar ?= next ]
	  rules _ _ = []

          buInfer j k next = --tracePrt ("buInfer "++show(j,k)++" "++prt next) (prtSep "\n") $
			     buPredict j k next <++> buCombine j k next 
          tdInfer   k next = tdPredict   k next

	  -- the combine rule
          buCombine j k next
	      | j == k    = [] -- hack for empty rules
	      | otherwise = [ Item i (forward rule) (next:found) | 
			      Item i rule found <- (finalChart ! j) ? Active next ]

	  -- kilbury bottom-up prediction
          buPredict j k next
	      = [ Item j rule [next] | isPredictBU,
		  rule <- map forward $ --tracePrt ("buRules "++prt next) (prtSep "\n") $
		                        bottomupRules grammar ? next,
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
	  buFilter (Rule _ (Cat cat:_) _) k | isFilterBU
	      = k < snd (inputBounds input) && 
		hasCommonElements (leftcornerTokens grammar ? cat) 
				      (aElems (inputFrom input ! k))
	  buFilter _ _ = True

          -- top down filtering: 'cat' is reachable by an active edge ending in node j < k
          tdFilter (Rule cat _ _) j k | isFilterTD && j < k
					  = (tdFilters ! j) ?= cat
	  tdFilter _ _ _ = True

	  tdFilters    = listArray (inputBounds input) $ 
			 map (listSet . limit leftCats . activeCats) [0..]
	  activeCats j = [ next | Active (Cat next) <- aElems (finalChart ! j) ]
	  leftCats cat = [ left | Rule _cat (Cat left:_) _ <- topdownRules grammar ? cat ]


-- type declarations, items & keys
data Item n c t = Item Int (Rule n c t) [Symbol c t]
		  deriving (Eq, Ord, Show)

data IKey   c t = Active (Symbol c t) | Passive
		  deriving (Eq, Ord, Show)

keyof :: Item n c t -> IKey c t
keyof (Item _ (Rule _ (next:_) _) _) = Active next
keyof (Item _ (Rule _ [] _) _)       = Passive

forward :: Rule n c t -> Rule n c t 
forward (Rule cat (_:rest) name) = Rule cat rest name


instance (Print n, Print c, Print t) => Print (Item n c t) where
    prt (Item k (Rule cat rhs name) syms) 
	= "<" ++show k++ ": "++prt name++". "++
	  prt cat++" -> "++prt rhs++" / "++prt syms++">"

instance (Print c, Print t) => Print (IKey c t) where
    prt (Active sym) = "?" ++ prt sym
    prt (Passive) = "!"


