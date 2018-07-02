concrete IdiomEng of Idiom = CatEng ** open Prelude, ResEng in {

  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkClause "it" (agrP3 Sg) vp ;
    GenericCl vp = mkClause "one" (agrP3 Sg) vp ;

    CleftNP np rs = mkClause "it" (agrP3 Sg) 
      (insertObj (\\_ => rs.s ! np.a)
        (insertObj (\\_ => np.s ! rs.c) (predAux auxBe))) ;

    CleftAdv ad s = mkClause "it" (agrP3 Sg) 
      (insertObj (\\_ => conjThat ++ s.s)
        (insertObj (\\_ => ad.s) (predAux auxBe))) ;

    ExistNP np = 
      mkClause "there" (agrP3 (fromAgr np.a).n) 
        (insertObj (\\_ => np.s ! NPAcc) (predAux auxBe)) ;

    ExistIP ip = 
      mkQuestion (ss (ip.s ! npNom)) 
        (mkClause "there" (agrP3 ip.n) (predAux auxBe)) ;

    ExistNPAdv np adv = 
      mkClause "there" (agrP3 (fromAgr np.a).n) 
        (insertObj (\\_ => np.s ! NPAcc ++ adv.s) (predAux auxBe)) ;

    ExistIPAdv ip adv = 
      mkQuestion (ss (ip.s ! npNom)) 
        (mkClause "there" (agrP3 ip.n) (insertObj (\\_ => adv.s) (predAux auxBe))) ;

    ProgrVP vp = insertObj (\\a => vp.ad ! a ++ vp.prp ++ vp.p ++ vp.s2 ! a) (predAux auxBe) ;

    ImpPl1 vp = {s = "let's" ++ infVP VVAux vp False Simul CPos (AgP1 Pl)} ;

    ImpP3 np vp = {s = "let" ++ np.s ! NPAcc ++ infVP VVAux vp False Simul CPos np.a} ;

    SelfAdvVP vp = insertObj reflPron vp ;
    SelfAdVVP vp = insertAdVAgr reflPron vp ;
    SelfNP np = {
      s = \\c => np.s ! c ++ reflPron ! np.a ; 
      a = np.a
      } ;

}

