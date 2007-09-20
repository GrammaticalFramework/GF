module GF.Infra.CompactPrint where
import Data.Char

compactPrint = concat . map spaceIf . words 

spaceIf w = case w of
  _ | keyword w -> "\n" ++ w
  c:cs | isAlpha c || isDigit c -> " " ++ w
  _ -> w

keyword w = elem w ["cat","fun","lin","lincat","oper","param"]
