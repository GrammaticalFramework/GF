
abstract FragmentAbstract = {

cat S; NP; VP; D; N; V;

fun

s_p      : NP -> VP -> S;
np_d 	 : D  -> N  -> NP;
np_p 	 : N  	    -> NP;
vp_t 	 : V  -> NP -> VP;
d_a, d_m : D;
n_c, n_f : N;
v_e, v_h : V;

}

