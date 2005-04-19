{-- Module --------------------------------------------------------------------
  Filename:    ActiveParse.hs
  Author:      Håkan Burden
  Time-stamp:  <2005-04-18, 14:25>

  Description: An agenda-driven implementation of algorithm 4.6, Active parsing
               of PMCFG, as described in Ljunglöf (2004)   
------------------------------------------------------------------------------}

module ActiveParse where


-- GF modules
import Examples
import GeneralChart
import MCFGrammar
import MCFParser
import Nondet
import Parser
import Range


{-- Datatypes -----------------------------------------------------------------
  AChart: A RedBlackMap with Items and Keys
  Item  :
  AKey  :  
------------------------------------------------------------------------------}
data Item    n c l = Active (AbstractRule n c) 
                            (RangeRec l)  
			    Range 
			    (Lin c l Range) 
			    (LinRec c l Range) 
			    [RangeRec l]
		   | Passive (AbstractRule n c) (RangeRec l) [RangeRec l]
		     deriving (Eq, Ord, Show)

type AChart n c l = ParseChart (Item n c l) (AKey c) 

data AKey       c = Act c
		  | Pass c
		  | Useless
		    deriving (Eq, Ord, Show)


keyof :: Item n c l -> AKey c
keyof (Active _ _ _ (Lin _ (Cat (next, _, _):_)) _ _) = Act next
keyof (Passive (_, cat, _) _ _)                       = Pass cat
keyof _                                               = Useless


{-- Parsing -------------------------------------------------------------------
  recognize:
  parse    : Builds a chart from the initial agenda, given by prediction, and
             the inference rules 
  keyof    : Given an Item returns an appropriate Key for the Chart
------------------------------------------------------------------------------}

recognize strategy mcfg toks = chartMember 
			       (parse strategy mcfg toks) item (keyof item)
    where n  = length toks
	  n2 = n `div` 2
	  item =  (Passive ("f", S, [A])
		    [("s",Range (0,n))] 
		    [[("p",Range (0,n2)),("q",Range (n2,n))]])


parse :: (Ord n, Ord c, Ord l, Eq t) => Strategy -> Grammar n c l t -> [t] 
      -> ParseChart (Item n c l) (AKey c)
parse (False,False) mcfg toks = buildChart keyof 
				[complete, scan, combine, convert]
				(predict mcfg toks)
parse (True, False) mcfg toks = buildChart keyof 
				[predictKilbury mcfg toks, complete, combine, convert] 
				(terminal mcfg toks)
parse (False, True) mcfg toks = buildChart keyof
				[predictEarley mcfg toks, complete, scan, combine, convert]
				(initial (take 1 mcfg) toks)

