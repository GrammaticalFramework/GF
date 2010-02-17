fof(axengineeringLem0, axiom, 
 ( ! [Var_MODELING] : 
 (hasType(type_Modeling, Var_MODELING) => 
(( ? [Var_MODEL] : 
 (hasType(type_Model, Var_MODEL) &  
(f_result(Var_MODELING,Var_MODEL)))))))).

fof(axengineeringLem1, axiom, 
 ( ! [Var_MODELING] : 
 (hasType(type_MultipoleModeling, Var_MODELING) => 
(( ? [Var_MODEL] : 
 (hasType(type_MultipoleModel, Var_MODEL) &  
(f_result(Var_MODELING,Var_MODEL)))))))).

fof(axengineeringLem2, axiom, 
 ( ! [Var_POLE] : 
 (hasType(type_MultipolePole, Var_POLE) => 
(( ! [Var_MULTIPOLE] : 
 (hasType(type_Abstract, Var_MULTIPOLE) => 
(((f_abstractPart(Var_POLE,Var_MULTIPOLE)) => (( ? [Var_SECTION] : 
 (hasType(type_MultipoleSection, Var_SECTION) &  
(((f_abstractPart(Var_POLE,Var_SECTION)) & (f_abstractPart(Var_SECTION,Var_MULTIPOLE))))))))))))))).

fof(axengineeringLem3, axiom, 
 ( ! [Var_DTHROUGH] : 
 (hasType(type_PhysicalDimension, Var_DTHROUGH) => 
(( ! [Var_DACROSS] : 
 (hasType(type_PhysicalDimension, Var_DACROSS) => 
(( ! [Var_QTHROUGH] : 
 (hasType(type_MultipoleQuantity, Var_QTHROUGH) => 
(( ! [Var_QACROSS] : 
 (hasType(type_MultipoleQuantity, Var_QACROSS) => 
(( ! [Var_THROUGH] : 
 (hasType(type_MultipoleVariable, Var_THROUGH) => 
(( ! [Var_ACROSS] : 
 (hasType(type_MultipoleVariable, Var_ACROSS) => 
(( ! [Var_POLE] : 
 (hasType(type_MultipolePole, Var_POLE) => 
(((((f_hasAcrossVariable(Var_POLE,Var_ACROSS)) & (((f_hasThroughVariable(Var_POLE,Var_THROUGH)) & (((f_hasVariable(Var_QACROSS,Var_ACROSS)) & (((f_hasVariable(Var_QTHROUGH,Var_THROUGH)) & (((f_hasDimension(Var_QACROSS,Var_DACROSS)) & (f_hasDimension(Var_QTHROUGH,Var_DTHROUGH)))))))))))) => (( ? [Var_DOMAIN] : 
 (hasType(type_PhysicalDomain, Var_DOMAIN) &  
(f_physicalDomain(Var_DACROSS,Var_DTHROUGH,Var_DOMAIN)))))))))))))))))))))))))))).

fof(axengineeringLem4, axiom, 
 ( ! [Var_MULTIPOLE] : 
 (hasType(type_Multipole, Var_MULTIPOLE) => 
(( ? [Var_SECTION] : 
 (hasType(type_MultipoleSection, Var_SECTION) &  
(f_abstractPart(Var_SECTION,Var_MULTIPOLE)))))))).

fof(axengineeringLem5, axiom, 
 ( ! [Var_SECTION] : 
 (hasType(type_MultipoleSection, Var_SECTION) => 
(( ? [Var_POLE1] : 
 (hasType(type_MultipolePole, Var_POLE1) &  
(( ? [Var_POLE2] : 
 (hasType(type_MultipolePole, Var_POLE2) &  
(((f_abstractPart(Var_POLE1,Var_SECTION)) & (((f_abstractPart(Var_POLE2,Var_SECTION)) & (Var_POLE1 != Var_POLE2)))))))))))))).

fof(axengineeringLem6, axiom, 
 ( ! [Var_PORT] : 
 (hasType(type_MultipolePort, Var_PORT) => 
(( ? [Var_POLE1] : 
 (hasType(type_MultipolePole, Var_POLE1) &  
(( ? [Var_POLE2] : 
 (hasType(type_MultipolePole, Var_POLE2) &  
(( ? [Var_POLE3] : 
 (hasType(type_MultipolePole, Var_POLE3) &  
(((f_abstractPart(Var_POLE1,Var_PORT)) & (((f_abstractPart(Var_POLE2,Var_PORT)) & (((f_abstractPart(Var_POLE3,Var_PORT)) & (((Var_POLE1 = Var_POLE2) & (((Var_POLE2 = Var_POLE3) & (Var_POLE1 = Var_POLE3))))))))))))))))))))))).

fof(axengineeringLem7, axiom, 
 ( ! [Var_M] : 
 (hasType(type_AcrossVariableAccumulator, Var_M) => 
(( ? [Var_C] : 
 (hasType(type_CapacitorElement, Var_C) &  
(f_represents(Var_M,Var_C)))))))).

fof(axengineeringLem8, axiom, 
 ( ! [Var_M] : 
 (hasType(type_ElectricalTwopole, Var_M) => 
(( ! [Var_E] : 
 (hasType(type_Entity, Var_E) => 
(( ? [Var_C] : 
 (hasType(type_CapacitorElement, Var_C) &  
(f_represents(Var_M,Var_E))))))))))).

fof(axengineeringLem9, axiom, 
 ( ! [Var_M] : 
 (hasType(type_ThroughVariableAccumulator, Var_M) => 
(( ? [Var_I] : 
 (hasType(type_InductorElement, Var_I) &  
(f_represents(Var_M,Var_I)))))))).

fof(axengineeringLem10, axiom, 
 ( ! [Var_M] : 
 (hasType(type_ElectricalTwopole, Var_M) => 
(( ! [Var_I] : 
 (hasType(type_Entity, Var_I) => 
(( ? [Var_C] : 
 (hasType(type_InductorElement, Var_C) &  
(f_represents(Var_M,Var_I))))))))))).

fof(axengineeringLem11, axiom, 
 ( ! [Var_M] : 
 (hasType(type_Twoport, Var_M) => 
(( ? [Var_T] : 
 (hasType(type_Transducer, Var_T) &  
(f_represents(Var_M,Var_T)))))))).

fof(axengineeringLem12, axiom, 
 ( ! [Var_M] : 
 (hasType(type_Dissipator, Var_M) => 
(( ? [Var_R] : 
 (hasType(type_ResistorElement, Var_R) &  
(f_represents(Var_M,Var_R)))))))).

fof(axengineeringLem13, axiom, 
 ( ! [Var_M] : 
 (hasType(type_ElectricalTwopole, Var_M) => 
(( ? [Var_R] : 
 (hasType(type_ResistorElement, Var_R) &  
(f_represents(Var_M,Var_R)))))))).

fof(axengineeringLem14, axiom, 
 ( ! [Var_PS] : 
 (hasType(type_PowerSource, Var_PS) => 
(( ? [Var_RE] : 
 (hasType(type_RadiatingElectromagnetic, Var_RE) &  
(f_origin(Var_RE,Var_PS)))))))).

fof(axengineeringLem15, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_ITProcess, Var_PROCESS) => 
(( ? [Var_AGENT] : 
 (hasType(type_ITAgent, Var_AGENT) &  
(( ? [Var_PATIENT] : 
 (hasType(type_Computer, Var_PATIENT) &  
(((f_agent(Var_PROCESS,Var_AGENT)) & (f_patient(Var_PROCESS,Var_PATIENT))))))))))))).

