module GF.Text.Coding where

import GF.Text.UTF8
import GF.Text.CP1251

encodeUnicode e = case e of
  "utf8"   -> encodeUTF8
  "cp1251" -> encodeCP1251
  _        -> id

decodeUnicode e = case e of
  "utf8"   -> decodeUTF8
  "cp1251" -> decodeCP1251
  _        -> id
