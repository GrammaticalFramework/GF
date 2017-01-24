import Data.Char
import Data.List

main = mkLatin

mkLatin = do
  ws <- readFile "DICTPAGE.RAW" >>= return . lines
  let fcs = mkDict ws
  let fs = [unwords [status st ++ "fun",f,":",cat,";","--",eng] | [st, f,cat,_,eng] <- fcs]
  let ls = [unwords [status st ++ "lin",f,"=",lat,";"]          | [st, f,_,lat,_] <- fcs]
  
  writeFile  "DictLatAbs.gf" "abstract DictLatAbs = Cat ** {"
  appendFile "DictLatAbs.gf" "\n-- extracted from http://archives.nd.edu/whitaker/dictpage.htm\n"
  appendFile "DictLatAbs.gf" (unlines fs)
  appendFile "DictLatAbs.gf" "}"
  
  writeFile  "DictLat.gf" "concrete DictLat of DictLatAbs = CatLat ** open ParadigmsLat in {"
  appendFile "DictLat.gf" "\n-- extracted from http://archives.nd.edu/whitaker/dictpage.htm\n"
  appendFile "DictLat.gf" (unlines ls)
  appendFile "DictLat.gf" "}"

  let es = [unwords [status st ++ "lin",f,"=",mkEng cat eng,";"] | [st, f,cat,_,eng] <- fcs]
  writeFile  "DictLatEng.gf" "concrete DictLatEng of DictLatAbs = CatEng ** open ParadigmsEng in {"
  appendFile "DictLatEng.gf" "\n-- extracted from http://archives.nd.edu/whitaker/dictpage.htm\n"
  appendFile "DictLatEng.gf" (unlines es)
  appendFile "DictLatEng.gf" "}"


---  putStrLn $ unlines ls

mkDict :: [String] -> [[String]] -- fun, cat, lat, eng
mkDict = map mkOne . zip [10001 ..] . map cleanUp 
  where
   cleanUp s = let (lat,eng) = break (=='[') s in 
             (words (filter (\c -> c==' ' || isLetter c) lat), eng)
   mkOne (i,(lws,eng)) = addId i (mkLat lws) ++ [eng]
   mkLat lws = case lws of 
     x:y:"N":_:g:_ -> f [x, "N", lin "mkN" [show x,show y, (snd (gender g))]] where f = if fst (gender g) then ok else todo
     x:y:"N":  g:_ -> f [x, "N", lin "mkN" [show x,show y, (snd (gender g))]] where f = if fst (gender g) then ok else todo
     x:"gen":z:"ADJ":_ -> ok [x, "A", lin "mkA" [show x]]
     x:y:z:"ADJ":_ -> ok [x, "A", lin "mkA" [show x]]
     x:"ADV":_     -> ok [x, "Adv", lin "mkAdv" [show x]]
     x:y:z:u:"V":_:"INTRANS":_ -> okv   [y, "V",                     lin "mkV" [show y,show x,show z,show u]]
     x:y:z:u:"V":_:"TRANS":_   -> okv   [y, "V2", lin "mkV2" ["(" ++ lin "mkV" [show y,show x,show z,show u] ++ ")"]]
     x:y:z:u:"V":_:"DEP":_     -> todo  [y, "V",  lin "depV" ["(" ++ lin "mkV" [show y,show x,show z,show u] ++ ")"]]
     x:y:z:u:"V":_             -> okv   [y, "V",                     lin "mkV" [show y,show x,show z,show u]]

     _ -> todo ["TODO","",unwords lws]

   addId i (st:f:c:rest) = st:(f ++ "_" ++ show i ++ "_" ++ c):c:rest
   
   gender g = case g of 
     "M" -> (True, "masculine")
     "F" -> (True, "feminine")
     "N" -> (True, "neuter")
     "C" -> (True, "masculine {-C-}")
     _   -> (False, g ++ "{-??-}")

   fun x c = x ++ "_" ++ c
   lin f xs = unwords (f:xs)
   todo xs = "1":xs
   ok xs = "0":xs
   okv r@(f:_) = if elem (take 3 (reverse f)) ["era","ere","eri"] then ok r else todo r

status st = case st of
  "0" -> ""
  _ -> "-- "


-- build an English version: TODO better analysis of the notation
mkEng cat eng = unwords $ intersperse "|" $ map mkOne engs
  where 
    mkOne s = unwords ["mk" ++ cat, show s]
    engs = [clean (takeWhile (flip notElem "\r,;") (drop 11 eng))] ---- TODO
    clean s = case s of
      '\\':r:cs -> clean cs
      c:cs -> c:clean cs
      _ -> s

--  [DXXFS] :: counting-board; side-board; slab table; panel; square stone on top of column;
--  [EEQEE] :: Father; (Aramaic); bishop of Syriac/Coptic church; (false read obba/decanter);
