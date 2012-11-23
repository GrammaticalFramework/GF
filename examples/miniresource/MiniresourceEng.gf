concrete MiniresourceEng of Miniresource = open Prelude in {

-- module GrammarEng

  lincat  
    S  = {s : Str} ;
    Cl = {s : ClForm => TTense => Bool => Str} ; 
    NP = NounPhrase ;  
      -- {s : Case => Str ; a : Agr} ; 
    VP = VerbPhrase ;  
      -- {v : AgrVerb ; compl : Str} ;
    AP = {s : Str} ;
    CN = Noun ;           -- {s : Number => Str} ;
    Det = {s : Str ; n : Number} ;
    N = Noun ;            -- {s : Number => Str} ;
    A = Adj ;             -- {s : Str} ;
    V = Verb ;            -- {s : VForm => Str} ;
    V2 = Verb ** {c : Str} ;
    AdA = {s : Str} ;
    Tense = {s : Str ; t : TTense} ;
    Pol = {s : Str ; b : Bool} ;
    Conj = {s : Str ; n : Number} ;
  lin
    UseCl t p cl = {s = t.s ++ p.s ++ cl.s ! ClDir ! t.t ! p.b} ; 
    PredVP np vp = {
      s = \\d,t,b => 
        let 
          vps = vp.verb.s ! d ! t ! b ! np.a 
        in case d of {
          ClDir => np.s ! Nom ++ vps.fin ++ vps.inf ++ vp.compl ;
          ClInv => vps.fin ++ np.s ! Nom ++ vps.inf ++ vp.compl
          }
      } ;

    ComplV2 v2 np = {
      verb = agrV v2 ; 
      compl = v2.c ++ np.s ! Acc
      } ;

    UseV v = {
      verb = agrV v ; 
      compl = []
      } ;

    DetCN det cn = {
      s = \\_ => det.s ++ cn.s ! det.n ;
      a = Ag det.n Per3
      } ;

    ModCN ap cn = {
      s = \\n => ap.s ++ cn.s ! n
      } ;

    CompAP ap = {
      verb = copula ;
      compl = ap.s 
      } ;

    AdAP ada ap = {
      s = ada.s ++ ap.s
      } ;

    ConjS  co x y = {s = x.s ++ co.s ++ y.s} ;

    ConjNP co nx ny = {
      s = \\c => nx.s ! c ++ co.s ++ ny.s ! c ;
      a = conjAgr co.n nx.a ny.a
      } ;

    UseN n = n ;

    UseA adj = adj ;

    a_Det = mkDet (pre {#vowel => "an" ; _ => "a"}) Sg ;

    every_Det = mkDet "every" Sg ;

    the_Det = mkDet "the" Sg ;
    this_Det = mkDet "this" Sg ;
    these_Det = mkDet "these" Pl ;
    that_Det = mkDet "that" Sg ;
    those_Det = mkDet "those" Pl ;

    i_NP = pronNP "I" "me" Sg Per1 ;
    youSg_NP = pronNP "you" "you" Sg Per2 ;
    he_NP = pronNP "he" "him" Sg Per3 ;
    she_NP = pronNP "she" "her" Sg Per3 ;
    we_NP = pronNP "we" "us" Pl Per1 ;
    youPl_NP = pronNP "you" "you" Pl Per2 ;
    they_NP = pronNP "they" "them" Pl Per3 ;

    very_AdA = ss "very" ;

    Pos  = {s = [] ; b = True} ;
    Neg  = {s = [] ; b = False} ;
    Pres = {s = [] ; t = TPres} ;
    Perf = {s = [] ; t = TPerf} ;

    and_Conj = {s = "and" ; n = Pl} ;
    or_Conj  = {s = "or" ; n = Sg} ;

-- module TestEng

    man_N = mkN "man" "men" ;
    woman_N = mkN "woman" "women" ;
    house_N = mkN "house" ;
    tree_N = mkN "tree" ;
    big_A = mkA "big" ;
    small_A = mkA "small" ;
    green_A = mkA "green" ;
    walk_V = mkV "walk" ;
    arrive_V = mkV "arrive" ;
    love_V2 = mkV2 "love" ;
    please_V2 = mkV2 "please" ;

-- module ResEng

param
    Number = Sg | Pl ;
    Case   = Nom | Acc ;
    Agr    = Ag Number Person ;
    TTense = TPres | TPerf ;
    Person = Per1 | Per2 | Per3 ;
    VForm  = VInf | VPres | VPast | VPart ;

    ClForm = ClDir | ClInv ;

oper
    VerbPhrase = {
      verb  : AgrVerb ; 
      compl : Str
      } ;

    NounPhrase = {
      s : Case => Str ;
      a : Agr
      } ; 

-- verb as in VP, including copula

    AgrVerb : Type = {
      s : ClForm => TTense => Bool => Agr => {fin,inf : Str} ;
      inf : Str
      } ;

  copula : AgrVerb = {
    s = \\d,t,p,a => case <t,a> of {
       <TPres,Ag Sg Per1> => {fin = "am"   ; inf = neg p} ;
       <TPres,Ag Sg Per3> => {fin = "is"   ; inf = neg p} ;
       <TPres,_         > => {fin = "are"  ; inf = neg p} ;
       <TPerf,Ag Sg Per3> => {fin = "has"  ; inf = neg p ++ "been"} ;
       <TPerf,_         > => {fin = "have" ; inf = neg p ++ "been"} 
       } ;
    inf = "be"
    } ;

  agrV : Verb -> AgrVerb = \v -> 
    let 
      vinf  = v.s ! VInf ; 
      vpart = v.s ! VPart
    in {
    s = \\d,t,p,a => case <d,t,p,a> of {
       <ClDir,TPres,True, Ag Sg Per3> => {fin = v.s ! VPres ; inf = []} ;
       <_,    TPres,_,    Ag Sg Per3> => {fin = "does"      ; inf = neg p ++ vinf} ;
       <ClDir,TPres,True, _         > => {fin = vinf        ; inf = []} ;
       <_,    TPres,_,    _         > => {fin = "do"        ; inf = neg p ++ vinf} ;
       <_,    TPerf,_,    Ag Sg Per3> => {fin = "has"       ; inf = neg p ++ vpart} ;
       <_,    TPerf,_,    _         > => {fin = "have"      ; inf = neg p ++ vpart}
       } ;
    inf = vinf
    } ;

    neg : Bool -> Str = \b -> case b of {True => [] ; False => "not"} ;

-- for coordination

    conjAgr : Number -> Agr -> Agr -> Agr = \n,xa,ya -> 
      case <xa,ya> of {
        <Ag xn xp, Ag yn yp> => 
          Ag (conjNumber (conjNumber xn yn) n) (conjPerson xp yp)
        } ;

    conjNumber : Number -> Number -> Number = \m,n ->
      case m of {Pl => Pl ; _ => n} ;

    conjPerson : Person -> Person -> Person = \p,q ->
      case <p,q> of {
        <Per1,_> | <_,Per1> => Per1 ;
        <Per2,_> | <_,Per2> => Per2 ;
        _                   => Per3
        } ;

    Noun : Type = {s : Number => Str} ;
    Adj  : Type = {s : Str} ;
    Verb : Type = {s : VForm => Str} ;

    mkNoun : Str -> Str -> Noun = \man,men -> {
      s = table {Sg => man ; Pl => men}
      } ;

    regNoun : Str -> Noun = \s -> 
      mkNoun s (s + "s") ; ----

    mkAdj : Str -> Adj = \s -> ss s ;

    mkVerb : (_,_,_,_ : Str) -> Verb = 
      \go,goes,went,gone -> {
      s = table {
            VInf  => go ;
            VPres => goes ;
            VPast => went ;
            VPart => gone
            }
      } ;

    regVerb : Str -> Verb = \v -> case v of {
      _ + "e" => mkVerb v (v + "s") (v + "d") (v + "d") ;
      _       => mkVerb v (v + "s") (v + "ed") (v + "ed")
      } ;

    mkDet : Str -> Number -> {s : Str ; n : Number} = \s,n -> {
      s = s ;
      n = n
      } ;

    pronNP : (s,a : Str) -> Number -> Person -> NounPhrase = 
    \s,a,n,p -> {
      s = table {
        Nom => s ;
        Acc => a
        } ;
      a = Ag n p
      } ;

    vowel    : pattern Str = #("a" | "e" | "i" | "o") ;

-- module ParadigmsEng

oper
  mkN = overload {
    mkN : (dog : Str) -> N 
      = \n -> lin N (regNoun n) ;
    mkN : (man, men : Str) -> N 
      = \s,p -> lin N (mkNoun s p) ;
    } ;

  mkA = overload {
    mkA : (small : Str) -> A 
      = \a -> lin A (mkAdj a) ;
    } ;

  mkV = overload {
    mkV : (walk : Str) -> V 
      = \v -> lin V (regVerb v) ;
    mkV : (go,goes,went,gone : Str) -> V 
      = \p1,p2,p3,p4 -> lin V (mkVerb p1 p2 p3 p4) ;
    } ;

  mkV2 = overload {
    mkV2 : Str -> V2
      = \s -> lin V2 (regVerb s ** {c = []}) ;
    mkV2 : V -> V2
      = \v -> lin V2 (v ** {c = []}) ;
    mkV2 : V -> Str -> V2
      = \v,p -> lin V2 (v ** {c = p}) ;
    } ;

}
