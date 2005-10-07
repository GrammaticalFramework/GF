----------------------------------------------------------------------
-- |
-- Module      : EmbedAPI
-- Maintainer  : Aarne Ranta
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 
-- > CVS $Author: 
-- > CVS $Revision: 
--
-- Reduced Application Programmer's Interface to GF, meant for
-- embedded GF systems. AR 10/5/2005
-----------------------------------------------------------------------------

module GF.Embed.EmbedAPI where

import GF.Compile.ShellState (ShellState,grammar2shellState,canModules,stateGrammarOfLang,abstract,grammar,firstStateGrammar,allLanguages,allCategories)
import GF.UseGrammar.Linear (linTree2string)
import GF.UseGrammar.GetTree (string2tree)
import GF.Embed.EmbedParsing (parseString)
import GF.Canon.CMacros (noMark)
import GF.Grammar.Grammar (Trm)
import GF.Grammar.MMacros (exp2tree)
import GF.Grammar.Macros (zIdent)
import GF.Grammar.PrGrammar (prt_)
import GF.Grammar.Values (tree2exp)
import GF.Grammar.TypeCheck (annotate)
import GF.Canon.GetGFC (getCanonGrammar)
import GF.Infra.Modules (emptyMGrammar)
import GF.CF.CFIdent (string2CFCat)
import GF.Infra.UseIO
import GF.Data.Operations
import GF.Infra.Option (noOptions,useUntokenizer)
import GF.Infra.Ident (prIdent)
import GF.Embed.EmbedCustom

-- This API is meant to be used when embedding GF grammars in Haskell 
-- programs. The embedded system is supposed to use the
-- .gfcm grammar format, which is first produced by the gf program.

---------------------------------------------------
-- Interface
---------------------------------------------------

type MultiGrammar = ShellState
type Language     = String
type Category     = String
type Tree         = Trm

file2grammar :: FilePath -> IO MultiGrammar

linearize    :: MultiGrammar -> Language -> Tree -> String
parse        :: MultiGrammar -> Language -> Category -> String -> [Tree]

linearizeAll :: MultiGrammar             -> Tree -> [String]
parseAll     :: MultiGrammar             -> Category -> String -> [[Tree]]

readTree     :: MultiGrammar -> String -> Tree
showTree     ::                 Tree -> String

languages    :: MultiGrammar -> [Language]
categories   :: MultiGrammar -> [Category]

---------------------------------------------------
-- Implementation
---------------------------------------------------

file2grammar file = do
  can <- useIOE (error "cannot parse grammar file") $ getCanonGrammar file
  return $ errVal (error "cannot build multigrammar") $ grammar2shellState noOptions (can,emptyMGrammar) 

linearize mgr lang = 
  untok .
  linTree2string noMark (canModules mgr) (zIdent lang) . 
  errVal (error "illegal tree") . 
  annotate gr
 where
   gr    = grammar sgr
   sgr   = stateGrammarOfLang mgr (zIdent lang)
   untok = customOrDefault noOptions useUntokenizer customUntokenizer sgr

parse mgr lang cat = 
  map tree2exp . 
  errVal [] . 
  parseString noOptions sgr cfcat
 where
   sgr   = stateGrammarOfLang mgr (zIdent lang)
   cfcat = string2CFCat abs cat
   abs   = maybe (error "no abstract syntax") prIdent $ abstract mgr

linearizeAll mgr t = [linearize mgr lang t | lang <- languages mgr]

parseAll mgr cat s = [parse mgr lang cat s | lang <- languages mgr]

readTree mgr s = tree2exp $ string2tree (firstStateGrammar mgr) s

showTree t  = prt_ t

languages mgr = [prt_ l | l <- allLanguages mgr]

categories mgr = [prt_ c | (_,c) <- allCategories mgr]
