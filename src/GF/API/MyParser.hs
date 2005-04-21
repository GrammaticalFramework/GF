----------------------------------------------------------------------
-- |
-- Module      : MyParser
-- Maintainer  : Peter Ljunglöf
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:21:07 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.6 $
--
-- template to define your own parser (obsolete?)
-----------------------------------------------------------------------------

module GF.API.MyParser (myParser) where

import GF.Compile.ShellState
import GF.CF.CFIdent
import GF.CF.CF
import GF.Data.Operations

-- type CFParser = [CFTok] -> ([(CFTree,[CFTok])],String)

myParser :: StateGrammar -> CFCat -> CFParser
myParser gr cat toks = ([],"Would you like to add your own parser?")
