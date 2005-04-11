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
-- Basic type declarations and functions to be used in grammar formalisms
-----------------------------------------------------------------------------


module GF.Formalism.Symbol where

import GF.Infra.Print

------------------------------------------------------------
-- symbols

data Symbol c t = Cat c | Tok t
		  deriving (Eq, Ord, Show)

symbol :: (c -> a) -> (t -> a) -> Symbol c t -> a
symbol fc ft (Cat cat) = fc cat
symbol fc ft (Tok tok) = ft tok

mapSymbol :: (c -> d) -> (t -> u) -> Symbol c t -> Symbol d u
mapSymbol fc ft = symbol (Cat . fc) (Tok . ft)

------------------------------------------------------------
-- pretty-printing

instance (Print c, Print t) => Print (Symbol c t) where
    prt = symbol prt (simpleShow . prt)
	where simpleShow str = "\"" ++ concatMap mkEsc str ++ "\""
	      mkEsc '\\' = "\\\\"
	      mkEsc '\"' = "\\\""
	      mkEsc '\n' = "\\n"
	      mkEsc '\t' = "\\t"
	      mkEsc chr  = [chr]
    prtList = prtSep " "



