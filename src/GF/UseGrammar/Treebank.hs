----------------------------------------------------------------------
-- |
-- Module      : Treebank
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- Generate multilingual treebanks. AR 8\/2\/2006
--
-- (c) Aarne Ranta 2006 under GNU GPL
--
-- Purpose: to generate treebanks.
-----------------------------------------------------------------------------

module GF.UseGrammar.Treebank (mkTreebank) where


import GF.Compile.ShellState (ShellState,grammar2shellState,canModules,stateGrammarOfLang,abstract,grammar,firstStateGrammar,allLanguages,allCategories)
import GF.UseGrammar.Linear (linTree2string)
import GF.UseGrammar.Custom
import GF.Canon.CMacros (noMark)
import GF.Grammar.Grammar (Trm)
import GF.Grammar.MMacros (exp2tree)
import GF.Grammar.Macros (zIdent)
import GF.Grammar.PrGrammar (prt_)
import GF.Grammar.Values (tree2exp)
import GF.Data.Operations
import GF.Infra.Option
import qualified GF.Grammar.Abstract as A

-- Generate a treebank with a multilingual grammar. AR 8/2/2006
-- (c) Aarne Ranta 2006 under GNU GPL

-- | the main function 
mkTreebank :: Options -> ShellState -> String -> [A.Tree] -> IO ()
mkTreebank opts sh com trees = putInXML opts "treebank" comm(mapM_ mkItem tris)
 where
   mkItem(t,i)= putInXML opts "item" (cat i)  (mkTree t >>mapM_ (mkLin t) langs)
   mkTree t   = putInXML opts "tree" []       (putStrLn $ showTree t)
   mkLin t lg = putInXML opts "lin" (lang lg) (putStrLn $ linearize sh lg t)

   langs   = [prt_ l | l <- allLanguages sh]
   comm    = "" --- " command=" ++ show com +++ "abstract=" ++ show abstr
   abstr   = "" --- "Abs" ----
   cat i   = " number=" ++ show (show i) --- " cat=" ++ show "S" ----
   lang lg = " lang=" ++ show (prt_ (zIdent lg))
   tris    = zip trees [1..]


putInXML :: Options -> String -> String -> IO () -> IO ()
putInXML opts tag attrs io = do
  ifXML $ putStrLn $ tagXML $ tag ++ attrs
  io
  ifXML $ putStrLn $ tagXML $ '/':tag
 where
  ifXML c = if oElem showXML opts then c else return ()

tagXML :: String -> String
tagXML s = "<" ++ s ++ ">"

--- these handy functions are borrowed from EmbedAPI

linearize mgr lang = 
  untok .
  linTree2string noMark (canModules mgr) (zIdent lang) 
 where
   sgr   = stateGrammarOfLang mgr (zIdent lang)
   untok = customOrDefault noOptions useUntokenizer customUntokenizer sgr

showTree t = prt_ $ tree2exp t
