
concrete FragmentNumber of FragmentAbstract = open FragmentResource in {

lincat 

N  = { s : Num => Str };
V  = { s : Num => Str };
VP = { s : Num => Str };

D  = { s : Str; n : Num };
NP = { s : Str; n : Num };

lin

s_p  x y = { s = x.s ++ y.s!x.n };
np_d x y = { s = x.s ++ y.s!x.n; n = x.n };
np_p x   = { s = x.s!Pl; n = Pl };
vp_t x y = { s = table { z => x.s!z ++ y.s } };
d_a    	 = { s = "a"; n = Sg };
d_m	 = { s = "many"; n = Pl };
n_c	 = { s = table { Sg => "lion"; Pl => "lions" } };
n_f	 = { s = table { _ => "fish" } };
v_e	 = { s = table { Sg => "eats" ; Pl => "eat" } };
v_h	 = { s = table { Sg => "hunts" ; Pl => "hunt" } };

}

