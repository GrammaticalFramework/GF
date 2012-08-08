--# -path=.:../common:../abstract

resource MakeStructuralLav = open CatLav, ParadigmsLav, ResLav, Prelude in {

flags
  coding = utf8 ;

oper
  mkSubj : Str -> Subj = \x ->
    lin Subj {s = x} ;

  --mkNP : Str -> ParadigmsLav.Number -> NP = \s,n ->
  --  lin NP (regNP s n) ;

  mkIDet : Str -> ParadigmsLav.Number -> IDet = \s,n ->
    lin IDet {s = \\_ => s ; n = n} ;

}
