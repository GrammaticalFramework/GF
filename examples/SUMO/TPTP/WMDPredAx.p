fof(axWMDPred0, axiom, 
 f_biochemicalAgentDelivery(type_BacterialAgent,type_Breathing)).

fof(axWMDPred1, axiom, 
 f_biochemicalAgentDelivery(type_BacterialAgent,type_Touching)).

fof(axWMDPred2, axiom, 
 f_biologicalAgentCarrier(type_RickettsialAgent,type_Mammal)).

fof(axWMDPred3, axiom, 
 f_biologicalAgentCarrier(type_RickettsialAgent,type_Arthropod)).

fof(axWMDPred4, axiom, 
 f_biologicalAgentCarrier(type_RickettsiaRickettsii,type_Arthropod)).

fof(axWMDPred5, axiom, 
 f_biochemicalAgentSyndrome(type_RickettsiaRickettsii,inst_RockyMountainSpottedFever)).

fof(axWMDPred6, axiom, 
 f_diseaseMortality(inst_RockyMountainSpottedFever,4.0e-2)).

fof(axWMDPred7, axiom, 
 f_diseaseTreatment(inst_RockyMountainSpottedFever,type_OralAntibiotic,type_Ingesting)).

fof(axWMDPred8, axiom, 
 f_biologicalAgentCarrier(type_RickettsiaProwazekii,type_Arthropod)).

fof(axWMDPred9, axiom, 
 f_biochemicalAgentSyndrome(type_RickettsiaProwazekii,inst_LouseBorneTyphus)).

fof(axWMDPred10, axiom, 
 f_diseaseTreatment(inst_LouseBorneTyphus,type_OralAntibiotic,type_Ingesting)).

fof(axWMDPred11, axiom, 
 f_biochemicalAgentSyndrome(type_BacillusAnthracis,inst_Anthrax)).

fof(axWMDPred12, axiom, 
 f_biochemicalAgentDelivery(type_BacillusAnthracis,type_Breathing)).

fof(axWMDPred13, axiom, 
 f_biochemicalAgentDelivery(type_BacillusAnthracis,type_Ingesting)).

fof(axWMDPred14, axiom, 
 f_biochemicalAgentDelivery(type_BacillusAnthracis,type_Poking)).

fof(axWMDPred15, axiom, 
 f_biochemicalAgentDelivery(type_BacillusAnthracis,type_Touching)).

fof(axWMDPred16, axiom, 
 f_biologicalAgentCarrier(type_BacillusAnthracis,type_HoofedMammal)).

fof(axWMDPred17, axiom, 
 f_biochemicalAgentDelivery(type_AerosolizedBacillusAnthracis,type_Breathing)).

fof(axWMDPred18, axiom, 
 f_biochemicalAgentSyndrome(type_AerosolizedBacillusAnthracis,inst_InhalationalAnthrax)).

fof(axWMDPred19, axiom, 
 f_lethalDose(type_Batrachotoxin,f_PerFn(f_MeasureFn(2.0,f_MicroFn(inst_Gram)),f_MeasureFn(1.0,f_KiloFn(inst_Gram))))).

fof(axWMDPred20, axiom, 
 f_secretesToxin(type_ClostridiumBotulinum,type_BotulinumToxin)).

fof(axWMDPred21, axiom, 
 f_lethalDose(type_BotulinumToxin,f_PerFn(f_MeasureFn(1.0e-3,f_MicroFn(inst_Gram)),f_MeasureFn(1,f_KiloFn(inst_Gram))))).

fof(axWMDPred22, axiom, 
 f_biochemicalAgentDelivery(type_BotulinumToxin,type_Ingesting)).

fof(axWMDPred23, axiom, 
 f_biochemicalAgentSyndrome(type_BotulinumToxin,inst_Botulism)).

fof(axWMDPred24, axiom, 
 f_diseaseSymptom(inst_Botulism,inst_Paralysis)).

fof(axWMDPred25, axiom, 
 f_secretesToxin(type_ClostridiumPerfringens,type_EpsilonToxin)).

fof(axWMDPred26, axiom, 
 f_biochemicalAgentDelivery(type_ClostridiumPerfringens,type_Ingesting)).

