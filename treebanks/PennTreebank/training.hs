import PGF
import qualified Data.Map as Map
import Data.Maybe
import Data.List

grammar_name  = "ParseEngAbs.pgf"

treebank_name = "log4.txt"

chunk_cats = map mkCId
  ["A", "AP", "AdA", "AdV", "Adv", "CN", "Cl", "ClSlash", "Conj", "Det", 
   "IAdv", "IP", "N", "NP", "Num", "Ord", "Predet", "Prep", "Pron", "QS",
   "Quant", "RP", "RS", "S", "Subj", "V", "V2", "VPS", "VS"]

main = do
  pgf <- readPGF grammar_name
  ls <- fmap (filterExprs . zip [1..] . lines) $ readFile treebank_name
  putStrLn ""
  putStrLn ("trees: "++show (length ls))
  let (_,cat,_) = unType (startCat pgf)
      stats = foldl' (collectStats pgf)
                     (initStats pgf)
                     [(n,fromMaybe (error l) (readExpr (toQ l)),Just cat) | (n,l) <- ls]

  putStrLn ("coverage: "++show (coverage stats))

  putStrLn ("Writing ParseEngAbs.probs...")
  writeFile "ParseEngAbs.probs"  (unlines [show f ++ "\t" ++ show p | (f,p) <- probs pgf stats])
  where
    toQ []       = []
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
  ,0
  )

collectStats pgf (ustats,count) (n,e,mb_cat1) =
  case unApp e of
    Just (f,args) -> let fcat2 = cat2 pgf f n e
                         fcat = fromMaybe fcat2 mb_cat1
                         cf   = fromMaybe 0 (Map.lookup f ustats)
                         cc   = fromMaybe 0 (Map.lookup fcat ustats)
                     in if isJust mb_cat1 && f /= mkCId "Q" && fcat /= fcat2
                          then error (show n ++ ": " ++ showExpr [] e)
                          else
                            cf `seq` cc `seq` count `seq`
                            foldl' (collectStats pgf)
                                   (Map.insert f (cf+1) (Map.insert fcat (cc+1) ustats)
                                   ,count+1
                                   )
                                   (zipWith (\e mb_cat1 -> (n,e,mb_cat1)) args (argCats f))
    Nothing       -> case unStr e of
                       Just _        -> (ustats,count+1)
                       Nothing       -> error ("collectStats ("++showExpr [] e++")")
  where
	argCats f =
	  case fmap unType (functionType pgf f) of
	    Just (arg_tys,_,_) -> let tyCat (_,_,ty) = let (_,cat,_) = unType ty in Just cat
	                          in map tyCat arg_tys
	    Nothing            -> repeat Nothing

coverage (stats,gcount) =
  let c = fromMaybe 0 (Map.lookup (mkCId "Q") stats)
  in (fromIntegral (gcount - c) / fromIntegral gcount) * 100

probs pgf (stats,gcount) =
  [toFProb f (cat pgf f) | f <- functions pgf] ++
  [toCProb c | c <- chunk_cats]
  where
    toFProb f cat =
      let count    = fromMaybe 0 (Map.lookup f   stats)
          cat_mass = fromMaybe 0 (Map.lookup cat stats)
      in (f, fromIntegral count / fromIntegral cat_mass :: Double)

    toCProb c =
      let ccount = fromMaybe 0 (Map.lookup c stats)
      in (c, fromIntegral ccount / fromIntegral chunk_mass :: Double)

    chunk_mass =
      sum [fromMaybe 0 (Map.lookup c stats) | c <- chunk_cats]

cat pgf f =
  case fmap unType (functionType pgf f) of
    Just (_,cat,_) -> cat
    Nothing        -> error ("Unknown function "++showCId f)

cat2 pgf f n e =
  case fmap unType (functionType pgf f) of
    Just (_,cat,_) -> cat
    Nothing        -> error (show n ++ ": Unknown function "++showCId f++" in "++showExpr [] e)
