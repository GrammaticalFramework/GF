module Unicode where

import Greek (mkGreek)
import Arabic (mkArabic)
import Hebrew (mkHebrew)
import Russian (mkRussian, mkRusKOI8)
import Ethiopic (mkEthiopic)
import Tamil (mkTamil)
import OCSCyrillic (mkOCSCyrillic)
import LatinASupplement (mkLatinASupplement)
import Devanagari (mkDevanagari)
import Hiragana (mkJapanese)
import ExtendedArabic (mkExtendedArabic)

-- ad hoc Unicode conversions from different alphabets

-- AR 12/4/2000, 18/9/2001, 30/5/2002, HH 14/11/2003

mkUnicode s = case s of
 '/':'/':cs -> mkGreek   (remClosing cs)
 '/':'+':cs -> mkHebrew  (remClosing cs)
 '/':'-':cs -> mkArabic  (remClosing cs)
 '/':'_':cs -> mkRussian (remClosing cs)
 '/':'*':cs -> mkRusKOI8 (remClosing cs)
 '/':'E':cs -> mkEthiopic (remClosing cs)           -- HH
 '/':'T':cs -> mkTamil (remClosing cs)              -- HH
 '/':'C':cs -> mkOCSCyrillic (remClosing cs)        -- HH
 '/':'&':cs -> mkDevanagari (remClosing cs)         -- HH
 '/':'L':cs -> mkLatinASupplement (remClosing cs)   -- HH
 '/':'J':cs -> mkJapanese (remClosing cs)           -- HH
 '/':'A':cs -> mkExtendedArabic (remClosing cs)     -- HH
 _      -> s

remClosing cs 
 | lcs > 1 && last cs == '/' = take (lcs-2) cs
 | otherwise = cs
    where lcs = length cs

