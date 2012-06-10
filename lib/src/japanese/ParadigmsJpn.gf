resource ParadigmsJpn = CatJpn ** 
  open ResJpn, CatJpn, Prelude in {

flags coding = utf8 ;

oper

  mkN = overload {
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
           = \kane,okane,a,c,b -> lin N (styleNoun kane okane a c b False) 
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

  mkV : (yomu : Str) -> (group : VerbGroup) -> V 
      = \yomu,gr -> lin V (mkVerb yomu gr) ;

  mkV2 : (yomu, prep : Str) -> (group : VerbGroup) -> V2 
       = \yomu,p,gr -> 
       lin V2 (mkVerb2 yomu p gr) ;
   
  mkV3 : (uru, p1, p2 : Str) -> (group : VerbGroup) -> V3 = \uru,p1,p2,gr -> 
       lin V3 (mkVerb3 uru p1 p2 gr) ;
}


