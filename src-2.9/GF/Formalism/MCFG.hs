----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/09 09:28:45 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
--
-- Definitions of multiple context-free grammars
-----------------------------------------------------------------------------

module GF.Formalism.MCFG where

import Control.Monad (liftM)
import Data.List (groupBy)

import GF.Formalism.Utilities
import GF.Formalism.GCFG

import GF.Infra.PrintClass


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

expandVariants :: Eq lbl => MCFRule cat name lbl tok -> [MCFRule cat name lbl tok]
expandVariants (Rule abs (Cnc typ typs lins)) = liftM (Rule abs . Cnc typ typs) $
						expandLins lins
    where expandLins = sequence . groupBy eqLbl 
	  eqLbl (Lin l1 _) (Lin l2 _) = l1 == l2


------------------------------------------------------------
-- pretty-printing

instance (Print c, Print l, Print t) => Print (Lin c l t) where
    prt (Lin lbl lin) = prt lbl ++ " = " ++ prtSep " " (map (symbol prArg (show.prt)) lin)
	where prArg (cat, lbl, nr) = prt cat ++ "@" ++ prt nr ++ prt lbl
    prtList = prtBefore "\n\t"



