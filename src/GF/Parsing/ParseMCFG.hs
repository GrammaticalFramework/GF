----------------------------------------------------------------------
-- |
-- Module      : ParseMCFG
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/21 14:17:43 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Main module for MCFG parsing
-----------------------------------------------------------------------------


module GF.Parsing.ParseMCFG (parse) where

import Char (toLower)
import GF.Parsing.Parser
import GF.Conversion.MCFGrammar
import qualified GF.Parsing.MCFParserBasic as PBas
import GF.Printing.PrintParser
---- import qualified MCFParserBasic2 as PBas2 -- file not found AR


parse :: (Ord n, Ord c, Ord l, Ord t,
	  Print n, Print c, Print l, Print t) => 
	 String -> MCFParser n c l t
parse str = decodeParser (map toLower str)

decodeParser "b"  = PBas.parse
---- decodeParser "c"  = PBas2.parse
decodeParser _    = decodeParser "c"