fof(axWMDPred27, axiom, 
 f_biochemicalAgentDelivery(type_EpsilonToxin,type_Ingesting)).

fof(axWMDPred28, axiom, 
 f_biologicalAgentCarrier(type_BurkholderiaMallei,type_Mammal)).

fof(axWMDPred29, axiom, 
 f_biochemicalAgentDelivery(type_BurkholderiaMallei,type_Poking)).

fof(axWMDPred30, axiom, 
 f_biochemicalAgentSyndrome(type_BurkholderiaMallei,inst_Glanders)).

fof(axWMDPred31, axiom, 
 f_diseaseSymptom(inst_Glanders,inst_Fever)).

fof(axWMDPred32, axiom, 
 f_biologicalAgentCarrier(type_BurkholderiaPseudomallei,type_Mammal)).

fof(axWMDPred33, axiom, 
 f_biochemicalAgentDelivery(type_BurkholderiaPseudomallei,type_Poking)).

fof(axWMDPred34, axiom, 
 f_biochemicalAgentDelivery(type_BurkholderiaPseudomallei,type_Breathing)).

fof(axWMDPred35, axiom, 
 f_biochemicalAgentDelivery(type_BurkholderiaPseudomallei,type_Ingesting)).

fof(axWMDPred36, axiom, 
 f_biochemicalAgentSyndrome(type_BurkholderiaPseudomallei,inst_Melioidosis)).

fof(axWMDPred37, axiom, 
 f_biochemicalAgentSyndrome(type_BrucellaBacterium,inst_Brucellosis)).

fof(axWMDPred38, axiom, 
 f_diseaseSymptom(inst_Brucellosis,inst_Fever)).

fof(axWMDPred39, axiom, 
 f_biochemicalAgentSyndrome(type_YersiniaPestis,inst_Plague)).

fof(axWMDPred40, axiom, 
 f_biologicalAgentCarrier(type_YersiniaPestis,type_Rodent)).

fof(axWMDPred41, axiom, 
 f_biologicalAgentCarrier(type_YersiniaPestis,type_Insect)).

fof(axWMDPred42, axiom, 
 f_diseaseSymptom(inst_Plague,inst_Fever)).

fof(axWMDPred43, axiom, 
 f_lethalDose(type_RicinToxin,f_PerFn(f_MeasureFn(3.0,f_MicroFn(inst_Gram)),f_MeasureFn(1,f_KiloFn(inst_Gram))))).

fof(axWMDPred44, axiom, 
 f_lethalDose(type_AbrinToxin,f_PerFn(f_MeasureFn(4.0e-2,f_MicroFn(inst_Gram)),f_MeasureFn(1,f_KiloFn(inst_Gram))))).

fof(axWMDPred45, axiom, 
 f_biochemicalAgentDelivery(type_BlisterAgent,type_Touching)).

fof(axWMDPred46, axiom, 
 f_biochemicalAgentDelivery(type_BlisterAgent,type_Breathing)).

fof(axWMDPred47, axiom, 
 f_biochemicalAgentDelivery(type_BlisterAgent,type_Ingesting)).

fof(axWMDPred48, axiom, 
 f_biochemicalAgentDelivery(type_BloodAgent,type_Breathing)).

fof(axWMDPred49, axiom, 
 f_biochemicalAgentDelivery(type_NerveAgent,type_Breathing)).

fof(axWMDPred50, axiom, 
 f_biochemicalAgentSyndrome(type_NerveAgent,inst_Paralysis)).

fof(axWMDPred51, axiom, 
 f_lethalDose(type_Soman,f_PerFn(f_MeasureFn(64.0,f_MicroFn(inst_Gram)),f_MeasureFn(1.0,f_KiloFn(inst_Gram))))).

fof(axWMDPred52, axiom, 
 f_lethalDose(type_Sarin,f_PerFn(f_MeasureFn(100.0,f_MicroFn(inst_Gram)),f_MeasureFn(1,f_KiloFn(inst_Gram))))).

fof(axWMDPred53, axiom, 
 f_lethalDose(type_VX,f_PerFn(f_MeasureFn(15.0,f_MicroFn(inst_Gram)),f_MeasureFn(1.0,f_KiloFn(inst_Gram))))).

