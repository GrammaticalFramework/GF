
-- the example 4.1 from Ljunglöf (2004, page 82) 

concrete Erasing of ErasingAbs = {

lincat 
S = { s : Str };
A = { s1 : Str; s2 : Str };
B = { s : Str };
C = { s : Str };

lin

f x = { s = x.s1 };

g x y z = { s1 = x.s2 ++ y.s;
      	    s2 = x.s1 ++ z.s };

a = { s1 = "a1"; s2 = "a2" };

b = { s = "b" };

c = { s = "c" };


}
