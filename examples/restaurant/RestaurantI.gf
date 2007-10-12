incomplete concrete RestaurantI of Restaurant = open Syntax, LexRestaurant in {

lincat
  Descr = Phr ;
  Name = NP ;
  Nationality = A ;
  PriceLevel = A ;

lin
  MkDescr name price nat = 
    mkPhr (mkCl name (mkNP indefSgDet (mkCN price (mkCN nat (mkCN restaurant_N))))) ;

  Cheap = cheap_A ;
  Italian = italian_A ;
  Thai = thai_A ;
  Swedish = swedish_A ;
  French = french_A ;
  Konkanok = mkNP konkanok_PN ;


}
