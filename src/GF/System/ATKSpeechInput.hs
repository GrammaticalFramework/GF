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
import Data.Maybe
import Data.IORef
import System.Environment
import System.IO
import System.IO.Unsafe

data ATKLang = ATKLang {
                        cmndef :: Maybe FilePath,
                        hmmlist :: FilePath,
                        mmf0 :: FilePath,
                        mmf1 :: FilePath,
                        dict :: FilePath
                       }

atk_home_error = "The environment variable ATK_HOME is not set. "
                 ++ "It should contain the path to your copy of ATK."

gf_atk_cfg_error = "The environment variable GF_ATK_CFG is not set. "
                   ++ "It should contain the path to your GF ATK configuration"
                   ++ " file. A default version of this file can be found"
                   ++ " in GF/src/gf_atk.cfg"

getLanguage :: String -> IO ATKLang
getLanguage l = 
    case l of 
           "en_UK" -> do
                      atk_home <- getEnv_ "ATK_HOME" atk_home_error
                      let res = atk_home ++ "/Resources"
                      return $ ATKLang {
                                 cmndef = Just $ res ++ "/UK_SI_ZMFCC/cepmean",
                                 hmmlist = res ++ "/UK_SI_ZMFCC/hmmlistbg",
                                 mmf0 = res ++ "/UK_SI_ZMFCC/WI4",
                                 mmf1 = res ++ "/UK_SI_ZMFCC/BGHMM2",
                                 dict = res ++ "/beep.dct" }
           "sv_SE" -> do
                      let res = "/home/bjorn/projects/atkswe/stoneage-swe"
                      return $ ATKLang {
                                 cmndef = Nothing,
                                 hmmlist = res ++ "/triphones1",
                                 mmf0 = res ++ "/hmm12/macros",
                                 mmf1 = res ++ "/hmm12/hmmdefs",
                                 dict = res ++ "/dict" }
           _ -> fail $ "ATKSpeechInput: language " ++ l ++ " not supported"

-- | List of the languages for which we have already loaded the HMM
--   and dictionary.
{-# NOINLINE languages #-}
languages :: IORef [String]
languages = unsafePerformIO $ newIORef []

initATK :: String -> IO ()
initATK language = 
    do
    l <- getLanguage language
    ls <- readIORef languages
    when (null ls) $ do
                     config <- getEnv_ "GF_ATK_CFG" gf_atk_cfg_error
                     hPutStrLn stderr $ "Initializing ATK..."
                     let ps = map ((,) "HPARM:CMNDEFAULT") (maybeToList (cmndef l))
                     initialize (Just config) ps
    when (language `notElem` ls) $ 
         do
         let hmmName = "hmm_" ++ language
             dictName = "dict_" ++ language
         hPutStrLn stderr $ "Initializing ATK (" ++ language ++ ")..."
         loadHMMSet hmmName (hmmlist l) (mmf0 l) (mmf1 l)
         loadDict dictName (dict l)
         writeIORef languages (language:ls)

recognizeSpeech :: Ident -- ^ Grammar name
	        -> Options -> CGrammar -> IO String
recognizeSpeech name opts cfg = 
    do
    let slf = slfPrinter name opts cfg
        n = prIdent name
        language = "sv_SE"
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


getEnv_ :: String    -- ^ Name of environment variable
        -> String    -- ^ Message to fail with if the variable is not set.
        -> IO String
getEnv_ e err = 
    do
    env <- getEnvironment
    case lookup e env of
                      Just v -> return v
                      Nothing -> fail err