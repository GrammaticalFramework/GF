fof(axMidLem0, axiom, 
 ( ! [Var_CORPSE] : 
 (hasType(type_HumanCorpse, Var_CORPSE) => 
(( ? [Var_HUMAN] : 
 (hasType(type_Human, Var_HUMAN) &  
(((f_before(f_WhenFn(Var_HUMAN),f_WhenFn(Var_CORPSE))) & (( ~ ( ? [Var_OTHERPART] : 
 (hasType(type_Object, Var_OTHERPART) &  
(((f_holdsDuring(f_WhenFn(Var_CORPSE),part(Var_OTHERPART,Var_CORPSE))) & (( ~ (f_holdsDuring(f_WhenFn(Var_HUMAN),part(Var_OTHERPART,Var_HUMAN))))))))))))))))))).

fof(axMidLem1, axiom, 
 ( ! [Var_CORPSE] : 
 (hasType(type_HumanCorpse, Var_CORPSE) => 
(f_attribute(Var_CORPSE,inst_Dead))))).

fof(axMidLem2, axiom, 
 ( ! [Var_SLAVE] : 
 ((hasType(type_Object, Var_SLAVE) & hasType(type_Entity, Var_SLAVE)) => 
(((f_attribute(Var_SLAVE,inst_HumanSlave)) => (( ? [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) &  
(((Var_PERSON != Var_SLAVE) & (f_possesses(Var_PERSON,Var_SLAVE)))))))))))).

fof(axMidLem3, axiom, 
 ( ! [Var_ADULT] : 
 (hasType(type_HumanAdult, Var_ADULT) => 
(( ! [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((f_age(Var_ADULT,f_MeasureFn(Var_NUMBER,inst_YearDuration))) => (f_greaterThanOrEqualTo(Var_NUMBER,18)))))))))).

fof(axMidLem4, axiom, 
 ( ! [Var_YOUTH] : 
 (hasType(type_HumanYouth, Var_YOUTH) => 
(( ! [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((f_age(Var_YOUTH,f_MeasureFn(Var_NUMBER,inst_YearDuration))) => (f_lessThan(Var_NUMBER,18)))))))))).

fof(axMidLem5, axiom, 
 ( ! [Var_CHILD] : 
 (hasType(type_HumanChild, Var_CHILD) => 
(f_attribute(Var_CHILD,inst_NonFullyFormed))))).

fof(axMidLem6, axiom, 
 ( ! [Var_CHILD] : 
 (hasType(type_HumanChild, Var_CHILD) => 
(( ! [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((f_age(Var_CHILD,f_MeasureFn(Var_NUMBER,inst_YearDuration))) => (f_lessThanOrEqualTo(Var_NUMBER,14)))))))))).

fof(axMidLem7, axiom, 
 ( ! [Var_TEEN] : 
 (hasType(type_Teenager, Var_TEEN) => 
(( ! [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((f_age(Var_TEEN,f_MeasureFn(Var_NUMBER,inst_YearDuration))) => (((f_greaterThan(Var_NUMBER,12)) & (f_lessThan(Var_NUMBER,20)))))))))))).

fof(axMidLem8, axiom, 
 ( ! [Var_BABY] : 
 (hasType(type_HumanBaby, Var_BABY) => 
(( ! [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((f_age(Var_BABY,f_MeasureFn(Var_NUMBER,inst_YearDuration))) => (f_lessThanOrEqualTo(Var_NUMBER,1)))))))))).

fof(axMidLem9, axiom, 
 ( ! [Var_O2] : 
 (hasType(type_Object, Var_O2) => 
(( ! [Var_O1] : 
 (hasType(type_Object, Var_O1) => 
(((f_older(Var_O1,Var_O2)) => (( ? [Var_U] : 
 (hasType(type_UnitOfMeasure, Var_U) &  
(( ? [Var_N2] : 
 ((hasType(type_RealNumber, Var_N2) & hasType(type_Quantity, Var_N2)) &  
(( ? [Var_N1] : 
 ((hasType(type_RealNumber, Var_N1) & hasType(type_Quantity, Var_N1)) &  
(((f_age(Var_O1,f_MeasureFn(Var_N1,Var_U))) & (((f_age(Var_O2,f_MeasureFn(Var_N2,Var_U))) & (f_greaterThan(Var_N1,Var_N2))))))))))))))))))))))).

fof(axMidLem10, axiom, 
 ( ! [Var_P] : 
 (hasType(type_Wading, Var_P) => 
(( ? [Var_W] : 
 (hasType(type_BodyOfWater, Var_W) &  
(f_located(Var_P,Var_W)))))))).

fof(axMidLem11, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Somersaulting, Var_S) => 
(( ! [Var_A] : 
 ((hasType(type_Agent, Var_A) & hasType(type_Object, Var_A)) => 
(((f_agent(Var_S,Var_A)) => (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_S)),attribute(Var_A,inst_Sitting))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_S)),attribute(Var_A,inst_Sitting))))))))))))).

fof(axMidLem12, axiom, 
 ( ! [Var_L] : 
 (hasType(type_Sunlight, Var_L) => 
(f_origin(Var_L,inst_Sol))))).

fof(axMidLem13, axiom, 
 ( ! [Var_W] : 
 (hasType(type_WrittenCommunication, Var_W) => 
(( ? [Var_T] : 
 (hasType(type_Text, Var_T) &  
(( ? [Var_C] : 
 (hasType(type_Character, Var_C) &  
(( ? [Var_S] : 
 (hasType(type_Script, Var_S) &  
(((f_result(Var_W,Var_T)) & (((f_part(Var_C,Var_T)) & (f_member(Var_C,Var_S)))))))))))))))))).

fof(axMidLem14, axiom, 
 ( ! [Var_T] : 
 (hasType(type_Paragraph, Var_T) => 
(( ? [Var_S] : 
 (hasType(type_Sentence, Var_S) &  
(f_part(Var_S,Var_T)))))))).

fof(axMidLem15, axiom, 
 ( ! [Var_MUSIC] : 
 (hasType(type_InstrumentalMusic, Var_MUSIC) => 
(( ? [Var_INSTRUMENT] : 
 (hasType(type_MusicalInstrument, Var_INSTRUMENT) &  
(f_instrument(Var_MUSIC,Var_INSTRUMENT)))))))).

fof(axMidLem16, axiom, 
 ( ! [Var_M] : 
 (hasType(type_VocalMusic, Var_M) => 
(( ? [Var_S] : 
 (hasType(type_Singing, Var_S) &  
(f_subProcess(Var_S,Var_M)))))))).

fof(axMidLem17, axiom, 
 ( ! [Var_WI] : 
 (hasType(type_WindInstrument, Var_WI) => 
(( ! [Var_M] : 
 (hasType(type_Music, Var_M) => 
(( ! [Var_A] : 
 (hasType(type_Agent, Var_A) => 
(((((f_agent(Var_M,Var_A)) & (f_instrument(Var_M,Var_WI)))) => (( ? [Var_B] : 
 (hasType(type_Exhaling, Var_B) &  
(((f_agent(Var_B,Var_A)) & (f_subProcess(Var_B,Var_M)))))))))))))))))).

fof(axMidLem18, axiom, 
 ( ! [Var_R] : 
 (hasType(type_Ringing, Var_R) => 
(( ? [Var_B] : 
 (hasType(type_Bell, Var_B) &  
(f_instrument(Var_R,Var_B)))))))).

fof(axMidLem19, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Bell, Var_B) => 
(( ! [Var_I] : 
 (hasType(type_Impacting, Var_I) => 
(((f_destination(Var_I,Var_B)) => (( ? [Var_MT] : 
 (hasType(type_MusicalTone, Var_MT) &  
(f_causes(Var_I,Var_MT))))))))))))).

fof(axMidLem20, axiom, 
 ( ! [Var_D] : 
 (hasType(type_Drumming, Var_D) => 
(( ? [Var_DRUM] : 
 (hasType(type_Drum, Var_DRUM) &  
(( ? [Var_I] : 
 (hasType(type_Impacting, Var_I) &  
(( ? [Var_A] : 
 (hasType(type_Agent, Var_A) &  
(((f_agent(Var_D,Var_A)) & (((f_instrument(Var_D,Var_DRUM)) & (((f_subProcess(Var_I,Var_D)) & (((f_agent(Var_I,Var_A)) & (f_patient(Var_I,Var_DRUM)))))))))))))))))))))).

fof(axMidLem21, axiom, 
 ( ! [Var_COMMUNICATE] : 
 (hasType(type_WrittenCommunication, Var_COMMUNICATE) => 
(( ? [Var_WRITE] : 
 (hasType(type_Writing, Var_WRITE) &  
(( ? [Var_READ] : 
 (hasType(type_Reading, Var_READ) &  
(( ? [Var_TEXT] : 
 (hasType(type_Text, Var_TEXT) &  
(((f_instrument(Var_COMMUNICATE,Var_TEXT)) & (((f_result(Var_WRITE,Var_TEXT)) & (((f_patient(Var_READ,Var_TEXT)) & (((f_subProcess(Var_WRITE,Var_COMMUNICATE)) & (f_subProcess(Var_READ,Var_COMMUNICATE)))))))))))))))))))))).

fof(axMidLem22, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Corresponding, Var_C) => 
(( ? [Var_M] : 
 (hasType(type_Mailing, Var_M) &  
(( ? [Var_T] : 
 (hasType(type_Text, Var_T) &  
(((f_subProcess(Var_M,Var_C)) & (((f_patient(Var_M,Var_T)) & (f_patient(Var_C,Var_T))))))))))))))).

fof(axMidLem23, axiom, 
 ( ! [Var_REMIND] : 
 (hasType(type_Reminding, Var_REMIND) => 
(( ? [Var_REMEMBER] : 
 (hasType(type_Remembering, Var_REMEMBER) &  
(f_causes(Var_REMIND,Var_REMEMBER)))))))).

fof(axMidLem24, axiom, 
 ( ! [Var_ACTION] : 
 (hasType(type_LegalAction, Var_ACTION) => 
(( ? [Var_REGISTER] : 
 (hasType(type_Registering, Var_REGISTER) &  
(f_subProcess(Var_REGISTER,Var_ACTION)))))))).

fof(axMidLem25, axiom, 
 ( ! [Var_ANSWER] : 
 (hasType(type_Answering, Var_ANSWER) => 
(( ? [Var_QUESTION] : 
 (hasType(type_Questioning, Var_QUESTION) &  
(((f_refers(Var_ANSWER,Var_QUESTION)) & (f_earlier(f_WhenFn(Var_QUESTION),f_WhenFn(Var_ANSWER))))))))))).

fof(axMidLem26, axiom, 
 ( ! [Var_ARGUE] : 
 (hasType(type_Arguing, Var_ARGUE) => 
(( ? [Var_STATEMENT] : 
 (hasType(type_Statement, Var_STATEMENT) &  
(( ? [Var_ARGUMENT] : 
 (hasType(type_Argument, Var_ARGUMENT) &  
(((f_patient(Var_ARGUE,Var_STATEMENT)) & (f_containsInformation(Var_STATEMENT,Var_ARGUMENT))))))))))))).

fof(axMidLem27, axiom, 
 ( ! [Var_STATE] : 
 (hasType(type_TellingALie, Var_STATE) => 
(( ! [Var_STATEMENT] : 
 ((hasType(type_Entity, Var_STATEMENT) & hasType(type_Sentence, Var_STATEMENT)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_CognitiveAgent, Var_AGENT)) => 
(((((f_agent(Var_STATE,Var_AGENT)) & (f_patient(Var_STATE,Var_STATEMENT)))) => (f_holdsDuring(f_WhenFn(Var_STATE),believes(Var_AGENT,truth(Var_STATEMENT,inst_False))))))))))))))).

fof(axMidLem28, axiom, 
 ( ! [Var_FOUND] : 
 (hasType(type_Founding, Var_FOUND) => 
(( ? [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) &  
(f_result(Var_FOUND,Var_ORG)))))))).

fof(axMidLem29, axiom, 
 ( ! [Var_P] : 
 (hasType(type_TurningOffDevice, Var_P) => 
(( ! [Var_D] : 
 ((hasType(type_Entity, Var_D) & hasType(type_Object, Var_D)) => 
(((f_patient(Var_P,Var_D)) => (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_P)),attribute(Var_D,inst_DeviceOn))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_P)),attribute(Var_D,inst_DeviceOff))))))))))))).

fof(axMidLem30, axiom, 
 ( ! [Var_P] : 
 (hasType(type_TurningOnDevice, Var_P) => 
(( ! [Var_D] : 
 ((hasType(type_Entity, Var_D) & hasType(type_Object, Var_D)) => 
(((f_patient(Var_P,Var_D)) => (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_P)),attribute(Var_D,inst_DeviceOff))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_P)),attribute(Var_D,inst_DeviceOn))))))))))))).

fof(axMidLem31, axiom, 
 ( ! [Var_PROJECTILE] : 
 (hasType(type_Projectile, Var_PROJECTILE) => 
(( ? [Var_SHELL] : 
 (hasType(type_ProjectileShell, Var_SHELL) &  
(f_part(Var_SHELL,Var_PROJECTILE)))))))).

fof(axMidLem32, axiom, 
 ( ! [Var_SHOOT] : 
 (hasType(type_Shooting, Var_SHOOT) => 
(( ? [Var_PROJECTILE] : 
 (hasType(type_Projectile, Var_PROJECTILE) &  
(( ? [Var_GUN] : 
 (hasType(type_Gun, Var_GUN) &  
(((f_patient(Var_SHOOT,Var_PROJECTILE)) & (f_instrument(Var_SHOOT,Var_GUN))))))))))))).

fof(axMidLem33, axiom, 
 ( ! [Var_B] : 
 (hasType(type_GunBarrel, Var_B) => 
(( ? [Var_G] : 
 (hasType(type_Gun, Var_G) &  
(f_part(Var_B,Var_G)))))))).

fof(axMidLem34, axiom, 
 ( ! [Var_G] : 
 (hasType(type_Gun, Var_G) => 
(( ! [Var_B] : 
 (hasType(type_GunBarrel, Var_B) => 
(( ! [Var_S] : 
 (hasType(type_Shooting, Var_S) => 
(( ! [Var_P] : 
 (hasType(type_Projectile, Var_P) => 
(( ! [Var_GUN] : 
 (hasType(type_Object, Var_GUN) => 
(((((f_part(Var_B,Var_G)) & (((f_instrument(Var_S,Var_GUN)) & (f_patient(Var_S,Var_P)))))) => (( ? [Var_SUB] : 
 ((hasType(type_Process, Var_SUB) & hasType(type_Motion, Var_SUB)) &  
(((f_subProcess(Var_SUB,Var_S)) & (f_path(Var_SUB,Var_B)))))))))))))))))))))))).

fof(axMidLem35, axiom, 
 ( ! [Var_STOCK] : 
 (hasType(type_GunStock, Var_STOCK) => 
(( ? [Var_GUN] : 
 (hasType(type_Gun, Var_GUN) &  
(f_part(Var_STOCK,Var_GUN)))))))).

fof(axMidLem36, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Shield, Var_S) => 
(( ? [Var_H] : 
 (hasType(type_Handle, Var_H) &  
(f_part(Var_H,Var_S)))))))).

fof(axMidLem37, axiom, 
 ( ! [Var_W] : 
 (hasType(type_WingDevice, Var_W) => 
(( ? [Var_A] : 
 (hasType(type_Aircraft, Var_A) &  
(f_part(Var_W,Var_A)))))))).

fof(axMidLem38, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Shelf, Var_S) => 
(( ? [Var_F] : 
 (hasType(type_Furniture, Var_F) &  
(f_part(Var_S,Var_F)))))))).

fof(axMidLem39, axiom, 
 ( ! [Var_C] : 
 ((hasType(type_Object, Var_C) & hasType(type_SelfConnectedObject, Var_C) & hasType(type_Hole, Var_C)) => 
(((f_attribute(Var_C,inst_ContainerFull)) => (( ? [Var_H] : 
 (hasType(type_Hole, Var_H) &  
(( ? [Var_S] : 
 (hasType(type_Object, Var_S) &  
(((f_hole(Var_H,Var_C)) & (f_fills(Var_S,Var_C))))))))))))))).

fof(axMidLem40, axiom, 
 ( ! [Var_PP] : 
 (hasType(type_PetroleumProduct, Var_PP) => 
(( ? [Var_O] : 
 (hasType(type_OrganicCompound, Var_O) &  
(f_part(Var_O,Var_PP)))))))).

fof(axMidLem41, axiom, 
 ( ! [Var_DEVICE] : 
 (hasType(type_SwitchDevice, Var_DEVICE) => 
(( ? [Var_ELECTRIC] : 
 (hasType(type_ElectricDevice, Var_ELECTRIC) &  
(( ? [Var_PROC2] : 
 (hasType(type_Process, Var_PROC2) &  
(( ? [Var_PROC1] : 
 (hasType(type_Process, Var_PROC1) &  
(((f_instrument(Var_PROC1,Var_DEVICE)) & (((f_causes(Var_PROC1,Var_PROC2)) & (f_instrument(Var_PROC2,Var_ELECTRIC)))))))))))))))))).

fof(axMidLem42, axiom, 
 ( ! [Var_AERATE] : 
 (hasType(type_Aerating, Var_AERATE) => 
(( ? [Var_AIR] : 
 (hasType(type_Air, Var_AIR) &  
(( ? [Var_S] : 
 ((hasType(type_Entity, Var_S) & hasType(type_Object, Var_S)) &  
(((f_patient(Var_AERATE,Var_AIR)) & (((f_patient(Var_AERATE,Var_S)) & (f_attribute(Var_S,inst_Liquid))))))))))))))).

fof(axMidLem43, axiom, 
 ( ! [Var_C] : 
 (hasType(type_CigarOrCigarette, Var_C) => 
(( ? [Var_T] : 
 (hasType(type_Tobacco, Var_T) &  
(f_part(Var_T,Var_C)))))))).

fof(axMidLem44, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Compass, Var_C) => 
(( ? [Var_D] : 
 (hasType(type_DirectionalAttribute, Var_D) &  
(f_represents(Var_C,Var_D)))))))).

fof(axMidLem45, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Crane, Var_C) => 
(( ? [Var_H] : 
 (hasType(type_HoistingDevice, Var_H) &  
(f_component(Var_H,Var_C)))))))).

fof(axMidLem46, axiom, 
 ( ! [Var_DEV] : 
 (hasType(type_ElectricDevice, Var_DEV) => 
(( ! [Var_EV] : 
 (hasType(type_Process, Var_EV) => 
(((f_patient(Var_EV,Var_DEV)) => (( ? [Var_R] : 
 (hasType(type_Electricity, Var_R) &  
(f_resourceS(Var_EV,Var_R))))))))))))).

fof(axMidLem47, axiom, 
 ( ! [Var_S] : 
 (hasType(type_ElectricalSignalling, Var_S) => 
(( ? [Var_D] : 
 (hasType(type_ElectricDevice, Var_D) &  
(f_instrument(Var_S,Var_D)))))))).

fof(axMidLem48, axiom, 
 ( ! [Var_S] : 
 (hasType(type_ElectronicSignalling, Var_S) => 
(( ? [Var_D] : 
 (hasType(type_Computer, Var_D) &  
(f_instrument(Var_S,Var_D)))))))).

fof(axMidLem49, axiom, 
 ( ! [Var_S] : 
 (hasType(type_SafeContainer, Var_S) => 
(( ? [Var_L] : 
 (hasType(type_Lock, Var_L) &  
(f_part(Var_L,Var_S)))))))).

fof(axMidLem50, axiom, 
 ( ! [Var_DEVICE] : 
 (hasType(type_SelfPoweredDevice, Var_DEVICE) => 
(( ? [Var_SOURCE] : 
 (hasType(type_Device, Var_SOURCE) &  
(f_powerPlant(Var_DEVICE,Var_SOURCE)))))))).

fof(axMidLem51, axiom, 
 ( ! [Var_D] : 
 (hasType(type_AnimalPoweredDevice, Var_D) => 
(( ! [Var_P] : 
 (hasType(type_Process, Var_P) => 
(((f_instrument(Var_P,Var_D)) => (( ? [Var_A] : 
 (hasType(type_Animal, Var_A) &  
(f_instrument(Var_P,Var_A))))))))))))).

fof(axMidLem52, axiom, 
 ( ! [Var_H] : 
 ((hasType(type_LengthMeasure, Var_H) & hasType(type_Quantity, Var_H)) => 
(( ! [Var_S2] : 
 ((hasType(type_SelfConnectedObject, Var_S2) & hasType(type_Object, Var_S2) & hasType(type_Entity, Var_S2) & hasType(type_Quantity, Var_S2)) => 
(( ! [Var_S1] : 
 ((hasType(type_SelfConnectedObject, Var_S1) & hasType(type_Object, Var_S1) & hasType(type_Entity, Var_S1) & hasType(type_Quantity, Var_S1)) => 
(( ! [Var_F] : 
 ((hasType(type_Object, Var_F) & hasType(type_SelfConnectedObject, Var_F)) => 
(((f_attribute(Var_F,inst_Flat)) => (((f_side(Var_S1,Var_F)) & (((f_side(Var_S2,Var_F)) & (((f_meetsSpatially(Var_S1,Var_S2)) & (((Var_S1 != Var_S2) & (((f_height(Var_F,Var_H)) & (((f_greaterThan(Var_S1,f_MultiplicationFn(2,Var_H))) & (f_greaterThan(Var_S2,f_MultiplicationFn(2,Var_H))))))))))))))))))))))))))))).

fof(axMidLem53, axiom, 
 ( ! [Var_H] : 
 ((hasType(type_PhysicalQuantity, Var_H) & hasType(type_Quantity, Var_H)) => 
(( ! [Var_S2] : 
 ((hasType(type_SelfConnectedObject, Var_S2) & hasType(type_Object, Var_S2) & hasType(type_Entity, Var_S2) & hasType(type_Quantity, Var_S2)) => 
(( ! [Var_S1] : 
 ((hasType(type_SelfConnectedObject, Var_S1) & hasType(type_Object, Var_S1) & hasType(type_Entity, Var_S1) & hasType(type_Quantity, Var_S1)) => 
(( ! [Var_F] : 
 ((hasType(type_Object, Var_F) & hasType(type_SelfConnectedObject, Var_F)) => 
(((f_attribute(Var_F,inst_LongAndThin)) => (((f_side(Var_S1,Var_F)) & (((f_side(Var_S2,Var_F)) & (((f_meetsSpatially(Var_S1,Var_S2)) & (((Var_S1 != Var_S2) & (((f_length(Var_F,Var_H)) & (((f_lessThan(Var_S1,f_MultiplicationFn(3,Var_H))) & (f_lessThan(Var_S2,f_MultiplicationFn(3,Var_H))))))))))))))))))))))))))))).

fof(axMidLem54, axiom, 
 ( ! [Var_O] : 
 ((hasType(type_Object, Var_O) & hasType(type_SelfConnectedObject, Var_O)) => 
(((f_attribute(Var_O,inst_LevelShape)) => (( ~ ( ? [Var_H2] : 
 ((hasType(type_LengthMeasure, Var_H2) & hasType(type_Quantity, Var_H2)) &  
(( ? [Var_H1] : 
 ((hasType(type_LengthMeasure, Var_H1) & hasType(type_Quantity, Var_H1)) &  
(( ? [Var_T] : 
 ((hasType(type_SelfConnectedObject, Var_T) & hasType(type_Object, Var_T)) &  
(( ? [Var_P2] : 
 ((hasType(type_Object, Var_P2) & hasType(type_SelfConnectedObject, Var_P2)) &  
(( ? [Var_P1] : 
 ((hasType(type_Object, Var_P1) & hasType(type_SelfConnectedObject, Var_P1)) &  
(((f_top(Var_T,Var_O)) & (((f_part(Var_P1,Var_T)) & (((f_part(Var_P2,Var_T)) & (((f_height(Var_P1,Var_H1)) & (((f_height(Var_P2,Var_H2)) & (f_greaterThan(Var_H1,Var_H2))))))))))))))))))))))))))))))))).

fof(axMidLem55, axiom, 
 ( ! [Var_T] : 
 ((hasType(type_Object, Var_T) & hasType(type_Entity, Var_T)) => 
(((f_attribute(Var_T,inst_SymmetricShape)) => (( ? [Var_C2] : 
 (hasType(type_Object, Var_C2) &  
(( ? [Var_C1] : 
 (hasType(type_Object, Var_C1) &  
(((f_copy(Var_C1,Var_C2)) & (Var_T = f_MereologicalSumFn(Var_C1,Var_C2))))))))))))))).

fof(axMidLem56, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Baton, Var_B) => 
(f_attribute(Var_B,inst_LongAndThin))))).

fof(axMidLem57, axiom, 
 ( ! [Var_N] : 
 (hasType(type_BroadcastNetwork, Var_N) => 
(( ? [Var_O] : 
 (hasType(type_Organization, Var_O) &  
(( ! [Var_M] : 
 ((hasType(type_SelfConnectedObject, Var_M) & hasType(type_Object, Var_M)) => 
(((f_member(Var_M,Var_N)) => (f_possesses(Var_O,Var_M))))))))))))).

fof(axMidLem58, axiom, 
 ( ! [Var_CANDLE] : 
 (hasType(type_Candle, Var_CANDLE) => 
(f_material(type_Wax,Var_CANDLE))))).

fof(axMidLem59, axiom, 
 ( ! [Var_L] : 
 (hasType(type_Lightning, Var_L) => 
(( ? [Var_C] : 
 (hasType(type_Cloud, Var_C) &  
(f_located(Var_L,Var_C)))))))).

fof(axMidLem60, axiom, 
 ( ! [Var_T] : 
 (hasType(type_Thunder, Var_T) => 
(( ? [Var_L] : 
 (hasType(type_Lightning, Var_L) &  
(f_causes(Var_L,Var_T)))))))).

fof(axMidLem61, axiom, 
 ( ! [Var_L] : 
 (hasType(type_VehicleLight, Var_L) => 
(( ? [Var_V] : 
 (hasType(type_Vehicle, Var_V) &  
(f_part(Var_L,Var_V)))))))).

fof(axMidLem62, axiom, 
 ( ! [Var_L] : 
 (hasType(type_Headlight, Var_L) => 
(( ? [Var_V] : 
 (hasType(type_Vehicle, Var_V) &  
(f_part(Var_L,f_FrontFn(Var_V))))))))).

fof(axMidLem63, axiom, 
 ( ! [Var_L] : 
 (hasType(type_Taillight, Var_L) => 
(( ? [Var_V] : 
 (hasType(type_Vehicle, Var_V) &  
(f_part(Var_L,f_BackFn(Var_V))))))))).

fof(axMidLem64, axiom, 
 ( ! [Var_PP] : 
 (hasType(type_PaintedPicture, Var_PP) => 
(( ? [Var_PAINT] : 
 (hasType(type_Paint, Var_PAINT) &  
(( ? [Var_PAINTING] : 
 (hasType(type_Painting, Var_PAINTING) &  
(((f_resourceS(Var_PAINTING,Var_PAINT)) & (f_result(Var_PAINTING,Var_PP))))))))))))).

fof(axMidLem65, axiom, 
 ( ! [Var_W] : 
 (hasType(type_WatercolorPicture, Var_W) => 
(( ? [Var_WP] : 
 (hasType(type_WatercolorPaint, Var_WP) &  
(( ? [Var_P] : 
 (hasType(type_Painting, Var_P) &  
(((f_resourceS(Var_P,Var_WP)) & (f_result(Var_P,Var_W))))))))))))).

fof(axMidLem66, axiom, 
 ( ! [Var_P] : 
 (hasType(type_Portrait, Var_P) => 
(( ? [Var_F] : 
 (hasType(type_Face, Var_F) &  
(f_represents(Var_P,Var_F)))))))).

fof(axMidLem67, axiom, 
 ( ! [Var_F] : 
 (hasType(type_Folding, Var_F) => 
(( ! [Var_O] : 
 ((hasType(type_Entity, Var_O) & hasType(type_Object, Var_O)) => 
(((f_patient(Var_F,Var_O)) => (( ? [Var_C] : 
 (hasType(type_Covering, Var_C) &  
(( ? [Var_P2] : 
 ((hasType(type_Object, Var_P2) & hasType(type_Entity, Var_P2)) &  
(( ? [Var_P1] : 
 (hasType(type_Object, Var_P1) &  
(((f_subProcess(Var_C,Var_F)) & (((f_part(Var_P1,Var_O)) & (((f_part(Var_P2,Var_O)) & (((f_instrument(Var_C,Var_P1)) & (f_patient(Var_C,Var_P2))))))))))))))))))))))))))).

fof(axMidLem68, axiom, 
 ( ! [Var_P] : 
 (hasType(type_WatercolorPaint, Var_P) => 
(( ? [Var_W] : 
 (hasType(type_Water, Var_W) &  
(f_part(Var_W,Var_P)))))))).

fof(axMidLem69, axiom, 
 ( ! [Var_P] : 
 (hasType(type_OilPaint, Var_P) => 
(( ? [Var_O] : 
 (hasType(type_Oil, Var_O) &  
(f_part(Var_O,Var_P)))))))).

fof(axMidLem70, axiom, 
 ( ! [Var_P] : 
 (hasType(type_OilPicture, Var_P) => 
(( ? [Var_O] : 
 (hasType(type_OilPaint, Var_O) &  
(( ? [Var_PAINTING] : 
 (hasType(type_Painting, Var_PAINTING) &  
(((f_resourceS(Var_PAINTING,Var_O)) & (f_result(Var_PAINTING,Var_P))))))))))))).

fof(axMidLem71, axiom, 
 ( ! [Var_PAINT] : 
 (hasType(type_ArtPainting, Var_PAINT) => 
(( ? [Var_PICTURE] : 
 (hasType(type_PaintedPicture, Var_PICTURE) &  
(f_result(Var_PAINT,Var_PICTURE)))))))).

fof(axMidLem72, axiom, 
 ( ! [Var_N] : 
 ((hasType(type_RealNumber, Var_N) & hasType(type_Quantity, Var_N)) => 
(( ! [Var_S] : 
 (hasType(type_Solution, Var_S) => 
(((f_potentialOfHydrogen(Var_S,Var_N)) => (((f_greaterThanOrEqualTo(Var_N,0)) & (f_lessThanOrEqualTo(Var_N,14)))))))))))).

fof(axMidLem73, axiom, 
 ( ! [Var_T] : 
 (hasType(type_Tracing, Var_T) => 
(( ? [Var_P] : 
 (hasType(type_Blueprint, Var_P) &  
(f_result(Var_T,Var_P)))))))).

fof(axMidLem74, axiom, 
 ( ! [Var_C] : 
 (hasType(type_ComposingMusic, Var_C) => 
(( ? [Var_M] : 
 (hasType(type_MusicalComposition, Var_M) &  
(f_result(Var_C,Var_M)))))))).

fof(axMidLem75, axiom, 
 ( ! [Var_DRAW] : 
 (hasType(type_Drawing, Var_DRAW) => 
(( ? [Var_SKETCH] : 
 (hasType(type_Sketch, Var_SKETCH) &  
(f_result(Var_DRAW,Var_SKETCH)))))))).

fof(axMidLem76, axiom, 
 ( ! [Var_F] : 
 (hasType(type_Focusing, Var_F) => 
(( ? [Var_L] : 
 (hasType(type_Lens, Var_L) &  
(f_patient(Var_F,Var_L)))))))).

fof(axMidLem77, axiom, 
 ( ! [Var_VEHICLE] : 
 (hasType(type_LandVehicle, Var_VEHICLE) => 
(( ? [Var_WHEEL] : 
 (hasType(type_Wheel, Var_WHEEL) &  
(f_part(Var_WHEEL,Var_VEHICLE)))))))).

fof(axMidLem78, axiom, 
 ( ! [Var_C] : 
 (hasType(type_VehicleController, Var_C) => 
(( ? [Var_V] : 
 (hasType(type_Vehicle, Var_V) &  
(f_part(Var_C,Var_V)))))))).

fof(axMidLem79, axiom, 
 ( ! [Var_W] : 
 (hasType(type_VehicleWindow, Var_W) => 
(( ? [Var_V] : 
 (hasType(type_Vehicle, Var_V) &  
(f_part(Var_W,Var_V)))))))).

fof(axMidLem80, axiom, 
 ( ! [Var_W] : 
 (hasType(type_Windshield, Var_W) => 
(( ? [Var_A] : 
 (hasType(type_Automobile, Var_A) &  
(f_part(Var_W,f_FrontFn(Var_A))))))))).

fof(axMidLem81, axiom, 
 ( ! [Var_W] : 
 (hasType(type_VehicleWheel, Var_W) => 
(( ! [Var_V] : 
 (hasType(type_RoadVehicle, Var_V) => 
(((f_part(Var_W,Var_V)) => (( ? [Var_A] : 
 (hasType(type_Axle, Var_A) &  
(((f_component(Var_A,Var_V)) & (f_connected(Var_W,Var_A))))))))))))))).

fof(axMidLem82, axiom, 
 ( ! [Var_BILL] : 
 (hasType(type_CurrencyBill, Var_BILL) => 
(( ? [Var_PAPER] : 
 (hasType(type_Paper, Var_PAPER) &  
(f_part(Var_PAPER,Var_BILL)))))))).

fof(axMidLem83, axiom, 
 ( ! [Var_WIRE] : 
 (hasType(type_Wire, Var_WIRE) => 
(f_material(type_Metal,Var_WIRE))))).

fof(axMidLem84, axiom, 
 ( ! [Var_TL] : 
 (hasType(type_TelephoneLine, Var_TL) => 
(( ? [Var_T1] : 
 ((hasType(type_Telephone, Var_T1) | hasType(type_Telegraph, Var_T1)) &  
(( ? [Var_T2] : 
 ((hasType(type_Telephone, Var_T2) | hasType(type_Telegraph, Var_T2)) &  
(((Var_T1 != Var_T2) & (f_connects(Var_TL,Var_T1,Var_T2))))))))))))).

fof(axMidLem85, axiom, 
 ( ! [Var_S] : 
 (hasType(type_String, Var_S) => 
(f_material(type_Fabric,Var_S))))).

fof(axMidLem86, axiom, 
 ( ! [Var_PLUG] : 
 (hasType(type_Plug, Var_PLUG) => 
(( ? [Var_HOLE] : 
 (hasType(type_Hole, Var_HOLE) &  
(f_completelyFills(Var_PLUG,Var_HOLE)))))))).

fof(axMidLem87, axiom, 
 ( ! [Var_POTTERY] : 
 (hasType(type_Pottery, Var_POTTERY) => 
(( ? [Var_CLAY] : 
 (hasType(type_Clay, Var_CLAY) &  
(f_part(Var_CLAY,Var_POTTERY)))))))).

fof(axMidLem88, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Compartment, Var_C) => 
(( ? [Var_O] : 
 (hasType(type_Container, Var_O) &  
(((Var_C != Var_O) & (f_part(Var_C,Var_O)))))))))).

fof(axMidLem89, axiom, 
 ( ! [Var_TAPE] : 
 (hasType(type_Tape, Var_TAPE) => 
(( ? [Var_PART] : 
 ((hasType(type_Paper, Var_PART) | hasType(type_Fabric, Var_PART)) &  
(f_part(Var_PART,Var_TAPE)))))))).

fof(axMidLem90, axiom, 
 ( ! [Var_R] : 
 (hasType(type_HorseRiding, Var_R) => 
(( ? [Var_H] : 
 (hasType(type_Horse, Var_H) &  
(f_instrument(Var_R,Var_H)))))))).

