--# -coding=cp1251
concrete AdjectiveBul of Adjective = CatBul ** open ResBul, Prelude in {
  flags coding=cp1251 ;

  lin
    PositA  a = {
      s = \\aform,_ => a.s ! aform ;
      adv = a.adv ;
      isPre = True
      } ;

    ComparA a np = {
      s = \\aform,_ => "по" ++ hyphen ++ a.s ! aform ++ "от" ++ np.s ! RObj Acc ; 
      adv = "по" ++ hyphen ++ a.adv ++ "от" ++ np.s ! RObj Acc ;
      isPre = True
      } ;
    UseComparA a = {
      s = \\aform,_ => "по" ++ hyphen ++ a.s ! aform ; 
      adv = "по" ++ hyphen ++ a.adv ;
      isPre = True
      } ;

    AdjOrd ord = {
      s = \\aform,_ => ord.s ! aform ;
      adv = ord.s ! ASg Neut Indef ; 
      isPre = True
      } ;

-- $SuperlA$ belongs to determiner syntax in $Noun$.

---- just to make the API compile. AR 7/4/2010
    CAdvAP ad ap np = {
      s = \\a,p => ad.s ++ ap.s ! a ! p ++ ad.sn ++ np.s ! RObj Acc ; 
      adv =        ad.s ++ ap.adv ++ ad.sn ++ np.s ! RObj Acc ; 
      isPre = False
      } ;

    ComplA2 a np = {
      s = \\aform,p => a.s ! aform ++ a.c2 ++ np.s ! RObj Acc ; 
      adv = a.adv ++ a.c2 ++ np.s ! RObj Acc ; 
      isPre = False
      } ;

    ReflA2 a = {
      s = \\aform,_ => a.s ! aform ++ a.c2 ++ ["себе си"] ; 
      adv = a.adv ++ a.c2 ++ ["себе си"] ; 
      isPre = False
      } ;

    SentAP ap sc = {
      s = \\a,p => ap.s ! a ! p ++ sc.s ! {gn=aform2gennum a; p=p} ;
      adv = ap.adv ++ sc.s ! agrP3 (GSg Neut) ;
      isPre = False
      } ;

    AdAP ada ap = {
      s = \\a,p => ada.s ++ ap.s ! a ! p ;
      adv = ada.s ++ ap.adv ;
      isPre = ap.isPre
      } ;

    UseA2 a = {
      s = \\aform,p => a.s ! aform ;
      adv = a.adv ; 
      isPre = True
      } ;
      
    AdvAP ap adv = {
      s = \\aform,p => ap.s ! aform ! p ++ adv.s ;
      adv = ap.adv ++ adv.s;
      isPre = False
    } ;

}
