module Unicode where

import Greek (mkGreek)
import Arabic (mkArabic)
import Hebrew (mkHebrew)
import Russian (mkRussian, mkRusKOI8)

-- ad hoc Unicode conversions from different alphabets

-- AR 12/4/2000, 18/9/2001, 30/5/2002

mkUnicode s = case s of
 '/':'/':cs -> mkGreek   (remClosing cs)
 '/':'+':cs -> mkHebrew  (remClosing cs)
 '/':'-':cs -> mkArabic  (remClosing cs)
 '/':'_':cs -> mkRussian (remClosing cs)
 '/':'*':cs -> mkRusKOI8 (remClosing cs)
 _      -> s

remClosing cs 
 | lcs > 1 && last cs == '/' = take (lcs-2) cs
 | otherwise = cs
    where lcs = length cs

