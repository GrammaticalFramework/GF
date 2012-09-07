import PGF
import qualified Data.Map as Map
import Data.Maybe
import Data.List

main = do
  pgf <- readPGF "ParseEngAbs.pgf"
  ls <- fmap (filterExprs . lines) $ readFile "log3.txt"
  putStrLn ""
  putStrLn ("trees: "++show (length ls))
  let stats = foldl' (collectStats pgf)
                     (initStats pgf)
                     [(fromMaybe (error l) (readExpr (toQ l)),Just (mkCId "Phr"),Nothing) | l <- ls]

  putStrLn ("coverage: "++show (coverage stats))

  putStrLn ("Writing ParseEngAbs.probs...")
  writeFile "ParseEngAbs.probs"  (unlines [show f ++ "\t" ++ show p | (f,p) <- uprobs pgf stats])
  
  putStrLn ("Writing ParseEngAbs2.probs...")
  writeFile "ParseEngAbs2.probs" (unlines [show cat1 ++ "\t" ++ show cat2 ++ "\t" ++ show p | (cat1,cat2,p) <- bprobs pgf stats])
  
  putStrLn ("Writing global.probs...")
  writeFile "global.probs" (unlines [show f ++ "\t" ++ show p | (f,p) <- gprobs pgf stats])
  where
    toQ []       = []
    toQ ('[':cs) = let (xs,']':ys) = break (==']') cs
                   in toQ ('?' : ys)
    toQ ('?':cs) = 'Q' : toQ cs
    toQ (c:cs)   = c   : toQ cs

filterExprs []          = []
filterExprs (l:ls)
  | null l              = filterExprs ls
  | elem (head l) "+#*" = drop 2 l : filterExprs ls
  | otherwise           = filterExprs ls

initStats pgf =
  (Map.fromListWith (+)
      ([(f,1) | f <- functions pgf] ++
       [(cat pgf f,1) | f <- functions pgf])
  ,Map.empty
  ,0
  )

collectStats pgf (ustats,bstats,count) (e,mb_cat1,mb_cat2) =
  case unApp e of
    Just (f,args) -> let fcat = fromMaybe (cat2 pgf f e) mb_cat1
                         cf   = fromMaybe 0 (Map.lookup f ustats)
                         cc   = fromMaybe 0 (Map.lookup fcat ustats)
                     in cf `seq` cc `seq` bstats `seq` count `seq`
                        foldl' (collectStats pgf)
                               (Map.insert f (cf+1) (Map.insert fcat (cc+1) ustats)
                               ,(if null args
                                   then Map.insertWith (+) (fcat,wildCId) 1
                                   else id)
                                (maybe bstats (\cat2 -> Map.insertWith (+) (cat2,fcat) 1 bstats) mb_cat2)
                               ,count+1
                               )
                               (zip3 args (argCats f) (repeat (Just fcat)))
    Nothing       -> case unStr e of
                       Just _        -> (ustats,bstats,count+1)
                       Nothing       -> error ("collectStats ("++show e++")")
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

bprobs pgf (ustats,bstats,count) =
  concat [toProb cat | cat <- categories pgf]
  where
    toProb cat =
      let mass = sum [count | ((cat1,cat2),count) <- Map.toList bstats, cat1==cat]
      in [(cat1,cat2,fromIntegral count / fromIntegral mass) 
					| ((cat1,cat2),count) <- Map.toList bstats, cat1==cat]

gprobs pgf (ustats,bstats,count) =
  sortBy (\x y -> compare (snd y) (snd x)) [toProb f | f <- functions pgf]
  where
    toProb f =
      let fcount = fromMaybe 0 (Map.lookup f ustats)
      in (f, fromIntegral fcount / fromIntegral count :: Double)

cat pgf f =
  case fmap unType (functionType pgf f) of
    Just (_,cat,_) -> cat
    Nothing        -> error ("Unknown function "++showCId f)

cat2 pgf f e =
  case fmap unType (functionType pgf f) of
    Just (_,cat,_) -> cat
    Nothing        -> error ("Unknown function "++showCId f++" "++show e)
