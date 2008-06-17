--# -path=.:prelude

concrete FoodsIta of Foods = open Prelude in {

  lincat
    Phrase = SS ; 
    Quality = {s : Gender => Number => Str} ; 
    Kind = {s : Number => Str ; g : Gender} ; 
    Item = {s : Str ; g : Gender ; n : Number} ; 

  lin
    Is item quality = 
      ss (item.s ++ copula item.n ++ quality.s ! item.g ! item.n) ;
    This  = det Sg "questo" "questa" ;
    That  = det Sg "quello" "quella" ;
    These = det Pl "questi" "queste" ;
    Those = det Pl "quelli" "quelle" ;
    QKind quality kind = {
      s = \\n => kind.s ! n ++ quality.s ! kind.g ! n ;
      g = kind.g
      } ;
    Wine = noun "vino" "vini" Masc ;
    Cheese = noun "formaggio" "formaggi" Masc ;
    Fish = noun "pesce" "pesci" Masc ;
    Pizza = noun "pizza" "pizze" Fem ;
    Very qual = {s = \\g,n => "molto" ++ qual.s ! g ! n} ;
    Fresh = adjective "fresco" "fresca" "freschi" "fresche" ;
    Warm = regAdj "caldo" ;
    Italian = regAdj "italiano" ;
    Expensive = regAdj "caro" ;
    Delicious = regAdj "delizioso" ;
    Boring = regAdj "noioso" ;

  param
    Number = Sg | Pl ;
    Gender = Masc | Fem ;

  oper
    det : Number -> Str -> Str -> {s : Number => Str ; g : Gender} -> 
        {s : Str ; g : Gender ; n : Number} = 
      \n,m,f,cn -> {
        s = case cn.g of {Masc => m ; Fem => f} ++ cn.s ! n ;
        g = cn.g ;
        n = n
      } ;
    noun : Str -> Str -> Gender -> {s : Number => Str ; g : Gender} = 
      \man,men,g -> {
        s = table {
          Sg => man ;
          Pl => men 
          } ;
        g = g
      } ;
    adjective : (_,_,_,_ : Str) -> {s : Gender => Number => Str} = 
      \nero,nera,neri,nere -> {
        s = table {
          Masc => table {
            Sg => nero ;
            Pl => neri
            } ; 
          Fem => table {
            Sg => nera ;
            Pl => nere
            }
          }
      } ;
    regAdj : Str -> {s : Gender => Number => Str} = \nero ->
      let ner = init nero 
      in adjective nero (ner + "a") (ner + "i") (ner + "e") ;

    copula : Number -> Str = 
      \n -> case n of {
        Sg => "è" ;
        Pl => "sono"
        } ;
}
