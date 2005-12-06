concrete English of Abstract = {

lincat 
  VP = {s : Num => Str} ;
  NP, Conj = {s : Str ; n : Num} ;

lin
  Pred np vp = ss (np.s ++ vp.s ! np.n) ;
  ConjS c A  B = ss (A.s ++ c.s ++ B.s) ;
  ConjVP c A  B = {s = \\n => A.s ! n ++ c.s ++ B.s ! n} ;
  ConjNP c A  B = {s = A.s ++ c.s ++ B.s ; n = c.n} ;
  
  John = pn "John" ;
  Mary = pn "Mary" ;
  Bill = pn "Bill" ;
  Walk = vp "walk" ;
  Run  = vp "run" ;
  Swim = vp "swim" ;

  And = {s = "and" ; n = Pl} ;
  Or = pn "or" ;

param
  Num = Sg | Pl ;

oper
  vp : Str -> {s : Num => Str} = \run -> {
    s = table {
      Sg => run + "s" ;
      Pl => run
      }
    } ;

  pn : Str -> {s : Str ; n : Num} = \bob -> {
    s = bob ;
    n = Sg
    } ;

  ss : Str -> {s : Str} = \s -> {s = s} ;

}
