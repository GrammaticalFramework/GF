abstract Health =  {

cat 
  Specialization ; Patient ; Body ; Symptom ; SymptomDegree ; Illness ; 
  Prop ; Condition ; Medicine ; 

fun 
  And : Prop -> Prop -> Prop ;
  Complain : Patient -> Symptom -> Prop ;
  FeverMod : SymptomDegree -> Symptom ;
  PainIn : Patient -> Body -> Prop ;
  PainInMod : Patient -> Body -> SymptomDegree -> Prop ;
  Injured : Patient -> Body -> Prop ;
  Broken : Patient -> Body -> Prop ;
  HaveIllness : Patient -> Illness -> Prop ;
  BeInCondition : Patient -> Condition -> Prop ; 
  NeedDoctor : Patient -> Specialization -> Prop ;
  NeedMedicine : Patient -> Medicine -> Prop ;
  TakeMedicine : Patient -> Medicine -> Prop ;
  CatchCold : Condition ;
  Pregnant : Condition ;
  Fever : Symptom ;
  High : SymptomDegree ;
  Terrible : SymptomDegree ;
  Head : Body ; 	
  Leg : Body ; 	
  ShePatient : Patient ;
  TheyPatient : Patient ;
  IPatientHe : Patient ;
  Influenza : Illness ; 
  Malaria : Illness ; 
   
  Dentist : Specialization ;
  PainKiller : Medicine ;

} ;
