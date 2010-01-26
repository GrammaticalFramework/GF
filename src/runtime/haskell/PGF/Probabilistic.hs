module PGF.Probabilistic (
  probTree                -- :: Probabilities -> Tree -> Double
 ,rankTreesByProbs        -- :: Probabilities -> [Tree] -> [Tree]
 ,Probabilities           -- data
 ,catProbs
 ,getProbsFromFile        -- :: FilePath -> PGF -> IO Probabilities
 ) where

import PGF.CId
import PGF.Data
import PGF.Macros

import qualified Data.Map as M
import Data.List (sortBy,partition)

data Probabilities = Probs {
  funProbs :: M.Map CId Double,
  catProbs :: M.Map CId [(Double, (CId,[CId]))] -- prob and arglist
  }

getProbsFromFile :: FilePath -> PGF -> IO Probabilities
getProbsFromFile file pgf = do
  s <- readFile file
  let ps0 = M.fromList [(mkCId f,read p) | f:p:_ <- map words (lines s)]
  return $ fillProbs pgf ps0

-- | build probability tables by filling unspecified funs with prob sum
--   TODO: check that probabilities sum to 1
fillProbs :: PGF -> M.Map CId Double -> Probabilities
fillProbs pgf funs = 
  let
     cats0 = [(cat,[(f,fst (catSkeleton ty)) | (f,ty) <- fs]) 
                | (cat,_) <- M.toList (cats (abstract pgf)), 
                  let fs = functionsToCat pgf cat]
     cats1 = map fill cats0
     funs1 = M.fromList [(f,p) | (_,cf) <- cats1, (p,(f,_)) <- cf]
  in Probs funs1 (M.fromList cats1)
 where
  fill (cat,fs) = (cat, pad [(getProb0 f,(f,xs)) | (f,xs) <- fs]) 
    where
      getProb0 :: CId -> Double
      getProb0 f = maybe (-1) id $ M.lookup f funs
      pad :: [(Double,a)] -> [(Double,a)]
      pad pfs = [(if p== -1 then deflt else p,f) | (p,f) <- pfs]
        where
          deflt = 1 - sum poss / fromIntegral (length negs) 
          (poss,negs) = partition (> (-1)) (map fst pfs)

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