fof(axMidLem91, axiom, 
 ( ! [Var_BAG] : 
 (hasType(type_Bag, Var_BAG) => 
(( ? [Var_PART] : 
 (hasType(type_Fabric, Var_PART) &  
(f_part(Var_PART,Var_BAG)))))))).

fof(axMidLem92, axiom, 
 ( ! [Var_TANK] : 
 (hasType(type_FluidContainer, Var_TANK) => 
(( ! [Var_STUFF] : 
 (hasType(type_Object, Var_STUFF) => 
(((f_contains(Var_TANK,Var_STUFF)) => (f_attribute(Var_STUFF,inst_Fluid)))))))))).

fof(axMidLem93, axiom, 
 ( ! [Var_BOTTLE] : 
 (hasType(type_Bottle, Var_BOTTLE) => 
(( ! [Var_STUFF] : 
 (hasType(type_Object, Var_STUFF) => 
(((f_contains(Var_BOTTLE,Var_STUFF)) => (f_attribute(Var_STUFF,inst_Liquid)))))))))).

fof(axMidLem94, axiom, 
 ( ! [Var_BOTTLE] : 
 (hasType(type_Bottle, Var_BOTTLE) => 
(( ! [Var_WIDTH2] : 
 ((hasType(type_PhysicalQuantity, Var_WIDTH2) & hasType(type_Quantity, Var_WIDTH2)) => 
(( ! [Var_WIDTH1] : 
 ((hasType(type_PhysicalQuantity, Var_WIDTH1) & hasType(type_Quantity, Var_WIDTH1)) => 
(( ! [Var_TOP] : 
 ((hasType(type_SelfConnectedObject, Var_TOP) & hasType(type_Object, Var_TOP)) => 
(( ! [Var_BOTTOM] : 
 ((hasType(type_SelfConnectedObject, Var_BOTTOM) & hasType(type_Object, Var_BOTTOM)) => 
(((((f_bottom(Var_BOTTOM,Var_BOTTLE)) & (((f_top(Var_TOP,Var_BOTTLE)) & (((f_width(Var_BOTTOM,Var_WIDTH1)) & (f_width(Var_TOP,Var_WIDTH2)))))))) => (f_lessThan(Var_WIDTH2,Var_WIDTH1))))))))))))))))))).

fof(axMidLem95, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Brick, Var_B) => 
(f_material(type_Clay,Var_B))))).

fof(axMidLem96, axiom, 
 ( ! [Var_TO] : 
 (hasType(type_TwoDimensionalObject, Var_TO) => 
(( ! [Var_O] : 
 ((hasType(type_Object, Var_O) & hasType(type_GeometricFigure, Var_O)) => 
(((f_attribute(Var_O,inst_RoundShape)) => (( ! [Var_P] : 
 ((hasType(type_GeometricFigure, Var_P) & hasType(type_Object, Var_P)) => 
(((f_pointOfFigure(Var_P,Var_O)) & (((f_meetsSpatially(Var_P,Var_O)) & (((f_meetsSpatially(Var_P,Var_TO)) & (( ? [Var_T] : 
 (hasType(type_OneDimensionalFigure, Var_T) &  
(f_tangent(Var_T,Var_TO)))))))))))))))))))))).

fof(axMidLem97, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Bubble, Var_B) => 
(( ? [Var_S] : 
 ((hasType(type_SelfConnectedObject, Var_S) & hasType(type_Object, Var_S)) &  
(((f_surface(Var_S,Var_B)) & (f_attribute(Var_S,inst_Liquid)))))))))).

fof(axMidLem98, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Bubble, Var_B) => 
(( ! [Var_P] : 
 (hasType(type_Object, Var_P) => 
(((f_interiorPart(Var_P,Var_B)) => (f_attribute(Var_P,inst_Gas)))))))))).

fof(axMidLem99, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Bubble, Var_B) => 
(((( ~ ( ? [Var_S] : 
 (hasType(type_Attribute, Var_S) &  
(( ? [Var_X] : 
 ((hasType(type_Object, Var_X) & hasType(type_Entity, Var_X)) &  
(((f_attribute(Var_X,Var_S)) & (((Var_X != inst_Gas) & (f_meetsSpatially(Var_X,Var_B))))))))))))) => (f_attribute(Var_B,inst_RoundShape))))))).

fof(axMidLem100, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Belt, Var_B) => 
(( ! [Var_P] : 
 (hasType(type_Animal, Var_P) => 
(((f_wears(Var_P,Var_B)) => (( ? [Var_C] : 
 (hasType(type_Clothing, Var_C) &  
(((f_wears(Var_P,Var_C)) & (f_meetsSpatially(Var_B,Var_C))))))))))))))).

fof(axMidLem101, axiom, 
 ( ! [Var_T] : 
 (hasType(type_TieClothing, Var_T) => 
(( ! [Var_P] : 
 ((hasType(type_Animal, Var_P) & hasType(type_Object, Var_P)) => 
(((f_wears(Var_P,Var_T)) => (( ? [Var_N] : 
 (hasType(type_Neck, Var_N) &  
(((f_part(Var_N,Var_P)) & (f_contains(Var_T,Var_N))))))))))))))).

fof(axMidLem102, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Collar, Var_C) => 
(( ? [Var_OC] : 
 ((hasType(type_Coat, Var_OC) | hasType(type_Shirt, Var_OC)) &  
(f_part(Var_C,Var_OC)))))))).

fof(axMidLem103, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Collar, Var_C) => 
(( ! [Var_P] : 
 ((hasType(type_Animal, Var_P) & hasType(type_Object, Var_P)) => 
(((f_wears(Var_P,Var_C)) => (( ? [Var_N] : 
 (hasType(type_Neck, Var_N) &  
(((f_part(Var_N,Var_P)) & (f_meetsSpatially(Var_C,Var_N))))))))))))))).

fof(axMidLem104, axiom, 
 ( ! [Var_G] : 
 (hasType(type_Glove, Var_G) => 
(( ! [Var_P] : 
 ((hasType(type_Animal, Var_P) & hasType(type_Object, Var_P)) => 
(((f_wears(Var_P,Var_G)) => (( ? [Var_H] : 
 (hasType(type_Hand, Var_H) &  
(((f_part(Var_H,Var_P)) & (f_meetsSpatially(Var_G,Var_H))))))))))))))).

fof(axMidLem105, axiom, 
 ( ! [Var_HAT] : 
 (hasType(type_Hat, Var_HAT) => 
(( ! [Var_PERSON] : 
 ((hasType(type_Animal, Var_PERSON) & hasType(type_Object, Var_PERSON)) => 
(((f_wears(Var_PERSON,Var_HAT)) => (( ? [Var_HEAD] : 
 (hasType(type_Head, Var_HEAD) &  
(((f_part(Var_HEAD,Var_PERSON)) & (f_meetsSpatially(Var_HAT,Var_HEAD))))))))))))))).

fof(axMidLem106, axiom, 
 ( ! [Var_T] : 
 (hasType(type_Trousers, Var_T) => 
(( ! [Var_H] : 
 ((hasType(type_Animal, Var_H) & hasType(type_Object, Var_H)) => 
(((f_wears(Var_H,Var_T)) => (( ? [Var_L] : 
 (hasType(type_Leg, Var_L) &  
(((f_part(Var_L,Var_H)) & (f_contains(Var_T,Var_L))))))))))))))).

fof(axMidLem107, axiom, 
 ( ! [Var_SHOE] : 
 (hasType(type_Shoe, Var_SHOE) => 
(( ! [Var_PERSON] : 
 ((hasType(type_Animal, Var_PERSON) & hasType(type_Object, Var_PERSON)) => 
(((f_wears(Var_PERSON,Var_SHOE)) => (( ? [Var_FOOT] : 
 (hasType(type_Foot, Var_FOOT) &  
(((f_part(Var_FOOT,Var_PERSON)) & (f_meetsSpatially(Var_SHOE,Var_FOOT))))))))))))))).

fof(axMidLem108, axiom, 
 ( ! [Var_SS] : 
 (hasType(type_ShoeSole, Var_SS) => 
(( ? [Var_S] : 
 (hasType(type_Shoe, Var_S) &  
(f_bottom(Var_SS,Var_S)))))))).

fof(axMidLem109, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Sandal, Var_S) => 
(( ? [Var_SOLE] : 
 (hasType(type_ShoeSole, Var_SOLE) &  
(((f_part(Var_SOLE,Var_S)) & (f_attribute(Var_SOLE,inst_Flat)))))))))).

fof(axMidLem110, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Sock, Var_S) => 
(( ! [Var_P] : 
 ((hasType(type_Animal, Var_P) & hasType(type_Object, Var_P)) => 
(((f_wears(Var_P,Var_S)) => (( ? [Var_F] : 
 (hasType(type_Foot, Var_F) &  
(((f_part(Var_F,Var_P)) & (f_contains(Var_S,Var_F))))))))))))))).

fof(axMidLem111, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Sleeve, Var_S) => 
(( ! [Var_P] : 
 ((hasType(type_Animal, Var_P) & hasType(type_Object, Var_P)) => 
(((f_wears(Var_P,Var_S)) => (( ? [Var_A] : 
 (hasType(type_Arm, Var_A) &  
(((f_part(Var_A,Var_P)) & (f_contains(Var_S,Var_A))))))))))))))).

fof(axMidLem112, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Sleeve, Var_S) => 
(( ? [Var_C] : 
 ((hasType(type_Shirt, Var_C) | hasType(type_Coat, Var_C)) &  
(f_part(Var_S,Var_C)))))))).

fof(axMidLem113, axiom, 
 ( ! [Var_SUIT] : 
 (hasType(type_ClothingSuit, Var_SUIT) => 
(( ! [Var_PERSON] : 
 (hasType(type_Animal, Var_PERSON) => 
(( ! [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) => 
(( ! [Var_ITEM1] : 
 ((hasType(type_SelfConnectedObject, Var_ITEM1) & hasType(type_Clothing, Var_ITEM1)) => 
(((((f_member(Var_ITEM1,Var_SUIT)) & (f_holdsDuring(Var_TIME,wears(Var_PERSON,Var_ITEM1))))) => (( ! [Var_ITEM2] : 
 ((hasType(type_SelfConnectedObject, Var_ITEM2) & hasType(type_Clothing, Var_ITEM2)) => 
(((f_member(Var_ITEM2,Var_SUIT)) => (f_holdsDuring(Var_TIME,wears(Var_PERSON,Var_ITEM2)))))))))))))))))))))).

fof(axMidLem114, axiom, 
 ( ! [Var_LEATHER] : 
 (hasType(type_Leather, Var_LEATHER) => 
(( ? [Var_MAKE] : 
 (hasType(type_Making, Var_MAKE) &  
(( ? [Var_SKIN] : 
 (hasType(type_Skin, Var_SKIN) &  
(((f_resourceS(Var_MAKE,Var_SKIN)) & (f_result(Var_MAKE,Var_LEATHER))))))))))))).

fof(axMidLem115, axiom, 
 ( ! [Var_W] : 
 (hasType(type_Wool, Var_W) => 
(( ? [Var_M] : 
 (hasType(type_Making, Var_M) &  
(( ? [Var_H] : 
 (hasType(type_Hair, Var_H) &  
(( ? [Var_S] : 
 (hasType(type_Sheep, Var_S) &  
(((f_result(Var_M,Var_W)) & (((f_resourceS(Var_M,Var_H)) & (f_part(Var_H,Var_S)))))))))))))))))).

fof(axMidLem116, axiom, 
 ( ! [Var_POCKET] : 
 (hasType(type_Pocket, Var_POCKET) => 
(( ? [Var_CLOTHING] : 
 (hasType(type_Clothing, Var_CLOTHING) &  
(f_part(Var_POCKET,Var_CLOTHING)))))))).

fof(axMidLem117, axiom, 
 ( ! [Var_F] : 
 (hasType(type_CottonFabric, Var_F) => 
(( ? [Var_M] : 
 (hasType(type_Making, Var_M) &  
(( ? [Var_C] : 
 (hasType(type_Cotton, Var_C) &  
(((f_resourceS(Var_M,Var_C)) & (f_result(Var_M,Var_F))))))))))))).

fof(axMidLem118, axiom, 
 ( ! [Var_F] : 
 (hasType(type_CottonFabric, Var_F) => 
(f_material(type_Cotton,Var_F))))).

fof(axMidLem119, axiom, 
 ( ! [Var_CC] : 
 (hasType(type_ChangingClothing, Var_CC) => 
(( ? [Var_R] : 
 (hasType(type_RemovingClothing, Var_R) &  
(( ? [Var_D] : 
 (hasType(type_Dressing, Var_D) &  
(((f_subProcess(Var_R,Var_CC)) & (f_subProcess(Var_D,Var_CC))))))))))))).

fof(axMidLem120, axiom, 
 ( ! [Var_P] : 
 (hasType(type_Washing, Var_P) => 
(( ? [Var_D] : 
 (hasType(type_Detergent, Var_D) &  
(( ? [Var_W] : 
 (hasType(type_Water, Var_W) &  
(((f_instrument(Var_P,Var_D)) & (f_instrument(Var_P,Var_W))))))))))))).

fof(axMidLem121, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Sewing, Var_S) => 
(( ? [Var_F] : 
 (hasType(type_Fabric, Var_F) &  
(f_patient(Var_S,Var_F)))))))).

fof(axMidLem122, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Soldering, Var_S) => 
(( ! [Var_OBJ2] : 
 ((hasType(type_Entity, Var_OBJ2) & hasType(type_SelfConnectedObject, Var_OBJ2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_Entity, Var_OBJ1) & hasType(type_SelfConnectedObject, Var_OBJ1)) => 
(((((f_patient(Var_S,Var_OBJ1)) & (((f_patient(Var_S,Var_OBJ2)) & (Var_OBJ1 != Var_OBJ2))))) => (( ? [Var_A] : 
 (hasType(type_MetallicAlloy, Var_A) &  
(f_connects(Var_A,Var_OBJ1,Var_OBJ2)))))))))))))))).

fof(axMidLem123, axiom, 
 ( ! [Var_DOCTOR] : 
 ((hasType(type_CognitiveAgent, Var_DOCTOR) & hasType(type_Agent, Var_DOCTOR)) => 
(( ! [Var_PATIENT] : 
 ((hasType(type_Human, Var_PATIENT) & hasType(type_Entity, Var_PATIENT)) => 
(((f_patientMedical(Var_PATIENT,Var_DOCTOR)) => (( ? [Var_PROCESS] : 
 ((hasType(type_DiagnosticProcess, Var_PROCESS) | hasType(type_TherapeuticProcess, Var_PROCESS)) &  
(((f_patient(Var_PROCESS,Var_PATIENT)) & (f_agent(Var_PROCESS,Var_DOCTOR))))))))))))))).

fof(axMidLem124, axiom, 
 ( ! [Var_I] : 
 (hasType(type_InfectiousDisease, Var_I) => 
(( ! [Var_O] : 
 (hasType(type_Microorganism, Var_O) => 
(( ! [Var_A] : 
 ((hasType(type_Object, Var_A) & hasType(type_Entity, Var_A)) => 
(((f_attribute(Var_A,Var_I)) => (( ? [Var_P] : 
 (hasType(type_PathologicProcess, Var_P) &  
(((f_agent(Var_P,Var_O)) & (f_experiencer(Var_P,Var_A)))))))))))))))))).

fof(axMidLem125, axiom, 
 ( ! [Var_H] : 
 (hasType(type_Object, Var_H) => 
(((f_attribute(Var_H,inst_Emphysema)) => (( ? [Var_L] : 
 (hasType(type_Lung, Var_L) &  
(( ? [Var_P] : 
 (hasType(type_PathologicProcess, Var_P) &  
(((f_part(Var_L,Var_H)) & (f_located(Var_P,Var_L))))))))))))))).

fof(axMidLem126, axiom, 
 ( ! [Var_H] : 
 (hasType(type_Human, Var_H) => 
(((f_attribute(Var_H,inst_Fever)) => (( ? [Var_N] : 
 ((hasType(type_RealNumber, Var_N) & hasType(type_Quantity, Var_N)) &  
(((f_measure(Var_H,f_MeasureFn(Var_N,inst_FahrenheitDegree))) & (f_greaterThan(Var_N,98.6)))))))))))).

fof(axMidLem127, axiom, 
 ( ! [Var_H] : 
 (hasType(type_Object, Var_H) => 
(((f_attribute(Var_H,inst_Goiter)) => (( ? [Var_G] : 
 (hasType(type_ThyroidGland, Var_G) &  
(( ? [Var_P] : 
 (hasType(type_PathologicProcess, Var_P) &  
(((f_part(Var_G,Var_H)) & (f_located(Var_P,Var_G))))))))))))))).

fof(axMidLem128, axiom, 
 ( ! [Var_O2] : 
 ((hasType(type_Organism, Var_O2) & hasType(type_Object, Var_O2)) => 
(( ! [Var_O1] : 
 (hasType(type_Organism, Var_O1) => 
(((f_parasite(Var_O1,Var_O2)) => (f_inhabits(Var_O1,Var_O2)))))))))).

fof(axMidLem129, axiom, 
 ( ! [Var_O2] : 
 ((hasType(type_Organism, Var_O2) & hasType(type_Entity, Var_O2)) => 
(( ! [Var_O1] : 
 ((hasType(type_Organism, Var_O1) & hasType(type_Agent, Var_O1)) => 
(((f_parasite(Var_O1,Var_O2)) => (( ? [Var_I] : 
 (hasType(type_Injuring, Var_I) &  
(((f_agent(Var_I,Var_O1)) & (f_patient(Var_I,Var_O2))))))))))))))).

fof(axMidLem130, axiom, 
 ( ! [Var_PERSON] : 
 (hasType(type_Object, Var_PERSON) => 
(((f_attribute(Var_PERSON,inst_Cancer)) => (( ? [Var_TUMOR] : 
 (hasType(type_Tumor, Var_TUMOR) &  
(f_part(Var_TUMOR,Var_PERSON)))))))))).

fof(axMidLem131, axiom, 
 ( ! [Var_CS] : 
 (hasType(type_ConjugatedSubstance, Var_CS) => 
(( ? [Var_C1] : 
 (hasType(type_CompoundSubstance, Var_C1) &  
(( ? [Var_C2] : 
 (hasType(type_CompoundSubstance, Var_C2) &  
(( ? [Var_P] : 
 (hasType(type_ChemicalSynthesis, Var_P) &  
(((Var_C1 != Var_C2) & (((f_resourceS(Var_P,Var_C1)) & (((f_resourceS(Var_P,Var_C2)) & (f_result(Var_P,Var_CS)))))))))))))))))))).

fof(axMidLem132, axiom, 
 ( ! [Var_COMPOUND2] : 
 ((hasType(type_CompoundSubstance, Var_COMPOUND2) & hasType(type_PureSubstance, Var_COMPOUND2)) => 
(( ! [Var_COMPOUND1] : 
 ((hasType(type_CompoundSubstance, Var_COMPOUND1) & hasType(type_PureSubstance, Var_COMPOUND1)) => 
(((f_conjugate(Var_COMPOUND1,Var_COMPOUND2)) => (( ? [Var_NUMBER2] : 
 ((hasType(type_PositiveInteger, Var_NUMBER2) & hasType(type_Quantity, Var_NUMBER2) & hasType(type_Entity, Var_NUMBER2)) &  
(( ? [Var_NUMBER1] : 
 ((hasType(type_PositiveInteger, Var_NUMBER1) & hasType(type_Entity, Var_NUMBER1) & hasType(type_Quantity, Var_NUMBER1)) &  
(((f_protonNumber(Var_COMPOUND1,Var_NUMBER1)) & (((f_protonNumber(Var_COMPOUND2,Var_NUMBER2)) & (((Var_NUMBER1 = f_AdditionFn(Var_NUMBER2,1)) | (Var_NUMBER2 = f_AdditionFn(Var_NUMBER1,1)))))))))))))))))))))).

fof(axMidLem133, axiom, 
 ( ! [Var_BITE] : 
 (hasType(type_Biting, Var_BITE) => 
(( ! [Var_ANIMAL] : 
 ((hasType(type_Agent, Var_ANIMAL) & hasType(type_Object, Var_ANIMAL)) => 
(((f_agent(Var_BITE,Var_ANIMAL)) => (( ? [Var_MOUTH] : 
 (hasType(type_Mouth, Var_MOUTH) &  
(((f_part(Var_MOUTH,Var_ANIMAL)) & (f_instrument(Var_BITE,Var_MOUTH))))))))))))))).

fof(axMidLem134, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Strangling, Var_S) => 
(( ? [Var_T] : 
 (hasType(type_Throat, Var_T) &  
(f_patient(Var_S,Var_T)))))))).

fof(axMidLem135, axiom, 
 ( ! [Var_SPIT] : 
 (hasType(type_Spitting, Var_SPIT) => 
(( ! [Var_ANIMAL] : 
 ((hasType(type_Agent, Var_ANIMAL) & hasType(type_Object, Var_ANIMAL)) => 
(((f_agent(Var_SPIT,Var_ANIMAL)) => (( ? [Var_MOUTH] : 
 (hasType(type_Mouth, Var_MOUTH) &  
(((f_part(Var_MOUTH,Var_ANIMAL)) & (f_origin(Var_SPIT,Var_MOUTH))))))))))))))).

fof(axMidLem136, axiom, 
 ( ! [Var_P] : 
 (hasType(type_Punching, Var_P) => 
(( ! [Var_A] : 
 ((hasType(type_Agent, Var_A) & hasType(type_Object, Var_A)) => 
(((f_agent(Var_P,Var_A)) => (( ? [Var_H] : 
 (hasType(type_Hand, Var_H) &  
(((f_attribute(Var_H,inst_Fist)) & (((f_part(Var_H,Var_A)) & (f_instrument(Var_P,Var_H))))))))))))))))).

fof(axMidLem137, axiom, 
 ( ! [Var_KICK] : 
 (hasType(type_Kicking, Var_KICK) => 
(( ! [Var_ANIMAL] : 
 ((hasType(type_Agent, Var_ANIMAL) & hasType(type_Object, Var_ANIMAL)) => 
(((f_agent(Var_KICK,Var_ANIMAL)) => (( ? [Var_FOOT] : 
 (hasType(type_Foot, Var_FOOT) &  
(((f_part(Var_FOOT,Var_ANIMAL)) & (f_instrument(Var_KICK,Var_FOOT))))))))))))))).

fof(axMidLem138, axiom, 
 ( ! [Var_MESSAGING] : 
 (hasType(type_Messaging, Var_MESSAGING) => 
(( ? [Var_M] : 
 (hasType(type_Message, Var_M) &  
(f_patient(Var_MESSAGING,Var_M)))))))).

fof(axMidLem139, axiom, 
 ( ! [Var_PERSON2] : 
 (hasType(type_Human, Var_PERSON2) => 
(( ! [Var_PERSON1] : 
 (hasType(type_Human, Var_PERSON1) => 
(((f_neighbor(Var_PERSON1,Var_PERSON2)) => (( ? [Var_HOME2] : 
 ((hasType(type_PermanentResidence, Var_HOME2) & hasType(type_Entity, Var_HOME2) & hasType(type_Object, Var_HOME2)) &  
(( ? [Var_HOME1] : 
 ((hasType(type_PermanentResidence, Var_HOME1) & hasType(type_Entity, Var_HOME1) & hasType(type_Object, Var_HOME1)) &  
(((f_home(Var_PERSON1,Var_HOME1)) & (((f_home(Var_PERSON2,Var_HOME2)) & (((Var_HOME1 != Var_HOME2) & (f_orientation(Var_HOME1,Var_HOME2,inst_Near)))))))))))))))))))))).

fof(axMidLem140, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_SelfConnectedObject, Var_OBJ2) => 
(( ! [Var_MEAS] : 
 ((hasType(type_PhysicalQuantity, Var_MEAS) & hasType(type_ConstantQuantity, Var_MEAS)) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((((f_measure(Var_OBJ1,Var_MEAS)) & (f_contains(Var_OBJ2,Var_OBJ1)))) => (f_capacity(Var_OBJ2,Var_MEAS))))))))))))).

fof(axMidLem141, axiom, 
 ( ! [Var_ITEM] : 
 (hasType(type_Entity, Var_ITEM) => 
(( ! [Var_LIST] : 
 (hasType(type_List, Var_LIST) => 
(((f_LastFn(Var_LIST) = Var_ITEM) <=> (( ? [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_PositiveInteger, Var_NUMBER)) &  
(((f_ListLengthFn(Var_LIST) = Var_NUMBER) & (f_ListOrderFn(Var_LIST,Var_NUMBER) = Var_ITEM)))))))))))))).

fof(axMidLem142, axiom, 
 ( ! [Var_LIST] : 
 (hasType(type_List, Var_LIST) => 
(((Var_LIST != inst_NullList) => (f_FirstFn(Var_LIST) = f_ListOrderFn(Var_LIST,1))))))).

fof(axMidLem143, axiom, 
 ( ! [Var_AGENT] : 
 ((hasType(type_Entity, Var_AGENT) & hasType(type_Agent, Var_AGENT)) => 
(( ! [Var_COUNTRY] : 
 (hasType(type_Nation, Var_COUNTRY) => 
(( ! [Var_CITY] : 
 (hasType(type_City, Var_CITY) => 
(( ! [Var_ROAD] : 
 (hasType(type_Roadway, Var_ROAD) => 
(( ! [Var_PLACE] : 
 ((hasType(type_StationaryArtifact, Var_PLACE) & hasType(type_Address, Var_PLACE)) => 
(((f_StreetAddressFn(Var_PLACE,Var_ROAD,Var_CITY,Var_COUNTRY) = Var_AGENT) => (f_address(Var_AGENT,Var_PLACE))))))))))))))))))).

fof(axMidLem144, axiom, 
 ( ! [Var_AGENT] : 
 (hasType(type_Entity, Var_AGENT) => 
(( ! [Var_COUNTRY] : 
 (hasType(type_Nation, Var_COUNTRY) => 
(( ! [Var_CITY] : 
 (hasType(type_City, Var_CITY) => 
(( ! [Var_ROAD] : 
 (hasType(type_Roadway, Var_ROAD) => 
(( ! [Var_PLACE] : 
 ((hasType(type_StationaryArtifact, Var_PLACE) & hasType(type_Object, Var_PLACE)) => 
(((f_StreetAddressFn(Var_PLACE,Var_ROAD,Var_CITY,Var_COUNTRY) = Var_AGENT) => (( ? [Var_BUILDING] : 
 (hasType(type_Building, Var_BUILDING) &  
(f_part(Var_PLACE,Var_BUILDING)))))))))))))))))))))).

fof(axMidLem145, axiom, 
 ( ! [Var_P] : 
 (hasType(type_VotingPoll, Var_P) => 
(( ? [Var_V] : 
 (hasType(type_Voting, Var_V) &  
(f_located(Var_V,Var_P)))))))).

fof(axMidLem146, axiom, 
 ( ! [Var_CAMP] : 
 (hasType(type_Camp, Var_CAMP) => 
(( ? [Var_TENT] : 
 (hasType(type_Tent, Var_TENT) &  
(f_part(Var_TENT,Var_CAMP)))))))).

fof(axMidLem147, axiom, 
 ( ! [Var_TENT] : 
 (hasType(type_Tent, Var_TENT) => 
(( ? [Var_FABRIC] : 
 (hasType(type_Fabric, Var_FABRIC) &  
(f_part(Var_FABRIC,Var_TENT)))))))).

fof(axMidLem148, axiom, 
 ( ! [Var_RESIDENCE] : 
 (hasType(type_ExecutiveResidence, Var_RESIDENCE) => 
(( ? [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) &  
(( ? [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) &  
(( ? [Var_AREA] : 
 ((hasType(type_Object, Var_AREA) & hasType(type_GeopoliticalArea, Var_AREA)) &  
(((f_located(Var_RESIDENCE,Var_AREA)) & (((f_home(Var_PERSON,Var_RESIDENCE)) & (f_chiefOfState(Var_AREA,Var_POSITION,Var_PERSON)))))))))))))))))).

fof(axMidLem149, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_ApartmentUnit, Var_UNIT) => 
(( ! [Var_PERSON] : 
 ((hasType(type_Human, Var_PERSON) & hasType(type_Agent, Var_PERSON)) => 
(((f_home(Var_PERSON,Var_UNIT)) => (( ~ (f_possesses(Var_PERSON,Var_UNIT)))))))))))).

fof(axMidLem150, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_ApartmentUnit, Var_UNIT) => 
(( ? [Var_BUILDING] : 
 (hasType(type_ApartmentBuilding, Var_BUILDING) &  
(f_part(Var_UNIT,Var_BUILDING)))))))).

fof(axMidLem151, axiom, 
 ( ! [Var_U] : 
 ((hasType(type_PermanentResidence, Var_U) & hasType(type_Object, Var_U) & hasType(type_Residence, Var_U) & hasType(type_Entity, Var_U)) => 
(( ! [Var_L] : 
 (hasType(type_Agent, Var_L) => 
(((f_landlord(Var_L,Var_U)) => (( ? [Var_R] : 
 (hasType(type_Renting, Var_R) &  
(( ? [Var_P] : 
 (hasType(type_Agent, Var_P) &  
(((f_possesses(Var_L,Var_U)) & (((f_tenant(Var_P,Var_U)) & (((f_agent(Var_R,Var_P)) & (f_patient(Var_R,Var_U)))))))))))))))))))))).

fof(axMidLem152, axiom, 
 ( ! [Var_U] : 
 ((hasType(type_Residence, Var_U) & hasType(type_PermanentResidence, Var_U) & hasType(type_Object, Var_U) & hasType(type_Entity, Var_U)) => 
(( ! [Var_P] : 
 (hasType(type_Agent, Var_P) => 
(((f_tenant(Var_P,Var_U)) => (( ? [Var_R] : 
 (hasType(type_Renting, Var_R) &  
(( ? [Var_L] : 
 (hasType(type_Agent, Var_L) &  
(((f_landlord(Var_L,Var_U)) & (((f_agent(Var_R,Var_P)) & (((f_possesses(Var_L,Var_U)) & (f_patient(Var_R,Var_U)))))))))))))))))))))).

fof(axMidLem153, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_CondominiumUnit, Var_UNIT) => 
(( ? [Var_BUILDING] : 
 (hasType(type_CondominiumBuilding, Var_BUILDING) &  
(f_part(Var_UNIT,Var_BUILDING)))))))).

fof(axMidLem154, axiom, 
 ( ! [Var_BUILDING] : 
 (hasType(type_ApartmentBuilding, Var_BUILDING) => 
(( ? [Var_UNIT1] : 
 (hasType(type_ApartmentUnit, Var_UNIT1) &  
(( ? [Var_UNIT2] : 
 (hasType(type_ApartmentUnit, Var_UNIT2) &  
(((f_part(Var_UNIT1,Var_BUILDING)) & (((f_part(Var_UNIT2,Var_BUILDING)) & (Var_UNIT1 != Var_UNIT2)))))))))))))).

fof(axMidLem155, axiom, 
 ( ! [Var_BUILDING] : 
 (hasType(type_CondominiumBuilding, Var_BUILDING) => 
(( ? [Var_UNIT1] : 
 (hasType(type_CondominiumUnit, Var_UNIT1) &  
(( ? [Var_UNIT2] : 
 (hasType(type_CondominiumUnit, Var_UNIT2) &  
(((f_part(Var_UNIT1,Var_BUILDING)) & (((f_part(Var_UNIT2,Var_BUILDING)) & (Var_UNIT1 != Var_UNIT2)))))))))))))).

fof(axMidLem156, axiom, 
 ( ! [Var_D] : 
 (hasType(type_Dormitory, Var_D) => 
(( ? [Var_S] : 
 (hasType(type_School, Var_S) &  
(f_possesses(Var_S,Var_D)))))))).

fof(axMidLem157, axiom, 
 ( ! [Var_B] : 
 (hasType(type_FarmBuilding, Var_B) => 
(( ? [Var_F] : 
 (hasType(type_Farm, Var_F) &  
(f_located(Var_B,Var_F)))))))).

fof(axMidLem158, axiom, 
 ( ! [Var_C] : 
 (hasType(type_EntertainmentCompany, Var_C) => 
(( ? [Var_P] : 
 ((hasType(type_CommercialService, Var_P) & hasType(type_Performance, Var_P)) &  
(f_agent(Var_P,Var_C)))))))).

fof(axMidLem159, axiom, 
 ( ! [Var_I] : 
 (hasType(type_InsuranceCompany, Var_I) => 
(( ? [Var_C] : 
 (hasType(type_Contract, Var_C) &  
(f_insured(Var_C,Var_I)))))))).

fof(axMidLem160, axiom, 
 ( ! [Var_S] : 
 (hasType(type_FinancialService, Var_S) => 
(( ? [Var_O] : 
 (hasType(type_FinancialCompany, Var_O) &  
(f_agent(Var_S,Var_O)))))))).

fof(axMidLem161, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Partnership, Var_C) => 
(( ? [Var_H1] : 
 (hasType(type_Human, Var_H1) &  
(( ? [Var_H2] : 
 (hasType(type_Human, Var_H2) &  
(((Var_H1 != Var_H2) & (((f_possesses(Var_H1,Var_C)) & (f_possesses(Var_H2,Var_C))))))))))))))).

fof(axMidLem162, axiom, 
 ( ! [Var_W] : 
 (hasType(type_Welfare, Var_W) => 
(( ? [Var_O] : 
 (hasType(type_ServiceOrganization, Var_O) &  
(f_agent(Var_W,Var_O)))))))).

fof(axMidLem163, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Publisher, Var_C) => 
(( ? [Var_S] : 
 ((hasType(type_CommercialService, Var_S) & hasType(type_Publication, Var_S)) &  
(f_agent(Var_S,Var_C)))))))).

fof(axMidLem164, axiom, 
 ( ! [Var_C] : 
 (hasType(type_FamilyBusiness, Var_C) => 
(( ! [Var_P2] : 
 ((hasType(type_Agent, Var_P2) & hasType(type_Organism, Var_P2)) => 
(( ! [Var_P1] : 
 ((hasType(type_Agent, Var_P1) & hasType(type_Organism, Var_P1)) => 
(((((f_possesses(Var_P1,Var_C)) & (f_possesses(Var_P2,Var_C)))) => (f_familyRelation(Var_P1,Var_P2))))))))))))).

fof(axMidLem165, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Restaurant, Var_C) => 
(( ? [Var_S] : 
 ((hasType(type_CommercialService, Var_S) & hasType(type_Selling, Var_S)) &  
(( ? [Var_F] : 
 (hasType(type_Food, Var_F) &  
(( ? [Var_B] : 
 (hasType(type_RestaurantBuilding, Var_B) &  
(((f_agent(Var_S,Var_C)) & (((f_located(Var_S,Var_B)) & (f_patient(Var_S,Var_F)))))))))))))))))).

fof(axMidLem166, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Proprietorship, Var_C) => 
(( ? [Var_H] : 
 (hasType(type_Human, Var_H) &  
(((f_possesses(Var_H,Var_C)) & (( ~ ( ? [Var_H2] : 
 ((hasType(type_Entity, Var_H2) & hasType(type_Agent, Var_H2)) &  
(((Var_H != Var_H2) & (f_possesses(Var_H2,Var_C)))))))))))))))).

fof(axMidLem167, axiom, 
 ( ! [Var_AUDITORIUM] : 
 (hasType(type_Auditorium, Var_AUDITORIUM) => 
(( ? [Var_STAGE] : 
 (hasType(type_PerformanceStage, Var_STAGE) &  
(f_part(Var_STAGE,Var_AUDITORIUM)))))))).

