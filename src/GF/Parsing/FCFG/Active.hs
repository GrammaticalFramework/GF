----------------------------------------------------------------------
-- |
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-- MCFG parsing, the active algorithm
-----------------------------------------------------------------------------

module GF.Parsing.FCFG.Active (parse) where

import GF.Data.GeneralDeduction
import GF.Data.Assoc
import GF.Data.SortedList
import GF.Data.Utilities

import GF.Formalism.GCFG
import GF.Formalism.FCFG
import GF.Formalism.MCFG(Lin(..))
import GF.Formalism.Utilities

import GF.Infra.Ident
import GF.Infra.Print

import GF.Parsing.FCFG.Range
import GF.Parsing.FCFG.PInfo

import Control.Monad (guard)

import qualified Data.List as List
import qualified Data.Map  as Map
import qualified Data.Set  as Set
import Data.Array

----------------------------------------------------------------------
-- * parsing

parse :: (Print c, Ord c, Ord n, Print t, Ord t) => String -> FCFParser c n t
parse strategy pinfo starts toks = xchart2syntaxchart chart pinfo
    where chart = process strategy pinfo toks axioms emptyXChart
          axioms | isBU  strategy = literals pinfo toks ++ initialBU pinfo toks
		 | isTD  strategy = literals pinfo toks ++ initialTD pinfo starts toks

isBU  s = s=="b"
isTD  s = s=="t"

-- used in prediction
emptyChildren :: RuleId -> FCFPInfo c n t -> SyntaxNode RuleId RangeRec
emptyChildren ruleid pinfo = SNode ruleid (replicate (length rhs) [])
  where
    FRule _ rhs _ _ = allRules pinfo ! ruleid

updateChildren :: SyntaxNode RuleId RangeRec -> Int -> RangeRec -> [SyntaxNode RuleId RangeRec]
updateChildren (SNode ruleid recs) i rec = do
  recs <- updateNthM update i recs
  return (SNode ruleid recs)
  where
    update rec' = guard (null rec' || rec' == rec) >> return rec

makeMaxRange (Range _ j) = Range j j
makeMaxRange EmptyRange  = EmptyRange

