 --# -path=.:../common:../abstract

resource MakeStructuralMon = open CatMon, ParadigmsMon, ResMon, Prelude in {

oper
 mkConj : Str -> Str -> Conj = \x,y -> lin Conj
    {s1 = x ; s2 = y} ; 

 mkSubj : Str -> Subj = \x -> lin Subj {s = x} ;

} 
