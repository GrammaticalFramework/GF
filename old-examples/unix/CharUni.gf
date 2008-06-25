concrete CharUni of Char = open Prelude in {

param 
  LForm = LCap | LSma ;

oper
  chr : Str -> Str -> {s : LForm => Str} = \c,C -> {
    s = table {
      LCap => C ;
      LSma => c
      }
    } ;

lincat 
  Letter = {s : LForm => Str} ;

lin
  BaseChr c = c ;
  ConsChr = infixSS "&+" ;

  C_dot = ss "." ;
  C_pipe = ss "|" ;
  C_hyphen = ss "-" ;
  CSmall c = ss (c.s ! LSma) ;
  CCap c = ss (c.s ! LCap) ;
  CC c = ss (c.s ! LSma) ;

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


  L_a =  chr "a" "A" ;
  L_b =  chr "b" "B" ;
  L_c =  chr "c" "C" ;
  L_d =  chr "d" "D" ;
  L_e =  chr "e" "E" ;
  L_f =  chr "f" "F" ;
  L_g =  chr "g" "G" ;
  L_h =  chr "h" "H" ;
  L_i =  chr "i" "I" ;
  L_j =  chr "j" "J" ;
  L_k =  chr "k" "K" ;
  L_l =  chr "l" "L" ;
  L_m =  chr "m" "M" ;
  L_n =  chr "n" "N" ;
  L_o =  chr "o" "O" ;
  L_p =  chr "p" "P" ;
  L_q =  chr "q" "Q" ;
  L_r =  chr "r" "R" ;
  L_s =  chr "s" "S" ;
  L_t =  chr "t" "T" ;
  L_u =  chr "u" "U" ;
  L_v =  chr "v" "V" ;
  L_w =  chr "w" "W" ;
  L_x =  chr "x" "X" ;
  L_y =  chr "y" "Y" ;
  L_z =  chr "z" "Z" ;

}
