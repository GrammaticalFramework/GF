
concrete FragmentSwedish of FragmentAbstract = open FragmentResource in {

lincat 

S  = { s : Order => Str };
VP = { s1 : Str; s2 : Str };
N  = { s : Num => Str; g : Gen };
D  = { s : Gen => Str; n : Num };

lin

s_p  x y = { s = table { Indir => y.s1 ++ x.s ++ y.s2; 
       	       	       	 Top   => y.s2 ++ y.s1 ++ x.s;
       	       	       	 _     => x.s ++ y.s1 ++ y.s2 } };
np_d x y = { s = x.s!y.g ++ y.s!x.n };
np_p x   = { s = x.s!Pl };
vp_t x y = { s1 = x.s; s2 = y.s };
d_a    	 = { s = table { Utr => "en"; Neu => "ett" }; n = Sg };
d_m	 = { s = table { _ => "maanga" }; n = Pl };
n_c	 = { s = table { _ => "lejon" }; g = Neu };
n_f	 = { s = table { Sg => "fisk"; Pl => "fiskar" }; g = Utr };
v_e	 = { s = "aeter" };

}

