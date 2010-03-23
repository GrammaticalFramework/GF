-----------------------------------------------------------------------------
-- |
-- Module      : GF.Text.CP1254
-- Maintainer  : Krasimir Angelov
--
-- cp1254 is a code page used under Microsoft Windows to write Turkish.
-- Characters with codepoints A0 through FF are compatible with ISO 8859-9.
--
-----------------------------------------------------------------------------

module GF.Text.CP1254 where

import Data.Char

decodeCP1254 = map convert where
  convert c
   | c == '\x80'                = chr 0x20AC
   | c == '\x82'                = chr 0x201A
   | c == '\x83'                = chr 0x192
   | c == '\x84'                = chr 0x201E
   | c == '\x85'                = chr 0x2026
   | c == '\x86'                = chr 0x2020
   | c == '\x87'                = chr 0x2021
   | c == '\x88'                = chr 0x2C6
   | c == '\x89'                = chr 0x2030
   | c == '\x8A'                = chr 0x160
   | c == '\x8B'                = chr 0x2039
   | c == '\x8C'                = chr 0x152
   | c == '\x91'                = chr 0x2018
   | c == '\x92'                = chr 0x2019
   | c == '\x93'                = chr 0x201C
   | c == '\x94'                = chr 0x201D
   | c == '\x95'                = chr 0x2022
   | c == '\x96'                = chr 0x2013
   | c == '\x97'                = chr 0x2014
   | c == '\x98'                = chr 0x2DC
   | c == '\x99'                = chr 0x2122
   | c == '\x9A'                = chr 0x161
   | c == '\x9B'                = chr 0x203A
   | c == '\x9C'                = chr 0x153
   | c == '\x9F'                = chr 0x178
   | c == '\xD0'                = chr 0x11E
   | c == '\xDD'                = chr 0x130
   | c == '\xDE'                = chr 0x15E
   | c == '\xF0'                = chr 0x11F
   | c == '\xFD'                = chr 0x131
   | c == '\xFE'                = chr 0x15F
   | otherwise                  = c

encodeCP1254 = map convert where
  convert c
   | oc == 0x20AC               = '\x80'
   | oc == 0x201A               = '\x82'
   | oc == 0x192                = '\x83'
   | oc == 0x201E               = '\x84'
   | oc == 0x2026               = '\x85'
   | oc == 0x2020               = '\x86'
   | oc == 0x2021               = '\x87'
   | oc == 0x2C6                = '\x88'
   | oc == 0x2030               = '\x89'
   | oc == 0x160                = '\x8A'
   | oc == 0x2039               = '\x8B'
   | oc == 0x152                = '\x8C'
   | oc == 0x2018               = '\x91'
   | oc == 0x2019               = '\x92'
   | oc == 0x201C               = '\x93'
   | oc == 0x201D               = '\x94'
   | oc == 0x2022               = '\x95'
   | oc == 0x2013               = '\x96'
   | oc == 0x2014               = '\x97'
   | oc == 0x2DC                = '\x98'
   | oc == 0x2122               = '\x99'
   | oc == 0x161                = '\x9A'
   | oc == 0x203A               = '\x9B'
   | oc == 0x153                = '\x9C'
   | oc == 0x178                = '\x9F'
   | oc == 0x11E                = '\xD0'
   | oc == 0x130                = '\xDD'
   | oc == 0x15E                = '\xDE'
   | oc == 0x11F                = '\xF0'
   | oc == 0x131                = '\xFD'
   | oc == 0x15F                = '\xFE'
   | otherwise                  = c
   where oc = ord c
