module GF.Text.Coding where

import GF.Infra.Option
import GF.Text.UTF8
import GF.Text.CP1250
import GF.Text.CP1251
import GF.Text.CP1252

encodeUnicode e = case e of
  UTF_8   -> encodeUTF8
  CP_1250 -> encodeCP1250
  CP_1251 -> encodeCP1251
  CP_1252 -> encodeCP1252
  _       -> id

decodeUnicode e = case e of
  UTF_8   -> decodeUTF8
  CP_1250 -> decodeCP1250
  CP_1251 -> decodeCP1251
  CP_1252 -> decodeCP1252
  _       -> id
