-- convert annotated word list to GF lexicon

import Data.Char

main = 
  interact (unlines . map (unwords . mkEntry . words) . lines)

-- [bare_A] paljas

mkEntry (fun_:trans) = [fun, "=", oper, args, ";"] where
  fun = tail (init fun_)  -- unbracket
  (name,cat) = let (tac,eman) = span (/= '_') (reverse fun) in (reverse (tail eman),reverse tac)
  oper = "mk" ++ cat 
  args = case cat of
    'V':_  -> unwords (map quoteIf trans)
    "Prep" -> unwords (map quoteIf trans)
    _ | null trans -> quote (mkUpper name)
    _ -> quote (unwords trans)

quote s = "\"" ++ s ++ "\""

-- [absent_Prep] poissa +elative
quoteIf s = case s of
  '+':cs -> cs
  _ -> quote s

mkUpper w = case w of
  c:cs -> toUpper c : cs
  _ -> w
