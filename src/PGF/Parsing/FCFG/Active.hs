----------------------------------------------------------------------
-- |
-- Maintainer  : Krasimir Angelov
-- Stability   : (stable)
-- Portability : (portable)
--
-- MCFG parsing, the active algorithm
-----------------------------------------------------------------------------

module PGF.Parsing.FCFG.Active (parse) where

import GF.Data.Assoc
import GF.Data.SortedList
import GF.Data.Utilities
import qualified GF.Data.MultiMap as MM

import PGF.CId
import PGF.Data
import PGF.Parsing.FCFG.Utilities
import PGF.BuildParser

import Control.Monad (guard)

import qualified Data.List as List
import qualified Data.Map  as Map
import qualified Data.IntMap  as IntMap
import qualified Data.Set  as Set
import Data.Array.IArray
import Debug.Trace

----------------------------------------------------------------------
-- * parsing

type FToken = String

makeFinalEdge cat 0 0 = (cat, [EmptyRange])
makeFinalEdge cat i j = (cat, [makeRange i j])

-- | the list of categories = possible starting categories
parse :: String -> ParserInfo -> Type -> [FToken] -> [Tree]
parse strategy pinfo (DTyp _ start _) toks = nubsort $ filteredForests >>= forest2trees
  where
    inTokens = input toks
    starts = Map.findWithDefault [] start (startCats pinfo)
    schart = xchart2syntaxchart chart pinfo
    (i,j) = inputBounds inTokens
    finalEdges = [makeFinalEdge cat i j | cat <- starts]
    forests = chart2forests schart (const False) finalEdges
    filteredForests = forests >>= applyProfileToForest
        
    pinfoex = buildParserInfo pinfo
    
    chart = process strategy pinfo pinfoex inTokens axioms emptyXChart
    axioms | isBU  strategy = literals pinfoex inTokens ++ initialBU pinfo pinfoex inTokens
           | isTD  strategy = literals pinfoex inTokens ++ initialTD pinfo starts inTokens

isBU  s = s=="b"
isTD  s = s=="t"

-- used in prediction
emptyChildren :: FunId -> [FCat] -> SyntaxNode FunId RangeRec
emptyChildren ruleid args = SNode ruleid (replicate (length args) [])


