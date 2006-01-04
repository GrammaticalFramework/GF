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

module GF.Speech.PrSLF (slfPrinter,slfGraphvizPrinter) where

import GF.Data.Utilities
import GF.Conversion.Types
import GF.Formalism.CFG
import GF.Formalism.Utilities (Symbol(..),symbol)
import GF.Infra.Ident
import GF.Infra.Option
import GF.Infra.Print
import GF.Speech.CFGToFiniteState
import GF.Speech.FiniteState
import GF.Speech.SRG
import GF.Speech.TransformCFG
import qualified GF.Visualization.Graphviz as Dot

import Control.Monad
import qualified Control.Monad.State as STM
import Data.Char (toUpper)
import Data.List
import Data.Maybe (maybe)

data SLFs = SLFs [(String,SLF)] SLF

data SLF = SLF { slfNodes :: [SLFNode], slfEdges :: [SLFEdge] }

data SLFNode = SLFNode { nId :: Int, nWord :: SLFWord, nTag :: Maybe String }
             | SLFSubLat { nId :: Int, nLat :: String }

-- | An SLF word is a word, or the empty string.
type SLFWord = Maybe String

data SLFEdge = SLFEdge { eId :: Int, eStart :: Int, eEnd :: Int }

type SLF_FA = FA State (Maybe (MFALabel String)) ()

-- | Make a network with subnetworks in SLF
slfPrinter :: Ident -- ^ Grammar name
	   -> Options -> CGrammar -> String
slfPrinter name opts cfg = prSLFs (mfaToSLFs $ cfgToMFA opts cfg) ""

slfGraphvizPrinter :: Ident -- ^ Grammar name
	           -> Options -> CGrammar -> String
slfGraphvizPrinter name opts cfg = Dot.prGraphviz g
  where MFA main subs = cfgToMFA opts cfg
        g = Dot.addSubGraphs (map (uncurry gvSLFFA) subs) $ gvSLFFA "" main

gvSLFFA :: String -> DFA (MFALabel String) -> Dot.Graph
gvSLFFA n = faToGraphviz n . mapStates (maybe "" mfaLabelToGv) 
            . mapTransitions (const "") . slfStyleFA
  where mfaLabelToGv (MFASym s) = s
        mfaLabelToGv (MFASub s) = "<" ++ s ++ ">"

mapMFA :: (DFA (MFALabel a) -> b) -> MFA a -> (b,[(String,b)])
mapMFA f (MFA main subs) = (f main, [(c, f fa) | (c,fa) <- subs])

slfStyleFA :: DFA (MFALabel String) -> SLF_FA
slfStyleFA = oneFinalState Nothing () . moveLabelsToNodes . dfa2nfa

mfaToSLFs :: MFA String -> SLFs
mfaToSLFs (MFA main subs) 
    = SLFs [(c, dfaToSLF fa) | (c,fa) <- subs] (dfaToSLF main)
  where dfaToSLF = automatonToSLF . slfStyleFA

automatonToSLF :: SLF_FA -> SLF
automatonToSLF fa = SLF { slfNodes = ns, slfEdges = es }
  where ns = map (uncurry mfaNodeToSLFNode) (states fa)
        es = zipWith (\i (f,t,()) -> mkSLFEdge i (f,t)) [0..] (transitions fa)

mfaNodeToSLFNode :: Int -> Maybe (MFALabel String) -> SLFNode
mfaNodeToSLFNode i l = case l of
                                Nothing -> mkSLFNode i Nothing
                                Just (MFASym x) -> mkSLFNode i (Just x)
                                Just (MFASub s) -> mkSLFSubLat i s

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

prSLFs :: SLFs -> ShowS
prSLFs (SLFs subs main) = unlinesS (map prSub subs) . prOneSLF main
  where prSub (n,s) = showString "SUBLAT=" . shows n 
                      . nl . prOneSLF s . showString "." . nl

prSLF :: SLF -> ShowS
prSLF slf = {- showString "VERSION=1.0" . nl . -} prOneSLF slf

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
