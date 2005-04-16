----------------------------------------------------------------------
-- |
-- Module      : PrintCFGrammar
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/16 05:40:50 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.16 $
--
-- Handles printing a CFGrammar in CFGM format.
-----------------------------------------------------------------------------

module PrintCFGrammar (prCanonAsCFGM) where

import AbsGFC
import qualified PrintCFG
import Ident
import GFC
import Modules

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

-- | FIXME: should add an Options argument,
-- to be able to decide which CFG conversion one wants to use
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

-- | FIXME: (1) Should use 'ShellState.stateCFG'
-- instead of 'Cnv.gfc2cfg' (which recalculates the grammar every time)
--
-- FIXME: (2) Should use the state options, when calculating the CFG
-- (this is solved automatically if one solves (1) above)
prLangAsCFGM :: CanonGrammar -> Ident -> Maybe String -> String
prLangAsCFGM gr i start = prCFGrammarAsCFGM (Cnv.gfc2cfg opts (gr, i)) i start
-- prLangAsCFGM gr i start = prCFGrammarAsCFGM (Cnv.cfg (Cnv.pInfo opts gr i)) i start
     where opts = Option.Opts [Option.gfcConversion "nondet"]

prCFGrammarAsCFGM :: GT.CGrammar -> Ident -> Maybe String -> String
prCFGrammarAsCFGM gr i start = PrintCFG.printTree $ cfGrammarToCFGM gr i start

cfGrammarToCFGM :: GT.CGrammar -> Ident -> Maybe String -> AbsCFG.Grammar
cfGrammarToCFGM gr i start = AbsCFG.Grammar (identToCFGMIdent i) flags (map ruleToCFGMRule gr)
    where flags = maybe [] (\c -> [AbsCFG.StartCat $ strToCFGMCat (c++"{}.s")]) start

ruleToCFGMRule :: GT.CRule -> AbsCFG.Rule
ruleToCFGMRule (CFRule c rhs (GT.Name fun profile)) 
    = AbsCFG.Rule fun' p' c' rhs'
    where 
    fun' = identToFun fun
    p' = profileToCFGMProfile profile
    c' = catToCFGMCat c
    rhs' = map symbolToGFCMSymbol rhs

profileToCFGMProfile :: [GT.Profile a] -> AbsCFG.Profile
profileToCFGMProfile = AbsCFG.Profile . map cnvProfile
    where cnvProfile (GT.Unify ns)   = AbsCFG.Ints $ map fromIntegral ns
	  cnvProfile (GT.Constant a) = AbsCFG.Ints []
	  -- FIXME: this should be replaced with a new constructor in 'AbsCFG'

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
