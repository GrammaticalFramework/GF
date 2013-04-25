concrete AdjectiveGre of Adjective = CatGre ** open ResGre, Prelude in {

flags coding=utf8;

lin

    PositA  a = {
      s = \\_=> a.s ! Posit;
      adv = a.adv ;
    } ;


    ComparA a np = {
      s = \\d,g,n,c =>   a.s ! Compar!  g ! n ! Nom ++ "από" ++ (np.s ! CPrep PNul).comp ;
      adv = a.adv ;  
    } ;

    ComplA2 adj np = {
      s = \\d,g,n,c => adj.s ! Posit !g ! n ! Nom ++ appCompl adj.c2 np ;
      adv = adj.adv ; 
      isPre = False
    } ;


   ReflA2 adj = { 
      s = \\d,g,n,c => adj.s ! Posit !g ! n ! Nom ++ adj.c2.s ++ reflPron ! (Ag g n P3) !Acc ;
      isPre = False ;
      adv= adj.adv
    } ;



    UseA2 a = {
      s = \\_ =>  a.s ! Posit ; 
      adv = a.adv ;
     } ;



    UseComparA a = {
      s = \\_ =>  a.s ! Compar ; 
      adv = a.adv ;
    } ;


    CAdvAP ad ap np = {
     s = \\d,g,n,c => ad.s ++ ap.s ! d ! g ! n ! c ++ ad.p ++ (np.s ! ad.c).comp ; 
     adv =  ap.adv ;
    } ;


    AdjOrd ord = {
      s = \\_, g, n, c =>   ord.s ! Posit ! g !n ! c;   
      adv = ord.adv ;
    } ;



   SentAP ap sc = {
      s = \\d,g,n,c => ap.s ! d! g ! n! Nom ++ sc.s ;
      adv = ap.adv ;  
      isPre = False
     } ;


    AdAP ada ap = {
     s = \\d,g,n,c => ada.s ++ ap.s ! d ! g ! n ! c ; 
     adv =  ap.adv ;
    } ;

   
    AdvAP ap adv = {
      s = \\d,g,n,c=> ap.s ! d ! g! n ! Nom ++ adv.s  ;
      isPre = False ;
      adv= ap.adv
    } ;
   


}
