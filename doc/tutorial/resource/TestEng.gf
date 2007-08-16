--# -path=.:resource:prelude

concrete TestEng of Test = SyntaxEng ** open Prelude, MorphoEng in {

  lin
    Wine = regNoun "wine" ;
    Cheese = regNoun "cheese" ;
    Fish = mkNoun "fish" "fish" ;
    Pizza = regNoun "pizza" ;
    Waiter = regNoun "waiter" ;
    Customer = regNoun "customer" ;
    Fresh = ss "fresh" ;
    Warm = ss "warm" ;
    Italian = ss "Italian" ;
    Expensive = ss "expensive" ;
    Delicious = ss "delicious" ;
    Boring = ss "boring" ;
    Stink = regVerb "stink" ;
    Eat = regVerb "eat" ** {c = []} ;
    Love = regVerb "love" ** {c = []} ;
    Talk = regVerb "talk" ** {c = "about"} ;
}

