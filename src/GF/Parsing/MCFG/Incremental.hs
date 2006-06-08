----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/08/08 09:01:25 $
-- > CVS $Author: peb $
-- > CVS $Revision: 1.4 $
--
-- MCFG parsing, the incremental algorithm
-----------------------------------------------------------------------------

module GF.Parsing.MCFG.Incremental (parse, parseR) where

import Data.List
import Control.Monad (guard) 

import GF.Data.Utilities (select)
import GF.Data.GeneralDeduction
import GF.Data.Assoc

import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Formalism.Utilities

import GF.Parsing.MCFG.Range
import GF.Parsing.MCFG.PInfo

import GF.System.Tracing
import GF.Infra.Print

----------------------------------------------------------------------
-- parsing

parse :: (Ord n, Ord c, Ord l, Ord t) => MCFParser c n l t
parse pinfo starts toks =
    accumAssoc groupSyntaxNodes $
      [ ((cat, found), SNode fun (zip rhs rrecs)) |
        Final (Abs cat rhs fun) found rrecs <- chartLookup chart Fin ]
    where chart = process pinfo toks ntoks
	  ntoks = snd (inputBounds toks)

-- parseR :: (Ord n, Ord c, Ord l, Ord t) => MCFParser c n l t
parseR pinfo starts ntoks =
    accumAssoc groupSyntaxNodes $
    [ ((cat, found), SNode fun (zip rhs rrecs)) |
      Final (Abs cat rhs fun) found rrecs <- chartLookup chart Fin ]
    where chart = processR pinfo ntoks 

process :: (Ord n, Ord c, Ord l, Ord t) => MCFPInfo c n l t -> Input t -> Int -> IChart c n l
process pinfo toks ntoks
    = tracePrt "MCFG.Incremental - chart size" prtSizes $
      buildChart keyof [complete ntoks, scan, combine, convert] (predict pinfo toks ntoks)

processR :: (Ord n, Ord c, Ord l) => MCFPInfo c n l Range -> Int -> IChart c n l
processR pinfo ntoks
    = tracePrt "MCFG.Incremental Range - chart size" prtSizes $
      buildChart keyof [complete ntoks, scan, combine, convert] (predictR pinfo ntoks)

