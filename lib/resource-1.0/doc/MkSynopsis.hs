import System
import Char

main = do
  writeFile synopsis "GF Resource Grammar Library: Synopsis"
  append "Aarne Ranta"
  space
  title "Syntax"
  space
  link "source" syntaxAPI
  space
  rs <- getRules syntaxAPI
  delimit rs
  space
  mapM_ putParadigms paradigmFiles
  system $ "txt2tags -thtml --toc " ++ synopsis


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

putParadigms (lang,file) = do
  title ("Paradigms for " ++ lang)
  space
  link "source" file
  space
  rs <- getRules file
  space
  delimit rs
  space

layout s = "  " ++ dropWhile isSpace s


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

synopsis = "synopsis.txt"
syntaxAPI = "../api/Constructors.gf"
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
link s f = append $ "[" ++ s ++ " " ++ f ++ "]"

ttf s = "``" ++ s ++ "``"
itf s = "//" ++ s ++ "//"
