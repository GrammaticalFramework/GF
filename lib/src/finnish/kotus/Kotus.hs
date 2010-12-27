main = interact (unlines . concatMap mkOne . lines)

mkOne = mkEntry . analyse

mkEntry (w,p,g,h) | elem p [0,50,51] = [] -- no inflection information, or a compound
mkEntry (w,p,g,h) | head w == '-' = mkEntry (tail w,p,g,h) -- suffix only
mkEntry (w,p,g,h) | last w == 't' && notElem p [5,43,47 ] = [] -- plurale tantum --- to do
mkEntry (w,p,g,h) = [mkFun fun cat, mkLin fun par w] where
  cat = if p < 50 then catNoun 
        else if p < 99 then catVerb
        else catAdverb
  fun = mkId w ++ "_" ++ (if h=="0" then "" else h ++ "_") ++ cat
  par = (if p < 52 then "d" else "c") ++ num p ++ (if g == "0" then "" else "A")
  num p = if p < 10 then "0" ++ show p else show p

mkFun fun cat = unwords ["fun",fun,":",cat,";"]
mkLin fun par w = unwords ["lin",fun,"=",par,quoted w,";"]

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

quoted s = "\"" ++ s ++ "\""

analyse :: String -> (String,Int,String,String)
analyse s = (word,paradigm,gradation,homonym) where
  word = tagged "s" x
  paradigm = (read (tagged "tn" x) :: Int)
  gradation = tagged "av" x
  homonym = tagged "hn" x
  x = getTags s

tagged :: String -> Tags -> String
tagged s x = maybe "0" id $ lookup s x

-- get values of leave tags
getTags :: String -> Tags
getTags s = case s of
  '<':rest -> case break (=='>') rest of
     (tag,_:more) -> case break (=='<') more of
       ([],_)  -> getTags more
       (v,end) -> (tag,v):getTags end
     _ -> []
  _ -> []

type Tags = [(String,String)]

catNoun = "NK"
catVerb = "VK"
catAdverb = "AdvK"
