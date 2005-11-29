concrete ConjunctionEng of Conjunction = 
  SequenceEng ** open ResEng, Coordination in {

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

}
