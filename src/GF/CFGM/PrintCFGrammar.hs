----------------------------------------------------------------------
-- |
-- Module      : PrintCFGrammar
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/21 14:27:10 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.11 $
--
-- Handles printing a CFGrammar in CFGM format.
-----------------------------------------------------------------------------

module PrintCFGrammar (prCanonAsCFGM) where

import AbsGFC
import qualified PrintCFG
import Ident
import GFC
import Modules
import qualified GF.Conversion.ConvertGrammar as Cnv
import qualified GF.Printing.PrintParser as Prt
import qualified GF.Conversion.CFGrammar as CFGrammar
import qualified GF.Conversion.GrammarTypes as GT
import qualified AbsCFG
import qualified GF.Parsing.Parser as Parser
import ErrM
import qualified Option

import List (intersperse)
import Maybe (listToMaybe, maybe)

-- | FIXME: fix warning about bad -printer= value
prCanonAsCFGM :: CanonGrammar -> String
prCanonAsCFGM gr = unlines $ map (uncurry (prLangAsCFGM gr)) xs 
    where 
    cncs = maybe [] (allConcretes gr) (greatestAbstract gr)
    cncms = map (\i -> (i,fromOk (lookupModule gr i))) cncs
    fromOk (Ok x) = x
    fromOk (Bad y) = error y
    xs = [(i,getFlag fs "startcat") | (i,ModMod (Module{flags=fs})) <- cncms]

-- | FIXME: need to look in abstract module too
getFlag :: [Flag] -> String -> Maybe String
getFlag fs x = listToMaybe [v | Flg (IC k) (IC v) <- fs, k == x]

-- | OBS! Should use 'ShellState.statePInfo' or 'ShellState.pInfos'
-- instead of 'Cnv.pInfo' (which recalculates the grammar every time)
prLangAsCFGM :: CanonGrammar -> Ident -> Maybe String -> String
prLangAsCFGM gr i start = prCFGrammarAsCFGM (Cnv.cfg (Cnv.pInfo opts gr i)) i start
    where opts = Option.Opts [Option.gfcConversion "nondet"]

{-
prCFGrammarAsCFGM :: GT.CFGrammar -> Ident -> Maybe String -> String
prCFGrammarAsCFGM gr i@(IC lang) start = (header . startcat . rules . footer) ""
    where
    header = showString "grammar " . showString lang . showString "\n"
    startcat = maybe id (\s -> showString "startcat " . showString (s++"{}.s") . showString ";\n") start
    rules0 = map Prt.prt gr
    rules = showString $ concat $ map (\l -> init l++";\n") rules0
    footer = showString "end grammar\n"
-}

prCFGrammarAsCFGM :: GT.CFGrammar -> Ident -> Maybe String -> String
prCFGrammarAsCFGM gr i start = PrintCFG.printTree $ cfGrammarToCFGM gr i start

cfGrammarToCFGM :: GT.CFGrammar -> Ident -> Maybe String -> AbsCFG.Grammar
cfGrammarToCFGM gr i start = AbsCFG.Grammar (identToCFGMIdent i) flags (map ruleToCFGMRule gr)
    where flags = maybe [] (\c -> [AbsCFG.StartCat $ strToCFGMCat (c++"{}.s")]) start

ruleToCFGMRule :: GT.CFRule -> AbsCFG.Rule
-- new version, without the MCFName constructor:
ruleToCFGMRule (CFGrammar.Rule c rhs (GT.CFName fun profile)) 
    = AbsCFG.Rule fun' p' c' rhs'
    where 
    fun' = identToFun fun
    p' = profileToCFGMProfile profile
    c' = catToCFGMCat c
    rhs' = map symbolToGFCMSymbol rhs

{- old version, with the MCFName constructor:
ruleToCFGMRule (CFGrammar.Rule c rhs (GT.CFName (GT.MCFName fun cat args) lbl profile)) 
    = AbsCFG.Rule fun' n' p' c' rhs'
    where 
    fun' = identToCFGMIdent fun
    n' = strToCFGMName (Prt.prt cat ++ concat [ "/" ++ Prt.prt arg | arg <- args ] ++ Prt.prt lbl)
    p' = profileToCFGMProfile profile
    c' = catToCFGMCat c
    rhs' = map symbolToGFCMSymbol rhs
-}

profileToCFGMProfile :: GT.CFProfile -> AbsCFG.Profile
profileToCFGMProfile = AbsCFG.Profile . map (AbsCFG.Ints . map fromIntegral)

identToCFGMIdent :: Ident -> AbsCFG.Ident
identToCFGMIdent = AbsCFG.Ident . Prt.prt

identToFun :: Ident -> AbsCFG.Fun
identToFun IW = AbsCFG.Coerce
identToFun i = AbsCFG.Cons (identToCFGMIdent i)

strToCFGMCat :: String -> AbsCFG.Category
strToCFGMCat = AbsCFG.Category . AbsCFG.SingleQuoteString . quoteSingle

catToCFGMCat :: GT.CFCat -> AbsCFG.Category
catToCFGMCat = strToCFGMCat . Prt.prt

symbolToGFCMSymbol :: Parser.Symbol GT.CFCat GT.Tokn -> AbsCFG.Symbol
symbolToGFCMSymbol (Parser.Cat c) = AbsCFG.CatS (catToCFGMCat c)
symbolToGFCMSymbol (Parser.Tok t) = AbsCFG.TermS (Prt.prt t)

quoteSingle :: String -> String
quoteSingle s = "'" ++ escapeSingle s ++ "'"
    where escapeSingle = concatMap (\c -> if c == '\'' then "\\'" else [c])
