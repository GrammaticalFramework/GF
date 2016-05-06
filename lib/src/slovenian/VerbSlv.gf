concrete VerbSlv of Verb = CatSlv ** open ResSlv, Prelude in {

  lin
    UseV v = 
      { s  = v.s ;
        s2 = \\a => ""
      } ;

    SlashV2a v = 
      { s  = v.s ;
        s2 = \\a => "" ;
        c2 = v.c2
      } ;

    ComplSlash vp np =
      insertObj (\\_ => vp.c2.s ++ np.s ! vp.c2.c) vp ;

}
