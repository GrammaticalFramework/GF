----------------------------------------------------------------------
-- |
-- Module      : Probabilistic
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/11/01 09:20:09 $ 
-- > CVS $Author: aarne $
-- > CVS $Revision: 1.5 $
--
-- Probabilistic abstract syntax. AR 30\/10\/2005
--
-- (c) Aarne Ranta 2005 under GNU GPL
--
-- Contents: parsing and random generation with probabilistic grammars.
-- To begin with, we use simple types and don't
-- guarantee the correctness of bindings\/dependences.
-----------------------------------------------------------------------------

module GF.Probabilistic.Probabilistic (
  generateRandomTreesProb -- :: Options -> StdGen -> GFCGrammar -> Probs -> Cat -> [Exp]
 ,checkGrammarProbs       -- :: GFCGrammar -> Probs -> Err ()
 ,computeProbTree         -- :: Probs -> Tree -> Double
 ,rankByScore             -- :: Ord n => [(a,n)] -> [(a,n)]
 ,Probs                   -- = BinTree Ident Double
 ,getProbsFromFile        -- :: Opts -> IO Probs
 ,emptyProbs              -- :: Probs
 ,prProbs                 -- :: Probs -> String
  ) where

import GF.Canon.GFC
import GF.Grammar.LookAbs
import GF.Grammar.PrGrammar
import GF.Grammar.Macros
import GF.Grammar.Values
import GF.Grammar.Grammar
import GF.Grammar.SGrammar

import GF.Infra.Ident
import GF.Data.Zipper
import GF.Data.Operations
import GF.Infra.Option

import Data.Char
import Data.List
import Control.Monad
import System.Random

-- | this parameter tells how many constructors at most are generated in a tree
timeout :: Int
timeout = 99

-- | generate an infinite list of trees, with their probabilities
generateRandomTreesProb :: Options -> StdGen -> GFCGrammar -> Probs -> Cat -> [Exp]
generateRandomTreesProb opts gen gr probs cat = 
  map str2tr $ randomTrees gen gr' cat' where
    gr'  = gr2sgr opts probs gr
    cat' = prt $ snd cat

-- | check that probabilities attached to a grammar make sense
checkGrammarProbs :: GFCGrammar -> Probs -> Err Probs
checkGrammarProbs gr probs = 
  err Bad (return . gr2probs) $ checkSGrammar $ gr2sgr noOptions probs gr where
    gr2probs sgr = buildTree [(zIdent f,p) | (_,rs) <- tree2list sgr, ((p,f),_) <- rs]

-- | compute the probability of a given tree
computeProbTree :: Probs -> Tree -> Double
computeProbTree probs (Tr (N (_,at,_,_,_),ts)) = case at of
  AtC (_,f) -> case lookupTree prt f probs of
    Ok p -> p * product (map prob ts)
    _ -> product (map prob ts)
  _ -> 1.0 ----
 where
   prob = computeProbTree probs

-- | rank from highest to lowest score, e.g. probability
rankByScore :: Ord n => [(a,n)] -> [(a,n)]
rankByScore = sortBy (\ (_,p) (_,q) -> compare q p)

getProbsFromFile :: Options -> FilePath -> IO Probs
getProbsFromFile opts file = do 
  s <- maybe (readFile file) readFile $ getOptVal opts probFile
  return $ buildTree $ concatMap pProb $ lines s
