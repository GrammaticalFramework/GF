--# -path=.:resource:prelude

concrete TestIta of Test = GrammarIta ** open Prelude, MorphoIta in {

  lin
    wine_N = regNoun "vino" ;
    cheese_N = regNoun "formaggio" ;
    fish_N = regNoun "pesce" ;
    pizza_N = regNoun "pizza" ;
    waiter_N = regNoun "cameriere" ;
    customer_N = regNoun "cliente" ;
    fresh_A = regAdjective "fresco" ;
    warm_A = regAdjective "caldo" ;
    italian_A = regAdjective "italiano" ;
    expensive_A = regAdjective "caro" ;
    delicious_A = regAdjective "delizioso" ;
    boring_A = regAdjective "noioso" ;
    stink_V = regVerb "puzzare" ;
    eat_V2 = regVerb "mangiare" ** {c = []} ;
    love_V2 = regVerb "amare" ** {c = []} ;
    talk_V2 = regVerb "parlare" ** {c = "di"} ;
}

