import MkExxTable
import System.Cmd
import System.Environment
import Data.Char
import Data.List
import qualified Data.ByteString.Char8 as BS
import qualified Data.Map as M
---import Debug.Trace ----

type Cats = [(String,String,String)]
type Rules = [(String,String,String)]

-- the file generated
synopsis = "synopsis.txt"

-- the language in which revealed examples are shown
revealedLang = "Eng"

-- all languages shown
apiExxFiles = ["api-examples-" ++ lang ++ ".txt" | lang <- words
--   "Eng Chi"
  "Afr Bul Cat Chi Dan Dut Eng Est Fin Fre Ger Gre Hin Ita Jpn Lav Mlt Mon Nep Nor Pes Pnb Pol Ron Rus Snd Spa Swe Tha Urd"
   ]

main = do
  xx <- getArgs
  let isLatex = case xx of
        "-tex":_ -> True
        _ -> False
  cs1 <- getCats commonAPI
  cs2 <- getCats catAPI
  let cs = sortCats (cs1 ++ cs2)
  writeFile synopsis "GF Resource Grammar Library: Synopsis"
  append "B. Bringert, T. Hallgren, and A. Ranta"
  space
  append "%!Encoding:utf-8"
  append "%!style(html): ./revealpopup.css"
  space
  append "%!postproc(html): '#divreveal'  '<div class=reveal>'"
  append "%!postproc(html): '#divpopup'  '<div class=popup>'"
  append "%!postproc(html): '#ediv'  '</div>'"
  append "%!postproc(html): '#UL'  '<ul>'"
  append "%!postproc(html): '#EUL'  '</ul>'"
  append "%!postproc(html): '#LI'  '<li>'"
  append "%!postproc(html): '(SRC=\"categories.png\")'  '\\1 USEMAP=\"#categories\"'"
  append "%!postproc(html): '#LParadigms'  '<a name=\"RParadigms\"></a>'"
  append "%!postproc(tex): '#LParadigms' ''"
  delimit $ addToolTips cs
  include "synopsis-intro.txt"
  title "Categories"
  space
  link "Source 1:" commonAPI
  space
  link "Source 2:" catAPI
  space
  append "==A hierarchic view==\n"
  include "categories-intro.txt"
  append "==Explanations==\n"
  delimit $ mkCatTable isLatex cs
  space
  title "Syntax Rules and Structural Words"
  space
  link "Source 1:" syntaxAPI
  space
  link "Source 2:" structuralAPI
  space
  apiExx <- getApiExx apiExxFiles
  rs <- getRules apiExx syntaxAPI
---  putStrLn $ unlines ["p -cat=" ++ last (words t) ++
---               " \"" ++ e ++ "\"" | (_,t,e) <- rs, not (null e)] ----
  rs2 <- getRules apiExx structuralAPI
  let rss = rs ++ rs2
---  mapM_ putStrLn [f ++ " " ++ e | (f,_,e) <- rss]
  delimit $ mkSplitTables True isLatex apiExx cs rss
  space
--  title "Structural Words"
--  space
--  link "Source:" structuralAPI
--  space
--  rs <- rulesTable False isLatex cs structuralAPI
--  delimit rs
  space
  title "Lexical Paradigms"
  mapM_ (putParadigms isLatex cs) paradigmFiles
  space
  include "synopsis-additional.txt"
  space
  include "synopsis-browse.txt"
  space
  title "An Example of Usage"
  space
  include "synopsis-example.txt"
  space
  title "Table of Contents"
  space
  append "%%toc"
  space
  let format = if isLatex then "tex" else "html"
  system $ "txt2tags -t" ++ format ++ " " ++ " --toc " ++ synopsis
  if isLatex then (system $ "pdflatex synopsis.tex") >> return () else return ()

addToolTips :: Cats -> [String]
addToolTips = map f
  where f (n,e,_) = "%!postproc(html): '(?i)(HREF=\"#" ++ n ++ "\")( TITLE=\"[^\"]*\")?'  '\\1 TITLE=\"" ++ e' ++ "\"'"
           where e' = n ++ if null e then "" else " - " ++ e

getCats :: FilePath -> IO Cats
getCats file = do
  ss <- readFile file >>= return . lines
  return $ getrs [] ss
 where
   getrs rs ss = case ss of
     ('-':'-':'.':_):_ -> reverse rs
     [] -> reverse rs
     ('-':'-':_):ss2 -> getrs rs ss2
     s:ss2 -> case words s of
       cat:";":"--":exp -> getrs ((cat,unwords expl, unwords (tail ex)):rs) ss2 where
         (expl,ex) = span (/="e.g.") exp
       _ -> getrs rs ss2

rulesTable :: ApiExx ->  Bool -> Bool -> Cats -> FilePath -> IO [String]
rulesTable aexx hasEx isLatex cs file = do
  rs <- getRules aexx file
  return $ mkTable hasEx isLatex aexx cs rs


