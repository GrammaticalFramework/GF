concrete MiniresourceIta of Miniresource = open Prelude in {

-- module GrammarIta

  flags coding = utf8 ;

  lincat  
    S  = {s : Str} ;
    Cl = {s : TTense => Bool => Str} ; 
    NP = NounPhrase ;  
      -- {s : Case => {clit,obj : Str ; isClit : Bool} ; a : Agr} ; 
    VP = VerbPhrase ;  
      -- {v : Verb ; clit : Str ; clitAgr : ClitAgr ; obj : Agr => Str} ;
    AP = {s : Gender => Number => Str ; isPre : Bool} ;
    CN = Noun ;           -- {s : Number => Str ; g : Gender} ;
    Det = {s : Gender => Case => Str ; n : Number} ;
    N = Noun ;            -- {s : Number => Str ; g : Gender} ;
    A = Adj ;             -- {s : Gender => Number => Str ; isPre : Bool} ;
    V = Verb ;            -- {s : VForm => Str ; aux : Aux} ;
    V2 = Verb ** {c : Case} ;
    AdA = {s : Str} ;
    Pol = {s : Str ; b : Bool} ;
    Tense = {s : Str ; t : TTense} ;
    Conj = {s : Str ; n : Number} ;
  lin
    UseCl t p cl = {s = t.s ++ p.s ++ cl.s ! t.t ! p.b} ; 
    PredVP np vp = 
      let 
        subj = (np.s ! Nom).obj ;
        obj  = vp.obj ! np.a ;
        clit = vp.clit ;
        verb = table {
          TPres => agrV vp.v np.a ;
          TPerf => agrV (auxVerb vp.v.aux) np.a ++ agrPart vp.v np.a vp.clitAgr
          }
      in {
        s = \\t,b => subj ++ neg b ++ clit ++ verb ! t ++ obj
      } ;

    ComplV2 v2 np = 
      let
        nps = np.s ! v2.c
      in {
        v = v2 ; 
        clit = nps.clit ; 
        clitAgr = case <nps.isClit,v2.c> of {
          <True,Acc> => CAgr np.a ;
          _ => CAgrNo
          } ;
        obj  = \\_ => nps.obj
        } ;

    UseV v = {
      v = v ; 
      clit = [] ; 
      clitAgr = CAgrNo ;
      obj = \\_ => []
      } ;

    DetCN det cn = {
      s = \\c => {
        obj = det.s ! cn.g ! c ++ cn.s ! det.n ; 
        clit = [] ; 
        isClit = False
        } ;
      a = Ag cn.g det.n Per3
      } ;

    ModCN ap cn = {
      s = \\n => preOrPost ap.isPre (ap.s ! cn.g ! n) (cn.s ! n) ;
      g = cn.g
      } ;

    CompAP ap = {
      v = essere_V ; 
      clit = [] ; 
      clitAgr = CAgrNo ;
      obj = \\ag => case ag of {
        Ag g n _ => ap.s ! g ! n
        }
      } ;

    AdAP ada ap = {
      s = \\g,n => ada.s ++ ap.s ! g ! n ;
      isPre = ap.isPre ;
      } ;

--- known issue: this comes out wrong for pronouns
    ConjNP co nx ny = {
      s = \\c => {
        obj = (nx.s ! c).clit ++ (nx.s ! c).obj ++ co.s ++ (ny.s ! c).clit ++ (ny.s ! c).obj ; 
        clit = [] ; 
        isClit = False
        } ;
      a = conjAgr co.n nx.a ny.a
      } ;

    ConjS co x y = {s = x.s ++ co.s ++ y.s} ;

    UseN n = n ;

    UseA adj = adj ;

    a_Det = adjDet (mkAdj "un" "una" [] [] True) Sg ;

    every_Det = adjDet (regAdj "ogni") Sg ;

    the_Det = {
      s = table {
        Masc => table {
          Nom | Acc => elisForms "lo" "l'" "il" ;
          Dat => elisForms "allo" "all'" "al"
          } ;
        Fem => table {
          Nom | Acc => elisForms "la" "'l" "la" ;
          Dat => elisForms "alla" "all'" "alla"
          }
        } ;
      n = Sg
      } ;
        
    this_Det = adjDet (regAdj "questo") Sg ;
    these_Det = adjDet (regAdj "questo") Pl ;
    that_Det = adjDet quello_A Sg ;
    those_Det = adjDet quello_A Pl ;

    i_NP     = pronNP "io"  "mi" "mi" Masc Sg Per1 ;
    youSg_NP = pronNP "tu"  "ti" "ti" Masc Sg Per2 ;
    he_NP    = pronNP "lui" "lo" "gli" Masc  Sg Per3 ;
    she_NP   = pronNP "lei" "la" "le" Fem  Sg Per3 ;
    we_NP    = pronNP "noi" "ci" "ci" Masc Pl Per1 ;
    youPl_NP = pronNP "voi" "vi" "vi" Masc Pl Per2 ;
    they_NP  = pronNP "loro" "li" "glie" Masc Pl Per3 ;

    very_AdA = ss "molto" ;

    Pos  = {s = [] ; b = True} ;
    Neg  = {s = [] ; b = False} ;
    Pres = {s = [] ; t = TPres} ;
    Perf = {s = [] ; t = TPerf} ;

    and_Conj = {s = "e" ; n = Pl} ;
    or_Conj  = {s = "o" ; n = Sg} ;

  oper
    quello_A : Adj = mkAdj 
      (elisForms "quello" "quell'" "quel") "quella"
      (elisForms "quegli" "quegli" "quei") "quelle"
      True ;

-- module TestIta

lin
  man_N = mkN "uomo" "uomini" masculine ;
  woman_N = mkN "donna" ;
  house_N = mkN "casa" ;
  tree_N = mkN "albero" ;
  big_A = preA (mkA "grande") ;
  small_A = preA (mkA "piccolo") ;
  green_A = mkA "verde" ;
  walk_V = mkV "camminare" ;
  arrive_V = essereV (mkV "arrivare") ;
  love_V2 = mkV2 "amare" ;
  please_V2 = mkV2 (essereV (mkV "piacere" "piaccio" "piaci" "piace" 
                        "piacciamo" "piacete" "piacciono" "piaciuto")) dative ;


-- module ResIta

-- parameters

param
  Number = Sg | Pl ;
  Gender = Masc | Fem ;
  Case   = Nom | Acc | Dat ;
  Agr    = Ag Gender Number Person ;
  Aux    = Avere | Essere ;
  TTense  = TPres | TPerf ;
  Person = Per1 | Per2 | Per3 ;

  VForm = VInf | VPres Number Person | VPart Gender Number ;

  ClitAgr = CAgrNo | CAgr Agr ;

-- parts of speech

oper
  VerbPhrase = {
    v : Verb ; 
    clit : Str ; 
    clitAgr : ClitAgr ; 
    obj : Agr => Str
    } ;
  NounPhrase = {
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

  pronNP : (s,a,d : Str) -> Gender -> Number -> Person -> NounPhrase = 
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

-- module ParadigmsIta

oper
  masculine : Gender = Masc ;
  feminine : Gender = Fem ;

  accusative : Case = Acc ;
  dative : Case = Dat ;

  mkN = overload {
    mkN : (vino : Str) -> N 
      = \n -> lin N (regNoun n) ;
    mkN : (uomo, uomini : Str) -> Gender -> N 
      = \s,p,g -> lin N (mkNoun s p g) ;
    } ;

  mkA = overload {
    mkA : (nero : Str) -> A 
      = \a -> lin A (regAdj a) ;
    mkA : (buono,buona,buoni,buone : Str) -> Bool -> A 
      = \sm,sf,pm,pf,p -> lin A (mkAdj sm sf pm pf False) ;
    } ;

  preA : A -> A
      = \a -> lin A {s = a.s ; isPre = True} ;

  mkV = overload {
    mkV : (finire : Str) -> V 
      = \v -> lin V (regVerb v) ;
    mkV : (andare,vado,vadi,va,andiamo,andate,vanno,andato : Str) -> V 
      = \i,p1,p2,p3,p4,p5,p6,p -> lin V (mkVerb i p1 p2 p3 p4 p5 p6 p Avere) ;
    } ;

  essereV : V -> V
    = \v -> lin V {s = v.s ; aux = Essere} ;

  mkV2 = overload {
    mkV2 : Str -> V2
      = \s -> lin V2 (regVerb s ** {c = accusative}) ;
    mkV2 : V -> V2
      = \v -> lin V2 (v ** {c = accusative}) ;
    mkV2 : V -> Case -> V2
      = \v,c -> lin V2 (v ** {c = c}) ;
    } ;


}