fof(axWMDPred54, axiom, 
 f_biochemicalAgentDelivery(type_ChokingAgent,type_Breathing)).

fof(axWMDPred55, axiom, 
 f_biochemicalAgentSyndrome(type_Chloropicrin,inst_Gastroenteritis)).

fof(axWMDPred56, axiom, 
 f_biochemicalAgentSyndrome(type_SalmonellaTyphimurium,inst_Gastroenteritis)).

fof(axWMDPred57, axiom, 
 f_biochemicalAgentSyndrome(type_SalmonellaTyphimurium,inst_Fever)).

fof(axWMDPred58, axiom, 
 f_diseaseTreatment(inst_Anthrax,type_Doxycycline,type_Ingesting)).

fof(axWMDPred59, axiom, 
 f_diseaseTreatment(inst_Anthrax,type_Ciprofloxacin,type_Ingesting)).

fof(axWMDPred60, axiom, 
 f_diseaseSymptom(inst_QFever,inst_Fever)).

fof(axWMDPred61, axiom, 
 f_diseaseMortality(inst_QFever,1.0e-2)).

fof(axWMDPred62, axiom, 
 f_biochemicalAgentSyndrome(type_YellowFeverVirus,inst_Fever)).

fof(axWMDPred63, axiom, 
 f_biochemicalAgentSyndrome(type_YellowFeverVirus,inst_YellowSkin)).

fof(axWMDPred64, axiom, 
 f_biochemicalAgentSyndrome(type_EbolaVirus,inst_EbolaHemorrhagicFever)).

fof(axWMDPred65, axiom, 
 f_biologicalAgentCarrier(type_FrancisellaTularensis,type_Rodent)).

fof(axWMDPred66, axiom, 
 f_biologicalAgentCarrier(type_FrancisellaTularensis,type_Arachnid)).

fof(axWMDPred67, axiom, 
 f_biochemicalAgentSyndrome(type_FrancisellaTularensis,inst_Tularemia)).

fof(axWMDPred68, axiom, 
 f_biochemicalAgentDelivery(type_FrancisellaTularensis,type_Breathing)).

fof(axWMDPred69, axiom, 
 f_diseaseSymptom(inst_Tularemia,inst_Fever)).

fof(axWMDPred70, axiom, 
 f_diseaseMortality(inst_Tularemia,5.0e-2)).

fof(axWMDPred71, axiom, 
 f_diseaseMortality(inst_Smallpox,0.33)).

fof(axWMDPred72, axiom, 
 f_biochemicalAgentSyndrome(type_MonkeypoxVirus,inst_Monkeypox)).

fof(axWMDPred73, axiom, 
 f_biochemicalAgentDelivery(type_MonkeypoxVirus,type_Poking)).

fof(axWMDPred74, axiom, 
 f_biologicalAgentCarrier(type_MonkeypoxVirus,type_Mammal)).

fof(axWMDPred75, axiom, 
 f_biochemicalAgentSyndrome(type_NeisseriaGonorrhoeae,inst_Gonorrhea)).

fof(axWMDPred76, axiom, 
 f_biochemicalAgentSyndrome(type_CoxiellaBurnetii,inst_QFever)).

fof(axWMDPred77, axiom, 
 f_biochemicalAgentDelivery(type_CoxiellaBurnetii,type_Breathing)).

fof(axWMDPred78, axiom, 
 f_biochemicalAgentDelivery(type_CoxiellaBurnetii,type_Ingesting)).

fof(axWMDPred79, axiom, 
 f_biochemicalAgentSyndrome(type_VariolaMajor,inst_Smallpox)).

fof(axWMDPred80, axiom, 
 f_biochemicalAgentSyndrome(type_VariolaMinor,inst_Smallpox)).

fof(axWMDPred81, axiom, 
 f_secretesToxin(type_ShigellaDysenteriae,type_ShigaToxin)).

fof(axWMDPred82, axiom, 
 f_biochemicalAgentDelivery(type_ShigellaDysenteriae,type_Ingesting)).

fof(axWMDPred83, axiom, 
 f_lethalDose(type_ShigaToxin,f_PerFn(f_MeasureFn(2.0e-3,f_MicroFn(inst_Gram)),f_MeasureFn(1,f_KiloFn(inst_Gram))))).

