--# -path=.:../common:../abstract

resource MakeStructuralLav = open CatLav, ParadigmsLav, ResLav, Prelude in {

flags
  coding = utf8 ;

oper
  mkSubj : Str -> Subj = \x ->
    lin Subj {s = x} ;

  mkIDet : Str -> ParadigmsLav.Number -> IDet = \s,n ->
    lin IDet {s = \\_ => s ; n = n} ;

}