getRules :: ApiExx -> FilePath -> IO Rules
getRules aexx file = do
  ss <- readFileC (coding file) file >>= return . filter (not . hiddenLine) . lines
  return $ getrs [] ss
 where
   getrs rs ss = case ss of
     ('-':'-':'.':_):_ -> reverse rs
     [] -> reverse rs
     ('-':'-':_):ss2 -> getrs rs ss2
     s:ss2 -> case words s of
       _:_:"overload":_ -> getrs rs ss2
       _:":":_ -> getrs (rule s:rs) ss2
       _ -> getrs rs ss2
   rule s = (name, typ, ex)
       where
         ws = takeWhile (flip notElem ["--#", "--:", "="]) $ words s
         name = head ws
         (t,e) = span (/="--") (tail ws)
         typ = unwords $ filtype (drop 1 t)
         filtype = filter (/=";")
         ex = if null e then "" else unwords $ unnumber $ drop 1 e
         unnumber e = case e of
           n:ws | last n == '.' && not (null (init n)) && all isDigit (init n) -> ws
           _ -> e

putParadigms :: Bool -> Cats -> (String, FilePath) -> IO ()
putParadigms isLatex cs (lang,file) = do
  stitle ("Paradigms for " ++ lang)
  append "#LParadigms"
  space
  link "source" file
  space
  rs <- rulesTable M.empty False isLatex cs file
  space
  delimit rs
  space

inChunks :: Int -> ([a] -> [String]) -> [a] -> [String]
inChunks i f = concat . intersperse ["\n\n"] . map f . chunks i where
  chunks _ [] = []
  chunks i xs = x : chunks i y where (x,y) = splitAt i xs

-- Makes one table per result category.
-- Adds a subsection header for each table.
mkSplitTables :: Bool -> Bool -> ApiExx -> Cats -> Rules -> [String]
mkSplitTables hasEx isLatex aexx cs = concatMap t . addLexicalCats cs . sortRules
  where t (c, xs) = [subtitle c expl] ++ tableOrLink
         where
           expl = case [e | (n,e,_) <- cs, n == c] of
                        []  -> ""
                        e:_ -> e
           tableOrLink = if null xs then parad else mkTable hasEx isLatex aexx cs xs
           parad = [
             "Lexical category, constructors given in",
             "[lexical paradigms #RParadigms]."
             ]