predictKilbury mcfg toks _ (Passive (_, cat, _) found _) = 
    [ Active (f, a, rhs) [] rng lin' lins' daughters |
      Rule a rhs ((Lin l ((Cat (cat', r, i)):syms)):lins) f <- mcfg,
      cat == cat',		
      lin' : lins' <- solutions $ rangeRestRec toks (Lin l syms : lins),
      -- lins' <- solutions $ rangeRestRec toks lins,
      rng <- solutions $ projection r found,
      let daughters = (replaceRec (replicate (length rhs) []) i found) ]  
predictKilbury _ _ _ _ = []

predictEarley mcfg toks _ item@(Active _ _ _ (Lin _ ((Cat (cat, _, _)):_)) _ _) = 
    concat [ predEar toks item rule | 
	     rule@(Rule cat' _ _ _) <- mcfg, cat == cat' ] 
predictEarley _ _ _ _ = []

predEar toks _ (Rule cat [] lins f) = 
    [ Passive (f, cat, []) (makeRangeRec lins') [] |
      lins' <- solutions $ rangeRestRec toks lins ]
predEar toks (Active _ _ (Range (_,j)) _ _ _) (Rule cat rhs lins f) =
    [ Active (f, cat, rhs) [] (Range (j, j)) lin' lins' (replicate (length rhs) []) |
      (lin':lins') <- solutions $ rangeRestRec toks lins ] 
predEar toks (Active _ _ EmptyRange _ _ _) (Rule cat rhs lins f) =
    [ Active (f, cat, rhs) [] EmptyRange lin' lins' (replicate (length rhs) []) |
      (lin':lins') <- solutions $ rangeRestRec toks lins ] 


{--Inference rules ------------------------------------------------------------
  predict : Creates an Active Item of every Rule in the Grammar to give the 
            initial Agenda
  complete: 
  scan    : 
  combine : Creates an Active Item every time it is possible to combine 
            an Active Item from the agenda with a Passive Item from the Chart 
  convert : Active Items with nothing to find are converted to Passive Items
------------------------------------------------------------------------------}

predict :: Eq t => Grammar n c l t -> [t] -> [Item n c l]
predict grammar toks = [ Active (f, cat, rhs) [] EmptyRange lin' lins' 
			 (replicate (length rhs) []) | 
			 Rule cat rhs lins f <- grammar,
			 (lin':lins') <- solutions $ rangeRestRec toks lins ]


complete :: (Ord n, Ord c, Ord l) => ParseChart (Item n c l) (AKey c) -> Item n c l 
	 -> [Item n c l]
complete _ (Active rule found (Range (i, j)) (Lin l []) (lin:lins) recs) = 
    [ Active rule (found ++ [(l, Range (i,j))]) EmptyRange lin lins recs ]
complete _ _ = []


scan :: (Ord n, Ord c, Ord l) => ParseChart (Item n c l) (AKey c) -> Item n c l 
	-> [Item n c l]
scan _ (Active rule found rng (Lin l ((Tok rng'):syms)) lins recs) = 
    [ Active rule found rng'' (Lin l syms) lins recs |
      rng'' <- solutions $ concRanges rng rng' ]
scan _ _ = []


combine :: (Ord n, Ord c, Ord l) => ParseChart (Item n c l) (AKey c) -> Item n c l 
	-> [Item n c l]
combine chart (Active rule found rng (Lin l ((Cat (c, r, d)):syms)) lins recs) =
    [ Active rule found rng'' (Lin l syms) lins (replaceRec recs d found') |
      Passive _ found' _ <- chartLookup chart (Pass c),
      rng' <- solutions $ projection r found',
      rng'' <- solutions $ concRanges rng rng',
      subsumes (recs !! d) found' ]
combine chart (Passive (_, c, _) found _) = 
    [ Active rule found' rng (Lin l syms) lins (replaceRec recs' d found) |
      Active rule found' rng' (Lin l ((Cat (c, r, d)):syms)) lins recs' 
            <- chartLookup chart (Act c),
      rng'' <- solutions $ projection r found,
      rng <- solutions $ concRanges rng' rng'',
      subsumes (recs' !! d) found ]
combine _ _ = []      

convert :: (Ord n, Ord c, Ord l) => ParseChart (Item n c l) (AKey c) -> Item n c l 
	-> [Item n c l]
convert _ (Active rule found rng (Lin l []) [] recs) = 
    [ Passive rule (found ++ [(l, rng)]) recs ]
convert _ _ = []


-- Earley --
-- anropas med alla startregler
initial :: Eq t => [Rule n c l t] -> [t] -> [Item n c l]
initial starts toks = 
    [ Active (f, s, rhs) [] (Range (0, 0)) lin' lins' (replicate (length rhs) []) |
      Rule s rhs lins f <- starts,
      (lin':lins') <- solutions $ rangeRestRec toks lins ]


-- Kilbury --
terminal mcfg toks = 
    [ Passive (f, cat, []) (makeRangeRec lins') [] | 
      Rule cat [] lins f <- mcfg,
      lins' <- solutions $ rangeRestRec toks lins ]
