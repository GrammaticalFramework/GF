resource CommonSlavic = ParamX ** open Prelude in {

param
  Gender = Masc | Fem | Neut ;
  Animacy = Animate | Inanimate ;

  GenNum = GSg Gender | GPl ;

oper
  gennum : Gender -> Number -> GenNum = \g,n ->
    case n of {
      Sg => GSg g ;
      Pl => GPl
      } ;

  numGenNum : GenNum -> Number = \gn -> 
    case gn of {
      GSg _  => Sg ;
      GPl    => Pl
    } ;

}
