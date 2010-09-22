module PGF.Probabilistic
         ( Probabilities(..)
         , mkProbabilities                 -- :: PGF -> M.Map CId Double -> Probabilities
         , defaultProbabilities            -- :: PGF -> Probabilities
         , showProbabilities               -- :: Probabilities -> String
         , readProbabilitiesFromFile       -- :: FilePath -> PGF -> IO Probabilities

         , probTree                -- :: Probabilities -> Tree -> Double
         , rankTreesByProbs        -- :: Probabilities -> [Tree] -> [Tree]
         ) where

import PGF.CId
import PGF.Data
import PGF.Macros

import qualified Data.Map as Map
import Data.List (sortBy,partition)
import Data.Maybe (fromMaybe)

-- | An abstract data structure which represents
-- the probabilities for the different functions in a grammar.
data Probabilities = Probs {
  funProbs :: Map.Map CId Double,
  catProbs :: Map.Map CId [(Double, CId)]
  }

-- | Renders the probability structure as string
showProbabilities :: Probabilities -> String
showProbabilities = unlines . map pr . Map.toList . funProbs where
  pr (f,d) = showCId f ++ "\t" ++ show d

-- | Reads the probabilities from a file.
-- This should be a text file where on every line
-- there is a function name followed by a real number.
-- The number represents the probability mass allocated for that function.
-- The function name and the probability should be separated by a whitespace.
readProbabilitiesFromFile :: FilePath -> PGF -> IO Probabilities
readProbabilitiesFromFile file pgf = do
  s <- readFile file
  let ps0 = Map.fromList [(mkCId f,read p) | f:p:_ <- map words (lines s)]
  return $ mkProbabilities pgf ps0

-- | Builds probability tables. The second argument is a map
-- which contains the know probabilities. If some function is
-- not in the map then it gets assigned some probability based
-- on the even distribution of the unallocated probability mass
-- for the result category.
mkProbabilities :: PGF -> Map.Map CId Double -> Probabilities
mkProbabilities pgf probs =
  let funs1 = Map.fromList [(f,p) | (_,cf) <- Map.toList cats1, (p,f) <- cf]
      cats1 = Map.map (\(_,fs) -> fill fs) (cats (abstract pgf))
  in Probs funs1 cats1
  where
    fill fs = pad [(Map.lookup f probs,f) | f <- fs]
      where
        pad :: [(Maybe Double,a)] -> [(Double,a)]
        pad pfs = [(fromMaybe deflt mb_p,f) | (mb_p,f) <- pfs]
          where
            deflt = case length [f | (Nothing,f) <- pfs] of
                      0 -> 0
                      n -> (1 - sum [d | (Just d,f) <- pfs]) / fromIntegral n

-- | Returns the default even distibution.
defaultProbabilities :: PGF -> Probabilities
defaultProbabilities pgf = mkProbabilities pgf Map.empty

-- | compute the probability of a given tree
probTree :: Probabilities -> Expr -> Double
probTree probs t = case t of
  EApp f e -> probTree probs f * probTree probs e
  EFun f   -> maybe 1 id $ Map.lookup f (funProbs probs)
  _ -> 1

-- | rank from highest to lowest probability
rankTreesByProbs :: Probabilities -> [Expr] -> [(Expr,Double)]
rankTreesByProbs probs ts = sortBy (\ (_,p) (_,q) -> compare q p) 
  [(t, probTree probs t) | t <- ts]


