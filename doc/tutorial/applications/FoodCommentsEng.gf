--# -path=.:../resource:prelude


concrete FoodCommentsEng of FoodComments = CommentsEng ** open LexEng in {

  lin
    Wine = regN "wine" ;
    Cheese = regN "cheese" ;
    Fish = mkN "fish" "fish" ;
    Pizza = regN "pizza" ;
    Fresh = mkA "fresh" ;
    Warm = mkA "warm" ;
    Italian = mkA "Italian" ;
    Expensive = mkA "expensive" ;
    Delicious = mkA "delicious" ;
    Boring = mkA "boring" ;

}
