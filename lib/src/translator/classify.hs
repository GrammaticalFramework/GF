import Text.EditDistance
import Data.List
import qualified Data.Set as Set
import qualified Data.Map.Strict as Map
import Data.Maybe(maybe,mapMaybe,fromMaybe)
import Data.Char
import Data.IORef
import Debug.Trace
import System.Random
import System.Random.Shuffle
import System.Environment
import Translit
import Control.Monad(forM_)

train = False
useTenFold = False

main = do
  [src,dst] <- getArgs
  src <- fmap (toEntries src) $ readFile ("data/wn-data-"++src++".tab")
  dst <- fmap (toEntries dst) $ readFile ("data/wn-data-"++dst++".tab")
  gen <- newStdGen
  let wps = addCounts (join src dst)

  rps <- if train
           then fmap (Set.fromList . map (toReferencePair . tsv) . lines) $ readFile "data/fiwn-transls.tsv"
           else return Set.empty
  e2f <- fmap (Map.fromList . map (toAlignmentPair . words) . lines) $ readFile "data/europarl-v7.fi-en.lemma.intersect.lex.e2f"

  let features = addFeatures rps wps

  res <- newIORef Map.empty
  (if useTenFold
     then forM_ (tenfold gen features)
     else (>>=) (return (features,features)))  $ \(evalData,trainData) -> do
       tbl <- if train
               then do let stats = Map.fromListWith add2 [((crank,drank),(if cls then (1,0) else (0,1))) | (_,_,_,_,_,crank,drank,cls) <- trainData]
                                   where
                                     add2 (x1,y1) (x2,y2) = (x1+x2,y1+y2)
                           tbl   = [[maybe 0 (\(c1,c2) -> fromIntegral c1 / fromIntegral (c1+c2)) (Map.lookup (rank,dist) stats) | dist <- [1..40]] | rank <- [1..7]]
                       writeFile "stats.tsv" (unlines [untsv [show crank,show drank,show c1,show c2] | ((crank,drank),(c1,c2)) <- Map.toList stats])
                       writeFile "table.tsv" (unlines (map (untsv . map show) tbl))
                       return tbl
               else do fmap (map (map read . tsv) . lines) $ readFile "table.tsv"

       g <- newStdGen
     --  let predictions = randomChoice g evalData
       let predictions = classify tbl evalData
       --let predictions = alignmentChoice e2f evalData
       writeFile "predictions.tsv" (unlines [untsv [sense_id,
                                                    lemma1,
                                                    lemma2,
                                                    show c,show d,
                                                    show crank,show drank,
                                                    show cls,show pred] 
                                               | (sense_id,lemma1,lemma2,c,d,crank,drank,cls,pred) <- predictions])

       let result0 = Map.fromListWith (+) [((cls,pred),1) | (_,_,_,_,_,_,_,cls,pred) <- predictions]
           total   = length predictions
           result  = Map.map (\c -> fromIntegral c / fromIntegral total) result0

       sum_result <- readIORef res
       let sum_result' = Map.fromList [let k = (cls,pred) in (k,fromMaybe 0 (Map.lookup k result)+fromMaybe 0 (Map.lookup k sum_result)) | cls <- [True,False], pred <- [True,False]]
       writeIORef res sum_result'

  result <- readIORef res
  writeFile ("result.tsv") (unlines [untsv ([show cls,show pred,show (c/(if useTenFold then 10 else 1))]) | ((cls,pred),c) <- Map.toList result])

toEntries lng =
  foldr addElem Map.empty . 
  mapMaybe (toEntry lng . tsv) . 
  tail . 
  lines
  where
    toEntry lng [sense_id,rel,w]
      | rel == "lemma" || rel == lng++":lemma" = Just (sense_id,w)
    toEntry _   _                              = Nothing

    addElem (k,a) =
      Map.alter (\mb_as -> Just (a:fromMaybe [] mb_as)) k

join src dst =
  [(sense_id,x,y) | (sense_id,xs) <- Map.toList src,
                    x <- xs,
                    y <- fromMaybe [] (Map.lookup sense_id dst)]

addCounts src_dst =
  let cmap  = Map.fromListWith (+) [((x,y),1) | (sense_id,x,y) <- src_dst]
      cdmap = Map.mapWithKey (\(x,y) c -> (c,dist x y)) cmap
  in [(sense_id,x,y,c,d) | (sense_id,x,y) <- src_dst, let (c,d) = fromMaybe (0,0) (Map.lookup (x,y) cdmap)]
  where
    dist x y = levenshteinDistance defaultEditCosts (map toLower x) (map toLower y)


