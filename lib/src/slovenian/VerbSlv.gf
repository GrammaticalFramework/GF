concrete VerbSlv of Verb = CatSlv ** open ResSlv, ParamX, Prelude in {

  lin
    UseV v = 
      { s  = \\p,vform => ne ! p ++ v.s ! vform ;
        s2 = \\a => "" ;
        isCop = False
      } ;

    SlashV2a v = 
      { s  = \\p,vform => ne ! p ++ v.s ! vform ;
        s2 = \\a => "" ;
        c2 = v.c2 ;
        isCop = False
      } ;

    ComplSlash vp np =
      insertObj (\\_ => vp.c2.s ++ np.s ! vp.c2.c) vp;

    UseComp comp = {
      s     = copula ;
      s2    = comp.s ;
      isCop = True
    } ;

    AdvVP vp adv = insertObj (\\_ => adv.s) vp ;

    CompAP ap = {
      s = \\agr => ap.s ! Indef ! inanimateGender agr.g ! Nom ! agr.n
      } ;

}
