module GF.Infra.CompactPrint where
import Data.Char

compactPrint = compactPrintCustom keywordGF (const False)

compactPrintGFCC = compactPrintCustom (const False) keywordGFCC

compactPrintCustom pre post = tail . concat . map (spaceIf pre post) . words 

spaceIf pre post w = case w of
  _ | pre w -> "\n" ++ w
  _ | post w -> w ++ "\n"
  c:cs | isAlpha c || isDigit c -> " " ++ w
  _ -> w

keywordGF w = elem w ["cat","fun","lin","lincat","lindef","oper","param"]
keywordGFCC w = 
  last w == ';' || 
  elem w ["flags","fun","cat","lin","oper","lincat","lindef","printname"]