fof(axMidLem168, axiom, 
 ( ! [Var_SEAT] : 
 (hasType(type_AuditoriumSeat, Var_SEAT) => 
(( ? [Var_AUDITORIUM] : 
 (hasType(type_Auditorium, Var_AUDITORIUM) &  
(f_part(Var_SEAT,Var_AUDITORIUM)))))))).

fof(axMidLem169, axiom, 
 ( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(( ! [Var_DESCENDANTS] : 
 ((hasType(type_Entity, Var_DESCENDANTS) & hasType(type_Collection, Var_DESCENDANTS)) => 
(((f_DescendantsFn(Var_PERSON) = Var_DESCENDANTS) => (( ! [Var_MEMBER] : 
 ((hasType(type_SelfConnectedObject, Var_MEMBER) & hasType(type_Organism, Var_MEMBER)) => 
(((f_member(Var_MEMBER,Var_DESCENDANTS)) <=> (f_ancestor(Var_MEMBER,Var_PERSON))))))))))))))).

fof(axMidLem170, axiom, 
 ( ! [Var_BROOD] : 
 (hasType(type_Brood, Var_BROOD) => 
(( ! [Var_MEMBER2] : 
 ((hasType(type_SelfConnectedObject, Var_MEMBER2) & hasType(type_Organism, Var_MEMBER2)) => 
(( ! [Var_MEMBER1] : 
 ((hasType(type_SelfConnectedObject, Var_MEMBER1) & hasType(type_Organism, Var_MEMBER1)) => 
(((((f_member(Var_MEMBER1,Var_BROOD)) & (f_member(Var_MEMBER2,Var_BROOD)))) => (f_sibling(Var_MEMBER1,Var_MEMBER2))))))))))))).

fof(axMidLem171, axiom, 
 ( ! [Var_BROOD] : 
 (hasType(type_Brood, Var_BROOD) => 
(( ? [Var_TIME] : 
 (hasType(type_Entity, Var_TIME) &  
(( ! [Var_MEMBER] : 
 ((hasType(type_SelfConnectedObject, Var_MEMBER) & hasType(type_Entity, Var_MEMBER)) => 
(((f_member(Var_MEMBER,Var_BROOD)) => (( ? [Var_BIRTH] : 
 (hasType(type_Birth, Var_BIRTH) &  
(((f_experiencer(Var_BIRTH,Var_MEMBER)) & (Var_TIME = f_WhenFn(Var_BIRTH)))))))))))))))))).

fof(axMidLem172, axiom, 
 ( ! [Var_AT] : 
 (hasType(type_AnimalTeam, Var_AT) => 
(( ? [Var_P] : 
 (hasType(type_Pulling, Var_P) &  
(f_agent(Var_P,Var_AT)))))))).

fof(axMidLem173, axiom, 
 ( ! [Var_S] : 
 (hasType(type_TeamSport, Var_S) => 
(( ? [Var_T1] : 
 (hasType(type_SportsTeam, Var_T1) &  
(( ? [Var_T2] : 
 (hasType(type_SportsTeam, Var_T2) &  
(((f_contestParticipant(Var_S,Var_T1)) & (((f_contestParticipant(Var_S,Var_T2)) & (Var_T1 != Var_T2)))))))))))))).

fof(axMidLem174, axiom, 
 ( ! [Var_CO] : 
 (hasType(type_CommunicationOrganization, Var_CO) => 
(( ? [Var_CS] : 
 (hasType(type_CommunicationSystem, Var_CS) &  
(( ? [Var_C] : 
 (hasType(type_Communication, Var_C) &  
(((f_instrument(Var_C,Var_CS)) & (f_agent(Var_C,Var_CO))))))))))))).

fof(axMidLem175, axiom, 
 ( ! [Var_COMPANY] : 
 (hasType(type_Tavern, Var_COMPANY) => 
(( ? [Var_SERVICE] : 
 ((hasType(type_CommercialService, Var_SERVICE) & hasType(type_Selling, Var_SERVICE)) &  
(( ? [Var_BEVERAGE] : 
 (hasType(type_AlcoholicBeverage, Var_BEVERAGE) &  
(((f_agent(Var_SERVICE,Var_COMPANY)) & (f_patient(Var_SERVICE,Var_BEVERAGE))))))))))))).

fof(axMidLem176, axiom, 
 ( ! [Var_D] : 
 (hasType(type_DrugStore, Var_D) => 
(( ! [Var_M] : 
 (hasType(type_Medicine, Var_M) => 
(( ? [Var_S] : 
 (hasType(type_Selling, Var_S) &  
(((f_agent(Var_S,Var_D)) & (f_patient(Var_S,Var_M))))))))))))).

fof(axMidLem177, axiom, 
 ( ! [Var_STORE] : 
 (hasType(type_GroceryStore, Var_STORE) => 
(( ? [Var_SELL] : 
 (hasType(type_Selling, Var_SELL) &  
(( ? [Var_FOOD] : 
 (hasType(type_Food, Var_FOOD) &  
(((f_agent(Var_SELL,Var_STORE)) & (f_patient(Var_SELL,Var_FOOD))))))))))))).

fof(axMidLem178, axiom, 
 ( ! [Var_SALE] : 
 (hasType(type_BargainSale, Var_SALE) => 
(( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(((f_patient(Var_SALE,Var_OBJ)) => (( ? [Var_AGENT2] : 
 (hasType(type_Agent, Var_AGENT2) &  
(( ? [Var_AGENT1] : 
 (hasType(type_Agent, Var_AGENT1) &  
(( ? [Var_PRICE2] : 
 ((hasType(type_CurrencyMeasure, Var_PRICE2) & hasType(type_Quantity, Var_PRICE2)) &  
(( ? [Var_PRICE1] : 
 ((hasType(type_CurrencyMeasure, Var_PRICE1) & hasType(type_Quantity, Var_PRICE1)) &  
(((f_holdsDuring(f_ImmediatePastFn(f_WhenFn(Var_SALE)),price(Var_OBJ,Var_PRICE1,Var_AGENT1))) & (((f_holdsDuring(f_WhenFn(Var_SALE),price(Var_OBJ,Var_PRICE2,Var_AGENT2))) & (f_lessThan(Var_PRICE2,Var_PRICE1)))))))))))))))))))))))))).

fof(axMidLem179, axiom, 
 ( ~ (f_overlapsTemporally(inst_CommonEra,inst_BeforeCommonEra)))).

fof(axMidLem180, axiom, 
 ( ! [Var_STEEPLE] : 
 (hasType(type_Steeple, Var_STEEPLE) => 
(( ? [Var_BUILDING] : 
 (hasType(type_Building, Var_BUILDING) &  
(f_part(Var_STEEPLE,Var_BUILDING)))))))).

fof(axMidLem181, axiom, 
 ( ! [Var_P] : 
 (hasType(type_CommunistParty, Var_P) => 
(( ! [Var_A] : 
 (hasType(type_GeopoliticalArea, Var_A) => 
(( ! [Var_M] : 
 ((hasType(type_SelfConnectedObject, Var_M) & hasType(type_CognitiveAgent, Var_M)) => 
(((f_member(Var_M,Var_P)) => (f_desires(Var_M,governmentType(Var_A,inst_CommunistState)))))))))))))).

fof(axMidLem182, axiom, 
 ( ! [Var_AREA] : 
 ((hasType(type_GeopoliticalArea, Var_AREA) & hasType(type_PermanentResidence, Var_AREA)) => 
(( ! [Var_PERSON] : 
 ((hasType(type_SelfConnectedObject, Var_PERSON) & hasType(type_Human, Var_PERSON)) => 
(((f_member(Var_PERSON,f_ResidentFn(Var_AREA))) => (f_home(Var_PERSON,Var_AREA)))))))))).

fof(axMidLem183, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(( ! [Var_POPULATION] : 
 ((hasType(type_Entity, Var_POPULATION) & (hasType(type_SetOrClass, Var_POPULATION) | hasType(type_Collection, Var_POPULATION))) => 
(( ! [Var_CITIZENRY] : 
 ((hasType(type_Entity, Var_CITIZENRY) & (hasType(type_SetOrClass, Var_CITIZENRY) | hasType(type_Collection, Var_CITIZENRY))) => 
(((((Var_CITIZENRY = f_CitizenryFn(Var_AREA)) & (Var_POPULATION = f_ResidentFn(Var_AREA)))) => (f_greaterThanOrEqualTo(f_CardinalityFn(Var_POPULATION),f_CardinalityFn(Var_CITIZENRY)))))))))))))).

fof(axMidLem184, axiom, 
 ( ! [Var_DISTRICT] : 
 (hasType(type_CityDistrict, Var_DISTRICT) => 
(( ? [Var_CITY] : 
 (hasType(type_City, Var_CITY) &  
(f_geopoliticalSubdivision(Var_DISTRICT,Var_CITY)))))))).

fof(axMidLem185, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Cemetery, Var_C) => 
(( ? [Var_T] : 
 (hasType(type_Tomb, Var_T) &  
(f_located(Var_T,Var_C)))))))).

fof(axMidLem186, axiom, 
 ( ! [Var_PARK] : 
 (hasType(type_Park, Var_PARK) => 
(( ? [Var_GOV] : 
 (hasType(type_Government, Var_GOV) &  
(f_possesses(Var_GOV,Var_PARK)))))))).

fof(axMidLem187, axiom, 
 ( ! [Var_P] : 
 (hasType(type_PublicPark, Var_P) => 
(( ? [Var_G] : 
 (hasType(type_Government, Var_G) &  
(f_possesses(Var_G,Var_P)))))))).

fof(axMidLem188, axiom, 
 ( ! [Var_A] : 
 (hasType(type_CultivatedLandArea, Var_A) => 
(( ? [Var_C] : 
 (hasType(type_Agriculture, Var_C) &  
(f_located(Var_C,Var_A)))))))).

fof(axMidLem189, axiom, 
 ( ! [Var_B] : 
 (hasType(type_CityBlock, Var_B) => 
(( ? [Var_C] : 
 (hasType(type_City, Var_C) &  
(f_part(Var_B,Var_C)))))))).

fof(axMidLem190, axiom, 
 ( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(((f_occupiesPosition(Var_PERSON,inst_SecretaryOfTheInterior,inst_UnitedStatesDepartmentOfInterior)) => (f_leader(inst_UnitedStatesDepartmentOfInterior,Var_PERSON))))))).

fof(axMidLem191, axiom, 
 ( ! [Var_GOVERNMENT] : 
 (hasType(type_StateGovernment, Var_GOVERNMENT) => 
(( ? [Var_STATE] : 
 (hasType(type_StateOrProvince, Var_STATE) &  
(f_GovernmentFn(Var_STATE) = Var_GOVERNMENT))))))).

fof(axMidLem192, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Battle, Var_B) => 
(( ? [Var_U1] : 
 (hasType(type_MilitaryUnit, Var_U1) &  
(( ? [Var_U2] : 
 (hasType(type_MilitaryUnit, Var_U2) &  
(((Var_U1 != Var_U2) & (((f_agent(Var_B,Var_U1)) & (f_agent(Var_B,Var_U2))))))))))))))).

fof(axMidLem193, axiom, 
 ( ! [Var_WAR] : 
 (hasType(type_War, Var_WAR) => 
(( ! [Var_U2] : 
 ((hasType(type_MilitaryUnit, Var_U2) & hasType(type_Organization, Var_U2)) => 
(( ! [Var_U1] : 
 ((hasType(type_MilitaryUnit, Var_U1) & hasType(type_Organization, Var_U1)) => 
(((f_hostileForces(Var_U1,Var_U2)) => (( ? [Var_A2] : 
 ((hasType(type_Agent, Var_A2) & hasType(type_GeopoliticalArea, Var_A2)) &  
(( ? [Var_A1] : 
 ((hasType(type_Agent, Var_A1) & hasType(type_GeopoliticalArea, Var_A1)) &  
(( ? [Var_W] : 
 (hasType(type_Contest, Var_W) &  
(((f_contestParticipant(Var_W,Var_A1)) & (((f_contestParticipant(Var_W,Var_A2)) & (((f_subOrganization(Var_U1,f_GovernmentFn(Var_A1))) & (f_subOrganization(Var_U2,f_GovernmentFn(Var_A2))))))))))))))))))))))))))))).

fof(axMidLem194, axiom, 
 ( ! [Var_ORG] : 
 (hasType(type_ServiceOrganization, Var_ORG) => 
(( ? [Var_PROC] : 
 (hasType(type_RegulatoryProcess, Var_PROC) &  
(( ? [Var_GOV] : 
 (hasType(type_Government, Var_GOV) &  
(((f_patient(Var_PROC,Var_ORG)) & (f_agent(Var_PROC,Var_GOV))))))))))))).

fof(axMidLem195, axiom, 
 ( ! [Var_L] : 
 (hasType(type_Library, Var_L) => 
(( ? [Var_B] : 
 (hasType(type_Building, Var_B) &  
(( ? [Var_T] : 
 (hasType(type_Text, Var_T) &  
(((f_possesses(Var_L,Var_B)) & (f_located(Var_T,Var_B))))))))))))).

fof(axMidLem196, axiom, 
 ( ! [Var_BOARD] : 
 (hasType(type_OrganizationalBoard, Var_BOARD) => 
(( ? [Var_MANAGE] : 
 (hasType(type_Managing, Var_MANAGE) &  
(( ? [Var_ORG] : 
 ((hasType(type_Organization, Var_ORG) & hasType(type_Entity, Var_ORG)) &  
(((f_subOrganization(Var_BOARD,Var_ORG)) & (((f_agent(Var_MANAGE,Var_BOARD)) & (f_patient(Var_MANAGE,Var_ORG))))))))))))))).

fof(axMidLem197, axiom, 
 ( ! [Var_ORG] : 
 (hasType(type_UnionOrganization, Var_ORG) => 
(( ! [Var_MEMBER] : 
 ((hasType(type_SelfConnectedObject, Var_MEMBER) & hasType(type_CognitiveAgent, Var_MEMBER)) => 
(( ? [Var_COLL] : 
 ((hasType(type_Corporation, Var_COLL) & hasType(type_Industry, Var_COLL)) &  
(((f_member(Var_MEMBER,Var_ORG)) => (((f_employs(Var_COLL,Var_MEMBER)) | (( ? [Var_CORP] : 
 ((hasType(type_SelfConnectedObject, Var_CORP) & hasType(type_Organization, Var_CORP)) &  
(((f_member(Var_CORP,Var_COLL)) & (f_employs(Var_CORP,Var_MEMBER)))))))))))))))))))).

fof(axMidLem198, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Hydrocarbon, Var_S) => 
(( ? [Var_P1] : 
 (hasType(type_Carbon, Var_P1) &  
(( ? [Var_P2] : 
 (hasType(type_Hydrogen, Var_P2) &  
(Var_S = f_MereologicalSumFn(Var_P1,Var_P2))))))))))).

fof(axMidLem199, axiom, 
 ( ! [Var_A] : 
 (hasType(type_Alkaloid, Var_A) => 
(( ? [Var_N] : 
 (hasType(type_Nitrogen, Var_N) &  
(f_part(Var_N,Var_A)))))))).

fof(axMidLem200, axiom, 
 ( ! [Var_P] : 
 (hasType(type_Protein, Var_P) => 
(( ? [Var_A] : 
 (hasType(type_AminoAcid, Var_A) &  
(f_part(Var_A,Var_P)))))))).

fof(axMidLem201, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Cholesterol, Var_S) => 
(( ? [Var_P] : 
 (hasType(type_BiologicalProcess, Var_P) &  
(( ? [Var_L] : 
 (hasType(type_Liver, Var_L) &  
(((f_located(Var_P,Var_L)) & (f_result(Var_P,Var_S))))))))))))).

fof(axMidLem202, axiom, 
 ( ! [Var_CA] : 
 (hasType(type_ChemicalAcid, Var_CA) => 
(( ! [Var_CB] : 
 (hasType(type_ChemicalBase, Var_CB) => 
(( ! [Var_C] : 
 (hasType(type_ChemicalProcess, Var_C) => 
(((((f_patient(Var_C,Var_CA)) & (f_patient(Var_C,Var_CB)))) => (( ? [Var_CS] : 
 (hasType(type_ChemicalSalt, Var_CS) &  
(f_result(Var_C,Var_CS)))))))))))))))).

fof(axMidLem203, axiom, 
 ( ! [Var_SALT] : 
 (hasType(type_SodiumChloride, Var_SALT) => 
(( ? [Var_SYNTHESIS] : 
 (hasType(type_ChemicalSynthesis, Var_SYNTHESIS) &  
(( ? [Var_SODIUM] : 
 (hasType(type_Sodium, Var_SODIUM) &  
(( ? [Var_CHLORINE] : 
 (hasType(type_Chlorine, Var_CHLORINE) &  
(((f_resourceS(Var_SYNTHESIS,Var_SODIUM)) & (((f_resourceS(Var_SYNTHESIS,Var_CHLORINE)) & (f_result(Var_SYNTHESIS,Var_SALT)))))))))))))))))).

fof(axMidLem204, axiom, 
 ( ! [Var_WATER] : 
 (hasType(type_Water, Var_WATER) => 
(( ? [Var_SYNTHESIS] : 
 (hasType(type_ChemicalSynthesis, Var_SYNTHESIS) &  
(( ? [Var_HYDROGEN] : 
 (hasType(type_Hydrogen, Var_HYDROGEN) &  
(( ? [Var_OXYGEN] : 
 (hasType(type_Oxygen, Var_OXYGEN) &  
(((f_resourceS(Var_SYNTHESIS,Var_HYDROGEN)) & (((f_resourceS(Var_SYNTHESIS,Var_OXYGEN)) & (f_result(Var_SYNTHESIS,Var_WATER)))))))))))))))))).

fof(axMidLem205, axiom, 
 ( ! [Var_ALLOY] : 
 (hasType(type_MetallicAlloy, Var_ALLOY) => 
(( ? [Var_METAL1] : 
 (hasType(type_Metal, Var_METAL1) &  
(( ? [Var_METAL2] : 
 (hasType(type_Metal, Var_METAL2) &  
(((Var_METAL1 != Var_METAL2) & (((f_part(Var_METAL1,Var_ALLOY)) & (f_part(Var_METAL2,Var_ALLOY))))))))))))))).

fof(axMidLem206, axiom, 
 ( ! [Var_STEEL] : 
 (hasType(type_Steel, Var_STEEL) => 
(( ? [Var_IRON] : 
 (hasType(type_Iron, Var_IRON) &  
(f_part(Var_IRON,Var_STEEL)))))))).

fof(axMidLem207, axiom, 
 ( ! [Var_BRASS] : 
 (hasType(type_Brass, Var_BRASS) => 
(( ? [Var_COPPER] : 
 (hasType(type_Copper, Var_COPPER) &  
(( ? [Var_ZINC] : 
 (hasType(type_Zinc, Var_ZINC) &  
(((f_part(Var_COPPER,Var_BRASS)) & (f_part(Var_ZINC,Var_BRASS))))))))))))).

fof(axMidLem208, axiom, 
 ( ! [Var_POWDER] : 
 (hasType(type_Powder, Var_POWDER) => 
(f_attribute(Var_POWDER,inst_Solid))))).

fof(axMidLem209, axiom, 
 ( ! [Var_FOG] : 
 (hasType(type_Fog, Var_FOG) => 
(( ? [Var_LAND] : 
 (hasType(type_LandArea, Var_LAND) &  
(f_meetsSpatially(Var_FOG,Var_LAND)))))))).

fof(axMidLem210, axiom, 
 ( ! [Var_ICE] : 
 (hasType(type_Ice, Var_ICE) => 
(( ! [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((f_measure(Var_ICE,f_MeasureFn(Var_NUMBER,inst_CelsiusDegree))) => (f_lessThanOrEqualTo(Var_NUMBER,0)))))))))).

fof(axMidLem211, axiom, 
 ( ! [Var_L] : 
 (hasType(type_Lawn, Var_L) => 
(( ? [Var_G] : 
 (hasType(type_Grass, Var_G) &  
(f_located(Var_G,Var_L)))))))).

fof(axMidLem212, axiom, 
 ( ! [Var_M] : 
 (hasType(type_Meteorite, Var_M) => 
(( ? [Var_T] : 
 (hasType(type_TimePosition, Var_T) &  
(f_holdsDuring(Var_T,meetsSpatially(Var_M,inst_PlanetEarth))))))))).

fof(axMidLem213, axiom, 
 ( ! [Var_M] : 
 (hasType(type_Meteorite, Var_M) => 
(( ? [Var_T] : 
 (hasType(type_TimePosition, Var_T) &  
(f_holdsDuring(Var_T,meetsSpatially(Var_M,inst_EarthsAtmosphere))))))))).

fof(axMidLem214, axiom, 
 ( ! [Var_AR] : 
 (hasType(type_AtmosphericRegion, Var_AR) => 
(f_geographicSubregion(Var_AR,inst_EarthsAtmosphere))))).

fof(axMidLem215, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Creek, Var_C) => 
(( ! [Var_R] : 
 (hasType(type_River, Var_R) => 
(f_smaller(Var_C,Var_R)))))))).

fof(axMidLem216, axiom, 
 ( ! [Var_FRONT] : 
 (hasType(type_StormFront, Var_FRONT) => 
(( ? [Var_AIR1] : 
 (hasType(type_Air, Var_AIR1) &  
(( ? [Var_AIR2] : 
 (hasType(type_Air, Var_AIR2) &  
(f_between(Var_AIR1,Var_FRONT,Var_AIR2))))))))))).

fof(axMidLem217, axiom, 
 ( ! [Var_REGION] : 
 (hasType(type_Object, Var_REGION) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Object, Var_OBJ) & hasType(type_Physical, Var_OBJ)) => 
(((f_orientation(Var_OBJ,Var_REGION,inst_Outside)) <=> (( ~ (f_partlyLocated(Var_OBJ,Var_REGION)))))))))))).

fof(axMidLem218, axiom, 
 ( ! [Var_REGION] : 
 (hasType(type_Object, Var_REGION) => 
(( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(((f_part(Var_OBJ,Var_REGION)) <=> (( ~ (f_orientation(Var_OBJ,Var_REGION,inst_Outside)))))))))))).

fof(axMidLem219, axiom, 
 ( ! [Var_W] : 
 (hasType(type_WoodArtifact, Var_W) => 
(f_material(type_Wood,Var_W))))).

fof(axMidLem220, axiom, 
 ( ! [Var_R] : 
 (hasType(type_Rubber, Var_R) => 
(( ? [Var_T] : 
 (hasType(type_BotanicalTree, Var_T) &  
(f_part(Var_R,Var_T)))))))).

fof(axMidLem221, axiom, 
 ( ! [Var_M] : 
 (hasType(type_Medicine, Var_M) => 
(( ? [Var_P] : 
 (hasType(type_TherapeuticProcess, Var_P) &  
(f_instrument(Var_P,Var_M)))))))).

fof(axMidLem222, axiom, 
 ( ! [Var_O] : 
 (hasType(type_Opium, Var_O) => 
(( ? [Var_A] : 
 (hasType(type_Alkaloid, Var_A) &  
(f_part(Var_A,Var_O)))))))).

fof(axMidLem223, axiom, 
 ( ! [Var_L] : 
 (hasType(type_Lesion, Var_L) => 
(( ? [Var_I] : 
 (hasType(type_Injuring, Var_I) &  
(f_result(Var_I,Var_L)))))))).

fof(axMidLem224, axiom, 
 ( ! [Var_L] : 
 (hasType(type_Lesion, Var_L) => 
(( ? [Var_O] : 
 (hasType(type_Organ, Var_O) &  
(( ? [Var_S] : 
 ((hasType(type_SelfConnectedObject, Var_S) & hasType(type_Object, Var_S)) &  
(((f_surface(Var_S,Var_O)) & (f_located(Var_L,Var_S))))))))))))).

fof(axMidLem225, axiom, 
 ( ! [Var_T] : 
 (hasType(type_Tendon, Var_T) => 
(( ? [Var_M] : 
 (hasType(type_Muscle, Var_M) &  
(( ? [Var_B] : 
 (hasType(type_Bone, Var_B) &  
(f_connects(Var_T,Var_M,Var_B))))))))))).

fof(axMidLem226, axiom, 
 ( ! [Var_SWEAT] : 
 (hasType(type_Sweat, Var_SWEAT) => 
(( ? [Var_PART] : 
 (hasType(type_SodiumChloride, Var_PART) &  
(f_part(Var_PART,Var_SWEAT)))))))).

fof(axMidLem227, axiom, 
 ( ! [Var_B] : 
 (hasType(type_TreeBranch, Var_B) => 
(( ? [Var_T] : 
 (hasType(type_BotanicalTree, Var_T) &  
(f_part(Var_B,Var_T)))))))).

fof(axMidLem228, axiom, 
 ( ! [Var_FLOWER] : 
 (hasType(type_Flower, Var_FLOWER) => 
(( ? [Var_PLANT] : 
 (hasType(type_FloweringPlant, Var_PLANT) &  
(( ? [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) &  
(f_holdsDuring(Var_TIME,part(Var_FLOWER,Var_PLANT)))))))))))).

fof(axMidLem229, axiom, 
 ( ! [Var_C] : 
 (hasType(type_BloodCell, Var_C) => 
(( ? [Var_B] : 
 (hasType(type_Blood, Var_B) &  
(f_part(Var_C,Var_B)))))))).

fof(axMidLem230, axiom, 
 ( ! [Var_C] : 
 (hasType(type_WhiteBloodCell, Var_C) => 
(( ? [Var_N] : 
 (hasType(type_CellNucleus, Var_N) &  
(f_part(Var_N,Var_C)))))))).

fof(axMidLem231, axiom, 
 ( ! [Var_B] : 
 (hasType(type_BloodTypeA, Var_B) => 
(( ? [Var_A] : 
 (hasType(type_AntigenA, Var_A) &  
(f_part(Var_A,Var_B)))))))).

fof(axMidLem232, axiom, 
 ( ! [Var_B] : 
 (hasType(type_BloodTypeAB, Var_B) => 
(( ? [Var_A] : 
 (hasType(type_AntigenA, Var_A) &  
(f_part(Var_A,Var_B)))))))).

fof(axMidLem233, axiom, 
 ( ! [Var_B] : 
 (hasType(type_BloodTypeAB, Var_B) => 
(( ? [Var_A] : 
 (hasType(type_AntigenB, Var_A) &  
(f_part(Var_A,Var_B)))))))).

fof(axMidLem234, axiom, 
 ( ! [Var_B] : 
 (hasType(type_BloodTypeB, Var_B) => 
(( ? [Var_A] : 
 (hasType(type_AntigenB, Var_A) &  
(f_part(Var_A,Var_B)))))))).

fof(axMidLem235, axiom, 
 ( ! [Var_N] : 
 (hasType(type_NerveCell, Var_N) => 
(( ? [Var_S] : 
 (hasType(type_NervousSystem, Var_S) &  
(f_part(Var_N,Var_S)))))))).

fof(axMidLem236, axiom, 
 ( ! [Var_SUBSTANCE] : 
 (hasType(type_LiquidBodySubstance, Var_SUBSTANCE) => 
(f_attribute(Var_SUBSTANCE,inst_Liquid))))).

fof(axMidLem237, axiom, 
 ( ! [Var_T] : 
 (hasType(type_TearSubstance, Var_T) => 
(( ? [Var_E] : 
 (hasType(type_Eye, Var_E) &  
(( ? [Var_P] : 
 (hasType(type_Process, Var_P) &  
(((f_instrument(Var_P,Var_E)) & (f_result(Var_P,Var_T))))))))))))).

fof(axMidLem238, axiom, 
 ( ! [Var_MILK] : 
 (hasType(type_Milk, Var_MILK) => 
(( ? [Var_MAMMAL] : 
 (hasType(type_Mammal, Var_MAMMAL) &  
(( ? [Var_PROCESS] : 
 (hasType(type_Process, Var_PROCESS) &  
(((f_attribute(Var_MAMMAL,inst_Female)) & (((f_instrument(Var_PROCESS,Var_MAMMAL)) & (f_result(Var_PROCESS,Var_MILK))))))))))))))).

fof(axMidLem239, axiom, 
 ( ! [Var_NUCLEUS] : 
 (hasType(type_CellNucleus, Var_NUCLEUS) => 
(( ? [Var_CELL] : 
 (hasType(type_Cell, Var_CELL) &  
(f_part(Var_NUCLEUS,Var_CELL)))))))).

fof(axMidLem240, axiom, 
 ( ! [Var_BEVERAGE] : 
 (hasType(type_AlcoholicBeverage, Var_BEVERAGE) => 
(( ? [Var_ALCOHOL] : 
 (hasType(type_Alcohol, Var_ALCOHOL) &  
(f_part(Var_ALCOHOL,Var_BEVERAGE)))))))).

fof(axMidLem241, axiom, 
 ( ! [Var_BEVERAGE] : 
 (hasType(type_DistilledAlcoholicBeverage, Var_BEVERAGE) => 
(( ? [Var_REMOVE] : 
 (hasType(type_Removing, Var_REMOVE) &  
(( ? [Var_WATER] : 
 (hasType(type_Water, Var_WATER) &  
(((f_patient(Var_REMOVE,Var_WATER)) & (f_origin(Var_REMOVE,Var_BEVERAGE))))))))))))).

fof(axMidLem242, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Brandy, Var_B) => 
(( ? [Var_D] : 
 (hasType(type_Distilling, Var_D) &  
(( ? [Var_W] : 
 (hasType(type_Wine, Var_W) &  
(((f_resourceS(Var_D,Var_W)) & (f_result(Var_D,Var_B))))))))))))).

fof(axMidLem243, axiom, 
 ( ! [Var_C] : 
 (hasType(type_SpinalCord, Var_C) => 
(( ? [Var_S] : 
 (hasType(type_NervousSystem, Var_S) &  
(f_part(Var_C,Var_S)))))))).

fof(axMidLem244, axiom, 
 ( ! [Var_C] : 
 (hasType(type_SpinalCord, Var_C) => 
(( ? [Var_S] : 
 (hasType(type_SpinalColumn, Var_S) &  
(f_contains(Var_S,Var_C)))))))).

fof(axMidLem245, axiom, 
 ( ! [Var_SKIN] : 
 (hasType(type_Skin, Var_SKIN) => 
(( ? [Var_ANIMAL] : 
 (hasType(type_Animal, Var_ANIMAL) &  
(( ? [Var_SURFACE] : 
 ((hasType(type_SelfConnectedObject, Var_SURFACE) & hasType(type_Object, Var_SURFACE)) &  
(((f_surface(Var_SURFACE,Var_ANIMAL)) & (((f_part(Var_SKIN,Var_ANIMAL)) & (f_overlapsSpatially(Var_SKIN,Var_SURFACE))))))))))))))).

fof(axMidLem246, axiom, 
 ( ! [Var_R] : 
 (hasType(type_Retina, Var_R) => 
(( ? [Var_E] : 
 (hasType(type_Eye, Var_E) &  
(f_part(Var_R,Var_E)))))))).

fof(axMidLem247, axiom, 
 ( ! [Var_DUCT] : 
 (hasType(type_BronchialDuct, Var_DUCT) => 
(( ? [Var_LUNG] : 
 (hasType(type_Lung, Var_LUNG) &  
(f_located(Var_DUCT,Var_LUNG)))))))).

fof(axMidLem248, axiom, 
 ( ! [Var_VESSEL] : 
 (hasType(type_BloodVessel, Var_VESSEL) => 
(( ? [Var_BLOOD] : 
 (hasType(type_Blood, Var_BLOOD) &  
(( ? [Var_TRANSFER] : 
 (hasType(type_Transfer, Var_TRANSFER) &  
(((f_patient(Var_TRANSFER,Var_BLOOD)) & (f_instrument(Var_TRANSFER,Var_VESSEL))))))))))))).

fof(axMidLem249, axiom, 
 ( ! [Var_A] : 
 (hasType(type_Alveolus, Var_A) => 
(( ? [Var_L] : 
 (hasType(type_Lung, Var_L) &  
(f_located(Var_A,Var_L)))))))).

fof(axMidLem250, axiom, 
 ( ! [Var_ARTERY] : 
 (hasType(type_Artery, Var_ARTERY) => 
(( ! [Var_TRANSFER] : 
 (hasType(type_Transfer, Var_TRANSFER) => 
(( ! [Var_BLOOD] : 
 (hasType(type_Blood, Var_BLOOD) => 
(((((f_patient(Var_TRANSFER,Var_BLOOD)) & (f_instrument(Var_TRANSFER,Var_ARTERY)))) => (( ? [Var_HEART] : 
 (hasType(type_Heart, Var_HEART) &  
(f_origin(Var_TRANSFER,Var_HEART)))))))))))))))).

fof(axMidLem251, axiom, 
 ( ! [Var_V] : 
 (hasType(type_Vein, Var_V) => 
(( ! [Var_T] : 
 (hasType(type_Transfer, Var_T) => 
(( ! [Var_B] : 
 (hasType(type_Blood, Var_B) => 
(((((f_patient(Var_T,Var_B)) & (f_instrument(Var_T,Var_V)))) => (( ? [Var_H] : 
 (hasType(type_Heart, Var_H) &  
(f_destination(Var_T,Var_H)))))))))))))))).

fof(axMidLem252, axiom, 
 ( ! [Var_ARTERY] : 
 (hasType(type_PulmonaryArtery, Var_ARTERY) => 
(( ! [Var_TRANSFER] : 
 (hasType(type_Transfer, Var_TRANSFER) => 
(( ! [Var_BLOOD] : 
 (hasType(type_Blood, Var_BLOOD) => 
(((((f_patient(Var_TRANSFER,Var_BLOOD)) & (f_instrument(Var_TRANSFER,Var_ARTERY)))) => (( ? [Var_LUNG] : 
 (hasType(type_Lung, Var_LUNG) &  
(f_destination(Var_TRANSFER,Var_LUNG)))))))))))))))).

fof(axMidLem253, axiom, 
 ( ! [Var_V] : 
 (hasType(type_PulmonaryVein, Var_V) => 
(( ! [Var_T] : 
 (hasType(type_Transfer, Var_T) => 
(( ! [Var_B] : 
 (hasType(type_Blood, Var_B) => 
(((((f_patient(Var_T,Var_B)) & (f_instrument(Var_T,Var_V)))) => (( ? [Var_L] : 
 (hasType(type_Lung, Var_L) &  
(( ? [Var_H] : 
 (hasType(type_Heart, Var_H) &  
(( ? [Var_P] : 
 (hasType(type_Object, Var_P) &  
(((f_origin(Var_T,Var_L)) & (((f_part(Var_V,Var_P)) & (((f_part(Var_L,Var_P)) & (((f_part(Var_H,Var_P)) & (f_destination(Var_T,Var_H)))))))))))))))))))))))))))))).

fof(axMidLem254, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Capillary, Var_C) => 
(( ? [Var_A] : 
 (hasType(type_Artery, Var_A) &  
(( ? [Var_V] : 
 (hasType(type_Vein, Var_V) &  
(f_connects(Var_C,Var_A,Var_V))))))))))).

fof(axMidLem255, axiom, 
 ( ! [Var_I] : 
 (hasType(type_Inhaling, Var_I) => 
(( ? [Var_L] : 
 (hasType(type_Lung, Var_L) &  
(f_destination(Var_I,Var_L)))))))).

fof(axMidLem256, axiom, 
 ( ! [Var_E] : 
 (hasType(type_Exhaling, Var_E) => 
(( ? [Var_L] : 
 (hasType(type_Lung, Var_L) &  
(f_origin(Var_E,Var_L)))))))).

fof(axMidLem257, axiom, 
 ( ! [Var_NOSE] : 
 (hasType(type_Nose, Var_NOSE) => 
(( ? [Var_N1] : 
 (hasType(type_Nostril, Var_N1) &  
(( ? [Var_N2] : 
 (hasType(type_Nostril, Var_N2) &  
(((Var_N1 != Var_N2) & (((f_connected(Var_N1,Var_NOSE)) & (f_connected(Var_N2,Var_NOSE))))))))))))))).

