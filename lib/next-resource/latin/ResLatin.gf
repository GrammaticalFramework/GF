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
      rege : Str = case rex of {
        _ + "e" => reg + "i" ;
        _ + ("al" | "ar") => rex + "i" ;
        _ => reg + "e"
        } ;
      regemes : Str * Str = case g of {
        Neutr => <rex,reg + "a"> ;
        _     => <reg + "em", reg + "es">
        } ;
    in
    mkNoun
      rex regemes.p1 (reg + "is") (reg + "i") rege rex
      regemes.p2 regemes.p2 (reg + "um") (reg + "ibus") 
      g ;


  noun3 : Str -> Noun = \labor -> 
    case labor of {
      _    + "r"   => noun3c labor (labor + "is")    Masc ;
      fl   + "os"  => noun3c labor (fl    + "oris")  Masc ;
      lim  + "es"  => noun3c labor (lim   + "itis")  Masc ;
      cod  + "ex"  => noun3c labor (cod   + "icis")  Masc ;
      poem + "a"   => noun3c labor (poem  + "atis")  Neutr ;
      calc + "ar"  => noun3c labor (calc  + "aris")  Neutr ;
      mar  + "e"   => noun3c labor (mar   + "is")    Neutr ;
      car  + "men" => noun3c labor (car   + "minis") Neutr ;
      rob  + "ur"  => noun3c labor (rob   + "oris")  Neutr ;
      temp + "us"  => noun3c labor (temp  + "oris")  Neutr ;
      vers + "io"  => noun3c labor (vers  + "ionis") Fem ;
      imag + "o"   => noun3c labor (imag  + "inis")  Fem ;
      ae   + "tas" => noun3c labor (ae    + "tatis") Fem ;
      vo   + "x"   => noun3c labor (vo    + "cis")   Fem ;
      pa   + "rs"  => noun3c labor (pa    + "rtis")  Fem ;
      cut  + "is"  => noun3c labor (cut   + "is")    Fem ;
      urb  + "s"   => noun3c labor (urb   + "is")    Fem ;
      _  => Predef.error ("noun3 does not apply to" ++ labor)
      } ;

  noun4us : Str -> Noun = \fructus -> 
    let
      fructu = init fructus ;
      fruct  = init fructu
    in
    mkNoun
      fructus (fructu + "m") fructus (fructu + "i") fructu fructus
      fructus fructus (fructu + "um") (fruct + "ibus")
      Masc ;

  noun4u : Str -> Noun = \cornu -> 
    let
      corn = init cornu ;
      cornua = cornu + "a"
    in
    mkNoun
      cornu cornu (cornu + "s") (cornu + "i") cornu cornu
      cornua cornua (cornu + "um") (corn + "ibus")
      Neutr ;

  noun5 : Str -> Noun = \res -> 
    let
      re = init res ;
      rei = re + "i"
    in
    mkNoun
      res (re+ "m") rei rei re res
      res res (re + "rum") (re + "bus")
      Fem ;

-- to change the default gender

    nounWithGen : Gender -> Noun -> Noun = \g,n ->
      {s = n.s ; g = g} ;

-- smart paradigms

  noun_ngg : Str -> Str -> Gender -> Noun = \verbum,verbi,g -> 
    let s : Noun = case <verbum,verbi> of {
      <_ + "a",  _ + "ae"> => noun1 verbum ;
      <_ + "us", _ + "i">  => noun2us verbum ;
      <_ + "um", _ + "i">  => noun2um verbum ;
      <_ + "er", _ + "i">  => noun2er verbum ;
      <_ + "us", _ + "us"> => noun4us verbum ;
      <_ + "u",  _ + "us"> => noun4u verbum ;
      <_ + "es", _ + "ei"> => noun5 verbum ;
      _  => noun3c verbum verbi g
      }
    in  
    nounWithGen g s ;

  noun : Str -> Noun = \verbum -> 
    case verbum of {
      _ + "a"  => noun1 verbum ;
      _ + "us" => noun2us verbum ;
      _ + "um" => noun2um verbum ;
      _ + "er" => noun2er verbum ;
      _ + "u"  => noun4u verbum ;
      _ + "es" => noun5 verbum ;
      _  => noun3 verbum
      } ;



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
