
concrete SimpleEng of SimpleAbs = open SimpleEngRes in {

lincat
S  = {s : Str};
VP = {s : Num => Str};
NP = {s : Str ; n : Num};
V  = {s : Num => Str};
N  = {s : Num => Str};
D  = {s : Str ; n : Num};

lin 
cyclic x   = x;
mkS    x y = {s = x.s ++ y.s ! x.n};
mkVP   x y = {s = table {n => x.s ! n ++ y.s}};
mkNP1  x y = {s = x.s ++ y.s ! x.n ; n = x.n};
mkNP2  x   = {s = x.s ! Pl ; n = Pl};

robin = {s = "Robin" ; n = Sg};
dog   = {s = table {Sg => "dog"   ; Pl => "dogs"}};
child = {s = table {Sg => "child" ; Pl => "children"}};
love  = {s = table {Sg => "loves" ; Pl => "love"}};
hate  = {s = table {Sg => "hates" ; Pl => "hate"}};
one   = {s = "one" ; n = Sg};
all   = {s = "all" ; n = Pl};

}


