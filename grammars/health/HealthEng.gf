-- use this path to read the grammar from the same directory
--# -path=.:../newresource/abstract:../prelude:../newresource/english
concrete HealthEng of Health = open PredicationEng, ResourceEng, Prelude, SyntaxEng, ExtraEng in {

flags 
  startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

lincat 
  Patient = NP ;
  -- CN is not enough, because of the different form of the "head" body part 
  -- expression in "I have a headache" and "I have injured my head":
  Body = BodyCNCategory ;
  Symptom = NP ;
  SymptomDegree = AP ;
  Prop = S ;
  Illness = CN ; 
  Condition = VP ;
  Specialization = CN ;
  Medicine  = CN ;

lin 
  ShePatient = SheNP ;
  TheyPatient = TheyNP ;
  IPatientHe = INP ;

  And x y = ConjS AndConj (TwoS x y) ; 

  Influenza = cnNoHum (nounReg "influenza")** {lock_CN = <>} ; 
  Malaria =  cnNoHum (nounReg "malaria") ** {lock_CN = <>}; 
  Dentist  = cnHum (nounReg "dentist")** {lock_CN = <>}  ;
  PainKiller = cnNoHum (nounReg "painkiller")** {lock_CN = <>} ;

  High = AdjP1 ((regAdjective "high") ** {lock_Adj1 = <>});
  Terrible = AdjP1 ((regAdjective "terrible")** {lock_Adj1 = <>});

  Leg = { s = \\_,n,_ => case n of {Sg =>"leg" ; Pl=> "legs" }; 
         painInType = True } ;
  Head = { s = table{ True => table {Sg => table {_  => "head" }; 
           Pl => table {_  => "heads" }};
           False => table { _ => table {_=> "headache"}}} ;
           painInType = False } ;

  BeInCondition = PredVP ; 
  Pregnant = PosVG ( PredAP( AdjP1 (regAdjective ["pregnant"] ** {lock_Adj1 = <>}))) ;
  CatchCold = PosVG (PredTV (tvHave** {lock_TV = <>}) (DetNP (aDet** {lock_Det = <>}) (cnNoHum (nounReg "cold")** {lock_CN = <>})));

  Fever = DetNP (aDet** {lock_Det = <>}) (cnNoHum (nounReg "fever")** {lock_CN = <>}) ;
  FeverMod degree = DetNP (aDet** {lock_Det = <>}) (ModAdj degree (cnNoHum (nounReg "fever")** {lock_CN = <>})) ;  

  HaveIllness patient illness = predV2 tvHave patient (DetNP (nullDet** {lock_Det = <>}) illness) ; 
  Complain = predV2 tvHave ;

  NeedDoctor patient doctor = predV2 (mkTransVerbDir (regVerbP3 "need")**{lock_TV = <>}) 
       patient (DetNP (aDet ** {lock_Det = <>}) doctor); 
  NeedMedicine patient medicine = predV2 (mkTransVerbDir (regVerbP3 "need")**{lock_TV = <>}) 
       patient (DetNP (aDet ** {lock_Det = <>}) medicine); 
  TakeMedicine patient medicine = predV2 (mkTransVerbDir (regVerbP3 "take")**{lock_TV = <>})
       patient (DetNP (aDet ** {lock_Det = <>}) medicine) ; 

  Injured = injuredBody (mkTransVerb verbP3Have "injured"**{lock_TV = <>}) ;
  Broken = injuredBody (mkTransVerb verbP3Have "broken"**{lock_TV = <>}) ;

  PainIn = painInPatientsBody (cnNoHum (nounReg "pain")**{lock_CN = <>}) ;
  PainInMod = painInPatientsBodyMode (cnNoHum (nounReg "pain")**{lock_CN = <>});
};




