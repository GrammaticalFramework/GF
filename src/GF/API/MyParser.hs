module MyParser where

import ShellState
import CFIdent
import CF
import Operations

-- template to define your own parser

-- type CFParser = [CFTok] -> ([(CFTree,[CFTok])],String)

myParser :: StateGrammar -> CFCat -> CFParser
myParser gr cat toks = ([],"Would you like to add your own parser?")
