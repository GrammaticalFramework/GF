resource ParadigmsJpn = CatJpn ** 
  open ResJpn, CatJpn, Prelude in {

flags coding = utf8 ;

param

  VerbGroupP = Gr1P | Gr2P | SuruP | KuruP ;

oper

  mkN = overload {
    mkN : (man : Str) -> N  ---- AR 15/11/2014
      = \n -> lin N (regNoun n Inanim "つ" False True) ;
    mkN : (man : Str) -> (anim : Animateness) -> N 
      = \n,a -> lin N (regNoun n a "つ" False True) ;
    mkN : (kane,okane : Str) -> (anim : Animateness) -> N 
      = \kane,okane,a -> lin N (styleNoun kane okane a "つ" False True) ;
    mkN : (man : Str) -> (anim : Animateness) -> (counter : Str) -> (counterReplace : Bool) -> N 
      = \n,a,c,b -> lin N (regNoun n a c b False) ;
    mkN : (man : Str) -> (anim : Animateness) -> (counter : Str) -> (counterReplace : Bool) -> 
          (men : Str) -> N = \n,a,c,b,pl -> lin N (numberNoun n a c b pl False) ;
    mkN : (kane,okane : Str) -> (anim : Animateness) -> (counter : Str) -> 
          (counterReplace : Bool) -> N 
           = \kane,okane,a,c,b -> lin N (styleNoun kane okane a c b False) ;
    mkN : (tsuma,okusan : Str) -> (anim : Animateness) -> (counter : Str) -> 
          (counterReplace : Bool) -> (tsumatachi : Str) -> N 
           = \tsuma,okusan,a,c,b,tsumatachi -> 
             lin N (mkNoun tsuma okusan tsumatachi tsumatachi a c b False) 
    } ;
  
  mkN2 : (man : Str) -> (anim : Animateness) -> (counter : Str) -> (counterReplace : Bool) -> 
         (men : Str) -> (prep : Str) -> N2 = \n,a,c,b,pl,pr -> 
          lin N2 (numberNoun n a c b pl False) ** {prep = pr ; object = \\st => []} ;
      
  mkN3 : (distance : Str) -> (prep1: Str) -> (prep2: Str) -> (anim : Animateness) -> N3 
      = \n,p1,p2,a -> lin N3 (regNoun n a "つ" False True) ** {prep1 = p1; prep2 = p2} ;
    
  mkPN = overload {
    mkPN : (paris : Str) -> PN 
      = \n -> lin PN (regPN n) ;
    mkPN : (jon,jonsan : Str) -> PN 
      = \jon,jonsan -> lin PN (personPN jon jonsan)
    } ;
    
  mkPron = overload {
    mkPron : (kare : Str) -> (Pron1Sg : Bool) -> (anim : Animateness) -> Pron 
      = \kare,b,a -> lin Pron (regPron kare b a) ;
    mkPron : (boku,watashi : Str) -> (Pron1Sg : Bool) -> (anim : Animateness) -> Pron 
      = \boku,watashi,b,a -> lin Pron (stylePron boku watashi b a)
    } ;

  mkA = overload {
    mkA : (ookina : Str) -> A = \a -> lin A (regAdj a) ;
    mkA : (kekkonshiteiru,kikonno : Str) -> A = \pred,attr -> lin A (VerbalA pred attr)
    } ;
  
  mkA2 = overload {
    mkA2 : (yasui : Str) -> (prep : Str) -> A2 = \a,p -> lin A2 (regAdj a) ** {prep = p} ;
    mkA2 : (pred : Str) -> (attr : Str) -> (prep : Str) -> A2 = 
           \pred,attr,pr -> lin A2 (VerbalA pred attr) ** {prep = pr}
    } ;

  mkV = overload {
    mkV : (yomu : Str) -> V 
      = \yomu -> lin V (mkVerb yomu Gr1) ; ---- AR 15/11/2014
    mkV : (yomu : Str) -> (group : ResJpn.VerbGroup) -> V 
      = \yomu,gr -> lin V (mkVerb yomu gr) ;
    } ;

  mkV2 = overload {
    mkV2 : (yomu : Str) -> V2  ---- AR 15/11/2014
        = \yomu -> lin V2 (mkVerb2 yomu "を" Gr1) ;
    mkV2 : (yomu, prep : Str) -> (group : ResJpn.VerbGroup) -> V2 
        = \yomu,p,gr -> lin V2 (mkVerb2 yomu p gr) ;
    } ;
       
  mkV3 = overload {
    mkV3 : (yomu : Str) -> V3 
        = \yomu -> lin V3 (mkVerb3 yomu "に" "を" Gr1) ;
    mkV3 : (uru, p1, p2 : Str) -> (group : ResJpn.VerbGroup) -> V3 = \uru,p1,p2,gr -> 
       lin V3 (mkVerb3 uru p1 p2 gr) ;
    } ;

  mkVS : (yomu : Str) -> VS = \yomu -> lin VS (mkVerb2 yomu "ことを" Gr1) ;

  mkVV : (yomu : Str) -> VV = \yomu -> lin VV (mkVerbV yomu Gr1) ;

  mkV2V : (yomu : Str) -> V2V = \yomu -> lin V2V (mkVerb yomu Gr1) ;

  mkV2S : (yomu : Str) -> V2S = \yomu -> lin V2S (mkVerb yomu Gr1) ;

  mkVQ : (yomu : Str) -> VQ = \yomu -> lin VQ (mkVerb2 yomu "を" Gr1) ;

  mkVA : (yomu : Str) -> VA = \yomu -> lin VA (mkVerb yomu Gr1) ;

  mkV2A : (yomu : Str) -> V2A = \yomu -> lin V2A (mkVerb yomu Gr1) ;

  mkAdv : Str -> Adv  ---- AR 15/11/2014
    = \s -> lin Adv (ResJpn.mkAdv s) ;

  mkPrep : Str -> Prep  ---- AR 15/11/2014
    = \s -> lin Prep (ResJpn.mkPrep s) ;

  mkDet : Str -> Det = \d -> lin Det (ResJpn.mkDet d d ResJpn.Sg) ;

  mkConj : Str -> Conj = \c -> lin Conj (ResJpn.mkConj c ResJpn.And) ; 

  mkInterj : Str -> Interj
    = \s -> lin Interj (ss s) ;

  mkgoVV : VV = lin VV {s = \\sp => mkGo.s ; te = \\sp => mkGo.te ;
             a_stem = \\sp => mkGo.a_stem ;
             i_stem = \\sp => mkGo.i_stem ;
             ba = \\sp => mkGo.ba ;
             te_neg = \\sp => "行かないで" ;
             ba_neg = \\sp => "行かなければ" ; 
             sense = Abil} ; 
}
