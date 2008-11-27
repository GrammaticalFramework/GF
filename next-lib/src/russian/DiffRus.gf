instance DiffRus of DiffSlavic = open CommonSlavic, Prelude in {

  param
    PrepKind   = PrepOther | PrepVNa;
    Case  = Nom | Gen | Dat | Acc | Inst | Prepos PrepKind ;

    NForm = NF Number Case ;

    PronGen = PGen Gender | PNoGen ;

  oper
    Agr = {n : Number; p : Person; g : PronGen} ;

    agrP3 : Number -> PronGen -> Agr = \n,g -> 
      {n = n; p = P3; g = g} ;

}