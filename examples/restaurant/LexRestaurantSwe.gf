instance LexRestaurantSwe of LexRestaurant = open SyntaxSwe, ParadigmsSwe in {

oper
  restaurant_N = mkN "restaurang" ;
  cheap_A = mkA "billig" ;
  italian_A = mkA "italiensk" ;
  thai_A = mkA "thailändsk" ;
  swedish_A = mkA "svensk" ;
  french_A = mkA "fransk" ;

  konkanok_PN = mkPN "Konkanok" ;
}
