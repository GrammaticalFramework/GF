----------------------------------------------------------------------
-- |
-- Module      : PrintParser
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:23:16 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.3 $
--
-- Pretty-printing of parser objects
-----------------------------------------------------------------------------

module GF.Printing.PrintParser (Print(..),
		    prtBefore, prtAfter, prtSep, 
		    prtBeforeAfter,
		    prIO
		   ) where

-- haskell modules:
import Data.List (intersperse)
-- gf modules:
import GF.Data.Operations (Err(..))
import GF.Infra.Ident (Ident(..))
import qualified GF.Canon.PrintGFC as P

------------------------------------------------------------

prtBefore :: Print a => String -> [a] -> String
prtBefore before = prtBeforeAfter before ""

prtAfter :: Print a => String -> [a] -> String
prtAfter after = prtBeforeAfter "" after

prtSep :: Print a => String -> [a] -> String
prtSep sep = concat . intersperse sep . map prt

prtBeforeAfter :: Print a => String -> String -> [a] -> String
prtBeforeAfter before after as = concat [ before ++ prt a ++ after | a <- as ]

prIO :: Print a => a -> IO ()
prIO = putStr . prt

class Print a where
    prt :: a -> String
    prtList :: [a] -> String
    prtList as = "[" ++ prtSep "," as ++ "]"

instance Print a => Print [a] where
    prt = prtList

instance (Print a, Print b) => Print (a, b) where
    prt (a, b) = "(" ++ prt a ++ "," ++ prt b ++ ")"

instance (Print a, Print b, Print c) => Print (a, b, c) where
    prt (a, b, c) = "(" ++ prt a ++ "," ++ prt b ++ "," ++ prt c ++ ")"

instance (Print a, Print b, Print c, Print d) => Print (a, b, c, d) where
    prt (a, b, c, d) = "(" ++ prt a ++ "," ++ prt b ++ "," ++ prt c ++ "," ++ prt d ++ ")"

instance Print Char where
    prt = return
    prtList = id

instance Print Int where
    prt = show

instance Print Integer where
    prt = show

instance Print a => Print (Maybe a) where
    prt (Just a) = "!" ++ prt a
    prt Nothing  = "Nothing"

instance Print a => Print (Err a) where
    prt (Ok a) = prt a
    prt (Bad str) = str

instance Print Ident where
    prt ident = str
	where str = P.printTree ident

