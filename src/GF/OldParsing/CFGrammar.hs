----------------------------------------------------------------------
-- |
-- Module      : CFGrammar
-- Maintainer  : Peter Ljunglöf
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/11 13:52:52 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Definitions of context-free grammars,
-- parser information and chart conversion
----------------------------------------------------------------------

module GF.OldParsing.CFGrammar
    (-- * Type definitions
     Grammar,
     Rule(..),
     CFParser,
     -- * Parser information
     pInfo,
     PInfo(..),
     -- * Building parse charts
     edges2chart,
     -- * Grammar checking
     checkGrammar
    ) where

import GF.System.Tracing 

-- haskell modules:
import Array 
-- gf modules:
import GF.Data.SortedList
import GF.Data.Assoc
import qualified CF 
-- parser modules:
import GF.OldParsing.Utilities
import GF.Printing.PrintParser


------------------------------------------------------------
-- type definitions

type Grammar n c t = [Rule n c t]
data Rule    n c t = Rule c [Symbol c t] n
		     deriving (Eq, Ord, Show)


type CFParser n c t = PInfo n c t -> [c] -> Input t -> [Edge (Rule n c t)]
-- - - - - - - - - - - - - - - - - - ^^^ possible starting categories


------------------------------------------------------------
-- parser information

pInfo :: (Ord n, Ord c, Ord t) => Grammar n c t -> PInfo n c t

data PInfo n c t
    = PInfo { grammarTokens        :: SList t,
	      nameRules            :: Assoc n            (SList (Rule n c t)),
	      topdownRules         :: Assoc c            (SList (Rule n c t)),
	      bottomupRules        :: Assoc (Symbol c t) (SList (Rule n c t)),
	      emptyLeftcornerRules :: Assoc c            (SList (Rule n c t)),
	      emptyCategories      :: Set c,
	      cyclicCategories     :: SList c,
	      -- ^^ONLY FOR DIRECT CYCLIC RULES!!!
	      leftcornerTokens     :: Assoc c (SList t)
	      -- ^^DOES NOT WORK WITH EMPTY RULES!!!
	    }

-- this is not permanent...
pInfo grammar = pInfo' (filter (not.isCyclic) grammar)

pInfo' grammar = tracePrt "#parserInfo" prt $
		 PInfo grToks nmRules tdRules buRules elcRules emptyCats cyclicCats leftToks 
    where grToks    = union [ nubsort [ tok | Tok tok <- rhs ] | Rule _ rhs _ <- grammar ]
	  nmRules   = accumAssoc id [ (name, rule) | rule@(Rule _ _ name) <- grammar ]
	  tdRules   = accumAssoc id [ (cat,  rule) | rule@(Rule cat _ _) <- grammar ]
	  buRules   = accumAssoc id [ (next, rule) | rule@(Rule _ (next:_) _) <- grammar ]
	  elcRules  = accumAssoc id $ limit lc emptyRules
	  leftToks  = accumAssoc id $ limit lc $ 
		            nubsort [ (cat, token) | Rule cat (Tok token:_) _ <- grammar ]
	  lc (left, res)  = nubsort [ (cat, res)   | Rule cat _ _ <- buRules ? Cat left ]
	  emptyRules      = nubsort [ (cat, rule)  | rule@(Rule cat [] _) <- grammar ]
	  emptyCats       = listSet $ limitEmpties $ map fst emptyRules
	  limitEmpties es = if es==es' then es else limitEmpties es'
	      where es'   = nubsort [ cat | Rule cat rhs _ <- grammar, 
				      all (symbol (`elem` es) (const False)) rhs ]
	  cyclicCats = nubsort [ cat | Rule cat [Cat cat'] _ <- grammar, cat == cat' ]

isCyclic (Rule cat [Cat cat'] _) = cat==cat'
isCyclic _ = False

------------------------------------------------------------
-- building parse charts

edges2chart :: (Ord n, Ord c, Ord t) => Input t -> 
	       [Edge (Rule n c t)] -> ParseChart n (Edge c)

----------

edges2chart input edges 
    = accumAssoc id [ (Edge i k cat, (name, children i k rhs)) |
		      Edge i k (Rule cat rhs name) <- edges ]
    where children i k []            = [ [] | i == k ]
	  children i k (Tok tok:rhs) = [ rest | i <= k,
					 j <- (inputFrom input ! i) ? tok,
					 rest <- children j k rhs ]
	  children i k (Cat cat:rhs) = [ Edge i j cat : rest | i <= k,
					 j <- echart ? (i, cat),
					 rest <- children j k rhs ]
	  echart = accumAssoc id [ ((i, cat), j) | Edge i j (Rule cat _ _) <- edges ]


------------------------------------------------------------
-- grammar checking

checkGrammar :: (Ord n, Ord c, Ord t, Print n, Print c, Print t) => 
		Grammar n c t -> [String]

----------

checkGrammar rules = [ "rhs category does not exist: " ++ prt cat ++ "\n" ++
		       "  in rule: " ++ prt rule |
		       rule@(Rule _ rhs _) <- rules,
		       Cat cat <- rhs, cat `notElem` cats ]
    where cats = nubsort [ cat | Rule cat _ _ <- rules ]


------------------------------------------------------------
-- pretty-printing

instance (Print n, Print c, Print t) => Print (Rule n c t) where
    prt (Rule cat rhs name) = prt name ++ ". " ++ prt cat ++ " -> " ++ prt rhs ++ 
			      (if null rhs then ".\n" else "\n")
    prtList = concatMap prt


instance (Ord n, Ord c, Ord t) => Print (PInfo n c t) where
    prt pI = "[ tokens=" ++ show (length (grammarTokens pI)) ++
	     "; names=" ++ sla nameRules ++ 
	     "; tdCats=" ++ sla topdownRules ++
	     "; buCats=" ++ sla bottomupRules ++ 
	     "; elcCats=" ++ sla emptyLeftcornerRules ++
	     "; eCats=" ++ sla emptyCategories ++
	     "; cCats=" ++ show (length (cyclicCategories pI)) ++
	     -- "; lctokCats=" ++ sla leftcornerTokens ++ 
	     " ]"
	where sla f = show $ length $ aElems $ f pI


