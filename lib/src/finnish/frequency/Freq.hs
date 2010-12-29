import qualified Data.Set as S

main = do
  src   <- readFile "src/suomen-sanomalehtikielen-taajuussanasto-utf8.txt"
  kotus <- readFile "kotusfuns.txt"
  let funSet = S.fromList (map (head . words) (lines kotus))
  mapM_ putStrLn $ concatMap (prEntry funSet . mkOne) $ lines src

stoplist = S.fromList 
  ["ei","olla","ei_ihme","eikä","ettei","ellei","vaikkei","muttei","miksei","jollei","jottei"]

prEntry funSet (f,c,w,p@(k,n),i) = if n == 0 then [] else [
   unwords ["fun",f, " : ", c,";"],
   unwords ["lin",f, "=", para,";"]
  ]
 where
  para = case n of
    2 -> let kf = i ++ "_" ++ k in
         if S.member kf funSet 
           then "mk" ++ c ++ " " ++ kf
           else "mk" ++ c ++ " " ++ quoted w
    _ -> "mk" ++ k ++ " " ++ quoted w


mkOne line = case words line of
  _:_:_:w:c0:_ | S.member w stoplist -> none
  _:_:_:w:c0:_ -> let c = mkCat c0 in (mkFun w c, c, w, mkLin c0, mkId w)
  _ -> none

none = ("","","",("",0),"")

quoted s = "\"" ++ s ++ "\""

mkCat = fst . catlin
mkLin = snd . catlin

catlin c = case c of
  "(adjektiivi)" -> kotus "A"
  "(adverbi)" -> rep "Adv"
  "(erisnimi)" -> rep "PN"
  "(interjektio)" -> hide "Interj"
  "(konjunktio)" -> hide "Conj"
  "(lukusana)" -> hide "Numeral"
  "(lyhenne)"  -> hide "Abbr"
  "(prepositio)" -> hide "Prep"
  "(pronomini)" -> hide "Pron"
  "(substantiivi)" -> kotus "N"
  "(verbi)" -> kotus "V"
  _ -> hide "Junk"


rep s = (s,(s,1))
kotus s = (s,(s ++ "K",2))
--- for entries not to be included
hide s = (s,(s,0))

mkFun w c = mkId w ++ "_" ++ c

mkId = concatMap trim where
  trim c = case fromEnum c of
    32 -> "_" -- space
    45 -> "_" -- -
    224 -> "a''" -- à
    228 -> "a'" -- ä
    246 -> "o'" -- ö
    252 -> "u'" -- ü
    x | x < 65 || (x > 90 && x < 97) || x > 122 -> "_"
    _   -> [c]