fof(axWMDPred84, axiom, 
 f_biochemicalAgentDelivery(type_HIVVirus,type_SexualReproduction)).

fof(axWMDPred85, axiom, 
 f_biochemicalAgentDelivery(type_SalmonellaTyphi,type_Ingesting)).

fof(axWMDPred86, axiom, 
 f_biochemicalAgentSyndrome(type_GiardiaLamblia,inst_Gastroenteritis)).

fof(axWMDPred87, axiom, 
 f_biologicalAgentCarrier(type_GiardiaLamblia,type_Rodent)).

fof(axWMDPred88, axiom, 
 f_biologicalAgentCarrier(type_Mixomatosis,type_Rodent)).

fof(axWMDPred89, axiom, 
 f_secretesToxin(type_StaphyylococcusAureus,type_StaphylococcalEnterotoxinB)).

fof(axWMDPred90, axiom, 
 f_biochemicalAgentSyndrome(type_StaphyylococcusAureus,inst_Fever)).

fof(axWMDPred91, axiom, 
 f_lethalDose(type_StaphylococcalEnterotoxinB,f_PerFn(f_MeasureFn(2.0e-2,f_MicroFn(inst_Gram)),f_MeasureFn(1,f_KiloFn(inst_Gram))))).

fof(axWMDPred92, axiom, 
 f_biochemicalAgentDelivery(type_StaphylococcalEnterotoxinB,type_Ingesting)).

fof(axWMDPred93, axiom, 
 f_biochemicalAgentDelivery(type_StaphylococcalEnterotoxinB,type_Breathing)).

fof(axWMDPred94, axiom, 
 f_biologicalAgentCarrier(type_Saxitoxin,type_Mollusk)).

fof(axWMDPred95, axiom, 
 f_biochemicalAgentDelivery(type_Saxitoxin,type_Ingesting)).

fof(axWMDPred96, axiom, 
 f_biochemicalAgentDelivery(type_Saxitoxin,type_Breathing)).

fof(axWMDPred97, axiom, 
 f_biochemicalAgentSyndrome(type_Saxitoxin,inst_ParalyticShellfishPoisoning)).

fof(axWMDPred98, axiom, 
 f_diseaseSymptom(inst_ParalyticShellfishPoisoning,inst_Paralysis)).

fof(axWMDPred99, axiom, 
 f_biologicalAgentCarrier(type_Conotoxin,type_Mollusk)).

fof(axWMDPred100, axiom, 
 f_biochemicalAgentSyndrome(type_Conotoxin,inst_ParalyticShellfishPoisoning)).

fof(axWMDPred101, axiom, 
 f_biochemicalAgentSyndrome(type_Tetrodotoxin,inst_ParalyticShellfishPoisoning)).

fof(axWMDPred102, axiom, 
 f_biochemicalAgentDelivery(type_VibrioCholera,type_Ingesting)).

fof(axWMDPred103, axiom, 
 f_biochemicalAgentSyndrome(type_VibrioCholera,inst_Cholera)).

fof(axWMDPred104, axiom, 
 f_biochemicalAgentDelivery(type_ClostridiumTetani,type_Poking)).

fof(axWMDPred105, axiom, 
 f_biochemicalAgentSyndrome(type_ClostridiumTetani,inst_Tetanus)).

fof(axWMDPred106, axiom, 
 f_diseaseMortality(inst_HerpesB,0.7)).

fof(axWMDPred107, axiom, 
 f_biologicalAgentCarrier(type_HerpesBVirus,type_Monkey)).

fof(axWMDPred108, axiom, 
 f_diseaseTreatment(inst_Pertussis,type_Antibiotic,type_Ingesting)).

fof(axWMDPred109, axiom, 
 f_biologicalAgentCarrier(type_BordetellaPertussis,type_Human)).

fof(axWMDPred110, axiom, 
 f_biochemicalAgentSyndrome(type_BordetellaPertussis,inst_Pertussis)).

fof(axWMDPred111, axiom, 
 f_biochemicalAgentDelivery(type_BordetellaPertussis,type_Breathing)).

