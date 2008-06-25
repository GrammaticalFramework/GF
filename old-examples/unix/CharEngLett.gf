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

  CDig_0 =  ss "0" ;
  CDig_1 =  ss "1" ;
  CDig_2 =  ss "2" ;
  CDig_3 =  ss "3" ;
  CDig_4 =  ss "4" ;
  CDig_5 =  ss "5" ;
  CDig_6 =  ss "6" ;
  CDig_7 =  ss "7" ;
  CDig_8 =  ss "8" ;
  CDig_9 =  ss "9" ;

  L_a =  ss "A" ;
  L_b =  ss "B" ;
  L_c =  ss "C" ;
  L_d =  ss "D" ;
  L_e =  ss "E" ;
  L_f =  ss "F" ;
  L_g =  ss "G" ;
  L_h =  ss "H" ;
  L_i =  ss "I" ;
  L_j =  ss "J" ;
  L_k =  ss "K" ;
  L_l =  ss "L" ;
  L_m =  ss "M" ;
  L_n =  ss "N" ;
  L_o =  ss "O" ;
  L_p =  ss "P" ;
  L_q =  ss "Q" ;
  L_r =  ss "R" ;
  L_s =  ss "S" ;
  L_t =  ss "T" ;
  L_u =  ss "U" ;
  L_v =  ss "V" ;
  L_w =  ss "W" ;
  L_x =  ss "X" ;
  L_y =  ss "Y" ;
  L_z =  ss "Z" ;

}