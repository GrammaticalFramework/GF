concrete MiniresourceSan of Miniresource = open Prelude in {

-- module GrammarSan

  flags coding = utf8;

  lincat
    S  = {s : Str} ; 
    Cl = {s : Bool => Str} ; 
    NP = NounPhrase ;  
    VP = VerbPhrase ;  
    AP = Adj ;
    CN = Noun ;
    Det = {s : Gender => Case => Str ; n : Number} ;
    N = Noun ; 
    A = Adj ;
    V = Verb;
    V2 = Verb ** {c : Case} ;
    AdA = {s : Str} ; 
    Pol = {s : Str ; b : Bool} ;
    Tense = {s : Str} ;
    Conj = {s : Str} ;    


  lin

    UseCl t p cl = {s = t.s ++ p.s ++ cl.s ! p.b} ; 

    PredVP np vp = {
       s  = \\p => np.s ! Nom ++ neg p ++ vp.compl ! np.a ++ vp.verb.s ! VPres np.a.n np.a.p
       } ;

    ComplV2 v2 np = {
     verb  = v2 ;
     compl = \\_ => np.s ! v2.c
     } ; 

    UseV v = {
      verb = v ; 
      compl = \\_ => []
      } ; 

    DetCN det cn = {
      s = \\c => det.s ! cn.g ! c ++ cn.s ! det.n ! c ; 
      a = agr cn.g det.n P3
      } ;
      
    ModCN ap cn = {s = \\n,c => ap.s ! cn.g ! n ! c ++ cn.s ! n ! c ; g = cn.g} ;

    CompAP ap = {
      verb = copula ;
      compl = \\a => ap.s ! a.g ! a.n ! Nom 
      } ;

    AdAP ada ap = {
      s = \\g,n,c => ada.s ++ ap.s ! g ! n ! c
      } ;

    ConjNP co x y = {
      s = \\c => x.s ! c ++ co.s ++ y.s ! c ;
      a = y.a ----
      } ;

    ConjS  co x y = {s = x.s ++ co.s ++ y.s} ;  

    UseN n = n ;
    UseA adj = adj ;

    a_Det = mkDet "" Sg ;
    every_Det = mkDet "प्रति" Sg ;        
    the_Det = mkDet "" Sg ;

    this_Det = mkDet "एतद्" Sg ;
--    these_Det = mkDet "这" Pl ;
    that_Det = mkDet "तद्" Sg ;
--    those_Det = mkDet "那" Pl ;

    i_NP = pronNP "" Sg P1 ;
    youSg_NP = pronNP "" Sg P2 ;
    he_NP = pronNP "" Sg P3 ;
    she_NP = pronNP "" Sg P3 ;
    we_NP = pronNP "" Pl P1 ;
    youPl_NP = pronNP "" Pl P2 ;
    they_NP = pronNP "" Pl P3 ;

    very_AdA = ss "अति" ;    
    
    and_Conj = {s = " च"} ;

    or_Conj  = {s = "अथवा"} ;

    Pos  = {s = [] ; b = True} ;
    Neg  = {s = [] ; b = False} ;
    Pres = {s = []} ;
    Perf = {s = []} ;

-- module TestChi

lin
  man_N = mkN "नरः" ;  
  woman_N = mkN "स्त्री" ;
  house_N = mkN "गृहं" ;
  tree_N = mkN "वृक्ष";
  big_A = mkA "महाकाय" ;
  small_A = mkA "अल्प" ;
  green_A = mkA "हरित" ;
  walk_V = mkV "गम्" ;
  arrive_V = mkV "अभि-उपा-गम्" ;
  love_V2 = mkV2 "कम्" ;
  please_V2 = mkV2 "प्री" ;








-- module ResSan

-- parameters

param
    Number = Sg | Dl | Pl ;
    Case = Nom | Acc | Ins | Dat | Abl | Gen | Loc | Voc ;
    Gender = Masc | Fem | Neutr ;
    Person = P3 | P2 | P1 ;


    VForm = VPres Number Person ;

oper
    Agr = {g : Gender ; n : Number ; p : Person} ;

    agr : Gender -> Number -> Person -> Agr = \g,n,p -> {g = g ; n = n ; p = p} ;

-- parts of speech

oper

  VerbPhrase = {verb : Verb ; compl : Agr => Str} ;
  NounPhrase = {s : Case => Str ; a : Agr} ; 

-- for morphology

  Noun : Type = {s : Number => Case => Str; g : Gender} ;
  Adj  : Type = {s : Gender => Number => Case => Str} ;
  Verb : Type = {s : VForm => Str} ;

  mkNoun : (s1,_,_,_,_,_,_,_, _,_,_, _,_,_,_,_,s17 : Str) -> Gender -> Noun = 
    \snom,sacc,sins,sdat,sabl,sgen,sloc,svoc,
     dnomaccvoc,dinsdatabl,dgenloc,
     pnomvoc,pacc,pins,pdatabl,pgen,ploc, 
     gen -> {
      s = table {
        Sg => table {
           Nom => snom ; Acc => sacc ; Ins => sins ; Dat => sdat ; Abl => sabl ; Gen => sgen ; Loc => sloc ; Voc => svoc
           } ;
        Dl => table {
           Nom | Acc | Voc => dnomaccvoc ; Ins | Dat | Abl => dinsdatabl ; Gen | Loc => dgenloc 
           } ;
        Pl => table {
           Nom | Voc => pnomvoc ; Acc => pacc ; Ins => pins ; Dat | Abl => pdatabl ; Gen => pgen ; Loc => ploc
           }
        } ;
      g = gen
      } ;

  endingNoun : Str -> (s1,_,_,_,_,_,_,_, _,_,_, _,_,_,_,_,s17 : Str) -> Gender -> Noun = 
    \stem,
     snom,sacc,sins,sdat,sabl,sgen,sloc,svoc,
     dnomaccvoc,dinsdatabl,dgenloc,
     pnomvoc,pacc,pins,pdatabl,pgen,ploc, 
     gen -> 
       mkNoun
         (stem + snom) (stem + sacc) (stem + sins) (stem + sdat) (stem + sabl) (stem + sgen) (stem + sloc) (stem + svoc) 
         (stem + dnomaccvoc) (stem + dinsdatabl) (stem + dgenloc) 
         (stem + pnomvoc) (stem + pacc) (stem + pins) (stem + pdatabl) (stem + pgen) (stem + ploc) 
         gen ;


  ramaNoun : Str -> Noun = \rama ->
    let ram = init rama in
    endingNoun ram
      "ः" "म्" "ॆणॆ" "ाय" "ात्" "स्य" "ॆ" ""
      "ौ" "ाथ्याम्" "यो" 
      "ाः" "ान्" "ैः" "ेथयः" "ाणाम" "ेषु" 
      Masc ;

  mkAdj : (m,f,n : Noun) -> Adj = \m,f,n -> {s = table {Masc => m.s ; Fem => f.s ; Neutr => n.s}} ; 


  mkVerb : (s1,_,_,_,_,_,_,_,s9 : Str) -> Verb = 
    \s3,s2,s1,d3,d2,d1,p3,p2,p1 -> {
      s = table {
        VPres Sg P3 => s3 ;
        VPres Sg P2 => s2 ;
        VPres Sg P1 => s1 ;
        VPres Dl P3 => d3 ;
        VPres Dl P2 => d2 ;
        VPres Dl P1 => d1 ;
        VPres Pl P3 => p3 ;
        VPres Pl P2 => p2 ;
        VPres Pl P1 => p1
        }
      } ;

  endingVerb : Str -> (s1,_,_,_,_,_,_,_,s9 : Str) -> Verb = 
    \stem,s3,s2,s1,d3,d2,d1,p3,p2,p1 -> 
      mkVerb
        (stem + s3) (stem + s2) (stem + s1) (stem + d3) (stem + d2) (stem + d1) (stem + p3) (stem + p2) (stem + p1) ;

  patVerb : Str -> Verb = \pat ->
    endingVerb pat
      "ित" "िस" "िम" "तः" "थः" "ावः" "िनख़त" "थ" "ामः" ;

  copula : Verb = {s = \\_ => []} ;

  neg : Bool -> Str = \b -> case b of {True => [] ; False => "न"} ;


-- for structural words

  mkDet : Str -> Number -> {s : Gender => Case => Str ; n : Number} = \s,n -> {
    s = \\_,_ => s ;
    n = n
    } ;

  pronNP : (s : Str) -> Number -> Person -> NounPhrase = \s,n,p -> {
    s = \\_ => s ;
    a = agr Masc n p
    } ;
    


-- module ParadigmsSan

oper
  mkN = overload {
    mkN : (man : Str) -> N 
      = \s -> lin N (ramaNoun s) ;
    } ;  
      
  mkA : (small : Str) -> A 
      = \s -> let n = ramaNoun s in lin A (mkAdj n n n) ;
      
  mkV : (walk : Str) -> V 
      = \s -> lin V (patVerb s) ; 

  mkV2 = overload {
    mkV2 : (love : Str) -> V2 
      = \love -> lin V2 (mkV love ** {c = Acc}) ;
---    mkV2 : (love : V) -> V2 
---      = \love -> lin V2 love ;
   } ;

}





