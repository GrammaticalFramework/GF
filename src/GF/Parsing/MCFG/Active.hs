----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/08/08 09:01:25 $
-- > CVS $Author: peb $
-- > CVS $Revision: 1.5 $
--
-- MCFG parsing, the active algorithm
-----------------------------------------------------------------------------

module GF.Parsing.MCFG.Active (parse, parseR) where

import GF.Data.GeneralDeduction
import GF.Data.Assoc

import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Formalism.Utilities

import GF.Parsing.MCFG.Range
import GF.Parsing.MCFG.PInfo

import GF.System.Tracing

import Control.Monad (guard)

import GF.Infra.Print

----------------------------------------------------------------------
-- * parsing

parse :: (Ord n, Ord c, Ord l, Ord t) => String -> MCFParser c n l t
parse strategy pinfo starts toks =
    trace2 "MCFG.Active - strategy" (if isBU strategy then "BU"
				     else if isTD strategy then "TD" else "None") $
    [ Abs (cat, found) (zip rhs rrecs) fun |
      Final (Abs cat rhs fun) found rrecs <- chartLookup chart Fin ]
    where chart = process strategy pinfo starts toks

-- parseR :: (Ord n, Ord c, Ord l, Ord t) => String -> MCFParser c n l t
parseR strategy pinfo starts =
    trace2 "MCFG.Active Range - strategy" (if isBU strategy then "BU"
					   else if isTD strategy then "TD" else "None") $
    [ Abs (cat, found) (zip rhs rrecs) fun |
      Final (Abs cat rhs fun) found rrecs <- chartLookup chart Fin ]
    where chart = processR strategy pinfo starts 

process :: (Ord n, Ord c, Ord l, Ord t) => 
	   String -> MCFPInfo c n l t -> [c] -> Input t -> AChart c n l
process strategy pinfo starts toks 
    = tracePrt "MCFG.Active - chart size" prtSizes $
      buildChart keyof (complete : combine : convert : rules) axioms
    where rules  | isNil strategy = [scan]
		 | isBU  strategy = [scan, predictKilbury pinfo toks]
		 | isTD  strategy = [scan, predictEarley pinfo toks]
	  axioms | isNil strategy = predict pinfo toks
		 | isBU  strategy = terminal pinfo toks ++ initialScan pinfo toks
		 | isTD  strategy = initial pinfo starts toks

--processR :: (Ord n, Ord c, Ord l) => 
--	    String -> MCFPInfo c n l Range -> [c] -> AChart c n l
processR strategy pinfo starts  
    = tracePrt "MCFG.Active Range - chart size" prtSizes $
      -- tracePrt "MCFG.Active Range - final chart" prtChart $
      buildChart keyof (complete : combine : convert : rules) axioms
    where rules  | isNil strategy = [scan]
		 | isBU  strategy = [scan, predictKilburyR pinfo]
		 | isTD  strategy = [scan, predictEarleyR pinfo]
	  axioms | isNil strategy = predictR pinfo
		 | isBU  strategy = terminalR pinfo ++ initialScanR pinfo
		 | isTD  strategy = initialR pinfo starts

isNil s = s=="n"
isBU  s = s=="b"
isTD  s = s=="t"

-- used in prediction
emptyChildren :: Abstract c n -> [RangeRec l]
emptyChildren (Abs _ rhs _) = replicate (length rhs) []

makeMaxRange (Range (_, j)) = Range (j, j)
makeMaxRange EmptyRange     = EmptyRange


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
combine chart item@(Active _ _ _ (Lin _ (Cat (c,_,_):_)) _ _) =
    do Passive _c found <- chartLookup chart (Pass c)
       combine2 chart found item
combine chart (Passive c found) = 
    do item <- chartLookup chart (Act c)
       combine2 chart found item
combine _ _ = []      

combine2 chart found' (Active rule found rng (Lin l (Cat (c, r, d):syms)) lins recs) =
    do rng' <- projection r found'
       rng'' <- concatRange rng rng'
       recs' <- unifyRec recs d found'
       return $ Active rule found rng'' (Lin l syms) lins recs'

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

predict :: (Ord c, Ord n, Ord l, Ord t) => MCFPInfo c n l t -> Input t -> [Item c n l]
predict pinfo toks = tracePrt "MCFG.Active (Naive) - predicted rules" (prt . length) $
		     do (Rule abs (Cnc _ _ lins)) <- rulesMatchingInput pinfo toks
			(lin':lins') <- rangeRestRec toks lins
			return $ Active abs [] EmptyRange lin' lins' (emptyChildren abs)


