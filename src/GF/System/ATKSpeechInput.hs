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
import System.IO
import System.IO.Unsafe

-- FIXME: get these from somewhere else

config = "/home/bjorn/projects/atkrec/atkrec.cfg"

res = "/home/bjorn/src/atk/Resources"
hmmlist = res ++ "/UK_SI_ZMFCC/hmmlistbg"
mmf0 = res ++ "/UK_SI_ZMFCC/WI4"
mmf1 = res ++ "/UK_SI_ZMFCC/BGHMM2"
dict = res ++ "/beep.dct"

initialized :: IORef Bool
initialized = unsafePerformIO $ newIORef False

initATK :: IO ()
initATK = do
       b <- readIORef initialized
       when (not b) $ do
                      hPutStrLn stderr "Initializing..."
                      initialize config
                      loadHMMSet "hmm_english" hmmlist mmf0 mmf1
                      loadDict "dict_english" dict
                      writeIORef initialized True

recognizeSpeech :: Ident -- ^ Grammar name
	        -> Options -> CGrammar -> IO String
recognizeSpeech name opts cfg = 
    do
    let slf = slfPrinter name opts cfg
        n = prIdent name
        slfName = "gram_" ++ n
        recName = "rec_english_" ++ n
    initATK
    loadGrammarString slfName slf
    createRecognizer recName "hmm_english" "dict_english" slfName
    hPutStrLn stderr "Listening..."
    s <- recognize recName
    return s
