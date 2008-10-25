module GF.Text.Coding where

import GF.Text.UTF8
import GF.Text.CP1251
import GF.Text.CP1252

encodeUnicode e = case e of
  "utf8"   -> encodeUTF8
  "cp1251" -> encodeCP1251
  "cp1252" -> decodeCP1252
  _        -> id

decodeUnicode e = case e of
  "utf8"   -> decodeUTF8
  "cp1251" -> decodeCP1251
  "cp1252" -> decodeCP1252
  _        -> id
