
concrete FragmentSimple of FragmentAbstract = {

lin

s_p  x y = { s = x.s ++ y.s };
np_d x y = { s = x.s ++ y.s };
np_p x   = { s = x.s };
vp_t x y = { s = x.s ++ y.s };
d_a    	 = { s = "a" };
d_m	 = { s = "many" };
n_c	 = { s = variants { "lion" ; "lions" } };
n_f	 = { s = "fish" };
v_e	 = { s = variants { "eats" ; "eat" } };

}

