----------------------------------------------------------------------
-- |
-- Module      : CFtoSRG
-- Maintainer  : Markus Forsberg
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:21:10 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.6 $
--
-- This module prints a CF as a SRG (Speech Recognition Grammar).
-- Created : 21 January, 2001.
-- Modified : 16 April, 2004 by Aarne Ranta for GF 2.
-----------------------------------------------------------------------------

module GF.CF.CFtoSRG (prSRG) where

import GF.Data.Operations
import GF.CF.CF
import GF.CF.CFIdent
---import UseGrammar
import GF.CF.PPrCF
import Data.List (intersperse,nub)

header :: String
header = unlines ["#ABNF 1.0 ISO-8859-1;\n",
		  "language en;",
		  "mode voice;",
		  "root $Main;",
		  "meta \"author\" is \"Grammatical Framework\";\n"]

prSRG :: CF -> String
prSRG cf = (header ++) $ prSRGC (catsOfCF cf) cf

prSRGC :: [CFCat] -> CF -> String
prSRGC [] _      = []
prSRGC (c:cs) cf =  "$" ++ prCFCat c ++ " = " ++ items ++ ";\n"++ prSRGC cs cf
 where items    =   concat $ intersperse " | " $   
		    map f $ nub $ map valItemsCF (rulesForCFCat cf c)
       f [] = "$NULL"
       f xs = unwords $ map prSRGItem xs

prSRGItem :: CFItem -> [Char]
prSRGItem (CFNonterm c) = "$" ++ prCFCat c
prSRGItem (CFTerm a)    = prRegExp a

