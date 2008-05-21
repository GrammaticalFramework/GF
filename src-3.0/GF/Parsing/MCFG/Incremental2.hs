----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/08/08 09:01:25 $
-- > CVS $Author: peb $
-- > CVS $Revision: 1.3 $
--
-- MCFG parsing, the incremental algorithm (alternative version)
-----------------------------------------------------------------------------

module GF.Parsing.MCFG.Incremental2 (parse) where

import Data.List
import Data.Array
import Control.Monad (guard) 

import GF.Data.Utilities (select)
import GF.Data.Assoc 
import GF.Data.IncrementalDeduction

import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Formalism.Utilities

import GF.Parsing.MCFG.Range
import GF.Parsing.MCFG.PInfo

import GF.System.Tracing
import GF.Infra.Print

----------------------------------------------------------------------
-- parsing

-- parseR :: (Ord n, Ord c, Ord l, Ord t) => MCFParser c n l t
parse pinfo starts inp =
    accumAssoc groupSyntaxNodes $
      [ ((cat, found), SNode fun (zip rhs rrecs)) |
        k <- uncurry enumFromTo (inputBounds inp),
        Final (Abs cat rhs fun) found rrecs <- chartLookup chart k Fin ]
    where chart = process pinfo inp 

--process :: (Ord n, Ord c, Ord l) => MCFPInfo c n l Range -> (Int, Int) -> IChart c n l
process pinfo inp
    = tracePrt "MCFG.Incremental - chart size" 
          (prt . map (prtSizes finalChart . fst) . assocs) $ 
      finalChart
    where finalChart    = buildChart keyof rules axioms inBounds
	  axioms k      = tracePrt ("MCFG.Incremental - axioms for " ++ show k) (prt . length) $
			  predict k ++ scan k ++ complete1 k 
	  rules  k item = complete2 k item ++ combine k item ++ convert k item
	  inBounds      = inputBounds inp

          -- axioms: predict + scan + complete
	  predict k = do Rule abs@(Abs _ rhs _) (Cnc _ _ lins) <- rulesMatchingInput pinfo inp
			 let daughters = replicate (length rhs) []
			 (lin, lins') <- select lins
			 return $ Active abs [] k lin lins' daughters 

	  scan k = do (tok, js) <- aAssocs (inputTo inp ! k)
		      j <- js
		      Active abs found i (Lin l (Tok _tok:syms)) lins recs <- 
			  chartLookup finalChart j (ActTok tok)
		      return $ Active abs found i  (Lin l syms) lins recs 

	  complete1 k = do j <- [fst inBounds .. k-1]
			   Active abs found i (Lin l _Nil) lins recs <- 
			       chartLookup finalChart j Pass
			   let found' = found ++ [(l, makeRange (i,j))]
			   (lin, lins') <- select lins
			   return $ Active abs found' k lin lins' recs 

          -- rules: convert + combine + complete
	  convert k (Active rule found j (Lin lbl []) [] recs) = 
	      let found' = found ++ [(lbl, makeRange (j,k))]
	       in return $ Final rule found' recs
	  convert _ _ = []

	  combine k (Active (Abs cat _ _) found' j (Lin lbl []) _ _) = 
	      do guard (j < k) ---- cannot handle epsilon-rules
		 Active abs found i (Lin l (Cat (_cat,_lbl,nr):syms)) lins recs <- 
		     chartLookup finalChart j (Act cat lbl)
		 let found'' = found' ++ [(lbl, makeRange (j,k))]
		 recs' <- unifyRec recs nr found''
		 return $ Active abs found i (Lin l syms) lins recs'
	  combine _ _ = []

	  complete2 k (Active abs found i (Lin l []) lins recs) =
	      do let found' = found ++ [(l, makeRange (i,k))]
		 (lin, lins') <- select lins
		 return $ Active abs found' k lin lins' recs 
	  complete2 _ _ = []

----------------------------------------------------------------------
-- type definitions

type IChart c n l t = IncrementalChart (Item c n l t) (IKey c l t) 

data Item   c n l t = Active (Abstract c n) 
                             (RangeRec l) 
			     Int 
			     (Lin c l t) 
			     (LinRec c l t) 
			     [RangeRec l]
		    | Final (Abstract c n) (RangeRec l) [RangeRec l]
		    ---- | Passive c (RangeRec l) 
		      deriving (Eq, Ord, Show)

data IKey     c l t = Act c l 
		    | ActTok t
		    ---- | Useless
		    | Pass
		    | Fin
		      deriving (Eq, Ord, Show)

keyof :: Item c n l t -> IKey c l t
keyof (Active _ _ _ (Lin _ (Cat (next,lbl,_):_)) _ _) = Act next lbl 
keyof (Active _ _ _ (Lin _ (Tok tok:_)) _ _) = ActTok tok 
keyof (Active _ _ _ (Lin _ []) _ _) = Pass
keyof (Final _ _ _) = Fin
-- keyof _ = Useless


----------------------------------------------------------------------
-- for tracing purposes
prtSizes chart k = "f=" ++ show (length (chartLookup chart k Fin)) ++
		   " p=" ++ show (length (chartLookup chart k Pass)) ++ 
		   " a=" ++ show (sum [length (chartLookup chart k key) | 
					     key@(Act _ _) <- chartKeys chart k ]) ++
		   " t=" ++ show (sum [length (chartLookup chart k key) | 
						 key@(ActTok _) <- chartKeys chart k ]) 
		   -- " u=" ++ show (length (chartLookup chart k Useless)) 

-- prtChart chart = concat [ "\n*** KEY: " ++ prt k ++ 
-- 			  prtBefore "\n  " (chartLookup chart k) | 
-- 			  k <- chartKeys chart ] 

instance (Print c, Print n, Print l, Print t) => Print (Item c n l t) where
    prt (Active abs found rng lin tofind children) = 
	"? " ++ prt abs ++ ";\n\t" ++ 
	"{" ++ prtSep " " found ++ "} " ++ prt rng ++ " . " ++ 
	prt lin ++ "{" ++ prtSep " " tofind ++ "}" ++
        ( if null children then ";" else ";\n\t" ++
	  "{" ++ prtSep "} {" (map (prtSep " ") children) ++ "}" )
    -- prt (Passive c rrec) = "- " ++ prt c ++ "; {" ++ prtSep " " rrec ++ "}"
    prt (Final abs rr rrs) = ": " ++ prt abs ++ ";\n\t{" ++ prtSep " " rr ++ "}" ++ 
			     ( if null rrs then ";" else ";\n\t" ++ 
			       "{" ++ prtSep "} {" (map (prtSep " ") rrs) ++ "}" )

instance (Print c, Print l, Print t) => Print (IKey c l t) where
    prt (Act c l) = "Active " ++ prt c ++ " " ++ prt l
    prt (ActTok t) = "ActiveTok " ++ prt t
    -- prt (Pass c l i) = "Passive " ++ prt c ++ " " ++ prt l ++ " @ " ++ prt i
    prt (Fin) = "Final"
    -- prt (Useless) = "Useless"