----------------------------------------------------------------------
-- NaiveR --

predictR :: (Ord c, Ord n, Ord l) => MCFPInfo c n l Range -> [Item c n l]
predictR pinfo = tracePrt "MCFG.Active (Naive Range) - predicted rules" (prt . length) $
		 do (Rule abs (Cnc _ _ (lin:lins))) <- allRules pinfo 
		    return $ Active abs [] EmptyRange lin lins (emptyChildren abs)


----------------------------------------------------------------------
-- Earley --

-- anropas med alla startkategorier
initial :: (Ord c, Ord n, Ord l, Ord t) => MCFPInfo c n l t -> [c] -> Input t -> [Item c n l]
initial pinfo starts toks = 
    tracePrt "MCFG.Active (Earley) - initial rules" (prt . length) $
    do cat <- starts
       Rule abs (Cnc _ _ lins) <- topdownRules pinfo ? cat
       lin' : lins' <- rangeRestRec toks lins 
       return $ Active abs [] (Range (0, 0)) lin' lins' (emptyChildren abs)

predictEarley :: (Ord c, Ord n, Ord l, Ord t) => MCFPInfo c n l t -> Input t
	      -> AChart c n l -> Item c n l -> [Item c n l]
predictEarley pinfo toks _ item@(Active (Abs _ _ f) _ rng (Lin _ (Cat (cat,_,_):_)) _ _) = 
    topdownRules pinfo ? cat >>= predictEarley2 toks rng 
predictEarley _ _ _ _ = []

