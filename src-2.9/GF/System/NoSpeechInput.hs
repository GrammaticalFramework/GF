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

import GF.Infra.Ident (Ident)
import GF.Infra.Option (Options)
import GF.Conversion.Types (CGrammar)


recognizeSpeech :: Ident -- ^ Grammar name
	        -> String -- ^ Language, e.g. en_UK
                -> CGrammar -- ^ Context-free grammar for input
                -> String -- ^ Start category name
                -> Int -- ^ Number of utterances
                -> IO [String]
recognizeSpeech _ _ _ _ _ = fail "No speech input available"
