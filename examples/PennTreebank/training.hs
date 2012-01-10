import PGF
import qualified Data.Map as Map
import Data.Maybe
import Data.List

main = do
  pgf <- readPGF "PennTreebank.pgf"
  ls <- fmap lines $ readFile "log.txt"
  let stats = foldl' collectStats Map.empty [e | l <- ls, Just e <- [readExpr (map toQ l)]]
  mapM_ putStrLn [show f ++ "\t" ++ show p | (f,p) <- Map.toList (probs pgf stats), f /= mkCId "Q"]
  where
    toQ '?' = 'Q'
    toQ c   = c

collectStats stats e =
  case unApp e of
    Just (f,args) -> let c = fromMaybe 0 (Map.lookup f stats)
                     in c `seq` foldl' collectStats (Map.insert f (c+1) stats) args
    Nothing       -> stats

probs pgf stats =
  Map.mapWithKey toProb stats  
  where
    toProb f c 
      | f == mkCId "Q" = 1.0
      | otherwise      = let (_,cat,_) = case functionType pgf f of
                                           Just ty -> unType ty
                                           Nothing -> error ("unknown: "++show f)
                             cat_mass = fromMaybe 0 (Map.lookup cat mass)
                         in (fromIntegral c / fromIntegral cat_mass :: Double)

    mass = Map.fromListWith (+)
             [(cat,c) | f <- functions pgf,
                        let Just (_,cat,_) = fmap unType (functionType pgf f),
                        let c = fromMaybe 0 (Map.lookup f stats)]
