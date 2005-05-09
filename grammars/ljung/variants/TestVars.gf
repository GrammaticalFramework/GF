
concrete TestVars of TestVarsA = open TestVarsR in {

lincat S = {s1:Str; s2:AB => Str};

lin

f x = { s1 = x.s2 ! A;
      	s2 = table{ y => variants{ x.s2 ! A; x.s1 ++ x.s2 ! y } } };

a = { s1 = "a" ++ variants{ "b"; "c" }; 
      s2 = table{ A => variants{ "A"; "Q" }; B => "B" } };

}
