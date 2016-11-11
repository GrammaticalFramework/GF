concrete VerbSlv of Verb = CatSlv ** open ResSlv, ParamX, Prelude in {

  lin
    UseV v = 
      { s  = \\p,vform => ne ! p ++ v.s ! vform ;
        s2 = \\a => v.p ;  ----AR: +p particle
        isCop = False ;
        refl = v.refl
      } ;

    SlashV2a v = 
      { s  = \\p,vform => ne ! p ++ v.s ! vform ;
        s2 = \\a => v.p ;  ----AR: +p particle
        c2 = v.c2 ;
        isCop = False ;
        refl = v.refl
      } ;

    --Check these V3-slashes AE
    Slash2V3 v np =
      { s  = \\p,vform => ne ! p ++ v.s ! vform ;
        s2 = \\_ => v.p ++ v.c2.s ++ np.s ! v.c2.c ;  
        c2 = v.c3 ;
        isCop = False ;
        refl = v.refl
      } ;

    Slash3V3 v np =
      { s  = \\p,vform => ne ! p ++ v.s ! vform ;
        s2 = \\_ => v.p ++ v.c3.s ++ np.s ! v.c3.c ;  
        c2 = v.c2 ;
        isCop = False ;
        refl = v.refl
      } ;

    ComplSlash vp np =
      insertObj (\\_ => vp.c2.s ++ np.s ! vp.c2.c) vp;


    ReflVP vp = {
      s     =  \\vform => vp.s ! vform ; --? the compiler told me to cut the polarity from this function?
      --s     =  \\p,vform => ne ! p ++ vp.s ! vform ;
      s2    = \\a => vp.s2 ! a ;
      isCop = False ;
      refl = reflexive ! vp.c2.c 
    } ;

    UseComp comp = {
      s     = copula ;
      s2    = comp.s ;
      isCop = True ;
      refl = []  
    } ;

    AdvVP vp adv = insertObj (\\_ => adv.s) vp ;

    CompAP ap = {
      s = \\agr => ap.s ! Indef ! inanimateGender agr.g ! Nom ! agr.n
      } ;
      
    CompAdv adv = {s = \\agr => adv.s} ; ----AR
    CompNP np = {s = \\agr => np.s ! Nom} ; ----AR

}
