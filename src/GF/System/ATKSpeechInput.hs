----------------------------------------------------------------------
-- |
-- Module      : GF.System.ATKSpeechInput
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (non-portable)
--
-- > CVS $Date: 2005/05/10 15:04:01 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- Use ATK and Speech.ATKRec for speech input.
-----------------------------------------------------------------------------

module GF.System.ATKSpeechInput (recognizeSpeech) where

import GF.Infra.Ident (Ident, prIdent)
import GF.Infra.Option (Options)
import GF.Conversion.Types (CGrammar)
import GF.Speech.PrSLF

import Speech.ATKRec

import Control.Monad
import Data.IORef
import System.Environment
import System.IO
import System.IO.Unsafe

-- FIXME: get these from somewhere else

config = "/home/aarne/atk/atkrec/atkrec.cfg"

data ATKLang = ATKLang {
                        hmmlist :: FilePath,
                        mmf0 :: FilePath,
                        mmf1 :: FilePath,
                        dict :: FilePath
                       }

getLanguage :: String -> IO ATKLang
getLanguage l = 
    case l of 
           "en_UK" -> do
                      atk_home <- getEnv "ATK_HOME"
                      let res = atk_home ++ "/Resources"
                      return $ ATKLang {
                                 hmmlist = res ++ "/UK_SI_ZMFCC/hmmlistbg",
                                 mmf0 = res ++ "/UK_SI_ZMFCC/WI4",
                                 mmf1 = res ++ "/UK_SI_ZMFCC/BGHMM2",
                                 dict = res ++ "/beep.dct" }
           _ -> fail $ "AKTSpeechInput: language " ++ l ++ " not supported"

-- | List of the languages for which we have already loaded the HMM
--   and dictionary.
{-# NOINLINE languages #-}
languages :: IORef [String]
languages = unsafePerformIO $ newIORef []

initATK :: String -> IO ()
initATK language = 
    do
    ls <- readIORef languages
    when (null ls) $ do
                     hPutStrLn stderr $ "Initializing ATK..."
                     initialize config
    when (language `notElem` ls) $ 
         do
         let hmmName = "hmm_" ++ language
             dictName = "dict_" ++ language
         hPutStrLn stderr $ "Initializing ATK (" ++ language ++ ")..."
         l <- getLanguage language
         loadHMMSet hmmName (hmmlist l) (mmf0 l) (mmf1 l)
         loadDict dictName (dict l)
         writeIORef languages (language:ls)

recognizeSpeech :: Ident -- ^ Grammar name
	        -> Options -> CGrammar -> IO String
recognizeSpeech name opts cfg = 
    do
    let slf = slfPrinter name opts cfg
        n = prIdent name
        language = "en_UK"
        hmmName = "hmm_" ++ language
        dictName = "dict_" ++ language
        slfName = "gram_" ++ n
        recName = "rec_" ++ language ++ "_" ++ n
    initATK language
    loadGrammarString slfName slf
    createRecognizer recName hmmName dictName slfName
    hPutStrLn stderr "Listening..."
    s <- recognize recName
    return s