mkTable :: Bool -> Bool -> ApiExx -> Cats -> Rules -> [String]
mkTable hasEx isLatex aexx cs = inChunks chsize (\rs -> header : map (unwords . row) rs)
 where
  chsize = if isLatex then 40 else 1000
  header = if hasEx then "|| Function  | Type  | Example  ||"
                    else "|| Function  | Type  | Explanation ||"
  row (name,typ,ex) =
         let ntyp = mkIdent (name ++ " : " ++ typ) in
         if hasEx then ["|", name', "|", typ', "|", ex' ntyp, "|"]
                  else ["|", name', "|", typ', "|", expl ntyp, "|"]
   where
     name' = ttf name
     typ' = showTyp cs typ
     ex' typ = let ex0 = if null ex then itf (takeWhile (/='_') name) else ex in
           case M.lookup typ aexx of
             Just es -> mkExample es ex0
             _ -> itf ex0
     expl typ = if null ex then itf "-" else itf ex

-- make an example with hover-popup translations
mkExample es ex = unwords [
  "#divreveal",
  itf (maybe ex (mkEx revealedLang) (M.lookup revealedLang es)),
  "#divpopup",
  "#UL",
  unwords ["#LI" ++ e | e <- prApiEx es],
  "#EUL",
  "#ediv",
  "#ediv"
  ]

-- makes mkUtt : QS -> Utt to mkUtt-QS-Utt
mkIdent :: String -> String
mkIdent = concatMap unspec where
  unspec c = case c of
    ' ' -> ""
    '>' -> ""
    '(' -> ""
    ')' -> ""
    ':' -> "-"
    _   -> [c]


mkCatTable :: Bool -> Cats -> [String]
mkCatTable isLatex cs = inChunks chsize (\rs -> header ++ map mk1 rs) cs
 where
  header = ["|| Category  | Explanation  | Example  ||"]
  chsize = if isLatex then 40 else 1000
  mk1 (name,expl,ex) = unwords ["|", showCat cs name, "|", expl, "|", typo ex, "|"]
  typo ex = if take 1 ex == "\"" then itf (init (tail ex)) else ex

srcPath = ("../src" ++)

commonAPI = srcPath "/abstract/Common.gf"
catAPI    = srcPath "/abstract/Cat.gf"
syntaxAPI = srcPath "/api/Constructors.gf"
structuralAPI = srcPath "/abstract/Structural.gf"
paradigmFiles = [
  ("Afrikaans", srcPath "/afrikaans/ParadigmsAfr.gf"),
  ("Bulgarian", srcPath "/bulgarian/ParadigmsBul.gf"),
  ("Catalan", srcPath "/catalan/ParadigmsCat.gf"),
  ("Chinese", srcPath "/chinese/ParadigmsChi.gf"),
  ("Danish", srcPath "/danish/ParadigmsDan.gf"),
  ("Dutch", srcPath "/dutch/ParadigmsDut.gf"),
  ("English", srcPath "/english/ParadigmsEng.gf"),
  ("Estonian", srcPath "/estonian/ParadigmsEst.gf"),
  ("Finnish", srcPath "/finnish/ParadigmsFin.gf"),
  ("French",  srcPath "/french/ParadigmsFre.gf"),
  ("German",  srcPath "/german/ParadigmsGer.gf"),
  ("Greek",  srcPath "/greek/ParadigmsGre.gf"),
  ("Hindi", srcPath "/hindi/ParadigmsHin.gf"),
--  ("Interlingua", srcPath "/interlingua/ParadigmsIna.gf"),
  ("Italian",  srcPath "/italian/ParadigmsIta.gf"),
  ("Japanese",  srcPath "/japanese/ParadigmsJpn.gf"),
  ("Latvian",  srcPath "/latvian/ParadigmsLav.gf"),
  ("Maltese",  srcPath "/maltese/ParadigmsMlt.gf"),
  ("Mongolian",  srcPath "/mongolian/ParadigmsMon.gf"),
  ("Nepali", srcPath "/nepali/ParadigmsNep.gf"),
  ("Norwegian", srcPath "/norwegian/ParadigmsNor.gf"),
  ("Polish", srcPath "/polish/ParadigmsPol.gf"),
  ("Punjabi", srcPath "/punjabi/ParadigmsPnb.gf"),
  ("Romanian", srcPath "/romanian/ParadigmsRon.gf"),
  ("Russian", srcPath "/russian/ParadigmsRus.gf"),
  ("Sindhi", srcPath "/sindhi/ParadigmsSnd.gf"),
  ("Spanish",  srcPath "/spanish/ParadigmsSpa.gf"),
  ("Swedish",  srcPath "/swedish/ParadigmsSwe.gf"),
  ("Thai", srcPath "/thai/ParadigmsTha.gf"),
  ("Urdu", srcPath "/urdu/ParadigmsUrd.gf")
  ]

append s = appendFile synopsis ('\n':s)
title s = append $ "=" ++ s ++ "="
stitle s = append $ "==" ++ s ++ "=="
include s = append $ "%!include: " ++ s
space = append "\n"
delimit ss = mapM_ append ss
link s f = append $ s ++ " [``" ++ f ++ "`` " ++ fa ++ "]" where
  fa = "http://www.grammaticalframework.org/lib" ++ dropWhile (=='.') f

ttf s = "``" ++ s ++ "``"
itf s = "//" ++ s ++ "//"

hiddenLine s = case reverse (words s) of
  "--%":_ -> True
  _ -> False

-----------------

-- sort category synopsis by category, retain one table
sortCats :: Cats -> Cats
sortCats = sortBy compareCat
  where compareCat (n1,_,_) (n2,_,_) = compare n1 n2

-- sort function synopsis by category, into separate tables
sortRules :: Rules -> [Rules]
sortRules = groupBy sameCat . sortBy compareRules
  where sameCat r1 r2 = resultCat r1 == resultCat r2
        compareRules r1@(n1,_,_) r2@(n2,_,_)
            = compare (resultCat r1,n1) (resultCat r2,n2)

addLexicalCats :: Cats -> [Rules] -> [(String,Rules)]
addLexicalCats cs rss =
    map head $ groupBy fstEq $ sortBy (\x y -> compare (fst x) (fst y)) $
           [ (resultCat r, rs) | rs@(r:_) <- rss] ++ [(n,[]) | (n,_,_) <- cs]
  where fstEq p1 p2 = fst p1 == fst p2

resultCat :: (String,String,String) -> String
resultCat (_,t,_) = last (words t)


subtitle cat expl = "==" ++ cat ++ e ++ "==" ++ "[" ++ cat ++ "]"
  where e = if null expl then "" else " - " ++ expl

showCat :: Cats -> String -> String
showCat cs cat = "[" ++ cat ++ " #" ++ cat ++ "]"

showTyp :: Cats -> String -> String
showTyp cs = unwords . map f . words
  where f s | head s == '(' && last s == ')' && isCat c
                = "(" ++ showCat cs c ++ ")"
            | isCat s = showCat cs s
            | otherwise = ttf s
         where c = init (tail s)
        isCat cat = cat `notElem` ["Str","Int"]
                    && all (\c -> isAlphaNum c || c == '\'') cat
                    && isUpper (head cat)

-- to work around GHC 6.12 file input
readFileC cod file = do
  let tmp = file ++ ".tmp"
  case cod of
    "utf8" -> readFile file
    _ -> do
      system $ "iconv -f ISO-8859-1 -t UTF-8 " ++ file ++ " >" ++ tmp
      readFile tmp

-- 'intelligently' determine the coding of a file
coding file = case language file of
  "Pol" -> "utf8"
  "Rus" -> "utf8"
  "Mlt" -> "utf8"
  _     -> "latin1" ----

language = reverse . take 3 . drop 3 . reverse
