--# -path=.:../resource:prelude

concrete FoodCommentsIta of FoodComments = CommentsIta ** open LexIta in {

  lin
    Wine = regN "vino" ;
    Cheese = mkN masculine "formaggio" "formaggi" ;
    Fish = regN "pesce" ;
    Pizza = regN "pizza" ;
    Fresh = mkA "fresco" "fresca" "freschi" "fresche" ;
    Warm = regA "caldo" ;
    Italian = regA "italiano" ;
    Expensive = regA "caro" ;
    Delicious = regA "delizioso" ;
    Boring = regA "noioso" ;

}
