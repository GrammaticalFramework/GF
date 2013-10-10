import Data.Char
import Data.List
import qualified Data.Map as M
import qualified Data.Set as S

wiktFile = "en-fr-enwiktionary.txt"
dictFuns = "dictfuns.txt"
irregFre = "irregFre.txt"
oldFre   = "oldFre.txt"

-- AR 10/10/2013
-- extracting a lexicon from Wiktionary as presented in
--   http://en.wiktionary.org/wiki/User:Matthias_Buchmeier/download
-- downloaded from
--   https://hotfile.com/dl/248980034/2861991/dictionaries_enwiktionary_ding_dictd_20131002.tgz.html


-- abjure_V2 : V2 ;    ==>   (abjure_V, 2)

main = do
  funs <- readFile dictFuns >>= return . map (break (\c -> isDigit c || isSpace c)) . lines
  let funmap = M.fromList [(w,takeWhile (not . isSpace) c) | (w,c) <- funs]
  fverbmap <- readFile irregFre >>= return . M.fromList . map mkVerb . lines
  oldFre <- readFile oldFre >>= return . S.fromList . map (head . words) . lines
  wiks0 <- readFile wiktFile >>= return . map analyseLine . lines 
  let wiks1 = [(w1,c1,f1) | (w0,c0,f0) <- wiks0,
                            c0 /= "?",
                            not (all isSpace f0),      -- not empty string
                            let w = w0 ++ "_" ++ c0, 
                            Just cs <- [M.lookup w funmap],
                            let c1 = c0 ++ cs,
                            let w1 = w0 ++ "_" ++ c1,
                            not (S.member w1 oldFre),
                            let f1 = analyseFre fverbmap c0 (uncomment f0),
                            notElem ' ' (fst f1)       -- exclude multiwords, for sanity
                           ]
  let dict = unlines $ map convertLine $ groupEntries wiks1
--  putStrLn dict
  writeFile "NewDictFre.txt" dict

-- [sur un sofa or sur un canapé] s'allonger  ==> s'allonger
uncomment s = case break (=='[') s of
  (s1,_:s2) -> s1 ++ case break (== ']') s2 of
    (_,_:s4) -> s4
    _ -> []
  _ -> s

groupEntries = map variants . groupBy sameFun where
  sameFun (f,_,_) (g,_,_) = f == g
  variants fes@((f,c,_):_) = (f,c,[s | (_,_,s) <- fes])
  

-- abjure {v} /æbˈdʒʊɹ/ (to renounce with solemnity) :: abjurer   ==>  (abjure, V, abjurer)

analyseLine l = case words l of
  w:c:rest | head c == '{' && elem "::" rest -> 
       (fun w,cat c, takeWhile (/=',') (unwords (tail (dropWhile (/= "::") rest))))
  _ -> ([],[],[])

fun = map fc where
  fc c = if isAlphaNum c then c else '_'

cat s = case (init (tail s)) of
  "adj"  -> "A"
  "n"    -> "N"
  "v"    -> "V"
  "prop" -> "PN"
  "adv"  -> "Adv"
  "conj" -> "Conj"
  "interj" -> "Interj"
  "determiner" -> "Det"
  _ -> "?"


analyseFre vmap c s = case (c, break (=='{') s) of
  ("N", (w,"{m}")) -> (init w,["masculine"])
  ("N", (w,"{f}")) -> (init w,["feminine"])
  ("PN", (w,"{m}")) -> (init w,["masculine"])
  ("PN", (w,"{f}")) -> (init w,["feminine"])
  ("A",  (w,'{':_)) -> (init w,[])
  (_,    (w,'{':_)) -> (init w,[])
  (_,_)             -> case (c, splitAt 2 s) of
    ('V':_,  ("se", ' ':v)) -> (mkV v, ["reflV"])
    ('V':_,  ("s'",   v)) -> (mkV v, ["reflV"])
    ('V':_,  _)           -> (mkV s, [])
    _ -> (s,     [])
 where
  mkV s = case M.lookup s vmap of
    Just f -> "I." ++ f
    _ -> s

mkVerb s = case words s of
  v:_ -> (takeWhile (/='_') v, v)


convertLine (eng,cat,fps) = eng ++ " = " ++ unwords (intersperse "|" (map lin fps)) ++ " ;" where
  lin (fre,ps) = case (cat,fre,ps) of
    ('V':_,  'I':'.':_,  ["reflV"]) -> "mk" ++ cat ++ " (reflV (mkV " ++ fre ++ "))" 
    ('V':_,  'I':'.':_,  [])        -> "mk" ++ cat ++ " (mkV " ++ fre ++ ")"
    ('V':_,  _,          ["reflV"]) -> "mk" ++ cat ++ " (reflV (mkV \"" ++ fre ++ "\"))"
    ('V':_,  _,          [])        -> "mk" ++ cat ++ " (mkV \"" ++ fre ++ "\")"
    _ -> "mk" ++ cat ++ " \"" ++ fre ++ "\" " ++ unwords ps

