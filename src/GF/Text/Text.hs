module Text where

import Operations
import Char

-- elementary text postprocessing. AR 21/11/2001
-- This is very primitive indeed. The functions should work on
-- token lists and not on strings. AR 5/12/2002


formatAsTextLit :: String -> String
formatAsTextLit = formatAsText . unwords . map unStringLit . words 
--- hope that there will be deforestation...

formatAsCodeLit :: String -> String
formatAsCodeLit = formatAsCode . unwords . map unStringLit . words 

formatAsText :: String -> String
formatAsText = unwords . format . cap . words where
  format ws = case ws of
    w : c : ww | major c -> (w ++ c)      : format (cap ww)
    w : c : ww | minor c -> (w ++ c)      : format ww
    c     : ww | para  c -> "\n\n"        : format ww
    w     : ww           -> w             : format ww
    [] -> []
  cap (p:(c:cs):ww) | para p = p : (toUpper c : cs) : ww
  cap ((c:cs):ww) = (toUpper c : cs) : ww
  cap [] = []
  major = flip elem (map singleton ".!?") 
  minor = flip elem (map singleton ",:;")
  para  = (=="<p>") 

formatAsCode :: String -> String
formatAsCode = rend 0 . words where
  -- render from BNF Converter
  rend i ss = case ss of
    "["      :ts -> cons "["  $ rend i ts
    "("      :ts -> cons "("  $ rend i ts
    "{"      :ts -> cons "{"  $ new (i+1) $ rend (i+1) ts
    "}" : ";":ts -> new (i-1) $ space "}" $ cons ";" $ new (i-1) $ rend (i-1) ts
    "}"      :ts -> new (i-1) $ cons "}" $ new (i-1) $ rend (i-1) ts
    ";"      :ts -> cons ";"  $ new i $ rend i ts
    t  : "," :ts -> cons t    $ space "," $ rend i ts
    t  : ")" :ts -> cons t    $ cons ")"  $ rend i ts
    t  : "]" :ts -> cons t    $ cons "]"  $ rend i ts
    t        :ts -> space t   $ rend i ts
    _            -> ""
  cons s t  = s ++ t
  new i s   = '\n' : replicate (2*i) ' ' ++ dropWhile isSpace s
  space t s = if null s then t else t ++ " " ++ s

performBinds :: String -> String
performBinds = unwords . format . words where
  format ws = case ws of
    w : "&+" : u : ws -> format ((w ++ u) : ws)
    w : ws            -> w : format ws
    []                -> []

unStringLit :: String -> String
unStringLit s = case s of
  c : cs | strlim c && strlim (last cs) -> init cs
  _ -> s
 where
   strlim = (=='\'')
