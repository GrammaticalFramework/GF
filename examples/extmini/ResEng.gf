resource ResEng = open Prelude in {

-- parameters

param
  Number = Sg | Pl ;
  Case   = Nom | Acc ;
  Agr    = Ag Number Person ;
  TTense = TPres | TPerf | TPast | TFut ;
  Person = Per1 | Per2 | Per3 ;

  VForm = VInf | VPres | VPast | VPart ;

  ClForm = ClDir | ClInv ;
  QForm = QDir | QIndir ;

-- parts of speech

oper
  VP = {
    verb  : AgrVerb ; 
    compl : Str
    } ;

  NP = {
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
       <TPerf,_         > => {fin = "have" ; inf = neg p ++ "been"} ;
       <TPast,Ag Sg (Per1 | Per3)> => {fin = "was"  ; inf = neg p} ;
       <TPast,_         > => {fin = "were" ; inf = neg p} ;
       <TFut, _         > => {fin = "will" ; inf = neg p ++ "be"}
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
       <_,    TPerf,_,    _         > => {fin = "have"      ; inf = neg p ++ vpart} ;
       <ClDir,TPast,True, _         > => {fin = v.s ! VPast ; inf = []} ;
       <_,    TPast,_,    _         > => {fin = "did"       ; inf = neg p ++ vinf} ;
       <_,    TFut, _,    _         > => {fin = "will"      ; inf = neg p ++ vinf}
       } ;
    inf = vinf
    } ;

  agrAux : (_,_,_,_ : Str) -> AgrVerb = \can,could,beenableto, beableto -> {
    s = \\d,t,p,a => case <t,a> of {
       <TPres,_         > => {fin = can    ; inf = neg p} ;
       <TPerf,Ag Sg Per3> => {fin = "has"  ; inf = neg p ++ beenableto} ;
       <TPerf,_         > => {fin = "have" ; inf = neg p ++ beenableto} ;
       <TPast,_         > => {fin = could  ; inf = neg p} ;
       <TFut, _         > => {fin = "will" ; inf = neg p ++ beableto} 
       } ;
    inf = beableto
    } ;

  infVP : VP -> Str = \vp -> 
    vp.verb.inf ++ vp.compl ;

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



-- for morphology

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

-- for structural words

  mkDet : Str -> Number -> {s : Str ; n : Number} = \s,n -> {
    s = s ;
    n = n
    } ;

  pronNP : (s,a : Str) -> Number -> Person -> NP = 
  \s,a,n,p -> {
    s = table {
      Nom => s ;
      Acc => a
      } ;
    a = Ag n p
    } ;

-- phonological auxiliaries

  vowel    : pattern Str = #("a" | "e" | "i" | "o") ;

}
