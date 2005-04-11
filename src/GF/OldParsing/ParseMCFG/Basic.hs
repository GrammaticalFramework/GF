----------------------------------------------------------------------
-- |
-- Module      : ParseMCFG.Basic
-- Maintainer  : Peter Ljunglöf
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/11 13:52:57 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Simplest possible implementation of MCFG chart parsing
-----------------------------------------------------------------------------

module GF.OldParsing.ParseMCFG.Basic 
    (parse) where

import GF.System.Tracing

import Ix
import GF.OldParsing.Utilities
import GF.OldParsing.MCFGrammar
import GF.OldParsing.GeneralChart 
import GF.Data.Assoc
import GF.Data.SortedList
import GF.Printing.PrintParser


parse :: (Ord n, Ord c, Ord l, Ord t,
	  Print n, Print c, Print l, Print t) => 
	 MCFParser n c l t
parse grammar start = edges2chart . extract . process grammar 


extract :: [Item n c l t] -> [(n, MEdge c l, [MEdge c l])]
extract items = tracePrt "#passives" (prt.length) $
		--trace2 "passives" (prtAfter "\n" [ i | i@(PItem _) <- items ]) $
		[ item | PItem item <- items ]


process :: (Ord n, Ord c, Ord l, Ord t, 
	    Print n, Print c, Print l, Print t) => 
	   Grammar n c l t -> Input t -> [Item n c l t]
process grammar input = buildChart keyof rules axioms
    where axioms = initial
	  rules  = [combine, scan, predict]

          -- axioms
	  initial = traceItems "axiom" [] $
		    [ nextLin name tofind (addNull cat) (map addNull args) |
		      Rule cat args tofind name <- grammar ]

	  addNull a = (a, [])

	  -- predict 
	  predict chart i1@(Item name tofind rho (Lin lbl []) (cat, found0) children)
	      = traceItems "predict" [i1] 
		[ nextLin name tofind (cat, found) children | 
		  let found = insertRow lbl rho found0 ]
	  predict _ _ = []

          -- combine 
	  combine chart active@(Item _ _ _ (Lin _ (Cat(cat,_,_):_)) _ _)
	      = do passive <- chartLookup chart (Passive cat)
		   combineItems active passive
	  combine chart passive@(PItem (_, (cat, _), _))
	      = do active <- chartLookup chart (Active cat)
		   combineItems active passive
	  combine _ _ = []

          combineItems i1@(Item name tofind rho0 (Lin lbl (Cat(_,lbl',nr):rest)) found children0)
		       i2@(PItem (_, found', _))
	      = traceItems "combine" [i1,i2]
		[ Item name tofind rho (Lin lbl rest) found children |
		  rho1 <- lookupLbl lbl' found',
		  let rho = concatRange rho0 rho1,
		  children <- updateChild nr children0 (snd found') ]

          -- scan
	  scan chart i1@(Item name tofind rho0 (Lin lbl (Tok tok:rest)) found children)
	      = traceItems "scan" [i1]
		[ Item name tofind rho (Lin lbl rest) found children |
		  let rho = concatRange rho0 (rangeOfToken tok) ]
	  scan _ _ = []

          -- utilities
          rangeOfToken tok = makeRange $ inputToken input ? tok

          zeroRange = makeRange $ map (\i -> (i,i)) $ range $ inputBounds input

          nextLin name [] found children = PItem (name, found, children)
          nextLin name (lin : tofind) found children 
	      = Item name tofind zeroRange lin found children 

lookupLbl a = map snd . filter (\b -> a == fst b) . snd
updateChild nr children found = updateIndex nr children $
				\child -> if null (snd child)
					     then [ (fst child, found) ]
					     else [ child | snd child == found ]

insertRow lbl rho [] = [(lbl, rho)]
insertRow lbl rho rows'@(row@(lbl', rho') : rows)
    = case compare lbl lbl' of
        LT -> row : insertRow lbl rho rows
	GT -> (lbl, rho) : rows'
	EQ -> (lbl, unionRange rho rho') : rows


-- internal representation of parse items

data Item n c l t
    = Item n [Lin c l t] -- tofind
      Range (Lin c l t) -- current row
      (MEdge c l) -- found rows
      [MEdge c l] -- found children
    | PItem (n, MEdge c l, [MEdge c l])
    deriving (Eq, Ord, Show)

data IKey c = Passive c | Active c | AnyItem
		deriving (Eq, Ord, Show)

keyof (PItem (_, (cat, _), _)) = Passive cat
keyof (Item _ _ _ (Lin _ (Cat(cat,_,_):_)) _ _) = Active cat
keyof _ = AnyItem


-- tracing

--type TraceItem = Item String String Char String
traceItems :: (Print n, Print l, Print c, Print t) =>
	      String -> [Item n c l t] -> [Item n c l t] -> [Item n c l t] 
traceItems rule trigs items
    | null items || True = items
    | otherwise = trace ("\n" ++ rule ++ ":" ++ 
			 unlines [ "\t" ++ prt i | i <- trigs ] ++ "=>" ++
			 unlines [ "\t" ++ prt i | i <- items ]) items

-- pretty-printing

instance (Print n, Print c, Print l, Print t) => Print (Item n c l t) where
    prt (Item name tofind rho lin (cat, found) children)
	= prt name ++ ". " ++ prt cat ++ prtRhs (map fst children) ++ 
	  "   { " ++ prt rho ++ prt lin ++ " ; " ++
	  concat [ prt lbl ++ "=" ++ prt ln ++ " " | 
		   Lin lbl ln <- tofind ] ++ "; " ++
	  concat [ prt lbl ++ "=" ++ prt rho ++ " " | 
		   (lbl, rho) <- found ] ++ "}   " ++
	  concat [ "[ " ++ concat [ prt lbl ++ "=" ++ prt rho ++ " " | 
				    (lbl,rho) <- child ] ++ "]   " | 
		   child <- map snd children ]
    prt (PItem (name, edge, edges)) 
	= prt name ++ ". " ++ prt edge ++ prtRhs edges

prtRhs [] = ""
prtRhs rhs = " -> " ++ prtSep " " rhs

