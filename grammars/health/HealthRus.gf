-- use this path to read the grammar from the same directory

concrete HealthRus of Health = open PredicationRus, ResourceRus, Prelude, SyntaxRus, ExtraRus in {
--# -path=.:../newresource/abstract:../prelude:../newresource/russian

flags 
  coding=utf8 ;
  startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

lincat 
  Patient = NP ;
  Body = CN ;
  Symptom = NP ;
  SymptomDegree = AP ;
  Prop = S ;
  Illness = CN ; 
  Condition = VP ;
  Specialization = CN ;
  Medicine  = CN ;
lin 
  And x y = ConjS AndConj (TwoS x y) ;

  ShePatient = SheNP ;
  TheyPatient = TheyNP ;
  IPatientHe =  { s = INP.s ; g = PGen Masc; anim = INP.anim ;
    n = INP.n ; nComp = INP.nComp ; p = INP.p ; pron = INP.pron; lock_NP = <>} ;

  Influenza = n2n gripp ** {lock_CN = <>}; 
  Malaria = n2n malaria ** {lock_CN = <>} ; 

  Dentist  =  n2n stomatolog ** {lock_CN = <>};
  PainKiller = n2n obezbolivauchee ** {lock_CN = <>};
  High = AdjP1 (extAdjective vusokij ** {lock_Adj1 = <>});
  Terrible = AdjP1 (extAdjective uzhasnuj ** {lock_Adj1 = <>});

  Head = n2n golova ** {lock_CN = <>};
  Leg = n2n noga ** {lock_CN = <>};
  Fever = mkNounPhrase Sg (n2n temperatura)** {lock_NP = <>}; 
  FeverMod degree = mkNounPhrase Sg (ModAdj degree (n2n temperatura** {lock_CN = <>})) ** {lock_NP = <>};
  BeInCondition = PredVP ; 
  CatchCold = PosVG (PredAP (AdjP1 (prostuzhen ** {lock_Adj1 = <>}))) ;
  Pregnant = PosVG (PredAP (AdjP1 (beremenen ** {lock_Adj1 = <>}))) ;
  

  TakeMedicine patient painkiller = predV2 (mkDirectVerb 
    (extVerb verbPrinimat Act Present)**{lock_TV = <>}) patient (mkNounPhrase Sg painkiller ** {lock_NP = <>}) ; 
  Injured patient painkiller = predV2 (mkDirectVerb
   (extVerb verbPoranit Act Past)**{lock_TV = <>}) patient (mkNounPhrase patient.n painkiller ** {lock_NP = <>}) ;
  Broken patient painkiller = predV2 (mkDirectVerb
   (extVerb verbSlomat Act Past)**{lock_TV = <>}) patient (mkNounPhrase patient.n painkiller ** {lock_NP = <>}) ;
                               
  HaveIllness patient symptom = U_predTransVerb True tvHave
     patient (mkNounPhrase Sg symptom) ;
  Complain = U_predTransVerb True tvHave ;

  NeedDoctor = predNeedShortAdjective True ; 
  NeedMedicine = predNeedShortAdjective True ; 

  PainIn patient head = U_predTransVerb True (mkDirectVerb 
    (extVerb verbBolet_2 Act Present )) patient (mkNounPhrase patient.n head) ;
 
  PainInMod patient head degree = U_predTransVerb True (mkDirectVerb
    (extVerb have Act Present)) patient (mkNounPhrase Sg (ModAdj degree 
      (AppFun (mkFun bol "в" Prepos ** {lock_Fun = <>}) (mkNounPhrase patient.n head** {lock_NP = <>}))));

};
