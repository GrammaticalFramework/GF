concrete paramsCnc of params = {

param
  Number = Sg | Pl ;
  Person = P1 | P2 | P3 ;

oper
  Agr = {n : Number; p : Person} ;

param
  Case = Nom | Acc | Abess Agr ;

lincat
  S = {s : Str} ;
  NP = {s : Case => Str} ;

lin
  test np = {s = np.s ! Abess {n=Sg;p=P3}} ;

}