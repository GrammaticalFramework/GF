module Main where

import List
import Char
import System

-- quick way of writing a multilingual lexicon and (with some more work) a grammar

usage = "usage: runghc Multi (-pgf)? file"

{-
-- This multi-line comment is a possible file in the format.
-- comments are as in GF, one-liners

-- always start by declaring lang names as follows
> langs Eng Fin Swe

-- baseline rules: semicolon-separated line-by-line entries update abs and cncs, adding to S
cheers ; skål ; terveydeksi

-- alternatives within a language are comma-separated
cheers ; skål ; terveydeksi, kippis

-- more advanced: verbatim abstract rules prefixed by "> abs"
> abs cat Drink ;
> abs fun drink : Drink -> S ;

-- verbatim concrete rules prefixed by ">" and comma-separated language list
> Eng,Swe lin Gin = "gin" ; 

-}


main = do
 xx <- getArgs
 if null xx putStrLn usage else do
  let (opts,file) = (init xx, last xx)
  src <- readFile file
  let multi = getMulti (takeWhile (/='.') file) src
      absn  = absName multi
      cncns = cncNames multi
  writeFile (gfFile absn) (absCode multi)
  mapM_ (uncurry writeFile) 
        [(gfFile cncn, cncCode absn cncn cod) | 
          cncn <- cncNames multi, let cod = [r | (la,r) <- cncRules multi, la == cncn]]
  putStrLn $ "wrote " ++ unwords (map gfFile (absn:cncns))
  if elem "-pgf" xx 
    then do
       system ("gf -make -s -optimize-pgf " ++ unwords (map gfFile cncns))
       putStrLn $ "wrote " ++ absn ++ ".pgf"
    else return ()

data Multi = Multi {
  absName  :: String,
  cncNames :: [String],
  startCat :: String,
  absRules :: [String],
  cncRules :: [(String,String)] -- lang,lin
  }

emptyMulti :: Multi 
emptyMulti = Multi {
  absName  = "Abs",
  cncNames = [],
  startCat = "S",
  absRules = [],
  cncRules = []
  }

absCode :: Multi -> String
absCode multi = unlines $ header : start ++ (reverse (absRules multi)) ++ ["}"] where
  header = "abstract " ++ absName multi ++ " = {"
  start  = ["flags startcat = " ++ cat ++ " ;", "cat " ++ cat ++ " ;"]
  cat = startCat multi

cncCode :: String -> String -> [String] -> String
cncCode ab cnc rules = unlines $ header : (reverse rules ++ ["}"]) where
  header = "concrete " ++ cnc ++ " of " ++ ab ++ " = {"

getMulti :: String -> String -> Multi
getMulti m s = foldl (flip addMulti) (emptyMulti{absName = m}) (lines s)

addMulti :: String -> Multi -> Multi
addMulti line multi = case line of
  '-':'-':_ -> multi
  _ | all isSpace line -> multi
  '>':s -> case words s of
     "langs":ws -> let las = [absName multi ++ w | w <- ws] in multi {
       cncNames = las, 
       cncRules = concat [[(la,"lincat " ++ startCat multi ++ " = Str ;"),
                           (la,"flags coding = utf8 ;")] | la <- las]
       }
     "startcat":c:ws -> multi {startCat = c}
     "abs":ws   -> multi {
       absRules = unwords ws : absRules multi
       }
     langs:ws   -> multi {
       cncRules = [(absName multi ++ la, unwords ws) | la <- chop ',' langs] ++ cncRules multi
       }
  _ -> let (cat,fun,lins) = getRules (startCat multi) line 
       in multi {
         absRules = ("fun " ++ fun ++ " : " ++ cat ++ " ;") : absRules multi,
         cncRules = zip (cncNames multi) lins ++ cncRules multi
         }

getRules :: String -> String -> (String,String,[String])
getRules cat line = (cat, fun, map lin rss) where
  rss = map (map unspace . chop ',') $ chop ';' line
  fun = map idChar (head (head rss)) ++ "_" ++ cat
  lin rs = "lin " ++ fun ++ " = " ++ unwords (intersperse "|" (map quote rs)) ++ " ;"

chop :: Eq c => c -> [c] -> [[c]]
chop c cs = case break (==c) cs of
  (w,_:cs2) -> w : chop c cs2
  ([],[])   -> []
  (w,_)     -> [w]

-- remove spaces from beginning and end, leave them in the middle
unspace :: String -> String
unspace = unwords . words

quote :: String -> String
quote r = "\"" ++ r ++ "\""

-- to guarantee that the char can be used in an ident
idChar :: Char -> Char
idChar c = 
  if (n > 47 && n < 58) || (n > 64 && n < 91) || (n > 96 && n < 123) 
  then c
  else '_'
 where n = fromEnum c


gfFile :: FilePath -> FilePath
gfFile f = f ++ ".gf"


