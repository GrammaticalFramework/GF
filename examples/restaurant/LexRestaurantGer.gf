instance LexRestaurantGer of LexRestaurant = open SyntaxGer, ParadigmsGer in {

oper
  restaurant_N = mkN "Restaurant" "Restaurants" neuter ;
  cheap_A = mkA "billig" ;
  italian_A = mkA "italienisch" ;
  thai_A = mkA "thailändisch" ;
  swedish_A = mkA "schwedisch" ;
  french_A = mkA "französisch" ;

  konkanok_PN = mkPN "Konkanok" ;
}
