module MoreCustom where

import Operations
import Text
import Tokenize
import UseGrammar
import qualified UseSyntax as S
import ShellState
import Editing
import Paraphrases
import Option
import CF
import CFIdent --- (CFTok, tS)

import EBNF
import CFtoGrammar
import PPrCF

import CFtoHappy
import Morphology
import GrammarToHaskell
import GrammarToCanon (showCanon)
import GrammarToXML
import qualified SyntaxToLatex as L
import GFTex
import MkResource
import SeparateOper

-- the cf parsing algorithms
import ChartParser -- or some other CF Parser
import Earley -- such as this one
---- import HappyParser -- or this...

import qualified PPrSRG as SRG
import PPrGSL

import qualified TransPredCalc as PC

-- databases for customizable commands. AR 21/11/2001
-- Extends ../Custom.

moreCustomGrammarParser = 
  [
   (strCIm "gfl",  S.parseGrammar . extractGFLatex)   
  ,(strCIm "tex",  S.parseGrammar . extractGFLatex)
  ,(strCIm "ebnf", pAsGrammar pEBNFasGrammar)
  ,(strCIm "cf",   pAsGrammar pCFAsGrammar)
-- add your own grammar parsers here
  ]
 where
  -- use a parser with no imports or flags
  pAsGrammar p = err Bad (\g -> return (([],noOptions),g)) . p


moreCustomGrammarPrinter = 
  [
   (strCIm "happy",   cf2HappyS . stateCF)
  ,(strCIm "srg",     SRG.prSRG . stateCF)
  ,(strCIm "gsl",     prGSL . stateCF)
  ,(strCIm "gfhs",    show . stateGrammarST)
  ,(strCIm "haskell", grammar2haskell . st2grammar . stateGrammarST)
  ,(strCIm "xml",     unlines . prDTD . grammar2dtd . stateAbstract)
  ,(strCIm "fullform",prFullForm . stateMorpho)
  ,(strCIm "resource",prt . st2grammar . mkResourceGrammar . stateGrammarST)
  ,(strCIm "resourcetypes", 
      prt . operTypeGrammar . st2grammar . mkResourceGrammar . stateGrammarST)
  ,(strCIm "resourcedefs", 
      prt . operDefGrammar . st2grammar . mkResourceGrammar . stateGrammarST)
-- add your own grammar printers here
--- also include printing via grammar2syntax!
  ]

moreCustomMultiGrammarPrinter = []

moreCustomSyntaxPrinter = 
  [ 
    (strCIm "gf",    S.prSyntax) -- DEFAULT
   ,(strCIm "latex", L.syntax2latexfile)
-- add your own grammar printers here
  ]

moreCustomTermPrinter = 
  [ 
    (strCIm "xml",    \g t -> unlines $ prElementX $ term2elemx (stateAbstract g) t)
-- add your own term printers here
  ]

moreCustomTermCommand = 
  [
   (strCIm "predcalc",   \_ t -> PC.transfer t)
-- add your own term commands here
  ]

moreCustomEditCommand = 
  [
-- add your own edit commands here
  ]

moreCustomStringCommand = 
  [
-- add your own string commands here
  ]

moreCustomParser = 
  [
   (strCIm "chart",    chartParser . stateCF)
  ,(strCIm "earley",   earleyParser . stateCF)
--  ,(strCIm "happy",     const $ lexHaskell)
--  ,(strCIm "td",        const $ lexText)
-- add your own parsers here
  ]

moreCustomTokenizer = 
  [
-- add your own tokenizers here
  ]

moreCustomUntokenizer = 
  [
-- add your own untokenizers here
  ]

moreCustomUniCoding = 
  [
-- add your own codings here
  ]

strCIm = id
