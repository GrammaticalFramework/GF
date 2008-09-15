module GF.Infra.CompactPrint where
import Data.Char

compactPrint = compactPrintCustom keywordGF (const False)

compactPrintGFCC = compactPrintCustom (const False) keywordGFCC

-- FIXME: using words is not safe, since this is run on UTF-8 encoded data.
compactPrintCustom pre post = id -- dps . concat . map (spaceIf pre post) . words 

dps = dropWhile isSpace

spaceIf pre post w = case w of
  _ | pre w -> "\n" ++ w
  _ | post w -> w ++ "\n"
  c:_ | isAlpha c || isDigit c -> " " ++ w
  '_':_  -> " " ++ w
  _ -> w

keywordGF w = elem w ["cat","fun","lin","lincat","lindef","oper","param"]
keywordGFCC w = 
  last w == ';' || 
  elem w ["flags","fun","cat","lin","oper","lincat","lindef","printname","param"]
