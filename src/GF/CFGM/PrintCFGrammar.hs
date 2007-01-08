----------------------------------------------------------------------
-- |
-- Module      : PrintCFGrammar
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/17 14:04:38 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.20 $
--
-- Handles printing a CFGrammar in CFGM format.
-----------------------------------------------------------------------------

module GF.CFGM.PrintCFGrammar (prCanonAsCFGM) where

import GF.Canon.AbsGFC
import qualified GF.CFGM.PrintCFG as PrintCFG
import GF.Infra.Ident
import GF.Canon.GFC
import GF.Infra.Modules

import qualified GF.Conversion.GFC as Cnv
import GF.Infra.Print (prt)
import GF.Formalism.CFG (CFRule(..))
import qualified GF.Formalism.Utilities as GU
import qualified GF.Conversion.Types as GT
import qualified GF.CFGM.AbsCFG as AbsCFG
import GF.Formalism.Utilities (Symbol(..))

import GF.Data.ErrM
import GF.Data.Utilities (compareBy)
import qualified GF.Infra.Option as Option

import Data.List (intersperse, sortBy)
import Data.Maybe (listToMaybe, maybeToList, maybe)

import GF.Infra.Print
import GF.System.Tracing

-- | FIXME: should add an Options argument,
-- to be able to decide which CFG conversion one wants to use
prCanonAsCFGM :: Option.Options -> CanonGrammar -> String
prCanonAsCFGM opts gr = unlines $ map (prLangAsCFGM gr) xs 
    where 
    cncs = maybe [] (allConcretes gr) (greatestAbstract gr)
    cncms = map (\i -> (i,fromOk (lookupModule gr i))) cncs
    fromOk (Ok x) = x
    fromOk (Bad y) = error y
    xs = tracePrt "CFGM languages" (prtBefore "\n") 
	 [ (i, getFlag fs "startcat", getFlag fs "conversion") | 
	   (i, ModMod (Module{flags=fs})) <- cncms ]

-- | FIXME: need to look in abstract module too
getFlag :: [Flag] -> String -> Maybe String
getFlag fs x = listToMaybe [v | Flg (IC k) (IC v) <- fs, k == x]

-- FIXME: (1) Should use 'ShellState.stateCFG'
-- instead of 'Cnv.gfc2cfg' (which recalculates the grammar every time)
--
-- FIXME: (2) Should use the state options, when calculating the CFG
-- (this is solved automatically if one solves (1) above)
prLangAsCFGM :: CanonGrammar -> (Ident, Maybe String, Maybe String) -> String
prLangAsCFGM gr (i, start, cnv) = prCFGrammarAsCFGM (Cnv.gfc2cfg opts (gr, i)) i start
-- prLangAsCFGM gr i start = prCFGrammarAsCFGM (Cnv.cfg (Cnv.pInfo opts gr i)) i start
     where opts = Option.Opts $ maybeToList $ fmap Option.gfcConversion cnv

prCFGrammarAsCFGM :: GT.CGrammar -> Ident -> Maybe String -> String
prCFGrammarAsCFGM gr i start = PrintCFG.printTree $ cfGrammarToCFGM gr i start

cfGrammarToCFGM :: GT.CGrammar -> Ident -> Maybe String -> AbsCFG.Grammar
cfGrammarToCFGM gr i start = 
    AbsCFG.Grammar (identToCFGMIdent i) flags $ sortCFGMRules $ map ruleToCFGMRule gr
    where flags = maybe [] (\c -> [AbsCFG.StartCat $ strToCFGMCat (c++"{}.s")]) start
          sortCFGMRules = sortBy (compareBy ruleKey)
          ruleKey (AbsCFG.Rule f ps cat rhs) = (cat,f)

ruleToCFGMRule :: GT.CRule -> AbsCFG.Rule
ruleToCFGMRule (CFRule c rhs (GU.Name fun profile)) 
    = AbsCFG.Rule fun' p' c' rhs'
    where 
    fun' = identToFun fun
    p' = profileToCFGMProfile profile
    c' = catToCFGMCat c
    rhs' = map symbolToGFCMSymbol rhs

profileToCFGMProfile :: [GU.Profile (GU.SyntaxForest GT.Fun)] -> AbsCFG.Profiles
profileToCFGMProfile = AbsCFG.Profiles . map cnvProfile
    where cnvProfile (GU.Unify ns)   = AbsCFG.UnifyProfile $ map fromIntegral ns
	  -- FIXME: is it always FNode?
	  cnvProfile (GU.Constant (GU.FNode c _)) = AbsCFG.ConstProfile $ identToCFGMIdent c
						  

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
