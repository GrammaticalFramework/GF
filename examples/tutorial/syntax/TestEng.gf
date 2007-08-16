--# -path=.:resource:prelude

concrete TestEng of Test = SyntaxEng ** open Prelude, MorphoEng in {

  lin
    Wine = mkN "wine" ;
    Cheese = mkN "cheese" ;
    Fish = mkN "fish" "fish" ;
    Pizza = mkN "pizza" ;
    Waiter = mkN "waiter" ;
    Customer = mkN "customer" ;
    Fresh = mkA "fresh" ;
    Warm = mkA "warm" ;
    Italian = mkA "Italian" ;
    Expensive = mkA "expensive" ;
    Delicious = mkA "delicious" ;
    Boring = mkA "boring" ;
    Stink = mkV "stink" ;
    Eat = mkV2 (mkV "eat") ;
    Love = mkV2 (mkV "love") ;
    Talk = mkV2 (mkV "talk") "about" ;
}

