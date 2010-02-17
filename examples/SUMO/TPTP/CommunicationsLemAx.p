fof(axCommLem0, axiom, 
 ( ! [Var_DEVICE] : 
 (hasType(type_CommunicationDevice, Var_DEVICE) => 
(( ! [Var_COMMUNICATION] : 
 (hasType(type_Communication, Var_COMMUNICATION) => 
(f_instrument(Var_COMMUNICATION,Var_DEVICE)))))))).

fof(axCommLem1, axiom, 
 ( ! [Var_SYSTEM] : 
 (hasType(type_TelephoneSystem, Var_SYSTEM) => 
(( ? [Var_PHONE] : 
 (hasType(type_Telephone, Var_PHONE) &  
(f_engineeringSubcomponent(Var_PHONE,Var_SYSTEM)))))))).

fof(axCommLem2, axiom, 
 ( ! [Var_SYSTEM] : 
 (hasType(type_TelephoneSystem, Var_SYSTEM) => 
(( ? [Var_LINE] : 
 (hasType(type_MainTelephoneLine, Var_LINE) &  
(f_engineeringSubcomponent(Var_LINE,Var_SYSTEM)))))))).

fof(axCommLem3, axiom, 
 ( ! [Var_SAT] : 
 (hasType(type_CommunicationSatellite, Var_SAT) => 
(( ? [Var_SYSTEM] : 
 (hasType(type_CommunicationSystem, Var_SYSTEM) &  
(f_engineeringSubcomponent(Var_SAT,Var_SYSTEM)))))))).

fof(axCommLem4, axiom, 
 ( ! [Var_SYSTEM] : 
 (hasType(type_RadioSystem, Var_SYSTEM) => 
(( ? [Var_DEVICE] : 
 (hasType(type_RadioReceiver, Var_DEVICE) &  
(f_engineeringSubcomponent(Var_DEVICE,Var_SYSTEM)))))))).

fof(axCommLem5, axiom, 
 ( ! [Var_SYSTEM] : 
 (hasType(type_TelevisionSystem, Var_SYSTEM) => 
(( ? [Var_STATION] : 
 (hasType(type_TelevisionStation, Var_STATION) &  
(f_engineeringSubcomponent(Var_STATION,Var_SYSTEM)))))))).

fof(axCommLem6, axiom, 
 ( ! [Var_SYSTEM] : 
 (hasType(type_TelevisionSystem, Var_SYSTEM) => 
(( ? [Var_DEVICE] : 
 (hasType(type_TelevisionReceiver, Var_DEVICE) &  
(f_engineeringSubcomponent(Var_DEVICE,Var_SYSTEM)))))))).

fof(axCommLem7, axiom, 
 ( ! [Var_SYSTEM] : 
 (hasType(type_CableTelevisionSystem, Var_SYSTEM) => 
(( ? [Var_DEVICE] : 
 (hasType(type_TelevisionReceiver, Var_DEVICE) &  
(f_engineeringSubcomponent(Var_DEVICE,Var_SYSTEM)))))))).

fof(axCommLem8, axiom, 
 ( ! [Var_PART] : 
 (hasType(type_InternetServiceProvider, Var_PART) => 
(f_engineeringSubcomponent(Var_PART,inst_Internet))))).

fof(axCommLem9, axiom, 
 ( ! [Var_INDIVIDUAL] : 
 ((hasType(type_Object, Var_INDIVIDUAL) & hasType(type_Agent, Var_INDIVIDUAL)) => 
(((f_attribute(Var_INDIVIDUAL,inst_InternetUser)) => (( ? [Var_PROCESS] : 
 (hasType(type_Process, Var_PROCESS) &  
(((f_agent(Var_PROCESS,Var_INDIVIDUAL)) & (f_instrument(Var_PROCESS,inst_Internet)))))))))))).

