fof(axMilitaryLem0, axiom, 
 ( ! [Var_MO] : 
 (hasType(type_MilitaryOperation, Var_MO) => 
(( ? [Var_PLAN] : 
 (hasType(type_Plan, Var_PLAN) &  
(f_represents(Var_PLAN,Var_MO)))))))).

fof(axMilitaryLem1, axiom, 
 ( ! [Var_PLAN] : 
 (hasType(type_Plan, Var_PLAN) => 
(( ! [Var_PROC] : 
 (hasType(type_Process, Var_PROC) => 
(( ! [Var_PLANNNG] : 
 (hasType(type_Process, Var_PLANNNG) => 
(((f_represents(Var_PLAN,Var_PROC)) => (( ? [Var_PLANNING] : 
 (hasType(type_Planning, Var_PLANNING) &  
(( ? [Var_CBO] : 
 (hasType(type_ContentBearingPhysical, Var_CBO) &  
(((f_containsInformation(Var_CBO,Var_PLAN)) & (((f_result(Var_PLANNNG,Var_CBO)) & (((f_earlier(f_BeginFn(f_WhenFn(Var_PLANNING)),f_BeginFn(f_WhenFn(Var_PROC)))) & (f_earlier(f_EndFn(f_WhenFn(Var_PLANNING)),f_EndFn(f_WhenFn(Var_PROC))))))))))))))))))))))))))).

fof(axMilitaryLem2, axiom, 
 ( ! [Var_FD] : 
 (hasType(type_FoodDistributionOperation, Var_FD) => 
(( ? [Var_GI] : 
 ((hasType(type_Giving, Var_GI) & hasType(type_Getting, Var_GI)) &  
(( ? [Var_GE] : 
 (hasType(type_Process, Var_GE) &  
(((f_subProcess(Var_GI,Var_FD)) & (f_subProcess(Var_GE,Var_FD))))))))))))).

fof(axMilitaryLem3, axiom, 
 ( ! [Var_FD] : 
 (hasType(type_FoodDistributionOperation, Var_FD) => 
(( ? [Var_FOOD] : 
 (hasType(type_Food, Var_FOOD) &  
(( ? [Var_CA] : 
 (hasType(type_CognitiveAgent, Var_CA) &  
(((f_patient(Var_FD,Var_FOOD)) & (((f_destination(Var_FD,Var_CA)) & (f_holdsDuring(f_ImmediateFutureFn(f_WhenFn(Var_FD)),possesses(Var_CA,Var_FOOD)))))))))))))))).

fof(axMilitaryLem4, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Convoy, Var_C) => 
(( ! [Var_X2] : 
 ((hasType(type_SelfConnectedObject, Var_X2) & hasType(type_Entity, Var_X2) & hasType(type_Agent, Var_X2)) => 
(( ! [Var_X1] : 
 ((hasType(type_SelfConnectedObject, Var_X1) & hasType(type_Entity, Var_X1) & hasType(type_Agent, Var_X1)) => 
(((((f_member(Var_X1,Var_C)) & (((f_member(Var_X2,Var_C)) & (Var_X1 != Var_X2))))) => (( ? [Var_P1] : 
 (hasType(type_Transportation, Var_P1) &  
(( ? [Var_P2] : 
 (hasType(type_Transportation, Var_P2) &  
(( ? [Var_D] : 
 (hasType(type_Entity, Var_D) &  
(((f_agent(Var_P1,Var_X1)) & (((f_agent(Var_P2,Var_X2)) & (((f_destination(Var_P1,Var_D)) & (f_destination(Var_P2,Var_D)))))))))))))))))))))))))))).

fof(axMilitaryLem5, axiom, 
 ( ! [Var_ATTR] : 
 (hasType(type_USMilitaryRank, Var_ATTR) => 
(( ! [Var_PERSON] : 
 ((hasType(type_Object, Var_PERSON) & hasType(type_SelfConnectedObject, Var_PERSON)) => 
(((f_attribute(Var_PERSON,Var_ATTR)) => (( ? [Var_MO] : 
 ((hasType(type_Collection, Var_MO) & hasType(type_MilitaryOrganization, Var_MO)) &  
(((f_member(Var_PERSON,Var_MO)) & (f_militaryOfArea(Var_MO,inst_UnitedStates))))))))))))))).

