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
import GF.Infra.Option
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
                        hmmlist :: FilePath,
                        mmf0 :: FilePath,
                        mmf1 :: FilePath,
                        dict :: FilePath,
                        opts :: [(String,String)]
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
                                 hmmlist = res ++ "/UK_SI_ZMFCC/hmmlistbg",
                                 mmf0 = res ++ "/UK_SI_ZMFCC/WI4",
                                 mmf1 = res ++ "/UK_SI_ZMFCC/BGHMM2",
                                 dict = res ++ "/beep.dct",
                                 opts = [("TARGETKIND", "MFCC_0_D_A_Z"),
                                         ("HPARM:CMNDEFAULT", res ++ "/UK_SI_ZMFCC/cepmean")]
                                       }
           "sv_SE" -> do
                      let res = "/home/bjorn/projects/atkswe/numerals-swe/final"
                      return $ ATKLang {
                                 hmmlist = res ++ "/hmm_tri/hmmlist",
                                 mmf0 = res ++ "/hmm_tri/macros",
                                 mmf1 = res ++ "/hmm_tri/hmmdefs",
                                 dict = res ++ "/NumeralsSwe.dct",
                                 opts = [("TARGETKIND", "MFCC_0_D_A")]
                                        }
           _ -> fail $ "ATKSpeechInput: language " ++ l ++ " not supported"

-- | Current language for which we have loaded the HMM
--   and dictionary.
{-# NOINLINE currentLang #-}
currentLang :: IORef (Maybe String)
currentLang = unsafePerformIO $ newIORef Nothing

-- | Initializes the ATK, loading the given language.
--   ATK must not be initialized when calling this function.
loadLang :: String -> IO ()
loadLang lang = 
    do
    l <- getLanguage lang
    config <- getEnv_ "GF_ATK_CFG" gf_atk_cfg_error
    hPutStrLn stderr $ "Initializing ATK..."
    initialize (Just config) (opts l)
    let hmmName = "hmm_" ++ lang
        dictName = "dict_" ++ lang
    hPutStrLn stderr $ "Initializing ATK (" ++ lang ++ ")..."
    loadHMMSet hmmName (hmmlist l) (mmf0 l) (mmf1 l)
    loadDict dictName (dict l)
    writeIORef currentLang (Just lang)

initATK :: String -> IO ()
initATK lang = 
    do
    ml <- readIORef currentLang
    case ml of
            Nothing -> loadLang lang
            Just l | l == lang -> return ()
                   | otherwise -> do
                                  deinitialize
                                  loadLang lang

recognizeSpeech :: Ident -- ^ Grammar name
	        -> String -- ^ Language, e.g. en_UK
                -> CGrammar -- ^ Context-free grammar for input
                -> String -- ^ Start category name
                -> Int -- ^ Number of utterances
                -> IO [String]
recognizeSpeech name language cfg start number = 
    do
    -- FIXME: use cat
    let slf = slfPrinter name start cfg
        n = prIdent name
        hmmName = "hmm_" ++ language
        dictName = "dict_" ++ language
        slfName = "gram_" ++ n
        recName = "rec_" ++ language ++ "_" ++ n
    writeFile "debug.net" slf
    initATK language
    hPutStrLn stderr "Loading grammar..."
    loadGrammarString slfName slf
    createRecognizer recName hmmName dictName slfName
    hPutStrLn stderr "Listening..."
    s <- replicateM number (recognize recName)
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