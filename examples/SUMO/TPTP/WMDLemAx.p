fof(axWMDLem0, axiom, 
 ( ! [Var_WEAPON] : 
 (hasType(type_BiochemicalWeapon, Var_WEAPON) => 
(( ? [Var_AGENT] : 
 (hasType(type_BiochemicalAgent, Var_AGENT) &  
(f_part(Var_AGENT,Var_WEAPON)))))))).

fof(axWMDLem1, axiom, 
 ( ! [Var_WEAPON] : 
 (hasType(type_BiologicalWeapon, Var_WEAPON) => 
(( ? [Var_AGENT] : 
 (hasType(type_BiologicalAgent, Var_AGENT) &  
(f_part(Var_AGENT,Var_WEAPON)))))))).

fof(axWMDLem2, axiom, 
 ( ! [Var_SUBSTANCE] : 
 (hasType(type_Toxin, Var_SUBSTANCE) => 
(( ? [Var_ORGANISM] : 
 (hasType(type_ToxicOrganism, Var_ORGANISM) &  
(( ? [Var_PROCESS] : 
 (hasType(type_BiologicalProcess, Var_PROCESS) &  
(((f_instrument(Var_PROCESS,Var_ORGANISM)) & (((f_result(Var_PROCESS,Var_SUBSTANCE)) | (( ? [Var_RESULT] : 
 ((hasType(type_Entity, Var_RESULT) & hasType(type_Object, Var_RESULT)) &  
(((f_result(Var_PROCESS,Var_RESULT)) & (f_copy(Var_SUBSTANCE,Var_RESULT)))))))))))))))))))).

fof(axWMDLem3, axiom, 
 ( ! [Var_ORGANISM] : 
 (hasType(type_ToxicOrganism, Var_ORGANISM) => 
(( ? [Var_SUBSTANCE] : 
 (hasType(type_Toxin, Var_SUBSTANCE) &  
(f_part(Var_SUBSTANCE,Var_ORGANISM)))))))).

fof(axWMDLem4, axiom, 
 ( ! [Var_BACTERIUM] : 
 (hasType(type_Bacterium, Var_BACTERIUM) => 
(( ? [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) &  
(((f_width(Var_BACTERIUM,f_MeasureFn(Var_NUMBER,inst_Meter))) & (((f_greaterThanOrEqualTo(Var_NUMBER,1.0e-6)) & (f_lessThanOrEqualTo(Var_NUMBER,2.0e-6)))))))))))).

fof(axWMDLem5, axiom, 
 ( ! [Var_SUBSTANCE] : 
 (hasType(type_Mycotoxin, Var_SUBSTANCE) => 
(( ! [Var_ORGANISM] : 
 (hasType(type_Object, Var_ORGANISM) => 
(( ? [Var_FUNGUS] : 
 (hasType(type_FungalAgent, Var_FUNGUS) &  
(( ? [Var_PROCESS] : 
 (hasType(type_BiologicalProcess, Var_PROCESS) &  
(((f_instrument(Var_PROCESS,Var_ORGANISM)) & (f_result(Var_PROCESS,Var_SUBSTANCE)))))))))))))))).

fof(axWMDLem6, axiom, 
 ( ! [Var_ORGANISM] : 
 (hasType(type_GeneticallyEngineeredOrganism, Var_ORGANISM) => 
(( ? [Var_PROCESS] : 
 (hasType(type_IntentionalProcess, Var_PROCESS) &  
(f_result(Var_PROCESS,Var_ORGANISM)))))))).

fof(axWMDLem7, axiom, 
 ( ! [Var_WEAPON] : 
 (hasType(type_ChemicalWeapon, Var_WEAPON) => 
(( ? [Var_AGENT] : 
 (hasType(type_ChemicalAgent, Var_AGENT) &  
(f_part(Var_AGENT,Var_WEAPON)))))))).

fof(axWMDLem8, axiom, 
 ( ! [Var_AGENT] : 
 (hasType(type_ChemicalAgent, Var_AGENT) => 
(( ? [Var_ORGANISM] : 
 (hasType(type_Organism, Var_ORGANISM) &  
(( ? [Var_PROCESS] : 
 (hasType(type_BiologicalProcess, Var_PROCESS) &  
(( ? [Var_SUBSTANCE] : 
 ((hasType(type_Entity, Var_SUBSTANCE) & hasType(type_Object, Var_SUBSTANCE)) &  
(((f_instrument(Var_PROCESS,Var_ORGANISM)) & (((f_result(Var_PROCESS,Var_SUBSTANCE)) & (f_copy(Var_SUBSTANCE,Var_AGENT)))))))))))))))))).