process :: String -> ParserInfo -> ParserInfoEx -> Input FToken -> [Item] -> XChart FCat -> XChart FCat
process strategy pinfo pinfoex toks []           chart = chart
process strategy pinfo pinfoex toks (item:items) chart = process strategy pinfo pinfoex toks items $! univRule item chart
  where
    univRule item@(Active found rng lbl ppos node@(SNode ruleid recs) args cat) chart
      | inRange (bounds lin) ppos =
           case lin ! ppos of
             FSymCat d r -> let c = args !! d
                            in case recs !! d of
                                [] -> case insertXChart chart item c of
	                                Nothing    -> chart
	                                Just chart -> let items = do item@(Final found' _ _ _) <- lookupXChartFinal chart c
	                			                     rng  <- concatRange rng (found' !! r)
	     			                                     return (Active found rng lbl (ppos+1) (SNode ruleid (updateNth (const found') d recs)) args cat)
	     			                                  ++
	     			                                  do guard (isTD strategy)
	     			                                     (ruleid,args) <- topdownRules pinfo c
	     			                                     return (Active [] EmptyRange 0 0 (emptyChildren ruleid args) args c)
	     			                      in process strategy pinfo pinfoex toks items chart
	     			found' -> let items = do rng  <- concatRange rng (found' !! r)
	     			                         return (Active found rng lbl (ppos+1) node args cat)
	     			          in process strategy pinfo pinfoex toks items chart
	     FSymKS [tok]
	                 -> let items = do t_rng <- inputToken toks ? tok
	                                   rng' <- concatRange rng t_rng
	                                   return (Active found rng' lbl (ppos+1) node args cat)
                            in process strategy pinfo pinfoex toks items chart
      | otherwise =
           if inRange (bounds lins) (lbl+1)
             then univRule (Active          (rng:found)  EmptyRange (lbl+1) 0 node args cat) chart
             else univRule (Final  (reverse (rng:found))                      node args cat) chart
      where
        (FFun _ _ lins) = functions pinfo ! ruleid
        lin             = sequences pinfo ! (lins ! lbl)
    univRule item@(Final found' node args cat) chart =
      case insertXChart chart item cat of
        Nothing    -> chart
        Just chart -> let items = do (Active found rng l ppos node@(SNode ruleid _) args c) <- lookupXChartAct chart cat
                                     let FFun _ _ lins = functions pinfo ! ruleid
                                         FSymCat d r = (sequences pinfo ! (lins ! l)) ! ppos
                                     rng  <- concatRange rng (found' !! r)
                                     return (Active found rng l (ppos+1) (updateChildren node d found') args c)
                                  ++
    			          do guard (isBU strategy)
			             (ruleid,args,c) <- leftcornerCats pinfoex ? cat
			             let FFun _ _ lins = functions pinfo ! ruleid
			                 FSymCat d r = (sequences pinfo ! (lins ! 0)) ! 0
                                     return (Active [] (found' !! r) 0 1 (updateChildren (emptyChildren ruleid args) d found') args c)

                          updateChildren :: SyntaxNode FunId RangeRec -> Int -> RangeRec -> SyntaxNode FunId RangeRec
                          updateChildren (SNode ruleid recs) i rec = SNode ruleid $! updateNth (const rec) i recs
                      in process strategy pinfo pinfoex toks items chart

----------------------------------------------------------------------
-- * XChart

data Item
  = Active RangeRec
           Range
           {-# UNPACK #-} !FIndex
           {-# UNPACK #-} !FPointPos
           (SyntaxNode FunId RangeRec)
           [FCat]
           FCat
  | Final RangeRec (SyntaxNode FunId RangeRec) [FCat] FCat
  deriving (Eq, Ord, Show)

data XChart c = XChart !(MM.MultiMap c Item) !(MM.MultiMap c Item)

emptyXChart :: Ord c => XChart c
emptyXChart = XChart MM.empty MM.empty

insertXChart (XChart actives finals) item@(Active _ _ _ _ _ _ _) c = 
  case MM.insert' c item actives of
    Nothing      -> Nothing
    Just actives -> Just (XChart actives finals)

insertXChart (XChart actives finals) item@(Final _ _ _ _) c =
  case MM.insert' c item finals of
    Nothing     -> Nothing
    Just finals -> Just (XChart actives finals)

lookupXChartAct   (XChart actives finals) c = actives MM.! c
lookupXChartFinal (XChart actives finals) c = finals  MM.! c

xchart2syntaxchart :: XChart FCat -> ParserInfo -> SyntaxChart (CId,[Profile]) (FCat,RangeRec)
xchart2syntaxchart (XChart actives finals) pinfo =
  accumAssoc groupSyntaxNodes $
    [ case node of
        SNode ruleid rrecs -> let FFun fun prof _ = functions pinfo ! ruleid
		              in ((cat,found), SNode (fun,prof) (zip rhs rrecs))
        SString s          ->    ((cat,found), SString s)
        SInt    n          ->    ((cat,found), SInt    n)
        SFloat  f          ->    ((cat,found), SFloat  f)
    | (Final found node rhs cat) <- MM.elems finals
    ]

literals :: ParserInfoEx -> Input FToken -> [Item]
literals pinfoex toks =
  [let (c,node) = lexer t in (Final [rng] node [] c) | (t,rngs) <- aAssocs (inputToken toks), rng <- rngs, not (t `elem` grammarToks pinfoex)]
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
initialTD :: ParserInfo -> [FCat] -> Input FToken -> [Item]
initialTD pinfo starts toks = 
    do cat <- starts
       (ruleid,args) <- topdownRules pinfo cat
       return (Active [] (Range 0 0) 0 0 (emptyChildren ruleid args) args cat)

topdownRules pinfo cat = f cat []
  where
    f cat rules = maybe rules (Set.fold g rules) (IntMap.lookup cat (productions pinfo))

    g (FApply ruleid args) rules = (ruleid,args) : rules
    g (FCoerce cat)        rules = f cat rules


----------------------------------------------------------------------
-- Kilbury --

initialBU :: ParserInfo -> ParserInfoEx -> Input FToken -> [Item]
initialBU pinfo pinfoex toks =
    do (tok,rngs) <- aAssocs (inputToken toks)
       (ruleid,args,cat) <- leftcornerTokens pinfoex ? tok
       rng <- rngs
       return (Active [] rng 0 1 (emptyChildren ruleid args) args cat)
    ++
    do (ruleid,args,cat) <- epsilonRules pinfoex
       let FFun _ _ _ = functions pinfo ! ruleid
       return (Active [] EmptyRange 0 0 (emptyChildren ruleid args) args cat)
