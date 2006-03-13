concrete English of Abstract = {

lincat 
  S = { s : Str } ;
  V2 = {s : Num => Str} ;
  Conj = {s : Str ; n : Num} ;
  NP = {s : Str ; n : Num; g : Gender} ;

lin
  PredV2 v s o = ss (s.s ++ v.s ! s.n ++ o.s) ;
  ReflV2 v s = ss (s.s ++ v.s ! s.n ++ self ! s.n ! s.g) ;
  -- FIXME: what is the gender of "Mary or Bill"?
  ConjNP c A B = {s = A.s ++ c.s ++ B.s ; n = c.n; g = A.g } ; 
  
  John = pn Masc "John" ;
  Mary = pn Fem "Mary" ;
  Bill = pn Masc "Bill" ;
  See = regV2 "see" ;
  Whip = regV2 "whip" ;

  And = {s = "and" ; n = Pl } ;
  Or = { s = "or"; n = Sg } ;

param
  Num = Sg | Pl ;
  Gender = Neutr | Masc | Fem ;

oper
  regV2 : Str -> {s : Num => Str} = \run -> {
    s = table {
      Sg => run + "s" ;
      Pl => run
      }
    } ;

  self : Num => Gender => Str =
    table {
      Sg => table {
	     Neutr => "itself";
	     Masc  => "himself";
	     Fem   => "herself"
	};
      Pl => \\g => "themselves"
    };

  pn : Gender -> Str -> {s : Str ; n : Num; g : Gender} = \gen -> \bob -> {
    s = bob ;
    n = Sg ;
    g = gen
    } ;

  ss : Str -> {s : Str} = \s -> {s = s} ;

}
