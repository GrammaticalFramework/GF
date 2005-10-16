-- The UTF8 version currently differs from the non-UTF8 !!!

-- The difference with the UTF8 version is that 
-- operations "verbVara" (vbVara see ExtraSweU.gf) 
-- and "predAP" (predAP, see ExtraSweU.gf) need to be replaced
-- using the UTF8 encoding (because of the UTF8 problem 
-- with UTF8 resource grammars) 

-- use this path to read the grammar from the same directory

--# -path=.:../../lib/resource-0.6/abstract:../../lib/prelude:../../lib/resource-0.6/swedish
concrete HealthSwe of Health = open PredicationSwe, ResourceSwe, Prelude, SyntaxSwe, ExtraSwe, ParadigmsSwe, ResourceExtSwe in {

flags 
  startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

lincat 
  Patient = patientNPCategory ;
  BodyPart = CN ;
  Symptom = NP ;
  SymptomDegree = AP ;
  Prop = S ;
  Illness = CN ; 
  Condition = VP ;
  Specialization = CN ;
  Medicine  = NP ;

lin 
  And x y = ConjS AndConj (TwoS x y) ; 

  ShePatient = mkPronPatient hon_35 ;
  TheyPatient = mkPronPatient de_38 ;
  IPatientHe = mkPronPatient jag_32 ;
  IPatientShe = mkPronPatient jag_32 ;
  HePatient = mkPronPatient han_34 ;
  WePatient = mkPronPatient vi_36 ;

  Influenza = UseN (nApa "influens") ; 
  Malaria = UseN (nApa "malari"); 
  Diarrhea = UseN (nApa "diarré"); 
  SkinAllergy = UseN (nApa "hudallergi");  
  Heartburn = UseN (nApa "halsbränna");  
  Rheumatism = UseN (nBil "reumatism");  
  Cystitis = UseN (nRisk "urinvägsinfektion");  
  Asthma = UseN (nApa "astma"); 
  Arthritis = UseN (nApa "artrit"); 
  Diabetes = UseN (nBil "diabetes"); 
  Tonsillitis = UseN (nBil "halsfluss"); 
  Constipation = UseN (nBil "förstoppning"); 
  
  Dentist  = UseN (nKikare "tandläkare") ;
  Gynecologist = UseN (nRisk "gynekolog"); 
  Urologist= UseN (nRisk "urolog"); 
  Pediatrician = UseN (nKikare "barnläkare"); 
  Physician = UseN (nKikare "läkare"); 
  Dermatologist = UseN (nKikare "hudläkare"); 
  Cardiologist = UseN (nRisk "kardiolog"); 
  Neuropathologist = UseN (nRisk "neurolog"); 
  Ophthalmologist = UseN (nKikare "ögönläkare"); 
  Surgeon = UseN (nRisk "kirurg"); 

  SleepingPeels = IndefManyNP (UseN (nRisk "sömntablett")) ;
  Sedative = IndefOneNP (UseN (nPapper "lugnande")) ;
  Vitamins = IndefManyNP (UseN (nPapper "vitaminpiller")) ;
  EyeDrops = IndefManyNP (UseN (nPojke "ögondroppe")) ;
  Antibiotics = IndefManyNP (UseN (nPapper "antibiotika")) ;
  Viagra = MassNP (UseN (nBil "viagra")) ;
  Laxative = IndefOneNP (UseN (nPapper "laxer")) ;
  Insulin = MassNP (UseN (nRep "insulin")) ;
  Antidepressant = IndefOneNP ( ModAdj (AdjP1 (adjReg "antidepressiv")) (UseN (nRep "läkemedel"))) ;
  PainKiller = IndefOneNP (UseN (nBil "smärtstillande")) ;

  CatchCold = PosVG ( PredAP( AdjP1 (extAdjective (aGrund("förkyl")) ** {lock_Adj1 = <>}) ));
  Pregnant = PosVG ( PredAP( AdjP1 (extAdjective (aGrund("gravi") )** {lock_Adj1 = <>}) ));
 
  BeInCondition = PredVP ; 
  HaveIllness patient illness = predV2 (mkDirectVerb verbHa** {lock_TV =<>}) patient 
                                (DetNP (nullDet  ** {lock_Det = <>}) illness) ;

  NeedMedicine = predV2 (mkDirectVerb verbBehova** {lock_TV =<>}) ; 
  TakeMedicine = predV2 (mkDirectVerb verbTa** {lock_TV =<>}) ;
 
  NeedDoctor patient illness = predV2 (mkDirectVerb verbBehova** {lock_TV =<>}) patient                                 
                                (DetNP (enDet  ** {lock_Det = <>}) illness) ;
  Fever = DetNP (nullDet  ** {lock_Det = <>}) (UseN (nRisk "feber")) ;
 
  Complain = predV2 (mkDirectVerb verbHa ** {lock_TV =<>}) ;
  Broken patient head = predV2 (mkTransVerb verbHa "brutit" ** {lock_TV =<>} ) patient 
                        (defNounPhrase patient.n head ** {lock_NP =<>}) ;

  PainIn patient head = predV2 (mkDirectVerb verbHa** {lock_TV =<>}) patient 
   (
    DetNP (nullDet  ** {lock_Det = <>}) 
    ( AppFun 
       ((mkFun (nBil "ont") "i") ** {lock_Fun = <>})
       ((defNounPhrase patient.n head)** {lock_NP = <>})
    )
   ) ;

  Head = UseN (nRep "huvud") ;
  Leg = UseN (nRep "ben") ;
  Stomac = UseN  (nPojke "mage")  ;
  Throat = UseN  (nBil "hals") ;
  Ear = UseN  (mkN "öra" "örat" "öron" "öronen" neutrum nonmasculine) ;
  Chest = UseN (nRep "bröst") ;
  Foot = UseN  (mkN "fot" "foten" "fötter" "fötterna" utrum nonmasculine) ;
  Arm = UseN  (mkN "hand" "handen" "händer" "händerna" utrum nonmasculine) ;
  Back = UseN  (nBil "rygg") ;
  Shoulder = UseN  (nNyckel "axel") ;

--  High = AdjP1 (adjReg "hög") ;
--  Terrible = AdjP1 (adjReg "hemsk") ;
--  FeverMod degree = DetNP (nullDet  ** {lock_Det = <>}) (ModAdj degree (UseN (nKikare "feb") ) ;
--  PainInMod patient head degree =  predV2 (mkDirectVerb verbHa** {lock_TV =<>}) patient
--    (
--      DetNP (nullDet  ** {lock_Det = <>}) 
--      ( modCommNounPhrase degree 
--           ( AppFun 
--               ((mkFun (extCommNoun nonmasculine (sBil "ont")) "i") ** {lock_Fun = <>}) 
--               ((defNounPhrase patient.n head)** {lock_NP = <>})
--           ) ** {lock_CN = <>}
--      )
--    ) ;

  Injured = injuredBody ;

};


