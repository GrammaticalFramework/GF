module Main where

import List
import System
import Char

-- produce a HTML document from a list of GF grammar files. AR 6/10/2002

-- to read files and write a file

main :: IO ()
main = do
  xx <- getArgs
  let 
   (typ,format,name) = case xx of
    "+latex" : x: [] -> (True,doc2latex,x)
    x:[]             -> (False,doc2html,x)
    _ -> (True,doc2html, "unknown.txt") ---
  if null xx
     then do
       putStrLn welcome
       putStrLn help
     else do  
       ss <- readFile name
       let outfile = fileFormat typ name
       writeFile outfile $ format $ pDoc $ ss

welcome = unlines [
  "",
  "gfdoc - a rudimentary GF document generator.",
  "(c) Aarne Ranta (aarne@cs.chalmers.se) 2002 under GNU GPL."
  ]

help = unlines $ [
  "",
  "Usage: gfdoc (+latex) file",
  "",
  "The program operates with lines in GF code, treating them into LaTeX",
  "(flag +latex) or to HTML (by default). The output is written in a file",
  "whose name is formed from the input file name by replacing its suffix",
  "with html or tex.",
  "",
  "The translation is line by line",
  "depending as follows on how the line begins",
  "",
  " --[Int]    heading of level Int",  
  " --         new paragraph",
  " --.        end of document",
---  " ---        ignore this comment line in document",
---  " {---}      ignore this code line in document",
  " --[Text]   Text belongs to text paragraph",
  " [Text]     Text belongs to code paragraph",
  "",
  "Within a text paragraph, text enclosed between certain characters",
  "is treated specially:",
  "",
  " *[Text]*   emphasized (boldface)",
  " \"[Text]\"   example string (italics)",
  " $[Text]$   example code (courier)"
  ]

fileFormat isLatex x = body ++ if isLatex then "tex" else "html" where
  body = reverse $ dropWhile (/='.') $ reverse x

-- the document datatype

data Doc = Doc Title [Paragraph]

type Title = [TextItem]

data Paragraph = 
   Text [TextItem]         -- text line starting with --
 | List [[TextItem]]       -- 
 | Code String             -- other text line
 | New                     -- new paragraph: line consisting of --
 | Heading Int [TextItem]  -- text line starting with --n where n = 1,2,3,4

data TextItem =
   Str String
 | Emp String  -- emphasized,     *...*
 | Lit String  -- string literal, "..."
 | Inl String  -- inlined code,   '...'


-- parse document

pDoc :: String -> Doc
pDoc s = case lines s of
  ('-':'-':'1':title) : paras -> Doc (pItems title) (map pPara (grp paras))
  paras -> Doc [] (map pPara (grp paras))
 where
   grp ss = case ss of
     s : rest --- | ignore s      -> grp rest
              | isEnd s       -> []
              | begComment s  -> let (s1,s2) = getComment (drop 2 s : rest) 
                                 in map ("-- " ++) s1 ++ grp s2 
              | isComment s   -> s : grp rest
              | all isSpace s -> grp rest
     [] -> []
     _ -> unlines code : grp rest where (code,rest) = span (not . isComment) ss 
   pPara s = case s of
     '-':'-':d:text | isDigit d -> Heading (read [d]) (pItems text)
     '-':'-':[]                 -> New
     '-':'-':text               -> Text (pItems (dropWhile isSpace text))
     _                          -> Code s
   pItems s = case s of
     '*'  : cs -> get 1 Emp (=='*')  cs
     '"'  : cs -> get 1 Lit (=='"')  cs
     '$'  : cs -> get 1 Inl (=='$') cs
     []        -> []
     _         -> get 0 Str (flip elem "*\"$") s

   get _ _   _     [] = []
   get k con isEnd cs = con beg : pItems (drop k rest) 
                    where (beg,rest) =  span (not . isEnd) cs
 
   ignore s = case s of
     '-':'-':'-':_ -> True
     '{':'-':'-':'-':'}':_ -> True
     _ -> False

   isEnd s = case s of
     '-':'-':'.':_ -> True
     _ -> False


-- render in html

doc2html :: Doc -> String
doc2html (Doc title paras) = unlines $
  tagXML "html" $
    tagXML "body" $
      unwords (tagXML "i" ["Produced by " ++ welcome]) :
      mkTagXML "p" :
      concat (tagXML "h1" [concat (map item2html title)]) :
      empty :
      map para2html paras

