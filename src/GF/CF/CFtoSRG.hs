{- 
   **************************************************************
    GF Module
   
    Description   : This module prints a CF as a SRG (Speech 
                    Recognition Grammar).

    Author        : Markus Forsberg (markus@cs.chalmers.se)

    License       : GPL (GNU General Public License)

    Created       : 21 January, 2001                           

    Modified      : 16 April, 2004 by Aarne Ranta for GF 2
   ************************************************************** 
-}

module CFtoSRG where

import Operations
import CF
import CFIdent
---import UseGrammar
import PPrCF
import List (intersperse,nub)

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

