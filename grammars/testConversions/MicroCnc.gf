
concrete MicroCnc of MicroAbs = open MicroRes in {

lincat 
S = {s : Str};
VV = {a : {s1:Str ; s2:Str}};
V = {s1 : Str ; s2 : Str ; p : PQ};
W = {s : Num => Str ; p : PQ => Num};

lin 
sv x = {s = x.s1 ++ x.s2};
vars = {a = variants { {s1="a" ; s2=variants{"b";"c"}} ; {s1="d";s2="e"} }};
ww x = {s = table {Sg => x.s!(x.p!P); 
                   Pl => x.s!(x.p!Q Pl)}; 
        p = table {P => Sg ; Q n => n}};
svw x y = {s = x.s2 ++ y.s!(y.p!x.p) ++ x.s1};

supr x y = {s = x.s1 ++ "a" ++ x.s2};
supredup x y = {s = x.s ++ "b" ++ x.s};
suplbl x = {s = x.s1};
reorder x y = {s1 = x.s2 ++ y.s1 ++ x.s1;
	       s2 = y.s2 ++ y.s1;
               p = x.p};
}


