-- File name System/general.Swe.gf

concrete genSystemSwe of genSystem = generalSwe ** open icm100ResSwe in {

---- flags lexer=codelit ; unlexer=codelit ; startcat=DMoveList ;

pattern
greet = ["Välkommen till videobandspelaren"] ;
quit = "hejdå" ;

lin
ask a = {s = a.s} ;

lin
---Language
change_language = {s = "byt" ++ "språk"} ;
language_alt = {s = ["vill du använda svenska eller engelska"]} ;

---Actions
lin
actionQ = {s = "Vad" ++ "kan" ++ "jag" ++ "stå" ++ "till" ++ "tjänst" ++ "med"} ;

lin
whQuestion w = {s = w.s };
altQuestion a1 a2 = {s = "vill" ++ "du" ++ "spela" ++ "in" ++ a1.s ++ "eller" ++ a2.s};

--- Issue
issue i = {s = i.s} ;

pattern
nil = "[]" ;
}