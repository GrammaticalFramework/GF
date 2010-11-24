--# -path=.:../common:../abstract

resource MakeStructuralPnb = open CatPnb, ParadigmsPnb, ResPnb, MorphoPnb, NounPnb, Prelude in {

oper 
  mkSubj : Str -> CatPnb.Subj = \x -> 
    lin Subj {s = x} ;
  mkNP : Str -> Number -> ResPnb.NP = \s,n ->
     MassNP (UseN (ParadigmsPnb.mkN s));
--    lin NP (regNP s n) ;
  mkIDet : Str -> Number -> IDet = \s,n ->
    lin IDet {s = \\_ => s ; n = n} ;

}
