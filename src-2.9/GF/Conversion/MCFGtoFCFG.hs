----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/09 09:28:43 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.6 $
--
-- Converting MCFG grammars to equivalent optimized FCFG
-----------------------------------------------------------------------------


module GF.Conversion.MCFGtoFCFG
    (convertGrammar) where

import Control.Monad
import List (elemIndex)
import Array

import GF.Formalism.Utilities
import GF.Formalism.GCFG
import GF.Formalism.MCFG
import GF.Formalism.FCFG
import GF.Conversion.Types
import GF.Data.SortedList (nubsort)

import GF.Infra.Print

----------------------------------------------------------------------
-- * converting MCFG to optimized FCFG

convertGrammar :: MGrammar -> FGrammar
convertGrammar gram = [ FRule (Abs (fcat cat) (map fcat cats) name) (fcnc cnc) |
                        Rule (Abs cat cats name) cnc <- gram ]
    where mcats = nubsort [ mc | Rule (Abs mcat mcats _) _ <- gram, mc <- mcat:mcats ]

          fcat mcat@(MCat (ECat scat ecns) mlbls) 
              = case elemIndex mcat mcats of
                  Just catid -> FCat catid scat mlbls ecns
                  Nothing -> error ("MCFGtoFCFG.fcat " ++ prt mcat)

          fcnc (Cnc  _ arglbls lins) = listArray (0, length lins-1) (map flin lins)
              where flin (Lin _ syms) = listArray (0, length syms-1) (map fsym syms)
                    fsym (Tok tok) = FSymTok tok
                    fsym (Cat (cat,lbl,arg)) = FSymCat (fcat cat) (flbl arg lbl) arg
                    flbl arg lbl = case elemIndex lbl (arglbls !! arg) of
                                     Just lblid -> lblid
                                     Nothing -> error ("MCFGtoFCFG.flbl " ++ prt arg ++ " " ++ prt lbl)
 
