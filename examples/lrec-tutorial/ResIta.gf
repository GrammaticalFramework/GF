resource ResIta = open Prelude in {

-- parameters

param
  Number = Sg | Pl ;
  Gender = Masc | Fem ;
  Case = Nom | Acc | Dat ;
  Agr = Ag Gender Number Person ;
  Aux = Avere | Essere ;
  Tense = Pres | Perf ;
  Person = Per1 | Per2 | Per3 ;

  VForm = VInf | VPres Number Person | VPart Gender Number ;

-- parts of speech

oper
  VP = {v : Verb ; clit : Str ; obj : Str} ;
  NP = {s : Case => {clit,obj : Str} ; a : Agr} ; 

-- auxiliaries

  prepCase : Case -> Str = \c -> case c of {
    Dat => "a" ;
    _ => []
    } ;

  adjDet : Adj -> Number -> {s : Gender => Case => Str ; n : Number} = \adj,n -> {
    s = \\g,c => prepCase c ++ adj.s ! g ! n ;
    n = n
    } ;

  pronNP : (s,a,d : Str) -> Gender -> Number -> Person -> NP = \s,a,d,g,n,p -> {
    s = table {
      Nom => {clit = [] ; obj = s} ;
      Acc => {clit = a  ; obj = []} ;
      Dat => {clit = d  ; obj = []}
      } ;
    a = Ag g n p
    } ;

-- predication

  agrV : Verb -> Agr -> Str = \v,a -> case a of {
    Ag _ n p => v.s ! VPres n p
    } ;

  auxVerb : Aux -> Verb = \a -> case a of {
    Avere => mkVerb "avere" "ho" "hai" "ha" "abbiamo" "avete" "hanno" "avuto" Avere ;
    Essere => mkVerb "essere" "sono" "sei" "è" "siamo" "siete" "sono" "stato" Essere
    } ;

  agrPart : Verb -> Agr -> Str = \v,a -> case v.aux of {
    Avere  => v.s ! VPart Masc Sg ;
    Essere => case a of {
      Ag g n _ => v.s ! VPart g n
      }
    } ;

  neg : Bool -> Str = \b -> case b of {True => [] ; False => "non"} ;

--------------------------------------------------------
-- morphology

  Noun : Type = {s : Number => Str ; g : Gender} ;
  Adj  : Type = {s : Gender => Number => Str ; isPre : Bool} ;
  Verb : Type = {s : VForm => Str ; aux : Aux} ;

  mkNoun : Str -> Str -> Gender -> Noun = \vino,vini,g -> {
    s = table {Sg => vino ; Pl => vini} ;
    g = g
    } ;

  regNoun : Str -> Noun = \vino -> case vino of {
    fuo + c@("c"|"g") + "o" => mkNoun vino (fuo + c + "hi") Masc ;
    ol  + "io" => mkNoun vino (ol + "i") Masc ;
    vin + "o" => mkNoun vino (vin + "i") Masc ;
    cas + "a" => mkNoun vino (cas + "e") Fem ;
    pan + "e" => mkNoun vino (pan + "i") Masc ;
    _ => mkNoun vino vino Masc 
    } ;

  mkN = overload {
    mkN : (vino : Str) -> Noun = regNoun ;
    mkN : (uomo, uomini : Str) -> Gender -> Noun = mkNoun ;
    } ;

  mkAdj : (_,_,_,_ : Str) -> Bool -> Adj = \buono,buona,buoni,buone,p -> {
    s = table {
          Masc => table {Sg => buono ; Pl => buoni} ;
          Fem  => table {Sg => buona ; Pl => buone}
        } ;
    isPre = p
    } ;

  regAdj : Str -> Adj = \nero -> case nero of {
    ner + "o"  => mkAdj nero (ner + "a") (ner + "i") (ner + "e") False ;
    verd + "e" => mkAdj nero nero (verd + "i") (verd + "i") False ;
    _ => mkAdj nero nero nero nero False
    } ;

  mkA = overload {
    mkA : (nero : Str) -> Adj = regAdj ;
    mkN : (buono,buona,buoni,buone : Str) -> Bool -> Adj = mkAdj ;
    } ;

  preA : Adj -> Adj = \a -> {s = a.s ; isPre = True} ;
  
  mkVerb : (_,_,_,_,_,_,_,_ : Str) -> Aux -> Verb = 
    \amare,amo,ami,ama,amiamo,amate,amano,amato,aux -> {
    s = table {
          VInf          => amare ;
          VPres Sg Per1 => amo ;
          VPres Sg Per2 => ami ;
          VPres Sg Per3 => ama ;
          VPres Pl Per1 => amiamo ;
          VPres Pl Per2 => amate ;
          VPres Pl Per3 => amano ;
          VPart g n     => (regAdj amato).s ! g ! n
          } ;
    aux = aux
    } ;

  regVerb : Str -> Verb = \amare -> case amare of {
    am  + "are" => mkVerb amare (am+"o") (am+"i") (am+"a") 
                          (am+"iamo") (am+"ate") (am+"ano") (am+"ato") Avere ;
    tem + "ere" => mkVerb amare (tem+"o") (tem+"i") (tem+"e") 
                          (tem+"iamo") (tem+"ete") (tem+"ono") (tem+"uto") Avere ;
    fin + "ire" => mkVerb amare (fin+"isco") (fin+"isci") (fin+"isce") 
                          (fin+"iamo") (fin+"ite") (fin+"iscono") (fin+"ito") Avere
    } ; 

  mkV = overload {
    mkV : (finire : Str) -> Verb = regVerb ;
    mkV : (andare,vado,vadi,va,andiamo,andate,vanno,andato : Str) -> 
             Aux -> Verb = mkVerb ;
    } ;

  essereV : Verb -> Verb = \v -> {s = v.s ; aux = Essere} ;
  
  Verb2 = Verb ** {c : Case} ;

  mkV2 = overload {
    mkV2 : (amare : Str) -> Verb2 = \v -> regVerb v ** {c = Acc} ; 
    mkV2 : (amare : Verb) -> Case -> Verb2 = \v,p -> v ** {c = p} ;
    } ;

-- phonological auxiliaries

    vowel    : Strs = strs {"a" ; "e" ; "i" ; "o" ; "u" ; "h"} ;
    s_impuro : Strs = strs {"z" ; "sb" ; "sc" ; "sd" ; "sf" ; "sp"} ; --- ...

}
