{-# OPTIONS -cpp #-}

----------------------------------------------------------------------
-- |
-- Module      : GF.System.SpeechInput
-- Maintainer  : BB
-- Stability   : (stable)
-- Portability : (portable)
--
-- > CVS $Date: 2005/05/10 15:04:01 $ 
-- > CVS $Author: bringert $
-- > CVS $Revision: 1.2 $
--
-- Uses the right speech recognition library for speech input.
-----------------------------------------------------------------------------

module GF.System.SpeechInput (recognizeSpeech) where

#ifdef USE_ATK

import GF.System.ATKSpeechInput (recognizeSpeech)

#else

import GF.System.NoSpeechInput (recognizeSpeech)

#endif