process :: (Print c, Ord c, Ord n, Print t, Ord t) => String -> FCFPInfo c n t -> Input t -> [(c,Item)] -> XChart c -> XChart c
process strategy pinfo toks []               chart = chart
process strategy pinfo toks ((c,item):items) chart = process strategy pinfo toks items $! univRule c item chart
  where
    univRule cat item@(Active found rng lbl ppos node@(SNode ruleid _)) chart
      | inRange (bounds lin) ppos =
           case lin ! ppos of
             FSymCat c r d -> case insertXChart chart item c of
	                        Nothing    -> chart
	                        Just chart -> let items = do item@(Final found' _) <- lookupXChartFinal chart c
	         			                     rng  <- concatRange rng (found' !! r)
	         			                     node <- updateChildren node d found'
	     			                             return (c, Active found rng lbl (ppos+1) node)
	     			                          ++
	     			                          do guard (isTD strategy)
	     			                             ruleid <- topdownRules pinfo ? c
	     			                             return (c, Active [] EmptyRange 0 0 (emptyChildren ruleid pinfo))
	     			              in process strategy pinfo toks items chart
	     FSymTok tok   -> let items = do (i,j) <- inputToken toks ? tok
	                                     rng' <- concatRange rng (makeRange i j)
	                                     return (cat, Active found rng' lbl (ppos+1) node)
                              in process strategy pinfo toks items chart
      | otherwise =
           if inRange (bounds lins) (lbl+1)
             then univRule cat (Active          (rng:found)  EmptyRange (lbl+1) 0 node) chart
             else univRule cat (Final  (reverse (rng:found))                      node) chart
      where
        (FRule fn _ cat lins) = allRules pinfo ! ruleid
        lin                   = lins ! lbl
    univRule cat item@(Final found' node) chart =
      case insertXChart chart item cat of
        Nothing    -> chart
        Just chart -> let items = do (Active found rng l ppos node@(SNode ruleid _)) <- lookupXChartAct chart cat
                                     let FRule _ _ _ lins = allRules pinfo ! ruleid
                                         FSymCat cat r d  = lins ! l ! ppos
                                     rng  <- concatRange rng (found' !! r)
                                     node <- updateChildren node d found'
                                     return (cat, Active found rng l (ppos+1) node)
                                  ++
    			          do guard (isBU strategy)
			             ruleid <- leftcornerCats pinfo ? cat
			             let FRule _ _ _ lins = allRules pinfo ! ruleid
			                 FSymCat cat r d  = lins ! 0 ! 0
			             node <- updateChildren (emptyChildren ruleid pinfo) d found'
                                     return (cat, Active [] (found' !! r) 0 1 node)
                      in process strategy pinfo toks items chart

----------------------------------------------------------------------
-- * XChart

data Item
  = Active RangeRec
           Range
           {-# UNPACK #-} !FLabel
           {-# UNPACK #-} !FPointPos
           (SyntaxNode RuleId RangeRec)
  | Final RangeRec (SyntaxNode RuleId RangeRec)
  deriving (Eq, Ord)

data XChart c = XChart !(ParseChart Item c) !(ParseChart Item c)

emptyXChart :: Ord c => XChart c
emptyXChart = XChart emptyChart emptyChart

insertXChart (XChart actives finals) item@(Active _ _ _ _ _) c = 
  case chartInsert actives item c of
    Nothing      -> Nothing
    Just actives -> Just (XChart actives finals)

insertXChart (XChart actives finals) item@(Final _ _) c =
  case chartInsert finals item c of
    Nothing     -> Nothing
    Just finals -> Just (XChart actives finals)

lookupXChartAct   (XChart actives finals) c = chartLookup actives c
lookupXChartFinal (XChart actives finals) c = chartLookup finals  c

xchart2syntaxchart :: (Ord c, Ord n, Ord t) => XChart c -> FCFPInfo c n t -> SyntaxChart n (c,RangeRec)
xchart2syntaxchart (XChart actives finals) pinfo =
  accumAssoc groupSyntaxNodes $
    [ case node of
        SNode ruleid rrecs -> let FRule fun rhs cat _ = allRules pinfo ! ruleid
		              in ((cat,found), SNode fun (zip rhs rrecs))
        SString s          ->    ((cat,found), SString s)
        SInt    n          ->    ((cat,found), SInt    n)
        SFloat  f          ->    ((cat,found), SFloat  f)
    | (cat, Final found node) <- chartAssocs finals
    ]

literals :: (Ord c, Ord n, Ord t) => FCFPInfo c n t -> Input t -> [(c,Item)]
literals pinfo toks =
  [let (c,node) = grammarLexer pinfo t in (c,Final [makeRange i j] node) | Edge i j t <- inputEdges toks, not (t `elem` grammarToks pinfo)]

----------------------------------------------------------------------
-- Earley --

-- called with all starting categories
initialTD :: (Ord c, Ord n, Ord t) => FCFPInfo c n t -> [c] -> Input t -> [(c,Item)]
initialTD pinfo starts toks = 
    do cat <- starts
       ruleid <- topdownRules pinfo ? cat
       return (cat,Active [] (Range 0 0) 0 0 (emptyChildren ruleid pinfo))


----------------------------------------------------------------------
-- Kilbury --

initialBU :: (Ord c, Ord n, Ord t) => FCFPInfo c n t -> Input t -> [(c,Item)]
initialBU pinfo toks =
    do tok <- aElems (inputToken toks)
       ruleid <- leftcornerTokens pinfo ? tok ++
                 epsilonRules pinfo
       let FRule _ _ cat _ = allRules pinfo ! ruleid
       return (cat,Active [] EmptyRange 0 0 (emptyChildren ruleid pinfo))
