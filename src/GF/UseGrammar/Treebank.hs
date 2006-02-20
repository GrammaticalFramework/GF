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

module GF.UseGrammar.Treebank (mkTreebank,testTreebank) where

import GF.Compile.ShellState 
import GF.UseGrammar.Linear (linTree2string)
import GF.UseGrammar.Custom
import GF.UseGrammar.GetTree (string2tree)
import GF.Grammar.TypeCheck (annotate)
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

-- | the main functions 
mkTreebank :: Options -> ShellState -> String -> [A.Tree] -> Res
mkTreebank opts sh com trees = putInXML opts "treebank" comm (concatMap mkItem tris)
 where
   mkItem(t,i)= putInXML opts "item" (cat i)  (mkTree t ++ concatMap (mkLin t) langs)
--   mkItem(t,i)= putInXML opts "item" (cat i)  (mkTree t >>mapM_ (mkLin t) langs)
   mkTree t   = putInXML opts "tree" []       (puts $ showTree t)
   mkLin t lg = putInXML opts "lin" (lang lg) (puts $ linearize sh lg t)

   langs   = [prt_ l | l <- allLanguages sh]
   comm    = "" --- " command=" ++ show com +++ "abstract=" ++ show abstr
   abstr   = "" --- "Abs" ----
   cat i   = " number=" ++ show (show i) --- " cat=" ++ show "S" ----
   lang lg = " lang=" ++ show (prt_ (zIdent lg))
   tris    = zip trees [1..]

testTreebank :: Options -> ShellState -> String -> Res
testTreebank opts sh = putInXML opts "testtreebank" [] . concatMap testOne . getTreebank . lines
 where
  testOne (e,lang,str0) = do
    let tr = annot gr e
    let str = linearize sh lang tr
    if str == str0 then ret else putInXML opts "diff" [] $ concat [
      putInXML opts "tree" [] (puts $ showTree tr),
      putInXML opts "old"  (" lang=" ++ show (prt_ (zIdent lang))) $ puts str0,
      putInXML opts "new"  (" lang=" ++ show (prt_ (zIdent lang))) $ puts str
      ]
  gr = firstStateGrammar sh

-- string vs. IO
type Res = [String] -- IO ()
puts :: String -> Res
puts = return  -- putStrLn
ret = [] -- return ()
--

getTreebank :: [String] -> [(String,String,String)]
getTreebank ll = case ll of
  [] -> []
  l:ls -> 
    let (l1,l2)   = getItem ls
        (tr,lins) = getTree l1
        lglins    = getLins lins
    in [(tr,lang,str) | (lang,str) <- lglins] ++ getTreebank l2
 where
   getItem = span ((/="</item") . take 6)

   getTree (_:ss) = let (t1,t2) = span ((/="</tree") . take 6) ss in (last t1, drop 1 t2)

   getLins (beg:str:end:ss) = (getLang beg, str):getLins ss
   getLins _ = []

   getLang = takeWhile (/='"') . tail . dropWhile (/='"')

annot :: StateGrammar -> String -> A.Tree
annot gr s = errVal (error "illegal tree") $ do
  let t = tree2exp $ string2tree gr s
  annotate (grammar gr) t

putInXML :: Options -> String -> String -> Res -> Res
putInXML opts tag attrs io = 
  (ifXML $ puts $ tagXML $ tag ++ attrs) ++
  io ++
  (ifXML $ puts $ tagXML $ '/':tag)
 where
  ifXML c = if oElem showXML opts then c else []


tagXML :: String -> String
tagXML s = "<" ++ s ++ ">"

--- these handy functions are borrowed from EmbedAPI

linearize mgr lang = 
  untok .
  linTree2string noMark (canModules mgr) (zIdent lang) 
 where
   sgr   = stateGrammarOfLangOpt False mgr (zIdent lang)
   untok = customOrDefault (stateOptions sgr) useUntokenizer customUntokenizer sgr

showTree t = prt_ $ tree2exp t
