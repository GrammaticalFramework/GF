concrete CharEng of Char = open Prelude in {

lin
  BaseChr c = c ;
  ConsChr = infixSS "," ;

  C_dot = ss "dot" ;
  C_pipe = ss "pipe" ;
  C_hyphen = ss (variants {"dash" ; "hyphen" ; "minus"}) ;
  CSmall = prefixSS "small" ;
  CCap = prefixSS "capital" ;
  CC c = c ;

  CDig_0 =  ss "zero" ;
  CDig_1 =  ss "one" ;
  CDig_2 =  ss "two" ;
  CDig_3 =  ss "three" ;
  CDig_4 =  ss "four" ;
  CDig_5 =  ss "five" ;
  CDig_6 =  ss "six" ;
  CDig_7 =  ss "seven" ;
  CDig_8 =  ss "eight" ;
  CDig_9 =  ss "nine" ;

  L_a =  ss "alpha" ;
  L_b =  ss "bravo" ;
  L_c =  ss "charlie" ;
  L_d =  ss "delta" ;
  L_e =  ss "echo" ;
  L_f =  ss "foxtrot" ;
  L_g =  ss "golf" ;
  L_h =  ss "hotel" ;
  L_i =  ss "india" ;
  L_j =  ss "juliet" ;
  L_k =  ss "kilo" ;
  L_l =  ss "lima" ;
  L_m =  ss "mike" ;
  L_n =  ss "november" ;
  L_o =  ss "oscar" ;
  L_p =  ss "papa" ;
  L_q =  ss "quebec" ;
  L_r =  ss "romeo" ;
  L_s =  ss "sierra" ;
  L_t =  ss "tango" ;
  L_u =  ss "uniform" ;
  L_v =  ss "victor" ;
  L_w =  ss "whiskey" ;
  L_x =  ss "x-ray" ;
  L_y =  ss "yankee" ;
  L_z =  ss "zulu" ;

}