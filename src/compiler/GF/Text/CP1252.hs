-----------------------------------------------------------------------------
-- |
-- Module      : GF.Text.CP1252
-- Maintainer  : Krasimir Angelov
--
-- cp1252 is a character encoding of the Latin alphabet, used by default in 
-- the legacy components of Microsoft Windows in English and some other 
-- Western languages.
--
-----------------------------------------------------------------------------

module GF.Text.CP1252 where

import Data.Char

decodeCP1252 = map id
encodeCP1252 = map (\x -> if x <= '\255' then x else '?')
