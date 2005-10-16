-- use this path to read the grammar from the same directory
--# -path=.:../../lib/resource-0.6/abstract:../../lib/prelude:../../lib/resource-0.6/italian:../../lib/resource-0.6/romance

concrete HealthIta of Health = open ResourceIta, Prelude, SyntaxIta, ExtraIta, MorphoIta, ParadigmsIta, ResourceExtIta, PredicationIta in {

flags 
  startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;
lincat 
  Patient = NP ;
  BodyPart = CN ;
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

  Influenza = mkCN (nRana "influenza") ;
  Malaria =  mkCN (nRana "malaria") ;
  HaveIllness patient illness = predV2 (tvDir vAvere) patient (DefOneNP
illness) ;

  BeInCondition = PredVP ;
  CatchCold = PosTV (tvDir vAvere) (IndefOneNP (mkCN (nSale "raffreddore" masculine))) ;
  Pregnant = PosA (apSolo "gravido" postpos) ;
  Complain = predV2 (tvDir vAvere) ;

  PainIn pat loc =
    PredVP pat (AdvVP (PosV (averCosa "male")) (datAdv (DefOneNP loc))) ;

  Fever = partitNP (mkCN (nSale "febbre" feminine)) ;
  Head = mkCN (nRana "testa") ;
  Leg = mkCN (nRana "gamba") ;

  Dentist  = mkCN (mkN "dentista" "dentisti" masculine)  ;
  PainKiller = mkCN (nSale "calmante" masculine) ;
  NeedDoctor pat doc = PredVP pat (averBisogno doc) ;
  NeedMedicine pat med = PredVP pat (averBisogno med) ;
  TakeMedicine pat med = predV2 (tvDir (vCorrere "prendere" "")) pat (IndefOneNP med) ;

  Injured = injuredBody (apSolo "ferito" prepos) ;
  Broken = injuredBody (apSolo "rotto" prepos) ;

  And = conjS ;

--  FeverMod deg = partitNP (ModAdj deg (mkCN (nSale "febbre" feminine)));
--  High = apSolo "alto" postpos ;
--  Terrible = apTale "terribile" postpos ;
--  PainInMod pat loc deg =
--    PredVP pat
--      (AdvVP (PosTV (tvDir vAvere)
--        (IndefOneNP (ModAdj deg (mkCN (nSale "dolore" masculine)))))
--             (datAdv (DefOneNP loc))) ;


};



