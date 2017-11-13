{-# OPTIONS_HADDOCK hide #-}
-------------------------------------------------
-- |
-- Stability   : unstable
--
-------------------------------------------------
module PGF.Internal(CId,
                    FId,isPredefFId,
                    FunId,SeqId,LIndex,
                    Production(..),PArg(..),Symbol(..),
                    
                    fidString, fidInt, fidFloat, fidVar, fidStart
                    ) where

import PGF.Data
