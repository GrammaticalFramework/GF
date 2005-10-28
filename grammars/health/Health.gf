abstract Health =  {

cat 
  Specialization ; Patient ; BodyPart ; Symptom ; SymptomDegree ; Illness ; 
  Prop ; Condition ; Medicine ; 

fun 
  And : Prop -> Prop -> Prop ;
  PainIn : Patient -> BodyPart -> Prop ;
  Injured : Patient -> BodyPart -> Prop ;
  Broken : Patient -> BodyPart -> Prop ;
--  HaveIllness : Patient -> Illness -> Prop ;
  HaveAsthma : Patient -> Prop ;
  HaveHeartburn : Patient -> Prop ;
  HaveInfluenza : Patient -> Prop ;
  HaveRheumatism : Patient -> Prop ; 
  HaveCystitis : Patient -> Prop ; 
  HaveAsthma : Patient -> Prop ;
  HaveArthritis : Patient -> Prop ;
  HaveDiabetes : Patient -> Prop ;
  HaveTonsillitis : Patient -> Prop ;
  HaveConstipation : Patient -> Prop ;
  HaveMalaria : Patient -> Prop ; 
  HaveDiarrhea : Patient -> Prop ; 
  HaveSkinAllergy : Patient -> Prop ; 
  NeedDoctor : Patient -> Specialization -> Prop ;
  NeedMedicine : Patient -> Medicine -> Prop ;
  TakeMedicine : Patient -> Medicine -> Prop ;

  CatchCold : Condition ;
  Pregnant : Condition ;
  BeInCondition : Patient -> Condition -> Prop ; 
  Complain : Patient -> Symptom -> Prop ;

  ShePatient : Patient ;
  HePatient : Patient ;
  WePatient : Patient ;
  TheyPatient : Patient ;
  IPatientHe : Patient ;
  IPatientShe : Patient ;

--  Influenza : Illness ; 
--  Malaria : Illness ; 
--  Diarrhea : Illness ; 
--  SkinAllergy : Illness ; 
--  Heartburn : Illness ; 
--  Rheumatism : Illness ; 
--  Cystitis : Illness ; 
--  Asthma : Illness ;
--  Arthritis : Illness ;
--  Diabetes : Illness ;
--  Tonsillitis : Illness ;
--  Constipation : Illness ;
  
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

  SleepingPeels : Medicine ;
  Sedative :  Medicine ;
  Vitamins : Medicine ;
  EyeDrops : Medicine ;
  Antibiotics :  Medicine ;
  Viagra : Medicine ;
  Laxative : Medicine ;
  Insulin : Medicine ;
  Antidepressant : Medicine ;
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
--  Tooth : BodyPart ; 	
--  Knee : BodyPart ; 	


  Fever : Symptom ;
--  Sickness: Symptom ;
--  PainInMod : Patient -> BodyPart -> SymptomDegree -> Prop ;
--  SymptomMod : SymptomDegree -> Symptom -> Symtom;
--  High : SymptomDegree ;
--  Low : SymptomDegree ;
--  Terrible : SymptomDegree ;
--  BloodPressure : Symptom ;


} ;