complete ::  (Ord n, Ord c, Ord l) => Int -> IChart c n l -> Item c n l -> [Item c n l]
complete ntoks _ (Active rule found rng (Lin l []) lins recs) = 
    do (lin, lins') <- select lins
       k <- [minRange rng .. ntoks]
       return $ Active rule (found ++ [(l, rng)]) (Range (k,k)) lin lins' recs 
complete _ _ _ = []


predict :: (Ord n, Ord c, Ord l, Ord t) => MCFPInfo c n l t -> Input t -> Int -> [Item c n l]
predict pinfo toks n = 
    tracePrt "MCFG.Incremental - predicted rules" (prt . length) $
    do Rule abs@(Abs _ rhs _) (Cnc _ _ lins) <- rulesMatchingInput pinfo toks
       let daughters = replicate (length rhs) []
       lins' <- rangeRestRec toks lins
       (lin', lins'') <- select lins'
       k <- [0..n] 
       return $ Active abs [] (Range (k,k)) lin' lins'' daughters 


predictR :: (Ord n, Ord c, Ord l) => MCFPInfo c n l Range -> Int -> [Item c n l]
predictR pinfo n = 
    tracePrt "MCFG.Incremental Range - predicted rules" (prt . length) $
    do Rule abs@(Abs _ rhs _) (Cnc _ _ lins) <- allRules pinfo 
       let daughters = replicate (length rhs) []
       (lin, lins') <- select lins
       k <- [0..n] 
       return $ Active abs [] (Range (k,k)) lin lins' daughters 


scan :: (Ord n, Ord c, Ord l) => IChart c n l -> Item c n l -> [Item c n l]
scan _ (Active abs found rng (Lin l (Tok rng':syms)) lins recs) = 
    do rng'' <- concatRange rng rng' 
       return $ Active abs found rng'' (Lin l syms) lins recs 
scan _ _ = []


combine :: (Ord n, Ord c, Ord l) => IChart c n l -> Item c n l -> [Item c n l]
combine chart active@(Active _ _ rng (Lin _ (Cat (c,l,_):_)) _ _) = 
    do passive <- chartLookup chart (Pass c l (maxRange rng))
       combine2 active passive
combine chart passive@(Active (Abs c _ _) _ rng (Lin l []) _ _) = 
    do active <- chartLookup chart (Act c l (minRange rng))
       combine2 active passive
combine _ _ = [] 

combine2 (Active abs found rng (Lin l (Cat (c,l',d):syms)) lins recs) 
	     (Active _ found' rng' _ _ _)
    = do rng'' <- concatRange rng rng' 
	 recs' <- unifyRec recs d found''
	 return $ Active abs found rng'' (Lin l syms) lins recs'
    where found'' = found' ++ [(l',rng')]


convert _ (Active rule found rng (Lin lbl []) [] recs) = 
    return $ Final rule (found ++ [(lbl,rng)]) recs
convert _ _ = []

----------------------------------------------------------------------
-- type definitions

type IChart c n l = ParseChart (Item c n l) (IKey c l) 

data Item   c n l = Active (Abstract c n) 
                           (RangeRec l) 
			   Range 
			   (Lin c l Range) 
			   (LinRec c l Range) 
			   [RangeRec l]
		  | Final (Abstract c n) (RangeRec l) [RangeRec l]
--		  | Passive c (RangeRec l) 
		    deriving (Eq, Ord, Show)

data IKey     c l = Act c l Int
                  | Pass c l Int
		  | Useless
		  | Fin
		    deriving (Eq, Ord, Show)

keyof :: Item c n l -> IKey c l
keyof (Active _ _ rng (Lin _ (Cat (next,lbl,_):_)) _ _) 
    = Act next lbl (maxRange rng)
keyof (Active (Abs cat _ _) found rng (Lin lbl []) _ _) 
    = Pass cat lbl (minRange rng)
keyof (Final _ _ _) = Fin
keyof _                                                       
    = Useless


----------------------------------------------------------------------
-- for tracing purposes
prtSizes chart = "final=" ++ show (length (chartLookup chart Fin)) ++
		 ", passive=" ++ show (sum [length (chartLookup chart k) | 
					    k@(Pass _ _ _) <- chartKeys chart ]) ++
		 ", active=" ++ show (sum [length (chartLookup chart k) | 
					   k@(Act _ _ _) <- chartKeys chart ]) ++
		 ", useless=" ++ show (length (chartLookup chart Useless)) 

prtChart chart = concat [ "\n*** KEY: " ++ prt k ++ 
			  prtBefore "\n  " (chartLookup chart k) | 
			  k <- chartKeys chart ] 

instance (Print c, Print n, Print l) => Print (Item c n l) where
    prt (Active abs found rng lin tofind children) = 
	"? " ++ prt abs ++ ";\n\t" ++ 
	"{" ++ prtSep " " found ++ "} " ++ prt rng ++ " . " ++ 
	prt lin ++ "{" ++ prtSep " " tofind ++ "}" ++
        ( if null children then ";" else ";\n\t" ++
	  "{" ++ prtSep "} {" (map (prtSep " ") children) ++ "}" )
--    prt (Passive c rrec) = "- " ++ prt c ++ "; {" ++ prtSep " " rrec ++ "}"
    prt (Final abs rr rrs) = ": " ++ prt abs ++ ";\n\t{" ++ prtSep " " rr ++ "}" ++ 
			     ( if null rrs then ";" else ";\n\t" ++ 
			       "{" ++ prtSep "} {" (map (prtSep " ") rrs) ++ "}" )

instance (Print c, Print l) => Print (IKey c l) where
    prt (Act c l i) = "Active " ++ prt c ++ " " ++ prt l ++ " @ " ++ prt i
    prt (Pass c l i) = "Passive " ++ prt c ++ " " ++ prt l ++ " @ " ++ prt i
    prt (Fin) = "Final"
    prt (Useless) = "Useless"
