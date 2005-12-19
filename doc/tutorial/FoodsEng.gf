--# -path=.:resource:prelude

concrete FoodsEng of Foods = open Prelude, MorphoEng in {

  lincat
    S, Quality = SS ; 
    Kind = {s : Number => Str} ; 
    Item = {s : Str ; n : Number} ; 

  lin
    Is item quality = ss (item.s ++ (mkVerb "are" "is").s ! item.n ++ quality.s) ;
    This  = det Sg "this" ;
    That  = det Sg "that" ;
    These = det Pl "these" ;
    Those = det Pl "those" ;
    QKind quality kind = {s = \\n => quality.s ++ kind.s ! n} ;
    Wine = regNoun "wine" ;
    Cheese = regNoun "cheese" ;
    Fish = mkNoun "fish" "fish" ;
    Pizza = regNoun "pizza" ;
    Very = prefixSS "very" ;
    Fresh = ss "fresh" ;
    Warm = ss "warm" ;
    Italian = ss "Italian" ;
    Expensive = ss "expensive" ;
    Delicious = ss "delicious" ;
    Boring = ss "boring" ;

  oper
    det : Number -> Str -> Noun -> {s : Str ; n : Number} = \n,d,cn -> {
      s = d ++ cn.s ! n ;
      n = n
      } ;

}
    