----------------------------------------------------------------------
-- |
-- Module      : ParseMCFG
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/21 22:31:52 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.2 $
--
-- Main module for MCFG parsing
-----------------------------------------------------------------------------


module GF.Parsing.ParseMCFG (parse) where

import Char (toLower)
import GF.Parsing.Utilities
import GF.Parsing.MCFGrammar
import qualified GF.Parsing.ParseMCFG.Basic as PBas
import GF.Printing.PrintParser
---- import qualified MCFParserBasic2 as PBas2 -- file not found AR


parse :: (Ord n, Ord c, Ord l, Ord t,
	  Print n, Print c, Print l, Print t) => 
	 String -> MCFParser n c l t
parse str = decodeParser (map toLower str)

decodeParser "b"  = PBas.parse
---- decodeParser "c"  = PBas2.parse
decodeParser _    = decodeParser "b"




