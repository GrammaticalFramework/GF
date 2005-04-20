
module GF.NewParsing.MCFG.Active (parse) where

import GF.NewParsing.GeneralChart
import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Formalism.Utilities
import GF.NewParsing.MCFG.Range
import GF.NewParsing.MCFG.PInfo
import GF.System.Tracing
import Monad (guard)

----------------------------------------------------------------------
-- * parsing

parse :: (Ord n, Ord c, Ord l, Ord t) => String -> MCFParser c n l t
parse strategy mcfg starts toks
    = [ Abs (cat, found) (zip rhs rrecs) fun |
	Final (Abs cat rhs fun) found rrecs <- chartLookup chart Fin ]
    where chart = process strategy mcfg starts toks

process :: (Ord n, Ord c, Ord l, Ord t) => 
	   String -> MCFGrammar c n l t -> [c] -> Input t -> AChart c n l
process strategy mcfg starts toks 
    = trace2 "MCFG.Active - strategy" (if isBU strategy then "BU"
				       else if isTD strategy then "TD" else "None") $
      tracePrt "MCFG.Active - chart size" prtSizes $
      buildChart keyof (complete : combine : convert : rules) axioms
    where rules  | isNil strategy = [scan]
		 | isBU  strategy = [predictKilbury mcfg toks]
		 | isTD  strategy = [predictEarley mcfg toks]
	  axioms | isNil strategy = predict mcfg toks
		 | isBU  strategy = terminal mcfg toks
		 | isTD  strategy = initial mcfg starts toks

isNil s = s=="n"
isBU  s = s=="b"
isTD  s = s=="t"

----------------------------------------------------------------------
-- * type definitions

type AChart c n l = ParseChart (Item c n l) (AKey c) 

data Item   c n l = Active (Abstract c n) 
                           (RangeRec l)  
			   Range 
			   (Lin c l Range) 
			   (LinRec c l Range) 
			   [RangeRec l]
		  | Final (Abstract c n) (RangeRec l) [RangeRec l]
		  | Passive c (RangeRec l)
		     deriving (Eq, Ord, Show)

data AKey       c = Act c
		  | Pass c
		  | Useless
		  | Fin
		    deriving (Eq, Ord, Show)


keyof :: Item c n l -> AKey c
keyof (Active _ _ _ (Lin _ (Cat (next, _, _):_)) _ _) = Act next
keyof (Final _ _ _) = Fin
keyof (Passive cat _) = Pass cat
keyof _ = Useless

-- to be used in prediction
emptyChildren :: Abstract c n -> [RangeRec l]
emptyChildren (Abs _ rhs _) = replicate (length rhs) []

-- for tracing purposes
prtSizes chart = "final=" ++ show (length (chartLookup chart Fin)) ++
		 ", passive=" ++ show (sum [length (chartLookup chart k) | 
					    k@(Pass _) <- chartKeys chart ]) ++
		 ", active=" ++ show (sum [length (chartLookup chart k) | 
					   k@(Act _) <- chartKeys chart ]) ++
		 ", useless=" ++ show (length (chartLookup chart Useless)) 


----------------------------------------------------------------------
-- * inference rules

-- completion
complete :: (Ord c, Ord n, Ord l) => AChart c n l -> Item c n l -> [Item c n l]
complete _ (Active rule found rng (Lin l []) (lin:lins) recs) = 
    return $ Active rule (found ++ [(l, rng)]) EmptyRange lin lins recs 
complete _ _ = []

