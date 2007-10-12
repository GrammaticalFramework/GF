instance LexRestaurantFin of LexRestaurant = open SyntaxFin, ParadigmsFin in {

oper
  restaurant_N = mkN "ravintola" ;
  cheap_A = mkA "halpa" ;
  italian_A = mkA "italialainen" ;
  thai_A = mkA "thaimaalainen" ;
  swedish_A = mkA "ruotsalainen" ;
  french_A = mkA "ranskalainen" ;

  konkanok_PN = mkPN "Konkanok" ;
}
