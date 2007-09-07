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
  append "==A hierarchic view==\n"
  include "categories-intro.txt"
  append "==Explanations==\n"
  delimit $ reCat cs
  space
  title "Syntax Rules"
  space
  link "Source:" syntaxAPI
  space
  rs <- getRules True isLatex syntaxAPI
  delimit $ reTable rs
  space
  title "Structural Words"
  space
  link "Source:" structuralAPI
  space
  rs <- getRules False isLatex structuralAPI
  delimit rs
  space
  mapM_ (putParadigms isLatex) paradigmFiles
  space
  include "synopsis-browse.txt"
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

getRules hasEx isLatex file = do
  ss <- readFile file >>= return . lines
  return $ inChunks chsize (mkTable hasEx) $ getrs [] ss
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

getParads = getRules False

putParadigms isLatex (lang,file) = do
  title ("Paradigms for " ++ lang)
  space
  link "source" file
  space
  rs <- getParads isLatex file
  space
  delimit rs
  space

inChunks :: Int -> ([a] -> [String]) -> [a] -> [String]
inChunks i f = concat . intersperse ["\n\n"] . map f . chunks i where
  chunks _ [] = []
  chunks i xs = x : chunks i y where (x,y) = splitAt i xs

mkTable hasEx rs = header : map (unwords . row . words) rs where
  header = if hasEx then "|| Function  | Type  | Example  ||" 
                    else "|| Function  | Type  ||"
  row ws = if hasEx then ["|", name, "|", typ, "|", ex, "|"]
                    else ["|", name, "|", typ, "|"] where
    name = ttf (head ws)
    (t,e) = span (/="--") (tail ws)
    typ = ttf (unwords $ filtype (drop 1 t)) 
    ex = if null e then "-" else itf (unwords $ unnumber $ drop 1 e)
    unnumber e = case e of
      n:ws | last n == '.' && not (null (init n)) && all isDigit (init n) -> ws
      _ -> e
    filtype = filter (/=";")

mkParTable rs = header : map (unwords . row . words) rs where
  header = "|| Paradigm  | Type  ||"
  row ws = ["|", name, "|", typ, "|"] where
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
  mk1 (name,typ,ex) = unwords ["|", ttf name, "|", typ, "|", typo ex, "|"]
  typo ex = if take 1 ex == "\"" then itf (init (tail ex)) else ex

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

-----------------

-- sort category synopsis by category, retain one table

reCat t = let (hd,tb) = splitHeader t in hd : sortCat tb

sortCat = sortBy (\r s -> compare (cat r) (cat s)) where
  cat r = unquote $ words r !! 1

unquote = takeWhile (/='`') . dropWhile (=='`')

-- sort function synopsis by category, into separate tables

-- table:
-- || Function  | Type  | Example  ||
-- | ``mkText`` | ``Phr -> Text`` | //But John walks.// |

reTable t = let (hd,tb) = splitHeader t in sortTable hd tb

splitHeader (hd:tb) = (hd,tb)

sortTable hd = map (printBack hd) . sortVal . groupVal

groupVal = groupBy sameVal where
  sameVal r1 r2 = valRow r1 == valRow r2

-- row: | ``mkText`` | ``Phr -> Text`` | //But John walks.// |
valRow r = case words r of
  "|":_:"|":rest -> val where
    typ = takeWhile (/="|") rest
    val = unquote $ last typ
  _ -> error "no row value for: " ++ r

sortVal = sortBy (\t u -> compare (hd t) (hd u)) where
  hd = (valRow . head)

printBack hd tb = unlines $ subtitle (valRow (head tb)) : "\n" : [hd] ++ tb

subtitle cat = "==" ++ cat ++ "=="

