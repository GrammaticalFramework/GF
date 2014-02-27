import Data.List
import qualified Data.Map

main = do

  ws <- readFile "new-trees.txt" >>= return . words

  let freqs ws = Data.Map.fromListWith (+) [(w,1) | w <- ws]

  let freqmap = freqs ws

  fs <- readFile "all-ndfuns.txt" >>= return . lines

  let catf ws = case ws of f:ty -> (f,last(init ty))

  let catmap = Data.Map.fromList [catf (words f) | f <- fs]

  let allist = [(f,(c,Data.Map.lookup f freqmap)) | (f,c) <- Data.Map.assocs catmap]

  let catlist = Data.List.sortBy (\(f,(c,_)) (_,(k,_)) -> compare c k) allist

  let gcatlist = Data.List.groupBy (\(f,(c,_)) (_,(k,_)) -> c==k) catlist

  let fcatfreqs fcs = let cat = fst (snd (head fcs)) in let tot = sum [maybe 0 id mn | (f,(c,mn)) <- fcs] in [(f,maybe 0 id mn, cat, tot) | (f,(c,mn)) <- fcs]

  let fcatfreqlist = map fcatfreqs gcatlist

  let relprobs cat = [(f, (fromIntegral i+1 :: Double) / (fromIntegral tot :: Double)) | (f,i,c,t) <- cat, let tot = t + length cat]

--  writeFile "allFunFreqs.txt" $ unlines $ [unwords [f,show i,c,show t] | (f,i,c,t) <- concat fcatfreqlist]
  writeFile "NDPredTrans.probs" $ unlines $ [unwords [f,show n] | (f,n) <- concatMap relprobs fcatfreqlist]