fof(axMidLem258, axiom, 
 ( ! [Var_NOS] : 
 (hasType(type_Nostril, Var_NOS) => 
(( ? [Var_N] : 
 (hasType(type_Nose, Var_N) &  
(( ? [Var_T] : 
 (hasType(type_Throat, Var_T) &  
(f_connects(Var_NOS,Var_N,Var_T))))))))))).

fof(axMidLem259, axiom, 
 ( ! [Var_HEART] : 
 (hasType(type_Heart, Var_HEART) => 
(( ? [Var_TRANSFER] : 
 (hasType(type_Transfer, Var_TRANSFER) &  
(( ? [Var_BLOOD] : 
 (hasType(type_Blood, Var_BLOOD) &  
(((f_instrument(Var_TRANSFER,Var_HEART)) & (f_patient(Var_TRANSFER,Var_BLOOD))))))))))))).

fof(axMidLem260, axiom, 
 ( ! [Var_MOUTH] : 
 (hasType(type_Mouth, Var_MOUTH) => 
(( ? [Var_FACE] : 
 (hasType(type_Face, Var_FACE) &  
(f_part(Var_MOUTH,Var_FACE)))))))).

fof(axMidLem261, axiom, 
 ( ! [Var_TONGUE] : 
 (hasType(type_Tongue, Var_TONGUE) => 
(( ? [Var_MOUTH] : 
 (hasType(type_Mouth, Var_MOUTH) &  
(f_part(Var_TONGUE,Var_MOUTH)))))))).

fof(axMidLem262, axiom, 
 ( ! [Var_H] : 
 (hasType(type_Hoof, Var_H) => 
(( ? [Var_F] : 
 (hasType(type_Foot, Var_F) &  
(( ? [Var_A] : 
 (hasType(type_HoofedMammal, Var_A) &  
(((f_part(Var_H,Var_F)) & (f_part(Var_F,Var_A))))))))))))).

fof(axMidLem263, axiom, 
 ( ! [Var_TOOTH] : 
 (hasType(type_Tooth, Var_TOOTH) => 
(( ? [Var_MOUTH] : 
 (hasType(type_Mouth, Var_MOUTH) &  
(f_part(Var_TOOTH,Var_MOUTH)))))))).

fof(axMidLem264, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Skull, Var_S) => 
(( ? [Var_V] : 
 (hasType(type_Vertebrate, Var_V) &  
(( ? [Var_H] : 
 (hasType(type_Head, Var_H) &  
(((f_part(Var_H,Var_V)) & (f_part(Var_S,Var_H))))))))))))).

fof(axMidLem265, axiom, 
 ( ! [Var_H] : 
 (hasType(type_Horn, Var_H) => 
(( ? [Var_M] : 
 (hasType(type_HoofedMammal, Var_M) &  
(f_part(Var_H,Var_M)))))))).

fof(axMidLem266, axiom, 
 ( ! [Var_O] : 
 (hasType(type_Ossification, Var_O) => 
(( ? [Var_B] : 
 (hasType(type_Bone, Var_B) &  
(f_result(Var_O,Var_B)))))))).

fof(axMidLem267, axiom, 
 ( ! [Var_CHEW] : 
 (hasType(type_Chewing, Var_CHEW) => 
(( ? [Var_EAT] : 
 (hasType(type_Eating, Var_EAT) &  
(f_subProcess(Var_CHEW,Var_EAT)))))))).

fof(axMidLem268, axiom, 
 ( ! [Var_LIP] : 
 (hasType(type_Lip, Var_LIP) => 
(( ? [Var_MOUTH] : 
 (hasType(type_Mouth, Var_MOUTH) &  
(f_part(Var_LIP,Var_MOUTH)))))))).

fof(axMidLem269, axiom, 
 ( ! [Var_L] : 
 (hasType(type_Licking, Var_L) => 
(( ? [Var_T] : 
 (hasType(type_Tongue, Var_T) &  
(f_instrument(Var_L,Var_T)))))))).

fof(axMidLem270, axiom, 
 ( ! [Var_E] : 
 (hasType(type_Embracing, Var_E) => 
(( ? [Var_P1] : 
 (hasType(type_Human, Var_P1) &  
(( ? [Var_P2] : 
 (hasType(type_Human, Var_P2) &  
(((Var_P1 != Var_P2) & (((f_agent(Var_E,Var_P1)) & (f_agent(Var_E,Var_P2))))))))))))))).

fof(axMidLem271, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Skeleton, Var_S) => 
(( ? [Var_A] : 
 (hasType(type_Animal, Var_A) &  
(f_interiorPart(Var_S,Var_A)))))))).

fof(axMidLem272, axiom, 
 ( ! [Var_BONE] : 
 (hasType(type_Bone, Var_BONE) => 
(( ? [Var_SKELETON] : 
 ((hasType(type_Skeleton, Var_SKELETON) | hasType(type_Exoskeleton, Var_SKELETON)) &  
(f_part(Var_BONE,Var_SKELETON)))))))).

fof(axMidLem273, axiom, 
 ( ! [Var_X] : 
 (hasType(type_Exoskeleton, Var_X) => 
(( ? [Var_A] : 
 (hasType(type_Animal, Var_A) &  
(((f_part(Var_X,Var_A)) & (( ~ ( ? [Var_PART] : 
 (hasType(type_Object, Var_PART) &  
(((f_properPart(Var_PART,Var_A)) & (f_orientation(Var_PART,Var_X,inst_Outside)))))))))))))))).

fof(axMidLem274, axiom, 
 ( ! [Var_J] : 
 (hasType(type_BodyJoint, Var_J) => 
(( ? [Var_S] : 
 (hasType(type_Skeleton, Var_S) &  
(( ? [Var_P2] : 
 ((hasType(type_CorpuscularObject, Var_P2) & hasType(type_SelfConnectedObject, Var_P2)) &  
(( ? [Var_P1] : 
 ((hasType(type_CorpuscularObject, Var_P1) & hasType(type_SelfConnectedObject, Var_P1)) &  
(((f_component(Var_P1,Var_S)) & (((f_component(Var_P2,Var_S)) & (((f_component(Var_J,Var_S)) & (f_connects(Var_J,Var_P1,Var_P2)))))))))))))))))))).

fof(axMidLem275, axiom, 
 ( ! [Var_THROAT] : 
 (hasType(type_Throat, Var_THROAT) => 
(( ? [Var_MOUTH] : 
 (hasType(type_Mouth, Var_MOUTH) &  
(f_connected(Var_THROAT,Var_MOUTH)))))))).

fof(axMidLem276, axiom, 
 ( ! [Var_HAIR] : 
 (hasType(type_Hair, Var_HAIR) => 
(( ? [Var_MAMMAL] : 
 (hasType(type_Mammal, Var_MAMMAL) &  
(( ? [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) &  
(f_holdsDuring(Var_TIME,part(Var_HAIR,Var_MAMMAL)))))))))))).

fof(axMidLem277, axiom, 
 ( ! [Var_H] : 
 (hasType(type_FacialHair, Var_H) => 
(( ? [Var_F] : 
 (hasType(type_Face, Var_F) &  
(f_part(Var_H,Var_F)))))))).

fof(axMidLem278, axiom, 
 ( ! [Var_P] : 
 (hasType(type_Peeling, Var_P) => 
(( ! [Var_O] : 
 ((hasType(type_Entity, Var_O) & hasType(type_Object, Var_O)) => 
(((f_patient(Var_P,Var_O)) => (( ? [Var_S] : 
 (hasType(type_Skin, Var_S) &  
(f_part(Var_O,Var_S))))))))))))).

fof(axMidLem279, axiom, 
 ( ! [Var_I] : 
 (hasType(type_Intestine, Var_I) => 
(( ? [Var_S] : 
 (hasType(type_Stomach, Var_S) &  
(f_connected(Var_I,Var_S)))))))).

fof(axMidLem280, axiom, 
 ( ! [Var_HYPO] : 
 (hasType(type_Hypothalamus, Var_HYPO) => 
(( ? [Var_BRAIN] : 
 (hasType(type_Brain, Var_BRAIN) &  
(f_part(Var_HYPO,Var_BRAIN)))))))).

fof(axMidLem281, axiom, 
 ( ! [Var_EYE] : 
 (hasType(type_Eye, Var_EYE) => 
(( ? [Var_HEAD] : 
 (hasType(type_Head, Var_HEAD) &  
(f_part(Var_EYE,Var_HEAD)))))))).

fof(axMidLem282, axiom, 
 ( ! [Var_EAR] : 
 (hasType(type_Ear, Var_EAR) => 
(( ? [Var_HEAD] : 
 (hasType(type_Head, Var_HEAD) &  
(f_part(Var_EAR,Var_HEAD)))))))).

fof(axMidLem283, axiom, 
 ( ! [Var_NOSE] : 
 (hasType(type_Nose, Var_NOSE) => 
(( ? [Var_FACE] : 
 (hasType(type_Face, Var_FACE) &  
(f_part(Var_NOSE,Var_FACE)))))))).

fof(axMidLem284, axiom, 
 ( ! [Var_HORMONE] : 
 (hasType(type_HormoneTSH, Var_HORMONE) => 
(( ? [Var_GLAND] : 
 (hasType(type_ThyroidGland, Var_GLAND) &  
(( ? [Var_PROC] : 
 (hasType(type_Process, Var_PROC) &  
(((f_instrument(Var_PROC,Var_GLAND)) & (f_result(Var_PROC,Var_HORMONE))))))))))))).

fof(axMidLem285, axiom, 
 ( ! [Var_ARM] : 
 (hasType(type_Arm, Var_ARM) => 
(( ? [Var_PRIMATE] : 
 (hasType(type_Primate, Var_PRIMATE) &  
(f_part(Var_ARM,Var_PRIMATE)))))))).

fof(axMidLem286, axiom, 
 ( ! [Var_HAND] : 
 (hasType(type_Hand, Var_HAND) => 
(( ? [Var_ARM] : 
 (hasType(type_Arm, Var_ARM) &  
(f_part(Var_HAND,Var_ARM)))))))).

fof(axMidLem287, axiom, 
 ( ! [Var_DIGIT] : 
 (hasType(type_DigitAppendage, Var_DIGIT) => 
(( ? [Var_LIMB] : 
 (hasType(type_Limb, Var_LIMB) &  
(f_part(Var_DIGIT,Var_LIMB)))))))).

fof(axMidLem288, axiom, 
 ( ! [Var_FINGER] : 
 (hasType(type_Finger, Var_FINGER) => 
(( ? [Var_HAND] : 
 (hasType(type_Hand, Var_HAND) &  
(f_part(Var_FINGER,Var_HAND)))))))).

fof(axMidLem289, axiom, 
 ( ! [Var_N] : 
 (hasType(type_NailDigit, Var_N) => 
(( ? [Var_D] : 
 (hasType(type_DigitAppendage, Var_D) &  
(f_part(Var_N,Var_D)))))))).

fof(axMidLem290, axiom, 
 ( ! [Var_LIMB] : 
 (hasType(type_Limb, Var_LIMB) => 
(( ? [Var_VERTEBRATE] : 
 (hasType(type_Vertebrate, Var_VERTEBRATE) &  
(f_part(Var_LIMB,Var_VERTEBRATE)))))))).

fof(axMidLem291, axiom, 
 ( ! [Var_LEG] : 
 (hasType(type_Leg, Var_LEG) => 
(( ? [Var_PRIMATE] : 
 (hasType(type_Primate, Var_PRIMATE) &  
(f_part(Var_LEG,Var_PRIMATE)))))))).

fof(axMidLem292, axiom, 
 ( ! [Var_FOOT] : 
 (hasType(type_Foot, Var_FOOT) => 
(( ? [Var_LIMB] : 
 (hasType(type_Leg, Var_LIMB) &  
(f_part(Var_FOOT,Var_LIMB)))))))).

fof(axMidLem293, axiom, 
 ( ! [Var_A] : 
 (hasType(type_Ankle, Var_A) => 
(( ? [Var_L] : 
 (hasType(type_Leg, Var_L) &  
(f_part(Var_A,Var_L)))))))).

fof(axMidLem294, axiom, 
 ( ! [Var_E] : 
 (hasType(type_Elbow, Var_E) => 
(( ? [Var_A] : 
 (hasType(type_Arm, Var_A) &  
(f_part(Var_E,Var_A)))))))).

fof(axMidLem295, axiom, 
 ( ! [Var_W] : 
 (hasType(type_Wrist, Var_W) => 
(( ? [Var_A] : 
 (hasType(type_Arm, Var_A) &  
(f_part(Var_W,Var_A)))))))).

fof(axMidLem296, axiom, 
 ( ! [Var_TOE] : 
 (hasType(type_Toe, Var_TOE) => 
(( ? [Var_FOOT] : 
 (hasType(type_Foot, Var_FOOT) &  
(f_part(Var_TOE,Var_FOOT)))))))).

fof(axMidLem297, axiom, 
 ( ! [Var_KNEE] : 
 (hasType(type_Knee, Var_KNEE) => 
(( ? [Var_LEG] : 
 (hasType(type_Leg, Var_LEG) &  
(f_part(Var_KNEE,Var_LEG)))))))).

fof(axMidLem298, axiom, 
 ( ! [Var_SHOULDER] : 
 (hasType(type_Shoulder, Var_SHOULDER) => 
(( ? [Var_PRIMATE] : 
 (hasType(type_Primate, Var_PRIMATE) &  
(f_part(Var_SHOULDER,Var_PRIMATE)))))))).

fof(axMidLem299, axiom, 
 ( ! [Var_KNUCKLE] : 
 (hasType(type_Knuckle, Var_KNUCKLE) => 
(( ? [Var_FINGER] : 
 (hasType(type_Finger, Var_FINGER) &  
(f_part(Var_KNUCKLE,Var_FINGER)))))))).

fof(axMidLem300, axiom, 
 ( ! [Var_TORSO] : 
 (hasType(type_Torso, Var_TORSO) => 
(( ! [Var_LIMB] : 
 (hasType(type_Limb, Var_LIMB) => 
(( ~ (f_overlapsSpatially(Var_TORSO,Var_LIMB)))))))))).

fof(axMidLem301, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Breast, Var_B) => 
(( ? [Var_T] : 
 (hasType(type_Torso, Var_T) &  
(f_part(Var_B,f_FrontFn(Var_T))))))))).

fof(axMidLem302, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Breast, Var_B) => 
(( ? [Var_P] : 
 (hasType(type_Primate, Var_P) &  
(f_part(Var_B,Var_P)))))))).

fof(axMidLem303, axiom, 
 ( ! [Var_NECK] : 
 (hasType(type_Neck, Var_NECK) => 
(( ? [Var_HEAD] : 
 (hasType(type_Head, Var_HEAD) &  
(f_connected(Var_NECK,Var_HEAD)))))))).

fof(axMidLem304, axiom, 
 ( ! [Var_FACE] : 
 (hasType(type_Face, Var_FACE) => 
(( ? [Var_HEAD] : 
 (hasType(type_Head, Var_HEAD) &  
(f_part(Var_FACE,Var_HEAD)))))))).

fof(axMidLem305, axiom, 
 ( ! [Var_FACE] : 
 (hasType(type_Face, Var_FACE) => 
(( ? [Var_VERTEBRATE] : 
 (hasType(type_Vertebrate, Var_VERTEBRATE) &  
(f_part(Var_FACE,Var_VERTEBRATE)))))))).

fof(axMidLem306, axiom, 
 ( ! [Var_CHIN] : 
 (hasType(type_Chin, Var_CHIN) => 
(( ? [Var_FACE] : 
 (hasType(type_Face, Var_FACE) &  
(f_part(Var_CHIN,Var_FACE)))))))).

fof(axMidLem307, axiom, 
 ( ! [Var_CHIN] : 
 (hasType(type_Chin, Var_CHIN) => 
(( ! [Var_FACE] : 
 (hasType(type_Object, Var_FACE) => 
(( ! [Var_PART] : 
 (hasType(type_Object, Var_PART) => 
(((((f_part(Var_PART,Var_FACE)) & (( ~ (f_part(Var_PART,Var_CHIN)))))) => (f_orientation(Var_PART,Var_CHIN,inst_Below))))))))))))).

fof(axMidLem308, axiom, 
 ( ! [Var_R] : 
 (hasType(type_Regretting, Var_R) => 
(( ! [Var_T] : 
 (hasType(type_Sentence, Var_T) => 
(((f_patient(Var_R,Var_T)) => (f_truth(Var_T,inst_True)))))))))).

fof(axMidLem309, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Congratulating, Var_C) => 
(( ? [Var_D] : 
 ((hasType(type_Entity, Var_D) & hasType(type_Agent, Var_D)) &  
(( ? [Var_A] : 
 ((hasType(type_Agent, Var_A) & hasType(type_CognitiveAgent, Var_A)) &  
(( ? [Var_P] : 
 ((hasType(type_Process, Var_P) & hasType(type_Physical, Var_P) & hasType(type_Entity, Var_P)) &  
(((f_destination(Var_C,Var_D)) & (((f_agent(Var_P,Var_D)) & (((f_agent(Var_C,Var_A)) & (((f_wants(Var_A,Var_P)) & (f_refers(Var_C,Var_P)))))))))))))))))))))).

fof(axMidLem310, axiom, 
 ( ! [Var_EXPRESS] : 
 (hasType(type_FacialExpression, Var_EXPRESS) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((f_agent(Var_EXPRESS,Var_AGENT)) => (( ? [Var_FACE] : 
 (hasType(type_Face, Var_FACE) &  
(((f_part(Var_FACE,Var_AGENT)) & (f_instrument(Var_EXPRESS,Var_FACE))))))))))))))).

fof(axMidLem311, axiom, 
 ( ! [Var_SMILE] : 
 (hasType(type_Smiling, Var_SMILE) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((f_agent(Var_SMILE,Var_AGENT)) => (f_holdsDuring(f_WhenFn(Var_SMILE),attribute(Var_AGENT,inst_Happiness))))))))))).

fof(axMidLem312, axiom, 
 ( ! [Var_FROWN] : 
 (hasType(type_Frowning, Var_FROWN) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((f_agent(Var_FROWN,Var_AGENT)) => (f_holdsDuring(f_WhenFn(Var_FROWN),attribute(Var_AGENT,inst_Unhappiness))))))))))).

fof(axMidLem313, axiom, 
 ( ! [Var_LAUGH] : 
 (hasType(type_Laughing, Var_LAUGH) => 
(( ? [Var_SMILE] : 
 (hasType(type_Smiling, Var_SMILE) &  
(f_subProcess(Var_SMILE,Var_LAUGH)))))))).

fof(axMidLem314, axiom, 
 ( ! [Var_WEEP] : 
 (hasType(type_Weeping, Var_WEEP) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((f_agent(Var_WEEP,Var_AGENT)) => (f_holdsDuring(f_WhenFn(Var_WEEP),attribute(Var_AGENT,inst_Unhappiness))))))))))).

fof(axMidLem315, axiom, 
 ( ! [Var_HG] : 
 (hasType(type_HandGesture, Var_HG) => 
(( ? [Var_H] : 
 (hasType(type_Hand, Var_H) &  
(f_patient(Var_HG,Var_H)))))))).

fof(axMidLem316, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Sinking, Var_S) => 
(( ? [Var_W] : 
 (hasType(type_BodyOfWater, Var_W) &  
(f_located(Var_S,Var_W)))))))).

fof(axMidLem317, axiom, 
 ( ! [Var_WHOLE] : 
 ((hasType(type_Object, Var_WHOLE) & hasType(type_Entity, Var_WHOLE)) => 
(( ! [Var_HALF] : 
 ((hasType(type_Object, Var_HALF) & hasType(type_Entity, Var_HALF)) => 
(((f_half(Var_HALF,Var_WHOLE)) => (( ? [Var_OTHER] : 
 ((hasType(type_Object, Var_OTHER) & hasType(type_Entity, Var_OTHER)) &  
(((f_half(Var_OTHER,Var_WHOLE)) & (((Var_OTHER != Var_HALF) & (Var_WHOLE = f_MereologicalSumFn(Var_HALF,Var_OTHER))))))))))))))))).

fof(axMidLem318, axiom, 
 ( ! [Var_W] : 
 ((hasType(type_Object, Var_W) & hasType(type_Entity, Var_W)) => 
(( ! [Var_T] : 
 ((hasType(type_Object, Var_T) & hasType(type_Entity, Var_T)) => 
(((f_third(Var_T,Var_W)) => (( ? [Var_O2] : 
 ((hasType(type_Object, Var_O2) & hasType(type_Entity, Var_O2)) &  
(( ? [Var_O1] : 
 ((hasType(type_Object, Var_O1) & hasType(type_Entity, Var_O1)) &  
(((f_third(Var_O1,Var_W)) & (((f_third(Var_O2,Var_W)) & (((Var_O1 != Var_T) & (((Var_O2 != Var_T) & (((Var_O1 != Var_O2) & (Var_W = f_MereologicalSumFn(Var_T,f_MereologicalSumFn(Var_O1,Var_O2))))))))))))))))))))))))))).

fof(axMidLem319, axiom, 
 ( ! [Var_W] : 
 (hasType(type_Object, Var_W) => 
(( ! [Var_Q] : 
 (hasType(type_Object, Var_Q) => 
(((f_quarter(Var_Q,Var_W)) <=> (( ? [Var_H] : 
 (hasType(type_Object, Var_H) &  
(((f_half(Var_H,Var_W)) & (f_half(Var_Q,Var_H))))))))))))))).

fof(axMidLem320, axiom, 
 ( ! [Var_WHOLE] : 
 (hasType(type_Object, Var_WHOLE) => 
(( ! [Var_MOST] : 
 (hasType(type_Object, Var_MOST) => 
(((f_most(Var_MOST,Var_WHOLE)) => (( ? [Var_UNIT] : 
 (hasType(type_UnitOfMeasure, Var_UNIT) &  
(( ? [Var_NUMBER2] : 
 ((hasType(type_RealNumber, Var_NUMBER2) & hasType(type_Quantity, Var_NUMBER2)) &  
(( ? [Var_NUMBER1] : 
 ((hasType(type_RealNumber, Var_NUMBER1) & hasType(type_Quantity, Var_NUMBER1)) &  
(( ? [Var_HALF] : 
 (hasType(type_Object, Var_HALF) &  
(((f_half(Var_HALF,Var_WHOLE)) & (((f_measure(Var_HALF,f_MeasureFn(Var_NUMBER1,Var_UNIT))) & (((f_measure(Var_MOST,f_MeasureFn(Var_NUMBER2,Var_UNIT))) & (f_greaterThan(Var_NUMBER2,Var_NUMBER1)))))))))))))))))))))))))))).

fof(axMidLem321, axiom, 
 ( ! [Var_CHART] : 
 (hasType(type_Chart, Var_CHART) => 
(( ? [Var_QUANTITY] : 
 (hasType(type_PhysicalQuantity, Var_QUANTITY) &  
(f_refers(Var_CHART,Var_QUANTITY)))))))).

fof(axMidLem322, axiom, 
 ( ! [Var_FLAG] : 
 (hasType(type_Flag, Var_FLAG) => 
(( ? [Var_FABRIC] : 
 (hasType(type_Fabric, Var_FABRIC) &  
(f_part(Var_FABRIC,Var_FLAG)))))))).

fof(axMidLem323, axiom, 
 ( ! [Var_FLAG] : 
 (hasType(type_Flag, Var_FLAG) => 
(( ? [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) &  
(f_refers(Var_FLAG,Var_AREA)))))))).

fof(axMidLem324, axiom, 
 ( ! [Var_F] : 
 (hasType(type_Flag, Var_F) => 
(( ? [Var_N] : 
 (hasType(type_Nation, Var_N) &  
(f_refers(Var_F,Var_N)))))))).

fof(axMidLem325, axiom, 
 ( ! [Var_G] : 
 (hasType(type_GraphDiagram, Var_G) => 
(( ? [Var_Q] : 
 (hasType(type_PhysicalQuantity, Var_Q) &  
(f_refers(Var_G,Var_Q)))))))).

fof(axMidLem326, axiom, 
 ( ! [Var_M] : 
 (hasType(type_Map, Var_M) => 
(( ? [Var_A] : 
 (hasType(type_GeographicArea, Var_A) &  
(f_represents(Var_M,Var_A)))))))).

fof(axMidLem327, axiom, 
 ( ! [Var_SHOOT] : 
 (hasType(type_Photographing, Var_SHOOT) => 
(( ? [Var_PHOTO] : 
 (hasType(type_Photograph, Var_PHOTO) &  
(( ? [Var_CAMERA] : 
 (hasType(type_Camera, Var_CAMERA) &  
(((f_result(Var_SHOOT,Var_PHOTO)) & (f_instrument(Var_SHOOT,Var_CAMERA))))))))))))).

fof(axMidLem328, axiom, 
 ( ! [Var_COMPOSE] : 
 (hasType(type_Composing, Var_COMPOSE) => 
(( ? [Var_MUSIC] : 
 (hasType(type_MusicalComposition, Var_MUSIC) &  
(f_result(Var_COMPOSE,Var_MUSIC)))))))).

fof(axMidLem329, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_TonMass) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,2000),inst_PoundMass))))))).

fof(axMidLem330, axiom, 
 ( ! [Var_A] : 
 ((hasType(type_RealNumber, Var_A) & hasType(type_Quantity, Var_A)) => 
(( ! [Var_O] : 
 (hasType(type_Object, Var_O) => 
(((f_measure(Var_O,f_MeasureFn(Var_A,inst_MetricTon))) <=> (f_measure(Var_O,f_MeasureFn(f_MultiplicationFn(Var_A,2205),inst_PoundMass))))))))))).

fof(axMidLem331, axiom, 
 ( ! [Var_N] : 
 ((hasType(type_Entity, Var_N) & hasType(type_RealNumber, Var_N) & hasType(type_Quantity, Var_N)) => 
(((Var_N = f_MultiplicationFn(1,Var_N)) => (f_MeasureFn(Var_N,inst_MillenniumDuration) = f_MeasureFn(f_MultiplicationFn(Var_N,1000),inst_YearDuration))))))).

fof(axMidLem332, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Song, Var_S) => 
(( ? [Var_L] : 
 (hasType(type_Lyrics, Var_L) &  
(f_part(Var_L,Var_S)))))))).

fof(axMidLem333, axiom, 
 ( ! [Var_PASS] : 
 (hasType(type_PassingABill, Var_PASS) => 
(( ! [Var_TEXT] : 
 ((hasType(type_Entity, Var_TEXT) & hasType(type_Object, Var_TEXT)) => 
(((f_patient(Var_PASS,Var_TEXT)) => (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_PASS)),attribute(Var_TEXT,inst_LegislativeBill))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_PASS)),attribute(Var_TEXT,inst_Law))))))))))))).

fof(axMidLem334, axiom, 
 ( ! [Var_L] : 
 (hasType(type_LawEnforcement, Var_L) => 
(( ! [Var_P] : 
 (hasType(type_PoliceOrganization, Var_P) => 
(( ! [Var_AGENT] : 
 (hasType(type_Agent, Var_AGENT) => 
(((f_agent(Var_L,Var_AGENT)) => (( ? [Var_O] : 
 (hasType(type_PoliceOrganization, Var_O) &  
(f_member(Var_P,Var_O)))))))))))))))).

fof(axMidLem335, axiom, 
 ( ! [Var_I] : 
 (hasType(type_Imprisoning, Var_I) => 
(( ? [Var_P] : 
 (hasType(type_Prison, Var_P) &  
(f_located(Var_I,Var_P)))))))).

fof(axMidLem336, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Espionage, Var_S) => 
(( ? [Var_GOV1] : 
 (hasType(type_Government, Var_GOV1) &  
(( ? [Var_GOV2] : 
 (hasType(type_Government, Var_GOV2) &  
(((f_agent(Var_S,Var_GOV1)) & (((f_patient(Var_S,Var_GOV2)) & (Var_GOV1 != Var_GOV2)))))))))))))).

fof(axMidLem337, axiom, 
 ( ! [Var_T] : 
 ((hasType(type_Object, Var_T) & hasType(type_Contract, Var_T)) => 
(((f_attribute(Var_T,inst_Treaty)) => (( ? [Var_N1] : 
 (hasType(type_Nation, Var_N1) &  
(( ? [Var_N2] : 
 (hasType(type_Nation, Var_N2) &  
(((f_agreementMember(Var_T,Var_N1)) & (((f_agreementMember(Var_T,Var_N2)) & (Var_N1 != Var_N2)))))))))))))))).

fof(axMidLem338, axiom, 
 ( ! [Var_FACT] : 
 (hasType(type_Fact, Var_FACT) => 
(f_truth(Var_FACT,inst_True))))).

fof(axMidLem339, axiom, 
 ( ! [Var_RECORD] : 
 (hasType(type_AudioRecording, Var_RECORD) => 
(( ? [Var_SOUND] : 
 (hasType(type_RadiatingSound, Var_SOUND) &  
(( ? [Var_INFO] : 
 (hasType(type_Proposition, Var_INFO) &  
(((f_containsInformation(Var_RECORD,Var_INFO)) & (f_realization(Var_SOUND,Var_INFO))))))))))))).

fof(axMidLem340, axiom, 
 ( ! [Var_LABEL] : 
 (hasType(type_Label, Var_LABEL) => 
(( ? [Var_OBJ] : 
 (hasType(type_SelfConnectedObject, Var_OBJ) &  
(((f_connected(Var_LABEL,Var_OBJ)) & (f_refers(Var_LABEL,Var_OBJ)))))))))).

fof(axMidLem341, axiom, 
 ( ! [Var_X] : 
 (hasType(type_DutyTax, Var_X) => 
(( ! [Var_OBJ] : 
 (hasType(type_Entity, Var_OBJ) => 
(((((f_refers(Var_X,Var_OBJ)) & (f_patient(Var_X,Var_OBJ)))) => (( ? [Var_T] : 
 (hasType(type_Transfer, Var_T) &  
(( ? [Var_N1] : 
 (hasType(type_Nation, Var_N1) &  
(( ? [Var_N2] : 
 (hasType(type_Nation, Var_N2) &  
(((f_patient(Var_T,Var_OBJ)) & (((f_origin(Var_T,Var_N1)) & (((f_destination(Var_T,Var_N2)) & (((Var_N1 != Var_N2) & (((f_earlier(f_WhenFn(Var_T),f_WhenFn(Var_X))) & (f_causes(Var_T,Var_X))))))))))))))))))))))))))))).

fof(axMidLem342, axiom, 
 ( ! [Var_A] : 
 (hasType(type_Announcement, Var_A) => 
(( ? [Var_CD] : 
 (hasType(type_ContentDevelopment, Var_CD) &  
(( ? [Var_I] : 
 (hasType(type_SocialInteraction, Var_I) &  
(((f_result(Var_CD,Var_A)) & (((f_refers(Var_A,Var_I)) & (f_earlier(f_WhenFn(Var_CD),f_WhenFn(Var_I)))))))))))))))).

fof(axMidLem343, axiom, 
 ( ! [Var_PROG] : 
 (hasType(type_PerformanceProgram, Var_PROG) => 
(( ? [Var_PERF] : 
 (hasType(type_Performance, Var_PERF) &  
(( ? [Var_PROP] : 
 (hasType(type_Proposition, Var_PROP) &  
(((f_containsInformation(Var_PROG,Var_PROP)) & (f_realization(Var_PERF,Var_PROP))))))))))))).

fof(axMidLem344, axiom, 
 ( ! [Var_SHOT] : 
 (hasType(type_MotionPictureShot, Var_SHOT) => 
(( ? [Var_MOVIE] : 
 (hasType(type_MotionPicture, Var_MOVIE) &  
(f_subsumesContentInstance(Var_MOVIE,Var_SHOT)))))))).

fof(axMidLem345, axiom, 
 ( ! [Var_S] : 
 (hasType(type_MotionPictureScene, Var_S) => 
(( ! [Var_MOVIE] : 
 (hasType(type_ContentBearingObject, Var_MOVIE) => 
(( ? [Var_M] : 
 (hasType(type_MotionPicture, Var_M) &  
(f_subsumesContentInstance(Var_MOVIE,Var_S))))))))))).

fof(axMidLem346, axiom, 
 ( ! [Var_PROGRAM] : 
 (hasType(type_BroadcastProgram, Var_PROGRAM) => 
(( ? [Var_BROADCAST] : 
 (hasType(type_Broadcasting, Var_BROADCAST) &  
(f_patient(Var_BROADCAST,Var_PROGRAM)))))))).

fof(axMidLem347, axiom, 
 ( ! [Var_CHAPTER] : 
 (hasType(type_Chapter, Var_CHAPTER) => 
(( ? [Var_BOOK] : 
 (hasType(type_Book, Var_BOOK) &  
(f_subsumesContentInstance(Var_BOOK,Var_CHAPTER)))))))).

fof(axMidLem348, axiom, 
 ( ! [Var_PAPER] : 
 (hasType(type_Newspaper, Var_PAPER) => 
(( ? [Var_REPORT] : 
 (hasType(type_Report, Var_REPORT) &  
(f_subsumesContentInstance(Var_PAPER,Var_REPORT)))))))).

fof(axMidLem349, axiom, 
 ( ! [Var_C] : 
 (hasType(type_HolidayCard, Var_C) => 
(f_material(type_Paper,Var_C))))).

fof(axMidLem350, axiom, 
 ( ! [Var_C] : 
 (hasType(type_HolidayCard, Var_C) => 
(( ? [Var_H] : 
 (hasType(type_Holiday, Var_H) &  
(f_refers(Var_C,Var_H)))))))).

fof(axMidLem351, axiom, 
 ( ! [Var_ACCOUNT] : 
 (hasType(type_HistoricalAccount, Var_ACCOUNT) => 
(( ? [Var_EVENT] : 
 ((hasType(type_Entity, Var_EVENT) & hasType(type_Physical, Var_EVENT)) &  
(((f_represents(Var_ACCOUNT,Var_EVENT)) & (f_earlier(f_WhenFn(Var_EVENT),f_WhenFn(Var_ACCOUNT))))))))))).

fof(axMidLem352, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Biography, Var_B) => 
(( ? [Var_H] : 
 (hasType(type_Human, Var_H) &  
(f_refers(Var_B,Var_H)))))))).

fof(axMidLem353, axiom, 
 ( ! [Var_S] : 
 (hasType(type_MysteryStory, Var_S) => 
(( ? [Var_C] : 
 (hasType(type_CriminalAction, Var_C) &  
(f_refers(Var_S,Var_C)))))))).

fof(axMidLem354, axiom, 
 ( ! [Var_H] : 
 ((hasType(type_Object, Var_H) & hasType(type_Agent, Var_H)) => 
(((f_attribute(Var_H,inst_LiteracyAttribute)) <=> (((f_hasSkill(type_Reading,Var_H)) & (f_hasSkill(type_Writing,Var_H))))))))).

fof(axMidLem355, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Curb, Var_C) => 
(( ? [Var_S] : 
 (hasType(type_Sidewalk, Var_S) &  
(( ? [Var_R] : 
 (hasType(type_Roadway, Var_R) &  
(f_connects(Var_C,Var_S,Var_R))))))))))).

