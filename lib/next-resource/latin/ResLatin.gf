--# -path=.:common

resource ResLatin = open Prelude in {

param
  Number = Sg | Pl ;
  Gender = Masc | Fem | Neutr ;
  Case = Nom | Acc | Gen | Dat | Abl | Voc ;
  Degree = DPos | DComp | DSup ;

oper
  Noun : Type = {s : Number => Case => Str ; g : Gender} ;
  Adjective : Type = {s : Gender => Number => Case => Str} ;

  -- worst case

  mkNoun : (n1,_,_,_,_,_,_,_,_,n10 : Str) -> Gender -> Noun = 
    \sn,sa,sg,sd,sab,sv,pn,pa,pg,pd, g -> {
    s = table {
      Sg => table {
        Nom => sn ;
        Acc => sa ;
        Gen => sg ;
        Dat => sd ;
        Abl => sab ;
        Voc => sv
        } ;
      Pl => table {
        Nom | Voc => pn ;
        Acc => pa ;
        Gen => pg ;
        Dat | Abl => pd
        }
      } ;
    g = g
    } ;

  -- declensions

  noun1 : Str -> Noun = \mensa ->
    let 
      mensae = mensa + "a" ;
      mensis = init mensa + "is" ;
    in
    mkNoun 
      mensa (mensa +"m") mensae mensae mensa mensa
      mensae (mensa + "s") (mensa + "rum") mensis
      Fem ;

  noun2us : Str -> Noun = \servus ->
    let
      serv = Predef.tk 2 servus ;
      servum = serv + "um" ;
      servi = serv + "i" ;
      servo = serv + "o" ;
    in
    mkNoun 
      servus servum servi servo servo (serv + "e")
      servi (serv + "os") (serv + "orum") (serv + "is")
      Masc ;

  noun2er : Str -> Noun = \puer ->
    let
      puerum = puer + "um" ;
      pueri = puer + "i" ;
      puero = puer + "o" ;
    in
    mkNoun 
      puer puerum pueri puero puero (puer + "e")
      pueri (puer + "os") (puer + "orum") (puer + "is")
      Masc ;

  noun2um : Str -> Noun = \bellum ->
    let
      bell = Predef.tk 2 bellum ;
      belli = bell + "i" ;
      bello = bell + "o" ;
      bella = bell + "a" ;
    in
    mkNoun 
      bellum bellum belli bello bello (bell + "e")
      bella bella (bell + "orum") (bell + "is")
      Neutr ;

-- smart paradigm for declensions 1&2

  noun12 : Str -> Noun = \verbum -> 
    case verbum of {
      _ + "a"  => noun1 verbum ;
      _ + "us" => noun2us verbum ;
      _ + "um" => noun2um verbum ;
      _ + "er" => noun2er verbum ;
      _  => Predef.error ("noun12 does not apply to" ++ verbum)
      } ;

  noun3c : Str -> Str -> Gender -> Noun = \rex,regis,g ->
    let
      reg = Predef.tk 2 regis ;
      regemes : Str * Str = case g of {
        Neutr => <rex,reg + "a"> ;
        _     => <reg + "em", reg + "es">
        } ;
    in
    mkNoun
      rex regemes.p1 (reg + "is") (reg + "i") (reg + "e") rex
      regemes.p2 regemes.p2 (reg + "um") (reg + "ibus") 
      g ;



-- adjectives

  mkAdjective : (_,_,_ : Noun) -> Adjective = \bonus,bona,bonum -> {
    s = table {
      Masc  => bonus.s ;
      Fem   => bona.s ;
      Neutr => bonum.s 
      }
    } ;
    
  adj12 : Str -> Adjective = \bonus ->
    let
      bon : Str = case bonus of {
       pulch + "er" => pulch + "r" ;
       bon + "us" => bon ;
       _ => Predef.error ("adj12 does not apply to" ++ bonus)
       }
    in
    mkAdjective (noun12 bonus) (noun1 (bon + "a")) (noun2um (bon + "um")) ;

}