fof(axWMDPred112, axiom, 
 f_biochemicalAgentSyndrome(type_ChlamydiaPsittaci,inst_Psittacosis)).

fof(axWMDPred113, axiom, 
 f_biologicalAgentCarrier(type_ChlamydiaPsittaci,type_Bird)).

fof(axWMDPred114, axiom, 
 f_biochemicalAgentDelivery(type_ChlamydiaPsittaci,type_Breathing)).

fof(axWMDPred115, axiom, 
 f_diseaseSymptom(inst_Malaria,inst_Fever)).

fof(axWMDPred116, axiom, 
 f_biologicalAgentCarrier(type_MalarialPlasmodium,type_Insect)).

fof(axWMDPred117, axiom, 
 f_biochemicalAgentDelivery(type_MalarialPlasmodium,type_Poking)).

fof(axWMDPred118, axiom, 
 f_biologicalAgentCarrier(type_WestNileVirus,type_Insect)).

fof(axWMDPred119, axiom, 
 f_biochemicalAgentSyndrome(type_WestNileVirus,inst_WestNileFever)).

fof(axWMDPred120, axiom, 
 f_biochemicalAgentDelivery(type_WestNileVirus,type_Poking)).

fof(axWMDPred121, axiom, 
 f_biologicalAgentCarrier(type_DengueFeverVirus,type_Insect)).

fof(axWMDPred122, axiom, 
 f_biochemicalAgentSyndrome(type_DengueFeverVirus,inst_DengueFever)).

fof(axWMDPred123, axiom, 
 f_biochemicalAgentSyndrome(type_DengueFeverVirus,inst_DengueHemorrhagicFever)).

fof(axWMDPred124, axiom, 
 f_biochemicalAgentDelivery(type_DengueFeverVirus,type_Poking)).

fof(axWMDPred125, axiom, 
 f_diseaseMortality(inst_DengueHemorrhagicFever,5.0e-2)).

fof(axWMDPred126, axiom, 
 f_biologicalAgentCarrier(type_LaCrosseVirus,type_Insect)).

fof(axWMDPred127, axiom, 
 f_biologicalAgentCarrier(type_LaCrosseVirus,type_Rodent)).

fof(axWMDPred128, axiom, 
 f_biochemicalAgentDelivery(type_LaCrosseVirus,type_Poking)).

fof(axWMDPred129, axiom, 
 f_biochemicalAgentSyndrome(type_LaCrosseVirus,inst_LaCrosseEncephalitis)).

fof(axWMDPred130, axiom, 
 f_diseaseMortality(inst_LaCrosseEncephalitis,1.0e-2)).

fof(axWMDPred131, axiom, 
 f_biologicalAgentCarrier(type_SaintLouisEncephalitisVirus,type_Bird)).

fof(axWMDPred132, axiom, 
 f_biologicalAgentCarrier(type_SaintLouisEncephalitisVirus,type_Insect)).

fof(axWMDPred133, axiom, 
 f_biochemicalAgentDelivery(type_SaintLouisEncephalitisVirus,type_Poking)).

fof(axWMDPred134, axiom, 
 f_biochemicalAgentSyndrome(type_SaintLouisEncephalitisVirus,inst_SaintLouisEncephalitis)).

fof(axWMDPred135, axiom, 
 f_diseaseSymptom(inst_SaintLouisEncephalitis,inst_Fever)).

fof(axWMDPred136, axiom, 
 f_biologicalAgentCarrier(type_EasternEquineEncephalitisVirus,type_Insect)).

fof(axWMDPred137, axiom, 
 f_biochemicalAgentDelivery(type_EasternEquineEncephalitisVirus,type_Poking)).

fof(axWMDPred138, axiom, 
 f_biochemicalAgentSyndrome(type_EasternEquineEncephalitisVirus,inst_EasternEquineEncephalitis)).

fof(axWMDPred139, axiom, 
 f_diseaseSymptom(inst_EasternEquineEncephalitis,inst_Fever)).

fof(axWMDPred140, axiom, 
 f_biologicalAgentCarrier(type_JapaneseEncephalitisVirus,type_Insect)).

