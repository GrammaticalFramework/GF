----------------------------------------------------------------------
-- |
-- Module      : (Module)
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date $ 
-- > CVS $Author $
-- > CVS $Revision $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module Morphology where

import AbsGFC
import GFC
import PrGrammar
import CMacros
import LookAbs
import Ident
import qualified Macros as M
import Linear

import Operations
import Glue

import Char
import List (sortBy, intersperse)
import Monad (liftM)
import Trie2

-- construct a morphological analyser from a GF grammar. AR 11/4/2001

-- we first found the binary search tree sorted by word forms more efficient
-- than a trie, at least for grammars with 7000 word forms
-- (18/11/2003) but this may change since we have to use a trie 
-- for decompositions and also want to use it in the parser

type Morpho = Trie Char String

emptyMorpho = emptyTrie

appMorpho :: Morpho -> String -> (String,[String])
appMorpho = appMorphoOnly
---- add lookup for literals

-- without literals
appMorphoOnly :: Morpho -> String -> (String,[String])
appMorphoOnly m s = trieLookup m s

-- recognize word, exluding literals
isKnownWord :: Morpho -> String -> Bool
isKnownWord mo = not . null . snd . appMorphoOnly mo

mkMorpho :: CanonGrammar -> Ident -> Morpho 
mkMorpho gr a = tcompile $ concatMap mkOne $ allItems where

  mkOne (Left (fun,c))  = map (prOne fun c) $ allLins fun
  mkOne (Right (fun,_)) = map (prSyn fun) $ allSyns fun
  
  -- gather forms of lexical items
  allLins fun@(m,f) = errVal [] $ do
    ts <- allLinsOfFun gr (CIQ a f)  
    ss <- mapM (mapPairsM (mapPairsM (return . wordsInTerm))) ts
    return [(p,s) | (p,fs) <- concat $ map snd $ concat ss, s <- fs]
  prOne (_,f) c (ps,s) = (s, [prt f +++ tagPrt c +++ unwords (map prt_ ps)])

  -- gather syncategorematic words
  allSyns fun@(m,f) = errVal [] $ do
    tss <- allLinsOfFun gr (CIQ a f) 
    let ss = [s | ts <- tss, (_,fs) <- ts, (_,s) <- fs]
    return $ concat $ map wordsInTerm ss
  prSyn f s = (s, ["+<syncategorematic>" ++ tagPrt f])

  -- all words, Left from lexical rules and Right syncategorematic
  allItems = [lexRole t (f,c) | (f,c,t) <- allFuns] where
    allFuns = [(f,c,t) | (f,t) <- funRulesOf gr, Ok c <- [M.valCat t]]
    lexRole t = case M.typeForm t of
      Ok ([],_,_) -> Left
      _ -> Right

-- printing full-form lexicon and results

prMorpho :: Morpho -> String
prMorpho = unlines . map prMorphoAnalysis . collapse

prMorphoAnalysis :: (String,[String]) -> String
prMorphoAnalysis (w,fs) = unlines (w:fs)

prMorphoAnalysisShort :: (String,[String]) -> String
prMorphoAnalysisShort (w,fs) = prBracket (w' ++ prTList "/" fs) where
  w' = if null fs then w +++ "*" else ""

tagPrt :: Print a => (a,a) -> String
tagPrt (m,c) = "+" ++ prt c --- module name

-- print all words recognized

allMorphoWords :: Morpho -> [String]
allMorphoWords = map fst . collapse

-- analyse running text and show results either in short form or on separate lines
morphoTextShort mo = unwords . map (prMorphoAnalysisShort . appMorpho mo) . words
morphoText mo = unlines . map (('\n':) . prMorphoAnalysis . appMorpho mo) . words

-- format used in the Italian Verb Engine
prFullForm :: Morpho -> String
prFullForm = unlines . map prOne . collapse where
  prOne (s,ps) = s ++ " : " ++ unwords (intersperse "/" ps)

-- using Huet's unglueing method to find word boundaries
---- it would be much better to use a trie also for morphological analysis,
---- so this is for the sake of experiment
---- Moreover, we should specify the cases in which this happens - not all words

decomposeWords :: Morpho -> String -> [String]
decomposeWords mo s = errVal (words s) $ decomposeSimple mo s
