 concrete ConjunctionGre of Conjunction = 
  CatGre ** open CommonGre, ResGre, Coordination, Prelude in {

  flags coding =utf8 ;

  lin

    ConjS conj ss = conjunctDistrTable Mood conj ss ;

    ConjAdv conj ss = conjunctDistrSS conj ss ;

    

    ConjNP conj ss = heavyNP (conjunctDistrTable Case conj ss ** {
      a = Ag  (agrFeatures ss.a).g  (conjNumber (agrFeatures ss.a).n conj.n) (agrFeatures ss.a).p ;
      isClit = False ; isNeg = ss.isNeg
      }) ;


    ConjAP conj ss = conjunctDistrTable4 Degree Gender Number Case conj ss ** {
      adv = ss.adv
      } ;
      

    ConjRS conj ss = conjunctDistrTable2 Mood Agr conj ss ** {      
     c = ss.c
     } ;

    ConjIAdv = conjunctDistrSS ;

    ConjCN co ns = conjunctDistrTable2 Number Case co ns ** {g = ns.g;} ;


    BaseS = twoTable Mood  ;
    ConsS = consrTable Mood comma ;
    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;

    
  
    BaseNP x y = {
      s1 = \\c => (x.s ! conjunctCase c).comp ; 
      s2 = \\c =>  (y.s ! conjunctCase c).comp ; 
      a = conjAgr Sg x.a y.a ; isNeg = orB x.isNeg y.isNeg
      } ;

    ConsNP x xs = {
      s1 = \\c => (x.s ! conjunctCase c).comp ++ comma ++ xs.s1 ! c ; 
      s2 = \\c => xs.s2 ! conjunctCase c ; 
      a = conjAgr Sg x.a xs.a ; isNeg = orB x.isNeg xs.isNeg
      } ;


    BaseAP x y = twoTable4 Degree Gender Number Case x y ** {adv = x.adv} ;
    ConsAP xs x = consrTable4 Degree Gender Number Case comma xs x  ** {adv = x.adv};


    BaseIAdv = twoSS ;
    ConsIAdv = consrSS comma ;

    BaseRS x y = twoTable2 Mood Agr x y ** {c = y.c} ;   
    ConsRS xs x = consrTable2 Mood Agr comma xs x ** {c = xs.c} ;
    
    BaseCN x y = twoTable2 Number Case x y ** {g = conjGender x.g y.g } ;
    ConsCN x xs = consrTable2 Number Case comma x xs ** {g = conjGender x.g xs.g } ;


  lincat
    [S] = {s1,s2 : Mood => Str} ;
    [Adv] = {s1,s2 : Str} ;
    [IAdv] = {s1,s2 : Str} ;
    [NP] = {s1,s2 : Case => Str ; a : Agr } ;
    [AP] = {s1,s2 : Degree => Gender => Number => Case => Str ; adv : Degree => Str } ;
    [RS] = {s1,s2 : Mood => Agr => Str ; c : Case} ;
    [CN] = {s1,s2 : Number => Case => Str ; g : Gender} ;

}
