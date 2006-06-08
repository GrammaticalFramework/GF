----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/09 09:28:44 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.3 $
--
-- Basic GCFG formalism (derived from Pollard 1984)
-----------------------------------------------------------------------------

module GF.Formalism.GCFG where

import GF.Formalism.Utilities (SyntaxChart)
import GF.Data.Assoc (assocMap, accumAssoc)
import GF.Data.SortedList (nubsort, groupPairs)
import GF.Infra.Print

----------------------------------------------------------------------

type Grammar c n l t  = [Rule c n l t]
data Rule    c n l t  = Rule (Abstract c n) (Concrete l t)
			deriving (Eq, Ord, Show)

data Abstract cat name = Abs cat [cat] name 
			 deriving (Eq, Ord, Show)
data Concrete lin term = Cnc lin [lin] term 
			 deriving (Eq, Ord, Show)

----------------------------------------------------------------------

instance (Print c, Print n, Print l, Print t) => Print (Rule n c l t) where
    prt (Rule abs cnc) = prt abs ++ " := " ++ prt cnc 
    prtList = prtSep "\n"

instance (Print c, Print n) => Print (Abstract c n) where
    prt (Abs cat args name) = prt name ++ ". " ++ prt cat ++ 
			      ( if null args then ""
				else " --> " ++ prtSep " " args )

instance (Print l, Print t) => Print (Concrete l t) where
    prt (Cnc lcat args term) = prt term 
			       ++ " : " ++ prt lcat ++ 
			       ( if null args then ""
			         else " / " ++ prtSep " " args)
