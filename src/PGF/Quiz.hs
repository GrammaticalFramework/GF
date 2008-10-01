----------------------------------------------------------------------
-- |
-- Module      : TeachYourself
-- Maintainer  : AR
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/04/21 16:46:13 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.7 $
--
-- translation and morphology quiz. AR 10\/5\/2000 -- 12\/4\/2002 -- 14\/6\/2008
--------------------------------------------------------------------------------

module PGF.Quiz (
  mkQuiz,
  translationList,
  morphologyList
  ) where

import PGF
import PGF.ShowLinearize

import GF.Data.Operations
import GF.Infra.UseIO
import GF.Text.Coding

import System.Random

import Data.List (nub)

-- translation and morphology quiz. AR 10/5/2000 -- 12/4/2002

-- generic quiz function

mkQuiz :: String -> String -> [(String,[String])] -> IO ()
mkQuiz cod msg tts = do
  let qas = [ (q, mkAnswer cod as) | (q,as) <- tts]
  teachDialogue qas msg

translationList :: 
  PGF -> Language -> Language -> Category -> Int -> IO [(String,[String])]
translationList pgf ig og cat number = do
  ts <- generateRandom pgf cat >>= return . take number
  return $ map mkOne $ ts
 where
   mkOne t = (norml (linearize pgf ig t), map (norml . linearize pgf og) (homonyms t))
   homonyms = nub . parse pgf ig cat . linearize pgf ig

morphologyList :: PGF -> Language -> Category -> Int -> IO [(String,[String])]
morphologyList pgf ig cat number = do
  ts  <- generateRandom pgf cat >>= return . take (max 1 number)
  gen <- newStdGen
  let ss    = map (tabularLinearize pgf (mkCId ig)) ts
  let size  = length (head ss)
  let forms = take number $ randomRs (0,size-1) gen
  return [(head (snd (head pws)) +++ par, ws) | 
           (pws,i) <- zip ss forms, let (par,ws) = pws !! i]

-- | compare answer to the list of right answers, increase score and give feedback 
mkAnswer :: String -> [String] -> String -> (Integer, String) 
mkAnswer cod as s = 
  if (elem (norm s) as) 
     then (1,"Yes.") 
     else (0,"No, not" +++ s ++ ", but" ++++ enc (unlines as))
 where
   norm = unwords . words . decodeUnicode cod
   enc = encodeUnicode cod

norml = unwords . words