para2html :: Paragraph -> String
para2html p = case p of
  Text its      -> concat (map item2html its)
  Code s        -> unlines $ tagXML "pre" $ map (indent 2) $ 
                                              remEmptyLines $ lines $ spec s
  New           -> mkTagXML "p"
  Heading i its -> concat $ tagXML ('h':show i) [concat (map item2html its)]

item2html :: TextItem -> String
item2html i = case i of
  Str s -> spec s
  Emp s -> concat $ tagXML "b" [spec s]
  Lit s -> concat $ tagXML "i" [spec s]
  Inl s -> concat $ tagXML "tt" [spec s]

mkTagXML t = '<':t ++ ">"
mkEndTagXML t = mkTagXML ('/':t)
tagXML t ss = mkTagXML t : ss ++ [mkEndTagXML t]

spec = elimLt

elimLt s = case s of
  '<':cs -> "&lt;" ++ elimLt cs
  c  :cs -> c : elimLt cs
  _      -> s


-- render in latex

doc2latex :: Doc -> String
doc2latex (Doc title paras) = unlines $
  preludeLatex :
  funLatex "title"  [concat (map item2latex title)] :
  funLatex "author" [fontLatex "footnotesize" (welcome)] :
  envLatex "document" (
    funLatex "maketitle" [] :
    map para2latex paras)   

para2latex :: Paragraph -> String
para2latex p = case p of
  Text its      -> concat (map item2latex its)
  Code s        -> unlines $ envLatex "verbatim" $ map (indent 2) $ 
                                                   remEmptyLines $ lines $ s
  New           -> "\n"
  Heading i its -> headingLatex i (concat (map item2latex its))

item2latex :: TextItem -> String
item2latex i = case i of
  Str s -> specl s
  Emp s -> fontLatex "bf" (specl s)
  Lit s -> fontLatex "it" (specl s)
  Inl s -> fontLatex "tt" (specl s)

funLatex :: String -> [String] -> String
funLatex f xs = "\\" ++ f ++ concat ["{" ++ x ++ "}" | x <- xs]

envLatex :: String -> [String] -> [String]
envLatex e ss = 
  funLatex "begin" [e] :
  ss ++
  [funLatex "end" [e]]

headingLatex :: Int -> String -> String
-- for slides
-- headingLatex _ s = funLatex "newone" [] ++ "\n" ++ funLatex "heading" [s] 
headingLatex i s = funLatex t [s] where 
  t = case i of
    2 -> "section"
    3 -> "subsection"
    _ -> "subsubsection"

fontLatex :: String -> String -> String
fontLatex f s = "{\\" ++ f ++ " " ++ s ++ "}"

specl = eliml

eliml s = case s of
  '|':cs -> mmath "mid" ++ elimLt cs
  '{':cs -> mmath "\\{" ++ elimLt cs
  '}':cs -> mmath "\\}" ++ elimLt cs
  _      -> s

mmath s = funLatex "mbox" ["$" ++ s ++ "$"]

preludeLatex = unlines $ [
  "\\documentclass[12pt]{article}",
  "\\usepackage{isolatin1}",
  "\\setlength{\\oddsidemargin}{0mm}",
  "\\setlength{\\evensidemargin}{-2mm}",
  "\\setlength{\\topmargin}{-16mm}",
  "\\setlength{\\textheight}{240mm}",
  "\\setlength{\\textwidth}{158mm}",
  "\\setlength{\\parskip}{2mm}",
  "\\setlength{\\parindent}{0mm}"
 ]

-- auxiliaries

empty = ""

isComment = (== "--") . take 2

begComment =  (== "{-") . take 2

getComment ss = case ss of
  "-}":ls -> ([],ls)
  l:ls -> (l : s1, s2) where (s1,s2) = getComment ls
  _    -> ([],[])

indent n = (replicate n ' ' ++)

remEmptyLines = rem False where
  rem prevGood ls = case span empty ls of
    (_ :_, ss@(_ : _)) -> (if prevGood then ("":) else id) $ rem False ss
    (_,    [])         -> []
    (_,    s:ss)       -> s : rem True ss 
  empty = all isSpace
