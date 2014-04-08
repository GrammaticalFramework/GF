import qualified Data.Map

createConcrete lang = do
  bnc <- readFile "bnc-to-check.txt" >>= return . words                                          -- list of BNC funs
  dict <- readFile (gfFile "Dictionary" lang) >>= return . map words . lines                     -- current lang lexicon
  let dictmap = Data.Map.fromList [(f,unwords ws) | "lin":f:"=":ws <- dict]
  let bncdict = [(f,maybe "variants{} ;" id $ Data.Map.lookup f dictmap) | f <- bnc]             -- current lang for BNC
  writeFile (gfFile "todo/TopDict" lang) $ unlines [unwords ("lin":f:"=":[ws]) | (f,ws) <- bncdict]   -- print inspectable file

gfFile body lang = body ++ lang ++ ".gf"


mergeDict lang = do
  old <- readFile (gfFile "Dictionary" lang) >>= return . map words . lines       -- read old lexicon
  new <- readFile "corrects.txt" >>= return . map words . lines         -- read corrected and new words
  let oldmap = Data.Map.fromList [(f,unwords ws) | "lin":f:"=":ws <- old]
  let newlist = [(f,unwords (takeWhile (/= "--") ws)) | "lin":f:"=":ws <- new]  -- drop comments from corrected words
  let newmap = foldr (uncurry Data.Map.insert) oldmap newlist                   -- insert corrected words
  writeFile "newdict.txt" $ unlines [unwords ("lin":f:"=":[ws]) | (f,ws) <- Data.Map.assocs newmap]  -- print lin rules

