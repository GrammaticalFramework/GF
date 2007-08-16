--# -path=.:resource:prelude

concrete TestIta of Test = SyntaxIta ** open Prelude, MorphoIta in {

  lin
    Wine = regNoun "vino" ;
    Cheese = regNoun "formaggio" ;
    Fish = regNoun "pesce" ;
    Pizza = regNoun "pizza" ;
    Waiter = regNoun "cameriere" ;
    Customer = regNoun "cliente" ;
    Fresh = regAdjective "fresco" ;
    Warm = regAdjective "caldo" ;
    Italian = regAdjective "italiano" ;
    Expensive = regAdjective "caro" ;
    Delicious = regAdjective "delizioso" ;
    Boring = regAdjective "noioso" ;
    Stink = regVerb "puzzare" ;
    Eat = regVerb "mangiare" ** {c = []} ;
    Love = regVerb "amare" ** {c = []} ;
    Talk = regVerb "parlare" ** {c = "di"} ;
}