fof(axMidLem356, axiom, 
 ( ! [Var_LEVEL1] : 
 (hasType(type_BuildingLevel, Var_LEVEL1) => 
(( ! [Var_LEVEL2] : 
 (hasType(type_BuildingLevel, Var_LEVEL2) => 
(( ! [Var_BUILDING] : 
 (hasType(type_Building, Var_BUILDING) => 
(((((f_part(Var_LEVEL1,Var_BUILDING)) & (f_part(Var_LEVEL2,Var_BUILDING)))) => (( ? [Var_STEPS] : 
 (hasType(type_Steps, Var_STEPS) &  
(f_connects(Var_STEPS,Var_LEVEL1,Var_LEVEL2)))))))))))))))).

fof(axMidLem357, axiom, 
 ( ! [Var_W] : 
 (hasType(type_Window, Var_W) => 
(f_attribute(Var_W,inst_Transparent))))).

fof(axMidLem358, axiom, 
 ( ! [Var_W] : 
 (hasType(type_Skylight, Var_W) => 
(( ? [Var_C] : 
 (hasType(type_Ceiling, Var_C) &  
(f_part(Var_W,Var_C)))))))).

fof(axMidLem359, axiom, 
 ( ! [Var_W] : 
 (hasType(type_RearWindow, Var_W) => 
(( ? [Var_A] : 
 (hasType(type_Automobile, Var_A) &  
(f_part(Var_W,f_BackFn(Var_A))))))))).

fof(axMidLem360, axiom, 
 ( ! [Var_DOOR] : 
 (hasType(type_Door, Var_DOOR) => 
(( ? [Var_WAY] : 
 (hasType(type_Doorway, Var_WAY) &  
(f_part(Var_DOOR,Var_WAY)))))))).

fof(axMidLem361, axiom, 
 ( ! [Var_WALL] : 
 (hasType(type_Wall, Var_WALL) => 
(( ? [Var_ARTIFACT] : 
 ((hasType(type_Building, Var_ARTIFACT) | hasType(type_Room, Var_ARTIFACT)) &  
(f_part(Var_WALL,Var_ARTIFACT)))))))).

fof(axMidLem362, axiom, 
 ( ! [Var_FLOOR] : 
 (hasType(type_Floor, Var_FLOOR) => 
(( ? [Var_ARTIFACT] : 
 (hasType(type_Room, Var_ARTIFACT) &  
(f_part(Var_FLOOR,Var_ARTIFACT)))))))).

fof(axMidLem363, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Ceiling, Var_C) => 
(( ? [Var_R] : 
 (hasType(type_Room, Var_R) &  
(f_top(Var_C,Var_R)))))))).

fof(axMidLem364, axiom, 
 ( ! [Var_ROOF] : 
 (hasType(type_Roof, Var_ROOF) => 
(( ? [Var_BUILDING] : 
 (hasType(type_Building, Var_BUILDING) &  
(f_top(Var_ROOF,Var_BUILDING)))))))).

fof(axMidLem365, axiom, 
 ( ! [Var_F] : 
 (hasType(type_Fireplace, Var_F) => 
(( ? [Var_C] : 
 (hasType(type_Chimney, Var_C) &  
(f_connected(Var_F,Var_C)))))))).

fof(axMidLem366, axiom, 
 ( ! [Var_F] : 
 (hasType(type_Fireplace, Var_F) => 
(( ? [Var_B] : 
 (hasType(type_Building, Var_B) &  
(f_part(Var_F,Var_B)))))))).

fof(axMidLem367, axiom, 
 ( ! [Var_LEVEL] : 
 (hasType(type_BuildingLevel, Var_LEVEL) => 
(( ? [Var_BUILDING] : 
 (hasType(type_Building, Var_BUILDING) &  
(f_part(Var_LEVEL,Var_BUILDING)))))))).

fof(axMidLem368, axiom, 
 ( ! [Var_T] : 
 (hasType(type_Transportation, Var_T) => 
(( ! [Var_D] : 
 (hasType(type_Pump, Var_D) => 
(((f_instrument(Var_T,Var_D)) => (( ? [Var_F] : 
 (hasType(type_Object, Var_F) &  
(((f_instrument(Var_T,Var_F)) & (f_attribute(Var_F,inst_Fluid))))))))))))))).

fof(axMidLem369, axiom, 
 ( ! [Var_GARAGE] : 
 (hasType(type_Garage, Var_GARAGE) => 
(( ? [Var_BUILDING] : 
 (hasType(type_Building, Var_BUILDING) &  
(f_part(Var_GARAGE,Var_BUILDING)))))))).

fof(axMidLem370, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Bathroom, Var_B) => 
(( ? [Var_W] : 
 (hasType(type_WashBasin, Var_W) &  
(f_located(Var_W,Var_B)))))))).

fof(axMidLem371, axiom, 
 ( ! [Var_ROOM] : 
 (hasType(type_Bedroom, Var_ROOM) => 
(( ? [Var_BED] : 
 (hasType(type_Bed, Var_BED) &  
(f_located(Var_BED,Var_ROOM)))))))).

fof(axMidLem372, axiom, 
 ( ! [Var_R] : 
 (hasType(type_Classroom, Var_R) => 
(( ? [Var_S] : 
 (hasType(type_School, Var_S) &  
(f_part(Var_R,Var_S)))))))).

fof(axMidLem373, axiom, 
 ( ! [Var_PORCH] : 
 (hasType(type_Porch, Var_PORCH) => 
(( ? [Var_BUILDING] : 
 (hasType(type_Building, Var_BUILDING) &  
(f_connected(Var_PORCH,Var_BUILDING)))))))).

fof(axMidLem374, axiom, 
 ( ! [Var_SIDE] : 
 (hasType(type_Sidewalk, Var_SIDE) => 
(( ? [Var_ROAD] : 
 (hasType(type_Roadway, Var_ROAD) &  
(f_orientation(Var_SIDE,Var_ROAD,inst_Near)))))))).

fof(axMidLem375, axiom, 
 ( ! [Var_LAB] : 
 (hasType(type_Laboratory, Var_LAB) => 
(( ? [Var_EXPERIMENT] : 
 (hasType(type_Experimenting, Var_EXPERIMENT) &  
(f_located(Var_EXPERIMENT,Var_LAB)))))))).

fof(axMidLem376, axiom, 
 ( ! [Var_BARN] : 
 (hasType(type_Barn, Var_BARN) => 
(( ? [Var_FARM] : 
 (hasType(type_Farm, Var_FARM) &  
(f_located(Var_BARN,Var_FARM)))))))).

fof(axMidLem377, axiom, 
 ( ! [Var_STAGE] : 
 (hasType(type_PerformanceStage, Var_STAGE) => 
(( ? [Var_AUDITORIUM] : 
 (hasType(type_Auditorium, Var_AUDITORIUM) &  
(f_part(Var_STAGE,Var_AUDITORIUM)))))))).

fof(axMidLem378, axiom, 
 ( ! [Var_W] : 
 (hasType(type_PerformanceStageWing, Var_W) => 
(( ? [Var_S] : 
 (hasType(type_PerformanceStage, Var_S) &  
(f_part(Var_W,Var_S)))))))).

fof(axMidLem379, axiom, 
 ( ! [Var_BROADCAST] : 
 (hasType(type_Broadcasting, Var_BROADCAST) => 
(( ? [Var_DEVICE] : 
 (hasType(type_CommunicationDevice, Var_DEVICE) &  
(f_instrument(Var_BROADCAST,Var_DEVICE)))))))).

fof(axMidLem380, axiom, 
 ( ! [Var_C] : 
 (hasType(type_PeriodicalPublisher, Var_C) => 
(( ? [Var_PUBLISH] : 
 (hasType(type_Publication, Var_PUBLISH) &  
(( ? [Var_PERIODICAL] : 
 (hasType(type_Periodical, Var_PERIODICAL) &  
(((f_agent(Var_PUBLISH,Var_C)) & (f_patient(Var_PUBLISH,Var_PERIODICAL))))))))))))).

fof(axMidLem381, axiom, 
 ( ! [Var_EXPLOSION] : 
 (hasType(type_Explosion, Var_EXPLOSION) => 
(( ? [Var_PROC] : 
 (hasType(type_ChemicalProcess, Var_PROC) &  
(f_causes(Var_PROC,Var_EXPLOSION)))))))).

fof(axMidLem382, axiom, 
 ( ! [Var_PERFORMANCE] : 
 (hasType(type_Performance, Var_PERFORMANCE) => 
(( ? [Var_SUB] : 
 ((hasType(type_DramaticActing, Var_SUB) | hasType(type_Music, Var_SUB)) &  
(f_subProcess(Var_SUB,Var_PERFORMANCE)))))))).

fof(axMidLem383, axiom, 
 ( ! [Var_PERFORMANCE] : 
 (hasType(type_Performance, Var_PERFORMANCE) => 
(( ? [Var_STAGE] : 
 (hasType(type_PerformanceStage, Var_STAGE) &  
(f_located(Var_PERFORMANCE,Var_STAGE)))))))).

fof(axMidLem384, axiom, 
 ( ! [Var_R] : 
 (hasType(type_Reciting, Var_R) => 
(( ? [Var_T] : 
 (hasType(type_Text, Var_T) &  
(( ? [Var_P] : 
 (hasType(type_Proposition, Var_P) &  
(((f_realization(Var_R,Var_P)) & (f_containsInformation(Var_T,Var_P))))))))))))).

fof(axMidLem385, axiom, 
 ( ! [Var_SERMON] : 
 (hasType(type_Sermon, Var_SERMON) => 
(( ? [Var_SERVICE] : 
 (hasType(type_ReligiousService, Var_SERVICE) &  
(f_subProcess(Var_SERMON,Var_SERVICE)))))))).

fof(axMidLem386, axiom, 
 ( ! [Var_CAST] : 
 (hasType(type_DramaticCast, Var_CAST) => 
(( ? [Var_TEXT] : 
 (hasType(type_FictionalText, Var_TEXT) &  
(( ? [Var_PROC] : 
 (hasType(type_Process, Var_PROC) &  
(( ? [Var_PROP] : 
 (hasType(type_Proposition, Var_PROP) &  
(((f_containsInformation(Var_TEXT,Var_PROP)) & (((f_realization(Var_PROC,Var_PROP)) & (( ! [Var_MEMBER] : 
 ((hasType(type_SelfConnectedObject, Var_MEMBER) & hasType(type_Agent, Var_MEMBER)) => 
(((f_member(Var_MEMBER,Var_CAST)) => (( ? [Var_SUB] : 
 (hasType(type_DramaticActing, Var_SUB) &  
(((f_agent(Var_SUB,Var_MEMBER)) & (f_subProcess(Var_SUB,Var_PROC)))))))))))))))))))))))))))).

fof(axMidLem387, axiom, 
 ( ! [Var_MEETING] : 
 (hasType(type_FormalMeeting, Var_MEETING) => 
(( ? [Var_PLANNING] : 
 (hasType(type_Planning, Var_PLANNING) &  
(((f_result(Var_PLANNING,Var_MEETING)) & (f_earlier(f_WhenFn(Var_PLANNING),f_WhenFn(Var_MEETING))))))))))).

fof(axMidLem388, axiom, 
 ( ! [Var_F] : 
 (hasType(type_Funeral, Var_F) => 
(( ? [Var_D] : 
 (hasType(type_Death, Var_D) &  
(f_refers(Var_F,Var_D)))))))).

fof(axMidLem389, axiom, 
 ( ! [Var_RESOLUTION] : 
 (hasType(type_Resolution, Var_RESOLUTION) => 
(( ? [Var_AGENT] : 
 (hasType(type_Organization, Var_AGENT) &  
(( ? [Var_MEETING] : 
 (hasType(type_FormalMeeting, Var_MEETING) &  
(((f_agent(Var_RESOLUTION,Var_AGENT)) & (f_subProcess(Var_RESOLUTION,Var_MEETING))))))))))))).

fof(axMidLem390, axiom, 
 ( ! [Var_SMOKING] : 
 (hasType(type_Smoking, Var_SMOKING) => 
(( ? [Var_BURN] : 
 (hasType(type_Combustion, Var_BURN) &  
(( ? [Var_CIGAR] : 
 (hasType(type_CigarOrCigarette, Var_CIGAR) &  
(( ? [Var_BREATHE] : 
 (hasType(type_Breathing, Var_BREATHE) &  
(( ? [Var_SMOKE] : 
 (hasType(type_Entity, Var_SMOKE) &  
(((f_subProcess(Var_BURN,Var_SMOKING)) & (((f_resourceS(Var_BURN,Var_CIGAR)) & (((f_result(Var_BURN,Var_SMOKE)) & (((f_patient(Var_BREATHE,Var_SMOKE)) & (f_subProcess(Var_BREATHE,Var_SMOKING))))))))))))))))))))))))).

fof(axMidLem391, axiom, 
 ( ! [Var_CHARGE] : 
 (hasType(type_LegalCharge, Var_CHARGE) => 
(( ? [Var_GOV] : 
 (hasType(type_Government, Var_GOV) &  
(f_agent(Var_CHARGE,Var_GOV)))))))).

fof(axMidLem392, axiom, 
 ( ! [Var_P] : 
 (hasType(type_Pleading, Var_P) => 
(( ? [Var_J] : 
 (hasType(type_JudicialProcess, Var_J) &  
(f_subProcess(Var_P,Var_J)))))))).

fof(axMidLem393, axiom, 
 ( ! [Var_P] : 
 (hasType(type_Pleading, Var_P) => 
(( ? [Var_C] : 
 (hasType(type_CriminalAction, Var_C) &  
(f_refers(Var_P,Var_C)))))))).

fof(axMidLem394, axiom, 
 ( ! [Var_TESTIFY] : 
 (hasType(type_Testifying, Var_TESTIFY) => 
(( ? [Var_PROC] : 
 (hasType(type_JudicialProcess, Var_PROC) &  
(f_subProcess(Var_TESTIFY,Var_PROC)))))))).

fof(axMidLem395, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_JudicialProcess, Var_PROCESS) => 
(( ? [Var_ROOM] : 
 (hasType(type_CourtRoom, Var_ROOM) &  
(f_located(Var_PROCESS,Var_ROOM)))))))).

fof(axMidLem396, axiom, 
 ( ! [Var_OPINION] : 
 (hasType(type_LegalOpinion, Var_OPINION) => 
(( ? [Var_DECISION] : 
 (hasType(type_LegalDecision, Var_DECISION) &  
(( ? [Var_PROPOSITION] : 
 ((hasType(type_Proposition, Var_PROPOSITION) & hasType(type_Argument, Var_PROPOSITION)) &  
(( ? [Var_TEXT] : 
 ((hasType(type_Entity, Var_TEXT) & hasType(type_ContentBearingPhysical, Var_TEXT)) &  
(((f_result(Var_DECISION,Var_TEXT)) & (((f_containsInformation(Var_TEXT,Var_PROPOSITION)) & (f_conclusion(Var_PROPOSITION,Var_OPINION)))))))))))))))))).

fof(axMidLem397, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Sentencing, Var_S) => 
(( ! [Var_P] : 
 (hasType(type_Entity, Var_P) => 
(((f_patient(Var_S,Var_P)) => (( ? [Var_C] : 
 (hasType(type_LegalConviction, Var_C) &  
(((f_causes(Var_C,Var_S)) & (((f_patient(Var_C,Var_P)) & (f_earlier(f_WhenFn(Var_C),f_WhenFn(Var_S)))))))))))))))))).

fof(axMidLem398, axiom, 
 ( ! [Var_CALL] : 
 (hasType(type_GameCall, Var_CALL) => 
(( ? [Var_GAME] : 
 (hasType(type_Game, Var_GAME) &  
(f_refers(Var_CALL,Var_GAME)))))))).

fof(axMidLem399, axiom, 
 ( ! [Var_OP] : 
 (hasType(type_BeginningOperations, Var_OP) => 
(( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(((f_agent(Var_OP,Var_ORG)) => (f_starts(Var_OP,f_WhenFn(Var_ORG))))))))))).

fof(axMidLem400, axiom, 
 ( ! [Var_OP] : 
 (hasType(type_CeasingOperations, Var_OP) => 
(( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(((f_agent(Var_OP,Var_ORG)) => (f_finishes(Var_OP,f_WhenFn(Var_ORG))))))))))).

fof(axMidLem401, axiom, 
 ( ! [Var_B] : 
 (hasType(type_BecomingDrunk, Var_B) => 
(( ! [Var_A] : 
 ((hasType(type_Entity, Var_A) & hasType(type_Object, Var_A)) => 
(((f_experiencer(Var_B,Var_A)) => (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_B)),attribute(Var_A,inst_Sober))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_B)),attribute(Var_A,inst_Drunk))))))))))))).

fof(axMidLem402, axiom, 
 ( ! [Var_B] : 
 (hasType(type_SoberingUp, Var_B) => 
(( ! [Var_A] : 
 ((hasType(type_Entity, Var_A) & hasType(type_Object, Var_A)) => 
(((f_experiencer(Var_B,Var_A)) => (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_B)),attribute(Var_A,inst_Drunk))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_B)),attribute(Var_A,inst_Sober))))))))))))).

fof(axMidLem403, axiom, 
 ( ! [Var_FALL] : 
 (hasType(type_FallingAsleep, Var_FALL) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Entity, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((f_experiencer(Var_FALL,Var_AGENT)) => (( ? [Var_FINISH] : 
 ((hasType(type_TimeInterval, Var_FINISH) & hasType(type_TimePosition, Var_FINISH)) &  
(( ? [Var_START] : 
 ((hasType(type_TimeInterval, Var_START) & hasType(type_TimePosition, Var_START)) &  
(((f_starts(Var_START,f_WhenFn(Var_FALL))) & (((f_finishes(Var_FINISH,f_WhenFn(Var_FALL))) & (((f_holdsDuring(Var_START,attribute(Var_AGENT,inst_Awake))) & (f_holdsDuring(Var_FINISH,attribute(Var_AGENT,inst_Asleep))))))))))))))))))))))).

fof(axMidLem404, axiom, 
 ( ! [Var_WAKE] : 
 (hasType(type_WakingUp, Var_WAKE) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Entity, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((f_experiencer(Var_WAKE,Var_AGENT)) => (( ? [Var_FINISH] : 
 ((hasType(type_TimeInterval, Var_FINISH) & hasType(type_TimePosition, Var_FINISH)) &  
(( ? [Var_START] : 
 ((hasType(type_TimeInterval, Var_START) & hasType(type_TimePosition, Var_START)) &  
(((f_starts(Var_START,f_WhenFn(Var_WAKE))) & (((f_finishes(Var_FINISH,f_WhenFn(Var_WAKE))) & (((f_holdsDuring(Var_START,attribute(Var_AGENT,inst_Asleep))) & (f_holdsDuring(Var_FINISH,attribute(Var_AGENT,inst_Awake))))))))))))))))))))))).

fof(axMidLem405, axiom, 
 ( ! [Var_G] : 
 (hasType(type_GainingConsciousness, Var_G) => 
(( ! [Var_A] : 
 ((hasType(type_Entity, Var_A) & hasType(type_Object, Var_A)) => 
(((f_experiencer(Var_G,Var_A)) => (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_G)),attribute(Var_A,inst_Unconscious))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_G)),attribute(Var_A,inst_Awake))))))))))))).

fof(axMidLem406, axiom, 
 ( ! [Var_L] : 
 (hasType(type_LosingConsciousness, Var_L) => 
(( ! [Var_A] : 
 ((hasType(type_Entity, Var_A) & hasType(type_Object, Var_A)) => 
(((f_experiencer(Var_L,Var_A)) => (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_L)),attribute(Var_A,inst_Awake))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_L)),attribute(Var_A,inst_Unconscious))))))))))))).

fof(axMidLem407, axiom, 
 ( ! [Var_DEGREE] : 
 (hasType(type_AcademicDegree, Var_DEGREE) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Entity, Var_AGENT)) => 
(((f_possesses(Var_AGENT,Var_DEGREE)) => (( ? [Var_PROGRAM] : 
 (hasType(type_EducationalProgram, Var_PROGRAM) &  
(( ? [Var_STUDY] : 
 (hasType(type_Process, Var_STUDY) &  
(((f_realization(Var_STUDY,Var_PROGRAM)) & (f_experiencer(Var_STUDY,Var_AGENT)))))))))))))))))).

fof(axMidLem408, axiom, 
 ( ! [Var_L] : 
 (hasType(type_License, Var_L) => 
(( ? [Var_ORG] : 
 (hasType(type_GovernmentOrganization, Var_ORG) &  
(f_issuedBy(Var_L,Var_ORG)))))))).

fof(axMidLem409, axiom, 
 ( ! [Var_P] : 
 (hasType(type_PassCertificate, Var_P) => 
(( ! [Var_A] : 
 ((hasType(type_Agent, Var_A) & hasType(type_Physical, Var_A)) => 
(((f_possesses(Var_A,Var_P)) => (( ? [Var_L] : 
 (hasType(type_Object, Var_L) &  
(f_confersNorm(Var_P,located(Var_A,Var_L),inst_Permission))))))))))))).

fof(axMidLem410, axiom, 
 ( ! [Var_T] : 
 (hasType(type_Testament, Var_T) => 
(( ? [Var_B] : 
 (hasType(type_Bequeathing, Var_B) &  
(f_refers(Var_T,Var_B)))))))).

fof(axMidLem411, axiom, 
 ( ! [Var_PROGRAM] : 
 (hasType(type_EducationalProgram, Var_PROGRAM) => 
(( ? [Var_COURSE1] : 
 (hasType(type_EducationalCourse, Var_COURSE1) &  
(( ? [Var_COURSE2] : 
 (hasType(type_EducationalCourse, Var_COURSE2) &  
(((Var_COURSE1 != Var_COURSE2) & (((f_subPlan(Var_COURSE1,Var_PROGRAM)) & (f_subPlan(Var_COURSE2,Var_PROGRAM))))))))))))))).

fof(axMidLem412, axiom, 
 ( ! [Var_COURSE] : 
 (hasType(type_EducationalCourse, Var_COURSE) => 
(( ? [Var_CLASS] : 
 (hasType(type_EducationalProcess, Var_CLASS) &  
(( ? [Var_ORG] : 
 (hasType(type_EducationalOrganization, Var_ORG) &  
(((f_realization(Var_CLASS,Var_COURSE)) & (f_located(Var_CLASS,Var_ORG))))))))))))).

fof(axMidLem413, axiom, 
 ( ! [Var_ENTER] : 
 (hasType(type_Matriculation, Var_ENTER) => 
(( ! [Var_COLLEGE] : 
 (hasType(type_College, Var_COLLEGE) => 
(( ! [Var_STUDENT] : 
 (hasType(type_Entity, Var_STUDENT) => 
(((((f_agent(Var_ENTER,Var_COLLEGE)) & (f_patient(Var_ENTER,Var_STUDENT)))) => (( ? [Var_GRAD] : 
 (hasType(type_Graduation, Var_GRAD) &  
(( ? [Var_SCHOOL] : 
 (hasType(type_HighSchool, Var_SCHOOL) &  
(((f_agent(Var_GRAD,Var_SCHOOL)) & (((f_patient(Var_GRAD,Var_STUDENT)) & (f_earlier(f_WhenFn(Var_GRAD),f_WhenFn(Var_ENTER)))))))))))))))))))))))).

fof(axMidLem414, axiom, 
 ( ! [Var_E] : 
 (hasType(type_Matriculation, Var_E) => 
(( ! [Var_C] : 
 (hasType(type_College, Var_C) => 
(( ! [Var_P] : 
 (hasType(type_Entity, Var_P) => 
(((((f_agent(Var_E,Var_C)) & (f_patient(Var_E,Var_P)))) => (( ? [Var_G] : 
 (hasType(type_Graduation, Var_G) &  
(( ? [Var_S] : 
 (hasType(type_SecondarySchool, Var_S) &  
(((f_agent(Var_G,Var_S)) & (((f_patient(Var_G,Var_P)) & (f_earlier(f_WhenFn(Var_G),f_WhenFn(Var_E)))))))))))))))))))))))).

fof(axMidLem415, axiom, 
 ( ! [Var_S] : 
 (hasType(type_GraduateSchool, Var_S) => 
(( ? [Var_U] : 
 (hasType(type_University, Var_U) &  
(f_part(Var_S,Var_U)))))))).

fof(axMidLem416, axiom, 
 ( ! [Var_AS] : 
 (hasType(type_ArtSchool, Var_AS) => 
(( ! [Var_P] : 
 (hasType(type_EducationalProcess, Var_P) => 
(((f_located(Var_P,Var_AS)) => (( ? [Var_M] : 
 (hasType(type_Making, Var_M) &  
(( ? [Var_ART] : 
 (hasType(type_ArtWork, Var_ART) &  
(((f_patient(Var_M,Var_ART)) & (f_refers(Var_P,Var_M)))))))))))))))))).

fof(axMidLem417, axiom, 
 ( ! [Var_DS] : 
 (hasType(type_DaySchool, Var_DS) => 
(( ~ ( ? [Var_S] : 
 ((hasType(type_CognitiveAgent, Var_S) & hasType(type_Human, Var_S)) &  
(((f_student(Var_DS,Var_S)) & (f_home(Var_S,Var_DS))))))))))).

fof(axMidLem418, axiom, 
 ( ! [Var_AGENT] : 
 ((hasType(type_CognitiveAgent, Var_AGENT) & hasType(type_Entity, Var_AGENT)) => 
(( ! [Var_ORG] : 
 ((hasType(type_EducationalOrganization, Var_ORG) & hasType(type_Object, Var_ORG)) => 
(((f_student(Var_ORG,Var_AGENT)) => (( ? [Var_PROCESS] : 
 (hasType(type_EducationalProcess, Var_PROCESS) &  
(((f_located(Var_PROCESS,Var_ORG)) & (f_destination(Var_PROCESS,Var_AGENT))))))))))))))).

fof(axMidLem419, axiom, 
 ( ! [Var_AGENT] : 
 ((hasType(type_CognitiveAgent, Var_AGENT) & hasType(type_Agent, Var_AGENT)) => 
(( ! [Var_ORG] : 
 ((hasType(type_EducationalOrganization, Var_ORG) & hasType(type_Object, Var_ORG)) => 
(((f_teacher(Var_ORG,Var_AGENT)) => (( ? [Var_PROCESS] : 
 (hasType(type_EducationalProcess, Var_PROCESS) &  
(((f_located(Var_PROCESS,Var_ORG)) & (f_agent(Var_PROCESS,Var_AGENT))))))))))))))).

fof(axMidLem420, axiom, 
 ( ! [Var_TEL] : 
 (hasType(type_Telephoning, Var_TEL) => 
(( ? [Var_DEVICE] : 
 (hasType(type_Telephone, Var_DEVICE) &  
(f_instrument(Var_TEL,Var_DEVICE)))))))).

fof(axMidLem421, axiom, 
 ( ! [Var_STRIKE] : 
 (hasType(type_LaborStriking, Var_STRIKE) => 
(( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(((((f_agent(Var_STRIKE,Var_PERSON)) & (f_patient(Var_STRIKE,Var_ORG)))) => (f_employs(Var_ORG,Var_PERSON))))))))))))).

fof(axMidLem422, axiom, 
 ( ! [Var_R] : 
 (hasType(type_Resigning, Var_R) => 
(( ! [Var_A] : 
 ((hasType(type_Agent, Var_A) & hasType(type_CognitiveAgent, Var_A)) => 
(((f_agent(Var_R,Var_A)) => (f_wants(Var_A,Var_R)))))))))).

fof(axMidLem423, axiom, 
 ( ! [Var_T] : 
 (hasType(type_TransferringPosition, Var_T) => 
(( ! [Var_H] : 
 ((hasType(type_Entity, Var_H) & hasType(type_Human, Var_H)) => 
(((f_experiencer(Var_T,Var_H)) => (( ? [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) &  
(( ? [Var_P2] : 
 ((hasType(type_Position, Var_P2) & hasType(type_Entity, Var_P2)) &  
(( ? [Var_P1] : 
 ((hasType(type_Position, Var_P1) & hasType(type_Entity, Var_P1)) &  
(((f_holdsDuring(f_BeginFn(f_WhenFn(Var_T)),occupiesPosition(Var_H,Var_P1,Var_ORG))) & (((f_holdsDuring(f_EndFn(f_WhenFn(Var_T)),occupiesPosition(Var_H,Var_P2,Var_ORG))) & (Var_P1 != Var_P2)))))))))))))))))))))).

fof(axMidLem424, axiom, 
 ( ! [Var_MONEY] : 
 (hasType(type_CurrencyMeasure, Var_MONEY) => 
(( ! [Var_TIME] : 
 (hasType(type_TimeDuration, Var_TIME) => 
(( ! [Var_PERSON] : 
 ((hasType(type_Human, Var_PERSON) & hasType(type_CognitiveAgent, Var_PERSON)) => 
(( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(((f_monetaryWage(Var_ORG,Var_PERSON,Var_TIME,Var_MONEY)) => (f_employs(Var_ORG,Var_PERSON)))))))))))))))).

fof(axMidLem425, axiom, 
 ( ! [Var_SHOT] : 
 (hasType(type_GameShot, Var_SHOT) => 
(( ? [Var_PIECE] : 
 (hasType(type_GamePiece, Var_PIECE) &  
(f_patient(Var_SHOT,Var_PIECE)))))))).

fof(axMidLem426, axiom, 
 ( ! [Var_SHOT] : 
 (hasType(type_GameShot, Var_SHOT) => 
(( ? [Var_GAME] : 
 (hasType(type_Game, Var_GAME) &  
(f_subProcess(Var_SHOT,Var_GAME)))))))).

fof(axMidLem427, axiom, 
 ( ! [Var_GOAL] : 
 (hasType(type_GameGoal, Var_GOAL) => 
(( ! [Var_GAME] : 
 (hasType(type_Game, Var_GAME) => 
(( ! [Var_SCORE] : 
 (hasType(type_Score, Var_SCORE) => 
(((((f_instrument(Var_GAME,Var_GOAL)) & (f_subProcess(Var_SCORE,Var_GAME)))) => (( ? [Var_PIECE] : 
 (hasType(type_GamePiece, Var_PIECE) &  
(( ? [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) &  
(((f_patient(Var_SCORE,Var_PIECE)) & (((f_temporalPart(Var_TIME,f_WhenFn(Var_SCORE))) & (f_holdsDuring(Var_TIME,located(Var_PIECE,Var_GOAL)))))))))))))))))))))))).

fof(axMidLem428, axiom, 
 ( ! [Var_SS] : 
 (hasType(type_SportServe, Var_SS) => 
(( ? [Var_S] : 
 (hasType(type_Sport, Var_S) &  
(((f_subProcess(Var_SS,Var_S)) & (f_starts(f_WhenFn(Var_SS),f_WhenFn(Var_S))))))))))).

fof(axMidLem429, axiom, 
 ( ! [Var_THROW] : 
 (hasType(type_Throwing, Var_THROW) => 
(( ? [Var_ARM] : 
 (hasType(type_Arm, Var_ARM) &  
(f_instrument(Var_THROW,Var_ARM)))))))).

fof(axMidLem430, axiom, 
 ( ! [Var_CATCH] : 
 (hasType(type_Catching, Var_CATCH) => 
(( ! [Var_BALL] : 
 ((hasType(type_Entity, Var_BALL) & hasType(type_Object, Var_BALL)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Animal, Var_AGENT)) => 
(((((f_agent(Var_CATCH,Var_AGENT)) & (f_patient(Var_CATCH,Var_BALL)))) => (f_holdsDuring(f_EndFn(f_WhenFn(Var_CATCH)),grasps(Var_AGENT,Var_BALL)))))))))))))).

fof(axMidLem431, axiom, 
 ( ! [Var_C] : 
 (hasType(type_PlayingCard, Var_C) => 
(f_material(type_Paper,Var_C))))).

fof(axMidLem432, axiom, 
 ( ! [Var_ACCELERATE] : 
 (hasType(type_Accelerating, Var_ACCELERATE) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((f_agent(Var_ACCELERATE,Var_AGENT)) => (( ? [Var_TIME2] : 
 ((hasType(type_TimeDuration, Var_TIME2) & hasType(type_Quantity, Var_TIME2)) &  
(( ? [Var_TIME1] : 
 ((hasType(type_TimeDuration, Var_TIME1) & hasType(type_Quantity, Var_TIME1)) &  
(( ? [Var_LENGTH2] : 
 ((hasType(type_LengthMeasure, Var_LENGTH2) & hasType(type_Quantity, Var_LENGTH2)) &  
(( ? [Var_LENGTH1] : 
 ((hasType(type_LengthMeasure, Var_LENGTH1) & hasType(type_Quantity, Var_LENGTH1)) &  
(((f_holdsDuring(f_BeginFn(f_WhenFn(Var_ACCELERATE)),measure(Var_AGENT,f_SpeedFn(Var_LENGTH1,Var_TIME1)))) & (((f_holdsDuring(f_EndFn(f_WhenFn(Var_ACCELERATE)),measure(Var_AGENT,f_SpeedFn(Var_LENGTH2,Var_TIME2)))) & (((f_greaterThan(Var_LENGTH2,Var_LENGTH1)) | (f_greaterThan(Var_TIME2,Var_TIME1)))))))))))))))))))))))))))).

fof(axMidLem433, axiom, 
 ( ! [Var_D] : 
 (hasType(type_Decelerating, Var_D) => 
(( ! [Var_A] : 
 ((hasType(type_Agent, Var_A) & hasType(type_Object, Var_A)) => 
(((f_agent(Var_D,Var_A)) => (( ? [Var_T2] : 
 ((hasType(type_TimeDuration, Var_T2) & hasType(type_Quantity, Var_T2)) &  
(( ? [Var_T1] : 
 ((hasType(type_TimeDuration, Var_T1) & hasType(type_Quantity, Var_T1)) &  
(( ? [Var_L2] : 
 ((hasType(type_LengthMeasure, Var_L2) & hasType(type_Quantity, Var_L2)) &  
(( ? [Var_L1] : 
 ((hasType(type_LengthMeasure, Var_L1) & hasType(type_Quantity, Var_L1)) &  
(((f_holdsDuring(f_BeginFn(f_WhenFn(Var_D)),measure(Var_A,f_SpeedFn(Var_L1,Var_T1)))) & (((f_holdsDuring(f_EndFn(f_WhenFn(Var_D)),measure(Var_A,f_SpeedFn(Var_L2,Var_T2)))) & (((f_greaterThan(Var_L1,Var_L2)) | (f_greaterThan(Var_T1,Var_T2)))))))))))))))))))))))))))).

fof(axMidLem434, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Shortening, Var_S) => 
(( ! [Var_O] : 
 ((hasType(type_Entity, Var_O) & hasType(type_Object, Var_O)) => 
(((f_patient(Var_S,Var_O)) => (( ? [Var_L2] : 
 ((hasType(type_PhysicalQuantity, Var_L2) & hasType(type_Quantity, Var_L2)) &  
(( ? [Var_L1] : 
 ((hasType(type_PhysicalQuantity, Var_L1) & hasType(type_Quantity, Var_L1)) &  
(((f_holdsDuring(f_BeginFn(f_WhenFn(Var_S)),length(Var_O,Var_L1))) & (((f_holdsDuring(f_EndFn(f_WhenFn(Var_S)),length(Var_O,Var_L2))) & (f_greaterThan(Var_L1,Var_L2)))))))))))))))))))).

fof(axMidLem435, axiom, 
 ( ! [Var_FLY] : 
 (hasType(type_Flying, Var_FLY) => 
(( ? [Var_REGION] : 
 (hasType(type_AtmosphericRegion, Var_REGION) &  
(f_located(Var_FLY,Var_REGION)))))))).

