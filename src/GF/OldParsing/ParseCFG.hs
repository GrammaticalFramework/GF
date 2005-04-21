----------------------------------------------------------------------
-- |
-- Module      : ParseCFG
-- Maintainer  : PL
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:22:49 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- Main parsing module for context-free grammars
-----------------------------------------------------------------------------


module GF.OldParsing.ParseCFG (parse) where

import Data.Char (toLower)
import GF.OldParsing.Utilities
import GF.OldParsing.CFGrammar
import qualified GF.OldParsing.ParseCFG.General as PGen
import qualified GF.OldParsing.ParseCFG.Incremental as PInc


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




