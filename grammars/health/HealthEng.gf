-- use this path to read the grammar from the same directory
--# -path=.:../newresource/abstract:../prelude:../newresource/english
concrete HealthEng of Health = open PredicationEng, ResourceEng, ResourceExtEng, Prelude, Predef, SyntaxEng, ExtraEng, ParadigmsEng in {

flags 
  startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

lincat 
  Patient = NP ;
  -- CN is not enough, because of the different form of the "head" body part 
  -- expression in "I have a headache" and "I have injured my head":
  BodyPart = BodyCNCategory ;
  Symptom = NP ;
  SymptomDegree = AP ;
  Prop = S ;
  Illness = CN ; 
  Condition = VP ;
  Specialization = CN ;
  Medicine  = NP ;

lin 
  ShePatient = SheNP ;
  TheyPatient = TheyNP ;
  IPatientHe = INP ;
  IPatientShe = INP ;
  HePatient = HeNP ;
  WePatient = WeNP ;

  And x y = ConjS AndConj (TwoS x y) ; 

  Influenza = cnNonhuman "influenza" ; 
  Malaria = cnNonhuman "malaria" ; 
  Diarrhea = cnNonhuman "diarrhea" ; 
  SkinAllergy = AppFun (mkFun (nNonhuman "skin") []) (MassNP (cnNonhuman "allergy")) ;  
  Heartburn = cnNonhuman "heartburn" ;  
  Rheumatism = cnNonhuman "rheumatism" ;  
  Cystitis = cnNonhuman "cystitis" ;  
  Asthma = cnNonhuman "asthma" ; 
  Arthritis = cnNonhuman "arthritis" ; 
  Diabetes = cnNonhuman "diabetes" ; 
  Tonsillitis = cnNonhuman "tonsillitis" ; 
  Constipation = cnNonhuman "constipation" ; 
  
  Dentist  = cnHuman "dentist" ; 
  Gynecologist = cnHuman "gynecologist" ;
  Urologist = cnHuman "urologist" ; 
  Pediatrician = cnHuman "pediatrician" ;
  Physician = cnHuman "physician" ;
  Dermatologist = cnHuman "dermatologist" ;
  Cardiologist = cnHuman "cardiologist" ;
  Neuropathologist = cnHuman "neuropathologist" ;
  Ophthalmologist = cnHuman "ophthalmologist" ;
  Surgeon = cnHuman "surgeon" ;

  SleepingPeels = IndefManyNP (ModAdj (apReg "sleeping") (cnNonhuman "peel"));
  Vitamins = IndefManyNP (cnNonhuman "vitamin") ;
  EyeDrops = IndefManyNP (cnNonhuman "eye-drop") ;
  Antibiotics = IndefManyNP (cnNonhuman "antibiotic") ;
  Sedative = IndefOneNP (cnNonhuman "sedative") ;
  Viagra = MassNP (cnNonhuman "viagra") ;
  Laxative = IndefOneNP (cnNonhuman "laxative") ;
  Insulin = MassNP (cnNonhuman "insulin");
  Antidepressant = IndefOneNP (cnNonhuman "antidepressant") ;
  PainKiller = IndefOneNP (cnNonhuman "painkiller") ;

  Leg = { s = \\_,n,_ => case n of {Sg =>"leg" ; Pl=> "legs" }; 
         painInType = True } ;
  Head = { s = table{ True => table {Sg => table {_  => "head" }; 
           Pl => table {_  => "heads" }};
           False => table { _ => table {_=> "headache"}}} ;
           painInType = False } ;
  Stomac = { s = table{ True => table {Sg => table {_  => "stomach" }; 
           Pl => table {_  => "stomachs" }};
           False => table { _ => table {_=> "stomach-ache"}}} ;
           painInType = False } ; 	
--  Tooth = { s = table{ True => table {Sg => table {_  => "tooth" }; 
--           Pl => table {_  => "teeth" }};
--           False => table { _ => table {_=> "toothache"}}} ;
--           painInType = False } ; 	
  Throat = { s = table{ True => table {Sg => table {_  => "throat" }; 
           Pl => table {_  => "throats" }};
           False => table { _ => table {_=> ["sore throat"]}}} ;
           painInType = False } ; 		
  Ear = { s = \\_,n,_ => case n of {Sg =>"ear" ; Pl=> "ears" };           painInType = True } ; 	
  Chest = { s = \\_,n,_ => case n of {Sg =>"chest" ; Pl=> "chests" };           painInType = True } ; 	
  Foot = { s = \\_,n,_ => case n of {Sg =>"foot" ; Pl=> "feet" };           painInType = True } ; 	
  Arm = { s = \\_,n,_ => case n of {Sg =>"arm" ; Pl=> "arms" };           painInType = True } ; 	
  Back = { s = \\_,n,_ => case n of {Sg =>"back" ; Pl=> "backs" };           painInType = True } ; 	
  Shoulder = { s = \\_,n,_ => case n of {Sg =>"shoulder" ; Pl=> "shoulders" };           painInType = True } ; 	
--  Knee = { s = \\_,n,_ => case n of {Sg =>"knee" ; Pl=> "knees" };           painInType = True } ; 	

  BeInCondition = PredVP ; 
  Pregnant = PosVG ( PredAP( AdjP1 (regAdjective ["pregnant"] ** {lock_Adj1 = <>}))) ;
  CatchCold = PosVG (PredTV (tvHave** {lock_TV = <>}) (DetNP (aDet** {lock_Det = <>}) (cnNoHum (nounReg "cold")** {lock_CN = <>})));

  Fever = DetNP (aDet** {lock_Det = <>}) (cnNoHum (nounReg "fever")** {lock_CN = <>}) ;

  HaveIllness patient illness = predV2 tvHave patient (DetNP (nullDet** {lock_Det = <>}) illness) ; 
  Complain = predV2 tvHave ;

  NeedDoctor patient doctor = predV2 (mkTransVerbDir (regVerbP3 "need")**{lock_TV = <>}) 
       patient (DetNP (aDet ** {lock_Det = <>}) doctor); 
  NeedMedicine = predV2 (mkTransVerbDir (regVerbP3 "need")**{lock_TV = <>}) ; 
  TakeMedicine = predV2 (mkTransVerbDir (regVerbP3 "take")**{lock_TV = <>}) ;

  Injured = injuredBody (mkTransVerb verbP3Have "injured"**{lock_TV = <>}) ;
  Broken = injuredBody (mkTransVerb verbP3Have "broken"**{lock_TV = <>}) ;

  PainIn = painInPatientsBody (cnNoHum (nounReg "pain")**{lock_CN = <>}) ;

--  PainInMod = painInPatientsBodyMode (cnNoHum (nounReg "pain")**{lock_CN = <>});
--  SymptomMod degree symptom = DetNP (aDet** {lock_Det = <>}) 
--     (ModAdj degree (symptom ** {lock_CN = <>})) ;  
--  High = AdjP1 ((regAdjective "high") ** {lock_Adj1 = <>});
--  Low = AdjP1 ((regAdjective "low") ** {lock_Adj1 = <>});
--  Terrible = AdjP1 ((regAdjective "terrible")** {lock_Adj1 = <>});
};




