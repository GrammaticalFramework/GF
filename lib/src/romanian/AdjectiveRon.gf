concrete AdjectiveRon of Adjective = 
  CatRon ** open ResRon, Prelude in {

  lin

    PositA  a = {
      s = a.s ;
      isPre = a.isPre
      } ;
    ComparA a np = {
      s = \\af => "mai" ++ a.s ! af  ++ conjThan ++ (np.s ! Ac).comp ; 
      isPre = False
      } ;
  
  CAdvAP ad ap np = {
      s = \\af => case af of
                    { AF g n sp c => artDem g n c ++ ad.s ++ ap.s ! (AF g n Indef c) ++ ad.p ++ (np.s ! No).comp ; 
                      AA          => ad.s ++ ap.s ! af ++ ad.p ++ (np.s ! No).comp 
                    };
      isPre = False
      } ;

   UseComparA a = {
      s = \\af => "mai" ++ a.s ! af ;
      isPre = False
      } ;
  
 AdjOrd ord = {
      s = \\af => case af of {
        AF g n sp c => ord.s ! n ! g ! (convACase c) ; 
        _ => ord.s ! Sg ! Masc ! No
        } ;
      isPre = True 
      } ;

-- $SuperlA$ belongs to determiner syntax in $Noun$.

    ComplA2 adj np = {
      s = \\af => adj.s ! af ++ appCompl adj.c2 np ; 
      isPre = False
      } ;

    ReflA2 adj = {
      s = \\af => case af of
            { AF g n sp c => adj.s ! af ++ adj.c2.s ++
              reflPron n P3 (convCase adj.c2.c) ++ reflPronHard g n P3; 
              AA => adj.s ! af ++ adj.c2.s ++ reflPron Sg P3 (convCase adj.c2.c) ++ reflPronHard Masc Sg P3
             };
      isPre = False
      } ;

    SentAP ap sc = {
      s = \\a => ap.s ! a ++ sc.s ; --- mood 
      isPre = False
      } ;

    AdAP ada ap = {
      s = \\a => ada.s ++ ap.s ! a ;
      isPre = ap.isPre
      } ;

    UseA2 a = {
      s = a.s ;
      isPre = False 
      } ;

};
