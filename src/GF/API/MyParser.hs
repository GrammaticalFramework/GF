----------------------------------------------------------------------
-- |
-- Module      : MyParser
-- Maintainer  : Peter Ljunglöf
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/02/18 19:21:06 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.5 $
--
-- template to define your own parser (obsolete?)
-----------------------------------------------------------------------------

module MyParser (myParser) where

import ShellState
import CFIdent
import CF
import Operations

-- type CFParser = [CFTok] -> ([(CFTree,[CFTok])],String)

myParser :: StateGrammar -> CFCat -> CFParser
myParser gr cat toks = ([],"Would you like to add your own parser?")