predictEarley2 :: (Ord c, Ord n, Ord l, Ord t) => Input t -> Range -> MCFRule c n l t -> [Item c n l]
predictEarley2 toks _ (Rule abs@(Abs _ [] _) (Cnc _ _ lins)) = 
    do lins' <- rangeRestRec toks lins 
       return $ Final abs (makeRangeRec lins') []
predictEarley2 toks rng (Rule abs (Cnc _ _ lins)) =
    do lin' : lins' <- rangeRestRec toks lins 
       return $ Active abs [] EmptyRange lin' lins' (emptyChildren abs)


----------------------------------------------------------------------
-- Earley Range --

initialR :: (Ord c, Ord n, Ord l) => MCFPInfo c n l Range -> [c] -> [Item c n l]
initialR pinfo starts = 
    tracePrt "MCFG.Active (Earley Range) - initial rules" (prt . length) $
    do cat <- starts
       Rule abs (Cnc _ _ (lin : lins)) <- topdownRules pinfo ? cat
       return $ Active abs [] (Range (0, 0)) lin lins (emptyChildren abs)

predictEarleyR :: (Ord c, Ord n, Ord l) => MCFPInfo c n l Range
	      -> AChart c n l -> Item c n l -> [Item c n l]
predictEarleyR pinfo _ item@(Active (Abs _ _ f) _ rng (Lin _ (Cat (cat,_,_):_)) _ _) = 
    topdownRules pinfo ? cat >>= predictEarleyR2 rng 
predictEarleyR _ _ _ = []

predictEarleyR2 :: (Ord c, Ord n, Ord l) => Range -> MCFRule c n l Range -> [Item c n l]
predictEarleyR2 _ (Rule abs@(Abs _ [] _) (Cnc _ _ lins)) = 
    return $ Final abs (makeRangeRec lins) []
predictEarleyR2 rng (Rule abs (Cnc _ _ (lin : lins))) =
    return $ Active abs [] EmptyRange lin lins (emptyChildren abs)


----------------------------------------------------------------------
-- Kilbury --

terminal :: (Ord c, Ord n, Ord l, Ord t) => MCFPInfo c n l t -> Input t -> [Item c n l]
terminal pinfo toks = 
    tracePrt "MCFG.Active (Kilbury) - initial terminal rules" (prt . length) $
    do Rule abs (Cnc _ _ lins) <- emptyRules pinfo
       lins' <- rangeRestRec toks lins 
       return $ Final abs (makeRangeRec lins') []

initialScan :: (Ord c, Ord n, Ord l, Ord t) => MCFPInfo c n l t -> Input t -> [Item c n l]
initialScan pinfo toks =
    tracePrt "MCFG.Active (Kilbury) - initial scanned rules" (prt . length) $
    do tok <- aElems (inputToken toks)
       Rule abs (Cnc _ _ lins) <- leftcornerTokens pinfo ? tok
       lin' : lins' <- rangeRestRec toks lins
       return $ Active abs [] EmptyRange lin' lins' (emptyChildren abs)

predictKilbury :: (Ord c, Ord n, Ord l, Ord t) => MCFPInfo c n l t -> Input t
	       -> AChart c n l -> Item c n l -> [Item c n l]
predictKilbury pinfo toks _ (Passive cat found) = 
    do Rule abs (Cnc _ _ (Lin l (Cat (_,r,i):syms) : lins)) <- leftcornerCats pinfo ? cat
       lin' : lins' <- rangeRestRec toks (Lin l syms : lins)
       rng <- projection r found
       children <- unifyRec (emptyChildren abs) i found 
       return $ Active abs [] rng lin' lins' children
predictKilbury _ _ _ _ = []



----------------------------------------------------------------------
-- KilburyR --

terminalR :: (Ord c, Ord n, Ord l) => MCFPInfo c n l Range -> [Item c n l]
terminalR pinfo = 
    tracePrt "MCFG.Active (Kilbury Range) - initial terminal rules" (prt . length) $
    do Rule abs (Cnc _ _ lins) <- emptyRules pinfo
       return $ Final abs (makeRangeRec lins) []

initialScanR :: (Ord c, Ord n, Ord l) => MCFPInfo c n l Range -> [Item c n l]
initialScanR pinfo =
    tracePrt "MCFG.Active (Kilbury Range) - initial scanned rules" (prt . length) $
    do Rule abs (Cnc _ _ (lin : lins)) <- concatMap snd (aAssocs (leftcornerTokens pinfo))
       return $ Active abs [] EmptyRange lin lins (emptyChildren abs)

predictKilburyR :: (Ord c, Ord n, Ord l) => MCFPInfo c n l Range
	       -> AChart c n l -> Item c n l -> [Item c n l]
predictKilburyR pinfo _ (Passive cat found) = 
    do Rule abs (Cnc _ _ (Lin l (Cat (_,r,i):syms) : lins)) <- leftcornerCats pinfo ? cat
       rng <- projection r found
       children <- unifyRec (emptyChildren abs) i found 
       return $ Active abs [] rng (Lin l syms) lins children
predictKilburyR _ _ _ = []


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


----------------------------------------------------------------------
-- for tracing purposes

prtSizes chart = "final=" ++ show (length (chartLookup chart Fin)) ++
		 ", passive=" ++ show (sum [length (chartLookup chart k) | 
					    k@(Pass _) <- chartKeys chart ]) ++
		 ", active=" ++ show (sum [length (chartLookup chart k) | 
					   k@(Act _) <- chartKeys chart ]) ++
		 ", useless=" ++ show (length (chartLookup chart Useless)) 

prtChart chart = concat [ "\n*** KEY: " ++ prt k ++ 
			  prtBefore "\n  " (chartLookup chart k) | 
			  k <- chartKeys chart ] 

prtFinals chart = prtBefore "\n  " (chartLookup chart Fin) 

instance (Print c, Print n, Print l) => Print (Item c n l) where
    prt (Active abs found rng lin tofind children) = 
	"? " ++ prt abs ++ ";\n\t" ++ 
	"{" ++ prtSep " " found ++ "}  " ++ prt rng ++ " . " ++ 
	prt lin ++ "  {" ++ prtSep " " tofind ++ "}" ++
        ( if null children then ";" else ";\n\t" ++
	  "{" ++ prtSep "}  {" (map (prtSep " ") children) ++ "}" )
    prt (Passive c rrec) = "- " ++ prt c ++ "; {" ++ prtSep " " rrec ++ "}"
    prt (Final abs rr rrs) = ": " ++ prt abs ++ ";\n\t{" ++ prtSep " " rr ++ "}" ++ 
			     ( if null rrs then ";" else ";\n\t" ++ 
			       "{" ++ prtSep "}  {" (map (prtSep " ") rrs) ++ "}" )

instance Print c => Print (AKey c) where
    prt (Act c) = "Active " ++ prt c
    prt (Pass c) = "Passive " ++ prt c
    prt (Fin) = "Final"
    prt (Useless) = "Useless"
