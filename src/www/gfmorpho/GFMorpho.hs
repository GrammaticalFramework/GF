import Network.HTTP.Base
import Codec.Binary.UTF8.String
import Data.Char
import Data.List
import System

main = do
  xs <- getArgs
  let xxoo = lexArgs (unwords xs)
  case pArgs xxoo of 
    Just (oo,xx) -> do
      morpho oo xx
    _ -> do
      putStrLn $ "cannot read " ++ unwords xs ++ "."
      putStrLn "<p>"
      putStrLn usage

usage = "usage: gfmorpho LANG POS FORMS OPT*"

noParse xx = length xx < 3 ----

lexArgs = map (decodeString . urlDecode) . words . map unspec . drop 1 . dropWhile (/='=') where
  unspec c = case c of
    '=' -> ' ' 
    '+' -> ' ' 
    _ -> c

pArgs xxoo = do
  let (oo,xx) = partition isOption xxoo
  if length xx < 3 then Nothing else return (oo,xx)

morpho :: [String] -> [String] -> IO ()
morpho oo xx = do
  writeFile tmpCommand (script xx)
  system $ command xx
  s <- readFile tmpFile
  putStrLn $ mkFile $ response oo s

script ("!":lang:rest) = "cc -table -unqual " ++ unwords rest
script (lang: pos: forms) = "cc -table -unqual " ++ fun pos ++ quotes forms 
  where 
    fun pos = "mk" ++ pos

command ("!":args) = command args
command (lang: pos: forms) = 
  "/usr/local/bin/gf -run -retain -path=alltenses alltenses/Paradigms" ++ lang ++ ".gfo"
  ++ " < " ++ tmpCommand
  ++ " > " ++ tmpFile

quotes = unwords . map quote where
  quote s = case s of
    '_':tag -> tag
    _ -> "\"" ++ s ++ "\""

-- html response
response oo = 
  tag "table border=1" . unlines . map (tag "tr" . unwords) . map cleanTable . grep oo . map words . lines

cleanTable ws = [tag "td" (unwords param), tag "td" (tag "i" (unwords form))] where
  (param,form) = getOne (map cleant ws)
  cleant w = case w of
    "s"  -> ""
    "."  -> ""   
    _ -> cleanw w
  cleanw = filter (flip notElem "()")
  getOne ws = let ww = filter (/= "=>") ws in (init ww, [last ww]) -- excludes multiwords

responsePlain oo = 
  unlines . map unwords . grep oo . map cleanTablePlain . map words . lines

cleanTablePlain = map clean where
  clean w = case w of
    "=>" -> "\t"
    "s"  -> ""
    "."  -> ""
    _ -> cleanw w
  cleanw = filter (flip notElem "()")

grep oo wss = filter (\ws -> all (flip matchIn ws) oo) wss

matchIn p ws = quant (matchPol pol patt) ws where
  quant = if pol then any else all
  (pol,patt) = (head p == '-', tail p)
  matchPol True p w = match p w
  matchPol False p w = not (match p w)
  match p w = case (p,w) of
    ('*':ps,_   ) -> any (match ps) [drop i w | i <- [0..length w]] ---
    (c:ps,  d:ws) -> c == d && match ps ws
    _             -> p == w

tmpFile = "_gfmorpho.tmp"
tmpCommand = "_gfcommand.tmp"

isOption = (flip elem "-~") . head

tag t s = "<" ++ t ++ ">" ++ s ++ "</" ++ t ++ ">"


-- html file with UTF8

mkFile s = unlines $ [
  "<HTML>",
  "<HEAD>",
  "<META HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=utf-8\">",
  "<TITLE>GF Smart Paradigm Output</TITLE>",
  "</HEAD>",
  "<BODY>",
   s,
   "</BODY>",
   "</HTML>"
   ]