fof(axWMDPred141, axiom, 
 f_biochemicalAgentDelivery(type_JapaneseEncephalitisVirus,type_Poking)).

fof(axWMDPred142, axiom, 
 f_biochemicalAgentSyndrome(type_JapaneseEncephalitisVirus,inst_JapaneseEncephalitis)).

fof(axWMDPred143, axiom, 
 f_diseaseMortality(inst_JapaneseEncephalitis,0.3)).

fof(axWMDPred144, axiom, 
 f_biochemicalAgentDelivery(type_EscherichiaColi0157H7,type_Ingesting)).

fof(axWMDPred145, axiom, 
 f_biochemicalAgentSyndrome(type_MycobacteriumTuberculosis,inst_Tuberculosis)).

fof(axWMDPred146, axiom, 
 f_biochemicalAgentDelivery(type_MycobacteriumTuberculosis,type_Breathing)).

fof(axWMDPred147, axiom, 
 f_diseaseTreatment(inst_Tuberculosis,type_OralAntibiotic,type_Ingesting)).

fof(axWMDPred148, axiom, 
 f_biochemicalAgentDelivery(type_MarburgVirus,type_Breathing)).

fof(axWMDPred149, axiom, 
 f_biochemicalAgentDelivery(type_MarburgVirus,type_Poking)).

fof(axWMDPred150, axiom, 
 f_biochemicalAgentSyndrome(type_MarburgVirus,inst_MarburgDisease)).

fof(axWMDPred151, axiom, 
 f_diseaseMortality(inst_MarburgDisease,0.25)).

fof(axWMDPred152, axiom, 
 f_biochemicalAgentSyndrome(type_StreptococcusA,inst_StrepThroat)).

fof(axWMDPred153, axiom, 
 f_biochemicalAgentSyndrome(type_StreptococcusA,inst_ScarletFever)).

fof(axWMDPred154, axiom, 
 f_biochemicalAgentSyndrome(type_StreptococcusA,inst_NecrotizingFaciitis)).

fof(axWMDPred155, axiom, 
 f_biochemicalAgentSyndrome(type_HepatitisAVirus,inst_HepatitisA)).

fof(axWMDPred156, axiom, 
 f_biochemicalAgentDelivery(type_HepatitisAVirus,type_Ingesting)).

fof(axWMDPred157, axiom, 
 f_biochemicalAgentDelivery(type_HepatitisAVirus,type_Poking)).

fof(axWMDPred158, axiom, 
 f_diseaseSymptom(inst_HepatitisA,inst_Fever)).

fof(axWMDPred159, axiom, 
 f_biochemicalAgentSyndrome(type_HepatitisBVirus,inst_HepatitisB)).

fof(axWMDPred160, axiom, 
 f_biochemicalAgentDelivery(type_HepatitisBVirus,type_Poking)).

fof(axWMDPred161, axiom, 
 f_biochemicalAgentSyndrome(type_HepatitisCVirus,inst_HepatitisC)).

fof(axWMDPred162, axiom, 
 f_biochemicalAgentDelivery(type_HepatitisCVirus,type_Poking)).

fof(axWMDPred163, axiom, 
 f_biochemicalAgentSyndrome(type_Rotavirus,inst_RotavirusGastroenteritis)).

fof(axWMDPred164, axiom, 
 f_biochemicalAgentDelivery(type_Rotavirus,type_Ingesting)).

fof(axWMDPred165, axiom, 
 f_diseaseSymptom(inst_RotavirusGastroenteritis,inst_Fever)).

fof(axWMDPred166, axiom, 
 f_biochemicalAgentSyndrome(type_Aflatoxin,inst_Aflatoxicosis)).

fof(axWMDPred167, axiom, 
 f_lethalDose(type_Diacetoxyscirpenol,f_PerFn(f_MeasureFn(23,f_MilliFn(inst_Gram)),f_MeasureFn(1,f_KiloFn(inst_Gram))))).

fof(axWMDPred168, axiom, 
 f_lethalDose(type_T2Toxin,f_PerFn(f_MeasureFn(5.2,f_MilliFn(inst_Gram)),f_MeasureFn(1,f_KiloFn(inst_Gram))))).

fof(axWMDPred169, axiom, 
 f_biochemicalAgentDelivery(type_BacillusCereus,type_Ingesting)).

