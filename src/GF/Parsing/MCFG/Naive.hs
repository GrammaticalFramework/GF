
module GF.Parsing.MCFG.Naive (parse, parseR) where

import Control.Monad (guard)

-- GF modules
import GF.Data.GeneralDeduction
import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Formalism.Utilities
import GF.Parsing.MCFG.Range
import GF.Parsing.MCFG.PInfo
import GF.Data.SortedList
import GF.Data.Assoc
import GF.System.Tracing

import GF.Infra.Print

----------------------------------------------------------------------
-- * parsing

-- | Builds a chart from the initial agenda, given by prediction, and the inference rules 
parse :: (Ord t, Ord n, Ord c, Ord l) => MCFParser c n l t
parse pinfo starts toks
    = [ Abs (cat, makeRangeRec lins) (zip rhs rrecs) fun |
	Active (Abs cat _Nil fun, rhs) lins rrecs <- chartLookup chart Final ]
    where chart = process pinfo toks

-- | Builds a chart from the initial agenda, given by prediction, and the inference rules 
-- parseR :: (Ord t, Ord n, Ord c, Ord l) => MCFParser c n l t
parseR pinfo starts
    = [ Abs (cat, makeRangeRec lins) (zip rhs rrecs) fun |
	Active (Abs cat _Nil fun, rhs) lins rrecs <- chartLookup chart Final ]
    where chart = processR pinfo

process :: (Ord t, Ord n, Ord c, Ord l) => MCFPInfo c n l t -> Input t -> NChart c n l
process pinfo toks
    = tracePrt "MCFG.Naive - chart size" prtSizes $
      buildChart keyof [convert, combine] (predict pinfo toks)

processR :: (Ord n, Ord c, Ord l) => MCFPInfo c n l Range -> NChart c n l
processR pinfo
    = tracePrt "MCFG.Naive Range - chart size" prtSizes $
      buildChart keyof [convert, combine] (predictR pinfo)


----------------------------------------------------------------------
-- * inference rules

-- Creates an Active Item of every Rule in the Grammar to give the initial Agenda
predict :: (Ord l, Ord t) => MCFPInfo c n l t -> Input t -> [Item c n l]  
predict pinfo toks = tracePrt "MCFG.Naive - predicted rules" (prt . length) $
		     do Rule abs (Cnc _ _ lins) <- rulesMatchingInput pinfo toks
			lins' <- rangeRestRec toks lins
			return $ Active (abs, []) lins' [] 

-- Creates an Active Item of every Rule in the Grammar to give the initial Agenda
predictR :: (Ord l) => MCFPInfo c n l Range -> [Item c n l]  
predictR pinfo = tracePrt "MCFG.Naive Range - predicted rules" (prt . length) $
		 do Rule abs (Cnc _ _ lins) <- allRules pinfo 
		    return $ Active (abs, []) lins [] 

-- | Creates an Active Item every time it is possible to combine 
-- an Active Item from the agenda with a Passive Item from the Chart 
combine :: (Ord n, Ord c, Ord l) => NChart c n l -> Item c n l -> [Item c n l]
combine chart item@(Active (Abs _ (c:_) _, _) _ _) = 
    do Passive _c rrec <- chartLookup chart (Pass c)
       combine2 chart rrec item
combine chart (Passive c rrec) = 
    do item <- chartLookup chart (Act c)
       combine2 chart rrec item
combine _ _ = []

combine2 chart rrec (Active (Abs nt (c:find) f, found) lins rrecs) = 
    do lins' <- substArgRec (length found) rrec lins
       return $ Active (Abs nt find f, found ++ [c]) lins' (rrecs ++ [rrec])

-- | Active Items with nothing to find are converted to Passive Items
convert :: (Ord n, Ord c, Ord l) => NChart c n l -> Item c n l -> [Item c n l]
convert _ (Active (Abs cat [] fun, _) lins _) = [Passive cat (makeRangeRec lins)]
convert _ _                                   = []


----------------------------------------------------------------------
-- * type definitions

type NChart   c n l = ParseChart (Item c n l) (NKey c)

data Item     c n l = Active (DottedRule c n) (LinRec c l Range) [RangeRec l]
	            | Passive c (RangeRec l)
	              deriving (Eq, Ord, Show)      

type DottedRule c n = (Abstract c n, [c])

data NKey         c = Act c
	            | Pass c
	            | Final
	              deriving (Eq, Ord, Show)

keyof :: Item c n l -> NKey c
keyof (Active (Abs _ (next:_) _, _) _ _) = Act next 
keyof (Passive cat _)                    = Pass cat
keyof _                                  = Final

-- for tracing purposes
prtSizes chart = "final=" ++ show (length (chartLookup chart Final)) ++
		 ", passive=" ++ show (sum [length (chartLookup chart k) | 
					    k@(Pass _) <- chartKeys chart ]) ++
		 ", active=" ++ show (sum [length (chartLookup chart k) | 
					   k@(Act _) <- chartKeys chart ]) 

prtChart chart = concat [ "\n*** KEY: " ++ prt k ++ 
			  prtBefore "\n  " (chartLookup chart k) | 
			  k <- chartKeys chart ] 

instance (Print c, Print n, Print l) => Print (Item c n l) where
    prt (Active (abs, cs) lrec rrecs) = "? " ++ prt abs ++ " . " ++ prtSep " " cs ++ ";\n\t" ++
					"{" ++ prtSep " " lrec ++ "}" ++ 
					( if null rrecs then ";" else ";\n\t" ++
					  "{" ++ prtSep "} {" (map (prtSep " ") rrecs) ++ "}" )
    prt (Passive c rrec) = "- " ++ prt c ++ "; {" ++ prtSep " " rrec ++ "}"

instance Print c => Print (NKey c) where
    prt (Act c) = "Active " ++ prt c
    prt (Pass c) = "Passive " ++ prt c
    prt (Final) = "Final"


