
-- the example 4.1 from Ljunglöf (2004, page 82) 

concrete CopyMorphism of CopyMorphismAbs = {

lincat 
S = { s : Str };
A = { s1 : Str; s2 : Str };

lin

f x = { s = x.s1 ++ x.s2 };

g x y = { s1 = x.s1 ++ y.s1;
      	  s2 = x.s2 ++ y.s2 };

ac = { s1 = "a"; s2 = "c" };

bd = { s1 = "b"; s2 = "d" };


}
