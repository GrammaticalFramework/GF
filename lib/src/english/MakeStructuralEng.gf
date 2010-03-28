--# -path=.:../common:../abstract

resource MakeStructuralEng = open CatEng, ParadigmsEng, ResEng, MorphoEng, Prelude in {

oper 
  mkSubj : Str -> Subj = \x -> 
    lin Subj {s = x} ;
  mkNP : Str -> ParadigmsEng.Number -> NP = \s,n ->
    lin NP (regNP s n) ;
  mkIDet : Str -> ParadigmsEng.Number -> IDet = \s,n ->
    lin IDet {s = s ; n = n} ;

}
