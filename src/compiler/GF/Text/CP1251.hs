-----------------------------------------------------------------------------
-- |
-- Module      : GF.Text.CP1251
-- Maintainer  : Krasimir Angelov
--
-- cp1251 is a popular 8-bit character encoding, designed to cover languages
-- that use the Cyrillic alphabet such as Russian, Bulgarian, Serbian Cyrillic
-- and other languages. It is the most widely used for encoding the Bulgarian,
-- Serbian and Macedonian languages.
--
-----------------------------------------------------------------------------

module GF.Text.CP1251 where

import Data.Char

decodeCP1251 = map convert where
  convert c
   | c >= '\xC0' && c <= '\xFF' = chr (ord c + (0x410-0xC0))
   | c == '\xA8'                = chr 0x401      -- cyrillic capital letter lo
   | c == '\x80'                = chr 0x402
   | c == '\x81'                = chr 0x403
   | c == '\xAA'                = chr 0x404
   | c == '\xBD'                = chr 0x405
   | c == '\xB2'                = chr 0x406
   | c == '\xAF'                = chr 0x407
   | c == '\xA3'                = chr 0x408
   | c == '\x8A'                = chr 0x409
   | c == '\x8C'                = chr 0x40A
   | c == '\x8E'                = chr 0x40B
   | c == '\x8D'                = chr 0x40C
   | c == '\xA1'                = chr 0x40E
   | c == '\x8F'                = chr 0x40F
   | c == '\xB8'                = chr 0x451      -- cyrillic small   letter lo
   | c == '\x90'                = chr 0x452
   | c == '\x83'                = chr 0x453
   | c == '\xBA'                = chr 0x454
   | c == '\xBE'                = chr 0x455
   | c == '\xB3'                = chr 0x456
   | c == '\xBF'                = chr 0x457
   | c == '\xBC'                = chr 0x458
   | c == '\x9A'                = chr 0x459
   | c == '\x9C'                = chr 0x45A
   | c == '\x9E'                = chr 0x45B
   | c == '\x9D'                = chr 0x45C
   | c == '\xA2'                = chr 0x45E
   | c == '\x9F'                = chr 0x45F
   | c == '\xA5'                = chr 0x490
   | c == '\xB4'                = chr 0x491
   | otherwise                  = c

encodeCP1251 = map convert where
  convert c
   | oc >= 0x410 && oc <= 0x44F = chr (oc - (0x410-0xC0))
   | oc == 0x401                = '\xA8'         -- cyrillic capital letter lo
   | oc == 0x402                = '\x80'
   | oc == 0x403                = '\x81'
   | oc == 0x404                = '\xAA'
   | oc == 0x405                = '\xBD'
   | oc == 0x406                = '\xB2'
   | oc == 0x407                = '\xAF'
   | oc == 0x408                = '\xA3'
   | oc == 0x409                = '\x8A'
   | oc == 0x40A                = '\x8C'
   | oc == 0x40B                = '\x8E'
   | oc == 0x40C                = '\x8D'
   | oc == 0x40E                = '\xA1'
   | oc == 0x40F                = '\x8F'
   | oc == 0x451                = '\xB8'         -- cyrillic small   letter lo
   | oc == 0x452                = '\x90'
   | oc == 0x453                = '\x83'
   | oc == 0x454                = '\xBA'
   | oc == 0x455                = '\xBE'
   | oc == 0x456                = '\xB3'
   | oc == 0x457                = '\xBF'
   | oc == 0x458                = '\xBC'
   | oc == 0x459                = '\x9A'
   | oc == 0x45A                = '\x9C'
   | oc == 0x45B                = '\x9E'
   | oc == 0x45C                = '\x9D'
   | oc == 0x45E                = '\xA2'
   | oc == 0x45F                = '\x9F'
   | oc == 0x490                = '\xA5'
   | oc == 0x491                = '\xB4'
   | otherwise                  = c
   where oc = ord c
