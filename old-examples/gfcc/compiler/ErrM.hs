-- BNF Converter: Error Monad
-- Copyright (C) 2004  Author:  Aarne Ranta

-- This file comes with NO WARRANTY and may be used FOR ANY PURPOSE.
module ErrM where

-- the Error monad: like Maybe type with error msgs

data Err a = Ok a | Bad String
  deriving (Read, Show, Eq)

instance Monad Err where
  return      = Ok
  Ok a  >>= f = f a
  Bad s >>= f = Bad s
