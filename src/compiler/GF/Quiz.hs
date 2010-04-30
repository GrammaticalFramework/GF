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

module GF.Quiz (
  mkQuiz,
  translationList,
  morphologyList
  ) where

import PGF
import PGF.Linearize
import GF.Data.Operations
import GF.Infra.UseIO
import GF.Infra.Option
import PGF.Probabilistic

import System.Random
import Data.List (nub)

-- translation and morphology quiz. AR 10/5/2000 -- 12/4/2002

-- generic quiz function

mkQuiz :: String -> [(String,[String])] -> IO ()
mkQuiz msg tts = do
  let qas = [(q, mkAnswer as) | (q,as) <- tts]
  teachDialogue qas msg

translationList :: 
  Maybe Expr -> Maybe Probabilities -> 
  PGF -> Language -> Language -> Type -> Int -> IO [(String,[String])]
translationList mex mprobs pgf ig og typ number = do
  gen <- newStdGen
  let ts = take number $ generateRandomFrom mex mprobs gen pgf typ
  return $ map mkOne $ ts
 where
   mkOne t = (norml (linearize pgf ig t), map (norml . linearize pgf og) (homonyms t))
   homonyms = parse pgf ig typ . linearize pgf ig

morphologyList :: 
  Maybe Expr -> Maybe Probabilities -> 
  PGF -> Language -> Type -> Int -> IO [(String,[String])]
morphologyList mex mprobs pgf ig typ number = do
  gen <- newStdGen
  let ts = take (max 1 number) $ generateRandomFrom mex mprobs gen pgf typ 
  let ss    = map (tabularLinearizes pgf ig) ts
  let size  = length (head (head ss))
  let forms = take number $ randomRs (0,size-1) gen
  return [(snd (head pws0) +++ fst (pws0 !! i), ws) | 
           (pwss@(pws0:_),i) <- zip ss forms, let ws = map (\pws -> snd (pws !! i)) pwss]

-- | compare answer to the list of right answers, increase score and give feedback 
mkAnswer :: [String] -> String -> (Integer, String) 
mkAnswer as s = 
  if (elem (norm s) as) 
     then (1,"Yes.") 
     else (0,"No, not" +++ s ++ ", but" ++++ unlines as)
 where
   norm = unwords . words

norml = unwords . words


-- * a generic quiz session

type QuestionsAndAnswers = [(String, String -> (Integer,String))]

teachDialogue :: QuestionsAndAnswers -> String -> IO ()
teachDialogue qas welc = do
  putStrLn $ welc ++++ genericTeachWelcome
  teach (0,0) qas
 where 
    teach _ [] = do putStrLn "Sorry, ran out of problems"
    teach (score,total) ((question,grade):quas) = do
      putStr ("\n" ++ question ++ "\n> ") 
      answer <- getLine
      if (answer == ".") then return () else do
        let (result, feedback) = grade answer
            score' = score + result 
            total' = total + 1
        putStr (feedback ++++ "Score" +++ show score' ++ "/" ++ show total')
        if (total' > 9 && fromInteger score' / fromInteger total' >= 0.75)
           then do putStrLn "\nCongratulations - you passed!"
           else teach (score',total') quas

    genericTeachWelcome = 
      "The quiz is over when you have done at least 10 examples" ++++
      "with at least 75 % success." +++++
      "You can interrupt the quiz by entering a line consisting of a dot ('.').\n"