fof(axWMDLem9, axiom, 
 ( ! [Var_FACILITY] : 
 (hasType(type_WMDWeaponsProductionFacility, Var_FACILITY) => 
(( ? [Var_DEVELOP] : 
 (hasType(type_DevelopingWeaponOfMassDestruction, Var_DEVELOP) &  
(f_located(Var_DEVELOP,Var_FACILITY)))))))).

fof(axWMDLem10, axiom, 
 ( ! [Var_FACILITY] : 
 (hasType(type_WMDWeaponsResearchFacility, Var_FACILITY) => 
(( ? [Var_RESEARCH] : 
 (hasType(type_ResearchingWeaponOfMassDestruction, Var_RESEARCH) &  
(f_located(Var_RESEARCH,Var_FACILITY)))))))).

fof(axWMDLem11, axiom, 
 ( ! [Var_DISMANTLE] : 
 (hasType(type_DismantlingWeaponOfMassDestruction, Var_DISMANTLE) => 
(( ! [Var_WEAPON] : 
 (hasType(type_Entity, Var_WEAPON) => 
(((f_patient(Var_DISMANTLE,Var_WEAPON)) => (( ? [Var_DEVELOP] : 
 (hasType(type_DevelopingWeaponOfMassDestruction, Var_DEVELOP) &  
(((f_result(Var_DEVELOP,Var_WEAPON)) & (f_earlier(f_WhenFn(Var_DEVELOP),f_WhenFn(Var_DISMANTLE)))))))))))))))).

fof(axWMDLem12, axiom, 
 ( ! [Var_ORGANISM] : 
 (hasType(type_Object, Var_ORGANISM) => 
(( ! [Var_SYMPTOM] : 
 ((hasType(type_DiseaseOrSyndrome, Var_SYMPTOM) & hasType(type_Attribute, Var_SYMPTOM)) => 
(( ! [Var_DISEASE] : 
 ((hasType(type_DiseaseOrSyndrome, Var_DISEASE) & hasType(type_Attribute, Var_DISEASE)) => 
(((f_diseaseSymptom(Var_DISEASE,Var_SYMPTOM)) => (f_increasesLikelihood(attribute(Var_ORGANISM,Var_DISEASE),attribute(Var_ORGANISM,Var_SYMPTOM)))))))))))))).

fof(axWMDLem13, axiom, 
 ( ! [Var_RATE] : 
 ((hasType(type_RealNumber, Var_RATE) & hasType(type_Quantity, Var_RATE)) => 
(( ! [Var_DISEASE] : 
 (hasType(type_DiseaseOrSyndrome, Var_DISEASE) => 
(((f_diseaseMortality(Var_DISEASE,Var_RATE)) => (((f_greaterThan(Var_RATE,0)) & (f_lessThan(Var_RATE,1)))))))))))).

fof(axWMDLem14, axiom, 
 ( ! [Var_ORGANISM] : 
 (hasType(type_Human, Var_ORGANISM) => 
(((f_attribute(Var_ORGANISM,inst_Fever)) => (( ? [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) &  
(((f_measure(Var_ORGANISM,f_MeasureFn(Var_NUMBER,inst_FahrenheitDegree))) & (f_greaterThan(Var_NUMBER,98.6)))))))))))).

fof(axWMDLem15, axiom, 
 ( ! [Var_ORGANISM] : 
 ((hasType(type_Object, Var_ORGANISM) & hasType(type_Agent, Var_ORGANISM)) => 
(((f_attribute(Var_ORGANISM,inst_InhalationalAnthrax)) => (( ? [Var_ANTHRACIS] : 
 (hasType(type_BacillusAnthracis, Var_ANTHRACIS) &  
(( ? [Var_BREATHING] : 
 (hasType(type_Breathing, Var_BREATHING) &  
(((f_agent(Var_BREATHING,Var_ORGANISM)) & (f_patient(Var_BREATHING,Var_ANTHRACIS))))))))))))))).

fof(axWMDLem16, axiom, 
 ( ! [Var_VIRUS] : 
 (hasType(type_YellowFeverVirus, Var_VIRUS) => 
(( ? [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Entity, Var_NUMBER)) &  
(((f_width(Var_VIRUS,f_MeasureFn(Var_NUMBER,inst_Meter))) & (Var_NUMBER = 2.0e-8))))))))).

fof(axWMDLem17, axiom, 
 ( ! [Var_VIRUS1] : 
 (hasType(type_FootAndMouthVirus, Var_VIRUS1) => 
(( ! [Var_VIRUS2] : 
 (hasType(type_YellowFeverVirus, Var_VIRUS2) => 
(f_smaller(Var_VIRUS1,Var_VIRUS2)))))))).

fof(axWMDLem18, axiom, 
 ( ! [Var_DISEASE] : 
 (hasType(type_Hepatitis, Var_DISEASE) => 
(f_biochemicalAgentSyndrome(type_HepatitisVirus,Var_DISEASE))))).

