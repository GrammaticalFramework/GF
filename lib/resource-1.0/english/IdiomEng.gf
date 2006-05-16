concrete IdiomEng of Idiom = CatEng ** open Prelude, ResEng in {

  flags optimize=all_subs ;

  lin
    ImpersCl vp = mkClause "it" (agrP3 Sg) vp ;
    GenericCl vp = mkClause "one" (agrP3 Sg) vp ;

    ExistNP np = 
      mkClause "there" (agrP3 np.a.n) (insertObj (\\_ => np.s ! Acc) (predAux auxBe)) ;

    ExistIP ip = 
      let cl =
        mkClause (ip.s ! Nom) (agrP3 ip.n) (insertObj (\\_ => "there") (predAux auxBe))
      in {
        s = \\t,a,b,_ => cl.s ! t ! a ! b ! ODir  --- "what is there", no "what there is"
        } ;


    ProgrVP vp = insertObj (\\a => vp.ad ++ vp.prp ++ vp.s2 ! a) (predAux auxBe) ;

}

