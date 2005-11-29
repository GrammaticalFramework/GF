concrete SequenceEng of Sequence = 
  CatEng ** open ResEng, Coordination, Prelude in {

  lin

    TwoS = twoSS ;
    AddS = consSS comma ;
    TwoAdv = twoSS ;
    AddAdv = consSS comma ;
    TwoNP x y = twoTable Case x y ** {a = conjAgr x.a y.a} ;
    AddNP xs x = consTable Case comma xs x ** {a = conjAgr xs.a x.a} ;
    TwoAP x y = twoTable Agr x y ** {isPre = andB x.isPre y.isPre} ;
    AddAP xs x = consTable Agr comma xs x ** {isPre = andB xs.isPre x.isPre} ;

}
