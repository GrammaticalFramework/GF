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
import ExtendedArabic (mkArabic0600)
import ExtendedArabic (mkExtendedArabic)
import ExtraDiacritics (mkExtraDiacritics)

import Char

-- ad hoc Unicode conversions from different alphabets

-- AR 12/4/2000, 18/9/2001, 30/5/2002, 26/1/2004

mkUnicode s = case s of
  '/':'/':cs -> treat [] mkGreek   unic ++ mkUnicode rest
  '/':'+':cs -> mkHebrew  unic ++ mkUnicode rest
  '/':'-':cs -> mkArabic  unic ++ mkUnicode rest
  '/':'_':cs -> treat [] mkRussian unic ++ mkUnicode rest
  '/':'*':cs -> mkRusKOI8 unic ++ mkUnicode rest
  '/':'E':cs -> mkEthiopic unic ++ mkUnicode rest
  '/':'T':cs -> mkTamil unic ++ mkUnicode rest
  '/':'C':cs -> mkOCSCyrillic unic ++ mkUnicode rest
  '/':'&':cs -> mkDevanagari unic ++ mkUnicode rest
  '/':'L':cs -> mkLatinASupplement unic ++ mkUnicode rest
  '/':'J':cs -> mkJapanese unic ++ mkUnicode rest
  '/':'6':cs -> mkArabic0600 unic ++ mkUnicode rest
  '/':'A':cs -> mkExtendedArabic unic ++ mkUnicode rest
  '/':'X':cs -> mkExtraDiacritics unic ++ mkUnicode rest
  c:cs -> c:mkUnicode cs
  _ -> s
 where
   (unic,rest) = remClosing [] $ dropWhile isSpace $ drop 2 s
   remClosing u s = case s of
     c:'/':s | elem c "/+-_*ETC&LJ6AX" -> (reverse u, s) --- end need not match
     c:cs -> remClosing (c:u) cs
     _ -> (reverse u,[]) -- forgiving missing end

   -- don't convert XML tags --- assumes <> always means XML tags
   treat old mk s = case s of
     '<':cs -> mk (reverse old) ++ '<':noTreat cs
     c:cs -> treat (c:old) mk cs
     _ -> mk (reverse old)
    where
      noTreat s = case s of
        '>':cs -> '>' : treat [] mk cs
        c:cs -> c : noTreat cs
        _ -> s
