--# -coding=cp1251
concrete AdjectiveBul of Adjective = CatBul ** open ResBul, Prelude in {
  flags coding=cp1251 ;

  lin
    PositA  a = {
      s = \\aform,_ => a.s ! aform ;
      isPre = a.isPre
      } ;

    ComparA a np = {
      s = \\aform,_ => "по" ++ hyphen ++ a.s ! aform ++ "от" ++ np.s ! RObj CPrep ;
      isPre = True
      } ;
    UseComparA a = {
      s = \\aform,_ => "по" ++ hyphen ++ a.s ! aform ; 
      isPre = True
      } ;

    AdjOrd ord = {
      s = \\aform,_ => ord.s ! aform ;
      isPre = True
      } ;

-- $SuperlA$ belongs to determiner syntax in $Noun$.

    CAdvAP ad ap np = {
      s = \\a,p => ad.s ++ ap.s ! a ! p ++ ad.p ++ np.s ! RObj CPrep ; 
      isPre = False
      } ;

    ComplA2 a np = {
      s = \\aform,p => a.s ! aform ++ a.c2 ++ np.s ! RObj CPrep ; 
      isPre = False
      } ;

    ReflA2 a = {
      s = \\aform,_ => a.s ! aform ++ a.c2 ++ ["себе си"] ;
      isPre = False
      } ;

    SentAP ap sc = {
      s = \\a,p => ap.s ! a ! p ++ sc.s ! {gn=aform2gennum a; p=p} ;
      isPre = False
      } ;

    AdAP ada ap = {
      s = \\a,p => ada.s ++ ap.s ! a ! p ;
      isPre = ap.isPre
      } ;

    UseA2 a = {
      s = \\aform,p => a.s ! aform ;
      isPre = True
      } ;
      
    AdvAP ap adv = {
      s = \\aform,p => ap.s ! aform ! p ++ adv.s ;
      isPre = False
    } ;

}
