
module GF.NewParsing.MCFG.Naive where


-- GF modules
import GF.NewParsing.GeneralChart
import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Formalism.Utilities
import GF.NewParsing.MCFG.Range
import GF.Data.SortedList
import GF.Data.Assoc

{-- Datatypes and types -------------------------------------------------------
  NChart    : A RedBlackMap with Items and Keys 
  Item      : The parse Items are either Active or Passive
  NKey      : One for Active Items, one for Passive and one for Active Items 
              to convert to Passive
  DottedRule: (function-name, LHS, [Found in RHS], [To find in RHS]) 
------------------------------------------------------------------------------}

type NChart   c n l = ParseChart (Item c n l) (NKey c)

data Item     c n l = Active (DottedRule c n) (LinRec c l Range) [RangeRec l]
	            | Passive (Abstract c n) (RangeRec l)
	              deriving (Eq, Ord, Show)      

type DottedRule c n = (Abstract c n, [c])

data NKey         c = Act c
	            | Pass c
	            | Final
	              deriving (Eq, Ord, Show)


{-- Parsing -------------------------------------------------------------------
  recognize: 
  parse    : Builds a chart from the initial agenda, given by prediction, and
             the inference rules 
  keyof    : Given an Item returns an appropriate Key for the Chart
------------------------------------------------------------------------------}


parse :: (Ord t, Ord n, Ord c, Ord l) => MCFGrammar c n l t -> [t] 
      -> SyntaxChart n (c, RangeRec l)
parse mcfg toks = chart3
    where chart3 = assocMap (const groupPairs) chart2
          chart2 = accumAssoc id $ nubsort chart1
	  chart1 = [ ((cat, rrec), (fun, zip rhs rrecs)) |
		     Active (Abs cat _Nil fun, rhs) lins rrecs <- chartLookup chart0 Final,
		     let rrec = makeRangeRec lins ]
	  chart0 = process mcfg toks

process :: (Ord t, Ord n, Ord c, Ord l) => MCFGrammar c n l t -> [t] -> NChart c n l
process mcfg toks = buildChart keyof [convert, combine] (predict toks mcfg)


keyof :: Item c n l -> NKey c
keyof (Active (Abs _ (next:_) _, _) _ _) = Act next 
keyof (Passive (Abs cat _ _) _)          = Pass cat
keyof _                                  = Final


{--Inference rules ------------------------------------------------------------
  predict: Creates an Active Item of every Rule in the Grammar to give the 
           initial Agenda
  combine: Creates an Active Item every time it is possible to combine 
           an Active Item from the agenda with a Passive Item from the Chart 
  convert: Active Items with nothing to find are converted to Passive Items
------------------------------------------------------------------------------}

predict :: (Eq t, Eq c) => [t] -> MCFGrammar c n l t -> [Item c n l]  
predict toks mcfg = [ Active (abs, []) lins' [] | 
		      Rule abs (Cnc _ _ lins) <- mcfg,      
		      lins' <- rangeRestRec toks lins ]


combine :: (Ord n, Ord c, Ord l) => NChart c n l -> Item c n l -> [Item c n l]
combine chart (Active (Abs nt (c:find) f, found) lins rrecs) = 
    do Passive _ rrec <- chartLookup chart (Pass c)
       lins' <- concLinRec $ substArgRec (length found) rrec lins
       return $ Active (Abs nt find f, found ++ [c]) lins' (rrecs ++ [rrec])
combine chart (Passive (Abs c _ _) rrec) = 
    do Active (Abs nt (c:find) f, found) lins rrecs <- chartLookup chart (Act c)
       lins' <- concLinRec $ substArgRec (length found) rrec lins
       return $ Active (Abs nt find f, found ++ [c]) lins' (rrecs ++ [rrec])
combine _ _ = []


convert :: (Ord n, Ord c, Ord l) => NChart c n l -> Item c n l -> [Item c n l]
convert _ (Active (Abs nt [] f, rhs) lins _) = [Passive (Abs nt rhs f) rrec]
    where rrec = makeRangeRec lins
convert _ _                                  = []


