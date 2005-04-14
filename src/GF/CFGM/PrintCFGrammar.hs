----------------------------------------------------------------------
-- |
-- Module      : PrintCFGrammar
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/14 18:38:36 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.14 $
--
-- Handles printing a CFGrammar in CFGM format.
-----------------------------------------------------------------------------

module PrintCFGrammar (prCanonAsCFGM) where

import AbsGFC
import qualified PrintCFG
import Ident
import GFC
import Modules

-- import qualified GF.OldParsing.ConvertGrammar as Cnv
-- import qualified GF.Printing.PrintParser as Prt
-- import qualified GF.OldParsing.CFGrammar as CFGrammar
-- import qualified GF.OldParsing.GrammarTypes as GT
-- import qualified AbsCFG
-- import qualified GF.OldParsing.Utilities as Parser
import qualified GF.Conversion.GFC as Cnv
import GF.Infra.Print (prt)
import GF.Formalism.CFG (CFRule(..))
import qualified GF.Conversion.Types as GT
import qualified AbsCFG
import GF.Formalism.Utilities (Symbol(..))

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
prLangAsCFGM gr i start = prCFGrammarAsCFGM (Cnv.gfc2cfg (gr, i)) i start
-- prLangAsCFGM gr i start = prCFGrammarAsCFGM (Cnv.cfg (Cnv.pInfo opts gr i)) i start
--     where opts = Option.Opts [Option.gfcConversion "nondet"]

{-
prCFGrammarAsCFGM :: GT.CFGrammar -> Ident -> Maybe String -> String
prCFGrammarAsCFGM gr i@(IC lang) start = (header . startcat . rules . footer) ""
    where
    header = showString "grammar " . showString lang . showString "\n"
    startcat = maybe id (\s -> showString "startcat " . showString (s++"{}.s") . showString ";\n") start
    rules0 = map prt gr
    rules = showString $ concat $ map (\l -> init l++";\n") rules0
    footer = showString "end grammar\n"
-}

prCFGrammarAsCFGM :: GT.CGrammar -> Ident -> Maybe String -> String
prCFGrammarAsCFGM gr i start = PrintCFG.printTree $ cfGrammarToCFGM gr i start

cfGrammarToCFGM :: GT.CGrammar -> Ident -> Maybe String -> AbsCFG.Grammar
cfGrammarToCFGM gr i start = AbsCFG.Grammar (identToCFGMIdent i) flags (map ruleToCFGMRule gr)
    where flags = maybe [] (\c -> [AbsCFG.StartCat $ strToCFGMCat (c++"{}.s")]) start

ruleToCFGMRule :: GT.CRule -> AbsCFG.Rule
-- new version, without the MCFName constructor:
ruleToCFGMRule (CFRule c rhs (GT.Name fun profile)) 
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
    n' = strToCFGMName (prt cat ++ concat [ "/" ++ prt arg | arg <- args ] ++ prt lbl)
    p' = profileToCFGMProfile profile
    c' = catToCFGMCat c
    rhs' = map symbolToGFCMSymbol rhs
-}

profileToCFGMProfile :: [GT.Profile a] -> AbsCFG.Profile
profileToCFGMProfile = AbsCFG.Profile . map cnvProfile
    where cnvProfile (GT.Unify ns)   = AbsCFG.Ints $ map fromIntegral ns
	  cnvProfile (GT.Constant a) = AbsCFG.Ints []
	  -- this should be replaced with a new constructor in 'AbsCFG'

identToCFGMIdent :: Ident -> AbsCFG.Ident
identToCFGMIdent = AbsCFG.Ident . prt

identToFun :: Ident -> AbsCFG.Fun
identToFun IW = AbsCFG.Coerce
identToFun i = AbsCFG.Cons (identToCFGMIdent i)

strToCFGMCat :: String -> AbsCFG.Category
strToCFGMCat = AbsCFG.Category . AbsCFG.SingleQuoteString . quoteSingle

catToCFGMCat :: GT.CCat -> AbsCFG.Category
catToCFGMCat = strToCFGMCat . prt

symbolToGFCMSymbol :: Symbol GT.CCat GT.Token -> AbsCFG.Symbol
symbolToGFCMSymbol (Cat c) = AbsCFG.CatS (catToCFGMCat c)
symbolToGFCMSymbol (Tok t) = AbsCFG.TermS (prt t)

quoteSingle :: String -> String
quoteSingle s = "'" ++ escapeSingle s ++ "'"
    where escapeSingle = concatMap (\c -> if c == '\'' then "\\'" else [c])