toReferencePair (fis:fi:ens:en:_) = (conv ens,en,fi)
  where
    conv s = drop 8 s ++ ['-',s !! 7]

toAlignmentPair (eng:fin:_:prob:_) = ((mapEng eng,mapFin fin),read prob :: Double)
  where 
    mapEng w =
      init w ++ ((:[]) $
      case last w of
        'n' -> 'n'
        'v' -> 'v'
        'j' -> 'a'
        'r' -> 'r'
        c   -> c)

    mapFin w =
      init w ++ ((:[]) $
      case last w of
        'n' -> 'n'
        'v' -> 'v'
        'j' -> 'a'
        'a' -> 'a'
        'r' -> 'r'
        c   -> c)

tsv :: String -> [String]
tsv "" = []
tsv cs =
  let (x,cs1) = break (=='\t') cs
  in x : if null cs1 then [] else tsv (tail cs1)

untsv :: [String] -> String
untsv = intercalate "\t"

addFeatures ts ps =
  let (xs,ys)   = takeSynset ps
      (cds,xs') = mapAccumL (addValues cds) (Set.empty,Set.empty) xs
  in if null xs 
       then []
       else xs' ++ addFeatures ts ys
  where
    takeSynset []     = ([],[])
    takeSynset (p:ps) = let sense_id = get_sense_id p
                            (ps1,ps2) = break (\p1 -> get_sense_id p1 /= sense_id) ps
                        in (p : ps1, ps2)
      where
	    get_sense_id (sense_id,_,_,_,_) = sense_id

    addValues cds (cs,ds) (sense_id,lemma1,lemma2,c,d) =
      let cls = Set.member (sense_id,lemma1,lemma2) ts
          cs' = Set.insert c cs
          ds' = Set.insert d ds
          crank = findIndex 1 c (Set.toDescList (fst cds))
          drank = findIndex 1 d (Set.toAscList  (snd cds))
      in ((cs',ds'),(sense_id,lemma1,lemma2,c,d,crank,drank,cls))
      where
        findIndex i x []     = i
        findIndex i x (y:ys)
          | x == y           = i
          | otherwise        = findIndex (i+1) x ys

tenfold gen ps =
  let synsets = takeSynset ps
      len     = length synsets
      len10   = len `div` 10
  in splitData len10 [] (shuffle' synsets len gen)
  where
    takeSynset []     = []
    takeSynset (p:ps) = let sense_id  = get_sense_id p
                            (ps1,ps2) = break (\p1 -> get_sense_id p1 /= sense_id) ps
                        in (p : ps1) : takeSynset ps2
      where
        get_sense_id (sense_id,_,_,_,_,_,_,_) = sense_id

    splitData len10 zs ps =
	  let (xs,ys) = splitAt len10 ps
	  in if null ys
	       then []
	       else (concat xs,concat (zs++ys)) : splitData len10 (xs++zs) ys

--classify :: [[Double]] -> (String,Int,String,Int,String,Int,Int,Int,Int,Bool) -> (String,Int,String,Int,String,Int,Int,Int,Int,Bool,Bool)
{-classify tbl (sense_id,lemma_id1,lemma1,lemma_id2,lemma2,c,d,crank,drank,cls)
  | tbl !! (crank-1) !! (drank-1) > 0.5 = (sense_id,lemma_id1,lemma1,lemma_id2,lemma2,c,d,crank,drank,cls,True)
  | otherwise                           = (sense_id,lemma_id1,lemma1,lemma_id2,lemma2,c,d,crank,drank,cls,False)
-}
classify tbl ps =
  let (xs,ys) = takeSynset ps
      xs'     = sortBy descProb (map pairProb xs)
      (ids,sel1) = pick1 ([],[]) xs'
      sel2       = pick2 ids xs'
      sel        = sel1++sel2
  in if null xs 
       then []
       else map (annotate sel) xs ++ classify tbl ys
  where
    takeSynset []     = ([],[])
    takeSynset (p:ps) = let sense_id = get_sense_id p
                            (ps1,ps2) = break (\p1 -> get_sense_id p1 /= sense_id) ps
                        in (p : ps1, ps2)
      where
	    get_sense_id (sense_id,_,_,_,_,_,_,_) = sense_id

    pairProb x@(sense_id,lemma1,lemma2,c,d,crank,drank,cls) = (lemma1,lemma2,tbl !! (crank-1) !! (drank-1))

    descProb (_,_,p1) (_,_,p2) = compare p2 p1

    pick1 ids             []                       = (ids,[])
    pick1 ids@(ids1,ids2) ((lemma1,lemma2,prob):xs)
      | not (elem lemma1 ids1 || elem lemma2 ids2) = let (ids',xs') = pick1 (lemma1:ids1,lemma2:ids2) xs
                                                     in (ids',(lemma1,lemma2) : xs')
      | otherwise                                  = pick1 ids xs

    pick2 ids             []       = []
    pick2 ids@(ids1,ids2) ((lemma1,lemma2,prob):xs)
      | not (elem lemma1 ids1) = (lemma1,lemma2) : pick2 (lemma1:ids1,lemma2:ids2) xs
      | not (elem lemma2 ids2) = (lemma1,lemma2) : pick2 (lemma1:ids1,lemma2:ids2) xs
      | otherwise              = pick2 ids xs

    annotate sel (sense_id,lemma1,lemma2,c,d,crank,drank,cls) =
      (sense_id,lemma1,lemma2,c,d,crank,drank,cls,elem (lemma1,lemma2) sel)

randomChoice g ps =
  let (xs,ys)  = takeSynset ps
      (g',xs') = mapAccumL pairProb g xs
      sel      = pick [] (sortBy descProb xs')
  in if null xs 
       then []
       else map (annotate sel) xs ++ randomChoice g' ys
  where
    takeSynset []     = ([],[])
    takeSynset (p:ps) = let sense_id = get_sense_id p
                            (ps1,ps2) = break (\p1 -> get_sense_id p1 /= sense_id) ps
                        in (p : ps1, ps2)
      where
	    get_sense_id (sense_id,_,_,_,_,_,_,_) = sense_id

    pairProb g x@(sense_id,lemma1,lemma2,c,d,crank,drank,cls) = 
      let (prob,g') = randomR (0.0,1.0::Double) g
      in (g',(lemma1,lemma2,prob))
      
    descProb (_,_,p1) (_,_,p2) = compare p2 p1

    pick ids []                  = []
    pick ids ((lemma1,lemma2,prob):xs)
      | not (elem lemma1 ids) = (lemma1,lemma2) : pick (lemma1:lemma2:ids) xs
      | not (elem lemma2 ids) = (lemma1,lemma2) : pick (lemma1:lemma2:ids) xs
      | otherwise                = pick ids xs

    annotate sel (sense_id,lemma1,lemma2,c,d,crank,drank,cls) =
      (sense_id,lemma1,lemma2,c,d,crank,drank,cls,elem (lemma1,lemma2) sel)


alignmentChoice e2f ps =
  let (xs,ys) = takeSynset ps
      xs'     = map pairProb xs
      sel     = pick ([],[]) (sortBy descProb xs')
  in if null xs 
       then []
       else map (annotate sel) xs ++ alignmentChoice e2f ys
  where
    takeSynset []     = ([],[])
    takeSynset (p:ps) = let sense_id = get_sense_id p
                            (ps1,ps2) = break (\p1 -> get_sense_id p1 /= sense_id) ps
                        in (p : ps1, ps2)
      where
	    get_sense_id (sense_id,_,_,_,_,_,_,_) = sense_id

    pairProb x@(sense_id,lemma1,lemma2,c,d,crank,drank,cls) = 
      let prob = fromMaybe 0 (Map.lookup (lemma1++"|"++[sense_id!!9],lemma2++"|"++[sense_id!!9]) e2f)
      in (lemma1,lemma2,prob)

    descProb (_,_,p1) (_,_,p2) = compare p2 p1

    pick ids             []                  = []
    pick ids@(ids1,ids2) ((lemma1,lemma2,prob):xs)
      | not (elem lemma1 ids1) = (lemma1,lemma2) : pick (lemma1:ids1,lemma2:ids2) xs
      | not (elem lemma2 ids2) = (lemma1,lemma2) : pick (lemma1:ids1,lemma2:ids2) xs
      | otherwise              = pick ids xs

    annotate sel (sense_id,lemma1,lemma2,c,d,crank,drank,cls) =
      (sense_id,lemma1,lemma2,c,d,crank,drank,cls,elem (lemma1,lemma2) sel)
