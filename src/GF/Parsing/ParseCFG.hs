----------------------------------------------------------------------
-- |
-- Module      : ParseCFG
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/03/21 14:17:42 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.1 $
--
-- Main parsing module for context-free grammars
-----------------------------------------------------------------------------


module GF.Parsing.ParseCFG (parse) where

import Char (toLower)
import GF.Parsing.Parser
import GF.Conversion.CFGrammar
import qualified GF.Parsing.CFParserGeneral as PGen
import qualified GF.Parsing.CFParserIncremental as PInc


parse :: (Ord n, Ord c, Ord t, Show t) => 
	 String -> CFParser n c t
parse = decodeParser . map toLower

decodeParser ['g',s]   = PGen.parse (decodeStrategy s)
decodeParser ['i',s,f] = PInc.parse (decodeStrategy s, decodeFilter f)
decodeParser _ = decodeParser "ibn"

decodeStrategy 'b' = (True, False)
decodeStrategy 't' = (False, True)

decodeFilter 'a' = (True, True)
decodeFilter 'b' = (True, False)
decodeFilter 't' = (False, True)
decodeFilter 'n' = (False, False)




