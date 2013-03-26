-- lookup the Kotus list. AR 17/3/2013
-- lookup a word: 
--   - if found with declension, return this
--   - if found without declension, look up as compound (INCOMPOUND), with the latter part's declension
--   - if not found, look up as compound (OUTCOMPOUND), with the latter part's declension
-- This is performed line by line on standard input and written into standard output
-- 25/3: 93,696 words, 2628 not found, 6964 unsure
-- 26/3: new heuristics for adjectives of type "älyperäinen", 1258 not found

import Data.List
import Data.Char
import qualified Data.Map as M

main = do
  kotus <- readFile "kotus-sanalista_v1.xml" >>= return . mkKotus . lines
-- do lookup
----  interact $ unlines . map (look kotus) . lines

--- just print all words
---  mapM_ (putStrLn . fst) $ M.toList kotus
--- debug
---  mapM_ print $ take 60 $ M.toList kotus -- debug

-- analyse fin wordnet senses
  interact $ unlines . map (annotateWordnet kotus) . lines


annotateWordnet :: Kotus -> String -> String
annotateWordnet kotus line = case cat of
  "V" -> untabs (take 2 tline ++ [cat, lookk ((iline !! 1) !! 0)]) -- fi:v02758977 sataa lunta 0   -> sataa
  _   -> untabs (take 2 tline ++ [cat, lookk (last (iline !! 1))]) -- fi:n02769075 näytön taustakuva 0 -> taustakuva
 where
  iline = map words (init tline)
  tline = tabs line
  cat = case line !! 3 of -- fi:v0276... -> v
    'v' -> "V"
    'a' -> "A"
    'n' -> "N"
    'r' -> "Adv"
  lookk = unwords . tail . words . look kotus  -- remove repetition of lemma

tabs :: String -> [String]
tabs s = case break (=='\t') s of
  (s1,_:s2) -> s1 : tabs s2
  _ -> [s]

untabs :: [String] -> String
untabs = concat . intersperse "\t"

look :: Kotus -> String -> String
look kotus w = case M.lookup w kotus of
  Just ["NOPAR"] -> lookCompound "INCOMPOUND" kotus w
  Just descr -> unwords $ w : descr
  _ -> lookCompound "OUTCOMPOUND" kotus w

lookCompound :: String -> Kotus -> String -> String
lookCompound pref kotus w = case sort (concatMap looks (splits w)) of  -- sort: 1's first
  (_,descr):_ -> unwords $ w : [descr] 
  _ -> unwords $ w : ["NOTFOUND",pref]
 where
   splits s = reverse [splitAt n s | n <- [3 .. length s - 3]]
   looks (x,y) = case M.lookup y kotus of 
     Just descr | elem x compPrefixes || any isCompPrefix (compForms x) -> [(1,unwords $ x : y : descr ++ [pref])] -- preferred: 1
     Just descr -> [(2,unwords $ x : y : descr ++ ["UNSURE", pref])] -- secondary: 2
     _ | drop (length y - 3) y == "nen" && (elem x compPrefixes || any isCompPrefix (compForms x)) 
                                      -> [(3,unwords $ x : y : ["38","UNSURE",pref])] -- tertiary: 3
     _ -> []
   isCompPrefix x = case M.lookup x kotus of
     Just _ -> True
     _ -> case M.lookup (x ++ "-") kotus of
       Just _ -> True
       _ -> False
   compForms x = let (initx,lastx) = (init x,last x) in 
                 x : [initx ++ "nen" | lastx == 's'] ++ [initx | elem lastx "n-" ] -- pakkas-, pakkanen
   compPrefixes = ["epä","ylä","yö"] -- yö is the only 2-letter word
     

type Kotus = M.Map String [String]

mkKotus :: [String] -> Kotus
mkKotus = M.fromList . groupHomonyms . map oneKotusLine . filter isWord

isWord = (=="<st>") . take 4

oneKotusLine :: String -> (String,[String])
oneKotusLine s = case untag s of w:ws -> (w,ws) 

-- <st><s>yhdesti</s><t><tn>99</tn></t></st>
--        yhdesti    <t><tn>99</tn></t></st>

untag s = case break (=='<') (drop 7 s) of 
  (w,d) -> case drop 4 d of
    '<':'t':'>':_ -> [w, takeWhile isDigit (drop 11 d), rest (drop 11 d)]  -- 99, </st>
    '<':'h':'n':'>':h:'<':'/':'h':'n':'>':'<':'t':'>':_ -> [w, ['H',h], takeWhile isDigit (drop 21 d), rest (drop 21 d)]  -- homonym
    _ -> [w, "NOPAR"]  -- no paradigm given
 where
   rest t = case t of
     '<':'a':'v':'>':_ -> "A"
     _:cs -> rest cs
     _ -> []

groupHomonyms :: [(String,[String])] -> [(String,[String])]
groupHomonyms ws = [(w,concat (intersperse [";"] (map snd wds))) | wds@((w,_):_) <- groupBy (\x y -> fst x == fst y) ws]



