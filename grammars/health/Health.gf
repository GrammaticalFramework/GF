abstract Health =  {

cat 
  Specialization ; Patient ; BodyPart ; Symptom ; SymptomDegree ; Illness ; 
  Prop ; Condition ; Medicine ; 

fun 
  And : Prop -> Prop -> Prop ;
  Complain : Patient -> Symptom -> Prop ;
  PainIn : Patient -> BodyPart -> Prop ;
  Injured : Patient -> BodyPart -> Prop ;
  Broken : Patient -> BodyPart -> Prop ;
  HaveIllness : Patient -> Illness -> Prop ;
  BeInCondition : Patient -> Condition -> Prop ; 
  NeedDoctor : Patient -> Specialization -> Prop ;
  NeedMedicine : Patient -> Medicine -> Prop ;
  TakeMedicine : Patient -> Medicine -> Prop ;
  CatchCold : Condition ;
  Pregnant : Condition ;

  ShePatient : Patient ;
  TheyPatient : Patient ;
  IPatientHe : Patient ;

  Influenza : Illness ; 
  Malaria : Illness ; 
   
  Dentist : Specialization ;

  PainKiller : Medicine ;

  Head : BodyPart ; 	
  Leg : BodyPart ; 	
  Stomac : BodyPart ; 	
  Throat : BodyPart ; 	
  Ear : BodyPart ; 	
  Chest : BodyPart ; 	
  Foot : BodyPart ; 	
  Arm : BodyPart ; 	
  Back : BodyPart ; 	
  Shoulder : BodyPart ; 	
--  Knee : BodyPart ; 	
--  Tooth : BodyPart ; 	

  Fever : Symptom ;

--  PainInMod : Patient -> BodyPart -> SymptomDegree -> Prop ;
--  SymptomMod : SymptomDegree -> Symptom -> Symtom;
--  High : SymptomDegree ;
--  Low : SymptomDegree ;
--  Terrible : SymptomDegree ;
--  BloodPressure : Symptom ;


} ;
