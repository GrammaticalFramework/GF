
module GF.Parsing.MCFG.Naive (parse) where


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

----------------------------------------------------------------------
-- * parsing

-- | Builds a chart from the initial agenda, given by prediction, and
-- the inference rules 
parse :: (Ord t, Ord n, Ord c, Ord l) => MCFParser c n l t
parse mcfg starts toks
    = [ Abs (cat, makeRangeRec lins) (zip rhs rrecs) fun |
	Active (Abs cat _Nil fun, rhs) lins rrecs <- chartLookup chart Final ]
    where chart = process mcfg toks

process :: (Ord t, Ord n, Ord c, Ord l) => MCFGrammar c n l t -> Input t -> NChart c n l
process mcfg toks
    = tracePrt "MCFG.Naive - chart size" prtSizes $
      buildChart keyof [convert, combine] (predict toks mcfg)

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

----------------------------------------------------------------------
-- * inference rules

-- Creates an Active Item of every Rule in the Grammar to give the initial Agenda
predict :: Ord t => Input t -> MCFGrammar c n l t -> [Item c n l]  
predict toks mcfg = [ Active (abs, []) lins' [] | 
		      Rule abs (Cnc _ _ lins) <- mcfg,      
		      lins' <- rangeRestRec toks lins ]

-- | Creates an Active Item every time it is possible to combine 
-- an Active Item from the agenda with a Passive Item from the Chart 
combine :: (Ord n, Ord c, Ord l) => NChart c n l -> Item c n l -> [Item c n l]
combine chart (Active (Abs nt (c:find) f, found) lins rrecs) = 
    do Passive _ rrec <- chartLookup chart (Pass c)
       lins' <- concLinRec $ substArgRec (length found) rrec lins
       return $ Active (Abs nt find f, found ++ [c]) lins' (rrecs ++ [rrec])
combine chart (Passive c rrec) = 
    do Active (Abs nt (c:find) f, found) lins rrecs <- chartLookup chart (Act c)
       lins' <- concLinRec $ substArgRec (length found) rrec lins
       return $ Active (Abs nt find f, found ++ [c]) lins' (rrecs ++ [rrec])
combine _ _ = []

-- | Active Items with nothing to find are converted to Passive Items
convert :: (Ord n, Ord c, Ord l) => NChart c n l -> Item c n l -> [Item c n l]
convert _ (Active (Abs cat [] _, _) lins _) = [Passive cat rrec]
    where rrec = makeRangeRec lins
convert _ _                                  = []


