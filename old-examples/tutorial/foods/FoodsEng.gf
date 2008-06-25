--# -path=.:prelude

concrete FoodsEng of Foods = open Prelude in {

  lincat
    Phrase, Quality = SS ; 
    Kind = {s : Number => Str} ; 
    Item = {s : Str ; n : Number} ; 

  lin
    Is item quality = ss (item.s ++ copula ! item.n ++ quality.s) ;
    This  = det Sg "this" ;
    That  = det Sg "that" ;
    These = det Pl "these" ;
    Those = det Pl "those" ;
    QKind quality kind = {s = \\n => quality.s ++ kind.s ! n} ;
    Wine = regNoun "wine" ;
    Cheese = regNoun "cheese" ;
    Fish = noun "fish" "fish" ;
    Pizza = regNoun "pizza" ;
    Very = prefixSS "very" ;
    Fresh = ss "fresh" ;
    Warm = ss "warm" ;
    Italian = ss "Italian" ;
    Expensive = ss "expensive" ;
    Delicious = ss "delicious" ;
    Boring = ss "boring" ;

  param
    Number = Sg | Pl ;

  oper
    det : Number -> Str -> {s : Number => Str} -> {s : Str ; n : Number} = 
      \n,d,cn -> {
        s = d ++ cn.s ! n ;
        n = n
      } ;
    noun : Str -> Str -> {s : Number => Str} = 
      \man,men -> {s = table {
        Sg => man ;
        Pl => men 
        }
      } ;
    regNoun : Str -> {s : Number => Str} = 
      \car -> noun car (car + "s") ;
    copula : Number => Str = 
      table {
        Sg => "is" ;
        Pl => "are"
        } ;
}
    
