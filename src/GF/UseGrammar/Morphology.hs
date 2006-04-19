----------------------------------------------------------------------
-- |
-- Module      : Morphology
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:23:49 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.8 $
--
-- Morphological analyser constructed from a GF grammar.
--
-- we first found the binary search tree sorted by word forms more efficient
-- than a trie, at least for grammars with 7000 word forms
-- (18\/11\/2003) but this may change since we have to use a trie 
-- for decompositions and also want to use it in the parser
-----------------------------------------------------------------------------

module GF.UseGrammar.Morphology where

import GF.Canon.AbsGFC
import GF.Canon.GFC
import GF.Grammar.PrGrammar
import GF.Canon.CMacros
import GF.Canon.Look
import GF.Grammar.LookAbs
import GF.Infra.Ident
import qualified GF.Grammar.Macros as M
import GF.UseGrammar.Linear

import GF.Data.Operations
import GF.Data.Glue

import Data.Char
import Data.List (sortBy, intersperse)
import Control.Monad (liftM)
import GF.Data.Trie2

-- construct a morphological analyser from a GF grammar. AR 11/4/2001

-- we first found the binary search tree sorted by word forms more efficient
-- than a trie, at least for grammars with 7000 word forms
-- (18\/11\/2003) but this may change since we have to use a trie 
-- for decompositions and also want to use it in the parser

type Morpho = Trie Char String

emptyMorpho :: Morpho
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

  comp = ccompute gr [] -- to undo 'values' optimization

  mkOne (Left (fun,c))  = map (prOne fun c) $ allLins fun
  mkOne (Right (fun,_)) = map (prSyn fun) $ allSyns fun
  
  -- gather forms of lexical items
  allLins fun@(m,f) = errVal [] $ do
    ts <- lookupLin gr (CIQ a f) >>= comp >>= allAllLinValues  
    ss <- mapM (mapPairsM (mapPairsM (liftM wordsInTerm . comp))) ts
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
prMorphoAnalysis (w,fs0) = 
  let fs = filter (not . null) fs0  in
  if null fs then w ++++ "*" else unlines (w:fs)

prMorphoAnalysisShort :: (String,[String]) -> String
prMorphoAnalysisShort (w,fs) = prBracket (w' ++ prTList "/" fs) where
  w' = if null fs then w +++ "*" else ""

tagPrt :: Print a => (a,a) -> String
tagPrt (m,c) = "+" ++ prt c --- module name

-- | print all words recognized
allMorphoWords :: Morpho -> [String]
allMorphoWords = map fst . collapse

-- analyse running text and show results either in short form or on separate lines

-- | analyse running text and show results in short form
morphoTextShort :: Morpho -> String -> String
morphoTextShort mo = unwords . map (prMorphoAnalysisShort . appMorpho mo) . words

-- | analyse running text and show results on separate lines
morphoText :: Morpho -> String -> String
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
