--# -path=.:../abstract:../../prelude

concrete RestaurantRus of Restaurant = 
  DatabaseRus ** open Prelude,ParadigmsRus in {
flags coding=utf8 ;
lin 
  Restaurant = n2n restoran;
  Bar = n2n bar ;
  French = AdjP1 francuzskij ;
  Italian = AdjP1 italyanskij ;
  Indian = AdjP1 indijskij ;
  Japanese = AdjP1 yaponskij ;

  address = funGen adres ;
  phone = funGen telefon ;
  priceLevel = funGen (commNounPhrase2CommNoun(appFunComm urovenFun cenu)) ;

  Cheap = deshevuj;
  Expensive = dorogoj ;

  WhoRecommend rest = mkSentSame (ss2 ["кто порекомендовал"] (rest.s ! Acc)) ;
  WhoHellRecommend rest = 
    mkSentSame (ss2 ["кто, черт возьми, порекомендовал"] (rest.s ! Acc)) ;

  LucasCarton = mkProperNameMasc ["Лукас Картун"] Inanimate;

oper 
  urovenFun : Function = funGen uroven ;
  cenu : NounPhrase = mkNounPhrase Pl (n2n cena) ;  
};
