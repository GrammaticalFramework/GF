----------------------------------------------------------------------
-- |
-- Module      : GF.System.NoSpeechInput
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/10 15:04:01 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- Dummy speech input.
-----------------------------------------------------------------------------

module GF.System.NoSpeechInput (recognizeSpeech) where

recognizeSpeech = fail "No speech input available"