fof(axWMDPred170, axiom, 
 f_biochemicalAgentSyndrome(type_LassaVirus,inst_LassaFever)).

fof(axWMDPred171, axiom, 
 f_biochemicalAgentDelivery(type_LassaVirus,type_Ingesting)).

fof(axWMDPred172, axiom, 
 f_biochemicalAgentDelivery(type_LassaVirus,type_Touching)).

fof(axWMDPred173, axiom, 
 f_biologicalAgentCarrier(type_LassaVirus,type_Rodent)).

fof(axWMDPred174, axiom, 
 f_diseaseSymptom(inst_LassaFever,inst_Fever)).

fof(axWMDPred175, axiom, 
 f_diseaseMortality(inst_LassaFever,1.0e-2)).

fof(axWMDPred176, axiom, 
 f_biochemicalAgentSyndrome(type_Legionella,inst_Legionellosis)).

fof(axWMDPred177, axiom, 
 f_diseaseMortality(inst_LegionnairesDisease,0.125)).

fof(axWMDPred178, axiom, 
 f_biochemicalAgentSyndrome(type_CorynebacteriumDiphtheriae,inst_Diphtheria)).

fof(axWMDPred179, axiom, 
 f_diseaseSymptom(inst_Diphtheria,inst_Fever)).

fof(axWMDPred180, axiom, 
 f_diseaseSymptom(inst_CrimeanCongoHemorrhagicFever,inst_Fever)).

fof(axWMDPred181, axiom, 
 f_diseaseMortality(inst_CrimeanCongoHemorrhagicFever,0.3)).

fof(axWMDPred182, axiom, 
 f_biologicalAgentCarrier(type_CrimeanCongoHemorrhagicFeverVirus,type_Arachnid)).

fof(axWMDPred183, axiom, 
 f_biochemicalAgentSyndrome(type_CrimeanCongoHemorrhagicFeverVirus,inst_CrimeanCongoHemorrhagicFever)).

fof(axWMDPred184, axiom, 
 f_biochemicalAgentDelivery(type_CrimeanCongoHemorrhagicFeverVirus,type_Poking)).

fof(axWMDPred185, axiom, 
 f_biologicalAgentCarrier(type_JuninVirus,type_Rodent)).

fof(axWMDPred186, axiom, 
 f_biochemicalAgentSyndrome(type_JuninVirus,inst_ArgentinianHemorrhagicFever)).

fof(axWMDPred187, axiom, 
 f_biochemicalAgentDelivery(type_JuninVirus,type_Breathing)).

fof(axWMDPred188, axiom, 
 f_diseaseSymptom(inst_ArgentinianHemorrhagicFever,inst_Fever)).

fof(axWMDPred189, axiom, 
 f_biologicalAgentCarrier(type_MachupoVirus,type_Rodent)).

fof(axWMDPred190, axiom, 
 f_biochemicalAgentSyndrome(type_MachupoVirus,inst_BolivianHemorrhagicFever)).

fof(axWMDPred191, axiom, 
 f_biochemicalAgentDelivery(type_MachupoVirus,type_Breathing)).

fof(axWMDPred192, axiom, 
 f_diseaseSymptom(inst_BolivianHemorrhagicFever,inst_Fever)).

fof(axWMDPred193, axiom, 
 f_biochemicalAgentSyndrome(type_GuanaritoVirus,inst_VenezuelanHemorrhagicFever)).

fof(axWMDPred194, axiom, 
 f_diseaseSymptom(inst_VenezuelanHemorrhagicFever,inst_Fever)).

fof(axWMDPred195, axiom, 
 f_biochemicalAgentSyndrome(type_SabiaVirus,inst_BrazilianHemorrhagicFever)).

fof(axWMDPred196, axiom, 
 f_diseaseSymptom(inst_BrazilianHemorrhagicFever,inst_Fever)).

fof(axWMDPred197, axiom, 
 f_biologicalAgentCarrier(type_TickBorneEncephalitisVirus,type_Arachnid)).

fof(axWMDPred198, axiom, 
 f_biochemicalAgentDelivery(type_TickBorneEncephalitisVirus,type_Poking)).

