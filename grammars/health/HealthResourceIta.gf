-- use this path to read the grammar from the same directory
--# -path=.:../newresource/abstract:../prelude:../newresource/italian:../newresource/romance

concrete HealthIta of Health = open ResourceIta, Prelude, SyntaxIta, ExtraIta, MorphoIta in {

flags 
  startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

lin
  ShePatient = SheNP ;
  TheyPatient = TheyNP ;
  IPatientHe = INP ;

  Influenza = mkCN (nRana "influenza") ;
  Malaria =  mkCN (nRana "malaria") ;
  HaveIllness patient illness = predV2 (tvDir vAvere) patient (DefOneNP
illness) ;

  BeInCondition = PredVP ;

  CatchCold =
    PosTV (tvDir vAvere) (IndefOneNP (mkCN (nSale "raffreddore"
masculine))) ;

  Pregnant = PosA (apSolo "gravido" postpos) ;

  Complain = predV2 (tvDir vAvere) ;

  PainInMod pat loc deg =
    PredVP pat
      (AdvVP (PosTV (tvDir vAvere)
                    (IndefOneNP (ModAdj deg (mkCN (nSale "dolore"
masculine)))))
             (datAdv (DefOneNP loc))) ;

  FeverMod deg = partitNP (ModAdj deg (mkCN (nSale "febbre" feminine)));

  PainIn pat loc =
    PredVP pat (AdvVP (PosV (averCosa "male")) (datAdv (DefOneNP loc))) ;

  Fever = partitNP (mkCNomReg (nSale "febbre" feminine)) ;

  High = apSolo "alto" postpos ;
  Terrible = apTale "terribile" postpos ;
  Head = mkCN (nRana "testa") ;
  Leg = mkCN (nRana "gamba") ;

  Dentist  = mkCN (mkN "dentista" "dentisti" masculine)  ;
  PainKiller = mkCN (nSale "calmante" masculine) ;
  NeedDoctor pat doc = PredVP pat (averBisogno doc) ;
  NeedMedicine pat med = PredVP pat (averBisogno med) ;
  TakeMedicine pat med = predV2 (tvDir (vCorrere "prendere")) pat
(IndefOneNP med) ;

  Injured = injuredBody (mkAdjective (adjSolo "ferito") True) ;
  Broken = injuredBody (mkAdjective (adjSolo "rotto") True) ;

  And = conjS ;


};



