module GF.Compile.Multi (readMulti) where

import Data.List
import Data.Char

-- AR 29 November 2010
-- quick way of writing a multilingual lexicon and (with some more work) a grammar
-- also several modules in one file
-- file suffix .gfm (GF Multi)


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

-- multiple modules: modules as usual. Each module has to start from a new line.
-- Should be UTF-8 encoded.

-}

{-
main = do
  xx <- getArgs
  if null xx then putStrLn usage else do 
    let (opts,file) = (init xx, last xx)
    (absn,cncns) <- readMulti opts file
    if elem "-pgf" xx 
      then do
         system ("gf -make -s -optimize-pgf " ++ unwords (map gfFile cncns))
         putStrLn $ "wrote " ++ absn ++ ".pgf"
      else return ()
-}

readMulti :: FilePath -> IO (FilePath,[FilePath])
readMulti file = do
  src <- readFile file
  let multi = getMulti (takeWhile (/='.') file) src
      absn  = absName multi
      cncns = cncNames multi
      raws  = rawModules multi
  writeFile (gfFile absn) (absCode multi)
  mapM_ (uncurry writeFile) 
        [(gfFile cncn, cncCode absn cncn cod) | 
          cncn <- cncNames multi, let cod = [r | (la,r) <- cncRules multi, la == cncn]]
  putStrLn $ "wrote " ++ unwords (map gfFile (absn:cncns))
  mapM_ (uncurry writeFile) [(gfFile n,s) | (n,s) <- raws] --- overwrites those above
  return (gfFile absn, map gfFile cncns)

data Multi = Multi {
  rawModules :: [(String,String)],
  absName  :: String,
  cncNames :: [String],
  startCat :: String,
  absRules :: [String],
  cncRules :: [(String,String)] -- lang,lin
  }

emptyMulti :: Multi 
emptyMulti = Multi {
  rawModules = [],
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
getMulti m s = foldl (flip addMulti) (emptyMulti{absName = m}) (modlines (lines s))

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
  _ -> case words line of
        m:name:_ | isModule m -> multi {
          rawModules = (name,line):rawModules multi
          } 
        _ -> let (cat,fun,lins) = getRules (startCat multi) line in 
              multi {
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

isModule :: String -> Bool
isModule = flip elem 
  ["abstract","concrete","incomplete","instance","interface","resource"]

modlines :: [String] -> [String]
modlines ss = case ss of
  l:ls -> case words l of
    w:_ | isModule w -> case break (isModule . concat . take 1 . words) ls of
      (ms,rest) -> unlines (l:ms) : modlines rest
    _ -> l : modlines ls
  _ -> []
