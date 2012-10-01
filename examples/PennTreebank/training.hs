import PGF
import qualified Data.Map as Map
import Data.Maybe
import Data.List

main = do
  pgf <- readPGF "ParseEngAbs.pgf"
  ls <- fmap (filterExprs . zip [1..] . lines) $ readFile "log4.txt"
  putStrLn ""
  putStrLn ("trees: "++show (length ls))
  let stats = foldl' (collectStats pgf)
                     (initStats pgf)
                     [(n,fromMaybe (error l) (readExpr (toQ l)),Just (mkCId "Phr"),Nothing) | (n,l) <- ls]

  putStrLn ("coverage: "++show (coverage stats))

  putStrLn ("Writing ParseEngAbs.probs...")
  writeFile "ParseEngAbs.probs"  (unlines [show f ++ "\t" ++ show p | (f,p) <- uprobs pgf stats])
  
  putStrLn ("Writing ParseEngAbs2.probs...")
  writeFile "ParseEngAbs2.probs" (unlines [show cat1 ++ "\t" ++ show cat2 ++ "\t" ++ show p | (cat1,cat2,p) <- mprobs pgf stats])
  
  putStrLn ("Writing global.probs...")
  writeFile "global.probs" (unlines [show f ++ "\t" ++ show p | (f,p) <- gprobs pgf stats])
  
  putStrLn ("Writing categories.probs...")
  writeFile "categories.probs" (unlines [show f ++ "\t" ++ show p | (f,p) <- cprobs pgf stats])
  where
    toQ []       = []
    toQ ('[':cs) = let (xs,']':ys) = break (==']') cs
                   in toQ ('?' : ys)
    toQ ('?':cs) = 'Q' : toQ cs
    toQ (c:cs)   = c   : toQ cs

filterExprs []          = []
filterExprs ((n,l):ls)
  | null l              = filterExprs ls
  | elem (head l) "+#*" = (n,drop 2 l) : filterExprs ls
  | otherwise           = filterExprs ls

initStats pgf =
  (Map.fromListWith (+)
      ([(f,1) | f <- functions pgf] ++
       [(cat pgf f,1) | f <- functions pgf])
  ,Map.empty
  ,0
  )

collectStats pgf (ustats,bstats,count) (n,e,mb_cat1,mb_cat2) =
  case unApp e of
    Just (f,args) -> let fcat2 = cat2 pgf f n e
                         fcat = fromMaybe (cat2 pgf f n e) mb_cat1
                         cf   = fromMaybe 0 (Map.lookup f ustats)
                         cc   = fromMaybe 0 (Map.lookup fcat ustats)
                     in if isJust mb_cat1 && f /= mkCId "Q" && fcat /= fcat2
                          then error (show n ++ ": " ++ showExpr [] e)
                          else
                            cf `seq` cc `seq` bstats `seq` count `seq`
                            foldl' (collectStats pgf)
                                   (Map.insert f (cf+1) (Map.insert fcat (cc+1) ustats)
                                   ,(if null args
                                       then Map.insertWith (+) (fcat,wildCId) 1
                                       else id)
                                    (maybe bstats (\cat2 -> Map.insertWith (+) (cat2,fcat) 1 bstats) mb_cat2)
                                   ,count+1
                                   )
                                   (zipWith3 (\e mb_cat1 mb_cat2 -> (n,e,mb_cat1,mb_cat2)) args (argCats f) (repeat (Just fcat)))
    Nothing       -> case unStr e of
                       Just _        -> (ustats,bstats,count+1)
                       Nothing       -> error ("collectStats ("++showExpr [] e++")")
  where
	argCats f =
	  case fmap unType (functionType pgf f) of
	    Just (arg_tys,_,_) -> let tyCat (_,_,ty) = let (_,cat,_) = unType ty in Just cat
	                          in map tyCat arg_tys
	    Nothing            -> repeat Nothing

coverage (ustats,bstats,count) =
  let c = fromMaybe 0 (Map.lookup (mkCId "Q") ustats)
  in (fromIntegral (count - c) / fromIntegral count) * 100

uprobs pgf (ustats,bstats,count) =
  [toProb f (cat pgf f) | f <- functions pgf]
  where
    toProb f cat =
      let count    = fromMaybe 0 (Map.lookup f ustats)
          cat_mass = fromMaybe 0 (Map.lookup cat ustats)
      in (f, fromIntegral count / fromIntegral cat_mass :: Double)

mprobs pgf (ustats,bstats,count) =
  concat [toProb cat | cat <- categories pgf]
  where
    toProb cat =
      let mass = sum [count | ((cat1,cat2),count) <- Map.toList bstats, cat1==cat]
          cat_count = fromMaybe 0 (Map.lookup cat ustats)
          fun_count = sum [fromMaybe 0 (Map.lookup f ustats) | f <- functionsByCat pgf cat]
      in (cat,mkCId "*",if cat_count == 0 then 0 else fromIntegral (cat_count - fun_count) / fromIntegral cat_count) :
         [(cat1,cat2,fromIntegral count / fromIntegral mass)
					| ((cat1,cat2),count) <- Map.toList bstats, cat1==cat]

gprobs pgf (ustats,bstats,count) =
  sortBy (\x y -> compare (snd y) (snd x)) [toProb f | f <- functions pgf]
  where
    toProb f =
      let fcount = fromMaybe 0 (Map.lookup f ustats)
      in (f, fromIntegral fcount / fromIntegral count :: Double)

cprobs pgf (ustats,bstats,count) =
  sortBy (\x y -> compare (snd y) (snd x)) [toProb c | c <- categories pgf]
  where
    mass = sum [fromMaybe 0 (Map.lookup c ustats) | c <- categories pgf]

    toProb c =
      let fcount = fromMaybe 0 (Map.lookup c ustats)
      in (c, fromIntegral fcount / fromIntegral mass :: Double)

cat pgf f =
  case fmap unType (functionType pgf f) of
    Just (_,cat,_) -> cat
    Nothing        -> error ("Unknown function "++showCId f)

cat2 pgf f n e =
  case fmap unType (functionType pgf f) of
    Just (_,cat,_) -> cat
    Nothing        -> error (show n ++ ": Unknown function "++showCId f++" in "++showExpr [] e)
