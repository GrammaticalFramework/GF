-- if a sense is split in the abstract syntax, create baseline implementations by copying the old lin rules
--
-- usage: writeSplitsFile "Dictionary.gf" "DictionarySwe.gf"
--
-- then open MergeDict.hs and do: mergeDict "DictionarySwe.gf" "tmp/splitDictionarySwe.gf" POld Nothing "tmp/DictionarySwe.gf"
--
-- AR 8 June 2015

import Data.Char
import qualified Data.Map as M
import qualified Data.Set as S

type Fun = String
type Cat = String
type Sense = String
type Rule = String

analyseFun :: Fun -> (Fun, Maybe Sense, Cat)
analyseFun = split . reverse where
  split nuf = case break (=='_') nuf of
    (tac, '_':'c':'s':'a':'M':w)    -> (reverse w, Just "Masc", reverse tac)
    (tac, '_':'m':'e':'F'    :w)    -> (reverse w, Just "Fem",  reverse tac)
    (tac, '_':d:'_' :w) | isDigit d -> (reverse w, Just [d],    reverse tac)
    (tac, '_':w)                    -> (reverse w, Nothing,     reverse tac)
    _ -> (reverse nuf, Nothing, "") ---- should not happen

mkFun :: (Fun, Maybe Sense, Cat) -> Fun
mkFun (f,ms,c) = f ++ s ++ "_" ++ c where
  s = case ms of
    Just g | elem s ["Masc","Fem"] -> g
    Just i -> "_" ++ i  -- integer index
    _ -> ""

unsplitFun :: Fun -> Fun
unsplitFun f = let (w,_,c) = analyseFun f in mkFun (w,Nothing,c)

isSplitFun :: Fun -> Bool
isSplitFun f = case analyseFun f of
  (_,ms,_) -> maybe False (const True) ms


allSplitFuns :: FilePath -> IO [Fun]
allSplitFuns absfile = do
  ls <- readFile absfile >>= return . lines
  return [f | "fun":f:_ <- map words ls, isSplitFun f]

baselineLinSplitFuns :: [Fun] -> FilePath -> IO [Rule]
baselineLinSplitFuns funs cncfile = do
  let funset = S.fromList (funs ++ map unsplitFun funs)
  ls <- readFile cncfile >>= return . lines
  let lmap = M.fromList [(f,unwords ws) | "lin":f:ws <- map words ls, S.member f funset]
  let look f = case M.lookup f lmap of
        Just l -> (l,False)
        _ -> case M.lookup (unsplitFun f) lmap of
          Just l -> (l ++ " ---- sense to be split", True)
          _ -> ("= variants {} ; ---- sense to be split",True)
  return [unwords ["lin",f,l] | f <- funs, let (l,notYet) = look f, notYet] 

writeSplitsFile :: FilePath -> FilePath -> IO ()
writeSplitsFile abs cnc = do
  fs <- allSplitFuns abs
  rs <- baselineLinSplitFuns fs cnc
  writeFile ("tmp/split"++cnc) (unlines rs)

