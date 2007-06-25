----------------------------------------------------------------------
-- |
-- Module      : PrSLF
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/10 16:43:44 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.12 $
--
-- This module converts a CFG to an SLF finite-state network
-- for use with the ATK recognizer. The SLF format is described
-- in the HTK manual, and an example for use in ATK is shown
-- in the ATK manual.
--
-- FIXME: remove \/ warn \/ fail if there are int \/ string literal
-- categories in the grammar
-----------------------------------------------------------------------------

module GF.Speech.PrSLF (slfPrinter,slfGraphvizPrinter,
                        slfSubPrinter,slfSubGraphvizPrinter) where

import GF.Data.Utilities
import GF.Conversion.Types
import GF.Formalism.CFG
import GF.Formalism.Utilities (Symbol(..),symbol,mapSymbol)
import GF.Infra.Ident
import GF.Infra.Option (Options)
import GF.Infra.Print
import GF.Speech.CFGToFiniteState
import GF.Speech.FiniteState
import GF.Speech.TransformCFG
import qualified GF.Visualization.Graphviz as Dot
import GF.Compile.ShellState (StateGrammar)

import Control.Monad
import qualified Control.Monad.State as STM
import Data.Char (toUpper)
import Data.List
import Data.Maybe

data SLFs = SLFs [(String,SLF)] SLF

data SLF = SLF { slfNodes :: [SLFNode], slfEdges :: [SLFEdge] }

data SLFNode = SLFNode { nId :: Int, nWord :: SLFWord, nTag :: Maybe String }
             | SLFSubLat { nId :: Int, nLat :: String }

-- | An SLF word is a word, or the empty string.
type SLFWord = Maybe String

data SLFEdge = SLFEdge { eId :: Int, eStart :: Int, eEnd :: Int }

type SLF_FA = FA State (Maybe (MFALabel String)) ()

mkFAs :: Options -> StateGrammar -> (SLF_FA, [(String,SLF_FA)])
mkFAs opts s = (slfStyleFA main, [(c,slfStyleFA n) | (c,n) <- subs])
  where MFA start subs = {- renameSubs $ -} cfgToMFA opts s
        main = let (fa,s,f) = newFA_ in newTransition s f (Cat start) fa        

slfStyleFA :: Eq a => DFA a -> FA State (Maybe a) ()
slfStyleFA = renameStates [0..] . removeTrivialEmptyNodes . oneFinalState Nothing ()
             . moveLabelsToNodes . dfa2nfa

-- | Give sequential names to subnetworks.
renameSubs :: MFA String -> MFA String
renameSubs (MFA start subs) = MFA (newName start) subs'
  where newNames = zip (map fst subs) ["sub"++show n | n <- [0..]]
        newName s = lookup' s newNames
        subs' = [(newName s,renameLabels n) | (s,n) <- subs]
        renameLabels = mapTransitions (mapSymbol newName id)

--
-- * SLF graphviz printing (without sub-networks)
--

slfGraphvizPrinter :: Options -> StateGrammar -> String
slfGraphvizPrinter opts s
    = prFAGraphviz $ gvFA $ slfStyleFA $ cfgToFA' opts s
  where 
  gvFA = mapStates (fromMaybe "") . mapTransitions (const "")

--
-- * SLF graphviz printing (with sub-networks)
--

slfSubGraphvizPrinter :: Options -> StateGrammar -> String
slfSubGraphvizPrinter opts s = Dot.prGraphviz g
  where (main, subs) = mkFAs opts s
        g = STM.evalState (liftM2 Dot.addSubGraphs ss m) [0..] 
        ss = mapM (\ (c,f) -> gvSLFFA (Just c) f) subs
        m = gvSLFFA Nothing main

gvSLFFA :: Maybe String -> SLF_FA -> STM.State [State] Dot.Graph
gvSLFFA n fa = 
    liftM (mkCluster n . faToGraphviz . mapStates (maybe "" mfaLabelToGv) 
            . mapTransitions (const "")) (rename fa)
  where mfaLabelToGv = symbol ("#"++) id
        mkCluster Nothing = id
        mkCluster (Just x) 
            = Dot.setName ("cluster_"++x) . Dot.setAttr "label" x
        rename fa = do
                    names <- STM.get
                    let fa' = renameStates names fa
                        names' = unusedNames fa'
                    STM.put names'
                    return fa'

