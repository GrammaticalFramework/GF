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

import GF.Formalism.FCFG
import GF.Formalism.Utilities

import GF.Infra.PrintClass

import GF.Parsing.FCFG.Range
import GF.Parsing.FCFG.PInfo

import Control.Monad (guard)

import qualified Data.List as List
import qualified Data.Map  as Map
import qualified Data.Set  as Set
import Data.Array

----------------------------------------------------------------------
-- * parsing

parse :: String -> FCFParser
parse strategy pinfo starts toks = xchart2syntaxchart chart pinfo
    where chart = process strategy pinfo toks axioms emptyXChart
          axioms | isBU  strategy = literals pinfo toks ++ initialBU pinfo toks
		 | isTD  strategy = literals pinfo toks ++ initialTD pinfo starts toks

isBU  s = s=="b"
isTD  s = s=="t"

-- used in prediction
emptyChildren :: RuleId -> FCFPInfo -> SyntaxNode RuleId RangeRec
emptyChildren ruleid pinfo = SNode ruleid (replicate (length rhs) [])
  where
    FRule _ rhs _ _ = allRules pinfo ! ruleid

process :: String -> FCFPInfo -> Input FToken -> [(FCat,Item)] -> XChart FCat -> XChart FCat
process strategy pinfo toks []               chart = chart
process strategy pinfo toks ((c,item):items) chart = process strategy pinfo toks items $! univRule c item chart
  where
    univRule cat item@(Active found rng lbl ppos node@(SNode ruleid recs)) chart
      | inRange (bounds lin) ppos =
           case lin ! ppos of
             FSymCat c r d -> case recs !! d of
                                [] -> case insertXChart chart item c of
	                                Nothing    -> chart
	                                Just chart -> let items = do item@(Final found' _) <- lookupXChartFinal chart c
	                			                     rng  <- concatRange rng (found' !! r)
	     			                                     return (c, Active found rng lbl (ppos+1) (SNode ruleid (updateNth (const found') d recs)))
	     			                                  ++
	     			                                  do guard (isTD strategy)
	     			                                     ruleid <- topdownRules pinfo ? c
	     			                                     return (c, Active [] EmptyRange 0 0 (emptyChildren ruleid pinfo))
	     			                      in process strategy pinfo toks items chart
	     			found' -> let items = do rng  <- concatRange rng (found' !! r)
	     			                         return (c, Active found rng lbl (ppos+1) node)
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
                                     return (cat, Active found rng l (ppos+1) (updateChildren node d found'))
                                  ++
    			          do guard (isBU strategy)
			             ruleid <- leftcornerCats pinfo ? cat
			             let FRule _ _ _ lins = allRules pinfo ! ruleid
			                 FSymCat cat r d  = lins ! 0 ! 0
                                     return (cat, Active [] (found' !! r) 0 1 (updateChildren (emptyChildren ruleid pinfo) d found'))

                          updateChildren :: SyntaxNode RuleId RangeRec -> Int -> RangeRec -> SyntaxNode RuleId RangeRec
                          updateChildren (SNode ruleid recs) i rec = SNode ruleid $! updateNth (const rec) i recs
                      in process strategy pinfo toks items chart

----------------------------------------------------------------------
-- * XChart

data Item
  = Active RangeRec
           Range
           {-# UNPACK #-} !FIndex
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

xchart2syntaxchart :: XChart FCat -> FCFPInfo -> SyntaxChart FName (FCat,RangeRec)
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

literals :: FCFPInfo -> Input FToken -> [(FCat,Item)]
literals pinfo toks =
  [let (c,node) = lexer t in (c,Final [makeRange i j] node) | Edge i j t <- inputEdges toks, not (t `elem` grammarToks pinfo)]
  where
    lexer t =
      case reads t of
        [(n,"")] -> (fcatInt, SInt (n::Integer))
        _        -> case reads t of
                      [(f,"")] -> (fcatFloat, SFloat  (f::Double))
                      _        -> (fcatString,SString t)


----------------------------------------------------------------------
-- Earley --

-- called with all starting categories
initialTD :: FCFPInfo -> [FCat] -> Input FToken -> [(FCat,Item)]
initialTD pinfo starts toks = 
    do cat <- starts
       ruleid <- topdownRules pinfo ? cat
       return (cat,Active [] (Range 0 0) 0 0 (emptyChildren ruleid pinfo))


----------------------------------------------------------------------
-- Kilbury --

initialBU :: FCFPInfo -> Input FToken -> [(FCat,Item)]
initialBU pinfo toks =
    do (tok,rngs) <- aAssocs (inputToken toks)
       ruleid <- leftcornerTokens pinfo ? tok
       let FRule _ _ cat _ = allRules pinfo ! ruleid
       (i,j) <- rngs
       return (cat,Active [] (makeRange i j) 0 1 (emptyChildren ruleid pinfo))
    ++
    do ruleid <- epsilonRules pinfo
       let FRule _ _ cat _ = allRules pinfo ! ruleid
       return (cat,Active [] EmptyRange 0 0 (emptyChildren ruleid pinfo))
