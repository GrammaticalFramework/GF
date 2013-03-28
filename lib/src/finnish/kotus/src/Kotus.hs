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
---  kotus <- readFile "kotus-sanalista_v1.xml" >>= return . mkKotus . lines
-- do lookup
---  interact $ unlines . map (look kotus) . lines

--- just print all words
---  mapM_ (putStrLn . fst) $ M.toList kotus
--- debug
---  mapM_ print $ take 60 $ M.toList kotus -- debug

--- analyse fin wordnet senses
--- wordnet to kotus: runghc Kotus.hs <fiwn-wsenses.tsv >wn-kotus.txt
--  interact $ unlines . map (annotateWordnet kotus) . lines


--- find Finnish words for DictEng: runghc Kotus.hs <DictEng.senses >DictEngFin.senses

  wnkotus <- readFile "wn-kotus.txt" >>= return . mkWNKotus . lines
  interact $ unlines . map (annotateSenseInflection wnkotus) . lines


annotateSenseInflection wnkotus line = case tabs line of
  w:s:_ -> untabs (w : s : lookupSenseInflection wnkotus s)
  _ -> "-- " ++ line

type WNKotus = M.Map String [[String]]

mkWNKotus :: [String] -> WNKotus
mkWNKotus = M.fromListWith (++) . map mkOne where
  mkOne s = case tabs s of
    w:ws -> (drop 3 w,[ws]) -- fi: dropped
    _ -> (s,[])

lookupSenseInflection :: WNKotus -> String -> [String]
lookupSenseInflection wnkotus synset = case M.lookup synset wnkotus of
  Just fws@(_:_) -> minimumBy (\x y -> compare (last x) (last y)) fws  -- choose one with the best status
  _ -> ["NOT_IN_KOTUS"]




annotateWordnet :: Kotus -> String -> String
annotateWordnet kotus line = untabs $ [tline !! 0, cat, tline !! 1] ++ case cat of
  "V" -> lookk ((iline !! 1) !! 0) -- fi:v02758977 sataa lunta 0   -> sataa
  _   -> lookk (last (iline !! 1)) -- fi:n02769075 näytön taustakuva 0 -> taustakuva
 where
  iline = map words (init tline)
  tline = tabs line
  cat = case line !! 3 of -- fi:v0276... -> v
    'v' -> "V"
    'a' -> "A"
    'n' -> "N"
    'r' -> "Adv"
  lookk = look kotus

tabs :: String -> [String]
tabs s = case break (=='\t') s of
  (s1,_:s2) -> s1 : tabs s2
  _ -> [s]

untabs :: [String] -> String
untabs = concat . intersperse "\t"

look :: Kotus -> String -> [String]
look kotus w = case M.lookup w kotus of
  Just ["NOPAR"] -> lookCompound "INCOMPOUND" kotus w -- compound in Kotus
  Just descr -> descr ++ ["FOUND"]
  _ -> lookCompound "OUTCOMPOUND" kotus w  -- compound not in Kotus

lookCompound :: String -> Kotus -> String -> [String]
lookCompound pref kotus w = case sort (concatMap looks (splits w)) of  -- sort: 1's first
  (_,descr):_ -> descr 
  _ -> ["MK", "XX5_NOTFOUND_"++pref]  -- NOUTFOUND, worst - use smart paradigm
 where
   splits s = reverse [splitAt n s | n <- [3 .. length s - 3]]
   looks (x,y) = case M.lookup y kotus of 
     Just descr | makesCompPrefix x                           -> comp 1 descr  pref                      x y  -- preferred: 1
     Just descr                                               -> comp 2 descr  ("XX3_UNSURE_"   ++ pref) x y  -- secondary: 2, UNSURE
     _ | drop (length y - 3) y == "nen" && makesCompPrefix x  -> comp 3 ["38"] ("XX4_INVENTED_" ++ pref) x y 
     _ | drop (length y - 3) y == "ttu" && makesCompPrefix x  -> comp 3 ["1"]  ("XX4_INVENTED_" ++ pref) x y 
     _ | drop (length y - 3) y == "tty" && makesCompPrefix x  -> comp 3 ["1"]  ("XX4_INVENTED_" ++ pref) x y 
     _ | drop (length y - 3) y == "nut" && makesCompPrefix x  -> comp 3 ["47"] ("XX4_INVENTED_" ++ pref) x y 
     _ | drop (length y - 3) y == "nyt" && makesCompPrefix x  -> comp 3 ["47"] ("XX4_INVENTED_" ++ pref) x y 
     _ -> []
   comp status descr pref x y = [(status, [unwords (descr ++ ["C", x ++ "_" ++ y]), pref])]

   makesCompPrefix x = elem x compPrefixes || any isCompPrefix (compForms x) 
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
    '<':'t':'>':_ -> [w, takeWhile isDigit (drop 11 d) ++ rest (drop 11 d)]  -- 99, </st>
    '<':'h':'n':'>':h:'<':'/':'h':'n':'>':'<':'t':'>':_ -> [w, ['H',h], takeWhile isDigit (drop 21 d) ++ rest (drop 21 d)]  -- homonym
    _ -> [w, "NOPAR"]  -- no paradigm given
 where
   rest t = case t of
     '<':'a':'v':'>':_ -> "A"
     _:cs -> rest cs
     _ -> []

groupHomonyms :: [(String,[String])] -> [(String,[String])]
groupHomonyms ws = [(w,concat (intersperse [";"] (map snd wds))) | wds@((w,_):_) <- groupBy (\x y -> fst x == fst y) ws]