-- where
pProb s = case words s of
     "--#":"prob":f:p:_ | isDouble p -> [(zIdent f, read p)]
     f:ps@(g:rest) -> case span (/= "--#") ps of
       (_,_:"prob":p:_) | isDouble p -> [(zIdent f', readD p)] where 
         f' = if elem f ["fun","lin","data"] then ident g else ident f
       _ -> []
     _ -> []
  where
   isDouble = all (flip elem ('.':['0'..'9']))
   ident = takeWhile (flip notElem ".:")
   readD :: String -> Double
   readD = read

------------------------------------------
-- translate grammar to simpler form and generated trees back

probTree :: STree -> Double
probTree t = case t of
  SApp ((p,_),ts) -> p * product (map probTree ts)
  _ -> 1

rankTrees :: [STree] -> [(STree,Double)]
rankTrees ts = sortBy (\ (_,p) (_,q) -> compare q p) [(t,probTree t) | t <- ts]

randomTrees :: StdGen -> SGrammar -> SCat -> [STree]
randomTrees gen = genTrees (randomRs (0.0, 1.0) gen)

genTrees :: [Double] -> SGrammar -> SCat -> [STree]
genTrees ds0 gr cat = 
  let (ds,ds2) = splitAt (timeout+1) ds0  -- for time out, else ds
      (t,k) = genTree ds gr cat      
  in (if k>timeout then id else (t:))     -- don't accept with metas
           (genTrees ds2 gr cat)          -- else (drop k ds)

genTree :: [Double] -> SGrammar -> SCat -> (STree,Int)
genTree rs gr = gett rs where
  gett [] cat = (SMeta cat,1) -- time-out case
  gett ds "String" = (SString "foo",1)
  gett ds "Int" = (SInt 1978,1)
  gett ds "Float" = (SFloat 3.1415926, 1)
  gett ds cat = case look cat of
    [] -> (SMeta cat,1) -- if no productions, return ? 
    fs -> let 
        d:ds2     = ds
        (pf,args) = getf d fs
        (ts,k)    = getts ds2 args
      in (SApp (pf,ts), k+1)
  getf d fs = hitRegion d [(p,(pf,args)) | (pf@(p,_),(args,_)) <- fs]
  getts ds cats = case cats of
    c:cs -> let 
        (t, k)  = gett ds c
        (ts,ks) = getts (drop k ds) cs 
      in (t:ts, k + ks)
    _ -> ([],0)
  look cat = errVal [] $ lookupTree id cat gr

hitRegion :: Double -> [(Double,a)] -> a
hitRegion d vs = case vs of
  (p1,v1):vs2 -> 
    if d < p1 then v1 else hitRegion d [(p+p1,v) | (p,v) <- vs2]

--- this should recover from rounding errors

checkSGrammar :: SGrammar -> Err SGrammar
checkSGrammar = mapMTree chCat where
  chCat (c,rs) = case sum [p | ((p,f),_) <- rs] of
    s | abs (s - 1.0) > 0.01 -> 
      Bad $ "illegal probability sum " ++ show s ++ " in " ++ c
    _ -> return (c,rs)


{-
------------------------------------------
-- to test outside GF

prSTree t = case t of
  SApp ((p,f),ts) -> f ++ prParenth (show p) ++ concat (map pr1 ts)
  SMeta c -> '?':c
  SString s -> prQuotedString s
  SInt i -> show i 
  SFloat i -> show i 
 where
  pr1 t@(SApp (_,ts)) = ' ' : (if null ts then id else prParenth) (prSTree t)
  pr1 t = prSTree t


mkSGrammar :: [SRule] -> SGrammar 
mkSGrammar rules = 
  buildTree [(c, fillProb rs) | rs@((_,(_,c)):_) <- rules'] where
    rules' =     
      groupBy (\x y -> scat x == scat y) $
        sortBy (\x y -> compare (scat x) (scat y)) 
          rules 
    scat (_,(_,c)) = c

pSRule :: String -> SRule
pSRule s = case words s of
  p : f : c : cs -> 
    if isDigit (head p) 
      then ((read p, f),(init cs', last cs')) 
      else ((2.0, p),(init (c:cs'), last (c:cs'))) --- hack for automatic probability
     where cs' = [cs !! i | i <- [0,2..length cs - 1]]
  _ -> error $ "not a rule" +++ s

expSgr = mkSGrammar $ map pSRule [
  "0.8 a : A"
 ,"0.2 b : A"
 ,"0.2 n : A -> S -> S"
 ,"0.8 e : S"
 ]

ex1 :: IO ()
ex1 = do
  g <- newStdGen
  mapM_ (putStrLn . prSTree) $ randomTrees g exSgr "S"

-}

