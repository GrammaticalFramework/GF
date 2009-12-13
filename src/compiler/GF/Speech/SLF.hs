----------------------------------------------------------------------
-- |
-- Module      : GF.Speech.SLF
--
-- This module converts a CFG to an SLF finite-state network
-- for use with the ATK recognizer. The SLF format is described
-- in the HTK manual, and an example for use in ATK is shown
-- in the ATK manual.
--
-----------------------------------------------------------------------------

module GF.Speech.SLF (slfPrinter,slfGraphvizPrinter,
                        slfSubPrinter,slfSubGraphvizPrinter) where

import GF.Data.Utilities
import GF.Speech.CFG
import GF.Speech.FiniteState
import GF.Speech.CFG
import GF.Speech.CFGToFA
import GF.Speech.PGFToCFG
import qualified GF.Data.Graphviz as Dot
import PGF
import PGF.CId

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

type SLF_FA = FA State (Maybe CFSymbol) ()

mkFAs :: PGF -> CId -> (SLF_FA, [(String,SLF_FA)])
mkFAs pgf cnc = (slfStyleFA main, [(c,slfStyleFA n) | (c,n) <- subs])
  where MFA start subs = {- renameSubs $ -} cfgToMFA $ pgfToCFG pgf cnc
        main = let (fa,s,f) = newFA_ in newTransition s f (NonTerminal start) fa

slfStyleFA :: Eq a => DFA a -> FA State (Maybe a) ()
slfStyleFA = renameStates [0..] . removeTrivialEmptyNodes . oneFinalState Nothing ()
             . moveLabelsToNodes . dfa2nfa

-- | Give sequential names to subnetworks.
renameSubs :: MFA -> MFA
renameSubs (MFA start subs) = MFA (newName start) subs'
  where newNames = zip (map fst subs) ["sub"++show n | n <- [0..]]
        newName s = lookup' s newNames
        subs' = [(newName s,renameLabels n) | (s,n) <- subs]
        renameLabels = mapTransitions (mapSymbol newName id)

--
-- * SLF graphviz printing (without sub-networks)
--

slfGraphvizPrinter :: PGF -> CId -> String
slfGraphvizPrinter pgf cnc
    = prFAGraphviz $ gvFA $ slfStyleFA $ cfgToFA' $ pgfToCFG pgf cnc
  where 
  gvFA = mapStates (fromMaybe "") . mapTransitions (const "")

--
-- * SLF graphviz printing (with sub-networks)
--

slfSubGraphvizPrinter :: PGF -> CId -> String
slfSubGraphvizPrinter pgf cnc = Dot.prGraphviz g
  where (main, subs) = mkFAs pgf cnc
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

slfPrinter :: PGF -> CId -> String
slfPrinter pgf cnc
    = prSLF $ automatonToSLF mkSLFNode $ slfStyleFA $ cfgToFA' $ pgfToCFG pgf cnc

--
-- * SLF printing (with sub-networks)
--

-- | Make a network with subnetworks in SLF
slfSubPrinter :: PGF -> CId -> String
slfSubPrinter pgf cnc = prSLFs slfs
  where 
  (main,subs) = mkFAs pgf cnc
  slfs = SLFs [(c, faToSLF fa) | (c,fa) <- subs] (faToSLF main)
  faToSLF = automatonToSLF mfaNodeToSLFNode

automatonToSLF :: (Int -> a -> SLFNode) -> FA State a () -> SLF
automatonToSLF mkNode fa = SLF { slfNodes = ns, slfEdges = es }
  where ns = map (uncurry mkNode) (states fa)
        es = zipWith (\i (f,t,()) -> mkSLFEdge i (f,t)) [0..] (transitions fa)

mfaNodeToSLFNode :: Int -> Maybe CFSymbol -> SLFNode
mfaNodeToSLFNode i l = case l of
                              Nothing -> mkSLFNode i Nothing
                              Just (Terminal x) -> mkSLFNode i (Just x)
                              Just (NonTerminal s) -> mkSLFSubLat i s

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