fof(axMidLem436, axiom, 
 ( ! [Var_RETURN] : 
 (hasType(type_Returning, Var_RETURN) => 
(( ! [Var_DEST] : 
 ((hasType(type_Entity, Var_DEST) & hasType(type_Object, Var_DEST)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Entity, Var_AGENT) & hasType(type_Physical, Var_AGENT)) => 
(((((f_experiencer(Var_RETURN,Var_AGENT)) & (f_destination(Var_RETURN,Var_DEST)))) => (( ? [Var_TIME] : 
 ((hasType(type_TimeInterval, Var_TIME) & hasType(type_TimePosition, Var_TIME)) &  
(((f_earlier(Var_TIME,f_WhenFn(Var_RETURN))) & (f_holdsDuring(Var_TIME,located(Var_AGENT,Var_DEST))))))))))))))))))).

fof(axMidLem437, axiom, 
 ( ! [Var_ESCAPE] : 
 (hasType(type_Escaping, Var_ESCAPE) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Entity, Var_AGENT)) => 
(((f_agent(Var_ESCAPE,Var_AGENT)) => (( ? [Var_CONFINE] : 
 (hasType(type_Confining, Var_CONFINE) &  
(((f_patient(Var_CONFINE,Var_AGENT)) & (f_meetsTemporally(f_WhenFn(Var_CONFINE),f_WhenFn(Var_ESCAPE)))))))))))))))).

fof(axMidLem438, axiom, 
 ( ! [Var_ESCAPE] : 
 (hasType(type_Escaping, Var_ESCAPE) => 
(( ! [Var_AGENT] : 
 (hasType(type_CognitiveAgent, Var_AGENT) => 
(( ~ (f_holdsRight(agent(Var_ESCAPE,Var_AGENT),Var_AGENT)))))))))).

fof(axMidLem439, axiom, 
 ( ! [Var_LEAVE] : 
 (hasType(type_Leaving, Var_LEAVE) => 
(( ? [Var_GO] : 
 (hasType(type_Translocation, Var_GO) &  
(((f_subProcess(Var_LEAVE,Var_GO)) & (f_starts(f_WhenFn(Var_LEAVE),f_WhenFn(Var_GO))))))))))).

fof(axMidLem440, axiom, 
 ( ! [Var_ARRIVE] : 
 (hasType(type_Arriving, Var_ARRIVE) => 
(( ? [Var_GO] : 
 (hasType(type_Translocation, Var_GO) &  
(((f_subProcess(Var_ARRIVE,Var_GO)) & (f_finishes(f_WhenFn(Var_ARRIVE),f_WhenFn(Var_GO))))))))))).

fof(axMidLem441, axiom, 
 ( ! [Var_I] : 
 (hasType(type_Immigrating, Var_I) => 
(( ! [Var_A] : 
 ((hasType(type_Agent, Var_A) & hasType(type_SelfConnectedObject, Var_A) & hasType(type_Organism, Var_A)) => 
(((f_agent(Var_I,Var_A)) => (( ? [Var_N1] : 
 (hasType(type_Nation, Var_N1) &  
(( ? [Var_N2] : 
 (hasType(type_Nation, Var_N2) &  
(((f_origin(Var_I,Var_N1)) & (((f_destination(Var_I,Var_N2)) & (((Var_N1 != Var_N2) & (((f_member(Var_A,f_CitizenryFn(Var_N1))) & (((( ~ (f_member(Var_A,f_CitizenryFn(Var_N2))))) & (f_hasPurpose(Var_I,inhabits(Var_A,Var_N2))))))))))))))))))))))))))).

fof(axMidLem442, axiom, 
 ( ! [Var_V] : 
 ((hasType(type_Vehicle, Var_V) & hasType(type_SelfConnectedObject, Var_V)) => 
(( ! [Var_O] : 
 ((hasType(type_SelfConnectedObject, Var_O) & hasType(type_Object, Var_O)) => 
(((f_onboard(Var_O,Var_V)) => (f_contains(Var_V,Var_O)))))))))).

fof(axMidLem443, axiom, 
 ( ! [Var_T] : 
 (hasType(type_Transportation, Var_T) => 
(( ! [Var_V] : 
 ((hasType(type_Vehicle, Var_V) & hasType(type_Object, Var_V)) => 
(( ! [Var_O] : 
 ((hasType(type_SelfConnectedObject, Var_O) & hasType(type_Entity, Var_O)) => 
(((((f_onboard(Var_O,Var_V)) & (f_instrument(Var_T,Var_V)))) => (f_patient(Var_T,Var_O))))))))))))).

fof(axMidLem444, axiom, 
 ( ! [Var_R] : 
 (hasType(type_Rotating, Var_R) => 
(( ! [Var_A] : 
 ((hasType(type_Entity, Var_A) & hasType(type_Physical, Var_A)) => 
(((f_experiencer(Var_R,Var_A)) => (( ? [Var_L] : 
 (hasType(type_Object, Var_L) &  
(((f_holdsDuring(f_BeginFn(f_WhenFn(Var_R)),located(Var_A,Var_L))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_R)),located(Var_A,Var_L)))))))))))))))).

fof(axMidLem445, axiom, 
 ( ! [Var_CM] : 
 (hasType(type_CentrifugalMotion, Var_CM) => 
(( ? [Var_R] : 
 (hasType(type_Rotating, Var_R) &  
(( ? [Var_O2] : 
 (hasType(type_Entity, Var_O2) &  
(( ? [Var_O1] : 
 ((hasType(type_Object, Var_O1) & hasType(type_Entity, Var_O1)) &  
(( ? [Var_A] : 
 (hasType(type_Object, Var_A) &  
(((f_axis(Var_A,Var_O1)) & (((f_origin(Var_CM,Var_A)) & (((f_experiencer(Var_R,Var_O1)) & (((f_experiencer(Var_CM,Var_O2)) & (f_causes(Var_R,Var_CM))))))))))))))))))))))))).

fof(axMidLem446, axiom, 
 ( ! [Var_CM] : 
 (hasType(type_CentripetalMotion, Var_CM) => 
(( ? [Var_R] : 
 (hasType(type_Rotating, Var_R) &  
(( ? [Var_O2] : 
 (hasType(type_Entity, Var_O2) &  
(( ? [Var_O1] : 
 ((hasType(type_Object, Var_O1) & hasType(type_Entity, Var_O1)) &  
(( ? [Var_A] : 
 ((hasType(type_Object, Var_A) & hasType(type_Entity, Var_A)) &  
(((f_axis(Var_A,Var_O1)) & (((f_destination(Var_CM,Var_A)) & (((f_experiencer(Var_R,Var_O1)) & (((f_experiencer(Var_CM,Var_O2)) & (f_causes(Var_R,Var_CM))))))))))))))))))))))))).

fof(axMidLem447, axiom, 
 ( ! [Var_POUR] : 
 (hasType(type_Pouring, Var_POUR) => 
(( ? [Var_LIQUID] : 
 (hasType(type_Substance, Var_LIQUID) &  
(( ? [Var_CONTAINER1] : 
 (hasType(type_Container, Var_CONTAINER1) &  
(( ? [Var_CONTAINER2] : 
 (hasType(type_Container, Var_CONTAINER2) &  
(((f_origin(Var_POUR,Var_CONTAINER1)) & (((f_destination(Var_POUR,Var_CONTAINER2)) & (((Var_CONTAINER1 != Var_CONTAINER2) & (((f_patient(Var_POUR,Var_LIQUID)) & (f_attribute(Var_LIQUID,inst_Liquid)))))))))))))))))))))).

fof(axMidLem448, axiom, 
 ( ! [Var_WAVE] : 
 (hasType(type_WaterWave, Var_WAVE) => 
(( ? [Var_AREA] : 
 (hasType(type_WaterArea, Var_AREA) &  
(f_located(Var_WAVE,Var_AREA)))))))).

fof(axMidLem449, axiom, 
 ( ! [Var_F] : 
 (hasType(type_Flooding, Var_F) => 
(( ! [Var_P] : 
 ((hasType(type_Object, Var_P) & hasType(type_WaterArea, Var_P)) => 
(((f_located(Var_F,Var_P)) => (( ? [Var_L2] : 
 ((hasType(type_LengthMeasure, Var_L2) & hasType(type_Quantity, Var_L2)) &  
(( ? [Var_L1] : 
 ((hasType(type_LengthMeasure, Var_L1) & hasType(type_Quantity, Var_L1)) &  
(((f_holdsDuring(f_BeginFn(f_WhenFn(Var_F)),waterDepth(Var_P,Var_L1))) & (((f_holdsDuring(f_EndFn(f_WhenFn(Var_F)),waterDepth(Var_P,Var_L2))) & (f_greaterThan(Var_L2,Var_L1)))))))))))))))))))).

fof(axMidLem450, axiom, 
 ( ! [Var_TT] : 
 (hasType(type_TractorTrailer, Var_TT) => 
(( ? [Var_TRAC] : 
 (hasType(type_TruckTractor, Var_TRAC) &  
(( ? [Var_TRAIL] : 
 (hasType(type_TruckTrailer, Var_TRAIL) &  
(((f_part(Var_TRAC,Var_TT)) & (((f_part(Var_TRAIL,Var_TT)) & (f_connected(Var_TRAC,Var_TRAIL))))))))))))))).

fof(axMidLem451, axiom, 
 ( ! [Var_TRANSPORT] : 
 (hasType(type_AirTransportation, Var_TRANSPORT) => 
(( ? [Var_CRAFT] : 
 (hasType(type_Aircraft, Var_CRAFT) &  
(( ? [Var_REGION] : 
 (hasType(type_AtmosphericRegion, Var_REGION) &  
(((f_instrument(Var_TRANSPORT,Var_CRAFT)) & (f_located(Var_TRANSPORT,Var_REGION))))))))))))).

fof(axMidLem452, axiom, 
 ( ! [Var_D] : 
 (hasType(type_ExplosiveDevice, Var_D) => 
(( ? [Var_S] : 
 (hasType(type_ExplosiveSubstance, Var_S) &  
(f_part(Var_S,Var_D)))))))).

fof(axMidLem453, axiom, 
 ( ! [Var_LAND] : 
 (hasType(type_LandTransportation, Var_LAND) => 
(( ? [Var_CRAFT] : 
 (hasType(type_LandVehicle, Var_CRAFT) &  
(( ? [Var_AREA] : 
 (hasType(type_LandArea, Var_AREA) &  
(((f_instrument(Var_LAND,Var_CRAFT)) & (f_located(Var_CRAFT,Var_AREA))))))))))))).

fof(axMidLem454, axiom, 
 ( ! [Var_A] : 
 (hasType(type_Automobile, Var_A) => 
(f_equipmentCount(Var_A,type_VehicleWheel,4))))).

fof(axMidLem455, axiom, 
 ( ! [Var_A] : 
 (hasType(type_Automobile, Var_A) => 
(f_equipmentCount(Var_A,type_Axle,2))))).

fof(axMidLem456, axiom, 
 ( ! [Var_M] : 
 (hasType(type_Motorcycle, Var_M) => 
(f_equipmentCount(Var_M,type_VehicleWheel,2))))).

fof(axMidLem457, axiom, 
 ( ! [Var_TRANSPORT] : 
 (hasType(type_WaterTransportation, Var_TRANSPORT) => 
(( ? [Var_CRAFT] : 
 (hasType(type_WaterVehicle, Var_CRAFT) &  
(( ? [Var_AREA] : 
 (hasType(type_WaterArea, Var_AREA) &  
(((f_instrument(Var_TRANSPORT,Var_CRAFT)) & (f_located(Var_TRANSPORT,Var_AREA))))))))))))).

fof(axMidLem458, axiom, 
 ( ! [Var_R] : 
 (hasType(type_Rowing, Var_R) => 
(( ? [Var_O] : 
 (hasType(type_Oar, Var_O) &  
(f_instrument(Var_R,Var_O)))))))).

fof(axMidLem459, axiom, 
 ( ! [Var_D] : 
 (hasType(type_BoatDeck, Var_D) => 
(( ? [Var_B] : 
 (hasType(type_WaterVehicle, Var_B) &  
(f_part(Var_D,Var_B)))))))).

fof(axMidLem460, axiom, 
 ( ! [Var_TRANSPORT] : 
 (hasType(type_SpaceTransportation, Var_TRANSPORT) => 
(( ? [Var_CRAFT] : 
 (hasType(type_Spacecraft, Var_CRAFT) &  
(( ? [Var_REGION] : 
 (hasType(type_SpaceRegion, Var_REGION) &  
(((f_instrument(Var_TRANSPORT,Var_CRAFT)) & (f_located(Var_TRANSPORT,Var_REGION))))))))))))).

fof(axMidLem461, axiom, 
 ( ! [Var_M] : 
 (hasType(type_Missile, Var_M) => 
(( ? [Var_B] : 
 (hasType(type_Bomb, Var_B) &  
(f_part(Var_B,Var_M)))))))).

fof(axMidLem462, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Burying, Var_B) => 
(( ? [Var_C] : 
 (hasType(type_Covering, Var_C) &  
(( ? [Var_S] : 
 (hasType(type_Soil, Var_S) &  
(((f_instrument(Var_C,Var_S)) & (f_subProcess(Var_C,Var_B))))))))))))).

fof(axMidLem463, axiom, 
 ( ! [Var_D] : 
 (hasType(type_Digging, Var_D) => 
(( ? [Var_S] : 
 (hasType(type_Soil, Var_S) &  
(f_patient(Var_D,Var_S)))))))).

fof(axMidLem464, axiom, 
 ( ! [Var_T] : 
 (hasType(type_Tilling, Var_T) => 
(( ? [Var_A] : 
 (hasType(type_Agriculture, Var_A) &  
(f_subProcess(Var_T,Var_A)))))))).

fof(axMidLem465, axiom, 
 ( ! [Var_MOVE] : 
 (hasType(type_MovingResidence, Var_MOVE) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Human, Var_AGENT)) => 
(((f_agent(Var_MOVE,Var_AGENT)) => (( ? [Var_HOME2] : 
 ((hasType(type_PermanentResidence, Var_HOME2) & hasType(type_Entity, Var_HOME2)) &  
(( ? [Var_HOME1] : 
 ((hasType(type_PermanentResidence, Var_HOME1) & hasType(type_Entity, Var_HOME1)) &  
(((f_holdsDuring(f_BeginFn(f_WhenFn(Var_MOVE)),home(Var_AGENT,Var_HOME1))) & (((f_holdsDuring(f_EndFn(f_WhenFn(Var_MOVE)),home(Var_AGENT,Var_HOME2))) & (Var_HOME1 != Var_HOME2))))))))))))))))))).

fof(axMidLem466, axiom, 
 ( ! [Var_H] : 
 (hasType(type_Harvesting, Var_H) => 
(( ? [Var_A] : 
 (hasType(type_Agriculture, Var_A) &  
(f_subProcess(Var_H,Var_A)))))))).

fof(axMidLem467, axiom, 
 ( ! [Var_DREAM] : 
 (hasType(type_Dreaming, Var_DREAM) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Entity, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((f_experiencer(Var_DREAM,Var_AGENT)) => (f_holdsDuring(f_WhenFn(Var_DREAM),attribute(Var_AGENT,inst_Asleep))))))))))).

fof(axMidLem468, axiom, 
 ( ! [Var_E] : 
 (hasType(type_Execution, Var_E) => 
(( ? [Var_G] : 
 (hasType(type_Government, Var_G) &  
(f_agent(Var_E,Var_G)))))))).

fof(axMidLem469, axiom, 
 ( ! [Var_E] : 
 (hasType(type_Execution, Var_E) => 
(( ? [Var_P] : 
 (hasType(type_Human, Var_P) &  
(f_patient(Var_E,Var_P)))))))).

fof(axMidLem470, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Suicide, Var_S) => 
(( ? [Var_A] : 
 ((hasType(type_Agent, Var_A) & hasType(type_Entity, Var_A)) &  
(((f_agent(Var_S,Var_A)) & (f_experiencer(Var_S,Var_A)))))))))).

fof(axMidLem471, axiom, 
 ( ! [Var_T] : 
 (hasType(type_Trespassing, Var_T) => 
(( ! [Var_P] : 
 ((hasType(type_Entity, Var_P) & hasType(type_Object, Var_P)) => 
(( ! [Var_H] : 
 ((hasType(type_Agent, Var_H) & hasType(type_Physical, Var_H)) => 
(((((f_agent(Var_T,Var_H)) & (f_patient(Var_T,Var_P)))) => (((( ~ (f_possesses(Var_H,Var_P)))) & (f_modalAttribute(located(Var_H,Var_P),inst_Illegal))))))))))))))).

fof(axMidLem472, axiom, 
 ( ! [Var_MURDER] : 
 (hasType(type_Murder, Var_MURDER) => 
(( ? [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) &  
(f_patient(Var_MURDER,Var_PERSON)))))))).

fof(axMidLem473, axiom, 
 ( ! [Var_H] : 
 (hasType(type_Hanging, Var_H) => 
(( ? [Var_S] : 
 (hasType(type_String, Var_S) &  
(( ? [Var_N] : 
 (hasType(type_Neck, Var_N) &  
(( ? [Var_P] : 
 (hasType(type_Human, Var_P) &  
(((f_experiencer(Var_H,Var_P)) & (((f_properPart(Var_N,Var_P)) & (((f_instrument(Var_H,Var_S)) & (f_holdsDuring(f_WhenFn(Var_H),meetsSpatially(Var_S,Var_N))))))))))))))))))))).

fof(axMidLem474, axiom, 
 ( ! [Var_CONDUCT] : 
 (hasType(type_OrchestralConducting, Var_CONDUCT) => 
(( ? [Var_MUSIC] : 
 (hasType(type_Music, Var_MUSIC) &  
(f_result(Var_CONDUCT,Var_MUSIC)))))))).

fof(axMidLem475, axiom, 
 ( ! [Var_SHARE] : 
 (hasType(type_Sharing, Var_SHARE) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(( ! [Var_AGENT2] : 
 (hasType(type_Entity, Var_AGENT2) => 
(( ! [Var_AGENT1] : 
 (hasType(type_Agent, Var_AGENT1) => 
(((((f_agent(Var_SHARE,Var_AGENT1)) & (((f_destination(Var_SHARE,Var_AGENT2)) & (f_patient(Var_SHARE,Var_OBJ)))))) => (( ? [Var_GIVE] : 
 (hasType(type_Giving, Var_GIVE) &  
(( ? [Var_PART] : 
 ((hasType(type_Entity, Var_PART) & hasType(type_Object, Var_PART)) &  
(((f_subProcess(Var_GIVE,Var_SHARE)) & (((f_patient(Var_GIVE,Var_PART)) & (((f_properPart(Var_PART,Var_OBJ)) & (((f_agent(Var_GIVE,Var_AGENT1)) & (f_destination(Var_GIVE,Var_AGENT2)))))))))))))))))))))))))))))).

fof(axMidLem476, axiom, 
 ( ! [Var_STEAL] : 
 (hasType(type_Stealing, Var_STEAL) => 
(( ! [Var_VICTIM] : 
 (hasType(type_CognitiveAgent, Var_VICTIM) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Entity, Var_AGENT) & hasType(type_CognitiveAgent, Var_AGENT)) => 
(((((f_destination(Var_STEAL,Var_AGENT)) & (f_origin(Var_STEAL,Var_VICTIM)))) => (( ~ (f_confersRight(destination(Var_STEAL,Var_AGENT),Var_VICTIM,Var_AGENT))))))))))))))).

fof(axMidLem477, axiom, 
 ( ! [Var_INHERIT] : 
 (hasType(type_Inheriting, Var_INHERIT) => 
(( ! [Var_PROPERTY] : 
 ((hasType(type_Entity, Var_PROPERTY) & hasType(type_Object, Var_PROPERTY)) => 
(( ! [Var_PERSON] : 
 ((hasType(type_Object, Var_PERSON) & hasType(type_Entity, Var_PERSON) & hasType(type_Agent, Var_PERSON)) => 
(( ! [Var_HEIR] : 
 ((hasType(type_Agent, Var_HEIR) & hasType(type_CognitiveAgent, Var_HEIR)) => 
(((((f_agent(Var_INHERIT,Var_HEIR)) & (((f_origin(Var_INHERIT,Var_PERSON)) & (f_patient(Var_INHERIT,Var_PROPERTY)))))) => (( ? [Var_DEATH] : 
 (hasType(type_Death, Var_DEATH) &  
(((f_experiencer(Var_DEATH,Var_PERSON)) & (((f_earlier(f_WhenFn(Var_DEATH),f_WhenFn(Var_INHERIT))) & (((f_holdsDuring(f_ImmediatePastFn(f_WhenFn(Var_DEATH)),possesses(Var_PERSON,Var_PROPERTY))) & (f_confersRight(possesses(Var_HEIR,Var_PROPERTY),Var_PERSON,Var_HEIR))))))))))))))))))))))))).

fof(axMidLem478, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Bequeathing, Var_B) => 
(( ! [Var_PROP] : 
 ((hasType(type_Entity, Var_PROP) & hasType(type_Object, Var_PROP)) => 
(( ! [Var_I] : 
 (hasType(type_Process, Var_I) => 
(( ! [Var_H] : 
 ((hasType(type_Entity, Var_H) & hasType(type_Agent, Var_H)) => 
(( ! [Var_P] : 
 ((hasType(type_Agent, Var_P) & hasType(type_Entity, Var_P)) => 
(((((f_agent(Var_B,Var_P)) & (((f_destination(Var_B,Var_H)) & (f_patient(Var_I,Var_PROP)))))) => (( ? [Var_D] : 
 (hasType(type_Death, Var_D) &  
(((f_experiencer(Var_D,Var_P)) & (((f_earlier(f_WhenFn(Var_D),f_WhenFn(Var_B))) & (((f_holdsDuring(f_ImmediatePastFn(f_WhenFn(Var_D)),possesses(Var_P,Var_PROP))) & (f_confersNorm(Var_P,possesses(Var_H,Var_PROP),inst_Permission)))))))))))))))))))))))))))).

fof(axMidLem479, axiom, 
 ( ! [Var_ORG] : 
 ((hasType(type_Organization, Var_ORG) & hasType(type_EducationalOrganization, Var_ORG)) => 
(( ! [Var_H] : 
 ((hasType(type_Human, Var_H) & hasType(type_CognitiveAgent, Var_H)) => 
(( ! [Var_P] : 
 ((hasType(type_Object, Var_P) & hasType(type_Position, Var_P)) => 
(((((f_attribute(Var_P,inst_CollegeFreshman)) & (f_occupiesPosition(Var_H,Var_P,Var_ORG)))) => (( ? [Var_T] : 
 ((hasType(type_TimePosition, Var_T) & hasType(type_Quantity, Var_T)) &  
(((f_holdsDuring(Var_T,student(Var_ORG,Var_H))) & (f_lessThan(Var_T,f_MeasureFn(1,inst_YearDuration))))))))))))))))))).

fof(axMidLem480, axiom, 
 ( ! [Var_ORG] : 
 ((hasType(type_Organization, Var_ORG) & hasType(type_EducationalOrganization, Var_ORG)) => 
(( ! [Var_H] : 
 ((hasType(type_Human, Var_H) & hasType(type_CognitiveAgent, Var_H)) => 
(( ! [Var_P] : 
 ((hasType(type_Object, Var_P) & hasType(type_Position, Var_P)) => 
(((((f_attribute(Var_P,inst_CollegeJunior)) & (f_occupiesPosition(Var_H,Var_P,Var_ORG)))) => (( ? [Var_T] : 
 ((hasType(type_TimePosition, Var_T) & hasType(type_Quantity, Var_T)) &  
(((f_holdsDuring(Var_T,student(Var_ORG,Var_H))) & (((f_greaterThanOrEqualTo(Var_T,f_MeasureFn(2,inst_YearDuration))) & (f_lessThan(Var_T,f_MeasureFn(3,inst_YearDuration))))))))))))))))))))).

fof(axMidLem481, axiom, 
 ( ! [Var_ORG] : 
 ((hasType(type_Organization, Var_ORG) & hasType(type_EducationalOrganization, Var_ORG)) => 
(( ! [Var_H] : 
 ((hasType(type_Human, Var_H) & hasType(type_CognitiveAgent, Var_H)) => 
(( ! [Var_P] : 
 ((hasType(type_Object, Var_P) & hasType(type_Position, Var_P)) => 
(((((f_attribute(Var_P,inst_CollegeJunior)) & (f_occupiesPosition(Var_H,Var_P,Var_ORG)))) => (( ? [Var_T] : 
 ((hasType(type_TimePosition, Var_T) & hasType(type_Quantity, Var_T)) &  
(((f_holdsDuring(Var_T,student(Var_ORG,Var_H))) & (((f_greaterThanOrEqualTo(Var_T,f_MeasureFn(3,inst_YearDuration))) & (f_lessThan(Var_T,f_MeasureFn(4,inst_YearDuration))))))))))))))))))))).

fof(axMidLem482, axiom, 
 ( ! [Var_ORG] : 
 ((hasType(type_Organization, Var_ORG) & hasType(type_EducationalOrganization, Var_ORG)) => 
(( ! [Var_H] : 
 ((hasType(type_Human, Var_H) & hasType(type_CognitiveAgent, Var_H)) => 
(( ! [Var_P] : 
 ((hasType(type_Object, Var_P) & hasType(type_Position, Var_P)) => 
(((((f_attribute(Var_P,inst_CollegeSophomore)) & (f_occupiesPosition(Var_H,Var_P,Var_ORG)))) => (( ? [Var_T] : 
 ((hasType(type_TimePosition, Var_T) & hasType(type_Quantity, Var_T)) &  
(((f_holdsDuring(Var_T,student(Var_ORG,Var_H))) & (((f_greaterThanOrEqualTo(Var_T,f_MeasureFn(2,inst_YearDuration))) & (f_lessThan(Var_T,f_MeasureFn(2,inst_YearDuration))))))))))))))))))))).

fof(axMidLem483, axiom, 
 ( ! [Var_PREF] : 
 (hasType(type_Process, Var_PREF) => 
(( ! [Var_P] : 
 ((hasType(type_Object, Var_P) & hasType(type_Agent, Var_P)) => 
(((f_attribute(Var_P,inst_Comedian)) => (( ? [Var_PERF] : 
 (hasType(type_Performance, Var_PERF) &  
(( ? [Var_L] : 
 (hasType(type_Laughing, Var_L) &  
(((f_agent(Var_PREF,Var_P)) & (f_causes(Var_PERF,Var_L)))))))))))))))))).

fof(axMidLem484, axiom, 
 ( ! [Var_H] : 
 ((hasType(type_Object, Var_H) & hasType(type_Agent, Var_H)) => 
(((f_attribute(Var_H,inst_PresidentOfTheUnitedStates)) => (f_leader(Var_H,inst_UnitedStates))))))).

fof(axMidLem485, axiom, 
 ( ! [Var_P] : 
 ((hasType(type_Object, Var_P) & hasType(type_Agent, Var_P)) => 
(((f_attribute(Var_P,inst_Dentist)) => (( ? [Var_D] : 
 (hasType(type_DiagnosticProcess, Var_D) &  
(( ? [Var_T] : 
 (hasType(type_Tooth, Var_T) &  
(((f_agent(Var_D,Var_P)) & (f_patient(Var_D,Var_T))))))))))))))).

fof(axMidLem486, axiom, 
 ( ! [Var_R] : 
 (hasType(type_Researcher, Var_R) => 
(( ! [Var_P] : 
 ((hasType(type_Object, Var_P) & hasType(type_Human, Var_P)) => 
(((f_attribute(Var_P,Var_R)) => (( ? [Var_S] : 
 (hasType(type_Science, Var_S) &  
(f_hasExpertise(Var_P,Var_S))))))))))))).

fof(axMidLem487, axiom, 
 ( ! [Var_OFFICER] : 
 (hasType(type_MilitaryOfficer, Var_OFFICER) => 
(( ? [Var_MANAGE] : 
 (hasType(type_Managing, Var_MANAGE) &  
(( ? [Var_PATIENT] : 
 ((hasType(type_MilitaryOrganization, Var_PATIENT) | hasType(type_Soldier, Var_PATIENT)) &  
(((f_agent(Var_MANAGE,Var_OFFICER)) & (f_patient(Var_MANAGE,Var_PATIENT))))))))))))).

fof(axMidLem488, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_CenturyDuration) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,100),inst_YearDuration))))))).

fof(axMidLem489, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_DecadeDuration) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,10),inst_YearDuration))))))).

fof(axMidLem490, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_YardLength) = f_MeasureFn(f_MultiplicationFn(3,Var_NUMBER),inst_FootLength))))))).

fof(axMidLem491, axiom, 
 ( ! [Var_NIGHT] : 
 (hasType(type_NightTime, Var_NIGHT) => 
(( ? [Var_DAY1] : 
 (hasType(type_DayTime, Var_DAY1) &  
(( ? [Var_DAY2] : 
 (hasType(type_DayTime, Var_DAY2) &  
(((f_meetsTemporally(Var_NIGHT,Var_DAY1)) & (f_meetsTemporally(Var_DAY2,Var_NIGHT))))))))))))).

fof(axMidLem492, axiom, 
 ( ! [Var_NIGHT] : 
 (hasType(type_NightTime, Var_NIGHT) => 
(( ? [Var_RISE] : 
 (hasType(type_Sunrise, Var_RISE) &  
(( ? [Var_SET] : 
 (hasType(type_Sunset, Var_SET) &  
(((f_starts(Var_SET,Var_NIGHT)) & (f_finishes(Var_RISE,Var_NIGHT))))))))))))).

fof(axMidLem493, axiom, 
 ( ! [Var_DAY] : 
 (hasType(type_DayTime, Var_DAY) => 
(( ? [Var_NIGHT1] : 
 (hasType(type_NightTime, Var_NIGHT1) &  
(( ? [Var_NIGHT2] : 
 (hasType(type_NightTime, Var_NIGHT2) &  
(((f_meetsTemporally(Var_DAY,Var_NIGHT1)) & (f_meetsTemporally(Var_NIGHT2,Var_DAY))))))))))))).

fof(axMidLem494, axiom, 
 ( ! [Var_DAY] : 
 (hasType(type_DayTime, Var_DAY) => 
(( ? [Var_RISE] : 
 (hasType(type_Sunrise, Var_RISE) &  
(( ? [Var_SET] : 
 (hasType(type_Sunset, Var_SET) &  
(((f_starts(Var_RISE,Var_DAY)) & (f_finishes(Var_SET,Var_DAY))))))))))))).

fof(axMidLem495, axiom, 
 ( ! [Var_WEEKEND] : 
 (hasType(type_Weekend, Var_WEEKEND) => 
(( ? [Var_SATURDAY] : 
 (hasType(type_Saturday, Var_SATURDAY) &  
(( ? [Var_SUNDAY] : 
 (hasType(type_Sunday, Var_SUNDAY) &  
(((f_starts(Var_SATURDAY,Var_WEEKEND)) & (((f_finishes(Var_SUNDAY,Var_WEEKEND)) & (f_meetsTemporally(Var_SATURDAY,Var_SUNDAY))))))))))))))).

fof(axMidLem496, axiom, 
 ( ! [Var_WINTER] : 
 (hasType(type_WinterSeason, Var_WINTER) => 
(( ? [Var_SPRING] : 
 (hasType(type_SpringSeason, Var_SPRING) &  
(f_meetsTemporally(Var_WINTER,Var_SPRING)))))))).

fof(axMidLem497, axiom, 
 ( ! [Var_WINTER] : 
 (hasType(type_WinterSeason, Var_WINTER) => 
(( ? [Var_AUTUMN] : 
 (hasType(type_FallSeason, Var_AUTUMN) &  
(f_meetsTemporally(Var_AUTUMN,Var_WINTER)))))))).

fof(axMidLem498, axiom, 
 ( ! [Var_SPRING] : 
 (hasType(type_SpringSeason, Var_SPRING) => 
(( ? [Var_SUMMER] : 
 (hasType(type_SummerSeason, Var_SUMMER) &  
(f_meetsTemporally(Var_SPRING,Var_SUMMER)))))))).

fof(axMidLem499, axiom, 
 ( ! [Var_SPRING] : 
 (hasType(type_SpringSeason, Var_SPRING) => 
(( ? [Var_WINTER] : 
 (hasType(type_WinterSeason, Var_WINTER) &  
(f_meetsTemporally(Var_WINTER,Var_SPRING)))))))).

fof(axMidLem500, axiom, 
 ( ! [Var_SUMMER] : 
 (hasType(type_SummerSeason, Var_SUMMER) => 
(( ? [Var_SPRING] : 
 (hasType(type_SpringSeason, Var_SPRING) &  
(f_meetsTemporally(Var_SPRING,Var_SUMMER)))))))).

fof(axMidLem501, axiom, 
 ( ! [Var_SUMMER] : 
 (hasType(type_SummerSeason, Var_SUMMER) => 
(( ? [Var_AUTUMN] : 
 (hasType(type_FallSeason, Var_AUTUMN) &  
(f_meetsTemporally(Var_SUMMER,Var_AUTUMN)))))))).

fof(axMidLem502, axiom, 
 ( ! [Var_AUTUMN] : 
 (hasType(type_FallSeason, Var_AUTUMN) => 
(( ? [Var_SUMMER] : 
 (hasType(type_SummerSeason, Var_SUMMER) &  
(f_meetsTemporally(Var_SUMMER,Var_AUTUMN)))))))).

fof(axMidLem503, axiom, 
 ( ! [Var_AUTUMN] : 
 (hasType(type_FallSeason, Var_AUTUMN) => 
(( ? [Var_WINTER] : 
 (hasType(type_WinterSeason, Var_WINTER) &  
(f_meetsTemporally(Var_AUTUMN,Var_WINTER)))))))).

fof(axMidLem504, axiom, 
 ( ! [Var_OBJ2] : 
 ((hasType(type_Object, Var_OBJ2) & hasType(type_Physical, Var_OBJ2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_Object, Var_OBJ1) & hasType(type_Physical, Var_OBJ1)) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_Upstairs)) => (( ? [Var_LEVEL1] : 
 (hasType(type_BuildingLevel, Var_LEVEL1) &  
(( ? [Var_LEVEL2] : 
 (hasType(type_BuildingLevel, Var_LEVEL2) &  
(( ? [Var_BUILDING] : 
 (hasType(type_Building, Var_BUILDING) &  
(((f_part(Var_LEVEL1,Var_BUILDING)) & (((f_part(Var_LEVEL2,Var_BUILDING)) & (((f_located(Var_OBJ1,Var_LEVEL1)) & (((f_located(Var_OBJ2,Var_LEVEL2)) & (f_orientation(Var_LEVEL1,Var_LEVEL2,inst_Above))))))))))))))))))))))))))).

fof(axMidLem505, axiom, 
 ( ! [Var_OBJ2] : 
 ((hasType(type_Object, Var_OBJ2) & hasType(type_Physical, Var_OBJ2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_Object, Var_OBJ1) & hasType(type_Physical, Var_OBJ1)) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_Downstairs)) => (( ? [Var_LEVEL1] : 
 (hasType(type_BuildingLevel, Var_LEVEL1) &  
(( ? [Var_LEVEL2] : 
 (hasType(type_BuildingLevel, Var_LEVEL2) &  
(( ? [Var_BUILDING] : 
 (hasType(type_Building, Var_BUILDING) &  
(((f_part(Var_LEVEL1,Var_BUILDING)) & (((f_part(Var_LEVEL2,Var_BUILDING)) & (((f_located(Var_OBJ1,Var_LEVEL1)) & (((f_located(Var_OBJ2,Var_LEVEL2)) & (f_orientation(Var_LEVEL1,Var_LEVEL2,inst_Below))))))))))))))))))))))))))).

fof(axMidLem506, axiom, 
 ( ! [Var_E] : 
 (hasType(type_Object, Var_E) => 
(((f_attribute(Var_E,inst_Headache)) => (( ? [Var_H] : 
 (hasType(type_Head, Var_H) &  
(((f_part(Var_H,Var_E)) & (f_attribute(Var_H,inst_Pain)))))))))))).

