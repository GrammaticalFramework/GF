--# -path=.:../common:../abstract

resource MakeStructuralUrd = open CatUrd, ParadigmsUrd, ResUrd, MorphoUrd, NounUrd, Prelude in {

oper 
  mkSubj : Str -> CatUrd.Subj = \x -> 
    lin Subj {s = x} ;
  mkNP : Str -> Number -> ResUrd.NP = \s,n ->
     MassNP (UseN (ParadigmsUrd.mkN s));
--    lin NP (regNP s n) ;
  mkIDet : Str -> Number -> IDet = \s,n ->
    lin IDet {s = \\_ => s ; n = n} ;

}
