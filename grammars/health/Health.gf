abstract Health =  {

cat 
  Specialization ; Patient ; BodyPart ; Symptom ; SymptomDegree ; Illness ; 
  Prop ; Condition ; Medicine ; 

fun 
  And : Prop -> Prop -> Prop ;
  PainIn : Patient -> BodyPart -> Prop ;
  Injured : Patient -> BodyPart -> Prop ;
  Broken : Patient -> BodyPart -> Prop ;
  HaveIllness : Patient -> Illness -> Prop ;
  NeedDoctor : Patient -> Specialization -> Prop ;
  NeedMedicine : Patient -> Medicine -> Prop ;
  TakeMedicine : Patient -> Medicine -> Prop ;

  CatchCold : Condition ;
  Pregnant : Condition ;
  BeInCondition : Patient -> Condition -> Prop ; 
  Complain : Patient -> Symptom -> Prop ;

  ShePatient : Patient ;
  TheyPatient : Patient ;
  IPatientHe : Patient ;

  Influenza : Illness ; 
  Malaria : Illness ; 
  Diarrhea : Illness ; 
  Allergy : Illness ; 
  Heartburn : Illness ; 
  Rheumatism : Illness ; 
  Cystitis : Illness ; 
  Asthma : Illness ;
  Arthritis : Illness ;
  Diabetes : Illness ;
  Tonsillitis : Illness ;
  Constipation : Illness ;
  
  Dentist : Specialization ;
  Gynecologist : Specialization ;
  Urologist: Specialization ;
  Pediatrician : Specialization ;
  Physician :Specialization ;
  Dermatologist :Specialization ;
  Cardiologist : Specialization ;
  Neuropathologist :  Specialization ;
  Ophthalmologist : Specialization ;
  Surgeon : Specialization ;

  PainKiller : Medicine ;
  SleepingPeels : Medicine ;
  Sedative :  Medicine ;
  Vitamins : Medicine ;
  EyeDrops : Medicine ;
  Antibiotics :  Medicine ;
  Viagra : Medicine ;
  Laxative : Medicine ;
  Insulin : Medicine ;
  Antidepressant : Medicine ;

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
  Sickness: Symptom ;
--  PainInMod : Patient -> BodyPart -> SymptomDegree -> Prop ;
--  SymptomMod : SymptomDegree -> Symptom -> Symtom;
--  High : SymptomDegree ;
--  Low : SymptomDegree ;
--  Terrible : SymptomDegree ;
--  BloodPressure : Symptom ;


} ;
