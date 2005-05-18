
concrete Findep of FindepAbs = {

flags conversion = finite;

lin 

Sg = {s = "SINGULAR"};
-- Pl = {s = "PLURAL"};

s   n g b x y = {s = x.s ++ y.s};
np  n g b x y = {s = x.s ++ y.s};
vpt n g b x y = {s = x.s ++ y.s};
vpi       x   = {s = x.s};

npBest n g   x = {s = x.s};
npPl     g b x = {s = x.s};

en  = {s = "en"};
ett = {s = "ett"};
den = {s = "den"};
det = {s = "det"};

ingen  = {s = "ingen"};
inget  = {s = "inget"};
inga g = {s = "inga"};

alla g = {s = "alla"};
de   g = {s = "de"};

katt     = {s = "katt"};
katter   = {s = "katter"};
katten   = {s = "katten"};
katterna = {s = "katterna"};

hund     = {s = "hund"};
hundar   = {s = "hundar"};
hunden   = {s = "hunden"};
hundarna = {s = "hundarna"};

barn n   = {s = "barn"};
barnet   = {s = "barnet"};
barnen   = {s = "barnen"};

djur n   = {s = "djur"};
djuret   = {s = "djuret"};
djuren   = {s = "djuren"};

jagar  = {s = "jagar"};
sover  = {s = "sover"};

}

