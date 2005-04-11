
concrete Findep of FindepAbs = {

lin 

Sg = {s = "SINGULAR"};
-- Pl = {s = "PLURAL"};

s  n g b x y = {s = x.s ++ y.s};
np n g b x y = {s = x.s ++ y.s};
vp n g b x y = {s = x.s ++ y.s};

npBest n g   x = {s = x.s};
npPl     g b x = {s = x.s};

en  = {s = "en"};
ett = {s = "ett"};
den = {s = "den"};
det = {s = "det"};

alla g = {s = "alla"};
de   g = {s = "de"};

katt     = {s = "katt"};
katter   = {s = "katter"};
katten   = {s = "katten"};
katterna = {s = "katterna"};

barn n   = {s = "barn"};
barnet   = {s = "barnet"};
barnen   = {s = "barnen"};

jagar  = {s = "jagar"};

}

