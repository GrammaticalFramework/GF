instance LexRestaurantEng of LexRestaurant = open SyntaxEng, ParadigmsEng in {

oper
  restaurant_N = mkN "restaurant" ;
  cheap_A = mkA "cheap" ;
  italian_A = mkA "Italian" ;
  thai_A = mkA "Thai" ;
  swedish_A = mkA "Swedish" ;
  french_A = mkA "French" ;

  konkanok_PN = mkPN "Konkanok" ;
}
