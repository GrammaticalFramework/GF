{-- Module --------------------------------------------------------------------
  Filename:    IncrementalParse.hs
  Author:      Håkan Burden
  Time-stamp:  <2005-04-18, 15:07>

  Description: An agenda-driven implementation of the incremental algorithm 4.6
               that handles erasing and suppressing MCFG.
               As described in Ljunglöf (2004)   
------------------------------------------------------------------------------}

module IncrementalParse where


-- Haskell
import List

-- GF modules
import Examples
import GeneralChart
import MCFGrammar
import MCFParser
import Parser
import Range
import Nondet


{-- Datatypes -----------------------------------------------------------------
  IChart: A RedBlackMap with Items and Keys
  Item   : One kind of Item since the Passive Items not necessarily need to be 
           saturated iow, they can still have rows to recognize. 
  IKey  :  
------------------------------------------------------------------------------}

type IChart n c l = ParseChart (Item n c l) (IKey c l) 

data Item   n c l = Active (AbstractRule n c) 
                           (RangeRec l) 
			   Range 
			   (Lin c l Range) 
			   (LinRec c l Range) 
			   [RangeRec l]
--		  | Passive (AbstractRule n c) 
--		            (RangeRec l) 
--			    [RangeRec l]
		    deriving (Eq, Ord, Show)

data IKey     c l = Act c l Int
--		  | ActE l
                  | Pass c l Int
--		  | Pred l
		  | Useless
		    deriving (Eq, Ord, Show)

keyof :: Item n c l -> IKey c l
keyof (Active _ _ (Range (_,j)) (Lin _ ((Cat (next,lbl,_)):_)) _ _) 
    = Act next lbl j
keyof (Active (_, cat, _) found (Range (i,_)) (Lin lbl []) _ _) 
    = Pass cat lbl i 
keyof _                                                       
    = Useless


{-- Parsing -------------------------------------------------------------------
  recognize: 
  parse    : Builds a chart from the initial agenda, given by prediction, and
             the inference rules 
  keyof    : Given an Item returns an appropriate Key for the Chart
------------------------------------------------------------------------------}

recognize mcfg toks = chartMember (parse mcfg toks) item (keyof item)
    where n = length toks
	  n2 = n `div` 2
	  item = Active ("f",S,[A]) 
		 [] (Range (0, n)) (Lin "s" []) []
		 [[("p", Range (0, n2)), ("q", Range (n2, n))]]


parse :: (Ord n, Ord c, Ord l, Eq t) => Grammar n c l t -> [t] -> IChart n c l
parse mcfg toks = buildChart keyof [complete ntoks, scan, combine] (predict mcfg toks ntoks)
    where ntoks = length toks

complete ::  (Ord n, Ord c, Ord l) => Int -> IChart n c l
	 -> Item n c l -> [Item n c l]
complete ntoks _ (Active rule found rng@(Range (_,j)) (Lin l []) lins recs) = 
    [ Active rule (found ++ [(l, rng)]) (Range (k,k)) lin lins' recs  |
      (lin, lins') <- select lins,
      k <- [j .. ntoks] ]
complete _ _ _ = []


predict :: (Eq n, Eq c, Eq l, Eq t) => Grammar n c l t -> [t] -> Int -> [Item n c l]
predict mcfg toks n = [ Active (f, c, rhs) [] (Range (k,k)) lin' lins'' daughters |
		 	Rule c rhs lins f <- mcfg,
			let daughters = replicate (length rhs) [],
			lins' <- solutions $ rangeRestRec toks lins, 
			(lin', lins'') <- select lins',
			k <- [0..n] ]


scan :: (Ord n, Ord c, Ord l) => IChart n c l -> Item n c l -> [Item n c l]
scan _ (Active rule found rng (Lin l (Tok rng':syms)) lins recs) = 
    [ Active rule found rng'' (Lin l syms) lins recs | 
      rng'' <- solutions $ concRanges rng rng' ]
scan _ _            = []


combine :: (Ord n, Ord c, Ord l) => IChart n c l -> Item n c l -> [Item n c l]
combine chart (Active rule found rng@(Range (_,j)) (Lin l ((Cat (c,r,d)):syms)) lins recs) = 
    [ Active rule found rng'' (Lin l syms) lins (replaceRec recs d (found' ++ [(l',rng')])) |
      Active _ found' rng' (Lin l' []) _ _ <-  chartLookup chart (Pass c r j),
      subsumes (recs !! d) (found' ++ [(l',rng')]),
      rng'' <- solutions $ concRanges rng rng' ] 
combine chart (Active (_,c,_) found rng'@(Range (i,_)) (Lin l []) _ _) = 
    [ Active rule found' rng'' (Lin l' syms) lins (replaceRec recs d (found ++ [(l,rng')])) |
      Active rule found' rng (Lin l' ((Cat (c,r,d)):syms)) lins recs
            <- chartLookup chart (Act c l i),
      subsumes (recs !! d) (found ++ [(l,rng')]),
      rng'' <- solutions $ concRanges rng rng' ]
combine _ _ = [] 




