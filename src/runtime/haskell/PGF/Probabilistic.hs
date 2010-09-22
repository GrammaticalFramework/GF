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

import qualified Data.Map as M
import Data.List (sortBy,partition)

-- | An abstract data structure which represents
-- the probabilities for the different functions in a grammar.
data Probabilities = Probs {
  funProbs :: M.Map CId Double,
  catProbs :: M.Map CId [(Double, (CId,[CId]))] -- prob and arglist
  }

-- | Renders the probability structure as string
showProbabilities :: Probabilities -> String
showProbabilities = unlines . map pr . M.toList . funProbs where
  pr (f,d) = showCId f ++ "\t" ++ show d

-- | Reads the probabilities from a file.
-- This should be a text file where on every line
-- there is a function name followed by a real number.
-- The number represents the probability mass allocated for that function.
-- The function name and the probability should be separated by a whitespace.
readProbabilitiesFromFile :: FilePath -> PGF -> IO Probabilities
readProbabilitiesFromFile file pgf = do
  s <- readFile file
  let ps0 = M.fromList [(mkCId f,read p) | f:p:_ <- map words (lines s)]
  return $ mkProbabilities pgf ps0

-- | Builds probability tables by filling unspecified funs with probability sum
--
-- TODO: check that probabilities sum to 1
mkProbabilities :: PGF -> M.Map CId Double -> Probabilities
mkProbabilities pgf funs = 
  let
     cats0 = [(cat,[(f,fst (catSkeleton ty)) | (f,ty) <- fs]) 
                | (cat,_) <- M.toList (cats (abstract pgf)), 
                  let fs = functionsToCat pgf cat]
     cats1 = map fill cats0
     funs1 = [(f,p) | (_,cf) <- cats1, (p,(f,_)) <- cf]
     in Probs (M.fromList funs1) (M.fromList cats1)
 where
  fill (cat,fs) = (cat, pad [(getProb0 f,(f,xs)) | (f,xs) <- fs]) 
    where
      getProb0 :: CId -> Double
      getProb0 f = maybe (-1) id $ M.lookup f funs
      pad :: [(Double,a)] -> [(Double,a)]
      pad pfs = [(if p== -1 then deflt else p,f) | (p,f) <- pfs]
        where
          deflt = case length negs of
            0 -> 0
            _ -> (1 - sum poss) / fromIntegral (length negs) 
          (poss,negs) = partition (> (-0.5)) (map fst pfs)

-- | Returns the default even distibution.
defaultProbabilities :: PGF -> Probabilities
defaultProbabilities pgf = mkProbabilities pgf M.empty

-- | compute the probability of a given tree
probTree :: Probabilities -> Expr -> Double
probTree probs t = case t of
  EApp f e -> probTree probs f * probTree probs e
  EFun f   -> maybe 1 id $ M.lookup f (funProbs probs)
  _ -> 1

-- | rank from highest to lowest probability
rankTreesByProbs :: Probabilities -> [Expr] -> [(Expr,Double)]
rankTreesByProbs probs ts = sortBy (\ (_,p) (_,q) -> compare q p) 
  [(t, probTree probs t) | t <- ts]