fof(axMidLem507, axiom, 
 ( ! [Var_WORD] : 
 (hasType(type_Word, Var_WORD) => 
(( ? [Var_SYLLABLE] : 
 (hasType(type_Syllable, Var_SYLLABLE) &  
(f_part(Var_SYLLABLE,Var_WORD)))))))).

fof(axMidLem508, axiom, 
 ( ! [Var_ATTR] : 
 (hasType(type_GameAttribute, Var_ATTR) => 
(( ! [Var_THING] : 
 ((hasType(type_Entity, Var_THING) & hasType(type_Agent, Var_THING) & hasType(type_Process, Var_THING)) => 
(((f_property(Var_THING,Var_ATTR)) => (( ? [Var_GAME] : 
 (hasType(type_Game, Var_GAME) &  
(((f_agent(Var_GAME,Var_THING)) | (((f_patient(Var_GAME,Var_THING)) | (f_subProcess(Var_THING,Var_GAME))))))))))))))))).

fof(axMidLem509, axiom, 
 ( ! [Var_ATTR] : 
 (hasType(type_SportsAttribute, Var_ATTR) => 
(( ! [Var_THING] : 
 ((hasType(type_Entity, Var_THING) & hasType(type_Agent, Var_THING) & hasType(type_Process, Var_THING)) => 
(((f_property(Var_THING,Var_ATTR)) => (( ? [Var_SPORT] : 
 (hasType(type_Game, Var_SPORT) &  
(((f_agent(Var_SPORT,Var_THING)) | (((f_patient(Var_SPORT,Var_THING)) | (f_subProcess(Var_THING,Var_SPORT))))))))))))))))).

fof(axMidLem510, axiom, 
 ( ! [Var_R] : 
 (hasType(type_ChemicalReduction, Var_R) => 
(( ! [Var_G] : 
 ((hasType(type_Quantity, Var_G) & hasType(type_PositiveInteger, Var_G)) => 
(( ! [Var_L] : 
 ((hasType(type_PositiveInteger, Var_L) & hasType(type_Quantity, Var_L)) => 
(( ! [Var_S] : 
 ((hasType(type_Entity, Var_S) & hasType(type_PureSubstance, Var_S)) => 
(((((f_patient(Var_R,Var_S)) & (f_holdsDuring(f_BeginFn(f_WhenFn(Var_R)),electronNumber(Var_S,Var_L))))) => (((f_greaterThan(Var_G,Var_L)) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_R)),electronNumber(Var_S,Var_G))))))))))))))))))).

fof(axMidLem511, axiom, 
 ( ! [Var_O] : 
 (hasType(type_Oxidation, Var_O) => 
(( ! [Var_G] : 
 ((hasType(type_PositiveInteger, Var_G) & hasType(type_Quantity, Var_G)) => 
(( ! [Var_S] : 
 ((hasType(type_Entity, Var_S) & hasType(type_PureSubstance, Var_S)) => 
(((((f_patient(Var_O,Var_S)) & (f_holdsDuring(f_BeginFn(f_WhenFn(Var_O)),electronNumber(Var_S,Var_G))))) => (( ? [Var_L] : 
 ((hasType(type_Quantity, Var_L) & hasType(type_PositiveInteger, Var_L)) &  
(((f_lessThan(Var_L,Var_G)) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_O)),electronNumber(Var_S,Var_L))))))))))))))))))).

fof(axMidLem512, axiom, 
 ( ! [Var_DIALYSIS] : 
 (hasType(type_Dialysis, Var_DIALYSIS) => 
(( ? [Var_SOLUTION] : 
 (hasType(type_Solution, Var_SOLUTION) &  
(( ? [Var_SUBSTANCE1] : 
 (hasType(type_PureSubstance, Var_SUBSTANCE1) &  
(( ? [Var_SUBSTANCE2] : 
 (hasType(type_PureSubstance, Var_SUBSTANCE2) &  
(((f_resourceS(Var_DIALYSIS,Var_SOLUTION)) & (((f_result(Var_DIALYSIS,Var_SUBSTANCE1)) & (((f_result(Var_DIALYSIS,Var_SUBSTANCE2)) & (Var_SUBSTANCE1 != Var_SUBSTANCE2))))))))))))))))))).

fof(axMidLem513, axiom, 
 ( ! [Var_D] : 
 (hasType(type_Diluting, Var_D) => 
(( ? [Var_S] : 
 (hasType(type_Solution, Var_S) &  
(((f_patient(Var_D,Var_S)) & (f_attribute(Var_S,inst_Liquid)))))))))).

fof(axMidLem514, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Chromatography, Var_C) => 
(( ? [Var_M] : 
 ((hasType(type_LiquidMixture, Var_M) | hasType(type_GasMixture, Var_M)) &  
(f_resourceS(Var_C,Var_M)))))))).

fof(axMidLem515, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Chromatography, Var_C) => 
(( ? [Var_S] : 
 (hasType(type_PureSubstance, Var_S) &  
(f_result(Var_C,Var_S)))))))).

fof(axMidLem516, axiom, 
 ( ! [Var_A] : 
 (hasType(type_RightAngle, Var_A) => 
(f_angularMeasure(Var_A,f_MeasureFn(90,inst_AngularDegree)))))).

fof(axMidLem517, axiom, 
 ( ! [Var_A] : 
 (hasType(type_AcuteAngle, Var_A) => 
(( ! [Var_N] : 
 ((hasType(type_RealNumber, Var_N) & hasType(type_Quantity, Var_N)) => 
(((f_angularMeasure(Var_A,f_MeasureFn(Var_N,inst_AngularDegree))) => (f_lessThan(Var_N,90)))))))))).

fof(axMidLem518, axiom, 
 ( ! [Var_A] : 
 (hasType(type_ObliqueAngle, Var_A) => 
(( ! [Var_N] : 
 ((hasType(type_RealNumber, Var_N) & hasType(type_Quantity, Var_N)) => 
(((f_angularMeasure(Var_A,f_MeasureFn(Var_N,inst_AngularDegree))) => (f_greaterThan(Var_N,90)))))))))).

fof(axMidLem519, axiom, 
 ( ! [Var_POLYGON] : 
 (hasType(type_Polygon, Var_POLYGON) => 
(( ! [Var_PART] : 
 ((hasType(type_GeometricFigure, Var_PART) & hasType(type_OneDimensionalFigure, Var_PART)) => 
(((f_geometricPart(Var_PART,Var_POLYGON)) => (((f_sideOfFigure(Var_PART,Var_POLYGON)) | (( ? [Var_SIDE] : 
 ((hasType(type_OneDimensionalFigure, Var_SIDE) & hasType(type_GeometricFigure, Var_SIDE)) &  
(((f_sideOfFigure(Var_SIDE,Var_POLYGON)) & (f_geometricPart(Var_PART,Var_SIDE))))))))))))))))).

fof(axMidLem520, axiom, 
 ( ! [Var_T] : 
 (hasType(type_RightTriangle, Var_T) => 
(( ? [Var_A] : 
 (hasType(type_RightAngle, Var_A) &  
(f_angleOfFigure(Var_A,Var_T)))))))).

fof(axMidLem521, axiom, 
 ( ! [Var_SQUARE] : 
 (hasType(type_Square, Var_SQUARE) => 
(( ? [Var_LENGTH] : 
 (hasType(type_LengthMeasure, Var_LENGTH) &  
(( ! [Var_SIDE] : 
 (hasType(type_OneDimensionalFigure, Var_SIDE) => 
(((f_sideOfFigure(Var_SIDE,Var_SQUARE)) => (f_lineMeasure(Var_SIDE,Var_LENGTH))))))))))))).

fof(axMidLem522, axiom, 
 ( ! [Var_L] : 
 (hasType(type_Entity, Var_L) => 
(( ! [Var_C] : 
 (hasType(type_Circle, Var_C) => 
(((f_DiameterFn(Var_C) = Var_L) => (( ? [Var_R] : 
 ((hasType(type_Entity, Var_R) & hasType(type_Quantity, Var_R)) &  
(((f_RadiusFn(Var_C) = Var_R) & (f_MultiplicationFn(Var_R,2) = Var_L)))))))))))))).

fof(axMidLem523, axiom, 
 ( ! [Var_R] : 
 ((hasType(type_LengthMeasure, Var_R) & hasType(type_Entity, Var_R)) => 
(( ! [Var_P2] : 
 ((hasType(type_GeometricFigure, Var_P2) & hasType(type_GeometricPoint, Var_P2)) => 
(( ! [Var_P] : 
 ((hasType(type_Entity, Var_P) & hasType(type_GeometricPoint, Var_P)) => 
(( ! [Var_C] : 
 ((hasType(type_Circle, Var_C) & hasType(type_GeometricFigure, Var_C)) => 
(((((f_CenterOfCircleFn(Var_C) = Var_P) & (((f_pointOfFigure(Var_P2,Var_C)) & (f_geometricDistance(Var_P2,Var_P,Var_R)))))) => (f_RadiusFn(Var_C) = Var_R))))))))))))))).

fof(axMidLem524, axiom, 
 ( ! [Var_CIRCLE] : 
 ((hasType(type_TwoDimensionalObject, Var_CIRCLE) & hasType(type_GeometricFigure, Var_CIRCLE)) => 
(( ! [Var_LINE] : 
 ((hasType(type_OneDimensionalFigure, Var_LINE) & hasType(type_GeometricFigure, Var_LINE)) => 
(((f_tangent(Var_LINE,Var_CIRCLE)) => (( ? [Var_POINT1] : 
 ((hasType(type_GeometricFigure, Var_POINT1) & hasType(type_Entity, Var_POINT1)) &  
(((f_pointOfFigure(Var_POINT1,Var_LINE)) & (((f_pointOfFigure(Var_POINT1,Var_CIRCLE)) & (( ! [Var_POINT2] : 
 ((hasType(type_GeometricFigure, Var_POINT2) & hasType(type_Entity, Var_POINT2)) => 
(((((f_pointOfFigure(Var_POINT2,Var_LINE)) & (f_pointOfFigure(Var_POINT2,Var_CIRCLE)))) => (Var_POINT1 = Var_POINT2))))))))))))))))))))).

fof(axMidLem525, axiom, 
 ( ! [Var_WAR] : 
 (hasType(type_CivilWar, Var_WAR) => 
(( ? [Var_NATION] : 
 (hasType(type_Nation, Var_NATION) &  
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_GeopoliticalArea, Var_AGENT)) => 
(((f_contestParticipant(Var_WAR,Var_AGENT)) => (f_geopoliticalSubdivision(Var_AGENT,Var_NATION))))))))))))).

fof(axMidLem526, axiom, 
 ( ! [Var_H] : 
 (hasType(type_Object, Var_H) => 
(((f_attribute(Var_H,inst_Pregnant)) => (f_attribute(Var_H,inst_Female))))))).

fof(axMidLem527, axiom, 
 ( ! [Var_LIE] : 
 (hasType(type_LyingDown, Var_LIE) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((f_agent(Var_LIE,Var_AGENT)) => (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_LIE)),attribute(Var_AGENT,inst_Sitting))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_LIE)),attribute(Var_AGENT,inst_Prostrate))))))))))))).

fof(axMidLem528, axiom, 
 ( ! [Var_SIT] : 
 (hasType(type_SittingDown, Var_SIT) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((f_agent(Var_SIT,Var_AGENT)) => (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_SIT)),attribute(Var_AGENT,inst_Standing))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_SIT)),attribute(Var_AGENT,inst_Sitting))))))))))))).

fof(axMidLem529, axiom, 
 ( ! [Var_STAND] : 
 (hasType(type_StandingUp, Var_STAND) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((f_agent(Var_STAND,Var_AGENT)) => (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_STAND)),attribute(Var_AGENT,inst_Sitting))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_STAND)),attribute(Var_AGENT,inst_Standing))))))))))))).

fof(axMidLem530, axiom, 
 ( ! [Var_EM] : 
 (hasType(type_EyeMotion, Var_EM) => 
(( ! [Var_A] : 
 ((hasType(type_Agent, Var_A) & hasType(type_Object, Var_A)) => 
(((f_agent(Var_EM,Var_A)) => (( ? [Var_E] : 
 (hasType(type_Eyelid, Var_E) &  
(((f_part(Var_E,Var_A)) & (f_patient(Var_EM,Var_E))))))))))))))).

fof(axMidLem531, axiom, 
 ( ! [Var_P] : 
 (hasType(type_ReflexiveProcess, Var_P) => 
(( ? [Var_M] : 
 (hasType(type_Muscle, Var_M) &  
(f_patient(Var_P,Var_M)))))))).

fof(axMidLem532, axiom, 
 ( ! [Var_ANIMAL] : 
 (hasType(type_DomesticAnimal, Var_ANIMAL) => 
(( ? [Var_KEEP] : 
 (hasType(type_Keeping, Var_KEEP) &  
(( ? [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) &  
(((f_agent(Var_KEEP,Var_PERSON)) & (f_patient(Var_KEEP,Var_ANIMAL))))))))))))).

fof(axMidLem533, axiom, 
 ( ! [Var_MULE] : 
 (hasType(type_Mule, Var_MULE) => 
(( ? [Var_DONKEY] : 
 (hasType(type_Donkey, Var_DONKEY) &  
(( ? [Var_HORSE] : 
 (hasType(type_Horse, Var_HORSE) &  
(((f_father(Var_MULE,Var_DONKEY)) & (f_mother(Var_MULE,Var_HORSE))))))))))))).

fof(axMidLem534, axiom, 
 ( ! [Var_F] : 
 (hasType(type_Feather, Var_F) => 
(( ? [Var_B] : 
 (hasType(type_Bird, Var_B) &  
(f_part(Var_F,Var_B)))))))).

fof(axMidLem535, axiom, 
 ( ! [Var_HAY] : 
 (hasType(type_Hay, Var_HAY) => 
(( ? [Var_MAKE] : 
 (hasType(type_Making, Var_MAKE) &  
(( ? [Var_GRASS] : 
 (hasType(type_Grass, Var_GRASS) &  
(((f_resourceS(Var_MAKE,Var_GRASS)) & (f_result(Var_MAKE,Var_HAY))))))))))))).

fof(axMidLem536, axiom, 
 ( ! [Var_VACATION] : 
 (hasType(type_Vacationing, Var_VACATION) => 
(( ! [Var_WORK] : 
 (hasType(type_Working, Var_WORK) => 
(( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(((((f_agent(Var_VACATION,Var_PERSON)) & (f_agent(Var_WORK,Var_PERSON)))) => (( ~ (f_overlapsTemporally(f_WhenFn(Var_VACATION),f_WhenFn(Var_WORK)))))))))))))))).

fof(axMidLem537, axiom, 
 ( ! [Var_FARMING] : 
 (hasType(type_Farming, Var_FARMING) => 
(( ! [Var_FARMER] : 
 ((hasType(type_Agent, Var_FARMER) & hasType(type_Physical, Var_FARMER)) => 
(((f_agent(Var_FARMING,Var_FARMER)) => (( ? [Var_FARM] : 
 (hasType(type_Farm, Var_FARM) &  
(f_holdsDuring(f_WhenFn(Var_FARMING),located(Var_FARMER,Var_FARM)))))))))))))).

fof(axMidLem538, axiom, 
 ( ! [Var_W] : 
 ((hasType(type_Object, Var_W) & hasType(type_Woman, Var_W)) => 
(((f_attribute(Var_W,inst_Housewife)) => (( ? [Var_H] : 
 (hasType(type_Man, Var_H) &  
(f_wife(Var_W,Var_H)))))))))).

fof(axMidLem539, axiom, 
 ( ! [Var_OCCUPATION] : 
 (hasType(type_SkilledOccupation, Var_OCCUPATION) => 
(( ! [Var_PERSON] : 
 ((hasType(type_Object, Var_PERSON) & hasType(type_Entity, Var_PERSON)) => 
(((f_attribute(Var_PERSON,Var_OCCUPATION)) => (( ? [Var_TRAINING] : 
 (hasType(type_EducationalProcess, Var_TRAINING) &  
(f_destination(Var_TRAINING,Var_PERSON))))))))))))).

fof(axMidLem540, axiom, 
 ( ! [Var_FM] : 
 (hasType(type_FilmMaking, Var_FM) => 
(( ? [Var_M] : 
 (hasType(type_MotionPicture, Var_M) &  
(( ? [Var_F] : 
 (hasType(type_PhotographicFilm, Var_F) &  
(((f_result(Var_FM,Var_M)) & (f_resourceS(Var_FM,Var_F))))))))))))).

fof(axMidLem541, axiom, 
 ( ! [Var_P] : 
 ((hasType(type_Object, Var_P) & hasType(type_Agent, Var_P)) => 
(((f_attribute(Var_P,inst_Carpenter)) => (f_hasSkill(type_Carpentry,Var_P))))))).

fof(axMidLem542, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Carpentry, Var_C) => 
(( ! [Var_W] : 
 (hasType(type_Wood, Var_W) => 
(( ? [Var_B] : 
 (hasType(type_Building, Var_B) &  
(((f_part(Var_W,Var_B)) & (f_result(Var_C,Var_B))))))))))))).

fof(axMidLem543, axiom, 
 ( ! [Var_P] : 
 ((hasType(type_Object, Var_P) & hasType(type_Agent, Var_P)) => 
(((f_attribute(Var_P,inst_FarmHand)) => (( ? [Var_F] : 
 (hasType(type_Agriculture, Var_F) &  
(f_agent(Var_F,Var_P)))))))))).

fof(axMidLem544, axiom, 
 ( ! [Var_H] : 
 ((hasType(type_Object, Var_H) & hasType(type_Agent, Var_H)) => 
(((f_attribute(Var_H,inst_Potter)) => (( ? [Var_M] : 
 (hasType(type_Making, Var_M) &  
(( ? [Var_P] : 
 (hasType(type_Pottery, Var_P) &  
(((f_agent(Var_M,Var_H)) & (f_result(Var_M,Var_P))))))))))))))).

fof(axMidLem545, axiom, 
 ( ! [Var_D] : 
 (hasType(type_Deacon, Var_D) => 
(( ? [Var_O] : 
 (hasType(type_ReligiousOrganization, Var_O) &  
(( ? [Var_C] : 
 (hasType(type_Cleric, Var_C) &  
(f_subordinateInOrganization(Var_O,Var_D,Var_C))))))))))).

fof(axMidLem546, axiom, 
 ( ! [Var_P] : 
 (hasType(type_PensionPlan, Var_P) => 
(( ! [Var_O] : 
 ((hasType(type_Organization, Var_O) & hasType(type_FinancialCompany, Var_O)) => 
(( ! [Var_A] : 
 (hasType(type_CognitiveAgent, Var_A) => 
(((((f_accountHolder(Var_P,Var_A)) & (f_employs(Var_O,Var_A)))) => (f_financialAccount(Var_P,Var_O))))))))))))).

fof(axMidLem547, axiom, 
 ( ! [Var_PSP] : 
 (hasType(type_ProfitSharingPlan, Var_PSP) => 
(( ! [Var_P] : 
 ((hasType(type_CurrencyMeasure, Var_P) & hasType(type_Quantity, Var_P)) => 
(( ! [Var_A] : 
 ((hasType(type_FinancialTransaction, Var_A) & hasType(type_Process, Var_A)) => 
(( ! [Var_O] : 
 ((hasType(type_Organization, Var_O) & hasType(type_Agent, Var_O)) => 
(( ! [Var_H] : 
 (hasType(type_CognitiveAgent, Var_H) => 
(((((f_accountHolder(Var_PSP,Var_H)) & (((f_employs(Var_O,Var_H)) & (((f_profit(Var_A,Var_P)) & (f_agent(Var_A,Var_O)))))))) => (( ? [Var_PAY] : 
 (hasType(type_FinancialTransaction, Var_PAY) &  
(( ? [Var_C] : 
 ((hasType(type_CurrencyMeasure, Var_C) & hasType(type_Quantity, Var_C)) &  
(((f_transactionAmount(Var_PAY,Var_C)) & (((f_lessThan(Var_C,Var_P)) & (f_destination(Var_PAY,Var_PSP))))))))))))))))))))))))))))).

fof(axMidLem548, axiom, 
 ( ! [Var_H] : 
 ((hasType(type_Human, Var_H) & hasType(type_Agent, Var_H)) => 
(((f_hasExpertise(Var_H,inst_Architecture)) => (( ? [Var_D] : 
 (hasType(type_ContentDevelopment, Var_D) &  
(( ? [Var_P] : 
 (hasType(type_Blueprint, Var_P) &  
(( ? [Var_B] : 
 (hasType(type_Building, Var_B) &  
(((f_agent(Var_D,Var_H)) & (((f_result(Var_D,Var_P)) & (f_represents(Var_P,Var_B)))))))))))))))))))).

fof(axMidLem549, axiom, 
 ( ! [Var_FIELD] : 
 ((hasType(type_FieldOfStudy, Var_FIELD) & hasType(type_Proposition, Var_FIELD)) => 
(( ! [Var_PERSON] : 
 ((hasType(type_Human, Var_PERSON) & hasType(type_Agent, Var_PERSON)) => 
(((f_hasExpertise(Var_PERSON,Var_FIELD)) => (( ? [Var_LEARN] : 
 (hasType(type_Learning, Var_LEARN) &  
(((f_agent(Var_LEARN,Var_PERSON)) & (f_realization(Var_LEARN,Var_FIELD))))))))))))))).

fof(axMidLem550, axiom, 
 ( ! [Var_BLEED] : 
 (hasType(type_Bleeding, Var_BLEED) => 
(( ? [Var_INJURY] : 
 (hasType(type_Injuring, Var_INJURY) &  
(f_causes(Var_INJURY,Var_BLEED)))))))).

fof(axMidLem551, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Blushing, Var_B) => 
(( ! [Var_A] : 
 ((hasType(type_Entity, Var_A) & hasType(type_Object, Var_A)) => 
(((f_experiencer(Var_B,Var_A)) => (( ? [Var_S1] : 
 (hasType(type_EmotionalState, Var_S1) &  
(( ? [Var_S2] : 
 (hasType(type_EmotionalState, Var_S2) &  
(( ? [Var_T2] : 
 ((hasType(type_TimePosition, Var_T2) & hasType(type_TimeInterval, Var_T2)) &  
(( ? [Var_T1] : 
 ((hasType(type_TimePosition, Var_T1) & hasType(type_TimeInterval, Var_T1)) &  
(((Var_S1 != Var_S2) & (((f_holdsDuring(Var_T1,attribute(Var_A,Var_S1))) & (((f_holdsDuring(Var_T2,attribute(Var_A,Var_S2))) & (((f_starts(f_WhenFn(Var_B),Var_T2)) & (f_finishes(f_WhenFn(Var_B),Var_T1)))))))))))))))))))))))))))))).

fof(axMidLem552, axiom, 
 ( ! [Var_CLOSE] : 
 (hasType(type_ClosingContract, Var_CLOSE) => 
(( ! [Var_CONTRACT] : 
 ((hasType(type_Entity, Var_CONTRACT) & hasType(type_Contract, Var_CONTRACT)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_CognitiveAgent, Var_AGENT)) => 
(((((f_agent(Var_CLOSE,Var_AGENT)) & (f_destination(Var_CLOSE,Var_CONTRACT)))) => (f_agreementMember(Var_CONTRACT,Var_AGENT))))))))))))).

fof(axMidLem553, axiom, 
 ( ! [Var_D] : 
 (hasType(type_Diet, Var_D) => 
(( ! [Var_P] : 
 (hasType(type_Process, Var_P) => 
(((f_realization(Var_P,Var_D)) => (( ? [Var_E] : 
 (hasType(type_Eating, Var_E) &  
(f_subProcess(Var_E,Var_P))))))))))))).

fof(axMidLem554, axiom, 
 ( ! [Var_FOOD] : 
 (hasType(type_PreparedFood, Var_FOOD) => 
(( ? [Var_COOK] : 
 (hasType(type_Cooking, Var_COOK) &  
(f_result(Var_COOK,Var_FOOD)))))))).

fof(axMidLem555, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Baking, Var_B) => 
(( ? [Var_O] : 
 (hasType(type_Oven, Var_O) &  
(f_instrument(Var_B,Var_O)))))))).

fof(axMidLem556, axiom, 
 ( ! [Var_B] : 
 (hasType(type_BreadOrBiscuit, Var_B) => 
(( ? [Var_D] : 
 (hasType(type_Dough, Var_D) &  
(( ? [Var_BAKE] : 
 (hasType(type_Baking, Var_BAKE) &  
(((f_resourceS(Var_BAKE,Var_D)) & (f_result(Var_BAKE,Var_B))))))))))))).

fof(axMidLem557, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Sandwich, Var_S) => 
(( ? [Var_B1] : 
 (hasType(type_BreadOrBiscuit, Var_B1) &  
(( ? [Var_B2] : 
 (hasType(type_BreadOrBiscuit, Var_B2) &  
(( ? [Var_F] : 
 (hasType(type_Food, Var_F) &  
(((f_between(Var_B1,Var_F,Var_B2)) & (((Var_B1 != Var_B2) & (((Var_B1 != Var_F) & (((Var_B2 != Var_F) & (((f_part(Var_B1,Var_S)) & (((f_part(Var_B2,Var_S)) & (f_part(Var_F,Var_S)))))))))))))))))))))))))).

fof(axMidLem558, axiom, 
 ( ! [Var_D] : 
 (hasType(type_Dough, Var_D) => 
(( ? [Var_F] : 
 (hasType(type_Flour, Var_F) &  
(( ? [Var_W] : 
 (hasType(type_Water, Var_W) &  
(((f_part(Var_F,Var_D)) & (f_part(Var_W,Var_D))))))))))))).

fof(axMidLem559, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Butter, Var_B) => 
(( ? [Var_C] : 
 (hasType(type_Cooking, Var_C) &  
(( ? [Var_M] : 
 (hasType(type_Milk, Var_M) &  
(((f_resourceS(Var_C,Var_M)) & (f_result(Var_C,Var_B))))))))))))).

fof(axMidLem560, axiom, 
 ( ! [Var_F] : 
 (hasType(type_Flour, Var_F) => 
(( ? [Var_P] : 
 (hasType(type_IntentionalProcess, Var_P) &  
(( ? [Var_C] : 
 (hasType(type_CerealGrain, Var_C) &  
(((f_resourceS(Var_P,Var_C)) & (f_result(Var_P,Var_F))))))))))))).

fof(axMidLem561, axiom, 
 ( ! [Var_H] : 
 (hasType(type_Honey, Var_H) => 
(( ? [Var_P] : 
 (hasType(type_PhysiologicProcess, Var_P) &  
(( ? [Var_B] : 
 (hasType(type_Bee, Var_B) &  
(((f_agent(Var_P,Var_B)) & (f_result(Var_P,Var_H))))))))))))).

fof(axMidLem562, axiom, 
 ( ! [Var_G] : 
 (hasType(type_AtomicGroup, Var_G) => 
(( ? [Var_ATOM1] : 
 (hasType(type_Atom, Var_ATOM1) &  
(( ? [Var_ATOM2] : 
 (hasType(type_Atom, Var_ATOM2) &  
(((Var_ATOM1 != Var_ATOM2) & (((f_part(Var_ATOM1,Var_G)) & (f_part(Var_ATOM2,Var_G))))))))))))))).

fof(axMidLem563, axiom, 
 ( ! [Var_G] : 
 (hasType(type_AtomicGroup, Var_G) => 
(( ? [Var_M] : 
 (hasType(type_Molecule, Var_M) &  
(f_part(Var_G,Var_M)))))))).

fof(axMidLem564, axiom, 
 ( ! [Var_M] : 
 (hasType(type_MilitaryManeuver, Var_M) => 
(( ? [Var_B] : 
 (hasType(type_Battle, Var_B) &  
(f_subProcess(Var_M,Var_B)))))))).

fof(axMidLem565, axiom, 
 ( ! [Var_X] : 
 (hasType(type_Bombing, Var_X) => 
(( ? [Var_BOMB] : 
 (hasType(type_Bomb, Var_BOMB) &  
(f_instrument(Var_X,Var_BOMB)))))))).

fof(axMidLem566, axiom, 
 ( ! [Var_X] : 
 (hasType(type_CarBombing, Var_X) => 
(( ? [Var_BOMB] : 
 (hasType(type_Bomb, Var_BOMB) &  
(( ? [Var_CAR] : 
 (hasType(type_TransportationDevice, Var_CAR) &  
(((f_instrument(Var_X,Var_CAR)) & (((f_instrument(Var_X,Var_BOMB)) & (f_connected(Var_CAR,Var_BOMB))))))))))))))).

fof(axMidLem567, axiom, 
 ( ! [Var_X] : 
 (hasType(type_ChemicalAttack, Var_X) => 
(( ? [Var_CHEM] : 
 (hasType(type_Substance, Var_CHEM) &  
(f_instrument(Var_X,Var_CHEM)))))))).

fof(axMidLem568, axiom, 
 ( ! [Var_X] : 
 (hasType(type_HandGrenade, Var_X) => 
(( ! [Var_N] : 
 ((hasType(type_RealNumber, Var_N) & hasType(type_Quantity, Var_N)) => 
(((f_measure(Var_X,f_MeasureFn(Var_N,inst_PoundMass))) & (f_lessThan(Var_N,10)))))))))).

fof(axMidLem569, axiom, 
 ( ! [Var_X] : 
 (hasType(type_HandgrenadeAttack, Var_X) => 
(( ? [Var_HG] : 
 (hasType(type_HandGrenade, Var_HG) &  
(f_instrument(Var_X,Var_HG)))))))).

fof(axMidLem570, axiom, 
 ( ! [Var_H] : 
 (hasType(type_Hijacking, Var_H) => 
(( ? [Var_V] : 
 (hasType(type_Vehicle, Var_V) &  
(f_patient(Var_H,Var_V)))))))).

fof(axMidLem571, axiom, 
 ( ! [Var_H] : 
 (hasType(type_Hijacking, Var_H) => 
(( ? [Var_D] : 
 (hasType(type_Driving, Var_D) &  
(f_subProcess(Var_D,Var_H)))))))).

fof(axMidLem572, axiom, 
 ( ! [Var_X] : 
 (hasType(type_HostageTaking, Var_X) => 
(( ? [Var_A] : 
 (hasType(type_SentientAgent, Var_A) &  
(f_patient(Var_X,Var_A)))))))).

fof(axMidLem573, axiom, 
 ( ! [Var_X] : 
 (hasType(type_Kidnapping, Var_X) => 
(( ? [Var_A] : 
 (hasType(type_SentientAgent, Var_A) &  
(( ? [Var_LOC1] : 
 (hasType(type_GeographicArea, Var_LOC1) &  
(( ? [Var_LOC2] : 
 (hasType(type_GeographicArea, Var_LOC2) &  
(((Var_LOC1 != Var_LOC2) & (((f_holdsDuring(f_ImmediatePastFn(f_WhenFn(Var_X)),located(Var_A,Var_LOC1))) & (f_holdsDuring(f_WhenFn(Var_X),located(Var_A,Var_LOC2))))))))))))))))))).

fof(axMidLem574, axiom, 
 ( ! [Var_X] : 
 (hasType(type_KnifeAttack, Var_X) => 
(( ? [Var_HG] : 
 (hasType(type_Knife, Var_HG) &  
(f_instrument(Var_X,Var_HG)))))))).

fof(axMidLem575, axiom, 
 ( ! [Var_X] : 
 (hasType(type_MortarAttack, Var_X) => 
(( ? [Var_MA] : 
 (hasType(type_Mortar, Var_MA) &  
(f_instrument(Var_X,Var_MA)))))))).

fof(axMidLem576, axiom, 
 ( ! [Var_X] : 
 (hasType(type_Stoning, Var_X) => 
(( ? [Var_ST] : 
 (hasType(type_Rock, Var_ST) &  
(f_instrument(Var_X,Var_ST)))))))).

fof(axMidLem577, axiom, 
 ( ! [Var_X] : 
 (hasType(type_SuicideBombing, Var_X) => 
(( ? [Var_A] : 
 ((hasType(type_Agent, Var_A) & hasType(type_Object, Var_A)) &  
(((f_agent(Var_X,Var_A)) & (f_holdsDuring(f_FutureFn(f_WhenFn(Var_X)),attribute(Var_A,inst_Dead))))))))))).

fof(axMidLem578, axiom, 
 ( ! [Var_X] : 
 (hasType(type_SuicideBombing, Var_X) => 
(( ! [Var_P] : 
 ((hasType(type_Agent, Var_P) & hasType(type_CognitiveAgent, Var_P)) => 
(((f_agent(Var_X,Var_P)) => (f_believes(Var_P,holdsDuring(f_FutureFn(f_WhenFn(Var_X)),attribute(Var_P,inst_Dead)))))))))))).

fof(axMidLem579, axiom, 
 ( ! [Var_X] : 
 (hasType(type_VehicleAttack, Var_X) => 
(( ? [Var_V] : 
 (hasType(type_TransportationDevice, Var_V) &  
(f_instrument(Var_X,Var_V)))))))).

fof(axMidLem580, axiom, 
 ( ! [Var_X] : 
 (hasType(type_BusStop, Var_X) => 
(( ? [Var_R] : 
 (hasType(type_Roadway, Var_R) &  
(f_meetsSpatially(Var_X,Var_R)))))))).

fof(axMidLem581, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Burrow, Var_B) => 
(( ? [Var_A] : 
 (hasType(type_Organism, Var_A) &  
(f_hasPurpose(Var_B,inhabits(Var_A,Var_B))))))))).

fof(axMidLem582, axiom, 
 ( ! [Var_X] : 
 ((hasType(type_Object, Var_X) & hasType(type_Agent, Var_X)) => 
(((f_attribute(Var_X,inst_Musician)) => (f_hasSkill(type_MusicalPerformance,Var_X))))))).

fof(axMidLem583, axiom, 
 ( ! [Var_H] : 
 (hasType(type_Object, Var_H) => 
(( ! [Var_T1] : 
 ((hasType(type_TimePosition, Var_T1) & hasType(type_Physical, Var_T1)) => 
(((f_holdsDuring(Var_T1,attribute(Var_H,inst_Veteran))) => (( ? [Var_P] : 
 (hasType(type_Soldier, Var_P) &  
(( ? [Var_T2] : 
 (hasType(type_TimePosition, Var_T2) &  
(((f_temporalPart(Var_T2,f_PastFn(f_WhenFn(Var_T1)))) & (((f_holdsDuring(Var_T2,attribute(Var_H,Var_P))) & (( ~ (f_holdsDuring(Var_T1,attribute(Var_H,Var_P))))))))))))))))))))))).

fof(axMidLem584, axiom, 
 ( ! [Var_X] : 
 (hasType(type_Checkpoint, Var_X) => 
(((( ? [Var_ROAD] : 
 (hasType(type_Road, Var_ROAD) &  
(f_orientation(Var_ROAD,Var_X,inst_Near))))) | (( ? [Var_REG2] : 
 (hasType(type_GeographicArea, Var_REG2) &  
(( ? [Var_REG1] : 
 (hasType(type_GeographicArea, Var_REG1) &  
(f_orientation(f_BorderFn(Var_REG1,Var_REG2),Var_X,inst_Near))))))))))))).

