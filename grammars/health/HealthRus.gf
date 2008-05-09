-- use this path to read the grammar from the same directory
--# -path=.:../../lib/resource-0.6/abstract:../../lib/prelude:../../lib/resource-0.6/russian

concrete HealthRus of Health = open PredicationRus, ResourceRus, SyntaxRus, ExtraRus, ResourceExtRus, ParadigmsRus in {

flags 
  coding=utf8 ;
  startcat=Phr ; lexer=text ; parser=chart ; unlexer=text ;

lincat 
  Patient = NP ;
  BodyPart = CN ;
  Symptom = NP ;
  SymptomDegree = AP ;
  Prop = S ;
  Illness = CN ; 
  Condition = VP ;
  Specialization = NP ;
  Medicine  = NP ;
lin 
  And x y = ConjS AndConj (TwoS x y) ;

  ShePatient = SheNP ;
  TheyPatient = TheyNP ;
  IPatientHe =  { s = INP.s ; g = PGen Masc; anim = INP.anim ;
    n = INP.n ; nComp = INP.nComp ; p = INP.p ; pron = INP.pron; lock_NP = <>} ;
  IPatientShe =   { s = INP.s ; g = PGen Fem; anim = INP.anim ;
    n = INP.n ; nComp = INP.nComp ; p = INP.p ; pron = INP.pron; lock_NP = <>} ;
  HePatient = HeNP ;
  WePatient = WeNP ;


--  Influenza = UseN ( gripp**{lock_N = <>}) ; 
--  Malaria = UseN ( malaria**{lock_N = <>}) ; 
--  Diarrhea = UseN ( ponos **{lock_N = <>});  
--  SkinAllergy = ModAdj (AdjP1(adj1Staruyj "кожн")) (UseN ( allergiya **{lock_N = <>}));  
--  Heartburn = UseN ( izzhoga **{lock_N = <>});  
--  Rheumatism = UseN ( revmatizm **{lock_N = <>});  
--  Cystitis = UseN ( tsistit **{lock_N = <>});  
--  Asthma = UseN ( astma **{lock_N = <>}); 
--  Arthritis = UseN ( artrit **{lock_N = <>}); 
--  Diabetes = UseN ( diabet **{lock_N = <>}); 
--  Tonsillitis = UseN ( angina **{lock_N = <>}); 
--  Constipation = UseN ( zapor **{lock_N = <>}); 
  
  Dentist  = IndefOneNP ( UseN ( stomatolog**{lock_N = <>})) ; 
  Gynecologist = IndefOneNP (UseN ( ginekolog**{lock_N = <>})) ; 
  Urologist = IndefOneNP (UseN ( urolog**{lock_N = <>})) ; 
  Pediatrician = IndefOneNP (UseN ( pediatr**{lock_N = <>})) ; 
  Physician = IndefOneNP (UseN ( terapevt**{lock_N = <>})) ; 
  Dermatologist = IndefOneNP (UseN ( dermatolog**{lock_N = <>})) ; 
  Cardiologist = IndefOneNP (UseN ( kardiolog**{lock_N = <>})) ; 
  Neuropathologist = IndefOneNP (UseN ( nevropatolog**{lock_N = <>})) ; 
  Ophthalmologist = IndefOneNP (UseN ( okulist**{lock_N = <>})) ; 
  Surgeon = IndefOneNP (UseN ( khirurg**{lock_N = <>})) ; 

  SleepingPeels = IndefOneNP (UseN ( snotvornoe**{lock_N = <>})); 
  Sedative = IndefOneNP (UseN ( uspokoitelnoe**{lock_N = <>})); 
  Vitamins = IndefManyNP (UseN ( vitamin**{lock_N = <>})); 
  EyeDrops = IndefManyNP (ModAdj (AdjP1 (glaznoj**{lock_Adj1 = <>})) (UseN ( kaplya**{lock_N = <>}))); 
  Antibiotics = IndefManyNP (UseN ( antibiotik**{lock_N = <>})); 
  Viagra = IndefOneNP (UseN ( viagra**{lock_N = <>})); 
  Laxative = IndefOneNP (UseN ( slabitelnoe**{lock_N = <>})); 
  Insulin = MassNP (UseN (insulin**{lock_N = <>})); 
  Antidepressant = IndefOneNP (UseN ( antidepressant**{lock_N = <>})); 
  PainKiller = IndefOneNP (UseN ( obezbolivauchee**{lock_N = <>}));

  Fever = mkNounPhrase singular (UseN ( temperatura**{lock_N = <>}))** {lock_NP = <>}; 
  BeInCondition = PredVP ; 
  CatchCold = PosVG (PredAP (AdjP1 (prostuzhen ** {lock_Adj1 = <>}))) ;
  Pregnant = PosVG (PredAP (AdjP1 (beremenen ** {lock_Adj1 = <>}))) ;
                                 
  TakeMedicine = predV2 (mkDirectVerb 
    (extVerb verbPrinimat active present)**{lock_TV = <>}) ; 
  Injured patient painkiller = predV2 (mkDirectVerb
   (extVerb verbPoranit active past)**{lock_TV = <>}) patient (mkNounPhrase patient.n painkiller ** {lock_NP = <>}) ;
  Broken patient painkiller = predV2 (mkDirectVerb
   (extVerb verbSlomat active past)**{lock_TV = <>}) patient (mkNounPhrase patient.n painkiller ** {lock_NP = <>}) ;
                               
--  HaveIllness patient symptom = U_predTransVerb true tvHave
--     patient (mkNounPhrase singular symptom ** {lock_NP = <>}) ;
  Complain = U_predTransVerb true tvHave ;

  NeedDoctor = predNeedShortAdjective true ; 
  NeedMedicine = predNeedShortAdjective true ; 

  PainIn patient head = U_predTransVerb true (mkDirectVerb 
    (extVerb verbBolet_2 active present ) ** {lock_TV =<>}) patient (mkNounPhrase patient.n head ** {lock_NP =<>}) ;
 
 Head = UseN ( golova**{lock_N = <>});
 Leg = UseN ( noga**{lock_N = <>});
  Stomac = UseN ( zhivot**{lock_N = <>});
  Throat = UseN ( gorlo**{lock_N = <>});
  Ear = UseN ( ukho**{lock_N = <>});
  Chest = UseN ( grud**{lock_N = <>});
  Foot = UseN ( stopa**{lock_N = <>});
  Arm = UseN ( ruka**{lock_N = <>});
  Back = UseN ( spina**{lock_N = <>});
  Shoulder = UseN ( plecho**{lock_N = <>});
--  Knee = UseN ( koleno**{lock_N = <>});

--  High = AdjP1 (extAdjective vusokij ** {lock_Adj1 = <>});
--  Terrible = AdjP1 (extAdjective uzhasnuj ** {lock_Adj1 = <>});
--  FeverMod degree =  mkNounPhrase singular 
-- (ModAdj degree (UseN ( temperatura**{lock_N = <>}))) ** {lock_NP = <>};
--  PainInMod patient head degree = U_predTransVerb true (mkDirectVerb
--    (extVerb have Act Present) ** {lock_TV =<>}) patient 
-- (mkNounPhrase singular (ModAdj degree 
--(AppFun (mkFun bol "в" Prepos ** {lock_Fun = <>}) 
-- (mkNounPhrase patient.n head** {lock_NP = <>}))) ** {lock_NP =<>});
};
