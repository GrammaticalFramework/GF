resource ResIta = open Prelude in {

-- parameters

param
  Number = Sg | Pl ;
  Gender = Masc | Fem ;
  Case   = Nom | Acc | Dat ;
  Agr    = Ag Gender Number Person ;
  Aux    = Avere | Essere ;
  Tense  = Pres | Perf ;
  Person = Per1 | Per2 | Per3 ;

  VForm = VInf | VPres Number Person | VPart Gender Number ;

  ClitAgr = CAgrNo | CAgr Agr ;

-- parts of speech

oper
  VP = {
    v : Verb ; 
    clit : Str ; 
    clitAgr : ClitAgr ; 
    obj : Agr => Str
    } ;
  NP = {
    s : Case => {clit,obj : Str ; isClit : Bool} ; 
    a : Agr
    } ; 

-- the preposition word of an abstract case

  prepCase : Case -> Str = \c -> case c of {
    Dat => "a" ;
    _ => []
    } ;

-- for predication

  agrV : Verb -> Agr -> Str = \v,a -> case a of {
    Ag _ n p => v.s ! VPres n p
    } ;

  auxVerb : Aux -> Verb = \a -> case a of {
    Avere => 
      mkVerb "avere" "ho" "hai" "ha" "abbiamo" "avete" "hanno" "avuto" Avere ;
    Essere => 
      mkVerb "essere" "sono" "sei" "è" "siamo" "siete" "sono" "stato" Essere
    } ;

  agrPart : Verb -> Agr -> ClitAgr -> Str = \v,a,c -> case v.aux of {
    Avere  => case c of {
      CAgr (Ag g n _) => v.s ! VPart g n ;
      _ => v.s ! VPart Masc Sg
      } ;
    Essere => case a of {
      Ag g n _ => v.s ! VPart g n
      }
    } ;

  neg : Bool -> Str = \b -> case b of {True => [] ; False => "non"} ;

  essere_V = auxVerb Essere ;

-- for coordination

  conjAgr : Number -> Agr -> Agr -> Agr = \n,xa,ya -> 
    let 
      x = agrFeatures xa ; y = agrFeatures ya
    in Ag 
      (conjGender x.g y.g) 
      (conjNumber (conjNumber x.n y.n) n)
      (conjPerson x.p y.p) ;

  agrFeatures : Agr -> {g : Gender ; n : Number ; p : Person} = \a -> 
    case a of {Ag g n p => {g = g ; n = n ; p = p}} ;

  conjGender : Gender -> Gender -> Gender = \g,h ->
    case g of {Masc => Masc ; _ => h} ;

  conjNumber : Number -> Number -> Number = \m,n ->
    case m of {Pl => Pl ; _ => n} ;

  conjPerson : Person -> Person -> Person = \p,q ->
    case <p,q> of {
      <Per1,_> | <_,Per1> => Per1 ;
      <Per2,_> | <_,Per2> => Per2 ;
      _                   => Per3
      } ;



-- for morphology

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

-- for structural words

  adjDet : Adj -> Number -> {s : Gender => Case => Str ; n : Number} = 
  \adj,n -> {
    s = \\g,c => prepCase c ++ adj.s ! g ! n ;
    n = n
    } ;

  pronNP : (s,a,d : Str) -> Gender -> Number -> Person -> NP = 
  \s,a,d,g,n,p -> {
    s = table {
      Nom => {clit = [] ; obj = s  ; isClit = False} ;
      Acc => {clit = a  ; obj = [] ; isClit = True} ;
      Dat => {clit = d  ; obj = [] ; isClit = True}
      } ;
    a = Ag g n p
    } ;

-- phonological auxiliaries

  vowel    : pattern Str = #("a" | "e" | "i" | "o" | "u" | "h") ;
  s_impuro : pattern Str = #("z" | "s" + ("b"|"c"|"d"|"f"|"m"|"p"|"q"|"t")) ;

  elisForms : (_,_,_ : Str) -> Str = \lo,l',il ->
    pre {#s_impuro => lo ; #vowel => l' ; _ => il} ;

}
