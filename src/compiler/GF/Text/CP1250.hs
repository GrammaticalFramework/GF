-----------------------------------------------------------------------------
-- |
-- Module      : GF.Text.CP1250
-- Maintainer  : Krasimir Angelov
--
-- cp1250 is a code page used under Microsoft Windows to represent texts 
-- in Central European and Eastern European languages that use Latin script, 
-- such as Polish, Czech, Slovak, Hungarian, Slovene, Bosnian, Croatian, 
-- Serbian (Latin script), Romanian and Albanian. It may also be used with 
-- the German language; German-language texts encoded with cp1250 and cp1252 
-- are identical.
--
-----------------------------------------------------------------------------

module GF.Text.CP1250 where

import Data.Char

decodeCP1250 = map convert where
  convert c
   | c == '\x80'                = chr 0x20AC
   | c == '\x82'                = chr 0x201A
   | c == '\x84'                = chr 0x201E
   | c == '\x85'                = chr 0x2026
   | c == '\x86'                = chr 0x2020
   | c == '\x87'                = chr 0x2021
   | c == '\x89'                = chr 0x2030
   | c == '\x8A'                = chr 0x0160
   | c == '\x8B'                = chr 0x2039
   | c == '\x8C'                = chr 0x015A
   | c == '\x8D'                = chr 0x0164
   | c == '\x8E'                = chr 0x017D
   | c == '\x8F'                = chr 0x0179
   | c == '\x91'                = chr 0x2018
   | c == '\x92'                = chr 0x2019
   | c == '\x93'                = chr 0x201C
   | c == '\x94'                = chr 0x201D
   | c == '\x95'                = chr 0x2022
   | c == '\x96'                = chr 0x2013
   | c == '\x97'                = chr 0x2014
   | c == '\x99'                = chr 0x2122
   | c == '\x9A'                = chr 0x0161
   | c == '\x9B'                = chr 0x203A
   | c == '\x9C'                = chr 0x015B
   | c == '\x9D'                = chr 0x0165
   | c == '\x9E'                = chr 0x017E
   | c == '\x9F'                = chr 0x017A
   | c == '\xA1'                = chr 0x02C7
   | c == '\xA5'                = chr 0x0104
   | c == '\xB9'                = chr 0x0105
   | c == '\xBC'                = chr 0x013D
   | c == '\xBE'                = chr 0x013E
   | otherwise                  = c


encodeCP1250 = map convert where
  convert c
   | oc == 0x20AC               = '\x80'
   | oc == 0x201A               = '\x82'
   | oc == 0x201E               = '\x84'
   | oc == 0x2026               = '\x85'
   | oc == 0x2020               = '\x86'
   | oc == 0x2021               = '\x87'
   | oc == 0x2030               = '\x89'
   | oc == 0x0160               = '\x8A'
   | oc == 0x2039               = '\x8B'
   | oc == 0x015A               = '\x8C'
   | oc == 0x0164               = '\x8D'
   | oc == 0x017D               = '\x8E'
   | oc == 0x0179               = '\x8F'
   | oc == 0x2018               = '\x91'
   | oc == 0x2019               = '\x92'
   | oc == 0x201C               = '\x93'
   | oc == 0x201D               = '\x94'
   | oc == 0x2022               = '\x95'
   | oc == 0x2013               = '\x96'
   | oc == 0x2014               = '\x97'
   | oc == 0x2122               = '\x99'
   | oc == 0x0161               = '\x9A'
   | oc == 0x203A               = '\x9B'
   | oc == 0x015B               = '\x9C'
   | oc == 0x0165               = '\x9D'
   | oc == 0x017E               = '\x9E'
   | oc == 0x017A               = '\x9F'
   | oc == 0x02C7               = '\xA1'
   | oc == 0x0104               = '\xA5'
   | oc == 0x0105               = '\xB9'
   | oc == 0x013D               = '\xBC'
   | oc == 0x013E               = '\xBE'
   | otherwise                  = c
   where oc = ord c