-- scanning
scan :: (Ord c, Ord n, Ord l) => AChart c n l -> Item c n l -> [Item c n l]
scan _ (Active rule found rng (Lin l (Tok rng':syms)) lins recs) = 
    do rng'' <- concatRange rng rng' 
       return $ Active rule found rng'' (Lin l syms) lins recs 
scan _ _ = []

-- | Creates an Active Item every time it is possible to combine 
-- an Active Item from the agenda with a Passive Item from the Chart 
combine :: (Ord c, Ord n, Ord l) => AChart c n l -> Item c n l -> [Item c n l]
combine chart (Active rule found rng (Lin l (Cat (c, r, d):syms)) lins recs) =
    do Passive _c found' <- chartLookup chart (Pass c)
       rng' <- projection r found'
       rng'' <- concatRange rng rng'
       guard $ subsumes (recs !! d) found' 
       return $ Active rule found rng'' (Lin l syms) lins (replaceRec recs d found') 
combine chart (Passive c found) = 
    do Active rule found' rng' (Lin l ((Cat (_c, r, d)):syms)) lins recs' 
           <- chartLookup chart (Act c)
       rng'' <- projection r found
       rng <- concatRange rng' rng''
       guard $ subsumes (recs' !! d) found
       return $ Active rule found' rng (Lin l syms) lins (replaceRec recs' d found) 
combine _ _ = []      

-- | Active Items with nothing to find are converted to Final items,
-- which in turn are converted to Passive Items
convert :: (Ord c, Ord n, Ord l) => AChart c n l -> Item c n l -> [Item c n l]
convert _ (Active rule found rng (Lin lbl []) [] recs) = 
    return $ Final rule (found ++ [(lbl,rng)]) recs
convert _ (Final (Abs cat _ _) found _) = 
    return $ Passive cat found
convert _ _ = []

----------------------------------------------------------------------
-- Naive --

-- | Creates an Active Item of every Rule in the Grammar to give the initial Agenda
predict :: (Ord c, Ord n, Ord l, Ord t) => MCFGrammar c n l t -> Input t -> [Item c n l]
predict grammar toks = 
    do Rule abs (Cnc _ _ lins) <- grammar
       (lin':lins') <- rangeRestRec toks lins 
       return $ Active abs [] EmptyRange lin' lins' (emptyChildren abs)

----------------------------------------------------------------------
-- Earley --

-- anropas med alla startkategorier
initial :: (Ord c, Ord n, Ord l, Ord t) => MCFGrammar c n l t -> [c] -> Input t -> [Item c n l]
initial mcfg starts toks = 
    do Rule abs@(Abs cat _ _) (Cnc _ _ lins) <- mcfg
       guard $ cat `elem` starts
       lin' : lins' <- rangeRestRec toks lins 
       return $ Active abs [] (Range (0, 0)) lin' lins' (emptyChildren abs)

-- earley prediction
predictEarley :: (Ord c, Ord n, Ord l, Ord t) => MCFGrammar c n l t -> Input t
	      -> AChart c n l -> Item c n l -> [Item c n l]
predictEarley mcfg toks _ (Active _ _ rng (Lin _ (Cat (cat,_,_):_)) _ _) = 
    do rule@(Rule (Abs cat' _ _) _) <- mcfg
       guard $ cat == cat' 
       predEar toks rng rule 
predictEarley _ _ _ _ = []

predEar :: (Ord c, Ord n, Ord l, Ord t) => 
	   Input t -> Range -> MCFRule c n l t -> [Item c n l]
predEar toks _ (Rule abs@(Abs _ [] _) (Cnc _ _ lins)) = 
    do lins' <- rangeRestRec toks lins 
       return $ Final abs (makeRangeRec lins') []
predEar toks rng (Rule abs (Cnc _ _ lins)) =
    do lin' : lins' <- rangeRestRec toks lins 
       return $ Active abs [] (makeMaxRange rng) lin' lins' (emptyChildren abs)

makeMaxRange (Range (_, j)) = Range (j, j)
makeMaxRange EmptyRange     = EmptyRange

----------------------------------------------------------------------
-- Kilbury --

terminal :: (Ord c, Ord n, Ord l, Ord t) => MCFGrammar c n l t -> Input t -> [Item c n l]
terminal mcfg toks = 
    do Rule abs@(Abs _ [] _) (Cnc _ _ lins) <- mcfg
       lins' <- rangeRestRec toks lins 
       return $ Final abs (makeRangeRec lins') []

-- kilbury prediction
predictKilbury :: (Ord c, Ord n, Ord l, Ord t) => 
		  MCFGrammar c n l t -> Input t
	       -> AChart c n l -> Item c n l -> [Item c n l]
predictKilbury mcfg toks _ (Passive cat found) = 
    do Rule abs@(Abs _ rhs _) (Cnc _ _ (Lin l (Cat (cat', r, i):syms) : lins)) <- mcfg
       guard $ cat == cat'
       lin' : lins' <- rangeRestRec toks (Lin l syms : lins)
       rng <- projection r found
       let children = replaceRec (emptyChildren abs) i found 
       return $ Active abs [] rng lin' lins' children
predictKilbury _ _ _ _ = []
