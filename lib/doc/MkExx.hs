-- make a script for computing examples
-- usage: runghc MkExx.hs <koe.txt >koe.gfs
-- then:  gf -retain -s ../alltenses/TryRon.gfo <koe.gfs
-- called automatically by 'make exx'

main = interact (unlines . concatMap mkScript . takeWhile (/="--.") . lines)

mkScript l = case l of
  ' ':_ -> 
     let ident = mkIdent $ unwords $ takeWhile (/="--") $ words l
     in [add $ psq ident]
  '-':_ -> []
  _ -> [
     add $ psq l,
     add $ "cc -one " ++ l,
     add $ psq "*"
     ]

add = ('\n':)

psq s = "ps \"" ++ s ++ "\""

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



langsCoding = [
  (("amharic",  "Amh"),""),
  (("arabic",   "Ara"),""),
  (("basque",   "Eus"),""),
  (("bulgarian","Bul"),""),
  (("catalan",  "Cat"),"Romance"),
  (("danish",   "Dan"),"Scand"),
  (("dutch",    "Dut"),""),
  (("english",  "Eng"),""),
  (("finnish",  "Fin"),""),
  (("french",   "Fre"),"Romance"),
  (("hindi",    "Hin"),"Hindustani"),
  (("german",   "Ger"),""),
  (("interlingua","Ina"),""),
  (("italian",  "Ita"),"Romance"),
  (("latin",    "Lat"),""),
  (("norwegian","Nor"),"Scand"),
  (("polish",   "Pol"),""),
  (("punjabi",  "Pnb"),""),
  (("romanian", "Ron"),""),
  (("russian",  "Rus"),""),
  (("spanish",  "Spa"),"Romance"),
  (("swedish",  "Swe"),"Scand"), 
  (("thai",     "Tha"),""),
  (("turkish",  "Tur"),""),
  (("urdu",     "Urd"),"Hindustani")
  ]


langs = map fst langsCoding

-- languagues for which Try is normally compiled
langsLang = langs `except` langsIncomplete

-- languages for which Lang can be compiled but which are incomplete
langsIncomplete = ["Amh","Ara","Hin","Lat","Pnb","Rus","Tha","Tur","Urd"]

except ls es = filter (flip notElem es . snd) ls
