----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/11 13:52:50 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Definitions of multiple context-free grammars
-----------------------------------------------------------------------------

module GF.Formalism.MCFG where

import GF.Formalism.Utilities
import GF.Formalism.GCFG

import GF.Infra.Print

------------------------------------------------------------
-- grammar types

-- | the lables in the linearization record should be in the same
-- order as specified by the linearization type @[lbl]@
type MCFGrammar cat name lbl tok = Grammar cat name [lbl] [Lin cat lbl tok]
type MCFRule    cat name lbl tok = Rule    cat name [lbl] [Lin cat lbl tok]

-- | variants are encoded as several linearizations with the same label
data Lin        cat      lbl tok = Lin lbl [Symbol (cat, lbl, Int) tok]
				   deriving (Eq, Ord, Show)

instantiateArgs :: [cat] -> Lin cat' lbl tok -> Lin cat lbl tok
instantiateArgs args (Lin lbl lin) = Lin lbl (map instSym lin)
    where instSym = mapSymbol instCat id
	  instCat (_, lbl, nr) = (args !! nr, lbl, nr)

------------------------------------------------------------
-- pretty-printing

instance (Print c, Print l, Print t) => Print (Lin c l t) where
    prt (Lin lbl lin) = prt lbl ++ " = " ++ prtSep " " (map (symbol prArg (show.prt)) lin)
	where prArg (cat, lbl, nr) = prt cat ++ "@" ++ prt nr ++ prt lbl
    prtList = prtBefore "\n\t"



