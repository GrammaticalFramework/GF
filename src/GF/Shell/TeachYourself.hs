----------------------------------------------------------------------
-- |
-- Module      : (Module)
-- Maintainer  : (Maintainer)
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/02/18 19:21:20 $ 
-- > CVS $Author: peb $
-- > CVS $Revision: 1.4 $
--
-- (Description of the module)
-----------------------------------------------------------------------------

module TeachYourself where

import ShellState
import API
import Linear
import PrGrammar

import Option
import Arch (myStdGen)
import Operations
import UseIO

import Random --- (randoms)  --- bad import for hbc
import System

-- translation and morphology quiz. AR 10/5/2000 -- 12/4/2002

teachTranslation :: Options -> GFGrammar -> GFGrammar -> IO ()
teachTranslation opts ig og = do
  tts <- transTrainList opts ig og infinity
  let qas = [ (q, mkAnswer as) | (q,as) <- tts]
  teachDialogue qas "Welcome to GF Translation Quiz."

transTrainList :: 
  Options -> GFGrammar -> GFGrammar -> Integer -> IO [(String,[String])]
transTrainList opts ig og number = do
  ts <- randomTreesIO (addOption beSilent opts) ig (fromInteger number)
  return $ map mkOne $ ts
 where
   cat = firstCatOpts opts ig
   mkOne t = (norml (linearize ig t),map (norml . linearize og) (homonyms ig cat t))


teachMorpho :: Options -> GFGrammar -> IO ()
teachMorpho opts ig = useIOE () $ do
  tts <- morphoTrainList opts ig infinity
  let qas = [ (q, mkAnswer as) | (q,as) <- tts]
  ioeIO $ teachDialogue qas "Welcome to GF Morphology Quiz."

morphoTrainList :: Options -> GFGrammar -> Integer -> IOE [(String,[String])]
morphoTrainList opts ig number = do
  ts   <- ioeIO $ randomTreesIO (addOption beSilent opts) ig (fromInteger number)
  gen  <- ioeIO $ myStdGen (fromInteger number)
  mkOnes gen ts
 where
   mkOnes gen (t:ts) = do
     psss    <- ioeErr $ allLinTables gr cnc t
     let pss = concat $ map snd $ concat psss
     let (i,gen') = randomR (0, length pss - 1) gen
     (ps,ss) <- ioeErr $ pss !? i
     (_,ss0) <- ioeErr $ pss !? 0
     let bas = unwords ss0 --- concat $ take 1 ss0
     more <- mkOnes gen' ts
     return $ (bas +++ ":" +++ unwords (map prt_ ps), return (unwords ss)) : more
   mkOnes gen [] = return []
 
   gr = grammar ig
   cnc = cncId ig

-- compare answer to the list of right answers, increase score and give feedback 
mkAnswer :: [String] -> String -> (Integer, String) 
mkAnswer as s = if (elem (norml s) as) 
                   then (1,"Yes.") 
                   else (0,"No, not" +++ s ++ ", but" ++++ unlines as)

norml = unwords . words

--- the maximal number of precompiled quiz problems
infinity :: Integer
infinity = 123 

