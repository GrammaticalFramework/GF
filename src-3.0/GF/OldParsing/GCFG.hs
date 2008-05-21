----------------------------------------------------------------------
-- |
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/11 13:52:53 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Simplistic GFC format
-----------------------------------------------------------------------------

module GF.OldParsing.GCFG where

import GF.Printing.PrintParser

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
    prt (Rule abs cnc) = prt abs ++ " := " ++ prt cnc ++ "\n"
    prtList = concatMap prt

instance (Print c, Print n) => Print (Abstract c n) where
    prt (Abs cat args name) = prt name ++ ". " ++ prt cat ++ 
			      ( if null args then ""
				else " -> " ++ prtSep " " args )

instance (Print l, Print t) => Print (Concrete l t) where
    prt (Cnc lcat args term) = prt term ++ " : " ++ prt lcat ++ 
			      ( if null args then ""
				else " [ " ++ prtSep " " args ++ " ]" )
