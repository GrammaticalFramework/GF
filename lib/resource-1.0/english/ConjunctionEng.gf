concrete ConjunctionEng of Conjunction = 
  CatEng ** open ResEng, Coordination, Prelude in {

  lin

    ConjS conj ss = {s = conjunctX conj ss} ;
    DConjS conj ss = {s = conjunctDistrX conj ss} ;

    ConjAdv conj ss = {s = conjunctX conj ss} ;
    DConjAdv conj ss = {s = conjunctDistrX conj ss} ;

    ConjNP conj ss = conjunctTable Case conj ss ** {
      a = {n = conjNumber conj.n ss.a.n ; p = ss.a.p}
      } ;
    DConjNP conj ss = conjunctDistrTable Case conj ss ** {
      a = {n = conjNumber conj.n ss.a.n ; p = ss.a.p}
      } ;

    ConjAP conj ss = conjunctTable Agr conj ss ** {
      isPre = ss.isPre
      } ;
    DConjAP conj ss = conjunctDistrTable Agr conj ss ** {
      isPre = ss.isPre
      } ;

    TwoS = twoSS ;
    AddS = consSS comma ;
    TwoAdv = twoSS ;
    AddAdv = consSS comma ;
    TwoNP x y = twoTable Case x y ** {a = conjAgr x.a y.a} ;
    AddNP xs x = consTable Case comma xs x ** {a = conjAgr xs.a x.a} ;
    TwoAP x y = twoTable Agr x y ** {isPre = andB x.isPre y.isPre} ;
    AddAP xs x = consTable Agr comma xs x ** {isPre = andB xs.isPre x.isPre} ;

}
