-- UTF8 version currently differs from non-UTF8 !!!

-- use this path to read the grammar from the same directory
--# -path=.:../newresource/abstract:../prelude:../newresource/french:../newresource/romance

concrete HealthFre of Health = open PredicationFre, ParadigmsFre, ResourceFre, Prelude, SyntaxFre, MorphoFre, ExtraFre, ParadigmsFre, ResourceExtFre in {

-- 1. still using "à" instead of "aux" in PainIn operations 
-- because of the UTF8 problem with non-utf8 resource grammars! 

flags 
  startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

lincat 
  Patient = NP ;
  BodyPart = CN ;
  Symptom = NP ;
  SymptomDegree = AP ;
  Prop = S ;
  Illness = NP ; 
  Condition = VP ;
  Specialization = CN ;
  Medicine  = NPMedicine ;

lin 
  And x y = ConjS AndConj (TwoS x y) ;  

  ShePatient = SheNP ;
  TheyPatient = TheyNP ;
  IPatientHe = INP ;
  IPatientShe = INP ;
  HePatient = HeNP ;
  WePatient = WeNP ;
                                               
  HaveIllness = predV2 (tvDir vAvoir) ;  
  Complain = predV2 (tvDir vAvoir) ;

  BeInCondition = PredVP ; 
  CatchCold = PosVG (PredTV (tvDir vAvoir) (IndefOneNP (mkCNomReg "rhume" Masc ** {lock_CN = <> })));
  Pregnant = PosVG (PredAP (mkAdjective (adjJeune "enceinte") adjPost** {lock_AP = <> })) ;

  Influenza = DefOneNP (mkCN (nReg "grippe" Fem)); 
  Malaria = DefOneNP (mkCN (nReg "malaria" Fem)); 
  Diarrhea = IndefOneNP (mkCN (nReg "diarrhée" Fem)) ; 
  Constipation = IndefOneNP (mkCN (nReg "constipation" Fem)); 
  Rheumatism = DetNP desDet (mkCN (nReg  "rhumatisme" Masc)) ;  
  Arthritis = DetNP delDet (mkCN (nReg "arthrite" Fem)) ; 
  SkinAllergy =IndefOneNP ( ModAdj 
             (AdjP1 (adj1Reg "épidermique" postpos)) 
             (mkCN (nReg "allergie" Fem))
    );  
  Heartburn = DetNP desDet (AppFun (funCase (nReg "brûlure" Fem) Gen) 
              (DetNP nullDet (mkCN (nReg "estomac"  Masc)))) ;
  Tonsillitis = IndefOneNP (mkCN (nReg "angine" Fem)) ; 
  Asthma = DetNP delDet (mkCN (nReg  "asthme" Masc)) ; 
  Cystitis =IndefOneNP ( mkCN (nReg  "cystite" Fem)) ;  
  Diabetes = DefOneNP (mkCN (nReg  "diabète" Masc)) ; 

  Dentist  = mkCN (nReg "dentiste" Masc) ;  
  Gynecologist = mkCN (nReg "gynécologue" Masc) ;
  Urologist = mkCN (nReg "urologue" Masc) ; 
  Pediatrician = mkCN (nReg "pédiatre" Masc) ;
  Physician = mkCN (nReg "thérapeute" Masc) ;
  Dermatologist = mkCN (nReg  "dermatologue" Masc) ;
  Cardiologist = mkCN (nReg "cardiologue" Masc) ;
  Neuropathologist = mkCN (nReg "neurologue" Masc) ;
  Ophthalmologist = mkCN (nReg "ophthalmologue" Masc) ;
  Surgeon = mkCN (nReg "chirurgien" Masc ) ;

  SleepingPeels = DetNP desDet (mkCN (nReg "somnifêre" Masc ))**{des = True};
  Vitamins = DetNP desDet (mkCN (nReg "vitamine" Fem))**{des = True} ;
  EyeDrops =  DetNP desDet (AppFun (funPrep (nReg "goutte" Fem) "pour") 
              (DefManyNP (mkCN (mkN "oeil" "yeux" Masc))))**{des = True} ;
  Antibiotics = DetNP desDet (mkCN (nReg "antibiotique" Masc))**{des = True} ;
  Insulin = DetNP delDet (mkCN (nReg "insuline" Fem))**{des = True};

  Viagra = DetNP nullDet (mkCN(nReg "viagra" Fem))**{des = False} ;
  Laxative = IndefOneNP (mkCN (nReg  "laxatif" Masc)) **{des = False};
  Sedative = IndefOneNP (mkCN (nReg  "sédatif" Masc)) **{des = False};
  Antidepressant = IndefOneNP (mkCN (nReg "antidépressif" Masc)) **{des = False};
  PainKiller = IndefOneNP (mkCN (nReg "calmant" Masc)) **{des = False};
                    
  NeedDoctor patient doctor = PredVP patient (avoirBesoin1 doctor ** {lock_VP = <> }) ;
  NeedMedicine patient medicine = PredVP patient (avoirBesoin medicine ** {lock_VP = <> }) ;
  TakeMedicine = predV2 (mkTransVerbDir (verbPres (conj3prendre "prendre")) ** {lock_TV = <> } ) ;

  Fever = DetNP delDet (mkCN (nReg "fièvre" Fem)) ;

  PainIn patient head = predV2 (tvDir vAvoir) patient
     (DetNP nullDet 
      (
        AppFun 
          ((mkCN (nReg "mal" Masc))** complementCas Dat ** {lock_Fun = <> }) 
          (defNounPhrase patient.n head ** {lock_NP = <>})
      )
     ) ;

  Injured = injuredBody (adjReg "blessé") ;
  Broken = injuredBody (adjReg "cassé") ;


  Head = mkCNomReg "tête" Fem ** {lock_CN = <> };
  Leg = mkCNomReg "jambe" Fem ** {lock_CN = <> };
  Stomac = mkCNomReg "estomac" Masc ** {lock_CN = <> }; 	
  Throat = mkCNomReg "gorge" Fem ** {lock_CN = <> };
  Ear = mkCNomReg "oreille" Fem ** {lock_CN = <> };
  Chest = mkCNomReg "poitrine" Fem ** {lock_CN = <> };
  Foot = mkCNomReg "pied" Masc ** {lock_CN = <> };
  Arm = mkCNomReg "bras" Masc ** {lock_CN = <> };
  Back = mkCNomReg "dos" Masc ** {lock_CN = <> };
  Shoulder = mkCNomReg "epaule" Fem ** {lock_CN = <> };
--  Tooth = mkCNomReg "dents" Masc ** {lock_CN = <> };
--  Knee = mkCNomReg "genou" Masc ** {lock_CN = <> };

  

--  High = AdjP1 (mkAdjReg "élevé" adjPost ** {lock_Adj1 = <> }) ;
--  Terrible = AdjP1 ((mkAdjective (mkAdj "terrible" "terrible" "terrible" "terrible")  adjPre ** {lock_Adj1 = <> })** {lock_AP = <> });
--  FeverMod degree = DetNP (delDet ** {lock_Det = <> }) (ModAdj degree (mkCNomReg "fièvre" Fem** {lock_CN = <> })) ;
--  PainInMod patient head degree = predV2 (tvDir vAvoir) patient 
--    (DetNP (nullDet ** {lock_Det = <> }) 
--      ( ModAdj degree
--        (
--          AppFun ((mkCNomReg "mal" Masc ** {lock_CN = <> })** complementCas Dat** {lock_Fun = <> }) 
--          (defNounPhrase patient.n head ** {lock_NP = <> })
--        )
--      )
--    ) ;


};

