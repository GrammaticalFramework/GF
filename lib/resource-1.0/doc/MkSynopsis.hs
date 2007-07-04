import System
import Char

main = do
  writeFile synopsis "GF Resource Grammar Library: Synopsis"
  append "Aarne Ranta"
  space
  title "Categories"
  space
  link "Source 1:" commonAPI
  space
  link "Source 2:" catAPI
  space
  cs1 <- getCats True commonAPI
  cs2 <- getCats False catAPI
  delimit $ cs1 ++ cs2
  space
  title "Syntax Rules"
  space
  link "Source:" syntaxAPI
  space
  rs <- getRules syntaxAPI
  delimit rs
  space
  title "Structural Words"
  space
  link "Source:" structuralAPI
  space
  rs <- getRules structuralAPI
  delimit rs
  space
  mapM_ putParadigms paradigmFiles
  space
  title "Example Usage"
  space
  ss <- readFile "synopsis-example.txt" >>= return . lines
  mapM_ append ss
  space
  system $ "txt2tags -thtml --toc " ++ synopsis

getCats isBeg file = do
  ss <- readFile file >>= return . lines
  return $ mkCatTable isBeg $ getrs [] ss
 where
   getrs rs ss = case ss of
     ('-':'-':'.':_):_ -> reverse rs
     [] -> reverse rs
     ('-':'-':_):ss2 -> getrs rs ss2
     s:ss2 -> case words s of
       cat:";":"--":exp -> getrs ((cat,unwords expl, unwords (tail ex)):rs) ss2 where
         (expl,ex) = span (/="e.g.") exp
       _ -> getrs rs ss2

getRules file = do
  ss <- readFile file >>= return . lines
  return $ mkTable $ getrs [] ss
 where
   getrs rs ss = case ss of
     ('-':'-':'.':_):_ -> reverse rs
     [] -> reverse rs
     ('-':'-':_):ss2 -> getrs rs ss2
     s:ss2 -> case words s of
       _:_:"overload":_ -> getrs rs ss2
       _:":":_ -> getrs (layout s:rs) ss2
       _ -> getrs rs ss2
   layout s = "  " ++ dropWhile isSpace s

putParadigms (lang,file) = do
  title ("Paradigms for " ++ lang)
  space
  link "source" file
  space
  rs <- getRules file
  space
  delimit rs
  space


mkTable rs = "|| Function  | Type  | Example  ||" : map (unwords . row . words) rs where
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
space = append "\n"
delimit ss = mapM_ append ss
link s f = append $ s ++ " [``" ++ fa ++ "`` " ++ f ++ "]" where
  fa = "http://www.cs.chalmers.se/~aarne/GF/lib/resource" ++ dropWhile (=='.') f

ttf s = "``" ++ s ++ "``"
itf s = "//" ++ s ++ "//"