--
-- * SLF printing (without sub-networks)
--

slfPrinter :: Options -> StateGrammar -> String
slfPrinter opts s 
    = prSLF $ automatonToSLF mkSLFNode $ slfStyleFA $ cfgToFA' opts s

--
-- * SLF printing (with sub-networks)
--

-- | Make a network with subnetworks in SLF
slfSubPrinter :: Options -> StateGrammar -> String
slfSubPrinter opts s = prSLFs slfs
  where 
  (main,subs) = mkFAs opts s
  slfs = SLFs [(c, faToSLF fa) | (c,fa) <- subs] (faToSLF main)
  faToSLF = automatonToSLF mfaNodeToSLFNode

automatonToSLF :: (Int -> a -> SLFNode) -> FA State a () -> SLF
automatonToSLF mkNode fa = SLF { slfNodes = ns, slfEdges = es }
  where ns = map (uncurry mkNode) (states fa)
        es = zipWith (\i (f,t,()) -> mkSLFEdge i (f,t)) [0..] (transitions fa)

mfaNodeToSLFNode :: Int -> Maybe (MFALabel String) -> SLFNode
mfaNodeToSLFNode i l = case l of
                              Nothing -> mkSLFNode i Nothing
                              Just (Tok x) -> mkSLFNode i (Just x)
                              Just (Cat s) -> mkSLFSubLat i s

mkSLFNode :: Int -> Maybe String -> SLFNode
mkSLFNode i Nothing = SLFNode { nId = i, nWord = Nothing, nTag = Nothing }
mkSLFNode i (Just w)
    | isNonWord w = SLFNode { nId = i, 
                              nWord = Nothing, 
                              nTag = Just w }
    | otherwise = SLFNode { nId = i, 
                            nWord = Just (map toUpper w), 
                            nTag = Just w }

mkSLFSubLat :: Int -> String -> SLFNode
mkSLFSubLat i sub = SLFSubLat { nId = i, nLat = sub }

mkSLFEdge :: Int -> (Int,Int) -> SLFEdge
mkSLFEdge i (f,t) = SLFEdge { eId = i, eStart = f, eEnd = t }

prSLFs :: SLFs -> String
prSLFs (SLFs subs main) = unlinesS (map prSub subs ++ [prOneSLF main]) ""
  where prSub (n,s) = showString "SUBLAT=" . shows n 
                      . nl . prOneSLF s . showString "." . nl

prSLF :: SLF -> String
prSLF slf = prOneSLF slf ""

prOneSLF :: SLF -> ShowS
prOneSLF (SLF { slfNodes = ns, slfEdges = es}) 
    = header . unlinesS (map prNode ns) . nl . unlinesS (map prEdge es) . nl
    where
    header = prFields [("N",show (length ns)),("L", show (length es))] . nl
    prNode (SLFNode { nId = i, nWord = w, nTag = t })
            = prFields $ [("I",show i),("W",showWord w)] 
                         ++ maybe [] (\t -> [("s",t)]) t
    prNode (SLFSubLat { nId = i, nLat = l }) 
            = prFields [("I",show i),("L",show l)]
    prEdge e = prFields [("J",show (eId e)),("S",show (eStart e)),("E",show (eEnd e))]

-- | Check if a word should not correspond to a word in the SLF file.
isNonWord :: String -> Bool
isNonWord = any isPunct

isPunct :: Char -> Bool
isPunct c = c `elem` "-_.;.,?!()[]{}"

showWord :: SLFWord -> String
showWord Nothing = "!NULL"
showWord (Just w) | null w = "!NULL"
                  | otherwise = w

prFields :: [(String,String)] -> ShowS
prFields fs = unwordsS [ showString l . showChar '=' . showString v | (l,v) <- fs ]
