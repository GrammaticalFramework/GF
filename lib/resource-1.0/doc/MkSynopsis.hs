import System
import Char
import List

main = do
  xx <- getArgs
  let isLatex = case xx of
        "-tex":_ -> True
        _ -> False 
  writeFile synopsis "GF Resource Grammar Library: Synopsis"
  append "Aarne Ranta"
  space
  include "synopsis-intro.txt"
  title "Categories"
  space
  link "Source 1:" commonAPI
  space
  link "Source 2:" catAPI
  space
  cs1 <- getCats isLatex True  commonAPI
  cs2 <- getCats isLatex False catAPI
  let cs = cs1 ++ cs2
  delimit cs
  space
  title "Syntax Rules"
  space
  link "Source:" syntaxAPI
  space
  rs <- getRules isLatex syntaxAPI
  delimit rs
  space
  title "Structural Words"
  space
  link "Source:" structuralAPI
  space
  rs <- getRules isLatex structuralAPI
  delimit rs
  space
  mapM_ (putParadigms isLatex) paradigmFiles
  space
  title "An Example of Usage"
  space
  include "synopsis-example.txt"
  space
  let format = if isLatex then "tex" else "html"
  system $ "txt2tags -t" ++ format ++ " --toc " ++ synopsis
  if isLatex then (system $ "pdflatex synopsis.tex") >> return () else return ()

getCats isLatex isBeg file = do
  ss <- readFile file >>= return . lines
  return $ inChunks chsize (mkCatTable (isLatex || isBeg)) $ getrs [] ss
 where
   chsize = if isLatex then 40 else 1000
   getrs rs ss = case ss of
     ('-':'-':'.':_):_ -> reverse rs
     [] -> reverse rs
     ('-':'-':_):ss2 -> getrs rs ss2
     s:ss2 -> case words s of
       cat:";":"--":exp -> getrs ((cat,unwords expl, unwords (tail ex)):rs) ss2 where
         (expl,ex) = span (/="e.g.") exp
       _ -> getrs rs ss2

getRules isLatex file = do
  ss <- readFile file >>= return . lines
  return $ inChunks chsize mkTable $ getrs [] ss
 where
   chsize = if isLatex then 40 else 1000
   getrs rs ss = case ss of
     ('-':'-':'.':_):_ -> reverse rs
     [] -> reverse rs
     ('-':'-':_):ss2 -> getrs rs ss2
     s:ss2 -> case words s of
       _:_:"overload":_ -> getrs rs ss2
       _:":":_ -> getrs (layout s:rs) ss2
       _ -> getrs rs ss2
   layout s = "  " ++ dropWhile isSpace s

putParadigms isLatex (lang,file) = do
  title ("Paradigms for " ++ lang)
  space
  link "source" file
  space
  rs <- getRules isLatex file
  space
  delimit rs
  space

inChunks :: Int -> ([a] -> [String]) -> [a] -> [String]
inChunks i f = concat . intersperse ["\n\n"] . map f . chunks i where
  chunks _ [] = []
  chunks i xs = x : chunks i y where (x,y) = splitAt i xs

mkTable rs = header : map (unwords . row . words) rs where
  header = "|| Function  | Type  | Example  ||"
  row ws = ["|", name, "|", typ, "|", ex, "|"] where
    name = ttf (head ws)
    (t,e) = span (/="--") (tail ws)
    typ = ttf (unwords $ filtype (drop 1 t)) 
    ex = if null e then "-" else itf (unwords $ unnumber $ drop 1 e)
    unnumber e = case e of
      n:ws | last n == '.' && not (null (init n)) && all isDigit (init n) -> ws
      _ -> e
    filtype = filter (/=";")

mkCatTable isBeg rs = 
  (if isBeg then ("|| Category  | Explanation  | Example  ||" :) else id) 
    (map mk1 rs) 
 where
  mk1 (name,typ,ex) = unwords ["|", ttf name, "|", typ, "|", ex, "|"]

synopsis = "synopsis.txt"
commonAPI = "../abstract/Common.gf"
catAPI    = "../abstract/Cat.gf"
syntaxAPI = "../api/Constructors.gf"
structuralAPI = "../abstract/Structural.gf"
paradigmFiles = [
  ("Danish", "../danish/ParadigmsDan.gf"),
  ("English", "../english/ParadigmsEng.gf"),
  ("Finnish", "../finnish/ParadigmsFin.gf"),
  ("French",  "../french/ParadigmsFre.gf"),
  ("German",  "../german/ParadigmsGer.gf"),
  ("Italian",  "../italian/ParadigmsIta.gf"),
  ("Norwegian", "../norwegian/ParadigmsNor.gf"),
  ("Russian", "../russian/ParadigmsRus.gf"),
  ("Spanish",  "../spanish/ParadigmsSpa.gf"),
  ("Swedish",  "../swedish/ParadigmsSwe.gf")
  ]

append s = appendFile synopsis ('\n':s)
title s = append $ "=" ++ s ++ "="
include s = append $ "%!include: " ++ s
space = append "\n"
delimit ss = mapM_ append ss
link s f = append $ s ++ " [``" ++ fa ++ "`` " ++ f ++ "]" where
  fa = "http://www.cs.chalmers.se/~aarne/GF/lib/resource" ++ dropWhile (=='.') f

ttf s = "``" ++ s ++ "``"
itf s = "//" ++ s ++ "//"
