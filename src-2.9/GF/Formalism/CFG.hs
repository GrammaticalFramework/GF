----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/11 13:52:49 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- CFG formalism
-----------------------------------------------------------------------------

module GF.Formalism.CFG where

import GF.Formalism.Utilities
import GF.Infra.Print
import GF.Data.Assoc (accumAssoc)
import GF.Data.SortedList (groupPairs)
import GF.Data.Utilities (mapSnd)

------------------------------------------------------------
-- type definitions

type CFGrammar  c n t = [CFRule c n t]
data CFRule     c n t = CFRule c [Symbol c t] n
			deriving (Eq, Ord, Show)

type CFChart    c n t = CFGrammar (Edge c) n t


------------------------------------------------------------
-- building syntax charts from grammars

grammar2chart :: (Ord n, Ord e) => CFGrammar e n t -> SyntaxChart n e
grammar2chart cfchart = accumAssoc groupSyntaxNodes $
			[ (lhs, SNode name (filterCats rhs)) |
				     CFRule lhs rhs name <- cfchart ]


----------------------------------------------------------------------
-- pretty-printing

instance (Print n, Print c, Print t) => Print (CFRule c n t) where
    prt (CFRule cat rhs name) = prt name ++ " : " ++ prt cat ++ 
				( if null rhs then "" 
				  else " --> " ++ prtSep " " rhs )
    prtList = prtSep "\n"