fof(axMidLem585, axiom, 
 ( ! [Var_P] : 
 ((hasType(type_Object, Var_P) & hasType(type_Human, Var_P)) => 
(( ! [Var_NOW] : 
 ((hasType(type_TimePosition, Var_NOW) & hasType(type_TimeInterval, Var_NOW)) => 
(((f_holdsDuring(Var_NOW,attribute(Var_P,inst_Widowed))) => (((( ? [Var_SPOUSE] : 
 ((hasType(type_Human, Var_SPOUSE) & hasType(type_Object, Var_SPOUSE)) &  
(( ? [Var_BEFORE] : 
 ((hasType(type_TimeInterval, Var_BEFORE) & hasType(type_TimePosition, Var_BEFORE)) &  
(((f_earlier(Var_BEFORE,Var_NOW)) & (((f_holdsDuring(Var_BEFORE,spouse(Var_SPOUSE,Var_P))) & (f_holdsDuring(Var_NOW,attribute(Var_SPOUSE,inst_Dead))))))))))))) & (( ~ ( ? [Var_OTHER] : 
 (hasType(type_Human, Var_OTHER) &  
(f_holdsDuring(Var_NOW,spouse(Var_OTHER,Var_P))))))))))))))))).

fof(axMidLem586, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Convoy, Var_C) => 
(( ! [Var_VEH] : 
 ((hasType(type_SelfConnectedObject, Var_VEH) & hasType(type_Entity, Var_VEH)) => 
(((f_member(Var_VEH,Var_C)) => (( ? [Var_DRIVE] : 
 (hasType(type_Driving, Var_DRIVE) &  
(((f_overlapsTemporally(f_WhenFn(Var_DRIVE),f_WhenFn(Var_C))) & (f_patient(Var_DRIVE,Var_VEH))))))))))))))).

fof(axMidLem587, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Convoy, Var_C) => 
(f_attribute(Var_C,inst_LineFormation))))).

fof(axMidLem588, axiom, 
 ( ! [Var_X] : 
 (hasType(type_EmbassyBuilding, Var_X) => 
(( ? [Var_EGOV] : 
 (hasType(type_Nation, Var_EGOV) &  
(( ? [Var_OTHERGOV] : 
 (hasType(type_Nation, Var_OTHERGOV) &  
(((Var_EGOV != Var_OTHERGOV) & (((f_possesses(Var_EGOV,Var_X)) & (f_located(Var_X,Var_OTHERGOV))))))))))))))).

fof(axMidLem589, axiom, 
 ( ! [Var_N] : 
 (hasType(type_EuropeanNation, Var_N) => 
(f_part(Var_N,inst_Europe))))).

fof(axMidLem590, axiom, 
 ( ! [Var_X] : 
 (hasType(type_GovernmentBuilding, Var_X) => 
(( ? [Var_G] : 
 (hasType(type_Government, Var_G) &  
(f_possesses(Var_G,Var_X)))))))).

fof(axMidLem591, axiom, 
 ( ! [Var_X] : 
 ((hasType(type_Object, Var_X) & hasType(type_CognitiveAgent, Var_X)) => 
(( ! [Var_T1] : 
 (hasType(type_TimePosition, Var_T1) => 
(((f_holdsDuring(Var_T1,attribute(Var_X,inst_GovernmentPerson))) => (( ? [Var_GOV] : 
 (hasType(type_Government, Var_GOV) &  
(f_holdsDuring(Var_T1,employs(Var_GOV,Var_X)))))))))))))).

fof(axMidLem592, axiom, 
 ( ! [Var_R] : 
 (hasType(type_Renting, Var_R) => 
(( ! [Var_O] : 
 ((hasType(type_Entity, Var_O) & hasType(type_Agent, Var_O)) => 
(( ! [Var_A] : 
 ((hasType(type_Agent, Var_A) & hasType(type_Object, Var_A)) => 
(((((f_agent(Var_R,Var_A)) & (f_patient(Var_R,Var_O)))) => (f_holdsDuring(f_WhenFn(Var_R),modalAttribute(uses(Var_A,Var_O),inst_Permission)))))))))))))).

fof(axMidLem593, axiom, 
 ( ! [Var_X] : 
 ((hasType(type_Object, Var_X) & hasType(type_SelfConnectedObject, Var_X)) => 
(( ! [Var_T1] : 
 (hasType(type_TimePosition, Var_T1) => 
(((f_holdsDuring(Var_T1,attribute(Var_X,inst_MilitaryPerson))) => (( ? [Var_ORG] : 
 (hasType(type_MilitaryOrganization, Var_ORG) &  
(f_holdsDuring(Var_T1,member(Var_X,Var_ORG)))))))))))))).

fof(axMidLem594, axiom, 
 ( ! [Var_ORG] : 
 (hasType(type_MilitaryOrganization, Var_ORG) => 
(( ! [Var_X] : 
 (hasType(type_Human, Var_X) => 
(( ! [Var_T1] : 
 (hasType(type_TimePosition, Var_T1) => 
(((f_holdsDuring(Var_T1,member(Var_X,Var_ORG))) => (f_holdsDuring(Var_T1,attribute(Var_X,inst_MilitaryPerson)))))))))))))).

fof(axMidLem595, axiom, 
 ( ! [Var_X] : 
 (hasType(type_EducationalFacility, Var_X) => 
(( ? [Var_ORG] : 
 (hasType(type_EducationalOrganization, Var_ORG) &  
(f_possesses(Var_ORG,Var_X)))))))).

fof(axMidLem596, axiom, 
 ( ! [Var_X] : 
 ((hasType(type_Object, Var_X) & hasType(type_Entity, Var_X)) => 
(((f_attribute(Var_X,inst_Student)) => (( ? [Var_EV] : 
 (hasType(type_EducationalProcess, Var_EV) &  
(f_patient(Var_EV,Var_X)))))))))).

fof(axMidLem597, axiom, 
 ( ! [Var_X] : 
 (hasType(type_Subway, Var_X) => 
(( ? [Var_SURF] : 
 ((hasType(type_SelfConnectedObject, Var_SURF) & hasType(type_Object, Var_SURF)) &  
(((f_surface(Var_SURF,inst_PlanetEarth)) & (f_orientation(Var_X,Var_SURF,inst_Below)))))))))).

fof(axMidLem598, axiom, 
 ( ! [Var_X] : 
 (hasType(type_TerroristOrganization, Var_X) => 
(( ? [Var_EV] : 
 (hasType(type_ViolentContest, Var_EV) &  
(f_agent(Var_EV,Var_X)))))))).

fof(axMidLem599, axiom, 
 ( ! [Var_MEMBERS] : 
 ((hasType(type_Integer, Var_MEMBERS) & hasType(type_Quantity, Var_MEMBERS)) => 
(( ! [Var_SEATS] : 
 ((hasType(type_Integer, Var_SEATS) & hasType(type_Quantity, Var_SEATS)) => 
(( ! [Var_ORG] : 
 ((hasType(type_Organization, Var_ORG) & hasType(type_Collection, Var_ORG)) => 
(((((f_seatsInOrganizationCount(Var_ORG,Var_SEATS)) & (f_memberCount(Var_ORG,Var_MEMBERS)))) => (f_greaterThanOrEqualTo(Var_SEATS,Var_MEMBERS))))))))))))).

fof(axMidLem600, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_NonnegativeInteger, Var_NUMBER) & hasType(type_Integer, Var_NUMBER)) => 
(( ! [Var_TYPE] : 
 (hasType(type_SetOrClass, Var_TYPE) => 
(( ! [Var_GROUP] : 
 (hasType(type_Collection, Var_GROUP) => 
(((f_memberTypeCount(Var_GROUP,Var_TYPE,Var_NUMBER)) => (( ? [Var_SUBGROUP] : 
 (hasType(type_Collection, Var_SUBGROUP) &  
(((f_subCollection(Var_SUBGROUP,Var_GROUP)) & (((f_memberCount(Var_SUBGROUP,Var_NUMBER)) & (f_memberType(Var_SUBGROUP,Var_TYPE)))))))))))))))))))).

fof(axMidLem601, axiom, 
 ( ! [Var_NUMBER2] : 
 ((hasType(type_NonnegativeInteger, Var_NUMBER2) & hasType(type_Quantity, Var_NUMBER2)) => 
(( ! [Var_TYPE] : 
 (hasType(type_SetOrClass, Var_TYPE) => 
(( ! [Var_NUMBER1] : 
 ((hasType(type_Integer, Var_NUMBER1) & hasType(type_Quantity, Var_NUMBER1)) => 
(( ! [Var_GROUP] : 
 (hasType(type_Collection, Var_GROUP) => 
(((((f_memberCount(Var_GROUP,Var_NUMBER1)) & (f_memberTypeCount(Var_GROUP,Var_TYPE,Var_NUMBER2)))) => (f_greaterThanOrEqualTo(Var_NUMBER1,Var_NUMBER2)))))))))))))))).

fof(axMidLem602, axiom, 
 ( ! [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) => 
(( ! [Var_COLLECTION] : 
 (hasType(type_Collection, Var_COLLECTION) => 
(( ! [Var_OBJ] : 
 (hasType(type_SelfConnectedObject, Var_OBJ) => 
(((f_memberAtTime(Var_OBJ,Var_COLLECTION,Var_TIME)) <=> (f_holdsDuring(Var_TIME,member(Var_OBJ,Var_COLLECTION)))))))))))))).

fof(axMidLem603, axiom, 
 ( ! [Var_OBJ] : 
 ((hasType(type_SelfConnectedObject, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(( ! [Var_PLACE] : 
 (hasType(type_Object, Var_PLACE) => 
(( ! [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) => 
(( ! [Var_COLLECTION] : 
 ((hasType(type_Object, Var_COLLECTION) & hasType(type_Collection, Var_COLLECTION)) => 
(((((f_locatedAtTime(Var_COLLECTION,Var_TIME,Var_PLACE)) & (f_memberAtTime(Var_OBJ,Var_COLLECTION,Var_TIME)))) => (f_locatedAtTime(Var_OBJ,Var_TIME,Var_PLACE)))))))))))))))).

fof(axMidLem604, axiom, 
 ( ! [Var_I] : 
 ((hasType(type_SelfConnectedObject, Var_I) & hasType(type_Entity, Var_I)) => 
(( ! [Var_C] : 
 (hasType(type_Collection, Var_C) => 
(( ! [Var_O] : 
 ((hasType(type_ContentBearingObject, Var_O) & hasType(type_Entity, Var_O)) => 
(((((f_inventory(Var_O,Var_C)) & (f_member(Var_I,Var_C)))) => (f_refers(Var_O,Var_I))))))))))))).

fof(axMidLem605, axiom, 
 ( ! [Var_PERSON2] : 
 (hasType(type_Human, Var_PERSON2) => 
(( ! [Var_PERSON1] : 
 ((hasType(type_Human, Var_PERSON1) & hasType(type_CognitiveAgent, Var_PERSON1)) => 
(( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(((f_subordinateInOrganization(Var_ORG,Var_PERSON1,Var_PERSON2)) => (f_employs(Var_ORG,Var_PERSON1))))))))))))).

fof(axMidLem606, axiom, 
 ( ! [Var_PERSON2] : 
 ((hasType(type_Human, Var_PERSON2) & hasType(type_CognitiveAgent, Var_PERSON2)) => 
(( ! [Var_PERSON1] : 
 (hasType(type_Human, Var_PERSON1) => 
(( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(((f_subordinateInOrganization(Var_ORG,Var_PERSON1,Var_PERSON2)) => (f_employs(Var_ORG,Var_PERSON2))))))))))))).

fof(axMidLem607, axiom, 
 ( ! [Var_PERSON1] : 
 (hasType(type_Human, Var_PERSON1) => 
(( ! [Var_ROLE2] : 
 (hasType(type_Position, Var_ROLE2) => 
(( ! [Var_ROLE1] : 
 (hasType(type_Position, Var_ROLE1) => 
(( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(((((f_subordinatePosition(Var_ORG,Var_ROLE1,Var_ROLE2)) & (f_occupiesPosition(Var_PERSON1,Var_ROLE1,Var_ORG)))) => (( ? [Var_PERSON2] : 
 (hasType(type_Human, Var_PERSON2) &  
(((f_occupiesPosition(Var_PERSON2,Var_ROLE2,Var_ORG)) & (f_subordinateInOrganization(Var_ORG,Var_PERSON1,Var_PERSON2))))))))))))))))))))).

fof(axMidLem608, axiom, 
 ( ! [Var_ONT] : 
 (hasType(type_Ontology, Var_ONT) => 
(( ? [Var_TAX] : 
 (hasType(type_Taxonomy, Var_TAX) &  
(f_abstractPart(Var_TAX,Var_ONT)))))))).

fof(axMidLem609, axiom, 
 ( ! [Var_EVENT] : 
 (hasType(type_ServiceProcess, Var_EVENT) => 
(( ? [Var_PROVIDER] : 
 (hasType(type_CognitiveAgent, Var_PROVIDER) &  
(f_serviceProvider(Var_EVENT,Var_PROVIDER)))))))).

fof(axMidLem610, axiom, 
 ( ! [Var_EVENT] : 
 (hasType(type_ServiceProcess, Var_EVENT) => 
(( ? [Var_RECEIVER] : 
 (hasType(type_CognitiveAgent, Var_RECEIVER) &  
(f_serviceRecipient(Var_EVENT,Var_RECEIVER)))))))).

fof(axMidLem611, axiom, 
 ( ! [Var_AGENT] : 
 ((hasType(type_Physical, Var_AGENT) & hasType(type_Agent, Var_AGENT)) => 
(( ! [Var_AGENT_END] : 
 ((hasType(type_Entity, Var_AGENT_END) & hasType(type_TimePoint, Var_AGENT_END)) => 
(( ! [Var_PROCESS] : 
 ((hasType(type_Physical, Var_PROCESS) & hasType(type_Process, Var_PROCESS)) => 
(( ! [Var_PROCESS_START] : 
 ((hasType(type_Entity, Var_PROCESS_START) & hasType(type_TimePoint, Var_PROCESS_START)) => 
(((((Var_PROCESS_START = f_BeginFn(f_WhenFn(Var_PROCESS))) & (((Var_AGENT_END = f_EndFn(f_WhenFn(Var_AGENT))) & (f_benefits(Var_PROCESS,Var_AGENT)))))) => (f_before(Var_PROCESS_START,Var_AGENT_END)))))))))))))))).

fof(axMidLem612, axiom, 
 ( ! [Var_PARENT] : 
 (hasType(type_Man, Var_PARENT) => 
(( ! [Var_CHILD] : 
 (hasType(type_Organism, Var_CHILD) => 
(((f_parent(Var_CHILD,Var_PARENT)) => (f_father(Var_CHILD,Var_PARENT)))))))))).

fof(axMidLem613, axiom, 
 ( ! [Var_PARENT] : 
 (hasType(type_Woman, Var_PARENT) => 
(( ! [Var_CHILD] : 
 (hasType(type_Organism, Var_CHILD) => 
(((f_parent(Var_CHILD,Var_PARENT)) => (f_mother(Var_CHILD,Var_PARENT)))))))))).

fof(axMidLem614, axiom, 
 ( ! [Var_CHILD] : 
 (hasType(type_Man, Var_CHILD) => 
(( ! [Var_PARENT] : 
 (hasType(type_Organism, Var_PARENT) => 
(((f_parent(Var_CHILD,Var_PARENT)) => (f_son(Var_CHILD,Var_PARENT)))))))))).

fof(axMidLem615, axiom, 
 ( ! [Var_CHILD] : 
 (hasType(type_Woman, Var_CHILD) => 
(( ! [Var_PARENT] : 
 (hasType(type_Organism, Var_PARENT) => 
(((f_parent(Var_CHILD,Var_PARENT)) => (f_daughter(Var_CHILD,Var_PARENT)))))))))).

fof(axMidLem616, axiom, 
 ( ! [Var_H] : 
 ((hasType(type_Human, Var_H) & hasType(type_Organism, Var_H)) => 
(( ! [Var_A] : 
 (hasType(type_Woman, Var_A) => 
(((f_aunt(Var_A,Var_H)) <=> (( ? [Var_P] : 
 ((hasType(type_Human, Var_P) & hasType(type_Organism, Var_P)) &  
(((f_sister(Var_A,Var_P)) & (f_parent(Var_H,Var_P))))))))))))))).

fof(axMidLem617, axiom, 
 ( ! [Var_P2] : 
 ((hasType(type_Human, Var_P2) & hasType(type_Organism, Var_P2)) => 
(( ! [Var_P1] : 
 ((hasType(type_Human, Var_P1) & hasType(type_Organism, Var_P1)) => 
(((f_cousin(Var_P1,Var_P2)) <=> (((( ? [Var_G2] : 
 (hasType(type_Man, Var_G2) &  
(( ? [Var_G1] : 
 (hasType(type_Woman, Var_G1) &  
(((f_grandmother(Var_P1,Var_G1)) & (((f_grandfather(Var_P1,Var_G2)) & (((f_grandmother(Var_P2,Var_G1)) & (f_grandfather(Var_P2,Var_G2)))))))))))))) & (( ~ ( ? [Var_F] : 
 (hasType(type_Organism, Var_F) &  
(( ? [Var_M] : 
 (hasType(type_Organism, Var_M) &  
(((f_mother(Var_P1,Var_M)) & (((f_father(Var_P1,Var_F)) & (((f_mother(Var_P2,Var_M)) & (f_father(Var_P2,Var_F))))))))))))))))))))))))).

fof(axMidLem618, axiom, 
 ( ! [Var_P] : 
 ((hasType(type_Man, Var_P) & hasType(type_Organism, Var_P)) => 
(( ! [Var_H] : 
 ((hasType(type_Human, Var_H) & hasType(type_Organism, Var_H)) => 
(((f_grandfather(Var_H,Var_P)) => (( ? [Var_C] : 
 (hasType(type_Organism, Var_C) &  
(((f_father(Var_C,Var_P)) & (f_parent(Var_H,Var_C))))))))))))))).

fof(axMidLem619, axiom, 
 ( ! [Var_P] : 
 ((hasType(type_Woman, Var_P) & hasType(type_Organism, Var_P)) => 
(( ! [Var_H] : 
 ((hasType(type_Human, Var_H) & hasType(type_Organism, Var_H)) => 
(((f_grandmother(Var_H,Var_P)) => (( ? [Var_C] : 
 (hasType(type_Organism, Var_C) &  
(((f_mother(Var_C,Var_P)) & (f_parent(Var_H,Var_C))))))))))))))).

fof(axMidLem620, axiom, 
 ( ! [Var_H] : 
 ((hasType(type_Human, Var_H) & hasType(type_Organism, Var_H)) => 
(( ! [Var_N] : 
 ((hasType(type_Man, Var_N) & hasType(type_Organism, Var_N)) => 
(((f_nephew(Var_N,Var_H)) <=> (( ? [Var_S] : 
 (hasType(type_Organism, Var_S) &  
(((f_sibling(Var_S,Var_H)) & (f_son(Var_N,Var_S))))))))))))))).

fof(axMidLem621, axiom, 
 ( ! [Var_H] : 
 ((hasType(type_Human, Var_H) & hasType(type_Organism, Var_H)) => 
(( ! [Var_N] : 
 ((hasType(type_Woman, Var_N) & hasType(type_Organism, Var_N)) => 
(((f_niece(Var_N,Var_H)) <=> (( ? [Var_S] : 
 (hasType(type_Organism, Var_S) &  
(((f_sibling(Var_S,Var_H)) & (f_daughter(Var_N,Var_S))))))))))))))).

fof(axMidLem622, axiom, 
 ( ! [Var_H] : 
 ((hasType(type_Human, Var_H) & hasType(type_Organism, Var_H)) => 
(( ! [Var_U] : 
 (hasType(type_Man, Var_U) => 
(((f_uncle(Var_U,Var_H)) <=> (( ? [Var_P] : 
 ((hasType(type_Human, Var_P) & hasType(type_Organism, Var_P)) &  
(((f_brother(Var_U,Var_P)) & (f_parent(Var_H,Var_P))))))))))))))).

fof(axMidLem623, axiom, 
 ( ! [Var_F] : 
 ((hasType(type_Man, Var_F) & hasType(type_Human, Var_F) & hasType(type_Organism, Var_F)) => 
(( ! [Var_P] : 
 ((hasType(type_Human, Var_P) & hasType(type_Organism, Var_P)) => 
(((f_stepfather(Var_P,Var_F)) <=> (( ? [Var_M] : 
 ((hasType(type_Organism, Var_M) & hasType(type_Human, Var_M)) &  
(((f_mother(Var_P,Var_M)) & (((f_spouse(Var_F,Var_M)) & (( ~ (f_father(Var_P,Var_F))))))))))))))))))).

fof(axMidLem624, axiom, 
 ( ! [Var_M] : 
 ((hasType(type_Woman, Var_M) & hasType(type_Human, Var_M) & hasType(type_Organism, Var_M)) => 
(( ! [Var_P] : 
 ((hasType(type_Human, Var_P) & hasType(type_Organism, Var_P)) => 
(((f_stepmother(Var_P,Var_M)) <=> (( ? [Var_F] : 
 ((hasType(type_Organism, Var_F) & hasType(type_Human, Var_F)) &  
(((f_father(Var_P,Var_F)) & (((f_spouse(Var_M,Var_F)) & (( ~ (f_mother(Var_P,Var_M))))))))))))))))))).

fof(axMidLem625, axiom, 
 ( ! [Var_PLACE] : 
 (hasType(type_Object, Var_PLACE) => 
(( ! [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Object, Var_OBJ) & hasType(type_Physical, Var_OBJ)) => 
(((f_locatedAtTime(Var_OBJ,Var_TIME,Var_PLACE)) <=> (f_holdsDuring(Var_TIME,located(Var_OBJ,Var_PLACE)))))))))))))).

fof(axMidLem626, axiom, 
 ( ! [Var_REGION] : 
 ((hasType(type_GeographicArea, Var_REGION) & hasType(type_Object, Var_REGION)) => 
(( ! [Var_PLACE] : 
 ((hasType(type_Object, Var_PLACE) & hasType(type_GeographicArea, Var_PLACE)) => 
(( ! [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) => 
(( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(((((f_locatedAtTime(Var_OBJ,Var_TIME,Var_PLACE)) & (f_geographicSubregion(Var_PLACE,Var_REGION)))) => (f_locatedAtTime(Var_OBJ,Var_TIME,Var_REGION)))))))))))))))).

fof(axMidLem627, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Seating, Var_S) => 
(( ? [Var_P] : 
 (hasType(type_Seat, Var_P) &  
(( ? [Var_H] : 
 (hasType(type_Human, Var_H) &  
(((f_experiencer(Var_S,Var_H)) & (f_destination(Var_S,Var_P))))))))))))).

fof(axMidLem628, axiom, 
 ( ! [Var_ARREST] : 
 (hasType(type_PlacingUnderArrest, Var_ARREST) => 
(( ! [Var_AGENT] : 
 (hasType(type_GroupOfPeople, Var_AGENT) => 
(( ! [Var_MEMBER] : 
 ((hasType(type_SelfConnectedObject, Var_MEMBER) & hasType(type_Agent, Var_MEMBER)) => 
(((((f_arrested(Var_ARREST,Var_AGENT)) & (f_member(Var_MEMBER,Var_AGENT)))) => (( ? [Var_ARREST1] : 
 (hasType(type_PlacingUnderArrest, Var_ARREST1) &  
(((f_arrested(Var_ARREST1,Var_MEMBER)) & (f_subProcess(Var_ARREST1,Var_ARREST)))))))))))))))))).

fof(axMidLem629, axiom, 
 ( ! [Var_PROC] : 
 (hasType(type_Process, Var_PROC) => 
(( ! [Var_SUB] : 
 ((hasType(type_Process, Var_SUB) & hasType(type_Physical, Var_SUB)) => 
(( ! [Var_LOC] : 
 (hasType(type_Object, Var_LOC) => 
(((((f_located(Var_PROC,Var_LOC)) & (f_subProcess(Var_SUB,Var_PROC)))) => (f_located(Var_SUB,Var_LOC))))))))))))).

fof(axMidLem630, axiom, 
 ( ! [Var_IMPRISON] : 
 (hasType(type_Imprisoning, Var_IMPRISON) => 
(( ! [Var_AGENT] : 
 (hasType(type_Human, Var_AGENT) => 
(( ! [Var_INTERVAL] : 
 (hasType(type_TimeInterval, Var_INTERVAL) => 
(((((f_detainee(Var_IMPRISON,Var_AGENT)) & (f_time(Var_IMPRISON,Var_INTERVAL)))) => (( ? [Var_ARREST] : 
 (hasType(type_PlacingUnderArrest, Var_ARREST) &  
(( ? [Var_TIME] : 
 (hasType(type_TimeInterval, Var_TIME) &  
(((f_time(Var_ARREST,Var_TIME)) & (((f_earlier(Var_TIME,Var_INTERVAL)) & (f_arrested(Var_ARREST,Var_AGENT))))))))))))))))))))))).

fof(axMidLem631, axiom, 
 ( ! [Var_TRANSPORT] : 
 (hasType(type_TransportViaRoadVehicle, Var_TRANSPORT) => 
(( ? [Var_DRIVING] : 
 (hasType(type_Driving, Var_DRIVING) &  
(f_subProcess(Var_TRANSPORT,Var_DRIVING)))))))).

fof(axMidLem632, axiom, 
 ( ! [Var_TRANSPORT] : 
 (hasType(type_Transportation, Var_TRANSPORT) => 
(( ! [Var_DRIVE] : 
 (hasType(type_Driving, Var_DRIVE) => 
(( ! [Var_VEHICLE] : 
 (hasType(type_TransportationDevice, Var_VEHICLE) => 
(((((f_subProcess(Var_TRANSPORT,Var_DRIVE)) & (f_instrument(Var_TRANSPORT,Var_VEHICLE)))) => (f_patient(Var_DRIVE,Var_VEHICLE))))))))))))).

fof(axMidLem633, axiom, 
 ( ! [Var_DRIVE] : 
 (hasType(type_Driving, Var_DRIVE) => 
(( ! [Var_VEHICLE] : 
 (hasType(type_RoadVehicle, Var_VEHICLE) => 
(((f_patient(Var_DRIVE,Var_VEHICLE)) => (( ? [Var_TRANSPORT] : 
 (hasType(type_TransportViaRoadVehicle, Var_TRANSPORT) &  
(f_subProcess(Var_TRANSPORT,Var_DRIVE))))))))))))).

fof(axMidLem634, axiom, 
 ( ! [Var_DRIVING] : 
 (hasType(type_Driving, Var_DRIVING) => 
(( ! [Var_TRANSPORT] : 
 (hasType(type_Transportation, Var_TRANSPORT) => 
(( ! [Var_DRIVER] : 
 ((hasType(type_Agent, Var_DRIVER) & hasType(type_Object, Var_DRIVER)) => 
(((((f_subProcess(Var_TRANSPORT,Var_DRIVING)) & (f_agent(Var_DRIVING,Var_DRIVER)))) => (f_transported(Var_TRANSPORT,Var_DRIVER))))))))))))).

fof(axMidLem635, axiom, 
 ( ! [Var_DRIVING] : 
 (hasType(type_Driving, Var_DRIVING) => 
(( ! [Var_TRANSPORT] : 
 (hasType(type_Transportation, Var_TRANSPORT) => 
(( ! [Var_DEST] : 
 (hasType(type_Entity, Var_DEST) => 
(((((f_subProcess(Var_TRANSPORT,Var_DRIVING)) & (f_destination(Var_DRIVING,Var_DEST)))) => (f_destination(Var_TRANSPORT,Var_DEST))))))))))))).

fof(axMidLem636, axiom, 
 ( ! [Var_DRIVING] : 
 (hasType(type_Driving, Var_DRIVING) => 
(( ! [Var_TRANSPORT] : 
 (hasType(type_Transportation, Var_TRANSPORT) => 
(( ! [Var_VEHICLE] : 
 (hasType(type_Vehicle, Var_VEHICLE) => 
(((((f_subProcess(Var_TRANSPORT,Var_DRIVING)) & (f_patient(Var_DRIVING,Var_VEHICLE)))) => (f_conveyance(Var_TRANSPORT,Var_VEHICLE))))))))))))).

fof(axMidLem637, axiom, 
 ( ! [Var_A] : 
 (hasType(type_Atrophy, Var_A) => 
(( ? [Var_B] : 
 (hasType(type_BodyPart, Var_B) &  
(f_experiencer(Var_A,Var_B)))))))).

fof(axMidLem638, axiom, 
 ( ! [Var_L] : 
 (hasType(type_Lengthening, Var_L) => 
(( ! [Var_O] : 
 ((hasType(type_Entity, Var_O) & hasType(type_Object, Var_O)) => 
(((f_patient(Var_L,Var_O)) => (( ? [Var_L2] : 
 ((hasType(type_PhysicalQuantity, Var_L2) & hasType(type_Quantity, Var_L2)) &  
(( ? [Var_L1] : 
 ((hasType(type_PhysicalQuantity, Var_L1) & hasType(type_Quantity, Var_L1)) &  
(((f_holdsDuring(f_BeginFn(f_WhenFn(Var_L)),length(Var_O,Var_L1))) & (((f_holdsDuring(f_EndFn(f_WhenFn(Var_L)),length(Var_O,Var_L2))) & (f_greaterThan(Var_L2,Var_L1)))))))))))))))))))).

fof(axMidLem639, axiom, 
 ( ! [Var_S] : 
 (hasType(type_Saving, Var_S) => 
(( ! [Var_A] : 
 (hasType(type_Agent, Var_A) => 
(( ! [Var_O] : 
 ((hasType(type_Entity, Var_O) & hasType(type_Physical, Var_O) & hasType(type_Object, Var_O)) => 
(((((f_patient(Var_S,Var_O)) & (f_agent(Var_S,Var_A)))) => (( ? [Var_Q2] : 
 ((hasType(type_CurrencyMeasure, Var_Q2) & hasType(type_Quantity, Var_Q2)) &  
(( ? [Var_Q1] : 
 ((hasType(type_CurrencyMeasure, Var_Q1) & hasType(type_Quantity, Var_Q1)) &  
(((f_holdsDuring(f_BeginFn(f_WhenFn(Var_S)),monetaryValue(Var_O,Var_Q1))) & (((f_holdsDuring(f_EndFn(f_WhenFn(Var_S)),monetaryValue(Var_O,Var_Q2))) & (((f_possesses(Var_A,Var_O)) & (f_lessThan(Var_Q1,Var_Q2))))))))))))))))))))))))).

fof(axMidLem640, axiom, 
 ( ! [Var_A] : 
 ((hasType(type_Object, Var_A) & hasType(type_Physical, Var_A)) => 
(( ! [Var_P] : 
 (hasType(type_Agent, Var_P) => 
(((f_financialAsset(Var_P,Var_A)) => (( ? [Var_V] : 
 (hasType(type_CurrencyMeasure, Var_V) &  
(f_monetaryValue(Var_A,Var_V))))))))))))).

fof(axMidLem641, axiom, 
 ( ! [Var_B] : 
 (hasType(type_Barking, Var_B) => 
(( ? [Var_D] : 
 (hasType(type_Canine, Var_D) &  
(f_agent(Var_B,Var_D)))))))).

fof(axMidLem642, axiom, 
 ( ! [Var_P] : 
 (hasType(type_Organification, Var_P) => 
(( ? [Var_O] : 
 (hasType(type_Organ, Var_O) &  
(f_result(Var_P,Var_O)))))))).

fof(axMidLem643, axiom, 
 ( ! [Var_SR] : 
 (hasType(type_SexualReproduction, Var_SR) => 
(( ? [Var_C] : 
 (hasType(type_BiologicalConception, Var_C) &  
(f_subProcess(Var_C,Var_SR)))))))).

fof(axMidLem644, axiom, 
 ( ! [Var_E] : 
 (hasType(type_BirdEgg, Var_E) => 
(( ? [Var_SR] : 
 (hasType(type_SexualReproduction, Var_SR) &  
(( ? [Var_B] : 
 (hasType(type_Bird, Var_B) &  
(((f_agent(Var_SR,Var_B)) & (f_result(Var_SR,Var_E))))))))))))).

fof(axMidLem645, axiom, 
 ( ! [Var_R] : 
 (hasType(type_Raping, Var_R) => 
(( ? [Var_A] : 
 ((hasType(type_Entity, Var_A) & hasType(type_CognitiveAgent, Var_A)) &  
(((f_experiencer(Var_R,Var_A)) & (( ~ (f_wants(Var_A,Var_R)))))))))))).

fof(axMidLem646, axiom, 
 ( ! [Var_PLACE] : 
 (hasType(type_Object, Var_PLACE) => 
(( ! [Var_INDIV] : 
 ((hasType(type_Animal, Var_INDIV) & hasType(type_Entity, Var_INDIV)) => 
(((f_birthplace(Var_INDIV,Var_PLACE)) => (( ? [Var_BIRTH] : 
 (hasType(type_Birth, Var_BIRTH) &  
(((f_experiencer(Var_BIRTH,Var_INDIV)) & (f_located(Var_BIRTH,Var_PLACE))))))))))))))).

fof(axMidLem647, axiom, 
 ( ! [Var_D] : 
 (hasType(type_Day, Var_D) => 
(( ! [Var_P] : 
 ((hasType(type_Human, Var_P) & hasType(type_Entity, Var_P)) => 
(((f_birthdate(Var_P,Var_D)) => (( ? [Var_B] : 
 (hasType(type_Birth, Var_B) &  
(((f_experiencer(Var_B,Var_P)) & (f_date(Var_B,Var_D))))))))))))))).

fof(axMidLem648, axiom, 
 ( ! [Var_T] : 
 (hasType(type_Day, Var_T) => 
(( ! [Var_P] : 
 ((hasType(type_Human, Var_P) & hasType(type_Entity, Var_P)) => 
(((f_deathdate(Var_P,Var_T)) => (( ? [Var_D] : 
 (hasType(type_Death, Var_D) &  
(((f_experiencer(Var_D,Var_P)) & (f_date(Var_D,Var_T))))))))))))))).

fof(axMidLem649, axiom, 
 ( ! [Var_L] : 
 (hasType(type_Object, Var_L) => 
(( ! [Var_P] : 
 ((hasType(type_Animal, Var_P) & hasType(type_Entity, Var_P)) => 
(((f_deathplace(Var_P,Var_L)) => (( ? [Var_D] : 
 (hasType(type_Death, Var_D) &  
(((f_experiencer(Var_D,Var_P)) & (f_located(Var_D,Var_L))))))))))))))).

fof(axMidLem650, axiom, 
 ( ! [Var_S] : 
 (hasType(type_TransitSystem, Var_S) => 
(( ! [Var_P] : 
 ((hasType(type_Transitway, Var_P) & hasType(type_Object, Var_P)) => 
(((f_pathInSystem(Var_P,Var_S)) => (((f_routeInSystem(Var_P,Var_S)) | (( ? [Var_R2] : 
 ((hasType(type_Transitway, Var_R2) & hasType(type_Object, Var_R2)) &  
(( ? [Var_R1] : 
 ((hasType(type_Transitway, Var_R1) & hasType(type_Object, Var_R1)) &  
(((f_routeInSystem(Var_R1,Var_S)) & (((f_routeInSystem(Var_R2,Var_S)) & (((f_part(Var_R1,Var_P)) & (((f_part(Var_R2,Var_P)) & (f_connected(Var_R1,Var_R2)))))))))))))))))))))))))).

fof(axMidLem651, axiom, 
 ( ! [Var_P] : 
 (hasType(type_Transitway, Var_P) => 
(( ! [Var_T] : 
 ((hasType(type_PhysicalSystem, Var_T) & hasType(type_TransitSystem, Var_T)) => 
(( ! [Var_S] : 
 ((hasType(type_PhysicalSystem, Var_S) & hasType(type_TransitSystem, Var_S)) => 
(((((f_subSystem(Var_S,Var_T)) & (f_routeInSystem(Var_P,Var_S)))) => (f_routeInSystem(Var_P,Var_T))))))))))))).

