resource ParadigmsJap = CatJap ** 
  open ResJap, CatJap, Prelude in {

flags coding = utf8 ;

oper

  mkN = overload {
    mkN : (man : Str) -> (anim : Animateness) -> N 
      = \n,a -> lin N (regNoun n a "つ" False) ;
    mkN : (kane,okane : Str) -> (anim : Animateness) -> N 
      = \kane,okane,a -> lin N (styleNoun kane okane a "つ" False) ;
    mkN : (man : Str) -> (anim : Animateness) -> (counter : Str) -> (counterReplace : Bool) -> N 
      = \n,a,c,b -> lin N (regNoun n a c b) ;
    mkN : (kane,okane : Str) -> (anim : Animateness) -> (counter : Str) -> 
          (counterReplace : Bool) -> N 
           = \kane,okane,a,c,b -> lin N (styleNoun kane okane a c b) 
    } ;
  
  mkN2 : (mother : Str) -> (prep: Str) -> (anim : Animateness) -> (counter : Str) -> 
         (counterReplace : Bool) -> N2 = \n,p,a,c,b -> 
          lin N2 (regNoun n a c b) ** {prep = p; object = \\st => []} ;
      
  mkN3 : (distance : Str) -> (prep1: Str) -> (prep2: Str) -> (anim : Animateness) -> N3 
      = \n,p1,p2,a -> lin N3 (regNoun n a "つ" False) ** {prep1 = p1; prep2 = p2} ;
    
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

  mkV : (yoma, yomi, yomu, yonda : Str) -> V 
      = \yoma,yomi,yomu,yonda -> lin V (mkVerb yoma yomi yomu yonda) ;

  mkV2 : (yoma, yomi, yomu, yonda, prep : Str) -> V2 
       = \yoma,yomi,yomu,yonda,p -> 
       lin V2 (mkVerb2 yoma yomi yomu yonda p) ;
   
  mkV3 : (yoma, yomi, yomu, yonda, p1, p2 : Str) -> (give: Bool) -> V3 
       = \yoma,yomi,yomu,yonda,p1,p2,b -> 
       lin V3 (mkVerb yoma yomi yomu yonda) ** {prep1 = p1 ; prep2 = p2 ; give = b} ;
}


