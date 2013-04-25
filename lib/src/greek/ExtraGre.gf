concrete ExtraGre of ExtraGreAbs = CatGre **
  open 
    CommonGre,
    ResGre,
    NounGre, 
    PhraseGre,
    SentenceGre,
    Prelude in {

flags coding = utf8 ;


    lin 
 
   -- TImperf = {s = [] ; t = ResGre.TImperf; m = Ind} ; 


   UttImpSgImperf pol imp = {s = pol.s ++ imp.s ! pol.p ! Sg ! Imperf} ;  
   UttImpPlImperf pol imp = {s = pol.s ++ imp.s ! pol.p !  Pl ! Imperf} ;  

  theyFem_Pron  = mkPron "αυτές" "τους" "τις" "αυτές" "αυτών" Fem Pl P3 ; 
  theyNeut_Pron  = mkPron "αυτά" "τους" "τα" "αυτά" "αυτών" Neut Pl P3 ;



   
} 