fof(axMilitaryLem6, axiom, 
 ( ! [Var_AB] : 
 (hasType(type_InfantryUnit, Var_AB) => 
(( ! [Var_C] : 
 (hasType(type_Object, Var_C) => 
(( ? [Var_AC] : 
 ((hasType(type_AutomaticGun, Var_AC) & hasType(type_Firearm, Var_AC) & hasType(type_MortarGun, Var_AC) & hasType(type_ExplosiveMine, Var_AC)) &  
(f_possesses(Var_AB,Var_C))))))))))).

fof(axMilitaryLem7, axiom, 
 ( ! [Var_C] : 
 ((hasType(type_Nation, Var_C) & hasType(type_Object, Var_C)) => 
(( ! [Var_P] : 
 ((hasType(type_Human, Var_P) & hasType(type_Physical, Var_P)) => 
(((((f_citizen(Var_P,Var_C)) & (( ~ ( ? [Var_L] : 
 (hasType(type_Object, Var_L) &  
(f_located(Var_P,Var_L)))))))) => (f_located(Var_P,Var_C)))))))))).

fof(axMilitaryLem8, axiom, 
 ( ! [Var_MILITARY] : 
 (hasType(type_MilitaryOrganization, Var_MILITARY) => 
(( ? [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) &  
(f_militaryOfArea(Var_MILITARY,Var_AREA)))))))).

fof(axMilitaryLem9, axiom, 
 ( ! [Var_AGENT] : 
 ((hasType(type_SelfConnectedObject, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(( ! [Var_MILITARY] : 
 ((hasType(type_MilitaryOrganization, Var_MILITARY) & hasType(type_Collection, Var_MILITARY)) => 
(( ! [Var_MILITARYAGE] : 
 ((hasType(type_TimeDuration, Var_MILITARYAGE) & hasType(type_Quantity, Var_MILITARYAGE)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((((f_militaryAge(Var_AREA,Var_MILITARYAGE)) & (((f_militaryOfArea(Var_MILITARY,Var_AREA)) & (f_member(Var_AGENT,Var_MILITARY)))))) => (( ? [Var_AGE] : 
 ((hasType(type_TimeDuration, Var_AGE) & hasType(type_Quantity, Var_AGE)) &  
(((f_age(Var_AGENT,Var_AGE)) & (f_greaterThanOrEqualTo(Var_AGE,Var_MILITARYAGE))))))))))))))))))))).

fof(axMilitaryLem10, axiom, 
 ( ! [Var_AGE] : 
 ((hasType(type_TimeDuration, Var_AGE) & hasType(type_Quantity, Var_AGE)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_SelfConnectedObject, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(( ! [Var_MILITARY] : 
 ((hasType(type_MilitaryOrganization, Var_MILITARY) & hasType(type_Collection, Var_MILITARY)) => 
(( ! [Var_MILITARYAGE] : 
 ((hasType(type_TimeDuration, Var_MILITARYAGE) & hasType(type_Quantity, Var_MILITARYAGE)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((((f_militaryAge(Var_AREA,Var_MILITARYAGE)) & (((f_militaryOfArea(Var_MILITARY,Var_AREA)) & (((f_member(Var_AGENT,Var_MILITARY)) & (f_age(Var_AGENT,Var_AGE)))))))) => (f_greaterThanOrEqualTo(Var_AGE,Var_MILITARYAGE))))))))))))))))))).

fof(axMilitaryLem11, axiom, 
 ( ! [Var_PERIOD] : 
 (hasType(type_TimeInterval, Var_PERIOD) => 
(( ! [Var_FRACTION] : 
 ((hasType(type_RationalNumber, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((f_militaryExpendituresFractionOfGDPInPeriod(Var_AREA,Var_FRACTION,Var_PERIOD)) => (f_lessThanOrEqualTo(Var_FRACTION,1.0))))))))))))).

fof(axMilitaryLem12, axiom, 
 ( ! [Var_FRACTION] : 
 ((hasType(type_RationalNumber, Var_FRACTION) & hasType(type_Quantity, Var_FRACTION)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((f_militaryExpendituresFractionOfGDP(Var_AREA,Var_FRACTION)) => (f_lessThanOrEqualTo(Var_FRACTION,1.0)))))))))).

