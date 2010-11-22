concrete FoodsIta of Foods = open ResIta in {
  lincat
    Comment = {s : Str} ; 
    Quality = Adjective ; 
    Kind = Noun ; 
    Item = NounPhrase ;
  lin
    Pred item quality = 
      {s = item.s ++ copula ! item.n ++ 
           quality.s ! item.g ! item.n} ;
    This  = det Sg "questo" "questa" ;
    That  = det Sg "quel"   "quella" ;
    These = det Pl "questi" "queste" ;
    Those = det Pl "quei"   "quelle" ;
    Mod quality kind = {
      s = \\n => kind.s ! n ++ quality.s ! kind.g ! n ;
      g = kind.g
      } ;
    Wine = noun "vino" "vini" Masc ;
    Cheese = noun "formaggio" "formaggi" Masc ;
    Fish = noun "pesce" "pesci" Masc ;
    Pizza = noun "pizza" "pizze" Fem ;
    Very qual = {s = \\g,n => "molto" ++ qual.s ! g ! n} ;
    Fresh = 
      adjective "fresco" "fresca" "freschi" "fresche" ;
    Warm = regAdj "caldo" ;
    Italian = regAdj "italiano" ;
    Expensive = regAdj "caro" ;
    Delicious = regAdj "delizioso" ;
    Boring = regAdj "noioso" ;
}

