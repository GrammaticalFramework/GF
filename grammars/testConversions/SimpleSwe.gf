
concrete SimpleSwe of SimpleAbs = open SimpleSweRes in {

lincat
S  = {s : Str};
VP = {s : Str};
NP = {s : Str};
V  = {s : Str};
N  = {s : Num => Str ; g : Gen};
D  = {s : Gen => Str ; n : Num};

lin 
cyclic x   = x;
mkS    x y = {s = x.s ++ y.s};
mkVP   x y = {s = x.s ++ y.s};
mkNP1  x y = {s = x.s ! y.g ++ y.s ! x.n};
mkNP2  x   = {s = x.s ! Pl};

robin = {s = "Robin"};
dog   = {s = table {Sg => "hund" ; Pl => "hundar"} ; g = Utr};
child = {s = table {_ => "barn"} ; g = Neu};
love  = {s = "älskar"};
hate  = {s = "hatar"};
one   = {s = table {Utr => "en" ; Neu => "ett"} ; n = Sg};
all   = {s = table {_ => "alla"} ; n = Pl};

}






























