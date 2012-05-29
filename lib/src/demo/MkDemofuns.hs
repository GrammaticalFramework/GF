import Char
import List

main = interact (unlines . map mkOne . lines)

mkOne line = case words line of 
  fun : ":" : typ -> mkGF fun (init typ)
  _ -> []

mkGF fun typ = unwords $ case typ of
  [ty] -> ["lin",fun] ++         ["=","mkTerm"]     ++ [quotes fun] ++ [";"]
  _    -> ["lin",fun] ++ args ++ ["=","mkTerm",lin] ++ args ++ [";"]
 where
   cats = filter (/="->") typ
   (src,target) = splitAt (length cats - 1) cats
   args = [x ++ "_" ++ show n | (x,n) <- zip (map unCap src) [1..]] 
   lin = quotes ("mk" ++ head target)

unCap = map toLower

quotes s = "\"" ++ s ++ "\""


