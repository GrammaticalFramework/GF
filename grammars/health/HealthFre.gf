-- UTF8 version currently differs from non-UTF8 !!!

-- use this path to read the grammar from the same directory
--# -path=.:../newresource/abstract:../prelude:../newresource/french:../newresource/romance

concrete HealthFre of Health = open PredicationFre, ResourceFre, Prelude, SyntaxFre, MorphoFre, ExtraFre, ParadigmsFre in {

-- 1. still using "à" instead of "aux" in PainIn operations 
-- because of the UTF8 problem with non-utf8 resource grammars! 

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
  IPatientHe = INP ;
                                               
  Influenza = mkCNomReg "grippe" Fem ** {lock_CN = <> }; 
  Malaria =  mkCNomReg "malaria" Fem ** {lock_CN = <> }; 
  HaveIllness patient illness = predV2 (tvDir vAvoir) patient (DefOneNP illness) ;  
  Complain = predV2 (tvDir vAvoir) ;

  BeInCondition = PredVP ; 
  CatchCold = PosVG (PredTV (tvDir vAvoir) (IndefOneNP (mkCNomReg "rhume" Masc ** {lock_CN = <> })));
  Pregnant = PosVG (PredAP (mkAdjective (adjJeune "enceinte") adjPost** {lock_AP = <> })) ;

  High = AdjP1 (mkAdjReg "élevé" adjPost ** {lock_Adj1 = <> }) ;
  Terrible = AdjP1 ((mkAdjective (mkAdj "terrible" "terrible" "terrible" "terrible")  adjPre ** {lock_Adj1 = <> })** {lock_AP = <> });

  Head = mkCNomReg "tête" Fem ** {lock_CN = <> };
  Leg = mkCNomReg "jambe" Fem ** {lock_CN = <> };
  Dentist  = mkCNomReg "dentiste" Masc ** {lock_CN = <> } ;
  PainKiller = mkCNomReg "calmant" Masc ** {lock_CN = <> };

  NeedDoctor patient doctor = PredVP patient (avoirBesoin doctor ** {lock_VP = <> }) ;
  NeedMedicine patient medicine = PredVP patient (avoirBesoin medicine** {lock_VP = <> }) ;
  TakeMedicine patient medicine = predV2 (mkTransVerbDir (verbPres 
              (conj3prendre "prendre")) ** {lock_TV = <> } ) patient (IndefOneNP medicine) ;

  FeverMod degree = DetNP (delDet ** {lock_Det = <> }) (ModAdj degree (mkCNomReg "fièvre" Fem** {lock_CN = <> })) ;
  Fever = DetNP (delDet ** {lock_Det = <> }) (mkCNomReg "fièvre" Fem ** {lock_CN = <> }) ;

  PainInMod patient head degree = predV2 (tvDir vAvoir) patient 
    (DetNP (nullDet ** {lock_Det = <> }) 
      ( ModAdj degree
        (
          AppFun ((mkCNomReg "mal" Masc ** {lock_CN = <> })** complementCas Dat** {lock_Fun = <> }) 
          (defNounPhrase patient.n head ** {lock_NP = <> })
        )
      )
    ) ;
              
  PainIn patient head = predV2 (tvDir vAvoir) patient
     (DetNP (nullDet ** {lock_Det = <> }) 
      (
        AppFun 
          ((mkCNomReg "mal" Masc ** {lock_CN = <> })** complementCas Dat ** {lock_Fun = <> }) 
          (defNounPhrase patient.n head ** {lock_NP = <> })
      )
     ) ;

  Injured = injuredBody (adjReg "blessé") ;
  Broken = injuredBody (adjReg "cassé") ;

};

