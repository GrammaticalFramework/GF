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

module GF.UseGrammar.Treebank (
  mkMultiTreebank,
  mkUniTreebank,
  multi2uniTreebank,
  uni2multiTreebank,
  testMultiTreebank,
  treesTreebank,
  getTreebank,
  getUniTreebank,
  readUniTreebanks,
  readMultiTreebank,
  lookupTreebank,
  assocsTreebank,
  printAssoc
  ) where

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
import GF.Infra.Ident (Ident)
import GF.Infra.UseIO
import qualified GF.Grammar.Abstract as A
import qualified Data.Map as M

-- Generate a treebank with a multilingual grammar. AR 8/2/2006
-- (c) Aarne Ranta 2006 under GNU GPL

-- keys  are trees; format: XML file
type MultiTreebank = [(String,[(String,String)])]       -- tree,lang,lin

-- keys are strings; format: string TAB tree TAB ... TAB tree
type UniTreebank   = Treebank -- M.Map String [String]  -- string,tree

-- both formats can be read from both kinds of files
readUniTreebanks :: FilePath -> IO [(Ident,UniTreebank)]
readUniTreebanks file = do
  s <- readFileIf file
  return $ if isMultiTreebank s 
    then multi2uniTreebank $ getTreebank $ lines s
    else
      let tb = getUniTreebank $ lines s
      in [(zIdent (unsuffixFile file),tb)]

readMultiTreebank :: FilePath -> IO MultiTreebank
readMultiTreebank file = do
  s <- readFileIf file
  return $ if isMultiTreebank s 
    then getTreebank $ lines s
    else uni2multiTreebank (zIdent (unsuffixFile file)) $ getUniTreebank $ lines s

isMultiTreebank :: String -> Bool
isMultiTreebank s = take 10 s == "<treebank>" 

multi2uniTreebank :: MultiTreebank -> [(Ident,UniTreebank)]
multi2uniTreebank mt@((_,lls):_) = [(zIdent la, mkTb la) | (la,_) <- lls] where
  mkTb la = M.fromListWith (++) [(s,[t]) | (t,lls) <- mt, (l,s) <- lls, l==la]
multi2uniTreebank [] = []

uni2multiTreebank ::  Ident -> UniTreebank -> MultiTreebank
uni2multiTreebank la tb = 
  [(t,[(prt_ la, s)]) | (s,ts) <- assocsTreebank tb, t <- ts]

-- | the main functions 

-- builds a treebank where trees are the keys, and writes a file (opt. XML)
mkMultiTreebank :: Options -> ShellState -> String -> [A.Tree] -> Res
mkMultiTreebank opts sh com trees = putInXML opts "treebank" comm (concatMap mkItem tris)
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

-- builds a unilingual treebank where strings are the keys into an internal treebank

mkUniTreebank :: Options -> ShellState -> Language -> [A.Tree] -> Treebank
mkUniTreebank opts sh lg trees = M.fromListWith (++) [(lin t, [prt_ t]) | t <- trees]
 where
   lang  = prt_ lg 
   lin t = linearize sh lang t

-- reads a treebank and linearizes its trees again, printing all differences
testMultiTreebank :: Options -> ShellState -> String -> Res
testMultiTreebank opts sh = putInXML opts "testtreebank" [] . 
                            concatMap testOne . 
                            getTreebanks . lines
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

-- writes all the trees of the treebank
treesTreebank :: Options -> String -> [String]
treesTreebank _ = terms . getTreebank . lines where
  terms ts = [t | (t,_) <- ts]

-- string vs. IO
type Res = [String] -- IO ()
puts :: String -> Res
puts = return  -- putStrLn
ret = [] -- return ()
--

-- here strings are keys
assocsTreebank :: UniTreebank -> [(String,[String])]
assocsTreebank = M.assocs

printAssoc (s, ts) = s ++ concat ["\t" ++ t | t <- ts]

getTreebanks :: [String] -> [(String,String,String)]
getTreebanks = concatMap grps . getTreebank where
  grps (t,lls) = [(t,x,y) | (x,y) <- lls]

getTreebank :: [String] -> MultiTreebank
getTreebank ll = case ll of
  l:ls@(_:_:_) -> 
    let (l1,l2)   = getItem ls
        (tr,lins) = getTree l1
        lglins    = getLins lins
    in (tr,lglins) : getTreebank l2
  _ -> []
 where
   getItem = span ((/="</item") . take 6)

   getTree (_:ss) = 
     let (t1,t2) = span ((/="</tree") . take 6) ss in (last t1, drop 1 t2)

   getLins (beg:str:end:ss) = (getLang beg, str):getLins ss
   getLins _ = []

   getLang = takeWhile (/='"') . tail . dropWhile (/='"')

getUniTreebank :: [String] -> UniTreebank
getUniTreebank ls = M.fromListWith (++) [(s, ts) | s:ts <- map chop ls] where
  chop = chunks '\t'

lookupTreebank :: Treebank -> String -> [String]
lookupTreebank tb s = maybe [] id $ M.lookup s tb 

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
