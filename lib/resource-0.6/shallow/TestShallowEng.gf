--# -path=.:../../prelude:../abstract:../english

concrete TestShallowEng of TestShallow = ShallowEng ** open ParadigmsEng in {
  lin
    Big = mkAdj1 "big" ;
    Happy = mkAdj1 "happy" ;
    Small = mkAdj1 "small" ;
    American = mkAdj1 "American" ;
---    Man = nMan "man" "men" human ;
    Car = cnNonhuman "car" ;
    Walk = vReg "walk" ;
    Love = tvDir (vReg "love") ;
}

