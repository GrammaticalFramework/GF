import qualified Data.Map
import Data.List

createConcrete lang = do
  bnc <- readFile "bnc-to-check.txt" >>= return . words                                -- list of BNC funs
  dict <- readFile (gfFile "Dictionary" lang) >>= return . lines                       -- current lang lexicon
  let header = getHeader dict
  let dictmap = Data.Map.fromList [(f,unwords ws) | "lin":f:"=":ws <- map words dict]
  let bncdict = [(f,maybe "variants{} ;" id $ Data.Map.lookup f dictmap) | f <- bnc]   -- current lang for BNC
  writeFile (gfFile "todo/tmp/Dictionary" lang) $ 
    unlines $ header ++ [unwords ("lin":f:"=":[ws]) | (f,ws) <- bncdict] ++ ["}"]      -- print inspectable file, to todo/tmp/

gfFile body lang = body ++ lang ++ ".gf"

mergeDict lang = do
  old <- readFile (gfFile      "Dictionary" lang) >>= return . lines                      -- read old lexicon
  new <- readFile (gfFile "todo/Dictionary" lang) >>= return . lines                      -- read corrected and new words
  let header = getHeader new
  let oldmap = Data.Map.fromList [(f,unwords ws) | "lin":f:"=":ws <- map words old]
  let newlist = [(f,unwords (takeWhile (/= "--") ws)) | "lin":f:"=":ws <- map words new]  -- drop comments from corrected words
  let newmap = foldr (uncurry Data.Map.insert) oldmap newlist                             -- insert corrected words
  writeFile (gfFile "tmp/Dictionary" lang) $ 
    unlines $ header ++ [unwords ("lin":f:"=":[ws]) | (f,ws) <- Data.Map.assocs newmap] ++ ["}"]  -- print revised file to tmp/

-- get the part of Dict before the first lin rule
getHeader = takeWhile ((/= "lin") . take 3)

