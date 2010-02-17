fof(axMergeLem0, axiom, 
 ( ! [Var_THING2] : 
 (hasType(type_Entity, Var_THING2) => 
(( ! [Var_THING1] : 
 (hasType(type_Entity, Var_THING1) => 
(((Var_THING1 = Var_THING2) => (( ! [Var_ATTR] : 
 (hasType(type_Attribute, Var_ATTR) => 
(((f_property(Var_THING1,Var_ATTR)) <=> (f_property(Var_THING2,Var_ATTR))))))))))))))).

fof(axMergeLem1, axiom, 
 ( ! [Var_ATTR2] : 
 ((hasType(type_Entity, Var_ATTR2) & hasType(type_Attribute, Var_ATTR2)) => 
(( ! [Var_ATTR1] : 
 ((hasType(type_Entity, Var_ATTR1) & hasType(type_Attribute, Var_ATTR1)) => 
(((Var_ATTR1 = Var_ATTR2) => (( ! [Var_THING] : 
 (hasType(type_Entity, Var_THING) => 
(((f_property(Var_THING,Var_ATTR1)) <=> (f_property(Var_THING,Var_ATTR2))))))))))))))).

fof(axMergeLem2, axiom, 
 ( ! [Var_ATTR2] : 
 (hasType(type_Attribute, Var_ATTR2) => 
(( ! [Var_ATTR1] : 
 (hasType(type_Attribute, Var_ATTR1) => 
(((f_subAttribute(Var_ATTR1,Var_ATTR2)) => (( ! [Var_OBJ] : 
 (hasType(type_Entity, Var_OBJ) => 
(((f_property(Var_OBJ,Var_ATTR1)) => (f_property(Var_OBJ,Var_ATTR2))))))))))))))).

fof(axMergeLem3, axiom, 
 ( ! [Var_ENTITY] : 
 (hasType(type_Entity, Var_ENTITY) => 
(( ! [Var_TIME1] : 
 (hasType(type_TimePosition, Var_TIME1) => 
(( ! [Var_ATTR2] : 
 (hasType(type_Attribute, Var_ATTR2) => 
(( ! [Var_ATTR1] : 
 (hasType(type_Attribute, Var_ATTR1) => 
(((((f_successorAttribute(Var_ATTR1,Var_ATTR2)) & (f_holdsDuring(Var_TIME1,property(Var_ENTITY,Var_ATTR2))))) => (( ? [Var_TIME2] : 
 (hasType(type_TimePosition, Var_TIME2) &  
(((f_temporalPart(Var_TIME2,f_PastFn(Var_TIME1))) & (f_holdsDuring(Var_TIME2,property(Var_ENTITY,Var_ATTR1)))))))))))))))))))))).

fof(axMergeLem4, axiom, 
 ( ! [Var_ATTR2] : 
 (hasType(type_Attribute, Var_ATTR2) => 
(( ! [Var_ATTR1] : 
 (hasType(type_Attribute, Var_ATTR1) => 
(((f_successorAttribute(Var_ATTR1,Var_ATTR2)) => (f_successorAttributeClosure(Var_ATTR1,Var_ATTR2)))))))))).

fof(axMergeLem5, axiom, 
 ( ! [Var_E3] : 
 (hasType(type_Entity, Var_E3) => 
(( ! [Var_ATT] : 
 (hasType(type_Attribute, Var_ATT) => 
(( ! [Var_E2] : 
 (hasType(type_Entity, Var_E2) => 
(( ! [Var_E1] : 
 (hasType(type_Entity, Var_E1) => 
(((((f_greaterThanByQuality(Var_E1,Var_E2,Var_ATT)) & (f_greaterThanByQuality(Var_E2,Var_E3,Var_ATT)))) => (f_greaterThanByQuality(Var_E1,Var_E3,Var_ATT)))))))))))))))).

fof(axMergeLem6, axiom, 
 ( ! [Var_ATT] : 
 (hasType(type_Attribute, Var_ATT) => 
(( ! [Var_E2] : 
 (hasType(type_Entity, Var_E2) => 
(( ! [Var_E1] : 
 (hasType(type_Entity, Var_E1) => 
(((f_greaterThanByQuality(Var_E1,Var_E2,Var_ATT)) => (( ~ (f_greaterThanByQuality(Var_E2,Var_E1,Var_ATT))))))))))))))).

fof(axMergeLem7, axiom, 
 ( ! [Var_ATT] : 
 (hasType(type_Attribute, Var_ATT) => 
(( ! [Var_E2] : 
 (hasType(type_Entity, Var_E2) => 
(( ! [Var_E1] : 
 (hasType(type_Entity, Var_E1) => 
(((f_greaterThanByQuality(Var_E1,Var_E2,Var_ATT)) => (Var_E2 != Var_E1)))))))))))).

fof(axMergeLem8, axiom, 
 ( ! [Var_PHYS] : 
 (hasType(type_Physical, Var_PHYS) => 
(( ? [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) &  
(( ? [Var_LOC] : 
 (hasType(type_Object, Var_LOC) &  
(((f_located(Var_PHYS,Var_LOC)) & (f_time(Var_PHYS,Var_TIME))))))))))))).

fof(axMergeLem9, axiom, 
 ( ! [Var_OBJ] : 
 (hasType(type_SelfConnectedObject, Var_OBJ) => 
(f_side(f_FrontFn(Var_OBJ),Var_OBJ))))).

fof(axMergeLem10, axiom, 
 ( ! [Var_OBJ] : 
 (hasType(type_SelfConnectedObject, Var_OBJ) => 
(f_side(f_BackFn(Var_OBJ),Var_OBJ))))).

fof(axMergeLem11, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_properPart(Var_OBJ1,Var_OBJ2)) <=> (((f_part(Var_OBJ1,Var_OBJ2)) & (( ~ (f_part(Var_OBJ2,Var_OBJ1)))))))))))))).

fof(axMergeLem12, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_SelfConnectedObject, Var_OBJ1) => 
(((f_contains(Var_OBJ1,Var_OBJ2)) <=> (( ? [Var_HOLE] : 
 (hasType(type_Hole, Var_HOLE) &  
(((f_hole(Var_HOLE,Var_OBJ1)) & (f_properlyFills(Var_OBJ2,Var_HOLE))))))))))))))).

fof(axMergeLem13, axiom, 
 ( ! [Var_OBJ] : 
 (hasType(type_Substance, Var_OBJ) => 
(( ! [Var_PART] : 
 (hasType(type_Object, Var_PART) => 
(( ! [Var_ATTR] : 
 (hasType(type_Attribute, Var_ATTR) => 
(((((f_attribute(Var_OBJ,Var_ATTR)) & (f_part(Var_PART,Var_OBJ)))) => (f_attribute(Var_PART,Var_ATTR))))))))))))).

fof(axMergeLem14, axiom, 
 ( ! [Var_ATOM] : 
 (hasType(type_Atom, Var_ATOM) => 
(( ? [Var_PROTON] : 
 (hasType(type_Proton, Var_PROTON) &  
(( ? [Var_ELECTRON] : 
 (hasType(type_Electron, Var_ELECTRON) &  
(((f_component(Var_PROTON,Var_ATOM)) & (f_component(Var_ELECTRON,Var_ATOM))))))))))))).

fof(axMergeLem15, axiom, 
 ( ! [Var_ATOM] : 
 (hasType(type_Atom, Var_ATOM) => 
(( ! [Var_NUCLEUS1] : 
 (hasType(type_AtomicNucleus, Var_NUCLEUS1) => 
(( ! [Var_NUCLEUS2] : 
 (hasType(type_AtomicNucleus, Var_NUCLEUS2) => 
(((((f_component(Var_NUCLEUS1,Var_ATOM)) & (f_component(Var_NUCLEUS2,Var_ATOM)))) => (Var_NUCLEUS1 = Var_NUCLEUS2)))))))))))).

fof(axMergeLem16, axiom, 
 ( ! [Var_PARTICLE] : 
 (hasType(type_SubatomicParticle, Var_PARTICLE) => 
(( ? [Var_ATOM] : 
 (hasType(type_Atom, Var_ATOM) &  
(f_part(Var_PARTICLE,Var_ATOM)))))))).

fof(axMergeLem17, axiom, 
 ( ! [Var_NUCLEUS] : 
 (hasType(type_AtomicNucleus, Var_NUCLEUS) => 
(( ? [Var_NEUTRON] : 
 (hasType(type_Neutron, Var_NEUTRON) &  
(( ? [Var_PROTON] : 
 (hasType(type_Proton, Var_PROTON) &  
(((f_component(Var_NEUTRON,Var_NUCLEUS)) & (f_component(Var_PROTON,Var_NUCLEUS))))))))))))).

fof(axMergeLem18, axiom, 
 ( ! [Var_MIXTURE] : 
 (hasType(type_Mixture, Var_MIXTURE) => 
(( ? [Var_PURE1] : 
 (hasType(type_PureSubstance, Var_PURE1) &  
(( ? [Var_PURE2] : 
 (hasType(type_PureSubstance, Var_PURE2) &  
(((Var_PURE1 != Var_PURE2) & (((f_part(Var_PURE1,Var_MIXTURE)) & (f_part(Var_PURE2,Var_MIXTURE))))))))))))))).

fof(axMergeLem19, axiom, 
 ( ! [Var_REGION] : 
 (hasType(type_Region, Var_REGION) => 
(( ? [Var_PHYS] : 
 (hasType(type_Physical, Var_PHYS) &  
(f_located(Var_PHYS,Var_REGION)))))))).

fof(axMergeLem20, axiom, 
 ( ! [Var_COLL] : 
 (hasType(type_Collection, Var_COLL) => 
(( ? [Var_OBJ] : 
 (hasType(type_SelfConnectedObject, Var_OBJ) &  
(f_member(Var_OBJ,Var_COLL)))))))).

fof(axMergeLem21, axiom, 
 ( ! [Var_COLL2] : 
 (hasType(type_Collection, Var_COLL2) => 
(( ! [Var_COLL1] : 
 (hasType(type_Collection, Var_COLL1) => 
(((f_subCollection(Var_COLL1,Var_COLL2)) <=> (( ! [Var_MEMBER] : 
 (hasType(type_SelfConnectedObject, Var_MEMBER) => 
(((f_member(Var_MEMBER,Var_COLL1)) => (f_member(Var_MEMBER,Var_COLL2))))))))))))))).

fof(axMergeLem22, axiom, 
 ( ! [Var_OBJ] : 
 (hasType(type_ContentBearingPhysical, Var_OBJ) => 
(( ? [Var_THING] : 
 (hasType(type_Entity, Var_THING) &  
(f_represents(Var_OBJ,Var_THING)))))))).

fof(axMergeLem23, axiom, 
 ( ! [Var_STRING] : 
 (hasType(type_SymbolicString, Var_STRING) => 
(( ? [Var_PART] : 
 (hasType(type_Character, Var_PART) &  
(f_part(Var_PART,Var_STRING)))))))).

fof(axMergeLem24, axiom, 
 ( ! [Var_LANG] : 
 (hasType(type_ConstructedLanguage, Var_LANG) => 
(( ? [Var_PLAN] : 
 (hasType(type_Planning, Var_PLAN) &  
(f_result(Var_PLAN,Var_LANG)))))))).

fof(axMergeLem25, axiom, 
 ( ! [Var_AGENT] : 
 (hasType(type_Agent, Var_AGENT) => 
(( ? [Var_PROC] : 
 (hasType(type_Process, Var_PROC) &  
(f_agent(Var_PROC,Var_AGENT)))))))).

fof(axMergeLem26, axiom, 
 ( ! [Var_Y] : 
 ((hasType(type_Human, Var_Y) & hasType(type_Object, Var_Y)) => 
(( ! [Var_X] : 
 (hasType(type_Agent, Var_X) => 
(((f_leader(Var_X,Var_Y)) => (f_attribute(Var_Y,inst_Living)))))))))).

fof(axMergeLem27, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_DualObjectProcess, Var_PROCESS) => 
(( ? [Var_OBJ2] : 
 (hasType(type_Entity, Var_OBJ2) &  
(( ? [Var_OBJ1] : 
 (hasType(type_Entity, Var_OBJ1) &  
(((f_patient(Var_PROCESS,Var_OBJ1)) & (((f_patient(Var_PROCESS,Var_OBJ2)) & (Var_OBJ1 != Var_OBJ2)))))))))))))).

fof(axMergeLem28, axiom, 
 ( ! [Var_PROC] : 
 (hasType(type_SingleAgentProcess, Var_PROC) => 
(( ? [Var_AGENT] : 
 (hasType(type_Agent, Var_AGENT) &  
(f_agent(Var_PROC,Var_AGENT)))))))).

fof(axMergeLem29, axiom, 
 ( ! [Var_PROC] : 
 (hasType(type_SingleAgentProcess, Var_PROC) => 
(( ! [Var_AGENT_2] : 
 ((hasType(type_Agent, Var_AGENT_2) & hasType(type_Entity, Var_AGENT_2)) => 
(( ! [Var_AGENT_1] : 
 ((hasType(type_Agent, Var_AGENT_1) & hasType(type_Entity, Var_AGENT_1)) => 
(((((f_agent(Var_PROC,Var_AGENT_1)) & (f_agent(Var_PROC,Var_AGENT_2)))) => (Var_AGENT_1 = Var_AGENT_2)))))))))))).

fof(axMergeLem30, axiom, 
 ( ! [Var_ABS] : 
 (hasType(type_Abstract, Var_ABS) => 
(( ~ ( ? [Var_POINT] : 
 ((hasType(type_Object, Var_POINT) & hasType(type_TimePosition, Var_POINT)) &  
(((f_located(Var_ABS,Var_POINT)) | (f_time(Var_ABS,Var_POINT))))))))))).

fof(axMergeLem31, axiom, 
 ( ! [Var_NUMBER2] : 
 ((hasType(type_Quantity, Var_NUMBER2) & hasType(type_Entity, Var_NUMBER2)) => 
(( ! [Var_NUMBER1] : 
 ((hasType(type_Quantity, Var_NUMBER1) & hasType(type_Entity, Var_NUMBER1)) => 
(((f_lessThanOrEqualTo(Var_NUMBER1,Var_NUMBER2)) <=> (((Var_NUMBER1 = Var_NUMBER2) | (f_lessThan(Var_NUMBER1,Var_NUMBER2)))))))))))).

fof(axMergeLem32, axiom, 
 ( ! [Var_NUMBER2] : 
 ((hasType(type_Quantity, Var_NUMBER2) & hasType(type_Entity, Var_NUMBER2)) => 
(( ! [Var_NUMBER1] : 
 ((hasType(type_Quantity, Var_NUMBER1) & hasType(type_Entity, Var_NUMBER1)) => 
(((f_greaterThanOrEqualTo(Var_NUMBER1,Var_NUMBER2)) <=> (((Var_NUMBER1 = Var_NUMBER2) | (f_greaterThan(Var_NUMBER1,Var_NUMBER2)))))))))))).

fof(axMergeLem33, axiom, 
 ( ! [Var_NUMBER] : 
 (hasType(type_ImaginaryNumber, Var_NUMBER) => 
(( ? [Var_REAL] : 
 (hasType(type_RealNumber, Var_REAL) &  
(Var_NUMBER = f_MultiplicationFn(Var_REAL,f_SquareRootFn(-1))))))))).

fof(axMergeLem34, axiom, 
 ( ! [Var_X] : 
 (hasType(type_NonnegativeInteger, Var_X) => 
(f_greaterThan(Var_X,-1))))).

fof(axMergeLem35, axiom, 
 ( ! [Var_X] : 
 (hasType(type_NegativeInteger, Var_X) => 
(f_greaterThan(0,Var_X))))).

fof(axMergeLem36, axiom, 
 ( ! [Var_X] : 
 (hasType(type_PositiveInteger, Var_X) => 
(f_greaterThan(Var_X,0))))).

fof(axMergeLem37, axiom, 
 ( ! [Var_NUMBER] : 
 (hasType(type_ComplexNumber, Var_NUMBER) => 
(( ? [Var_REAL1] : 
 (hasType(type_RealNumber, Var_REAL1) &  
(( ? [Var_REAL2] : 
 (hasType(type_RealNumber, Var_REAL2) &  
(Var_NUMBER = f_AdditionFn(Var_REAL1,f_MultiplicationFn(Var_REAL2,f_SquareRootFn(-1))))))))))))).

fof(axMergeLem38, axiom, 
 ( ! [Var_OBJECT] : 
 (hasType(type_Entity, Var_OBJECT) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_CognitiveAgent, Var_AGENT)) => 
(((( ? [Var_PROCESS] : 
 (hasType(type_IntentionalProcess, Var_PROCESS) &  
(((f_agent(Var_PROCESS,Var_AGENT)) & (f_patient(Var_PROCESS,Var_OBJECT))))))) <=> (f_inScopeOfInterest(Var_AGENT,Var_OBJECT)))))))))).

fof(axMergeLem39, axiom, 
 ( ! [Var_OBJECT] : 
 (hasType(type_Physical, Var_OBJECT) => 
(( ! [Var_AGENT] : 
 (hasType(type_CognitiveAgent, Var_AGENT) => 
(((f_needs(Var_AGENT,Var_OBJECT)) => (f_wants(Var_AGENT,Var_OBJECT)))))))))).

fof(axMergeLem40, axiom, 
 ( ! [Var_OBJ] : 
 ((hasType(type_Physical, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(( ! [Var_AGENT] : 
 (hasType(type_CognitiveAgent, Var_AGENT) => 
(((f_wants(Var_AGENT,Var_OBJ)) => (f_desires(Var_AGENT,possesses(Var_AGENT,Var_OBJ))))))))))).

fof(axMergeLem41, axiom, 
 ( ! [Var_LIST] : 
 (hasType(type_List, Var_LIST) => 
(( ? [Var_NUMBER1] : 
 ((hasType(type_PositiveInteger, Var_NUMBER1) & hasType(type_Quantity, Var_NUMBER1)) &  
(( ? [Var_ITEM1] : 
 (hasType(type_Entity, Var_ITEM1) &  
(((f_ListOrderFn(Var_LIST,Var_NUMBER1) != Var_ITEM1) & (( ! [Var_NUMBER2] : 
 (hasType(type_PositiveInteger, Var_NUMBER2) => 
(((f_lessThan(Var_NUMBER2,Var_NUMBER1)) => (( ? [Var_ITEM2] : 
 (hasType(type_Entity, Var_ITEM2) &  
(f_ListOrderFn(Var_LIST,Var_NUMBER2) = Var_ITEM2)))))))))))))))))))).

fof(axMergeLem42, axiom, 
 ( ! [Var_LIST] : 
 (hasType(type_UniqueList, Var_LIST) => 
(( ! [Var_NUMBER2] : 
 ((hasType(type_PositiveInteger, Var_NUMBER2) & hasType(type_Entity, Var_NUMBER2)) => 
(( ! [Var_NUMBER1] : 
 ((hasType(type_PositiveInteger, Var_NUMBER1) & hasType(type_Entity, Var_NUMBER1)) => 
(((f_ListOrderFn(Var_LIST,Var_NUMBER1) = f_ListOrderFn(Var_LIST,Var_NUMBER2)) => (Var_NUMBER1 = Var_NUMBER2)))))))))))).

fof(axMergeLem43, axiom, 
 ( ! [Var_LIST1] : 
 (hasType(type_List, Var_LIST1) => 
(( ! [Var_LIST2] : 
 (hasType(type_List, Var_LIST2) => 
(((( ! [Var_NUMBER] : 
 (hasType(type_PositiveInteger, Var_NUMBER) => 
(f_ListOrderFn(Var_LIST1,Var_NUMBER) = f_ListOrderFn(Var_LIST2,Var_NUMBER))))) => (Var_LIST1 = Var_LIST2))))))))).

fof(axMergeLem44, axiom, 
 ( ! [Var_LIST] : 
 (hasType(type_List, Var_LIST) => 
(( ! [Var_NUMBER1] : 
 (hasType(type_PositiveInteger, Var_NUMBER1) => 
(((((f_ListLengthFn(Var_LIST) = Var_NUMBER1) & (Var_LIST != inst_NullList))) => (( ! [Var_NUMBER2] : 
 ((hasType(type_PositiveInteger, Var_NUMBER2) & hasType(type_Quantity, Var_NUMBER2)) => 
(((( ? [Var_ITEM] : 
 (hasType(type_Entity, Var_ITEM) &  
(((f_ListOrderFn(Var_LIST,Var_NUMBER2) = Var_ITEM) & (f_inList(Var_ITEM,Var_LIST))))))) <=> (f_lessThanOrEqualTo(Var_NUMBER2,Var_NUMBER1))))))))))))))).

fof(axMergeLem45, axiom, 
 ( ! [Var_LIST2] : 
 (hasType(type_List, Var_LIST2) => 
(( ! [Var_LIST1] : 
 (hasType(type_List, Var_LIST1) => 
(( ! [Var_LIST3] : 
 ((hasType(type_Entity, Var_LIST3) & hasType(type_List, Var_LIST3)) => 
(((Var_LIST3 = f_ListConcatenateFn(Var_LIST1,Var_LIST2)) <=> (( ! [Var_NUMBER1] : 
 (hasType(type_PositiveInteger, Var_NUMBER1) => 
(( ! [Var_NUMBER2] : 
 (hasType(type_PositiveInteger, Var_NUMBER2) => 
(((((f_lessThanOrEqualTo(Var_NUMBER1,f_ListLengthFn(Var_LIST1))) & (f_lessThanOrEqualTo(Var_NUMBER2,f_ListLengthFn(Var_LIST2))))) => (((f_ListOrderFn(Var_LIST3,Var_NUMBER1) = f_ListOrderFn(Var_LIST1,Var_NUMBER1)) & (f_ListOrderFn(Var_LIST3,f_AdditionFn(f_ListLengthFn(Var_LIST1),Var_NUMBER2)) = f_ListOrderFn(Var_LIST2,Var_NUMBER2))))))))))))))))))))))).

fof(axMergeLem46, axiom, 
 ( ! [Var_LIST] : 
 (hasType(type_List, Var_LIST) => 
(( ! [Var_ITEM] : 
 (hasType(type_Entity, Var_ITEM) => 
(((f_inList(Var_ITEM,Var_LIST)) => (( ? [Var_NUMBER] : 
 (hasType(type_PositiveInteger, Var_NUMBER) &  
(f_ListOrderFn(Var_LIST,Var_NUMBER) = Var_ITEM)))))))))))).

fof(axMergeLem47, axiom, 
 ( ! [Var_LIST2] : 
 (hasType(type_List, Var_LIST2) => 
(( ! [Var_LIST1] : 
 (hasType(type_List, Var_LIST1) => 
(((f_subList(Var_LIST1,Var_LIST2)) => (( ! [Var_ITEM] : 
 (hasType(type_Entity, Var_ITEM) => 
(((f_inList(Var_ITEM,Var_LIST1)) => (f_inList(Var_ITEM,Var_LIST2))))))))))))))).

fof(axMergeLem48, axiom, 
 ( ! [Var_LIST2] : 
 (hasType(type_List, Var_LIST2) => 
(( ! [Var_LIST1] : 
 (hasType(type_List, Var_LIST1) => 
(((f_subList(Var_LIST1,Var_LIST2)) => (( ? [Var_NUMBER3] : 
 (hasType(type_Quantity, Var_NUMBER3) &  
(( ! [Var_ITEM] : 
 (hasType(type_Entity, Var_ITEM) => 
(((f_inList(Var_ITEM,Var_LIST1)) => (( ? [Var_NUMBER2] : 
 ((hasType(type_PositiveInteger, Var_NUMBER2) & hasType(type_Entity, Var_NUMBER2)) &  
(( ? [Var_NUMBER1] : 
 ((hasType(type_PositiveInteger, Var_NUMBER1) & hasType(type_Quantity, Var_NUMBER1)) &  
(((f_ListOrderFn(Var_LIST1,Var_NUMBER1) = Var_ITEM) & (((f_ListOrderFn(Var_LIST2,Var_NUMBER2) = Var_ITEM) & (Var_NUMBER2 = f_AdditionFn(Var_NUMBER1,Var_NUMBER3)))))))))))))))))))))))))))).

fof(axMergeLem49, axiom, 
 ( ! [Var_ITEM] : 
 (hasType(type_Entity, Var_ITEM) => 
(( ! [Var_LIST2] : 
 (hasType(type_List, Var_LIST2) => 
(( ! [Var_LIST1] : 
 (hasType(type_List, Var_LIST1) => 
(((f_identicalListItems(Var_LIST1,Var_LIST2)) => (((f_inList(Var_ITEM,Var_LIST1)) <=> (f_inList(Var_ITEM,Var_LIST2))))))))))))))).

fof(axMergeLem50, axiom, 
 ( ! [Var_S2] : 
 (hasType(type_Process, Var_S2) => 
(( ! [Var_P] : 
 (hasType(type_Process, Var_P) => 
(( ! [Var_S1] : 
 (hasType(type_Process, Var_S1) => 
(((((f_subProcess(Var_S1,Var_P)) & (f_subProcess(Var_S2,Var_P)))) => (f_relatedEvent(Var_S1,Var_S2))))))))))))).

fof(axMergeLem51, axiom, 
 ( ! [Var_PROC1] : 
 (hasType(type_Process, Var_PROC1) => 
(( ? [Var_PROC2] : 
 (hasType(type_Process, Var_PROC2) &  
(f_causes(Var_PROC2,Var_PROC1)))))))).

fof(axMergeLem52, axiom, 
 ( ! [Var_P2] : 
 ((hasType(type_Process, Var_P2) & hasType(type_Physical, Var_P2)) => 
(( ! [Var_P1] : 
 ((hasType(type_Process, Var_P1) & hasType(type_Physical, Var_P1)) => 
(((f_causes(Var_P1,Var_P2)) => (f_earlier(f_WhenFn(Var_P1),f_WhenFn(Var_P2))))))))))).

fof(axMergeLem53, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_copy(Var_OBJ1,Var_OBJ2)) => (( ! [Var_ATTR] : 
 (hasType(type_Attribute, Var_ATTR) => 
(((f_attribute(Var_OBJ1,Var_ATTR)) => (f_attribute(Var_OBJ2,Var_ATTR))))))))))))))).

fof(axMergeLem54, axiom, 
 ( ! [Var_AGENT] : 
 (hasType(type_Agent, Var_AGENT) => 
(( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(((f_exploits(Var_OBJ,Var_AGENT)) => (( ? [Var_PROCESS] : 
 (hasType(type_Process, Var_PROCESS) &  
(((f_agent(Var_PROCESS,Var_AGENT)) & (f_resourceS(Var_PROCESS,Var_OBJ))))))))))))))).

fof(axMergeLem55, axiom, 
 ( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(((f_partlyLocated(Var_OBJ1,Var_OBJ2)) => (f_overlapsSpatially(Var_OBJ1,Var_OBJ2)))))))))).

fof(axMergeLem56, axiom, 
 ( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(((f_partlyLocated(Var_OBJ1,Var_OBJ2)) => (( ? [Var_SUB] : 
 ((hasType(type_Object, Var_SUB) & hasType(type_Physical, Var_SUB)) &  
(((f_part(Var_SUB,Var_OBJ1)) & (f_located(Var_SUB,Var_OBJ2))))))))))))))).

fof(axMergeLem57, axiom, 
 ( ! [Var_LOC] : 
 (hasType(type_Object, Var_LOC) => 
(( ! [Var_PROCESS] : 
 ((hasType(type_Process, Var_PROCESS) & hasType(type_Physical, Var_PROCESS)) => 
(((f_origin(Var_PROCESS,Var_LOC)) => (f_partlyLocated(Var_PROCESS,Var_LOC)))))))))).

fof(axMergeLem58, axiom, 
 ( ! [Var_LOC] : 
 ((hasType(type_Entity, Var_LOC) & hasType(type_Object, Var_LOC)) => 
(( ! [Var_PROCESS] : 
 ((hasType(type_Process, Var_PROCESS) & hasType(type_Physical, Var_PROCESS)) => 
(((f_destination(Var_PROCESS,Var_LOC)) => (f_partlyLocated(Var_PROCESS,Var_LOC)))))))))).

fof(axMergeLem59, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_Physical, Var_OBJ1) & hasType(type_Object, Var_OBJ1)) => 
(((f_located(Var_OBJ1,Var_OBJ2)) => (( ! [Var_SUB] : 
 ((hasType(type_Object, Var_SUB) & hasType(type_Physical, Var_SUB)) => 
(((f_part(Var_SUB,Var_OBJ1)) => (f_located(Var_SUB,Var_OBJ2))))))))))))))).

fof(axMergeLem60, axiom, 
 ( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(( ! [Var_PROCESS] : 
 ((hasType(type_Physical, Var_PROCESS) & hasType(type_Process, Var_PROCESS)) => 
(((f_located(Var_PROCESS,Var_OBJ)) => (( ! [Var_SUB] : 
 ((hasType(type_Process, Var_SUB) & hasType(type_Physical, Var_SUB)) => 
(((f_subProcess(Var_SUB,Var_PROCESS)) => (f_located(Var_SUB,Var_OBJ))))))))))))))).

fof(axMergeLem61, axiom, 
 ( ! [Var_REGION] : 
 (hasType(type_Object, Var_REGION) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Physical, Var_OBJ) & hasType(type_Entity, Var_OBJ)) => 
(((f_exactlyLocated(Var_OBJ,Var_REGION)) => (( ~ ( ? [Var_OTHEROBJ] : 
 ((hasType(type_Physical, Var_OTHEROBJ) & hasType(type_Entity, Var_OTHEROBJ)) &  
(((f_exactlyLocated(Var_OTHEROBJ,Var_REGION)) & (Var_OTHEROBJ != Var_OBJ))))))))))))))).

fof(axMergeLem62, axiom, 
 ( ! [Var_END2] : 
 (hasType(type_Object, Var_END2) => 
(( ! [Var_MID] : 
 (hasType(type_Object, Var_MID) => 
(( ! [Var_END1] : 
 (hasType(type_Object, Var_END1) => 
(((f_between(Var_END1,Var_MID,Var_END2)) => (f_between(Var_END2,Var_MID,Var_END1))))))))))))).

fof(axMergeLem63, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_traverses(Var_OBJ1,Var_OBJ2)) => (((f_crosses(Var_OBJ1,Var_OBJ2)) | (f_penetrates(Var_OBJ1,Var_OBJ2)))))))))))).

fof(axMergeLem64, axiom, 
 ( ! [Var_REGION] : 
 ((hasType(type_Entity, Var_REGION) & hasType(type_Object, Var_REGION)) => 
(( ! [Var_TIME] : 
 ((hasType(type_TimePoint, Var_TIME) & hasType(type_TimePosition, Var_TIME)) => 
(( ! [Var_THING] : 
 (hasType(type_Physical, Var_THING) => 
(((f_WhereFn(Var_THING,Var_TIME) = Var_REGION) <=> (f_holdsDuring(Var_TIME,exactlyLocated(Var_THING,Var_REGION)))))))))))))).

fof(axMergeLem65, axiom, 
 ( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(( ! [Var_PERSON] : 
 (hasType(type_Agent, Var_PERSON) => 
(((f_possesses(Var_PERSON,Var_OBJ)) => (f_modalAttribute(uses(Var_OBJ,Var_PERSON),inst_Permission)))))))))).

fof(axMergeLem66, axiom, 
 ( ! [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) => 
(( ! [Var_AGENT2] : 
 ((hasType(type_Agent, Var_AGENT2) & hasType(type_Entity, Var_AGENT2)) => 
(( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(( ! [Var_AGENT1] : 
 ((hasType(type_Agent, Var_AGENT1) & hasType(type_Entity, Var_AGENT1)) => 
(((((f_holdsDuring(Var_TIME,possesses(Var_AGENT1,Var_OBJ))) & (f_holdsDuring(Var_TIME,possesses(Var_AGENT2,Var_OBJ))))) => (Var_AGENT1 = Var_AGENT2))))))))))))))).

fof(axMergeLem67, axiom, 
 ( ! [Var_AGENT] : 
 (hasType(type_Agent, Var_AGENT) => 
(( ! [Var_ENTITY] : 
 (hasType(type_Entity, Var_ENTITY) => 
(( ! [Var_REP] : 
 (hasType(type_Entity, Var_REP) => 
(((f_representsForAgent(Var_REP,Var_ENTITY,Var_AGENT)) => (f_represents(Var_REP,Var_ENTITY))))))))))))).

fof(axMergeLem68, axiom, 
 ( ! [Var_LANGUAGE] : 
 (hasType(type_Language, Var_LANGUAGE) => 
(( ! [Var_ENTITY] : 
 (hasType(type_Entity, Var_ENTITY) => 
(( ! [Var_REP] : 
 ((hasType(type_LinguisticExpression, Var_REP) & hasType(type_Entity, Var_REP)) => 
(((f_representsInLanguage(Var_REP,Var_ENTITY,Var_LANGUAGE)) => (( ? [Var_AGENT] : 
 (hasType(type_Agent, Var_AGENT) &  
(f_representsForAgent(Var_REP,Var_ENTITY,Var_AGENT)))))))))))))))).

fof(axMergeLem69, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_ContentBearingObject, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_ContentBearingObject, Var_OBJ1) => 
(((((f_subsumesContentInstance(Var_OBJ1,Var_OBJ2)) & (f_subsumesContentInstance(Var_OBJ2,Var_OBJ1)))) <=> (f_equivalentContentInstance(Var_OBJ1,Var_OBJ2)))))))))).

fof(axMergeLem70, axiom, 
 ( ! [Var_OBJ2] : 
 ((hasType(type_ContentBearingObject, Var_OBJ2) & hasType(type_ContentBearingPhysical, Var_OBJ2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_ContentBearingObject, Var_OBJ1) & hasType(type_ContentBearingPhysical, Var_OBJ1)) => 
(((f_subsumesContentInstance(Var_OBJ1,Var_OBJ2)) => (( ! [Var_INFO] : 
 (hasType(type_Proposition, Var_INFO) => 
(((f_containsInformation(Var_OBJ2,Var_INFO)) => (f_containsInformation(Var_OBJ1,Var_INFO))))))))))))))).

fof(axMergeLem71, axiom, 
 ( ! [Var_PROP] : 
 (hasType(type_Proposition, Var_PROP) => 
(( ! [Var_PROCESS] : 
 (hasType(type_Process, Var_PROCESS) => 
(((f_realization(Var_PROCESS,Var_PROP)) => (( ? [Var_OBJ] : 
 (hasType(type_ContentBearingObject, Var_OBJ) &  
(f_containsInformation(Var_OBJ,Var_PROP))))))))))))).

fof(axMergeLem72, axiom, 
 ( ! [Var_LANGUAGE] : 
 (hasType(type_Language, Var_LANGUAGE) => 
(( ! [Var_EXPRESS] : 
 (hasType(type_LinguisticExpression, Var_EXPRESS) => 
(((f_expressedInLanguage(Var_EXPRESS,Var_LANGUAGE)) <=> (( ? [Var_PROP] : 
 (hasType(type_Entity, Var_PROP) &  
(f_representsInLanguage(Var_EXPRESS,Var_PROP,Var_LANGUAGE))))))))))))).

fof(axMergeLem73, axiom, 
 ( ! [Var_PROP2] : 
 (hasType(type_Proposition, Var_PROP2) => 
(( ! [Var_PROP1] : 
 (hasType(type_Proposition, Var_PROP1) => 
(((f_subProposition(Var_PROP1,Var_PROP2)) => (( ! [Var_OBJ2] : 
 ((hasType(type_ContentBearingPhysical, Var_OBJ2) & hasType(type_ContentBearingObject, Var_OBJ2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_ContentBearingPhysical, Var_OBJ1) & hasType(type_ContentBearingObject, Var_OBJ1)) => 
(((((f_containsInformation(Var_OBJ1,Var_PROP1)) & (f_containsInformation(Var_OBJ2,Var_PROP2)))) => (f_subsumesContentInstance(Var_OBJ2,Var_OBJ1)))))))))))))))))).

fof(axMergeLem74, axiom, 
 ( ! [Var_AGENT] : 
 (hasType(type_Agent, Var_AGENT) => 
(( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(((f_uses(Var_OBJ,Var_AGENT)) => (( ? [Var_PROC] : 
 (hasType(type_Process, Var_PROC) &  
(((f_agent(Var_PROC,Var_AGENT)) & (f_instrument(Var_PROC,Var_OBJ))))))))))))))).

fof(axMergeLem75, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Integer, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(f_SuccessorFn(Var_NUMBER) = f_AdditionFn(Var_NUMBER,1))))).

fof(axMergeLem76, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Integer, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(f_PredecessorFn(Var_NUMBER) = f_SubtractionFn(Var_NUMBER,1))))).

fof(axMergeLem77, axiom, 
 ( ! [Var_NUMBER] : 
 (hasType(type_RationalNumber, Var_NUMBER) => 
(( ? [Var_INT1] : 
 (hasType(type_Integer, Var_INT1) &  
(( ? [Var_INT2] : 
 (hasType(type_Integer, Var_INT2) &  
(Var_NUMBER = f_DivisionFn(Var_INT1,Var_INT2))))))))))).

fof(axMergeLem78, axiom, 
 ( ! [Var_N2] : 
 ((hasType(type_Integer, Var_N2) & hasType(type_Entity, Var_N2)) => 
(( ! [Var_N1] : 
 ((hasType(type_Integer, Var_N1) & hasType(type_Quantity, Var_N1)) => 
(((f_multiplicativeFactor(Var_N1,Var_N2)) => (( ? [Var_I] : 
 (hasType(type_Integer, Var_I) &  
(Var_N2 = f_MultiplicationFn(Var_N1,Var_I))))))))))))).

fof(axMergeLem79, axiom, 
 ( ! [Var_NUMBER] : 
 (hasType(type_ComplexNumber, Var_NUMBER) => 
(( ? [Var_PART2] : 
 (hasType(type_Entity, Var_PART2) &  
(( ? [Var_PART1] : 
 (hasType(type_Entity, Var_PART1) &  
(((Var_PART1 = f_RealNumberFn(Var_NUMBER)) & (Var_PART2 = f_ImaginaryPartFn(Var_NUMBER))))))))))))).

fof(axMergeLem80, axiom, 
 ( ! [Var_NUMBER] : 
 (hasType(type_Entity, Var_NUMBER) => 
(( ! [Var_NUMBER2] : 
 ((hasType(type_Quantity, Var_NUMBER2) & hasType(type_Entity, Var_NUMBER2)) => 
(( ! [Var_NUMBER1] : 
 ((hasType(type_Quantity, Var_NUMBER1) & hasType(type_Entity, Var_NUMBER1)) => 
(((f_MaxFn(Var_NUMBER1,Var_NUMBER2) = Var_NUMBER) => (((((Var_NUMBER = Var_NUMBER1) & (f_greaterThan(Var_NUMBER1,Var_NUMBER2)))) | (((((Var_NUMBER = Var_NUMBER2) & (f_greaterThan(Var_NUMBER2,Var_NUMBER1)))) | (((Var_NUMBER = Var_NUMBER1) & (Var_NUMBER = Var_NUMBER2)))))))))))))))))).

fof(axMergeLem81, axiom, 
 ( ! [Var_NUMBER] : 
 (hasType(type_Entity, Var_NUMBER) => 
(( ! [Var_NUMBER2] : 
 ((hasType(type_Quantity, Var_NUMBER2) & hasType(type_Entity, Var_NUMBER2)) => 
(( ! [Var_NUMBER1] : 
 ((hasType(type_Quantity, Var_NUMBER1) & hasType(type_Entity, Var_NUMBER1)) => 
(((f_MinFn(Var_NUMBER1,Var_NUMBER2) = Var_NUMBER) => (((((Var_NUMBER = Var_NUMBER1) & (f_lessThan(Var_NUMBER1,Var_NUMBER2)))) | (((((Var_NUMBER = Var_NUMBER2) & (f_lessThan(Var_NUMBER2,Var_NUMBER1)))) | (((Var_NUMBER = Var_NUMBER1) & (Var_NUMBER = Var_NUMBER2)))))))))))))))))).

fof(axMergeLem82, axiom, 
 ( ! [Var_NUMBER] : 
 (hasType(type_Quantity, Var_NUMBER) => 
(f_ReciprocalFn(Var_NUMBER) = f_ExponentiationFn(Var_NUMBER,-1))))).

fof(axMergeLem83, axiom, 
 ( ! [Var_NUMBER] : 
 (hasType(type_Quantity, Var_NUMBER) => 
(1 = f_MultiplicationFn(Var_NUMBER,f_ReciprocalFn(Var_NUMBER)))))).

fof(axMergeLem84, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(( ! [Var_NUMBER2] : 
 (hasType(type_Quantity, Var_NUMBER2) => 
(( ! [Var_NUMBER1] : 
 ((hasType(type_Quantity, Var_NUMBER1) & hasType(type_Entity, Var_NUMBER1)) => 
(((f_RemainderFn(Var_NUMBER1,Var_NUMBER2) = Var_NUMBER) <=> (f_AdditionFn(f_MultiplicationFn(f_FloorFn(f_DivisionFn(Var_NUMBER1,Var_NUMBER2)),Var_NUMBER2),Var_NUMBER) = Var_NUMBER1)))))))))))).

fof(axMergeLem85, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER)) => 
(( ! [Var_NUMBER2] : 
 ((hasType(type_Quantity, Var_NUMBER2) & hasType(type_RealNumber, Var_NUMBER2)) => 
(( ! [Var_NUMBER1] : 
 (hasType(type_Quantity, Var_NUMBER1) => 
(((f_RemainderFn(Var_NUMBER1,Var_NUMBER2) = Var_NUMBER) => (f_SignumFn(Var_NUMBER2) = f_SignumFn(Var_NUMBER))))))))))))).

fof(axMergeLem86, axiom, 
 ( ! [Var_NUMBER] : 
 (hasType(type_EvenInteger, Var_NUMBER) => 
(f_RemainderFn(Var_NUMBER,2) = 0)))).

fof(axMergeLem87, axiom, 
 ( ! [Var_NUMBER] : 
 (hasType(type_OddInteger, Var_NUMBER) => 
(f_RemainderFn(Var_NUMBER,2) = 1)))).

fof(axMergeLem88, axiom, 
 ( ! [Var_PRIME] : 
 (hasType(type_PrimeNumber, Var_PRIME) => 
(( ! [Var_NUMBER] : 
 ((hasType(type_Quantity, Var_NUMBER) & hasType(type_Entity, Var_NUMBER)) => 
(((f_RemainderFn(Var_PRIME,Var_NUMBER) = 0) => (((Var_NUMBER = 1) | (Var_NUMBER = Var_PRIME))))))))))).

fof(axMergeLem89, axiom, 
 ( ! [Var_NUMBER2] : 
 (hasType(type_Entity, Var_NUMBER2) => 
(( ! [Var_NUMBER1] : 
 ((hasType(type_Quantity, Var_NUMBER1) & hasType(type_RealNumber, Var_NUMBER1)) => 
(((f_RoundFn(Var_NUMBER1) = Var_NUMBER2) => (((((f_lessThan(f_SubtractionFn(Var_NUMBER1,f_FloorFn(Var_NUMBER1)),0.5)) => (Var_NUMBER2 = f_FloorFn(Var_NUMBER1)))) | (((f_greaterThanOrEqualTo(f_SubtractionFn(Var_NUMBER1,f_FloorFn(Var_NUMBER1)),0.5)) => (Var_NUMBER2 = f_CeilingFn(Var_NUMBER1)))))))))))))).

fof(axMergeLem90, axiom, 
 ( ! [Var_NUMBER] : 
 (hasType(type_NonnegativeRealNumber, Var_NUMBER) => 
(((f_SignumFn(Var_NUMBER) = 1) | (f_SignumFn(Var_NUMBER) = 0)))))).

fof(axMergeLem91, axiom, 
 ( ! [Var_NUMBER] : 
 (hasType(type_PositiveRealNumber, Var_NUMBER) => 
(f_SignumFn(Var_NUMBER) = 1)))).

fof(axMergeLem92, axiom, 
 ( ! [Var_NUMBER] : 
 (hasType(type_NegativeRealNumber, Var_NUMBER) => 
(f_SignumFn(Var_NUMBER) = -1)))).

fof(axMergeLem93, axiom, 
 ( ! [Var_NUMBER2] : 
 ((hasType(type_Entity, Var_NUMBER2) & hasType(type_Quantity, Var_NUMBER2)) => 
(( ! [Var_NUMBER1] : 
 ((hasType(type_RealNumber, Var_NUMBER1) & hasType(type_Entity, Var_NUMBER1)) => 
(((f_SquareRootFn(Var_NUMBER1) = Var_NUMBER2) => (f_MultiplicationFn(Var_NUMBER2,Var_NUMBER2) = Var_NUMBER1))))))))).

fof(axMergeLem94, axiom, 
 ( ! [Var_DEGREE] : 
 (hasType(type_PlaneAngleMeasure, Var_DEGREE) => 
(f_TangentFn(Var_DEGREE) = f_DivisionFn(f_SineFn(Var_DEGREE),f_CosineFn(Var_DEGREE)))))).

fof(axMergeLem95, axiom, 
 ( ! [Var_INT2] : 
 ((hasType(type_Integer, Var_INT2) & hasType(type_Entity, Var_INT2)) => 
(( ! [Var_INT1] : 
 ((hasType(type_Integer, Var_INT1) & hasType(type_Entity, Var_INT1)) => 
(((f_SuccessorFn(Var_INT1) = f_SuccessorFn(Var_INT2)) => (Var_INT1 = Var_INT2))))))))).

fof(axMergeLem96, axiom, 
 ( ! [Var_INT] : 
 (hasType(type_Integer, Var_INT) => 
(f_lessThan(Var_INT,f_SuccessorFn(Var_INT)))))).

fof(axMergeLem97, axiom, 
 ( ! [Var_INT1] : 
 (hasType(type_Integer, Var_INT1) => 
(( ! [Var_INT2] : 
 (hasType(type_Integer, Var_INT2) => 
(( ~ ((f_lessThan(Var_INT1,Var_INT2)) & (f_lessThan(Var_INT2,f_SuccessorFn(Var_INT1)))))))))))).

fof(axMergeLem98, axiom, 
 ( ! [Var_INT] : 
 (hasType(type_Integer, Var_INT) => 
(Var_INT = f_SuccessorFn(f_PredecessorFn(Var_INT)))))).

fof(axMergeLem99, axiom, 
 ( ! [Var_INT] : 
 (hasType(type_Integer, Var_INT) => 
(Var_INT = f_PredecessorFn(f_SuccessorFn(Var_INT)))))).

fof(axMergeLem100, axiom, 
 ( ! [Var_INT2] : 
 ((hasType(type_Integer, Var_INT2) & hasType(type_Entity, Var_INT2)) => 
(( ! [Var_INT1] : 
 ((hasType(type_Integer, Var_INT1) & hasType(type_Entity, Var_INT1)) => 
(((f_PredecessorFn(Var_INT1) = f_PredecessorFn(Var_INT2)) => (Var_INT1 = Var_INT2))))))))).

fof(axMergeLem101, axiom, 
 ( ! [Var_INT] : 
 (hasType(type_Integer, Var_INT) => 
(f_greaterThan(Var_INT,f_PredecessorFn(Var_INT)))))).

fof(axMergeLem102, axiom, 
 ( ! [Var_INT1] : 
 (hasType(type_Integer, Var_INT1) => 
(( ! [Var_INT2] : 
 (hasType(type_Integer, Var_INT2) => 
(( ~ ((f_lessThan(Var_INT2,Var_INT1)) & (f_lessThan(f_PredecessorFn(Var_INT1),Var_INT2))))))))))).

fof(axMergeLem103, axiom, 
 ( ! [Var_SET] : 
 (hasType(type_Set, Var_SET) => 
(( ! [Var_SUBSET] : 
 (hasType(type_Set, Var_SUBSET) => 
(((f_subset(Var_SUBSET,Var_SET)) => (( ! [Var_ELEMENT] : 
 (hasType(type_Entity, Var_ELEMENT) => 
(((f_element(Var_ELEMENT,Var_SUBSET)) => (f_element(Var_ELEMENT,Var_SET))))))))))))))).

fof(axMergeLem104, axiom, 
 ( ! [Var_SET2] : 
 ((hasType(type_Set, Var_SET2) & hasType(type_Entity, Var_SET2)) => 
(( ! [Var_SET1] : 
 ((hasType(type_Set, Var_SET1) & hasType(type_Entity, Var_SET1)) => 
(((( ! [Var_ELEMENT] : 
 (hasType(type_Entity, Var_ELEMENT) => 
(((f_element(Var_ELEMENT,Var_SET1)) <=> (f_element(Var_ELEMENT,Var_SET2))))))) => (Var_SET1 = Var_SET2))))))))).

fof(axMergeLem105, axiom, 
 ( ! [Var_SET] : 
 (hasType(type_FiniteSet, Var_SET) => 
(( ? [Var_NUMBER] : 
 (hasType(type_NonnegativeInteger, Var_NUMBER) &  
(Var_NUMBER = f_CardinalityFn(Var_SET)))))))).

fof(axMergeLem106, axiom, 
 ( ! [Var_GRAPH] : 
 (hasType(type_Graph, Var_GRAPH) => 
(( ! [Var_NODE1] : 
 (hasType(type_GraphNode, Var_NODE1) => 
(( ! [Var_NODE2] : 
 (hasType(type_GraphNode, Var_NODE2) => 
(((((f_graphPart(Var_NODE1,Var_GRAPH)) & (((f_graphPart(Var_NODE2,Var_GRAPH)) & (Var_NODE1 != Var_NODE2))))) => (( ? [Var_PATH] : 
 (hasType(type_GraphPath, Var_PATH) &  
(( ? [Var_ARC] : 
 (hasType(type_GraphArc, Var_ARC) &  
(((f_links(Var_NODE1,Var_NODE2,Var_ARC)) | (((f_subGraph(Var_PATH,Var_GRAPH)) & (((((f_BeginNodeFn(Var_PATH) = Var_NODE1) & (f_EndNodeFn(Var_PATH) = Var_NODE2))) | (((f_BeginNodeFn(Var_PATH) = Var_NODE2) & (f_EndNodeFn(Var_PATH) = Var_NODE1)))))))))))))))))))))))))).

fof(axMergeLem107, axiom, 
 ( ! [Var_GRAPH] : 
 (hasType(type_Graph, Var_GRAPH) => 
(( ? [Var_ARC2] : 
 ((hasType(type_GraphElement, Var_ARC2) & hasType(type_GraphArc, Var_ARC2) & hasType(type_Entity, Var_ARC2)) &  
(( ? [Var_ARC1] : 
 ((hasType(type_GraphElement, Var_ARC1) & hasType(type_GraphArc, Var_ARC1) & hasType(type_Entity, Var_ARC1)) &  
(( ? [Var_NODE3] : 
 ((hasType(type_GraphElement, Var_NODE3) & hasType(type_GraphNode, Var_NODE3) & hasType(type_Entity, Var_NODE3)) &  
(( ? [Var_NODE2] : 
 ((hasType(type_GraphElement, Var_NODE2) & hasType(type_GraphNode, Var_NODE2) & hasType(type_Entity, Var_NODE2)) &  
(( ? [Var_NODE1] : 
 ((hasType(type_GraphElement, Var_NODE1) & hasType(type_GraphNode, Var_NODE1) & hasType(type_Entity, Var_NODE1)) &  
(((f_graphPart(Var_NODE1,Var_GRAPH)) & (((f_graphPart(Var_NODE2,Var_GRAPH)) & (((f_graphPart(Var_NODE3,Var_GRAPH)) & (((f_graphPart(Var_ARC1,Var_GRAPH)) & (((f_graphPart(Var_ARC2,Var_GRAPH)) & (((f_links(Var_NODE1,Var_NODE2,Var_ARC1)) & (((f_links(Var_NODE2,Var_NODE3,Var_ARC2)) & (((Var_NODE1 != Var_NODE2) & (((Var_NODE2 != Var_NODE3) & (((Var_NODE1 != Var_NODE3) & (Var_ARC1 != Var_ARC2))))))))))))))))))))))))))))))))))))))).

fof(axMergeLem108, axiom, 
 ( ! [Var_GRAPH] : 
 (hasType(type_DirectedGraph, Var_GRAPH) => 
(( ! [Var_ARC] : 
 (hasType(type_GraphArc, Var_ARC) => 
(((f_graphPart(Var_ARC,Var_GRAPH)) => (( ? [Var_NODE2] : 
 (hasType(type_Entity, Var_NODE2) &  
(( ? [Var_NODE1] : 
 (hasType(type_Entity, Var_NODE1) &  
(((f_InitialNodeFn(Var_ARC) = Var_NODE1) & (f_TerminalNodeFn(Var_ARC) = Var_NODE2))))))))))))))))).

fof(axMergeLem109, axiom, 
 ( ! [Var_GRAPH] : 
 (hasType(type_GraphPath, Var_GRAPH) => 
(( ! [Var_ARC] : 
 (hasType(type_GraphArc, Var_ARC) => 
(( ! [Var_NODE] : 
 (hasType(type_Entity, Var_NODE) => 
(((f_graphPart(Var_ARC,Var_GRAPH)) => (((f_InitialNodeFn(Var_ARC) = Var_NODE) => (( ~ ( ? [Var_OTHER] : 
 ((hasType(type_GraphArc, Var_OTHER) & hasType(type_Entity, Var_OTHER)) &  
(((f_InitialNodeFn(Var_OTHER) = Var_NODE) & (Var_OTHER != Var_ARC)))))))))))))))))))).

fof(axMergeLem110, axiom, 
 ( ! [Var_GRAPH] : 
 (hasType(type_GraphPath, Var_GRAPH) => 
(( ! [Var_ARC] : 
 (hasType(type_GraphArc, Var_ARC) => 
(( ! [Var_NODE] : 
 (hasType(type_Entity, Var_NODE) => 
(((f_graphPart(Var_ARC,Var_GRAPH)) => (((f_TerminalNodeFn(Var_ARC) = Var_NODE) => (( ~ ( ? [Var_OTHER] : 
 ((hasType(type_GraphArc, Var_OTHER) & hasType(type_Entity, Var_OTHER)) &  
(((f_TerminalNodeFn(Var_OTHER) = Var_NODE) & (Var_OTHER != Var_ARC)))))))))))))))))))).

fof(axMergeLem111, axiom, 
 ( ! [Var_GRAPH] : 
 (hasType(type_GraphCircuit, Var_GRAPH) => 
(( ? [Var_NODE] : 
 (hasType(type_Entity, Var_NODE) &  
(((f_BeginNodeFn(Var_GRAPH) = Var_NODE) & (f_EndNodeFn(Var_GRAPH) = Var_NODE))))))))).

fof(axMergeLem112, axiom, 
 ( ! [Var_GRAPH] : 
 (hasType(type_MultiGraph, Var_GRAPH) => 
(( ? [Var_NODE2] : 
 ((hasType(type_GraphElement, Var_NODE2) & hasType(type_GraphNode, Var_NODE2)) &  
(( ? [Var_NODE1] : 
 ((hasType(type_GraphElement, Var_NODE1) & hasType(type_GraphNode, Var_NODE1)) &  
(( ? [Var_ARC2] : 
 ((hasType(type_GraphElement, Var_ARC2) & hasType(type_GraphArc, Var_ARC2) & hasType(type_Entity, Var_ARC2)) &  
(( ? [Var_ARC1] : 
 ((hasType(type_GraphElement, Var_ARC1) & hasType(type_GraphArc, Var_ARC1) & hasType(type_Entity, Var_ARC1)) &  
(((f_graphPart(Var_ARC1,Var_GRAPH)) & (((f_graphPart(Var_ARC2,Var_GRAPH)) & (((f_graphPart(Var_NODE1,Var_GRAPH)) & (((f_graphPart(Var_NODE2,Var_GRAPH)) & (((f_links(Var_NODE1,Var_NODE2,Var_ARC1)) & (((f_links(Var_NODE1,Var_NODE2,Var_ARC2)) & (Var_ARC1 != Var_ARC2)))))))))))))))))))))))))))).

fof(axMergeLem113, axiom, 
 ( ! [Var_GRAPH] : 
 (hasType(type_PseudoGraph, Var_GRAPH) => 
(( ? [Var_LOOP] : 
 (hasType(type_GraphLoop, Var_LOOP) &  
(f_graphPart(Var_LOOP,Var_GRAPH)))))))).

fof(axMergeLem114, axiom, 
 ( ! [Var_PART] : 
 (hasType(type_GraphElement, Var_PART) => 
(( ? [Var_GRAPH] : 
 (hasType(type_Graph, Var_GRAPH) &  
(f_graphPart(Var_PART,Var_GRAPH)))))))).

fof(axMergeLem115, axiom, 
 ( ! [Var_NODE] : 
 (hasType(type_GraphNode, Var_NODE) => 
(( ? [Var_ARC] : 
 (hasType(type_GraphArc, Var_ARC) &  
(( ? [Var_OTHER] : 
 (hasType(type_GraphNode, Var_OTHER) &  
(f_links(Var_NODE,Var_OTHER,Var_ARC))))))))))).

fof(axMergeLem116, axiom, 
 ( ! [Var_ARC] : 
 (hasType(type_GraphArc, Var_ARC) => 
(( ? [Var_NODE2] : 
 (hasType(type_GraphNode, Var_NODE2) &  
(( ? [Var_NODE1] : 
 (hasType(type_GraphNode, Var_NODE1) &  
(f_links(Var_NODE1,Var_NODE2,Var_ARC))))))))))).

fof(axMergeLem117, axiom, 
 ( ! [Var_LOOP] : 
 (hasType(type_GraphLoop, Var_LOOP) => 
(( ? [Var_NODE] : 
 (hasType(type_GraphNode, Var_NODE) &  
(f_links(Var_NODE,Var_NODE,Var_LOOP)))))))).

fof(axMergeLem118, axiom, 
 ( ! [Var_ARC] : 
 (hasType(type_GraphArc, Var_ARC) => 
(( ! [Var_NODE2] : 
 (hasType(type_GraphNode, Var_NODE2) => 
(( ! [Var_NODE1] : 
 (hasType(type_GraphNode, Var_NODE1) => 
(((f_links(Var_NODE1,Var_NODE2,Var_ARC)) => (f_links(Var_NODE2,Var_NODE1,Var_ARC))))))))))))).

fof(axMergeLem119, axiom, 
 ( ! [Var_ELEMENT] : 
 (hasType(type_GraphElement, Var_ELEMENT) => 
(( ! [Var_GRAPH2] : 
 (hasType(type_Graph, Var_GRAPH2) => 
(( ! [Var_GRAPH1] : 
 (hasType(type_Graph, Var_GRAPH1) => 
(((((f_subGraph(Var_GRAPH1,Var_GRAPH2)) & (f_graphPart(Var_ELEMENT,Var_GRAPH1)))) => (f_graphPart(Var_ELEMENT,Var_GRAPH2))))))))))))).

fof(axMergeLem120, axiom, 
 ( ! [Var_NUMBER1] : 
 (hasType(type_Quantity, Var_NUMBER1) => 
(( ! [Var_ARC1] : 
 ((hasType(type_GraphElement, Var_ARC1) & hasType(type_GraphArc, Var_ARC1) & hasType(type_Entity, Var_ARC1)) => 
(( ! [Var_SUBPATH] : 
 ((hasType(type_Graph, Var_SUBPATH) & hasType(type_GraphPath, Var_SUBPATH)) => 
(( ! [Var_SUM] : 
 (hasType(type_Entity, Var_SUM) => 
(( ! [Var_PATH] : 
 ((hasType(type_GraphPath, Var_PATH) & hasType(type_Graph, Var_PATH)) => 
(((((f_PathWeightFn(Var_PATH) = Var_SUM) & (((f_subGraph(Var_SUBPATH,Var_PATH)) & (((f_graphPart(Var_ARC1,Var_PATH)) & (((f_arcWeight(Var_ARC1,Var_NUMBER1)) & (( ! [Var_ARC2] : 
 ((hasType(type_GraphElement, Var_ARC2) & hasType(type_Entity, Var_ARC2)) => 
(((f_graphPart(Var_ARC2,Var_PATH)) => (((f_graphPart(Var_ARC2,Var_SUBPATH)) | (Var_ARC2 = Var_ARC1)))))))))))))))) => (Var_SUM = f_AdditionFn(f_PathWeightFn(Var_SUBPATH),Var_NUMBER1))))))))))))))))))).

fof(axMergeLem121, axiom, 
 ( ! [Var_NUMBER2] : 
 (hasType(type_Quantity, Var_NUMBER2) => 
(( ! [Var_NUMBER1] : 
 (hasType(type_Quantity, Var_NUMBER1) => 
(( ! [Var_ARC2] : 
 ((hasType(type_GraphElement, Var_ARC2) & hasType(type_GraphArc, Var_ARC2) & hasType(type_Entity, Var_ARC2)) => 
(( ! [Var_ARC1] : 
 ((hasType(type_GraphElement, Var_ARC1) & hasType(type_GraphArc, Var_ARC1) & hasType(type_Entity, Var_ARC1)) => 
(( ! [Var_SUM] : 
 (hasType(type_Entity, Var_SUM) => 
(( ! [Var_PATH] : 
 ((hasType(type_GraphPath, Var_PATH) & hasType(type_Graph, Var_PATH)) => 
(((((f_PathWeightFn(Var_PATH) = Var_SUM) & (((f_graphPart(Var_ARC1,Var_PATH)) & (((f_graphPart(Var_ARC2,Var_PATH)) & (((f_arcWeight(Var_ARC1,Var_NUMBER1)) & (((f_arcWeight(Var_ARC2,Var_NUMBER2)) & (( ! [Var_ARC3] : 
 ((hasType(type_GraphElement, Var_ARC3) & hasType(type_Entity, Var_ARC3)) => 
(((f_graphPart(Var_ARC3,Var_PATH)) => (((Var_ARC3 = Var_ARC1) | (Var_ARC3 = Var_ARC2)))))))))))))))))) => (f_PathWeightFn(Var_PATH) = f_AdditionFn(Var_NUMBER1,Var_NUMBER2)))))))))))))))))))))).

fof(axMergeLem122, axiom, 
 ( ! [Var_PART] : 
 (hasType(type_Physical, Var_PART) => 
(( ! [Var_SYSTEM] : 
 (hasType(type_PhysicalSystem, Var_SYSTEM) => 
(( ! [Var_SUB] : 
 (hasType(type_PhysicalSystem, Var_SUB) => 
(((((f_subSystem(Var_SUB,Var_SYSTEM)) & (f_systemPart(Var_PART,Var_SUB)))) => (f_systemPart(Var_PART,Var_SYSTEM))))))))))))).

fof(axMergeLem123, axiom, 
 ( ! [Var_M] : 
 (hasType(type_UnitOfMeasure, Var_M) => 
(( ! [Var_G] : 
 (hasType(type_Graph, Var_G) => 
(((f_graphMeasure(Var_G,Var_M)) => (( ! [Var_AC] : 
 ((hasType(type_GraphElement, Var_AC) & hasType(type_Abstract, Var_AC)) => 
(((f_graphPart(Var_AC,Var_G)) & (( ? [Var_PC] : 
 (hasType(type_Physical, Var_PC) &  
(f_abstractCounterpart(Var_AC,Var_PC)))))))))))))))))).

fof(axMergeLem124, axiom, 
 ( ! [Var_AN] : 
 (hasType(type_GraphNode, Var_AN) => 
(( ! [Var_AA] : 
 (hasType(type_GraphArc, Var_AA) => 
(( ! [Var_N] : 
 (hasType(type_RealNumber, Var_N) => 
(( ! [Var_PA] : 
 ((hasType(type_Physical, Var_PA) & hasType(type_Object, Var_PA)) => 
(( ! [Var_PN] : 
 (hasType(type_Physical, Var_PN) => 
(( ! [Var_M] : 
 (hasType(type_UnitOfMeasure, Var_M) => 
(( ! [Var_G] : 
 (hasType(type_Graph, Var_G) => 
(((((f_graphMeasure(Var_G,Var_M)) & (((f_abstractCounterpart(Var_AN,Var_PN)) & (((f_abstractCounterpart(Var_AA,Var_PA)) & (f_arcWeight(Var_AA,f_MeasureFn(Var_N,Var_M))))))))) => (f_measure(Var_PA,f_MeasureFn(Var_N,Var_M)))))))))))))))))))))))))).

fof(axMergeLem125, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfMeasure, Var_UNIT) => 
(( ! [Var_KILOUNIT] : 
 ((hasType(type_Entity, Var_KILOUNIT) & hasType(type_UnitOfMeasure, Var_KILOUNIT)) => 
(((Var_KILOUNIT = f_KiloFn(Var_UNIT)) => (f_MeasureFn(1,Var_KILOUNIT) = f_MeasureFn(1000,Var_UNIT)))))))))).

fof(axMergeLem126, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfMeasure, Var_UNIT) => 
(( ! [Var_MEGAUNIT] : 
 ((hasType(type_Entity, Var_MEGAUNIT) & hasType(type_UnitOfMeasure, Var_MEGAUNIT)) => 
(((Var_MEGAUNIT = f_MegaFn(Var_UNIT)) => (f_MeasureFn(1,Var_MEGAUNIT) = f_MeasureFn(1000000,Var_UNIT)))))))))).

fof(axMergeLem127, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfMeasure, Var_UNIT) => 
(( ! [Var_GIGAUNIT] : 
 ((hasType(type_Entity, Var_GIGAUNIT) & hasType(type_UnitOfMeasure, Var_GIGAUNIT)) => 
(((Var_GIGAUNIT = f_GigaFn(Var_UNIT)) => (f_MeasureFn(1,Var_GIGAUNIT) = f_MeasureFn(1000000000,Var_UNIT)))))))))).

fof(axMergeLem128, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfMeasure, Var_UNIT) => 
(( ! [Var_MILLIUNIT] : 
 ((hasType(type_Entity, Var_MILLIUNIT) & hasType(type_UnitOfMeasure, Var_MILLIUNIT)) => 
(((Var_MILLIUNIT = f_MilliFn(Var_UNIT)) => (f_MeasureFn(1,Var_MILLIUNIT) = f_MeasureFn(1.0e-3,Var_UNIT)))))))))).

fof(axMergeLem129, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfMeasure, Var_UNIT) => 
(( ! [Var_MICROUNIT] : 
 ((hasType(type_Entity, Var_MICROUNIT) & hasType(type_UnitOfMeasure, Var_MICROUNIT)) => 
(((Var_MICROUNIT = f_MicroFn(Var_UNIT)) => (f_MeasureFn(1,Var_MICROUNIT) = f_MeasureFn(1.0e-6,Var_UNIT)))))))))).

fof(axMergeLem130, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfMeasure, Var_UNIT) => 
(( ! [Var_NANOUNIT] : 
 ((hasType(type_Entity, Var_NANOUNIT) & hasType(type_UnitOfMeasure, Var_NANOUNIT)) => 
(((Var_NANOUNIT = f_NanoFn(Var_UNIT)) => (f_MeasureFn(1,Var_NANOUNIT) = f_MeasureFn(1.0e-9,Var_UNIT)))))))))).

fof(axMergeLem131, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfMeasure, Var_UNIT) => 
(( ! [Var_PICOUNIT] : 
 ((hasType(type_Entity, Var_PICOUNIT) & hasType(type_UnitOfMeasure, Var_PICOUNIT)) => 
(((Var_PICOUNIT = f_PicoFn(Var_UNIT)) => (f_MeasureFn(1,Var_PICOUNIT) = f_MeasureFn(1.0e-12,Var_UNIT)))))))))).

fof(axMergeLem132, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfMeasure, Var_UNIT) => 
(( ! [Var_QUANT] : 
 ((hasType(type_Entity, Var_QUANT) & hasType(type_PhysicalQuantity, Var_QUANT)) => 
(( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER)) => 
(((((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) & (Var_QUANT = f_MeasureFn(Var_NUMBER,Var_UNIT)))) => (f_MagnitudeFn(Var_QUANT) = Var_NUMBER)))))))))))).

fof(axMergeLem133, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfMeasure, Var_UNIT) => 
(( ! [Var_QUANT] : 
 ((hasType(type_Entity, Var_QUANT) & hasType(type_PhysicalQuantity, Var_QUANT)) => 
(( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER)) => 
(((((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) & (Var_QUANT = f_MeasureFn(Var_NUMBER,Var_UNIT)))) => (f_UnitFn(Var_QUANT) = Var_UNIT)))))))))))).

fof(axMergeLem134, axiom, 
 ( ! [Var_DIRECTION] : 
 (hasType(type_DirectionalAttribute, Var_DIRECTION) => 
(( ! [Var_REF] : 
 (hasType(type_Region, Var_REF) => 
(( ! [Var_TIME] : 
 (hasType(type_TimeDuration, Var_TIME) => 
(( ! [Var_DISTANCE] : 
 (hasType(type_LengthMeasure, Var_DISTANCE) => 
(( ! [Var_OBJECT] : 
 (hasType(type_Object, Var_OBJECT) => 
(((f_measure(Var_OBJECT,f_VelocityFn(Var_DISTANCE,Var_TIME,Var_REF,Var_DIRECTION))) => (f_measure(Var_OBJECT,f_SpeedFn(Var_DISTANCE,Var_TIME)))))))))))))))))))).

fof(axMergeLem135, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_Centimeter) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,1.0e-2),inst_Meter))))))).

fof(axMergeLem136, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_Millimeter) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,1.0e-3),inst_Meter))))))).

fof(axMergeLem137, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_Kilometer) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,1000),inst_Meter))))))).

fof(axMergeLem138, axiom, 
 ( ! [Var_N] : 
 (hasType(type_RealNumber, Var_N) => 
(f_MeasureFn(Var_N,inst_Horsepower) = f_MeasureFn(f_MultiplicationFn(Var_N,746),inst_Watt))))).

fof(axMergeLem139, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_CelsiusDegree) = f_MeasureFn(f_SubtractionFn(Var_NUMBER,273.15),inst_KelvinDegree))))))).

fof(axMergeLem140, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_CelsiusDegree) = f_MeasureFn(f_DivisionFn(f_SubtractionFn(Var_NUMBER,32),1.8),inst_FahrenheitDegree))))))).

fof(axMergeLem141, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_DayDuration) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,24),inst_HourDuration))))))).

fof(axMergeLem142, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_HourDuration) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,60),inst_MinuteDuration))))))).

fof(axMergeLem143, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_MinuteDuration) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,60),inst_SecondDuration))))))).

fof(axMergeLem144, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_WeekDuration) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,7),inst_DayDuration))))))).

fof(axMergeLem145, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_greaterThanOrEqualTo(f_MeasureFn(Var_NUMBER,inst_MonthDuration),f_MeasureFn(f_MultiplicationFn(Var_NUMBER,28),inst_DayDuration)))))))).

fof(axMergeLem146, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_lessThanOrEqualTo(f_MeasureFn(Var_NUMBER,inst_MonthDuration),f_MeasureFn(f_MultiplicationFn(Var_NUMBER,31),inst_DayDuration)))))))).

fof(axMergeLem147, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_YearDuration) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,365),inst_DayDuration))))))).

fof(axMergeLem148, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_FootLength) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,0.3048),inst_Meter))))))).

fof(axMergeLem149, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_Inch) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,2.54e-2),inst_Meter))))))).

fof(axMergeLem150, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_Mile) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,1609.344),inst_Meter))))))).

fof(axMergeLem151, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_UnitedStatesGallon) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,3.785411784),inst_Liter))))))).

fof(axMergeLem152, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_Quart) = f_MeasureFn(f_DivisionFn(Var_NUMBER,4),inst_UnitedStatesGallon))))))).

fof(axMergeLem153, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_Pint) = f_MeasureFn(f_DivisionFn(Var_NUMBER,2),inst_Quart))))))).

fof(axMergeLem154, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_Cup) = f_MeasureFn(f_DivisionFn(Var_NUMBER,2),inst_Pint))))))).

fof(axMergeLem155, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_Ounce) = f_MeasureFn(f_DivisionFn(Var_NUMBER,8),inst_Cup))))))).

fof(axMergeLem156, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_UnitedKingdomGallon) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,4.54609),inst_Liter))))))).

fof(axMergeLem157, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_Kilogram) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,1000),inst_Gram))))))).

fof(axMergeLem158, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_PoundMass) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,453.59237),inst_Gram))))))).

fof(axMergeLem159, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_Slug) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,14593.9),inst_Gram))))))).

fof(axMergeLem160, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_RankineDegree) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,1.8),inst_KelvinDegree))))))).

fof(axMergeLem161, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_PoundForce) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,4.448222),inst_Newton))))))).

fof(axMergeLem162, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_Calorie) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,4.1868),inst_Joule))))))).

fof(axMergeLem163, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_BritishThermalUnit) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,1055.05585262),inst_Joule))))))).

fof(axMergeLem164, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_AngularDegree) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,f_DivisionFn(inst_Pi,180)),inst_Radian))))))).

fof(axMergeLem165, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(( ! [Var_ANGLE] : 
 (hasType(type_Object, Var_ANGLE) => 
(((f_measure(Var_ANGLE,f_MeasureFn(Var_NUMBER,inst_AngularDegree))) => (((f_greaterThanOrEqualTo(Var_NUMBER,0)) & (f_lessThanOrEqualTo(Var_NUMBER,360)))))))))))).

fof(axMergeLem166, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_UnitedStatesCent) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,1.0e-2),inst_UnitedStatesDollar))))))).

fof(axMergeLem167, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_EuroCent) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,1.0e-2),inst_EuroDollar))))))).

fof(axMergeLem168, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_Byte) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,8),inst_Bit))))))).

fof(axMergeLem169, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_KiloByte) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,1024),inst_Byte))))))).

fof(axMergeLem170, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_MegaByte) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,1024),inst_KiloByte))))))).

fof(axMergeLem171, axiom, 
 ( ! [Var_TIME] : 
 (hasType(type_TimePoint, Var_TIME) => 
(( ! [Var_DURATION] : 
 (hasType(type_TimeDuration, Var_DURATION) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Object, Var_OBJ) & hasType(type_Physical, Var_OBJ)) => 
(((f_holdsDuring(Var_TIME,age(Var_OBJ,Var_DURATION))) => (f_duration(f_TimeIntervalFn(f_BeginFn(f_WhenFn(Var_OBJ)),Var_TIME),Var_DURATION))))))))))))).

fof(axMergeLem172, axiom, 
 ( ! [Var_M] : 
 ((hasType(type_PhysicalQuantity, Var_M) & hasType(type_Quantity, Var_M)) => 
(( ! [Var_O] : 
 (hasType(type_Object, Var_O) => 
(((f_length(Var_O,Var_M)) => (( ~ ( ? [Var_M2] : 
 ((hasType(type_LengthMeasure, Var_M2) & hasType(type_Quantity, Var_M2)) &  
(((f_linearExtent(Var_O,Var_M2)) & (f_greaterThan(Var_M2,Var_M)))))))))))))))).

fof(axMergeLem173, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Circle, Var_C) => 
(( ? [Var_R] : 
 (hasType(type_LengthMeasure, Var_R) &  
(f_radius(Var_C,Var_R)))))))).

fof(axMergeLem174, axiom, 
 ( ! [Var_C] : 
 (hasType(type_Circle, Var_C) => 
(( ? [Var_P] : 
 (hasType(type_Entity, Var_P) &  
(f_CenterOfCircleFn(Var_C) = Var_P))))))).

fof(axMergeLem175, axiom, 
 ( ! [Var_RADIUS] : 
 (hasType(type_LengthMeasure, Var_RADIUS) => 
(( ! [Var_CIRCLE] : 
 ((hasType(type_Circle, Var_CIRCLE) & hasType(type_GeometricFigure, Var_CIRCLE)) => 
(((f_radius(Var_CIRCLE,Var_RADIUS)) => (( ? [Var_POINT] : 
 (hasType(type_GeometricPoint, Var_POINT) &  
(( ! [Var_PART] : 
 ((hasType(type_GeometricFigure, Var_PART) & hasType(type_GeometricPoint, Var_PART)) => 
(((f_pointOfFigure(Var_PART,Var_CIRCLE)) => (f_geometricDistance(Var_PART,Var_POINT,Var_RADIUS)))))))))))))))))).

fof(axMergeLem176, axiom, 
 ( ! [Var_LENGTH] : 
 ((hasType(type_LengthMeasure, Var_LENGTH) & hasType(type_Entity, Var_LENGTH)) => 
(( ! [Var_CIRCLE] : 
 (hasType(type_Circle, Var_CIRCLE) => 
(((f_diameter(Var_CIRCLE,Var_LENGTH)) => (( ? [Var_HALF] : 
 ((hasType(type_LengthMeasure, Var_HALF) & hasType(type_Quantity, Var_HALF)) &  
(((f_radius(Var_CIRCLE,Var_HALF)) & (f_MultiplicationFn(Var_HALF,2) = Var_LENGTH)))))))))))))).

fof(axMergeLem177, axiom, 
 ( ! [Var_QUANT] : 
 (hasType(type_LengthMeasure, Var_QUANT) => 
(( ! [Var_OBJ2] : 
 (hasType(type_Physical, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Physical, Var_OBJ1) => 
(((f_distance(Var_OBJ1,Var_OBJ2,Var_QUANT)) => (f_distance(Var_OBJ2,Var_OBJ1,Var_QUANT))))))))))))).

fof(axMergeLem178, axiom, 
 ( ! [Var_HEIGHT] : 
 (hasType(type_LengthMeasure, Var_HEIGHT) => 
(( ! [Var_OBJ2] : 
 ((hasType(type_Physical, Var_OBJ2) & hasType(type_Object, Var_OBJ2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_Physical, Var_OBJ1) & hasType(type_Object, Var_OBJ1)) => 
(((f_altitude(Var_OBJ1,Var_OBJ2,Var_HEIGHT)) => (f_orientation(Var_OBJ1,Var_OBJ2,inst_Above))))))))))))).

fof(axMergeLem179, axiom, 
 ( ! [Var_HEIGHT] : 
 (hasType(type_LengthMeasure, Var_HEIGHT) => 
(( ! [Var_OBJ2] : 
 (hasType(type_Physical, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_Physical, Var_OBJ1) & hasType(type_SelfConnectedObject, Var_OBJ1)) => 
(((f_altitude(Var_OBJ1,Var_OBJ2,Var_HEIGHT)) => (( ? [Var_TOP] : 
 ((hasType(type_SelfConnectedObject, Var_TOP) & hasType(type_Physical, Var_TOP)) &  
(((f_top(Var_TOP,Var_OBJ1)) & (f_distance(Var_TOP,Var_OBJ2,Var_HEIGHT)))))))))))))))))).

fof(axMergeLem180, axiom, 
 ( ! [Var_DEPTH] : 
 (hasType(type_LengthMeasure, Var_DEPTH) => 
(( ! [Var_OBJ2] : 
 ((hasType(type_Physical, Var_OBJ2) & hasType(type_Object, Var_OBJ2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_Physical, Var_OBJ1) & hasType(type_Object, Var_OBJ1)) => 
(((f_depth(Var_OBJ1,Var_OBJ2,Var_DEPTH)) => (f_orientation(Var_OBJ1,Var_OBJ2,inst_Below))))))))))))).

fof(axMergeLem181, axiom, 
 ( ! [Var_DEPTH] : 
 (hasType(type_LengthMeasure, Var_DEPTH) => 
(( ! [Var_OBJ2] : 
 (hasType(type_Physical, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_Physical, Var_OBJ1) & hasType(type_SelfConnectedObject, Var_OBJ1)) => 
(((f_depth(Var_OBJ1,Var_OBJ2,Var_DEPTH)) => (( ? [Var_BOTTOM] : 
 ((hasType(type_SelfConnectedObject, Var_BOTTOM) & hasType(type_Physical, Var_BOTTOM)) &  
(((f_bottom(Var_BOTTOM,Var_OBJ1)) & (f_distance(Var_BOTTOM,Var_OBJ2,Var_DEPTH)))))))))))))))))).

fof(axMergeLem182, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_larger(Var_OBJ1,Var_OBJ2)) <=> (( ! [Var_UNIT] : 
 (hasType(type_UnitOfLength, Var_UNIT) => 
(( ! [Var_QUANT2] : 
 ((hasType(type_RealNumber, Var_QUANT2) & hasType(type_Quantity, Var_QUANT2)) => 
(( ! [Var_QUANT1] : 
 ((hasType(type_RealNumber, Var_QUANT1) & hasType(type_Quantity, Var_QUANT1)) => 
(((((f_measure(Var_OBJ1,f_MeasureFn(Var_QUANT1,Var_UNIT))) & (f_measure(Var_OBJ2,f_MeasureFn(Var_QUANT2,Var_UNIT))))) => (f_greaterThan(Var_QUANT1,Var_QUANT2))))))))))))))))))))).

fof(axMergeLem183, axiom, 
 ( ! [Var_AMOUNT] : 
 ((hasType(type_Entity, Var_AMOUNT) & hasType(type_CurrencyMeasure, Var_AMOUNT)) => 
(( ! [Var_PERSON] : 
 (hasType(type_Agent, Var_PERSON) => 
(((f_WealthFn(Var_PERSON) = Var_AMOUNT) <=> (f_monetaryValue(f_PropertyFn(Var_PERSON),Var_AMOUNT)))))))))).

fof(axMergeLem184, axiom, 
 ( ! [Var_POINT] : 
 (hasType(type_TimePoint, Var_POINT) => 
(((Var_POINT != inst_PositiveInfinity) => (f_before(Var_POINT,inst_PositiveInfinity))))))).

fof(axMergeLem185, axiom, 
 ( ! [Var_POINT] : 
 (hasType(type_TimePoint, Var_POINT) => 
(((Var_POINT != inst_PositiveInfinity) => (( ? [Var_OTHERPOINT] : 
 (hasType(type_TimePoint, Var_OTHERPOINT) &  
(f_temporallyBetween(Var_POINT,Var_OTHERPOINT,inst_PositiveInfinity)))))))))).

fof(axMergeLem186, axiom, 
 ( ! [Var_POINT] : 
 (hasType(type_TimePoint, Var_POINT) => 
(((Var_POINT != inst_NegativeInfinity) => (f_before(inst_NegativeInfinity,Var_POINT))))))).

fof(axMergeLem187, axiom, 
 ( ! [Var_POINT] : 
 (hasType(type_TimePoint, Var_POINT) => 
(((Var_POINT != inst_NegativeInfinity) => (( ? [Var_OTHERPOINT] : 
 (hasType(type_TimePoint, Var_OTHERPOINT) &  
(f_temporallyBetween(inst_NegativeInfinity,Var_OTHERPOINT,Var_POINT)))))))))).

fof(axMergeLem188, axiom, 
 ( ! [Var_POINT] : 
 (hasType(type_TimePoint, Var_POINT) => 
(( ? [Var_INTERVAL] : 
 (hasType(type_TimeInterval, Var_INTERVAL) &  
(f_temporalPart(Var_POINT,Var_INTERVAL)))))))).

fof(axMergeLem189, axiom, 
 ( ! [Var_INTERVAL] : 
 (hasType(type_TimeInterval, Var_INTERVAL) => 
(( ? [Var_POINT] : 
 (hasType(type_TimePoint, Var_POINT) &  
(f_temporalPart(Var_POINT,Var_INTERVAL)))))))).

fof(axMergeLem190, axiom, 
 ( ! [Var_THING] : 
 (hasType(type_Physical, Var_THING) => 
(( ! [Var_POS] : 
 (hasType(type_TimePosition, Var_POS) => 
(((f_temporalPart(Var_POS,f_WhenFn(Var_THING))) <=> (f_time(Var_THING,Var_POS)))))))))).

fof(axMergeLem191, axiom, 
 ( ! [Var_OBJ] : 
 ((hasType(type_Object, Var_OBJ) & hasType(type_Physical, Var_OBJ)) => 
(( ! [Var_PROCESS] : 
 ((hasType(type_Process, Var_PROCESS) & hasType(type_Physical, Var_PROCESS)) => 
(((f_origin(Var_PROCESS,Var_OBJ)) => (f_located(f_WhereFn(Var_PROCESS,f_BeginFn(f_WhenFn(Var_PROCESS))),f_WhereFn(Var_OBJ,f_BeginFn(f_WhenFn(Var_OBJ))))))))))))).

fof(axMergeLem192, axiom, 
 ( ! [Var_POINT] : 
 ((hasType(type_Entity, Var_POINT) & hasType(type_TimePoint, Var_POINT)) => 
(( ! [Var_INTERVAL] : 
 ((hasType(type_TimeInterval, Var_INTERVAL) & hasType(type_TimePosition, Var_INTERVAL)) => 
(((f_BeginFn(Var_INTERVAL) = Var_POINT) => (( ! [Var_OTHERPOINT] : 
 ((hasType(type_TimePosition, Var_OTHERPOINT) & hasType(type_Entity, Var_OTHERPOINT) & hasType(type_TimePoint, Var_OTHERPOINT)) => 
(((((f_temporalPart(Var_OTHERPOINT,Var_INTERVAL)) & (Var_OTHERPOINT != Var_POINT))) => (f_before(Var_POINT,Var_OTHERPOINT))))))))))))))).

fof(axMergeLem193, axiom, 
 ( ! [Var_POINT] : 
 ((hasType(type_Entity, Var_POINT) & hasType(type_TimePoint, Var_POINT)) => 
(( ! [Var_INTERVAL] : 
 ((hasType(type_TimeInterval, Var_INTERVAL) & hasType(type_TimePosition, Var_INTERVAL)) => 
(((f_EndFn(Var_INTERVAL) = Var_POINT) => (( ! [Var_OTHERPOINT] : 
 ((hasType(type_TimePosition, Var_OTHERPOINT) & hasType(type_Entity, Var_OTHERPOINT) & hasType(type_TimePoint, Var_OTHERPOINT)) => 
(((((f_temporalPart(Var_OTHERPOINT,Var_INTERVAL)) & (Var_OTHERPOINT != Var_POINT))) => (f_before(Var_OTHERPOINT,Var_POINT))))))))))))))).

fof(axMergeLem194, axiom, 
 ( ! [Var_INTERVAL2] : 
 (hasType(type_TimeInterval, Var_INTERVAL2) => 
(( ! [Var_INTERVAL1] : 
 (hasType(type_TimeInterval, Var_INTERVAL1) => 
(((f_starts(Var_INTERVAL1,Var_INTERVAL2)) <=> (((f_BeginFn(Var_INTERVAL1) = f_BeginFn(Var_INTERVAL2)) & (f_before(f_EndFn(Var_INTERVAL1),f_EndFn(Var_INTERVAL2))))))))))))).

fof(axMergeLem195, axiom, 
 ( ! [Var_INTERVAL2] : 
 (hasType(type_TimeInterval, Var_INTERVAL2) => 
(( ! [Var_INTERVAL1] : 
 (hasType(type_TimeInterval, Var_INTERVAL1) => 
(((f_finishes(Var_INTERVAL1,Var_INTERVAL2)) <=> (((f_before(f_BeginFn(Var_INTERVAL2),f_BeginFn(Var_INTERVAL1))) & (f_EndFn(Var_INTERVAL2) = f_EndFn(Var_INTERVAL1)))))))))))).

fof(axMergeLem196, axiom, 
 ( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(( ? [Var_TIME1] : 
 (hasType(type_TimePoint, Var_TIME1) &  
(( ? [Var_TIME2] : 
 (hasType(type_TimePoint, Var_TIME2) &  
(((f_before(Var_TIME1,Var_TIME2)) & (( ! [Var_TIME] : 
 ((hasType(type_TimePoint, Var_TIME) & hasType(type_TimePosition, Var_TIME)) => 
(((((f_beforeOrEqual(Var_TIME1,Var_TIME)) & (f_beforeOrEqual(Var_TIME,Var_TIME2)))) => (f_time(Var_OBJ,Var_TIME)))))))))))))))))).

fof(axMergeLem197, axiom, 
 ( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Physical, Var_OBJ)) => 
(( ! [Var_PROC] : 
 ((hasType(type_Process, Var_PROC) & hasType(type_Physical, Var_PROC)) => 
(((f_result(Var_PROC,Var_OBJ)) => (( ! [Var_TIME] : 
 ((hasType(type_TimePoint, Var_TIME) & hasType(type_TimePosition, Var_TIME)) => 
(((f_before(Var_TIME,f_BeginFn(f_WhenFn(Var_PROC)))) => (( ~ (f_time(Var_OBJ,Var_TIME))))))))))))))))).

fof(axMergeLem198, axiom, 
 ( ! [Var_INTERVAL] : 
 (hasType(type_TimeInterval, Var_INTERVAL) => 
(f_before(f_BeginFn(Var_INTERVAL),f_EndFn(Var_INTERVAL)))))).

fof(axMergeLem199, axiom, 
 ( ! [Var_POINT2] : 
 ((hasType(type_TimePoint, Var_POINT2) & hasType(type_Entity, Var_POINT2)) => 
(( ! [Var_POINT1] : 
 ((hasType(type_TimePoint, Var_POINT1) & hasType(type_Entity, Var_POINT1)) => 
(((f_beforeOrEqual(Var_POINT1,Var_POINT2)) => (((f_before(Var_POINT1,Var_POINT2)) | (Var_POINT1 = Var_POINT2))))))))))).

fof(axMergeLem200, axiom, 
 ( ! [Var_POINT3] : 
 (hasType(type_TimePoint, Var_POINT3) => 
(( ! [Var_POINT2] : 
 (hasType(type_TimePoint, Var_POINT2) => 
(( ! [Var_POINT1] : 
 (hasType(type_TimePoint, Var_POINT1) => 
(((f_temporallyBetween(Var_POINT1,Var_POINT2,Var_POINT3)) <=> (((f_before(Var_POINT1,Var_POINT2)) & (f_before(Var_POINT2,Var_POINT3))))))))))))))).

fof(axMergeLem201, axiom, 
 ( ! [Var_POINT3] : 
 (hasType(type_TimePoint, Var_POINT3) => 
(( ! [Var_POINT2] : 
 (hasType(type_TimePoint, Var_POINT2) => 
(( ! [Var_POINT1] : 
 (hasType(type_TimePoint, Var_POINT1) => 
(((f_temporallyBetweenOrEqual(Var_POINT1,Var_POINT2,Var_POINT3)) <=> (((f_beforeOrEqual(Var_POINT1,Var_POINT2)) & (f_beforeOrEqual(Var_POINT2,Var_POINT3))))))))))))))).

fof(axMergeLem202, axiom, 
 ( ! [Var_TIME] : 
 (hasType(type_TimePoint, Var_TIME) => 
(( ! [Var_PHYS] : 
 (hasType(type_Physical, Var_PHYS) => 
(((f_time(Var_PHYS,Var_TIME)) <=> (f_temporallyBetweenOrEqual(f_BeginFn(f_WhenFn(Var_PHYS)),Var_TIME,f_EndFn(f_WhenFn(Var_PHYS)))))))))))).

fof(axMergeLem203, axiom, 
 ( ! [Var_INTERVAL2] : 
 ((hasType(type_TimeInterval, Var_INTERVAL2) & hasType(type_TimePosition, Var_INTERVAL2)) => 
(( ! [Var_INTERVAL1] : 
 ((hasType(type_TimeInterval, Var_INTERVAL1) & hasType(type_TimePosition, Var_INTERVAL1)) => 
(((f_overlapsTemporally(Var_INTERVAL1,Var_INTERVAL2)) <=> (( ? [Var_INTERVAL3] : 
 (hasType(type_TimeInterval, Var_INTERVAL3) &  
(((f_temporalPart(Var_INTERVAL3,Var_INTERVAL1)) & (f_temporalPart(Var_INTERVAL3,Var_INTERVAL2))))))))))))))).

fof(axMergeLem204, axiom, 
 ( ! [Var_INTERVAL2] : 
 (hasType(type_TimeInterval, Var_INTERVAL2) => 
(( ! [Var_INTERVAL1] : 
 (hasType(type_TimeInterval, Var_INTERVAL1) => 
(((f_during(Var_INTERVAL1,Var_INTERVAL2)) => (((f_before(f_EndFn(Var_INTERVAL1),f_EndFn(Var_INTERVAL2))) & (f_before(f_BeginFn(Var_INTERVAL2),f_BeginFn(Var_INTERVAL1))))))))))))).

fof(axMergeLem205, axiom, 
 ( ! [Var_INTERVAL2] : 
 (hasType(type_TimeInterval, Var_INTERVAL2) => 
(( ! [Var_INTERVAL1] : 
 (hasType(type_TimeInterval, Var_INTERVAL1) => 
(((f_meetsTemporally(Var_INTERVAL1,Var_INTERVAL2)) <=> (f_EndFn(Var_INTERVAL1) = f_BeginFn(Var_INTERVAL2)))))))))).

fof(axMergeLem206, axiom, 
 ( ! [Var_INTERVAL2] : 
 ((hasType(type_TimeInterval, Var_INTERVAL2) & hasType(type_Entity, Var_INTERVAL2)) => 
(( ! [Var_INTERVAL1] : 
 ((hasType(type_TimeInterval, Var_INTERVAL1) & hasType(type_Entity, Var_INTERVAL1)) => 
(((((f_BeginFn(Var_INTERVAL1) = f_BeginFn(Var_INTERVAL2)) & (f_EndFn(Var_INTERVAL1) = f_EndFn(Var_INTERVAL2)))) => (Var_INTERVAL1 = Var_INTERVAL2))))))))).

fof(axMergeLem207, axiom, 
 ( ! [Var_INTERVAL2] : 
 (hasType(type_TimeInterval, Var_INTERVAL2) => 
(( ! [Var_INTERVAL1] : 
 (hasType(type_TimeInterval, Var_INTERVAL1) => 
(((f_earlier(Var_INTERVAL1,Var_INTERVAL2)) <=> (f_before(f_EndFn(Var_INTERVAL1),f_BeginFn(Var_INTERVAL2))))))))))).

fof(axMergeLem208, axiom, 
 ( ! [Var_PHYS2] : 
 (hasType(type_Physical, Var_PHYS2) => 
(( ! [Var_PHYS1] : 
 (hasType(type_Physical, Var_PHYS1) => 
(((f_cooccur(Var_PHYS1,Var_PHYS2)) <=> (f_WhenFn(Var_PHYS1) = f_WhenFn(Var_PHYS2)))))))))).

fof(axMergeLem209, axiom, 
 ( ! [Var_POINT1] : 
 (hasType(type_TimePoint, Var_POINT1) => 
(( ! [Var_POINT2] : 
 (hasType(type_TimePoint, Var_POINT2) => 
(( ! [Var_INTERVAL] : 
 (hasType(type_TimeInterval, Var_INTERVAL) => 
(((f_TimeIntervalFn(Var_POINT1,Var_POINT2) = Var_INTERVAL) => (((f_BeginFn(Var_INTERVAL) = Var_POINT1) & (f_EndFn(Var_INTERVAL) = Var_POINT2)))))))))))))).

fof(axMergeLem210, axiom, 
 ( ! [Var_POINT1] : 
 (hasType(type_TimePoint, Var_POINT1) => 
(( ! [Var_POINT2] : 
 (hasType(type_TimePoint, Var_POINT2) => 
(( ! [Var_INTERVAL] : 
 (hasType(type_TimeInterval, Var_INTERVAL) => 
(((f_TimeIntervalFn(Var_POINT1,Var_POINT2) = Var_INTERVAL) => (( ! [Var_POINT] : 
 ((hasType(type_TimePoint, Var_POINT) & hasType(type_TimePosition, Var_POINT)) => 
(((f_temporallyBetweenOrEqual(Var_POINT1,Var_POINT,Var_POINT2)) <=> (f_temporalPart(Var_POINT,Var_INTERVAL)))))))))))))))))).

fof(axMergeLem211, axiom, 
 ( ! [Var_INTERVAL] : 
 (hasType(type_TimeInterval, Var_INTERVAL) => 
(f_meetsTemporally(f_PastFn(Var_INTERVAL),Var_INTERVAL))))).

fof(axMergeLem212, axiom, 
 ( ! [Var_INTERVAL] : 
 (hasType(type_TimeInterval, Var_INTERVAL) => 
(f_PastFn(Var_INTERVAL) = f_TimeIntervalFn(inst_NegativeInfinity,f_BeginFn(Var_INTERVAL)))))).

fof(axMergeLem213, axiom, 
 ( ! [Var_INTERVAL] : 
 (hasType(type_TimeInterval, Var_INTERVAL) => 
(f_finishes(f_ImmediatePastFn(Var_INTERVAL),f_PastFn(Var_INTERVAL)))))).

fof(axMergeLem214, axiom, 
 ( ! [Var_INTERVAL] : 
 (hasType(type_TimeInterval, Var_INTERVAL) => 
(f_meetsTemporally(Var_INTERVAL,f_FutureFn(Var_INTERVAL)))))).

fof(axMergeLem215, axiom, 
 ( ! [Var_INTERVAL] : 
 (hasType(type_TimeInterval, Var_INTERVAL) => 
(f_FutureFn(Var_INTERVAL) = f_TimeIntervalFn(f_EndFn(Var_INTERVAL),inst_PositiveInfinity))))).

fof(axMergeLem216, axiom, 
 ( ! [Var_INTERVAL] : 
 (hasType(type_TimeInterval, Var_INTERVAL) => 
(f_starts(f_ImmediateFutureFn(Var_INTERVAL),f_FutureFn(Var_INTERVAL)))))).

fof(axMergeLem217, axiom, 
 ( ! [Var_YEAR] : 
 (hasType(type_Year, Var_YEAR) => 
(f_duration(Var_YEAR,f_MeasureFn(1,inst_YearDuration)))))).

fof(axMergeLem218, axiom, 
 ( ! [Var_YEAR1] : 
 (hasType(type_Year, Var_YEAR1) => 
(( ! [Var_YEAR2] : 
 (hasType(type_Year, Var_YEAR2) => 
(((f_SubtractionFn(Var_YEAR2,Var_YEAR1) = 1) => (f_meetsTemporally(Var_YEAR1,Var_YEAR2)))))))))).

fof(axMergeLem219, axiom, 
 ( ! [Var_MONTH] : 
 (hasType(type_January, Var_MONTH) => 
(f_duration(Var_MONTH,f_MeasureFn(31,inst_DayDuration)))))).

fof(axMergeLem220, axiom, 
 ( ! [Var_MONTH] : 
 (hasType(type_March, Var_MONTH) => 
(f_duration(Var_MONTH,f_MeasureFn(31,inst_DayDuration)))))).

fof(axMergeLem221, axiom, 
 ( ! [Var_MONTH] : 
 (hasType(type_April, Var_MONTH) => 
(f_duration(Var_MONTH,f_MeasureFn(30,inst_DayDuration)))))).

fof(axMergeLem222, axiom, 
 ( ! [Var_MONTH] : 
 (hasType(type_May, Var_MONTH) => 
(f_duration(Var_MONTH,f_MeasureFn(31,inst_DayDuration)))))).

fof(axMergeLem223, axiom, 
 ( ! [Var_MONTH] : 
 (hasType(type_June, Var_MONTH) => 
(f_duration(Var_MONTH,f_MeasureFn(30,inst_DayDuration)))))).

fof(axMergeLem224, axiom, 
 ( ! [Var_MONTH] : 
 (hasType(type_July, Var_MONTH) => 
(f_duration(Var_MONTH,f_MeasureFn(31,inst_DayDuration)))))).

fof(axMergeLem225, axiom, 
 ( ! [Var_MONTH] : 
 (hasType(type_August, Var_MONTH) => 
(f_duration(Var_MONTH,f_MeasureFn(31,inst_DayDuration)))))).

fof(axMergeLem226, axiom, 
 ( ! [Var_MONTH] : 
 (hasType(type_September, Var_MONTH) => 
(f_duration(Var_MONTH,f_MeasureFn(30,inst_DayDuration)))))).

fof(axMergeLem227, axiom, 
 ( ! [Var_MONTH] : 
 (hasType(type_October, Var_MONTH) => 
(f_duration(Var_MONTH,f_MeasureFn(31,inst_DayDuration)))))).

fof(axMergeLem228, axiom, 
 ( ! [Var_MONTH] : 
 (hasType(type_November, Var_MONTH) => 
(f_duration(Var_MONTH,f_MeasureFn(30,inst_DayDuration)))))).

fof(axMergeLem229, axiom, 
 ( ! [Var_MONTH] : 
 (hasType(type_December, Var_MONTH) => 
(f_duration(Var_MONTH,f_MeasureFn(31,inst_DayDuration)))))).

fof(axMergeLem230, axiom, 
 ( ! [Var_DAY] : 
 (hasType(type_Day, Var_DAY) => 
(f_duration(Var_DAY,f_MeasureFn(1,inst_DayDuration)))))).

fof(axMergeLem231, axiom, 
 ( ! [Var_DAY1] : 
 (hasType(type_Monday, Var_DAY1) => 
(( ! [Var_DAY2] : 
 (hasType(type_Tuesday, Var_DAY2) => 
(( ! [Var_WEEK] : 
 (hasType(type_Week, Var_WEEK) => 
(((((f_temporalPart(Var_DAY1,Var_WEEK)) & (f_temporalPart(Var_DAY2,Var_WEEK)))) => (f_meetsTemporally(Var_DAY1,Var_DAY2))))))))))))).

fof(axMergeLem232, axiom, 
 ( ! [Var_DAY1] : 
 (hasType(type_Tuesday, Var_DAY1) => 
(( ! [Var_DAY2] : 
 (hasType(type_Wednesday, Var_DAY2) => 
(( ! [Var_WEEK] : 
 (hasType(type_Week, Var_WEEK) => 
(((((f_temporalPart(Var_DAY1,Var_WEEK)) & (f_temporalPart(Var_DAY2,Var_WEEK)))) => (f_meetsTemporally(Var_DAY1,Var_DAY2))))))))))))).

fof(axMergeLem233, axiom, 
 ( ! [Var_DAY1] : 
 (hasType(type_Wednesday, Var_DAY1) => 
(( ! [Var_DAY2] : 
 (hasType(type_Thursday, Var_DAY2) => 
(( ! [Var_WEEK] : 
 (hasType(type_Week, Var_WEEK) => 
(((((f_temporalPart(Var_DAY1,Var_WEEK)) & (f_temporalPart(Var_DAY2,Var_WEEK)))) => (f_meetsTemporally(Var_DAY1,Var_DAY2))))))))))))).

fof(axMergeLem234, axiom, 
 ( ! [Var_DAY1] : 
 (hasType(type_Thursday, Var_DAY1) => 
(( ! [Var_DAY2] : 
 (hasType(type_Friday, Var_DAY2) => 
(( ! [Var_WEEK] : 
 (hasType(type_Week, Var_WEEK) => 
(((((f_temporalPart(Var_DAY1,Var_WEEK)) & (f_temporalPart(Var_DAY2,Var_WEEK)))) => (f_meetsTemporally(Var_DAY1,Var_DAY2))))))))))))).

fof(axMergeLem235, axiom, 
 ( ! [Var_DAY1] : 
 (hasType(type_Friday, Var_DAY1) => 
(( ! [Var_DAY2] : 
 (hasType(type_Saturday, Var_DAY2) => 
(( ! [Var_WEEK] : 
 (hasType(type_Week, Var_WEEK) => 
(((((f_temporalPart(Var_DAY1,Var_WEEK)) & (f_temporalPart(Var_DAY2,Var_WEEK)))) => (f_meetsTemporally(Var_DAY1,Var_DAY2))))))))))))).

fof(axMergeLem236, axiom, 
 ( ! [Var_DAY1] : 
 (hasType(type_Saturday, Var_DAY1) => 
(( ! [Var_DAY2] : 
 (hasType(type_Sunday, Var_DAY2) => 
(( ! [Var_WEEK] : 
 (hasType(type_Week, Var_WEEK) => 
(((((f_temporalPart(Var_DAY1,Var_WEEK)) & (f_temporalPart(Var_DAY2,Var_WEEK)))) => (f_meetsTemporally(Var_DAY1,Var_DAY2))))))))))))).

fof(axMergeLem237, axiom, 
 ( ! [Var_DAY1] : 
 (hasType(type_Sunday, Var_DAY1) => 
(( ! [Var_DAY2] : 
 (hasType(type_Monday, Var_DAY2) => 
(( ! [Var_WEEK1] : 
 (hasType(type_Week, Var_WEEK1) => 
(( ! [Var_WEEK2] : 
 (hasType(type_Week, Var_WEEK2) => 
(((((f_temporalPart(Var_DAY1,Var_WEEK1)) & (((f_temporalPart(Var_DAY2,Var_WEEK2)) & (f_meetsTemporally(Var_WEEK1,Var_WEEK2)))))) => (f_meetsTemporally(Var_DAY1,Var_DAY2)))))))))))))))).

fof(axMergeLem238, axiom, 
 ( ! [Var_WEEK] : 
 (hasType(type_Week, Var_WEEK) => 
(f_duration(Var_WEEK,f_MeasureFn(1,inst_WeekDuration)))))).

fof(axMergeLem239, axiom, 
 ( ! [Var_HOUR] : 
 (hasType(type_Hour, Var_HOUR) => 
(f_duration(Var_HOUR,f_MeasureFn(1,inst_HourDuration)))))).

fof(axMergeLem240, axiom, 
 ( ! [Var_MINUTE] : 
 (hasType(type_Minute, Var_MINUTE) => 
(f_duration(Var_MINUTE,f_MeasureFn(1,inst_MinuteDuration)))))).

fof(axMergeLem241, axiom, 
 ( ! [Var_SECOND] : 
 (hasType(type_Second, Var_SECOND) => 
(f_duration(Var_SECOND,f_MeasureFn(1,inst_SecondDuration)))))).

fof(axMergeLem242, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_connected(Var_OBJ1,Var_OBJ2)) => (((f_meetsSpatially(Var_OBJ1,Var_OBJ2)) | (f_overlapsSpatially(Var_OBJ1,Var_OBJ2)))))))))))).

fof(axMergeLem243, axiom, 
 ( ! [Var_OBJ] : 
 (hasType(type_SelfConnectedObject, Var_OBJ) => 
(( ! [Var_PART2] : 
 (hasType(type_Object, Var_PART2) => 
(( ! [Var_PART1] : 
 (hasType(type_Object, Var_PART1) => 
(((Var_OBJ = f_MereologicalSumFn(Var_PART1,Var_PART2)) => (f_connected(Var_PART1,Var_PART2))))))))))))).

fof(axMergeLem244, axiom, 
 ( ! [Var_OBJ3] : 
 ((hasType(type_SelfConnectedObject, Var_OBJ3) & hasType(type_Object, Var_OBJ3)) => 
(( ! [Var_OBJ2] : 
 ((hasType(type_SelfConnectedObject, Var_OBJ2) & hasType(type_Object, Var_OBJ2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_SelfConnectedObject, Var_OBJ1) & hasType(type_Object, Var_OBJ1)) => 
(((f_connects(Var_OBJ1,Var_OBJ2,Var_OBJ3)) <=> (f_between(Var_OBJ2,Var_OBJ1,Var_OBJ3))))))))))))).

fof(axMergeLem245, axiom, 
 ( ! [Var_OBJ3] : 
 ((hasType(type_SelfConnectedObject, Var_OBJ3) & hasType(type_Object, Var_OBJ3)) => 
(( ! [Var_OBJ2] : 
 ((hasType(type_SelfConnectedObject, Var_OBJ2) & hasType(type_Object, Var_OBJ2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_SelfConnectedObject, Var_OBJ1) & hasType(type_Object, Var_OBJ1)) => 
(((f_connects(Var_OBJ1,Var_OBJ2,Var_OBJ3)) <=> (((f_connected(Var_OBJ1,Var_OBJ2)) & (((f_connected(Var_OBJ1,Var_OBJ3)) & (( ~ (f_connected(Var_OBJ2,Var_OBJ3))))))))))))))))))).

fof(axMergeLem246, axiom, 
 ( ! [Var_NODE2] : 
 (hasType(type_SelfConnectedObject, Var_NODE2) => 
(( ! [Var_NODE1] : 
 (hasType(type_SelfConnectedObject, Var_NODE1) => 
(( ! [Var_ARC] : 
 (hasType(type_SelfConnectedObject, Var_ARC) => 
(((f_connects(Var_ARC,Var_NODE1,Var_NODE2)) => (f_connects(Var_ARC,Var_NODE2,Var_NODE1))))))))))))).

fof(axMergeLem247, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_overlapsSpatially(Var_OBJ1,Var_OBJ2)) <=> (( ? [Var_OBJ3] : 
 (hasType(type_Object, Var_OBJ3) &  
(((f_part(Var_OBJ3,Var_OBJ1)) & (f_part(Var_OBJ3,Var_OBJ2))))))))))))))).

fof(axMergeLem248, axiom, 
 ( ! [Var_OBJ2] : 
 ((hasType(type_SelfConnectedObject, Var_OBJ2) & hasType(type_Entity, Var_OBJ2) & hasType(type_Object, Var_OBJ2)) => 
(( ! [Var_COLL] : 
 (hasType(type_Collection, Var_COLL) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_SelfConnectedObject, Var_OBJ1) & hasType(type_Entity, Var_OBJ1) & hasType(type_Object, Var_OBJ1)) => 
(((((f_member(Var_OBJ1,Var_COLL)) & (((f_member(Var_OBJ2,Var_COLL)) & (Var_OBJ1 != Var_OBJ2))))) => (( ~ (f_overlapsSpatially(Var_OBJ1,Var_OBJ2))))))))))))))).

fof(axMergeLem249, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_overlapsPartially(Var_OBJ1,Var_OBJ2)) <=> (((( ~ (f_part(Var_OBJ1,Var_OBJ2)))) & (((( ~ (f_part(Var_OBJ2,Var_OBJ1)))) & (( ? [Var_OBJ3] : 
 (hasType(type_Object, Var_OBJ3) &  
(((f_part(Var_OBJ3,Var_OBJ1)) & (f_part(Var_OBJ3,Var_OBJ2))))))))))))))))))).

fof(axMergeLem250, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_superficialPart(Var_OBJ1,Var_OBJ2)) => (((( ~ (f_interiorPart(Var_OBJ1,Var_OBJ2)))) & (( ~ ( ? [Var_OBJ3] : 
 (hasType(type_Object, Var_OBJ3) &  
(f_interiorPart(Var_OBJ3,Var_OBJ1)))))))))))))))).

fof(axMergeLem251, axiom, 
 ( ! [Var_OBJ2] : 
 ((hasType(type_SelfConnectedObject, Var_OBJ2) & hasType(type_Object, Var_OBJ2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_SelfConnectedObject, Var_OBJ1) & hasType(type_Object, Var_OBJ1)) => 
(((f_surface(Var_OBJ1,Var_OBJ2)) => (( ! [Var_OBJ3] : 
 (hasType(type_Object, Var_OBJ3) => 
(((f_superficialPart(Var_OBJ3,Var_OBJ2)) => (f_part(Var_OBJ3,Var_OBJ1))))))))))))))).

fof(axMergeLem252, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_interiorPart(Var_OBJ1,Var_OBJ2)) => (( ! [Var_PART] : 
 (hasType(type_Object, Var_PART) => 
(((f_superficialPart(Var_PART,Var_OBJ2)) => (( ~ (f_overlapsSpatially(Var_OBJ1,Var_PART))))))))))))))))).

fof(axMergeLem253, axiom, 
 ( ! [Var_PART] : 
 (hasType(type_Object, Var_PART) => 
(( ! [Var_OBJECT] : 
 ((hasType(type_SelfConnectedObject, Var_OBJECT) & hasType(type_Object, Var_OBJECT)) => 
(( ! [Var_BOTTOM] : 
 ((hasType(type_SelfConnectedObject, Var_BOTTOM) & hasType(type_Object, Var_BOTTOM)) => 
(((((f_bottom(Var_BOTTOM,Var_OBJECT)) & (((f_part(Var_PART,Var_OBJECT)) & (( ~ (f_connected(Var_PART,Var_BOTTOM)))))))) => (f_orientation(Var_PART,Var_BOTTOM,inst_Above))))))))))))).

fof(axMergeLem254, axiom, 
 ( ! [Var_PART] : 
 (hasType(type_Object, Var_PART) => 
(( ! [Var_OBJECT] : 
 ((hasType(type_SelfConnectedObject, Var_OBJECT) & hasType(type_Object, Var_OBJECT)) => 
(( ! [Var_TOP] : 
 ((hasType(type_SelfConnectedObject, Var_TOP) & hasType(type_Object, Var_TOP)) => 
(((((f_top(Var_TOP,Var_OBJECT)) & (((f_part(Var_PART,Var_OBJECT)) & (( ~ (f_connected(Var_PART,Var_TOP)))))))) => (f_orientation(Var_PART,Var_TOP,inst_Below))))))))))))).

fof(axMergeLem255, axiom, 
 ( ! [Var_PART] : 
 (hasType(type_Object, Var_PART) => 
(( ! [Var_OBJECT] : 
 ((hasType(type_SelfConnectedObject, Var_OBJECT) & hasType(type_Object, Var_OBJECT)) => 
(( ! [Var_SIDE] : 
 ((hasType(type_SelfConnectedObject, Var_SIDE) & hasType(type_Object, Var_SIDE)) => 
(((((f_side(Var_SIDE,Var_OBJECT)) & (((f_part(Var_PART,Var_OBJECT)) & (( ~ (f_connected(Var_PART,Var_SIDE)))))))) => (( ? [Var_DIRECT] : 
 (hasType(type_PositionalAttribute, Var_DIRECT) &  
(f_orientation(Var_SIDE,Var_PART,Var_DIRECT)))))))))))))))).

fof(axMergeLem256, axiom, 
 ( ! [Var_S] : 
 ((hasType(type_SelfConnectedObject, Var_S) & hasType(type_Entity, Var_S)) => 
(( ! [Var_O] : 
 (hasType(type_SelfConnectedObject, Var_O) => 
(( ! [Var_TOP] : 
 ((hasType(type_SelfConnectedObject, Var_TOP) & hasType(type_Entity, Var_TOP)) => 
(((((f_top(Var_TOP,Var_O)) & (f_side(Var_S,Var_O)))) => (Var_TOP != Var_S)))))))))))).

fof(axMergeLem257, axiom, 
 ( ! [Var_WIDTH] : 
 ((hasType(type_PhysicalQuantity, Var_WIDTH) & hasType(type_LengthMeasure, Var_WIDTH)) => 
(( ! [Var_OBJECT] : 
 ((hasType(type_Object, Var_OBJECT) & hasType(type_SelfConnectedObject, Var_OBJECT)) => 
(((f_width(Var_OBJECT,Var_WIDTH)) <=> (( ? [Var_SIDE2] : 
 ((hasType(type_SelfConnectedObject, Var_SIDE2) & hasType(type_Physical, Var_SIDE2)) &  
(( ? [Var_SIDE1] : 
 ((hasType(type_SelfConnectedObject, Var_SIDE1) & hasType(type_Physical, Var_SIDE1)) &  
(((f_side(Var_SIDE1,Var_OBJECT)) & (((f_side(Var_SIDE2,Var_OBJECT)) & (f_distance(Var_SIDE1,Var_SIDE2,Var_WIDTH)))))))))))))))))))).

fof(axMergeLem258, axiom, 
 ( ! [Var_BOTTOM] : 
 ((hasType(type_SelfConnectedObject, Var_BOTTOM) & hasType(type_Physical, Var_BOTTOM)) => 
(( ! [Var_TOP] : 
 ((hasType(type_SelfConnectedObject, Var_TOP) & hasType(type_Physical, Var_TOP)) => 
(( ! [Var_HEIGHT] : 
 (hasType(type_LengthMeasure, Var_HEIGHT) => 
(( ! [Var_OBJECT] : 
 (hasType(type_SelfConnectedObject, Var_OBJECT) => 
(((((f_height(Var_OBJECT,Var_HEIGHT)) & (((f_top(Var_TOP,Var_OBJECT)) & (f_bottom(Var_BOTTOM,Var_OBJECT)))))) => (f_distance(Var_TOP,Var_BOTTOM,Var_HEIGHT)))))))))))))))).

fof(axMergeLem259, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(( ! [Var_OBJ3] : 
 ((hasType(type_Entity, Var_OBJ3) & hasType(type_Object, Var_OBJ3)) => 
(((Var_OBJ3 = f_MereologicalSumFn(Var_OBJ1,Var_OBJ2)) => (( ! [Var_PART] : 
 (hasType(type_Object, Var_PART) => 
(((f_part(Var_PART,Var_OBJ3)) <=> (((f_part(Var_PART,Var_OBJ1)) | (f_part(Var_PART,Var_OBJ2)))))))))))))))))))).

fof(axMergeLem260, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(( ! [Var_OBJ3] : 
 ((hasType(type_Entity, Var_OBJ3) & hasType(type_Object, Var_OBJ3)) => 
(((Var_OBJ3 = f_MereologicalProductFn(Var_OBJ1,Var_OBJ2)) => (( ! [Var_PART] : 
 (hasType(type_Object, Var_PART) => 
(((f_part(Var_PART,Var_OBJ3)) <=> (((f_part(Var_PART,Var_OBJ1)) & (f_part(Var_PART,Var_OBJ2)))))))))))))))))))).

fof(axMergeLem261, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(( ! [Var_OBJ3] : 
 ((hasType(type_Entity, Var_OBJ3) & hasType(type_Object, Var_OBJ3)) => 
(((Var_OBJ3 = f_MereologicalDifferenceFn(Var_OBJ1,Var_OBJ2)) => (( ! [Var_PART] : 
 (hasType(type_Object, Var_PART) => 
(((f_properPart(Var_PART,Var_OBJ3)) <=> (((f_properPart(Var_PART,Var_OBJ1)) & (( ~ (f_properPart(Var_PART,Var_OBJ2)))))))))))))))))))))).

fof(axMergeLem262, axiom, 
 ( ! [Var_HOLE] : 
 (hasType(type_Hole, Var_HOLE) => 
(( ? [Var_OBJ] : 
 (hasType(type_SelfConnectedObject, Var_OBJ) &  
(f_hole(Var_HOLE,Var_OBJ)))))))).

fof(axMergeLem263, axiom, 
 ( ! [Var_OBJ] : 
 ((hasType(type_SelfConnectedObject, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(( ! [Var_HOLE] : 
 ((hasType(type_Hole, Var_HOLE) & hasType(type_Object, Var_HOLE)) => 
(((f_hole(Var_HOLE,Var_OBJ)) => (( ~ (f_overlapsSpatially(Var_HOLE,Var_OBJ)))))))))))).

fof(axMergeLem264, axiom, 
 ( ! [Var_OBJ2] : 
 ((hasType(type_SelfConnectedObject, Var_OBJ2) & hasType(type_Object, Var_OBJ2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_SelfConnectedObject, Var_OBJ1) & hasType(type_Object, Var_OBJ1)) => 
(( ! [Var_HOLE] : 
 (hasType(type_Hole, Var_HOLE) => 
(((((f_hole(Var_HOLE,Var_OBJ1)) & (f_hole(Var_HOLE,Var_OBJ2)))) => (( ? [Var_OBJ3] : 
 ((hasType(type_Object, Var_OBJ3) & hasType(type_SelfConnectedObject, Var_OBJ3)) &  
(((f_properPart(Var_OBJ3,f_MereologicalProductFn(Var_OBJ1,Var_OBJ2))) & (f_hole(Var_HOLE,Var_OBJ3)))))))))))))))))).

fof(axMergeLem265, axiom, 
 ( ! [Var_HOLE2] : 
 ((hasType(type_Hole, Var_HOLE2) & hasType(type_Object, Var_HOLE2)) => 
(( ! [Var_OBJ] : 
 (hasType(type_SelfConnectedObject, Var_OBJ) => 
(( ! [Var_HOLE1] : 
 ((hasType(type_Hole, Var_HOLE1) & hasType(type_Object, Var_HOLE1)) => 
(((((f_hole(Var_HOLE1,Var_OBJ)) & (f_hole(Var_HOLE2,Var_OBJ)))) => (( ! [Var_HOLE3] : 
 ((hasType(type_Object, Var_HOLE3) & hasType(type_Hole, Var_HOLE3)) => 
(((f_part(Var_HOLE3,f_MereologicalSumFn(Var_HOLE1,Var_HOLE2))) => (f_hole(Var_HOLE3,Var_OBJ)))))))))))))))))).

fof(axMergeLem266, axiom, 
 ( ! [Var_OBJ2] : 
 ((hasType(type_Object, Var_OBJ2) & hasType(type_SelfConnectedObject, Var_OBJ2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_SelfConnectedObject, Var_OBJ1) & hasType(type_Object, Var_OBJ1)) => 
(( ! [Var_HOLE] : 
 ((hasType(type_Hole, Var_HOLE) & hasType(type_Object, Var_HOLE)) => 
(((((f_hole(Var_HOLE,Var_OBJ1)) & (f_part(Var_OBJ1,Var_OBJ2)))) => (((f_overlapsSpatially(Var_HOLE,Var_OBJ2)) | (f_hole(Var_HOLE,Var_OBJ2))))))))))))))).

fof(axMergeLem267, axiom, 
 ( ! [Var_OBJ2] : 
 ((hasType(type_SelfConnectedObject, Var_OBJ2) & hasType(type_Object, Var_OBJ2)) => 
(( ! [Var_HOLE2] : 
 ((hasType(type_Hole, Var_HOLE2) & hasType(type_Object, Var_HOLE2)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_SelfConnectedObject, Var_OBJ1) & hasType(type_Object, Var_OBJ1)) => 
(( ! [Var_HOLE1] : 
 ((hasType(type_Hole, Var_HOLE1) & hasType(type_Object, Var_HOLE1)) => 
(((((f_hole(Var_HOLE1,Var_OBJ1)) & (((f_hole(Var_HOLE2,Var_OBJ2)) & (f_overlapsSpatially(Var_HOLE1,Var_HOLE2)))))) => (f_overlapsSpatially(Var_OBJ1,Var_OBJ2)))))))))))))))).

fof(axMergeLem268, axiom, 
 ( ! [Var_HOLE1] : 
 (hasType(type_Hole, Var_HOLE1) => 
(( ? [Var_HOLE2] : 
 (hasType(type_Object, Var_HOLE2) &  
(f_properPart(Var_HOLE2,Var_HOLE1)))))))).

fof(axMergeLem269, axiom, 
 ( ! [Var_OBJ] : 
 ((hasType(type_SelfConnectedObject, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(( ! [Var_HOLE] : 
 ((hasType(type_Hole, Var_HOLE) & hasType(type_Object, Var_HOLE)) => 
(((f_hole(Var_HOLE,Var_OBJ)) => (f_connected(Var_HOLE,Var_OBJ)))))))))).

fof(axMergeLem270, axiom, 
 ( ! [Var_HOLE1] : 
 (hasType(type_Hole, Var_HOLE1) => 
(( ! [Var_HOLE2] : 
 (hasType(type_Object, Var_HOLE2) => 
(((f_properPart(Var_HOLE2,Var_HOLE1)) => (( ? [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) &  
(((f_meetsSpatially(Var_HOLE1,Var_OBJ)) & (( ~ (f_meetsSpatially(Var_HOLE2,Var_OBJ))))))))))))))))).

fof(axMergeLem271, axiom, 
 ( ! [Var_HOLE] : 
 ((hasType(type_Hole, Var_HOLE) & hasType(type_Object, Var_HOLE)) => 
(( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(((( ? [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) &  
(f_holdsDuring(Var_TIME,fills(Var_OBJ,Var_HOLE)))))) => (f_attribute(Var_HOLE,inst_Fillable)))))))))).

fof(axMergeLem272, axiom, 
 ( ! [Var_HOLE1] : 
 (hasType(type_Object, Var_HOLE1) => 
(((f_attribute(Var_HOLE1,inst_Fillable)) <=> (( ? [Var_HOLE2] : 
 (hasType(type_Hole, Var_HOLE2) &  
(f_part(Var_HOLE1,Var_HOLE2)))))))))).

fof(axMergeLem273, axiom, 
 ( ! [Var_HOLE1] : 
 (hasType(type_Object, Var_HOLE1) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Physical, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(((f_partiallyFills(Var_OBJ,Var_HOLE1)) => (( ? [Var_HOLE2] : 
 ((hasType(type_Object, Var_HOLE2) & hasType(type_Hole, Var_HOLE2)) &  
(((f_part(Var_HOLE2,Var_HOLE1)) & (f_completelyFills(Var_OBJ,Var_HOLE2))))))))))))))).

fof(axMergeLem274, axiom, 
 ( ! [Var_HOLE1] : 
 ((hasType(type_Hole, Var_HOLE1) & hasType(type_Object, Var_HOLE1)) => 
(( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(((f_properlyFills(Var_OBJ,Var_HOLE1)) => (( ? [Var_HOLE2] : 
 ((hasType(type_Object, Var_HOLE2) & hasType(type_Hole, Var_HOLE2)) &  
(((f_part(Var_HOLE2,Var_HOLE1)) & (f_fills(Var_OBJ,Var_HOLE2))))))))))))))).

fof(axMergeLem275, axiom, 
 ( ! [Var_HOLE] : 
 (hasType(type_Hole, Var_HOLE) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_completelyFills(Var_OBJ1,Var_HOLE)) => (( ? [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) &  
(((f_part(Var_OBJ2,Var_OBJ1)) & (f_fills(Var_OBJ2,Var_HOLE))))))))))))))).

fof(axMergeLem276, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_HOLE] : 
 (hasType(type_Hole, Var_HOLE) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((((f_fills(Var_OBJ1,Var_HOLE)) & (f_attribute(Var_OBJ2,inst_Fillable)))) => (( ~ (f_overlapsSpatially(Var_OBJ1,Var_OBJ2))))))))))))))).

fof(axMergeLem277, axiom, 
 ( ! [Var_HOLE] : 
 ((hasType(type_Hole, Var_HOLE) & hasType(type_Object, Var_HOLE)) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_completelyFills(Var_OBJ1,Var_HOLE)) => (( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(((f_connected(Var_OBJ2,Var_HOLE)) => (f_connected(Var_OBJ2,Var_OBJ1))))))))))))))).

fof(axMergeLem278, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_HOLE] : 
 ((hasType(type_Hole, Var_HOLE) & hasType(type_Object, Var_HOLE)) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((((f_properlyFills(Var_OBJ1,Var_HOLE)) & (f_connected(Var_OBJ2,Var_OBJ1)))) => (f_connected(Var_HOLE,Var_OBJ2))))))))))))).

fof(axMergeLem279, axiom, 
 ( ! [Var_HOLE2] : 
 ((hasType(type_Object, Var_HOLE2) & hasType(type_Hole, Var_HOLE2)) => 
(( ! [Var_HOLE1] : 
 ((hasType(type_Hole, Var_HOLE1) & hasType(type_Object, Var_HOLE1)) => 
(( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(((((f_fills(Var_OBJ,Var_HOLE1)) & (f_properPart(Var_HOLE2,Var_HOLE1)))) => (f_completelyFills(Var_OBJ,Var_HOLE2))))))))))))).

fof(axMergeLem280, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_HOLE] : 
 (hasType(type_Hole, Var_HOLE) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((((f_fills(Var_OBJ1,Var_HOLE)) & (f_properPart(Var_OBJ2,Var_OBJ1)))) => (f_properlyFills(Var_OBJ2,Var_HOLE))))))))))))).

fof(axMergeLem281, axiom, 
 ( ! [Var_HOLE] : 
 ((hasType(type_Hole, Var_HOLE) & hasType(type_Object, Var_HOLE)) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_Entity, Var_OBJ1) & hasType(type_Object, Var_OBJ1)) => 
(((Var_OBJ1 = f_HoleSkinFn(Var_HOLE)) => (( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(((f_overlapsSpatially(Var_OBJ2,Var_OBJ1)) <=> (( ? [Var_OBJ3] : 
 (hasType(type_Object, Var_OBJ3) &  
(((f_superficialPart(Var_OBJ3,f_HoleHostFn(Var_HOLE))) & (((f_meetsSpatially(Var_HOLE,Var_OBJ3)) & (f_overlapsSpatially(Var_OBJ2,Var_OBJ3)))))))))))))))))))))).

fof(axMergeLem282, axiom, 
 ( ! [Var_PROC] : 
 ((hasType(type_Process, Var_PROC) & hasType(type_Physical, Var_PROC)) => 
(( ! [Var_SUBPROC] : 
 ((hasType(type_Process, Var_SUBPROC) & hasType(type_Physical, Var_SUBPROC)) => 
(((f_subProcess(Var_SUBPROC,Var_PROC)) => (f_temporalPart(f_WhenFn(Var_SUBPROC),f_WhenFn(Var_PROC))))))))))).

fof(axMergeLem283, axiom, 
 ( ! [Var_PROC] : 
 ((hasType(type_Process, Var_PROC) & hasType(type_Physical, Var_PROC)) => 
(( ! [Var_SUBPROC] : 
 ((hasType(type_Process, Var_SUBPROC) & hasType(type_Physical, Var_SUBPROC)) => 
(((f_subProcess(Var_SUBPROC,Var_PROC)) => (( ! [Var_REGION] : 
 (hasType(type_Object, Var_REGION) => 
(((f_located(Var_PROC,Var_REGION)) => (f_located(Var_SUBPROC,Var_REGION))))))))))))))).

fof(axMergeLem284, axiom, 
 ( ! [Var_PROC] : 
 (hasType(type_Process, Var_PROC) => 
(( ! [Var_SUBPROC] : 
 ((hasType(type_Process, Var_SUBPROC) & hasType(type_Physical, Var_SUBPROC)) => 
(((f_subProcess(Var_SUBPROC,Var_PROC)) => (( ? [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) &  
(f_time(Var_SUBPROC,Var_TIME))))))))))))).

fof(axMergeLem285, axiom, 
 ( ! [Var_PROC] : 
 (hasType(type_BiologicalProcess, Var_PROC) => 
(( ? [Var_OBJ] : 
 (hasType(type_Organism, Var_OBJ) &  
(f_located(Var_PROC,Var_OBJ)))))))).

fof(axMergeLem286, axiom, 
 ( ! [Var_PROC] : 
 (hasType(type_OrganOrTissueProcess, Var_PROC) => 
(( ? [Var_THING] : 
 ((hasType(type_Organ, Var_THING) | hasType(type_Tissue, Var_THING)) &  
(f_located(Var_PROC,Var_THING)))))))).

fof(axMergeLem287, axiom, 
 ( ! [Var_BIRTH] : 
 (hasType(type_Birth, Var_BIRTH) => 
(( ! [Var_AGENT] : 
 (hasType(type_Entity, Var_AGENT) => 
(((f_experiencer(Var_BIRTH,Var_AGENT)) => (( ? [Var_DEATH] : 
 (hasType(type_Death, Var_DEATH) &  
(f_experiencer(Var_DEATH,Var_AGENT))))))))))))).

fof(axMergeLem288, axiom, 
 ( ! [Var_DEATH] : 
 (hasType(type_Death, Var_DEATH) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Entity, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((f_experiencer(Var_DEATH,Var_AGENT)) => (f_holdsDuring(f_FutureFn(f_WhenFn(Var_DEATH)),attribute(Var_AGENT,inst_Dead))))))))))).

fof(axMergeLem289, axiom, 
 ( ! [Var_DEATH] : 
 (hasType(type_Death, Var_DEATH) => 
(( ! [Var_BIRTH] : 
 (hasType(type_Birth, Var_BIRTH) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Entity, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((((f_experiencer(Var_DEATH,Var_AGENT)) & (f_experiencer(Var_BIRTH,Var_AGENT)))) => (( ? [Var_TIME] : 
 ((hasType(type_TimeInterval, Var_TIME) & hasType(type_TimePosition, Var_TIME)) &  
(((f_meetsTemporally(f_WhenFn(Var_BIRTH),Var_TIME)) & (((f_meetsTemporally(Var_TIME,f_WhenFn(Var_DEATH))) & (f_holdsDuring(Var_TIME,attribute(Var_AGENT,inst_Living))))))))))))))))))))).

fof(axMergeLem290, axiom, 
 ( ! [Var_DIGEST] : 
 (hasType(type_Digesting, Var_DIGEST) => 
(( ! [Var_ORGANISM] : 
 (hasType(type_Agent, Var_ORGANISM) => 
(((f_agent(Var_DIGEST,Var_ORGANISM)) => (( ? [Var_INGEST] : 
 (hasType(type_Ingesting, Var_INGEST) &  
(((f_agent(Var_INGEST,Var_ORGANISM)) & (f_overlapsTemporally(f_WhenFn(Var_INGEST),f_WhenFn(Var_DIGEST)))))))))))))))).

fof(axMergeLem291, axiom, 
 ( ! [Var_DIGEST] : 
 (hasType(type_Digesting, Var_DIGEST) => 
(( ? [Var_DECOMP] : 
 (hasType(type_ChemicalDecomposition, Var_DECOMP) &  
(f_subProcess(Var_DECOMP,Var_DIGEST)))))))).

fof(axMergeLem292, axiom, 
 ( ! [Var_REP] : 
 (hasType(type_Replication, Var_REP) => 
(( ! [Var_CHILD] : 
 ((hasType(type_Entity, Var_CHILD) & hasType(type_Organism, Var_CHILD)) => 
(( ! [Var_PARENT] : 
 ((hasType(type_Agent, Var_PARENT) & hasType(type_Organism, Var_PARENT)) => 
(((((f_agent(Var_REP,Var_PARENT)) & (f_result(Var_REP,Var_CHILD)))) => (f_parent(Var_CHILD,Var_PARENT))))))))))))).

fof(axMergeLem293, axiom, 
 ( ! [Var_REP] : 
 (hasType(type_Replication, Var_REP) => 
(( ? [Var_BODY] : 
 (hasType(type_ReproductiveBody, Var_BODY) &  
(f_result(Var_REP,Var_BODY)))))))).

fof(axMergeLem294, axiom, 
 ( ! [Var_REP] : 
 (hasType(type_SexualReproduction, Var_REP) => 
(( ! [Var_ORGANISM] : 
 ((hasType(type_Entity, Var_ORGANISM) & hasType(type_Organism, Var_ORGANISM)) => 
(((f_result(Var_REP,Var_ORGANISM)) => (( ? [Var_FATHER] : 
 (hasType(type_Organism, Var_FATHER) &  
(( ? [Var_MOTHER] : 
 (hasType(type_Organism, Var_MOTHER) &  
(((f_mother(Var_ORGANISM,Var_MOTHER)) & (f_father(Var_ORGANISM,Var_FATHER)))))))))))))))))).

fof(axMergeLem295, axiom, 
 ( ! [Var_REP] : 
 (hasType(type_AsexualReproduction, Var_REP) => 
(( ! [Var_ORGANISM] : 
 ((hasType(type_Entity, Var_ORGANISM) & hasType(type_Organism, Var_ORGANISM)) => 
(((f_result(Var_REP,Var_ORGANISM)) => (( ~ ( ? [Var_PARENT2] : 
 ((hasType(type_Organism, Var_PARENT2) & hasType(type_Entity, Var_PARENT2)) &  
(( ? [Var_PARENT1] : 
 ((hasType(type_Organism, Var_PARENT1) & hasType(type_Entity, Var_PARENT1)) &  
(((f_parent(Var_ORGANISM,Var_PARENT1)) & (((f_parent(Var_ORGANISM,Var_PARENT2)) & (Var_PARENT1 != Var_PARENT2)))))))))))))))))))).

fof(axMergeLem296, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_PsychologicalProcess, Var_PROCESS) => 
(( ? [Var_ANIMAL] : 
 (hasType(type_Animal, Var_ANIMAL) &  
(f_experiencer(Var_PROCESS,Var_ANIMAL)))))))).

fof(axMergeLem297, axiom, 
 ( ! [Var_PATH] : 
 (hasType(type_PathologicProcess, Var_PATH) => 
(( ! [Var_ORG] : 
 ((hasType(type_Entity, Var_ORG) & hasType(type_Object, Var_ORG)) => 
(((f_experiencer(Var_PATH,Var_ORG)) => (( ? [Var_DISEASE] : 
 (hasType(type_DiseaseOrSyndrome, Var_DISEASE) &  
(( ? [Var_PART] : 
 (hasType(type_Object, Var_PART) &  
(((f_part(Var_PART,Var_ORG)) & (f_attribute(Var_PART,Var_DISEASE)))))))))))))))))).

fof(axMergeLem298, axiom, 
 ( ! [Var_INJ] : 
 (hasType(type_Injuring, Var_INJ) => 
(( ? [Var_STRUCT] : 
 (hasType(type_AnatomicalStructure, Var_STRUCT) &  
(f_patient(Var_INJ,Var_STRUCT)))))))).

fof(axMergeLem299, axiom, 
 ( ! [Var_POISON] : 
 (hasType(type_Poisoning, Var_POISON) => 
(( ? [Var_SUBSTANCE] : 
 (hasType(type_BiologicallyActiveSubstance, Var_SUBSTANCE) &  
(f_instrument(Var_POISON,Var_SUBSTANCE)))))))).

fof(axMergeLem300, axiom, 
 ( ! [Var_PROC] : 
 (hasType(type_IntentionalProcess, Var_PROC) => 
(( ? [Var_AGENT] : 
 (hasType(type_CognitiveAgent, Var_AGENT) &  
(f_agent(Var_PROC,Var_AGENT)))))))).

fof(axMergeLem301, axiom, 
 ( ! [Var_PROC] : 
 (hasType(type_IntentionalProcess, Var_PROC) => 
(( ! [Var_HUMAN] : 
 (hasType(type_Animal, Var_HUMAN) => 
(((f_agent(Var_PROC,Var_HUMAN)) => (f_holdsDuring(f_WhenFn(Var_PROC),attribute(Var_HUMAN,inst_Awake))))))))))).

fof(axMergeLem302, axiom, 
 ( ! [Var_DECISION] : 
 (hasType(type_LegalDecision, Var_DECISION) => 
(( ? [Var_ACTION] : 
 (hasType(type_LegalAction, Var_ACTION) &  
(f_refers(Var_DECISION,Var_ACTION)))))))).

fof(axMergeLem303, axiom, 
 ( ! [Var_DECISION] : 
 (hasType(type_LegalDecision, Var_DECISION) => 
(( ? [Var_DECIDE] : 
 (hasType(type_Deciding, Var_DECIDE) &  
(f_earlier(f_WhenFn(Var_DECIDE),f_WhenFn(Var_DECISION))))))))).

fof(axMergeLem304, axiom, 
 ( ! [Var_EVENT] : 
 (hasType(type_Planning, Var_EVENT) => 
(( ! [Var_CBO] : 
 (hasType(type_ContentBearingObject, Var_CBO) => 
(((f_result(Var_EVENT,Var_CBO)) => (( ? [Var_PLAN] : 
 (hasType(type_Plan, Var_PLAN) &  
(f_containsInformation(Var_CBO,Var_PLAN))))))))))))).

fof(axMergeLem305, axiom, 
 ( ! [Var_INTERPRET] : 
 (hasType(type_Interpreting, Var_INTERPRET) => 
(( ! [Var_CONTENT] : 
 (hasType(type_ContentBearingObject, Var_CONTENT) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_CognitiveAgent, Var_AGENT)) => 
(((((f_agent(Var_INTERPRET,Var_AGENT)) & (f_patient(Var_INTERPRET,Var_CONTENT)))) => (( ? [Var_PROP] : 
 (hasType(type_Proposition, Var_PROP) &  
(f_holdsDuring(f_EndFn(f_WhenFn(Var_INTERPRET)),believes(Var_AGENT,containsInformation(Var_CONTENT,Var_PROP)))))))))))))))))).

fof(axMergeLem306, axiom, 
 ( ! [Var_MOTION] : 
 (hasType(type_Motion, Var_MOTION) => 
(( ! [Var_PLACE] : 
 (hasType(type_Object, Var_PLACE) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Physical, Var_OBJ)) => 
(((((f_patient(Var_MOTION,Var_OBJ)) & (f_origin(Var_MOTION,Var_PLACE)))) => (f_holdsDuring(f_BeginFn(f_WhenFn(Var_MOTION)),located(Var_OBJ,Var_PLACE)))))))))))))).

fof(axMergeLem307, axiom, 
 ( ! [Var_MOTION] : 
 (hasType(type_Motion, Var_MOTION) => 
(( ! [Var_PLACE] : 
 ((hasType(type_Entity, Var_PLACE) & hasType(type_Object, Var_PLACE)) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Physical, Var_OBJ)) => 
(((((f_patient(Var_MOTION,Var_OBJ)) & (f_destination(Var_MOTION,Var_PLACE)))) => (f_holdsDuring(f_EndFn(f_WhenFn(Var_MOTION)),located(Var_OBJ,Var_PLACE)))))))))))))).

fof(axMergeLem308, axiom, 
 ( ! [Var_DISTANCE] : 
 ((hasType(type_LengthMeasure, Var_DISTANCE) & hasType(type_Quantity, Var_DISTANCE)) => 
(( ! [Var_MEASURE1] : 
 ((hasType(type_PhysicalQuantity, Var_MEASURE1) & hasType(type_Quantity, Var_MEASURE1)) => 
(( ! [Var_DEST] : 
 ((hasType(type_Entity, Var_DEST) & hasType(type_Physical, Var_DEST) & hasType(type_Object, Var_DEST)) => 
(( ! [Var_SOURCE] : 
 ((hasType(type_Object, Var_SOURCE) & hasType(type_Physical, Var_SOURCE)) => 
(( ! [Var_PATH1] : 
 (hasType(type_Object, Var_PATH1) => 
(( ! [Var_PROCESS] : 
 ((hasType(type_Motion, Var_PROCESS) & hasType(type_Process, Var_PROCESS)) => 
(((((f_path(Var_PROCESS,Var_PATH1)) & (((f_origin(Var_PROCESS,Var_SOURCE)) & (((f_destination(Var_PROCESS,Var_DEST)) & (((f_length(Var_PATH1,Var_MEASURE1)) & (((f_distance(Var_SOURCE,Var_DEST,Var_DISTANCE)) & (( ~ (f_greaterThan(Var_MEASURE1,Var_DISTANCE)))))))))))))) => (( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(((f_part(Var_OBJ,Var_PATH1)) => (f_between(Var_SOURCE,Var_OBJ,Var_DEST))))))))))))))))))))))))))).

fof(axMergeLem309, axiom, 
 ( ! [Var_MOTION] : 
 (hasType(type_BodyMotion, Var_MOTION) => 
(( ? [Var_OBJ] : 
 (hasType(type_BodyPart, Var_OBJ) &  
(( ? [Var_AGENT] : 
 (hasType(type_Organism, Var_AGENT) &  
(((f_patient(Var_MOTION,Var_OBJ)) & (f_agent(Var_MOTION,Var_AGENT))))))))))))).

fof(axMergeLem310, axiom, 
 ( ! [Var_VOCAL] : 
 (hasType(type_Vocalizing, Var_VOCAL) => 
(( ! [Var_VC] : 
 (hasType(type_VocalCords, Var_VC) => 
(( ? [Var_HUMAN] : 
 (hasType(type_Human, Var_HUMAN) &  
(((f_part(Var_VC,Var_HUMAN)) & (((f_agent(Var_VOCAL,Var_HUMAN)) & (f_instrument(Var_VOCAL,Var_VC))))))))))))))).

fof(axMergeLem311, axiom, 
 ( ! [Var_WALK] : 
 (hasType(type_Walking, Var_WALK) => 
(( ! [Var_RUN] : 
 (hasType(type_Running, Var_RUN) => 
(( ! [Var_LENGTH2] : 
 ((hasType(type_LengthMeasure, Var_LENGTH2) & hasType(type_Quantity, Var_LENGTH2)) => 
(( ! [Var_TIME] : 
 (hasType(type_TimeDuration, Var_TIME) => 
(( ! [Var_LENGTH1] : 
 ((hasType(type_LengthMeasure, Var_LENGTH1) & hasType(type_Quantity, Var_LENGTH1)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((((f_agent(Var_WALK,Var_AGENT)) & (((f_agent(Var_RUN,Var_AGENT)) & (((f_holdsDuring(f_WhenFn(Var_WALK),measure(Var_AGENT,f_SpeedFn(Var_LENGTH1,Var_TIME)))) & (f_holdsDuring(f_WhenFn(Var_RUN),measure(Var_AGENT,f_SpeedFn(Var_LENGTH2,Var_TIME)))))))))) => (f_greaterThan(Var_LENGTH2,Var_LENGTH1)))))))))))))))))))))).

fof(axMergeLem312, axiom, 
 ( ! [Var_SWIM] : 
 (hasType(type_Swimming, Var_SWIM) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Physical, Var_AGENT)) => 
(((f_agent(Var_SWIM,Var_AGENT)) => (( ? [Var_AREA] : 
 (hasType(type_WaterArea, Var_AREA) &  
(f_located(Var_AGENT,Var_AREA))))))))))))).

fof(axMergeLem313, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_Precipitation, Var_PROCESS) => 
(( ? [Var_STUFF] : 
 (hasType(type_Water, Var_STUFF) &  
(f_patient(Var_PROCESS,Var_STUFF)))))))).

fof(axMergeLem314, axiom, 
 ( ! [Var_MOTION] : 
 (hasType(type_LiquidMotion, Var_MOTION) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(((f_patient(Var_MOTION,Var_OBJ)) => (f_attribute(Var_OBJ,inst_Liquid)))))))))).

fof(axMergeLem315, axiom, 
 ( ! [Var_MOTION] : 
 (hasType(type_WaterMotion, Var_MOTION) => 
(( ? [Var_WATER] : 
 (hasType(type_Water, Var_WATER) &  
(f_patient(Var_MOTION,Var_WATER)))))))).

fof(axMergeLem316, axiom, 
 ( ! [Var_MOTION] : 
 (hasType(type_GasMotion, Var_MOTION) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(((f_patient(Var_MOTION,Var_OBJ)) => (f_attribute(Var_OBJ,inst_Gas)))))))))).

fof(axMergeLem317, axiom, 
 ( ! [Var_TRANSFER] : 
 (hasType(type_Transfer, Var_TRANSFER) => 
(( ! [Var_PATIENT] : 
 (hasType(type_Entity, Var_PATIENT) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Entity, Var_AGENT)) => 
(((((f_agent(Var_TRANSFER,Var_AGENT)) & (f_patient(Var_TRANSFER,Var_PATIENT)))) => (Var_AGENT != Var_PATIENT)))))))))))).

fof(axMergeLem318, axiom, 
 ( ! [Var_T1] : 
 (hasType(type_Translocation, Var_T1) => 
(( ! [Var_T2] : 
 (hasType(type_Translocation, Var_T2) => 
(( ! [Var_P] : 
 (hasType(type_Entity, Var_P) => 
(( ! [Var_D2] : 
 (hasType(type_Entity, Var_D2) => 
(( ! [Var_D1] : 
 ((hasType(type_Object, Var_D1) & hasType(type_Entity, Var_D1)) => 
(( ! [Var_O1] : 
 (hasType(type_Object, Var_O1) => 
(((((f_origin(Var_T1,Var_O1)) & (((f_origin(Var_T2,Var_D1)) & (((f_destination(Var_T1,Var_D1)) & (((f_destination(Var_T2,Var_D2)) & (((f_experiencer(Var_T1,Var_P)) & (f_experiencer(Var_T2,Var_P)))))))))))) => (( ? [Var_T] : 
 (hasType(type_Translocation, Var_T) &  
(((f_origin(Var_T,Var_O1)) & (((f_destination(Var_T,Var_D2)) & (((f_subProcess(Var_T1,Var_T)) & (((f_subProcess(Var_T2,Var_T)) & (((f_experiencer(Var_T,Var_P)) & (((f_starts(f_WhenFn(Var_T1),f_WhenFn(Var_T))) & (f_finishes(f_WhenFn(Var_T2),f_WhenFn(Var_T)))))))))))))))))))))))))))))))))))))).

fof(axMergeLem319, axiom, 
 ( ! [Var_CARRY] : 
 (hasType(type_Carrying, Var_CARRY) => 
(( ? [Var_ANIMAL] : 
 (hasType(type_Animal, Var_ANIMAL) &  
(f_instrument(Var_CARRY,Var_ANIMAL)))))))).

fof(axMergeLem320, axiom, 
 ( ! [Var_INJECT] : 
 (hasType(type_Injecting, Var_INJECT) => 
(( ? [Var_SUBSTANCE] : 
 (hasType(type_BiologicallyActiveSubstance, Var_SUBSTANCE) &  
(( ? [Var_ANIMAL] : 
 (hasType(type_Animal, Var_ANIMAL) &  
(((f_patient(Var_INJECT,Var_SUBSTANCE)) & (((f_attribute(Var_SUBSTANCE,inst_Liquid)) & (f_destination(Var_INJECT,Var_ANIMAL))))))))))))))).

fof(axMergeLem321, axiom, 
 ( ! [Var_SUB] : 
 (hasType(type_Substituting, Var_SUB) => 
(( ? [Var_PUT] : 
 (hasType(type_Putting, Var_PUT) &  
(( ? [Var_REMOVE] : 
 (hasType(type_Removing, Var_REMOVE) &  
(( ? [Var_PLACE] : 
 ((hasType(type_Object, Var_PLACE) & hasType(type_Entity, Var_PLACE)) &  
(( ? [Var_OBJ2] : 
 (hasType(type_Entity, Var_OBJ2) &  
(( ? [Var_OBJ1] : 
 (hasType(type_Entity, Var_OBJ1) &  
(((f_subProcess(Var_PUT,Var_SUB)) & (((f_subProcess(Var_REMOVE,Var_SUB)) & (((f_patient(Var_REMOVE,Var_OBJ1)) & (((f_origin(Var_REMOVE,Var_PLACE)) & (((f_patient(Var_PUT,Var_OBJ2)) & (((f_destination(Var_PUT,Var_PLACE)) & (Var_OBJ1 != Var_OBJ2))))))))))))))))))))))))))))))).

fof(axMergeLem322, axiom, 
 ( ! [Var_IMPACT] : 
 (hasType(type_Impacting, Var_IMPACT) => 
(( ! [Var_OBJ] : 
 (hasType(type_Entity, Var_OBJ) => 
(((f_patient(Var_IMPACT,Var_OBJ)) => (( ? [Var_IMPEL] : 
 (hasType(type_Impelling, Var_IMPEL) &  
(((f_patient(Var_IMPEL,Var_OBJ)) & (f_earlier(f_WhenFn(Var_IMPEL),f_WhenFn(Var_IMPACT)))))))))))))))).

fof(axMergeLem323, axiom, 
 ( ! [Var_MOVEMENT] : 
 (hasType(type_Translocation, Var_MOVEMENT) => 
(( ! [Var_PLACE1] : 
 ((hasType(type_Object, Var_PLACE1) & hasType(type_Entity, Var_PLACE1)) => 
(((f_origin(Var_MOVEMENT,Var_PLACE1)) => (( ? [Var_PLACE2] : 
 (hasType(type_Region, Var_PLACE2) &  
(( ? [Var_STAGE] : 
 ((hasType(type_Process, Var_STAGE) & hasType(type_Physical, Var_STAGE)) &  
(((Var_PLACE1 != Var_PLACE2) & (((f_subProcess(Var_STAGE,Var_MOVEMENT)) & (f_located(Var_STAGE,Var_PLACE2)))))))))))))))))))).

fof(axMergeLem324, axiom, 
 ( ! [Var_DROP] : 
 (hasType(type_Falling, Var_DROP) => 
(( ! [Var_FINISH] : 
 ((hasType(type_Entity, Var_FINISH) & hasType(type_Object, Var_FINISH)) => 
(( ! [Var_START] : 
 (hasType(type_Object, Var_START) => 
(((((f_origin(Var_DROP,Var_START)) & (f_destination(Var_DROP,Var_FINISH)))) => (f_orientation(Var_FINISH,Var_START,inst_Below))))))))))))).

fof(axMergeLem325, axiom, 
 ( ! [Var_TRANS] : 
 (hasType(type_Transportation, Var_TRANS) => 
(( ? [Var_DEVICE] : 
 (hasType(type_TransportationDevice, Var_DEVICE) &  
(f_instrument(Var_TRANS,Var_DEVICE)))))))).

fof(axMergeLem326, axiom, 
 ( ! [Var_DRIVE] : 
 (hasType(type_Driving, Var_DRIVE) => 
(( ? [Var_VEHICLE] : 
 (hasType(type_Vehicle, Var_VEHICLE) &  
(f_patient(Var_DRIVE,Var_VEHICLE)))))))).

fof(axMergeLem327, axiom, 
 ( ! [Var_CHANGE] : 
 (hasType(type_ChangeOfPossession, Var_CHANGE) => 
(( ! [Var_AGENT2] : 
 ((hasType(type_Agent, Var_AGENT2) & hasType(type_Entity, Var_AGENT2)) => 
(( ! [Var_AGENT1] : 
 ((hasType(type_Agent, Var_AGENT1) & hasType(type_Entity, Var_AGENT1)) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(((((f_patient(Var_CHANGE,Var_OBJ)) & (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_CHANGE)),possesses(Var_AGENT1,Var_OBJ))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_CHANGE)),possesses(Var_AGENT2,Var_OBJ))))))) => (Var_AGENT1 != Var_AGENT2))))))))))))))).

fof(axMergeLem328, axiom, 
 ( ! [Var_CHANGE] : 
 (hasType(type_ChangeOfPossession, Var_CHANGE) => 
(( ! [Var_AGENT1] : 
 (hasType(type_Agent, Var_AGENT1) => 
(( ! [Var_AGENT2] : 
 (hasType(type_Agent, Var_AGENT2) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(((((f_origin(Var_CHANGE,Var_AGENT1)) & (((f_destination(Var_CHANGE,Var_AGENT2)) & (f_patient(Var_CHANGE,Var_OBJ)))))) => (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_CHANGE)),possesses(Var_AGENT1,Var_OBJ))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_CHANGE)),possesses(Var_AGENT2,Var_OBJ))))))))))))))))))).

fof(axMergeLem329, axiom, 
 ( ! [Var_GIVE] : 
 (hasType(type_Giving, Var_GIVE) => 
(( ! [Var_AGENT2] : 
 (hasType(type_Agent, Var_AGENT2) => 
(( ! [Var_OBJ] : 
 (hasType(type_Entity, Var_OBJ) => 
(( ! [Var_AGENT1] : 
 ((hasType(type_Agent, Var_AGENT1) & hasType(type_Object, Var_AGENT1)) => 
(((((f_agent(Var_GIVE,Var_AGENT1)) & (((f_destination(Var_GIVE,Var_AGENT2)) & (f_patient(Var_GIVE,Var_OBJ)))))) => (( ? [Var_GET] : 
 (hasType(type_Getting, Var_GET) &  
(((f_agent(Var_GET,Var_AGENT2)) & (((f_origin(Var_GET,Var_AGENT1)) & (f_patient(Var_GET,Var_OBJ))))))))))))))))))))))).

fof(axMergeLem330, axiom, 
 ( ! [Var_GIVE] : 
 (hasType(type_Giving, Var_GIVE) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((f_agent(Var_GIVE,Var_AGENT)) => (f_origin(Var_GIVE,Var_AGENT)))))))))).

fof(axMergeLem331, axiom, 
 ( ! [Var_FUND] : 
 (hasType(type_Funding, Var_FUND) => 
(( ? [Var_MONEY] : 
 (hasType(type_Currency, Var_MONEY) &  
(f_patient(Var_FUND,Var_MONEY)))))))).

fof(axMergeLem332, axiom, 
 ( ! [Var_OBJECT] : 
 (hasType(type_Entity, Var_OBJECT) => 
(( ! [Var_AGENT2] : 
 ((hasType(type_Object, Var_AGENT2) & hasType(type_Agent, Var_AGENT2)) => 
(( ! [Var_AGENT1] : 
 ((hasType(type_Agent, Var_AGENT1) & hasType(type_Entity, Var_AGENT1)) => 
(((( ? [Var_BORROW] : 
 (hasType(type_Borrowing, Var_BORROW) &  
(((f_agent(Var_BORROW,Var_AGENT1)) & (((f_origin(Var_BORROW,Var_AGENT2)) & (f_patient(Var_BORROW,Var_OBJECT))))))))) <=> (( ? [Var_LEND] : 
 (hasType(type_Lending, Var_LEND) &  
(((f_agent(Var_LEND,Var_AGENT2)) & (((f_destination(Var_LEND,Var_AGENT1)) & (f_patient(Var_LEND,Var_OBJECT)))))))))))))))))))).

fof(axMergeLem333, axiom, 
 ( ! [Var_RETURN] : 
 (hasType(type_GivingBack, Var_RETURN) => 
(( ! [Var_DEST] : 
 ((hasType(type_Entity, Var_DEST) & hasType(type_Agent, Var_DEST)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Entity, Var_AGENT)) => 
(((((f_agent(Var_RETURN,Var_AGENT)) & (f_destination(Var_RETURN,Var_DEST)))) => (( ? [Var_GIVE] : 
 (hasType(type_Giving, Var_GIVE) &  
(((f_agent(Var_GIVE,Var_DEST)) & (((f_destination(Var_GIVE,Var_AGENT)) & (f_earlier(f_WhenFn(Var_GIVE),f_WhenFn(Var_RETURN))))))))))))))))))))).

fof(axMergeLem334, axiom, 
 ( ! [Var_GET] : 
 (hasType(type_Getting, Var_GET) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Entity, Var_AGENT)) => 
(((f_agent(Var_GET,Var_AGENT)) => (f_destination(Var_GET,Var_AGENT)))))))))).

fof(axMergeLem335, axiom, 
 ( ! [Var_TRANS] : 
 (hasType(type_Transaction, Var_TRANS) => 
(( ? [Var_GIVE1] : 
 (hasType(type_Giving, Var_GIVE1) &  
(( ? [Var_GIVE2] : 
 (hasType(type_Giving, Var_GIVE2) &  
(( ? [Var_OBJ2] : 
 (hasType(type_Entity, Var_OBJ2) &  
(( ? [Var_OBJ1] : 
 (hasType(type_Entity, Var_OBJ1) &  
(( ? [Var_AGENT2] : 
 ((hasType(type_Agent, Var_AGENT2) & hasType(type_Entity, Var_AGENT2)) &  
(( ? [Var_AGENT1] : 
 ((hasType(type_Agent, Var_AGENT1) & hasType(type_Entity, Var_AGENT1)) &  
(((f_subProcess(Var_GIVE1,Var_TRANS)) & (((f_subProcess(Var_GIVE2,Var_TRANS)) & (((f_agent(Var_GIVE1,Var_AGENT1)) & (((f_agent(Var_GIVE2,Var_AGENT2)) & (((f_patient(Var_GIVE1,Var_OBJ1)) & (((f_patient(Var_GIVE2,Var_OBJ2)) & (((f_destination(Var_GIVE1,Var_AGENT2)) & (((f_destination(Var_GIVE2,Var_AGENT1)) & (((Var_AGENT1 != Var_AGENT2) & (Var_OBJ1 != Var_OBJ2)))))))))))))))))))))))))))))))))))))))).

fof(axMergeLem336, axiom, 
 ( ! [Var_TRANS] : 
 (hasType(type_FinancialTransaction, Var_TRANS) => 
(( ? [Var_OBJ] : 
 (hasType(type_Currency, Var_OBJ) &  
(f_patient(Var_TRANS,Var_OBJ)))))))).

fof(axMergeLem337, axiom, 
 ( ! [Var_AMOUNT] : 
 (hasType(type_CurrencyMeasure, Var_AMOUNT) => 
(( ! [Var_TRANS] : 
 ((hasType(type_FinancialTransaction, Var_TRANS) & hasType(type_Process, Var_TRANS)) => 
(((f_transactionAmount(Var_TRANS,Var_AMOUNT)) => (( ? [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Physical, Var_OBJ)) &  
(((f_patient(Var_TRANS,Var_OBJ)) & (f_monetaryValue(Var_OBJ,Var_AMOUNT))))))))))))))).

fof(axMergeLem338, axiom, 
 ( ! [Var_BUSINESS] : 
 (hasType(type_CommercialService, Var_BUSINESS) => 
(( ? [Var_AGENT] : 
 (hasType(type_CommercialAgent, Var_AGENT) &  
(f_agent(Var_BUSINESS,Var_AGENT)))))))).

fof(axMergeLem339, axiom, 
 ( ! [Var_BUY] : 
 (hasType(type_Buying, Var_BUY) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Entity, Var_AGENT)) => 
(((f_agent(Var_BUY,Var_AGENT)) => (f_destination(Var_BUY,Var_AGENT)))))))))).

fof(axMergeLem340, axiom, 
 ( ! [Var_OBJECT] : 
 (hasType(type_Entity, Var_OBJECT) => 
(( ! [Var_AGENT2] : 
 ((hasType(type_Object, Var_AGENT2) & hasType(type_Agent, Var_AGENT2)) => 
(( ! [Var_AGENT1] : 
 ((hasType(type_Agent, Var_AGENT1) & hasType(type_Entity, Var_AGENT1)) => 
(((( ? [Var_BUY] : 
 (hasType(type_Buying, Var_BUY) &  
(((f_agent(Var_BUY,Var_AGENT1)) & (((f_origin(Var_BUY,Var_AGENT2)) & (f_patient(Var_BUY,Var_OBJECT))))))))) <=> (( ? [Var_SELL] : 
 (hasType(type_Selling, Var_SELL) &  
(((f_agent(Var_SELL,Var_AGENT2)) & (((f_destination(Var_SELL,Var_AGENT1)) & (f_patient(Var_SELL,Var_OBJECT)))))))))))))))))))).

fof(axMergeLem341, axiom, 
 ( ! [Var_SELL] : 
 (hasType(type_Selling, Var_SELL) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((f_agent(Var_SELL,Var_AGENT)) => (f_origin(Var_SELL,Var_AGENT)))))))))).

fof(axMergeLem342, axiom, 
 ( ! [Var_DISCOVER] : 
 (hasType(type_Discovering, Var_DISCOVER) => 
(( ! [Var_OBJ] : 
 (hasType(type_Entity, Var_OBJ) => 
(((f_patient(Var_DISCOVER,Var_OBJ)) => (( ? [Var_PURSUE] : 
 (hasType(type_Pursuing, Var_PURSUE) &  
(f_meetsTemporally(f_WhenFn(Var_PURSUE),f_WhenFn(Var_DISCOVER)))))))))))))).

fof(axMergeLem343, axiom, 
 ( ! [Var_VOTE] : 
 (hasType(type_Voting, Var_VOTE) => 
(( ? [Var_ELECT] : 
 (hasType(type_Election, Var_ELECT) &  
(f_subProcess(Var_VOTE,Var_ELECT)))))))).

fof(axMergeLem344, axiom, 
 ( ! [Var_MEAS] : 
 (hasType(type_Measuring, Var_MEAS) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_CognitiveAgent, Var_AGENT)) => 
(((((f_agent(Var_MEAS,Var_AGENT)) & (f_patient(Var_MEAS,Var_OBJ)))) => (( ? [Var_UNIT] : 
 (hasType(type_UnitOfMeasure, Var_UNIT) &  
(( ? [Var_QUANT] : 
 (hasType(type_RealNumber, Var_QUANT) &  
(f_holdsDuring(f_EndFn(f_WhenFn(Var_MEAS)),knows(Var_AGENT,measure(Var_OBJ,f_MeasureFn(Var_QUANT,Var_UNIT)))))))))))))))))))))).

fof(axMergeLem345, axiom, 
 ( ! [Var_KEEP] : 
 (hasType(type_Keeping, Var_KEEP) => 
(( ! [Var_OBJ] : 
 (hasType(type_Entity, Var_OBJ) => 
(( ! [Var_AGENT] : 
 (hasType(type_Agent, Var_AGENT) => 
(((((f_agent(Var_KEEP,Var_AGENT)) & (f_patient(Var_KEEP,Var_OBJ)))) => (( ? [Var_PUT] : 
 (hasType(type_Putting, Var_PUT) &  
(((f_agent(Var_PUT,Var_AGENT)) & (((f_patient(Var_PUT,Var_OBJ)) & (f_earlier(f_WhenFn(Var_PUT),f_WhenFn(Var_KEEP))))))))))))))))))))).

fof(axMergeLem346, axiom, 
 ( ! [Var_KEEP] : 
 (hasType(type_Keeping, Var_KEEP) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Physical, Var_OBJ)) => 
(((f_patient(Var_KEEP,Var_OBJ)) => (( ? [Var_PLACE] : 
 (hasType(type_Object, Var_PLACE) &  
(( ! [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) => 
(((f_temporalPart(Var_TIME,f_WhenFn(Var_KEEP))) => (f_holdsDuring(Var_TIME,located(Var_OBJ,Var_PLACE))))))))))))))))))).

fof(axMergeLem347, axiom, 
 ( ! [Var_CONFINE] : 
 (hasType(type_Confining, Var_CONFINE) => 
(( ? [Var_AGENT] : 
 (hasType(type_Animal, Var_AGENT) &  
(f_patient(Var_CONFINE,Var_AGENT)))))))).

fof(axMergeLem348, axiom, 
 ( ! [Var_CONFINE] : 
 (hasType(type_Confining, Var_CONFINE) => 
(( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(((f_patient(Var_CONFINE,Var_PERSON)) => (( ~ (f_desires(Var_PERSON,patient(Var_CONFINE,Var_PERSON))))))))))))).

fof(axMergeLem349, axiom, 
 ( ! [Var_REPAIR] : 
 (hasType(type_Repairing, Var_REPAIR) => 
(( ! [Var_OBJ] : 
 (hasType(type_Entity, Var_OBJ) => 
(((f_patient(Var_REPAIR,Var_OBJ)) => (( ? [Var_DAMAGE] : 
 (hasType(type_Damaging, Var_DAMAGE) &  
(((f_patient(Var_DAMAGE,Var_OBJ)) & (f_earlier(f_WhenFn(Var_DAMAGE),f_WhenFn(Var_REPAIR)))))))))))))))).

fof(axMergeLem350, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_Destruction, Var_PROCESS) => 
(( ? [Var_PATIENT] : 
 ((hasType(type_Entity, Var_PATIENT) & hasType(type_Physical, Var_PATIENT)) &  
(((f_patient(Var_PROCESS,Var_PATIENT)) & (((f_time(Var_PATIENT,f_BeginFn(f_WhenFn(Var_PROCESS)))) & (( ~ (f_time(Var_PATIENT,f_EndFn(f_WhenFn(Var_PROCESS)))))))))))))))).

fof(axMergeLem351, axiom, 
 ( ! [Var_KILL] : 
 (hasType(type_Killing, Var_KILL) => 
(( ! [Var_PATIENT] : 
 ((hasType(type_Entity, Var_PATIENT) & hasType(type_Object, Var_PATIENT)) => 
(((f_patient(Var_KILL,Var_PATIENT)) => (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_KILL)),attribute(Var_PATIENT,inst_Living))) & (f_holdsDuring(f_FutureFn(f_WhenFn(Var_KILL)),attribute(Var_PATIENT,inst_Dead))))))))))))).

fof(axMergeLem352, axiom, 
 ( ! [Var_KILL] : 
 (hasType(type_Killing, Var_KILL) => 
(( ! [Var_OBJ] : 
 (hasType(type_Entity, Var_OBJ) => 
(((f_patient(Var_KILL,Var_OBJ)) => (( ? [Var_DEATH] : 
 (hasType(type_Death, Var_DEATH) &  
(((f_experiencer(Var_DEATH,Var_OBJ)) & (f_causes(Var_KILL,Var_DEATH))))))))))))))).

fof(axMergeLem353, axiom, 
 ( ! [Var_POKE] : 
 (hasType(type_Poking, Var_POKE) => 
(( ! [Var_INST] : 
 ((hasType(type_Object, Var_INST) & hasType(type_SelfConnectedObject, Var_INST)) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_SelfConnectedObject, Var_OBJ)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_SelfConnectedObject, Var_AGENT)) => 
(((((f_agent(Var_POKE,Var_AGENT)) & (((f_patient(Var_POKE,Var_OBJ)) & (f_instrument(Var_POKE,Var_INST)))))) => (f_holdsDuring(f_WhenFn(Var_POKE),connects(Var_INST,Var_AGENT,Var_OBJ))))))))))))))))).

fof(axMergeLem354, axiom, 
 ( ! [Var_ATTACH] : 
 (hasType(type_Attaching, Var_ATTACH) => 
(( ? [Var_OBJ] : 
 (hasType(type_CorpuscularObject, Var_OBJ) &  
(f_patient(Var_ATTACH,Var_OBJ)))))))).

fof(axMergeLem355, axiom, 
 ( ! [Var_DETACH] : 
 (hasType(type_Detaching, Var_DETACH) => 
(( ? [Var_OBJ] : 
 (hasType(type_CorpuscularObject, Var_OBJ) &  
(f_patient(Var_DETACH,Var_OBJ)))))))).

fof(axMergeLem356, axiom, 
 ( ! [Var_COMBINE] : 
 (hasType(type_Combining, Var_COMBINE) => 
(( ? [Var_OBJ] : 
 (hasType(type_SelfConnectedObject, Var_OBJ) &  
(f_patient(Var_COMBINE,Var_OBJ)))))))).

fof(axMergeLem357, axiom, 
 ( ! [Var_SEPARATE] : 
 (hasType(type_Separating, Var_SEPARATE) => 
(( ? [Var_OBJ] : 
 (hasType(type_SelfConnectedObject, Var_OBJ) &  
(f_patient(Var_SEPARATE,Var_OBJ)))))))).

fof(axMergeLem358, axiom, 
 ( ! [Var_COMPOUND] : 
 (hasType(type_CompoundSubstance, Var_COMPOUND) => 
(( ? [Var_ELEMENT1] : 
 (hasType(type_ElementalSubstance, Var_ELEMENT1) &  
(( ? [Var_ELEMENT2] : 
 (hasType(type_ElementalSubstance, Var_ELEMENT2) &  
(( ? [Var_PROCESS] : 
 (hasType(type_ChemicalSynthesis, Var_PROCESS) &  
(((Var_ELEMENT1 != Var_ELEMENT2) & (((f_resourceS(Var_PROCESS,Var_ELEMENT1)) & (((f_resourceS(Var_PROCESS,Var_ELEMENT2)) & (f_result(Var_PROCESS,Var_COMPOUND)))))))))))))))))))).

fof(axMergeLem359, axiom, 
 ( ! [Var_COMBUSTION] : 
 (hasType(type_Combustion, Var_COMBUSTION) => 
(( ? [Var_HEAT] : 
 (hasType(type_Heating, Var_HEAT) &  
(( ? [Var_LIGHT] : 
 (hasType(type_RadiatingLight, Var_LIGHT) &  
(((f_subProcess(Var_HEAT,Var_COMBUSTION)) & (f_subProcess(Var_LIGHT,Var_COMBUSTION))))))))))))).

fof(axMergeLem360, axiom, 
 ( ! [Var_DEVELOP] : 
 (hasType(type_ContentDevelopment, Var_DEVELOP) => 
(( ? [Var_OBJ] : 
 (hasType(type_ContentBearingObject, Var_OBJ) &  
(f_result(Var_DEVELOP,Var_OBJ)))))))).

fof(axMergeLem361, axiom, 
 ( ! [Var_READ] : 
 (hasType(type_Reading, Var_READ) => 
(( ? [Var_TEXT] : 
 (hasType(type_Text, Var_TEXT) &  
(( ? [Var_PROP] : 
 (hasType(type_Proposition, Var_PROP) &  
(((f_containsInformation(Var_TEXT,Var_PROP)) & (f_realization(Var_READ,Var_PROP))))))))))))).

fof(axMergeLem362, axiom, 
 ( ! [Var_DECODE] : 
 (hasType(type_Decoding, Var_DECODE) => 
(( ! [Var_PROP] : 
 (hasType(type_Proposition, Var_PROP) => 
(( ! [Var_DOC1] : 
 ((hasType(type_Entity, Var_DOC1) & hasType(type_ContentBearingPhysical, Var_DOC1)) => 
(((f_patient(Var_DECODE,Var_DOC1)) => (( ? [Var_ENCODE] : 
 (hasType(type_Encoding, Var_ENCODE) &  
(( ? [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) &  
(( ? [Var_DOC2] : 
 ((hasType(type_ContentBearingPhysical, Var_DOC2) & hasType(type_Entity, Var_DOC2)) &  
(((f_containsInformation(Var_DOC2,Var_PROP)) & (((f_containsInformation(Var_DOC1,Var_PROP)) & (((f_temporalPart(Var_TIME,f_PastFn(f_WhenFn(Var_DECODE)))) & (f_holdsDuring(Var_TIME,patient(Var_ENCODE,Var_DOC2))))))))))))))))))))))))))))).

fof(axMergeLem363, axiom, 
 ( ! [Var_TRANSLATE] : 
 (hasType(type_Translating, Var_TRANSLATE) => 
(( ! [Var_EXPRESSION2] : 
 ((hasType(type_Entity, Var_EXPRESSION2) & hasType(type_LinguisticExpression, Var_EXPRESSION2)) => 
(( ! [Var_EXPRESSION1] : 
 ((hasType(type_Entity, Var_EXPRESSION1) & hasType(type_LinguisticExpression, Var_EXPRESSION1)) => 
(((((f_patient(Var_TRANSLATE,Var_EXPRESSION1)) & (f_result(Var_TRANSLATE,Var_EXPRESSION2)))) => (( ? [Var_ENTITY] : 
 (hasType(type_Entity, Var_ENTITY) &  
(( ? [Var_LANGUAGE2] : 
 ((hasType(type_Language, Var_LANGUAGE2) & hasType(type_Entity, Var_LANGUAGE2)) &  
(( ? [Var_LANGUAGE1] : 
 ((hasType(type_Language, Var_LANGUAGE1) & hasType(type_Entity, Var_LANGUAGE1)) &  
(((f_representsInLanguage(Var_EXPRESSION1,Var_ENTITY,Var_LANGUAGE1)) & (((f_representsInLanguage(Var_EXPRESSION2,Var_ENTITY,Var_LANGUAGE2)) & (Var_LANGUAGE1 != Var_LANGUAGE2))))))))))))))))))))))))).

fof(axMergeLem364, axiom, 
 ( ! [Var_WET] : 
 (hasType(type_Wetting, Var_WET) => 
(( ? [Var_OBJ] : 
 ((hasType(type_Object, Var_OBJ) & hasType(type_Entity, Var_OBJ)) &  
(((f_attribute(Var_OBJ,inst_Liquid)) & (f_patient(Var_WET,Var_OBJ)))))))))).

fof(axMergeLem365, axiom, 
 ( ! [Var_DRY] : 
 (hasType(type_Drying, Var_DRY) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(((f_patient(Var_DRY,Var_OBJ)) => (f_holdsDuring(f_EndFn(f_WhenFn(Var_DRY)),attribute(Var_OBJ,inst_Dry))))))))))).

fof(axMergeLem366, axiom, 
 ( ! [Var_ACTION] : 
 (hasType(type_Creation, Var_ACTION) => 
(( ? [Var_RESULT] : 
 (hasType(type_Entity, Var_RESULT) &  
(f_result(Var_ACTION,Var_RESULT)))))))).

fof(axMergeLem367, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_Creation, Var_PROCESS) => 
(( ? [Var_PATIENT] : 
 ((hasType(type_Entity, Var_PATIENT) & hasType(type_Physical, Var_PATIENT)) &  
(((f_patient(Var_PROCESS,Var_PATIENT)) & (((f_time(Var_PATIENT,f_EndFn(f_WhenFn(Var_PROCESS)))) & (( ~ (f_time(Var_PATIENT,f_BeginFn(f_WhenFn(Var_PROCESS)))))))))))))))).

fof(axMergeLem368, axiom, 
 ( ! [Var_COOK] : 
 (hasType(type_Cooking, Var_COOK) => 
(( ? [Var_FOOD] : 
 (hasType(type_Food, Var_FOOD) &  
(f_result(Var_COOK,Var_FOOD)))))))).

fof(axMergeLem369, axiom, 
 ( ! [Var_PURSUE] : 
 (hasType(type_Pursuing, Var_PURSUE) => 
(( ? [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) &  
(f_patient(Var_PURSUE,Var_OBJ)))))))).

fof(axMergeLem370, axiom, 
 ( ! [Var_PURSUE] : 
 (hasType(type_Pursuing, Var_PURSUE) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Physical, Var_OBJ)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_CognitiveAgent, Var_AGENT)) => 
(((((f_agent(Var_PURSUE,Var_AGENT)) & (f_patient(Var_PURSUE,Var_OBJ)))) => (f_holdsDuring(Var_PURSUE,wants(Var_AGENT,Var_OBJ)))))))))))))).

fof(axMergeLem371, axiom, 
 ( ! [Var_H] : 
 (hasType(type_Hunting, Var_H) => 
(( ? [Var_T] : 
 (hasType(type_Animal, Var_T) &  
(f_patient(Var_H,Var_T)))))))).

fof(axMergeLem372, axiom, 
 ( ! [Var_PROC] : 
 (hasType(type_DiagnosticProcess, Var_PROC) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_CognitiveAgent, Var_AGENT)) => 
(((f_agent(Var_PROC,Var_AGENT)) => (( ? [Var_CAUSE] : 
 (hasType(type_Process, Var_CAUSE) &  
(f_hasPurposeForAgent(Var_PROC,knows(Var_AGENT,causes(Var_CAUSE,Var_PROC)),Var_AGENT))))))))))))).

fof(axMergeLem373, axiom, 
 ( ! [Var_INTERACTION] : 
 (hasType(type_SocialInteraction, Var_INTERACTION) => 
(( ? [Var_AGENT1] : 
 (hasType(type_Agent, Var_AGENT1) &  
(( ? [Var_AGENT2] : 
 (hasType(type_Agent, Var_AGENT2) &  
(((f_involvedInEvent(Var_INTERACTION,Var_AGENT1)) & (((f_involvedInEvent(Var_INTERACTION,Var_AGENT2)) & (Var_AGENT1 != Var_AGENT2)))))))))))))).

fof(axMergeLem374, axiom, 
 ( ! [Var_COMMUNICATE] : 
 (hasType(type_Communication, Var_COMMUNICATE) => 
(( ? [Var_AGENT1] : 
 (hasType(type_CognitiveAgent, Var_AGENT1) &  
(( ? [Var_AGENT2] : 
 (hasType(type_CognitiveAgent, Var_AGENT2) &  
(( ? [Var_ENTITY] : 
 (hasType(type_Entity, Var_ENTITY) &  
(( ? [Var_PHYS] : 
 (hasType(type_Entity, Var_PHYS) &  
(((f_refers(Var_PHYS,Var_ENTITY)) & (((f_patient(Var_COMMUNICATE,Var_PHYS)) & (((f_agent(Var_COMMUNICATE,Var_AGENT1)) & (f_destination(Var_COMMUNICATE,Var_AGENT2))))))))))))))))))))))).

fof(axMergeLem375, axiom, 
 ( ! [Var_DISSEMINATE] : 
 (hasType(type_Disseminating, Var_DISSEMINATE) => 
(( ? [Var_AGENT1] : 
 (hasType(type_CognitiveAgent, Var_AGENT1) &  
(( ? [Var_AGENT2] : 
 (hasType(type_CognitiveAgent, Var_AGENT2) &  
(((f_destination(Var_DISSEMINATE,Var_AGENT1)) & (((f_destination(Var_DISSEMINATE,Var_AGENT2)) & (Var_AGENT1 != Var_AGENT2)))))))))))))).

fof(axMergeLem376, axiom, 
 ( ! [Var_DEMO] : 
 (hasType(type_Demonstrating, Var_DEMO) => 
(( ? [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) &  
(f_attends(Var_DEMO,Var_PERSON)))))))).

fof(axMergeLem377, axiom, 
 ( ! [Var_EXPRESS] : 
 (hasType(type_Expressing, Var_EXPRESS) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((f_agent(Var_EXPRESS,Var_AGENT)) => (( ? [Var_STATE] : 
 (hasType(type_StateOfMind, Var_STATE) &  
(((f_attribute(Var_AGENT,Var_STATE)) & (f_represents(Var_EXPRESS,Var_STATE))))))))))))))).

fof(axMergeLem378, axiom, 
 ( ! [Var_COMMUNICATE] : 
 (hasType(type_LinguisticCommunication, Var_COMMUNICATE) => 
(( ? [Var_OBJ] : 
 (hasType(type_LinguisticExpression, Var_OBJ) &  
(((f_represents(Var_COMMUNICATE,Var_OBJ)) & (f_patient(Var_COMMUNICATE,Var_OBJ)))))))))).

fof(axMergeLem379, axiom, 
 ( ! [Var_DIS] : 
 (hasType(type_Disagreeing, Var_DIS) => 
(( ? [Var_STMT2] : 
 (hasType(type_Proposition, Var_STMT2) &  
(( ? [Var_STMT1] : 
 (hasType(type_Proposition, Var_STMT1) &  
(( ? [Var_STATE2] : 
 ((hasType(type_Process, Var_STATE2) & hasType(type_ContentBearingPhysical, Var_STATE2)) &  
(( ? [Var_STATE1] : 
 ((hasType(type_Process, Var_STATE1) & hasType(type_ContentBearingPhysical, Var_STATE1)) &  
(( ? [Var_A2] : 
 (hasType(type_Agent, Var_A2) &  
(( ? [Var_A1] : 
 (hasType(type_Agent, Var_A1) &  
(((f_subProcess(Var_STATE1,Var_DIS)) & (((f_subProcess(Var_STATE2,Var_DIS)) & (((f_agent(Var_STATE1,Var_A1)) & (((f_agent(Var_STATE2,Var_A2)) & (((f_containsInformation(Var_STATE1,Var_STMT1)) & (((f_containsInformation(Var_STATE2,Var_STMT2)) & (( ~ (f_consistent(Var_STMT1,Var_STMT2))))))))))))))))))))))))))))))))))))).

fof(axMergeLem380, axiom, 
 ( ! [Var_WED] : 
 (hasType(type_Wedding, Var_WED) => 
(( ? [Var_PERSON2] : 
 (hasType(type_Human, Var_PERSON2) &  
(( ? [Var_PERSON1] : 
 (hasType(type_Human, Var_PERSON1) &  
(f_holdsDuring(f_ImmediateFutureFn(f_WhenFn(Var_WED)),spouse(Var_PERSON1,Var_PERSON2)))))))))))).

fof(axMergeLem381, axiom, 
 ( ! [Var_T1] : 
 (hasType(type_TimeInterval, Var_T1) => 
(( ! [Var_P2] : 
 ((hasType(type_Human, Var_P2) & hasType(type_Entity, Var_P2)) => 
(( ! [Var_P1] : 
 ((hasType(type_Human, Var_P1) & hasType(type_Entity, Var_P1)) => 
(((f_holdsDuring(Var_T1,spouse(Var_P1,Var_P2))) => (( ? [Var_WED] : 
 (hasType(type_Wedding, Var_WED) &  
(((f_patient(Var_WED,Var_P1)) & (((f_patient(Var_WED,Var_P2)) & (f_earlier(f_WhenFn(Var_WED),Var_T1)))))))))))))))))))).

fof(axMergeLem382, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_Naming, Var_PROCESS) => 
(( ! [Var_NAME] : 
 ((hasType(type_Entity, Var_NAME) & hasType(type_SymbolicString, Var_NAME)) => 
(( ! [Var_THING] : 
 (hasType(type_Entity, Var_THING) => 
(((((f_patient(Var_PROCESS,Var_THING)) & (f_destination(Var_PROCESS,Var_NAME)))) => (f_holdsDuring(f_FutureFn(f_WhenFn(Var_PROCESS)),names(Var_NAME,Var_THING)))))))))))))).

fof(axMergeLem383, axiom, 
 ( ! [Var_MEET] : 
 (hasType(type_Meeting, Var_MEET) => 
(( ! [Var_AGENT2] : 
 ((hasType(type_Agent, Var_AGENT2) & hasType(type_Object, Var_AGENT2)) => 
(( ! [Var_AGENT1] : 
 ((hasType(type_Agent, Var_AGENT1) & hasType(type_Object, Var_AGENT1)) => 
(((((f_agent(Var_MEET,Var_AGENT1)) & (f_agent(Var_MEET,Var_AGENT2)))) => (f_holdsDuring(f_WhenFn(Var_MEET),orientation(Var_AGENT1,Var_AGENT2,inst_Near)))))))))))))).

fof(axMergeLem384, axiom, 
 ( ! [Var_WAR] : 
 (hasType(type_War, Var_WAR) => 
(( ? [Var_BATTLE] : 
 (hasType(type_Battle, Var_BATTLE) &  
(f_subProcess(Var_BATTLE,Var_WAR)))))))).

fof(axMergeLem385, axiom, 
 ( ! [Var_BATTLE] : 
 (hasType(type_Battle, Var_BATTLE) => 
(( ? [Var_WAR] : 
 (hasType(type_War, Var_WAR) &  
(f_subProcess(Var_BATTLE,Var_WAR)))))))).

fof(axMergeLem386, axiom, 
 ( ! [Var_BATTLE] : 
 (hasType(type_Battle, Var_BATTLE) => 
(( ? [Var_ATTACK] : 
 (hasType(type_ViolentContest, Var_ATTACK) &  
(f_subProcess(Var_ATTACK,Var_BATTLE)))))))).

fof(axMergeLem387, axiom, 
 ( ! [Var_MOVE] : 
 (hasType(type_Maneuver, Var_MOVE) => 
(( ? [Var_CONTEST] : 
 (hasType(type_Contest, Var_CONTEST) &  
(f_subProcess(Var_MOVE,Var_CONTEST)))))))).

fof(axMergeLem388, axiom, 
 ( ! [Var_ATTACK] : 
 (hasType(type_Attack, Var_ATTACK) => 
(( ? [Var_CONTEST] : 
 (hasType(type_ViolentContest, Var_CONTEST) &  
(f_subProcess(Var_ATTACK,Var_CONTEST)))))))).

fof(axMergeLem389, axiom, 
 ( ! [Var_DEFENSE] : 
 (hasType(type_DefensiveManeuver, Var_DEFENSE) => 
(( ? [Var_CONTEST] : 
 (hasType(type_ViolentContest, Var_CONTEST) &  
(f_subProcess(Var_DEFENSE,Var_CONTEST)))))))).

fof(axMergeLem390, axiom, 
 ( ! [Var_SEE] : 
 (hasType(type_Seeing, Var_SEE) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_CognitiveAgent, Var_AGENT)) => 
(((((f_agent(Var_SEE,Var_AGENT)) & (f_patient(Var_SEE,Var_OBJ)))) => (((f_attribute(Var_OBJ,inst_Illuminated)) & (( ? [Var_PROP] : 
 (hasType(type_ColorAttribute, Var_PROP) &  
(f_knows(Var_AGENT,attribute(Var_OBJ,Var_PROP))))))))))))))))))).

fof(axMergeLem391, axiom, 
 ( ! [Var_SMELL] : 
 (hasType(type_Smelling, Var_SMELL) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(((f_patient(Var_SMELL,Var_OBJ)) => (( ? [Var_ATTR] : 
 (hasType(type_OlfactoryAttribute, Var_ATTR) &  
(f_attribute(Var_OBJ,Var_ATTR))))))))))))).

fof(axMergeLem392, axiom, 
 ( ! [Var_TASTE] : 
 (hasType(type_Tasting, Var_TASTE) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(((f_patient(Var_TASTE,Var_OBJ)) => (( ? [Var_ATTR] : 
 (hasType(type_TasteAttribute, Var_ATTR) &  
(f_attribute(Var_OBJ,Var_ATTR))))))))))))).

fof(axMergeLem393, axiom, 
 ( ! [Var_HEAR] : 
 (hasType(type_Hearing, Var_HEAR) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(((f_patient(Var_HEAR,Var_OBJ)) => (( ? [Var_ATTR] : 
 (hasType(type_SoundAttribute, Var_ATTR) &  
(f_attribute(Var_OBJ,Var_ATTR))))))))))))).

fof(axMergeLem394, axiom, 
 ( ! [Var_TACTILE] : 
 (hasType(type_TactilePerception, Var_TACTILE) => 
(( ? [Var_TOUCH] : 
 (hasType(type_Touching, Var_TOUCH) &  
(f_subProcess(Var_TOUCH,Var_TACTILE)))))))).

fof(axMergeLem395, axiom, 
 ( ! [Var_REGION] : 
 (hasType(type_Region, Var_REGION) => 
(((( ? [Var_EMIT] : 
 (hasType(type_RadiatingLight, Var_EMIT) &  
(f_patient(Var_EMIT,Var_REGION))))) <=> (f_attribute(Var_REGION,inst_Illuminated))))))).

fof(axMergeLem396, axiom, 
 ( ! [Var_EMIT] : 
 (hasType(type_RadiatingSound, Var_EMIT) => 
(( ! [Var_SOUND] : 
 ((hasType(type_Agent, Var_SOUND) & hasType(type_Object, Var_SOUND)) => 
(((f_agent(Var_EMIT,Var_SOUND)) => (( ? [Var_ATTR] : 
 (hasType(type_SoundAttribute, Var_ATTR) &  
(f_attribute(Var_SOUND,Var_ATTR))))))))))))).

fof(axMergeLem397, axiom, 
 ( ! [Var_PROCESS] : 
 (hasType(type_StateChange, Var_PROCESS) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(((f_patient(Var_PROCESS,Var_OBJ)) => (( ? [Var_STATE1] : 
 (hasType(type_PhysicalState, Var_STATE1) &  
(( ? [Var_STATE2] : 
 (hasType(type_PhysicalState, Var_STATE2) &  
(( ? [Var_PART] : 
 (hasType(type_Object, Var_PART) &  
(((f_part(Var_PART,Var_OBJ)) & (((Var_STATE1 != Var_STATE2) & (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_PROCESS)),attribute(Var_PART,Var_STATE1))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_PROCESS)),attribute(Var_PART,Var_STATE2)))))))))))))))))))))))))).

fof(axMergeLem398, axiom, 
 ( ! [Var_MELT] : 
 (hasType(type_Melting, Var_MELT) => 
(( ? [Var_HEAT] : 
 (hasType(type_Heating, Var_HEAT) &  
(f_subProcess(Var_HEAT,Var_MELT)))))))).

fof(axMergeLem399, axiom, 
 ( ! [Var_MELT] : 
 (hasType(type_Melting, Var_MELT) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(((f_patient(Var_MELT,Var_OBJ)) => (( ? [Var_PART] : 
 (hasType(type_Object, Var_PART) &  
(((f_part(Var_PART,Var_OBJ)) & (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_MELT)),attribute(Var_PART,inst_Solid))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_MELT)),attribute(Var_PART,inst_Liquid)))))))))))))))))).

fof(axMergeLem400, axiom, 
 ( ! [Var_BOIL] : 
 (hasType(type_Boiling, Var_BOIL) => 
(( ? [Var_HEAT] : 
 (hasType(type_Heating, Var_HEAT) &  
(f_subProcess(Var_HEAT,Var_BOIL)))))))).

fof(axMergeLem401, axiom, 
 ( ! [Var_BOIL] : 
 (hasType(type_Boiling, Var_BOIL) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(((f_patient(Var_BOIL,Var_OBJ)) => (( ? [Var_PART] : 
 (hasType(type_Object, Var_PART) &  
(((f_part(Var_PART,Var_OBJ)) & (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_BOIL)),attribute(Var_PART,inst_Liquid))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_BOIL)),attribute(Var_PART,inst_Gas)))))))))))))))))).

fof(axMergeLem402, axiom, 
 ( ! [Var_COND] : 
 (hasType(type_Condensing, Var_COND) => 
(( ? [Var_COOL] : 
 (hasType(type_Cooling, Var_COOL) &  
(f_subProcess(Var_COOL,Var_COND)))))))).

fof(axMergeLem403, axiom, 
 ( ! [Var_COND] : 
 (hasType(type_Condensing, Var_COND) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(((f_patient(Var_COND,Var_OBJ)) => (( ? [Var_PART] : 
 (hasType(type_Object, Var_PART) &  
(((f_part(Var_PART,Var_OBJ)) & (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_COND)),attribute(Var_PART,inst_Gas))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_COND)),attribute(Var_PART,inst_Liquid)))))))))))))))))).

fof(axMergeLem404, axiom, 
 ( ! [Var_FREEZE] : 
 (hasType(type_Freezing, Var_FREEZE) => 
(( ? [Var_COOL] : 
 (hasType(type_Cooling, Var_COOL) &  
(f_subProcess(Var_COOL,Var_FREEZE)))))))).

fof(axMergeLem405, axiom, 
 ( ! [Var_FREEZE] : 
 (hasType(type_Freezing, Var_FREEZE) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(((f_patient(Var_FREEZE,Var_OBJ)) => (( ? [Var_PART] : 
 (hasType(type_Object, Var_PART) &  
(((f_part(Var_PART,Var_OBJ)) & (((f_holdsDuring(f_BeginFn(f_WhenFn(Var_FREEZE)),attribute(Var_PART,inst_Liquid))) & (f_holdsDuring(f_EndFn(f_WhenFn(Var_FREEZE)),attribute(Var_PART,inst_Solid)))))))))))))))))).

fof(axMergeLem406, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(((f_leader(f_GovernmentFn(Var_AREA),Var_PERSON)) => (f_leader(Var_AREA,Var_PERSON)))))))))).

fof(axMergeLem407, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(((f_leader(Var_AREA,Var_PERSON)) => (f_leader(f_GovernmentFn(Var_AREA),Var_PERSON)))))))))).

fof(axMergeLem408, axiom, 
 ( ! [Var_AREA] : 
 (hasType(type_WaterArea, Var_AREA) => 
(( ? [Var_WATER] : 
 (hasType(type_Water, Var_WATER) &  
(( ? [Var_HOLE] : 
 (hasType(type_Hole, Var_HOLE) &  
(( ? [Var_BED] : 
 ((hasType(type_Entity, Var_BED) & hasType(type_Object, Var_BED)) &  
(((f_HoleHostFn(Var_HOLE) = Var_BED) & (((f_properlyFills(Var_WATER,Var_HOLE)) & (f_MereologicalSumFn(Var_BED,Var_WATER) = Var_AREA))))))))))))))))).

fof(axMergeLem409, axiom, 
 ( ! [Var_LAND1] : 
 (hasType(type_LandArea, Var_LAND1) => 
(( ? [Var_LAND2] : 
 ((hasType(type_Continent, Var_LAND2) | hasType(type_Island, Var_LAND2)) &  
(f_part(Var_LAND1,Var_LAND2)))))))).

fof(axMergeLem410, axiom, 
 ( ! [Var_BANK] : 
 (hasType(type_ShoreArea, Var_BANK) => 
(( ? [Var_WATER] : 
 (hasType(type_WaterArea, Var_WATER) &  
(f_meetsSpatially(Var_BANK,Var_WATER)))))))).

fof(axMergeLem411, axiom, 
 ( ! [Var_ISLE] : 
 (hasType(type_Island, Var_ISLE) => 
(( ? [Var_WATER] : 
 (hasType(type_WaterArea, Var_WATER) &  
(f_meetsSpatially(Var_ISLE,Var_WATER)))))))).

fof(axMergeLem412, axiom, 
 ( ! [Var_STATE] : 
 (hasType(type_StateOrProvince, Var_STATE) => 
(( ? [Var_LAND] : 
 (hasType(type_Nation, Var_LAND) &  
(f_properPart(Var_STATE,Var_LAND)))))))).

fof(axMergeLem413, axiom, 
 ( ! [Var_STATE] : 
 (hasType(type_County, Var_STATE) => 
(( ? [Var_LAND] : 
 (hasType(type_StateOrProvince, Var_LAND) &  
(f_properPart(Var_STATE,Var_LAND)))))))).

fof(axMergeLem414, axiom, 
 ( ! [Var_ATTR2] : 
 ((hasType(type_Attribute, Var_ATTR2) & hasType(type_DevelopmentalAttribute, Var_ATTR2)) => 
(( ! [Var_ATTR1] : 
 ((hasType(type_DevelopmentalAttribute, Var_ATTR1) & hasType(type_Attribute, Var_ATTR1)) => 
(( ! [Var_OBJ] : 
 (hasType(type_OrganicObject, Var_OBJ) => 
(( ! [Var_TIME1] : 
 ((hasType(type_TimePosition, Var_TIME1) & hasType(type_TimeInterval, Var_TIME1)) => 
(((((f_holdsDuring(Var_TIME1,developmentalForm(Var_OBJ,Var_ATTR1))) & (f_successorAttributeClosure(Var_ATTR2,Var_ATTR1)))) => (( ? [Var_TIME2] : 
 ((hasType(type_TimeInterval, Var_TIME2) & hasType(type_TimePosition, Var_TIME2)) &  
(((f_earlier(Var_TIME2,Var_TIME1)) & (f_holdsDuring(Var_TIME2,developmentalForm(Var_OBJ,Var_ATTR2)))))))))))))))))))))).

fof(axMergeLem415, axiom, 
 ( ! [Var_ORGANISM] : 
 (hasType(type_Organism, Var_ORGANISM) => 
(( ? [Var_BIRTH] : 
 (hasType(type_Birth, Var_BIRTH) &  
(f_experiencer(Var_BIRTH,Var_ORGANISM)))))))).

fof(axMergeLem416, axiom, 
 ( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(( ! [Var_ORGANISM] : 
 ((hasType(type_Organism, Var_ORGANISM) & hasType(type_Physical, Var_ORGANISM)) => 
(( ! [Var_T1] : 
 (hasType(type_TimePosition, Var_T1) => 
(((f_holdsDuring(Var_T1,inhabits(Var_ORGANISM,Var_OBJ))) => (( ? [Var_TIME] : 
 (hasType(type_TimeInterval, Var_TIME) &  
(((f_temporalPart(Var_TIME,Var_T1)) & (f_holdsDuring(Var_TIME,located(Var_ORGANISM,Var_OBJ))))))))))))))))))).

fof(axMergeLem417, axiom, 
 ( ! [Var_ALGA] : 
 (hasType(type_Alga, Var_ALGA) => 
(( ? [Var_WATER] : 
 (hasType(type_Water, Var_WATER) &  
(f_inhabits(Var_ALGA,Var_WATER)))))))).

fof(axMergeLem418, axiom, 
 ( ! [Var_BACTERIUM] : 
 (hasType(type_Bacterium, Var_BACTERIUM) => 
(( ? [Var_CELL1] : 
 (hasType(type_Cell, Var_CELL1) &  
(((f_component(Var_CELL1,Var_BACTERIUM)) & (( ! [Var_CELL2] : 
 (hasType(type_Cell, Var_CELL2) => 
(((f_component(Var_CELL2,Var_BACTERIUM)) => (Var_CELL1 = Var_CELL2)))))))))))))).

fof(axMergeLem419, axiom, 
 ( ! [Var_VIRUS] : 
 (hasType(type_Virus, Var_VIRUS) => 
(( ! [Var_PROC] : 
 (hasType(type_Replication, Var_PROC) => 
(((f_agent(Var_PROC,Var_VIRUS)) => (( ? [Var_CELL] : 
 (hasType(type_Cell, Var_CELL) &  
(f_located(Var_PROC,Var_CELL))))))))))))).

fof(axMergeLem420, axiom, 
 ( ! [Var_FISH] : 
 (hasType(type_Fish, Var_FISH) => 
(( ? [Var_WATER] : 
 (hasType(type_Water, Var_WATER) &  
(f_inhabits(Var_FISH,Var_WATER)))))))).

fof(axMergeLem421, axiom, 
 ( ! [Var_MAN] : 
 (hasType(type_Man, Var_MAN) => 
(f_attribute(Var_MAN,inst_Male))))).

fof(axMergeLem422, axiom, 
 ( ! [Var_WOMAN] : 
 (hasType(type_Woman, Var_WOMAN) => 
(f_attribute(Var_WOMAN,inst_Female))))).

fof(axMergeLem423, axiom, 
 ( ! [Var_MIX] : 
 (hasType(type_LiquidMixture, Var_MIX) => 
(( ? [Var_PART] : 
 (hasType(type_Object, Var_PART) &  
(((f_part(Var_PART,Var_MIX)) & (f_attribute(Var_PART,inst_Liquid)))))))))).

fof(axMergeLem424, axiom, 
 ( ! [Var_MIX] : 
 (hasType(type_GasMixture, Var_MIX) => 
(( ? [Var_PART] : 
 (hasType(type_Object, Var_PART) &  
(((f_part(Var_PART,Var_MIX)) & (f_attribute(Var_PART,inst_Gas)))))))))).

fof(axMergeLem425, axiom, 
 ( ! [Var_SMOKE] : 
 (hasType(type_Smoke, Var_SMOKE) => 
(( ? [Var_BURNING] : 
 (hasType(type_Combustion, Var_BURNING) &  
(f_result(Var_BURNING,Var_SMOKE)))))))).

fof(axMergeLem426, axiom, 
 ( ! [Var_CLOUD] : 
 (hasType(type_WaterCloud, Var_CLOUD) => 
(( ? [Var_WATER] : 
 (hasType(type_Water, Var_WATER) &  
(f_part(Var_WATER,Var_CLOUD)))))))).

fof(axMergeLem427, axiom, 
 ( ! [Var_WIND] : 
 (hasType(type_Wind, Var_WIND) => 
(( ? [Var_AIR] : 
 (hasType(type_Air, Var_AIR) &  
(f_patient(Var_WIND,Var_AIR)))))))).

fof(axMergeLem428, axiom, 
 ( ! [Var_HORMONE] : 
 (hasType(type_Hormone, Var_HORMONE) => 
(( ? [Var_GLAND] : 
 (hasType(type_Gland, Var_GLAND) &  
(( ? [Var_PROCESS] : 
 (hasType(type_Process, Var_PROCESS) &  
(((f_instrument(Var_PROCESS,Var_GLAND)) & (f_result(Var_PROCESS,Var_HORMONE))))))))))))).

fof(axMergeLem429, axiom, 
 ( ! [Var_FOOD] : 
 (hasType(type_Food, Var_FOOD) => 
(( ? [Var_NUTRIENT] : 
 (hasType(type_Nutrient, Var_NUTRIENT) &  
(f_part(Var_NUTRIENT,Var_FOOD)))))))).

fof(axMergeLem430, axiom, 
 ( ! [Var_MEAT] : 
 (hasType(type_Meat, Var_MEAT) => 
(( ! [Var_PART] : 
 (hasType(type_Object, Var_PART) => 
(((f_part(Var_PART,Var_MEAT)) => (( ? [Var_ANIMAL] : 
 (hasType(type_Animal, Var_ANIMAL) &  
(( ? [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) &  
(( ? [Var_SUBPART] : 
 (hasType(type_Object, Var_SUBPART) &  
(((f_part(Var_SUBPART,Var_PART)) & (f_holdsDuring(Var_TIME,part(Var_SUBPART,Var_ANIMAL)))))))))))))))))))))).

fof(axMergeLem431, axiom, 
 ( ! [Var_BEV] : 
 (hasType(type_Beverage, Var_BEV) => 
(f_attribute(Var_BEV,inst_Liquid))))).

fof(axMergeLem432, axiom, 
 ( ! [Var_ANAT] : 
 (hasType(type_AnatomicalStructure, Var_ANAT) => 
(( ? [Var_ORGANISM] : 
 (hasType(type_Organism, Var_ORGANISM) &  
(( ? [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) &  
(((f_temporalPart(Var_TIME,f_WhenFn(Var_ORGANISM))) & (f_holdsDuring(Var_TIME,part(Var_ANAT,Var_ORGANISM)))))))))))))).

fof(axMergeLem433, axiom, 
 ( ! [Var_PART] : 
 (hasType(type_AnatomicalStructure, Var_PART) => 
(( ? [Var_CELL] : 
 (hasType(type_Cell, Var_CELL) &  
(f_part(Var_CELL,Var_PART)))))))).

fof(axMergeLem434, axiom, 
 ( ! [Var_STRUCTURE] : 
 (hasType(type_AbnormalAnatomicalStructure, Var_STRUCTURE) => 
(( ? [Var_PROC] : 
 (hasType(type_PathologicProcess, Var_PROC) &  
(f_result(Var_PROC,Var_STRUCTURE)))))))).

fof(axMergeLem435, axiom, 
 ( ! [Var_PART] : 
 (hasType(type_BodyPart, Var_PART) => 
(( ? [Var_ORGANISM] : 
 (hasType(type_Organism, Var_ORGANISM) &  
(( ? [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) &  
(((f_temporalPart(Var_TIME,f_WhenFn(Var_ORGANISM))) & (f_holdsDuring(Var_TIME,component(Var_PART,Var_ORGANISM)))))))))))))).

fof(axMergeLem436, axiom, 
 ( ! [Var_PART] : 
 (hasType(type_BodyPart, Var_PART) => 
(( ? [Var_PROC] : 
 (hasType(type_PhysiologicProcess, Var_PROC) &  
(f_result(Var_PROC,Var_PART)))))))).

fof(axMergeLem437, axiom, 
 ( ! [Var_SEED] : 
 (hasType(type_Seed, Var_SEED) => 
(( ? [Var_PLANT] : 
 (hasType(type_FloweringPlant, Var_PLANT) &  
(( ? [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) &  
(f_holdsDuring(Var_TIME,part(Var_SEED,Var_PLANT)))))))))))).

fof(axMergeLem438, axiom, 
 ( ! [Var_SPORE] : 
 (hasType(type_Spore, Var_SPORE) => 
(( ? [Var_PLANT] : 
 (hasType(type_NonFloweringPlant, Var_PLANT) &  
(( ? [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) &  
(f_holdsDuring(Var_TIME,part(Var_SPORE,Var_PLANT)))))))))))).

fof(axMergeLem439, axiom, 
 ( ! [Var_COVER] : 
 (hasType(type_BodyCovering, Var_COVER) => 
(( ? [Var_BODY] : 
 ((hasType(type_Organism, Var_BODY) | hasType(type_BodyPart, Var_BODY)) &  
(f_superficialPart(Var_COVER,Var_BODY)))))))).

fof(axMergeLem440, axiom, 
 ( ! [Var_JUNCT] : 
 (hasType(type_BodyJunction, Var_JUNCT) => 
(( ? [Var_OBJ1] : 
 (hasType(type_BodyPart, Var_OBJ1) &  
(( ? [Var_OBJ2] : 
 (hasType(type_BodyPart, Var_OBJ2) &  
(f_connects(Var_JUNCT,Var_OBJ1,Var_OBJ2))))))))))).

fof(axMergeLem441, axiom, 
 ( ! [Var_STUFF] : 
 (hasType(type_Tissue, Var_STUFF) => 
(( ? [Var_PART] : 
 (hasType(type_Cell, Var_PART) &  
(f_part(Var_PART,Var_STUFF)))))))).

fof(axMergeLem442, axiom, 
 ( ! [Var_STUFF] : 
 (hasType(type_Tissue, Var_STUFF) => 
(( ? [Var_ORGANISM] : 
 (hasType(type_Organism, Var_ORGANISM) &  
(f_part(Var_STUFF,Var_ORGANISM)))))))).

fof(axMergeLem443, axiom, 
 ( ! [Var_BONE] : 
 (hasType(type_Bone, Var_BONE) => 
(( ? [Var_VERT] : 
 (hasType(type_Vertebrate, Var_VERT) &  
(f_part(Var_BONE,Var_VERT)))))))).

fof(axMergeLem444, axiom, 
 ( ! [Var_MORPH] : 
 (hasType(type_Morpheme, Var_MORPH) => 
(( ? [Var_WORD] : 
 (hasType(type_Word, Var_WORD) &  
(f_part(Var_MORPH,Var_WORD)))))))).

fof(axMergeLem445, axiom, 
 ( ! [Var_WORD] : 
 (hasType(type_Word, Var_WORD) => 
(( ? [Var_PART] : 
 (hasType(type_Morpheme, Var_PART) &  
(f_part(Var_PART,Var_WORD)))))))).

fof(axMergeLem446, axiom, 
 ( ! [Var_PHRASE] : 
 (hasType(type_Phrase, Var_PHRASE) => 
(( ? [Var_PART1] : 
 (hasType(type_Word, Var_PART1) &  
(( ? [Var_PART2] : 
 (hasType(type_Word, Var_PART2) &  
(((f_part(Var_PART1,Var_PHRASE)) & (((f_part(Var_PART2,Var_PHRASE)) & (Var_PART1 != Var_PART2)))))))))))))).

fof(axMergeLem447, axiom, 
 ( ! [Var_PHRASE] : 
 (hasType(type_VerbPhrase, Var_PHRASE) => 
(( ? [Var_VERB] : 
 (hasType(type_Verb, Var_VERB) &  
(f_part(Var_VERB,Var_PHRASE)))))))).

fof(axMergeLem448, axiom, 
 ( ! [Var_SENTENCE] : 
 (hasType(type_Sentence, Var_SENTENCE) => 
(( ? [Var_PHRASE1] : 
 (hasType(type_NounPhrase, Var_PHRASE1) &  
(( ? [Var_PHRASE2] : 
 (hasType(type_VerbPhrase, Var_PHRASE2) &  
(((f_part(Var_PHRASE1,Var_SENTENCE)) & (f_part(Var_PHRASE2,Var_SENTENCE))))))))))))).

fof(axMergeLem449, axiom, 
 ( ! [Var_PHRASE] : 
 (hasType(type_NounPhrase, Var_PHRASE) => 
(( ? [Var_NOUN] : 
 (hasType(type_Noun, Var_NOUN) &  
(f_part(Var_NOUN,Var_PHRASE)))))))).

fof(axMergeLem450, axiom, 
 ( ! [Var_PHRASE] : 
 (hasType(type_PrepositionalPhrase, Var_PHRASE) => 
(( ? [Var_PREP] : 
 (hasType(type_ParticleWord, Var_PREP) &  
(f_part(Var_PREP,Var_PHRASE)))))))).

fof(axMergeLem451, axiom, 
 ( ! [Var_TEXT] : 
 (hasType(type_Text, Var_TEXT) => 
(( ? [Var_PART] : 
 (hasType(type_LinguisticExpression, Var_PART) &  
(f_part(Var_PART,Var_TEXT)))))))).

fof(axMergeLem452, axiom, 
 ( ! [Var_TEXT] : 
 (hasType(type_Text, Var_TEXT) => 
(( ? [Var_WRITE] : 
 (hasType(type_Writing, Var_WRITE) &  
(f_result(Var_WRITE,Var_TEXT)))))))).

fof(axMergeLem453, axiom, 
 ( ! [Var_SENT] : 
 (hasType(type_Sentence, Var_SENT) => 
(( ? [Var_PROP] : 
 (hasType(type_Proposition, Var_PROP) &  
(f_containsInformation(Var_SENT,Var_PROP)))))))).

fof(axMergeLem454, axiom, 
 ( ! [Var_TEXT] : 
 (hasType(type_Summary, Var_TEXT) => 
(( ? [Var_TEXT2] : 
 (hasType(type_Text, Var_TEXT2) &  
(f_subsumesContentInstance(Var_TEXT2,Var_TEXT)))))))).

fof(axMergeLem455, axiom, 
 ( ! [Var_SERIES] : 
 (hasType(type_Series, Var_SERIES) => 
(( ? [Var_BOOK1] : 
 (hasType(type_Book, Var_BOOK1) &  
(( ? [Var_BOOK2] : 
 (hasType(type_Book, Var_BOOK2) &  
(((f_subsumesContentInstance(Var_SERIES,Var_BOOK1)) & (((f_subsumesContentInstance(Var_SERIES,Var_BOOK2)) & (Var_BOOK1 != Var_BOOK2)))))))))))))).

fof(axMergeLem456, axiom, 
 ( ! [Var_ARTICLE1] : 
 (hasType(type_Article, Var_ARTICLE1) => 
(( ! [Var_BOOK] : 
 (hasType(type_Book, Var_BOOK) => 
(((f_subsumesContentInstance(Var_BOOK,Var_ARTICLE1)) => (( ? [Var_ARTICLE2] : 
 (hasType(type_Article, Var_ARTICLE2) &  
(((Var_ARTICLE2 != Var_ARTICLE1) & (f_subsumesContentInstance(Var_BOOK,Var_ARTICLE2))))))))))))))).

fof(axMergeLem457, axiom, 
 ( ! [Var_CURRENCY] : 
 (hasType(type_Currency, Var_CURRENCY) => 
(( ? [Var_MEASURE] : 
 (hasType(type_CurrencyMeasure, Var_MEASURE) &  
(f_monetaryValue(Var_CURRENCY,Var_MEASURE)))))))).

fof(axMergeLem458, axiom, 
 ( ! [Var_MOLE] : 
 (hasType(type_Molecule, Var_MOLE) => 
(( ? [Var_ATOM1] : 
 (hasType(type_Atom, Var_ATOM1) &  
(( ? [Var_ATOM2] : 
 (hasType(type_Atom, Var_ATOM2) &  
(((f_part(Var_ATOM1,Var_MOLE)) & (((f_part(Var_ATOM2,Var_MOLE)) & (Var_ATOM1 != Var_ATOM2)))))))))))))).

fof(axMergeLem459, axiom, 
 ( ! [Var_ARTIFACT] : 
 (hasType(type_Artifact, Var_ARTIFACT) => 
(( ? [Var_MAKING] : 
 (hasType(type_Making, Var_MAKING) &  
(f_result(Var_MAKING,Var_ARTIFACT)))))))).

fof(axMergeLem460, axiom, 
 ( ! [Var_PRODUCT] : 
 (hasType(type_Product, Var_PRODUCT) => 
(( ? [Var_MANUFACTURE] : 
 (hasType(type_Manufacture, Var_MANUFACTURE) &  
(f_result(Var_MANUFACTURE,Var_PRODUCT)))))))).

fof(axMergeLem461, axiom, 
 ( ! [Var_ARTIFACT] : 
 (hasType(type_StationaryArtifact, Var_ARTIFACT) => 
(( ? [Var_PLACE] : 
 ((hasType(type_Object, Var_PLACE) & hasType(type_Entity, Var_PLACE)) &  
(((f_holdsDuring(f_WhenFn(Var_ARTIFACT),located(Var_ARTIFACT,Var_PLACE))) & (( ~ ( ? [Var_P2] : 
 ((hasType(type_Object, Var_P2) & hasType(type_Entity, Var_P2)) &  
(((f_holdsDuring(f_WhenFn(Var_ARTIFACT),located(Var_ARTIFACT,Var_P2))) & (Var_PLACE != Var_P2))))))))))))))).

fof(axMergeLem462, axiom, 
 ( ! [Var_BUILDING] : 
 (hasType(type_Building, Var_BUILDING) => 
(( ? [Var_HUMAN] : 
 (hasType(type_Human, Var_HUMAN) &  
(((f_inhabits(Var_HUMAN,Var_BUILDING)) | (( ? [Var_ACT] : 
 ((hasType(type_Process, Var_ACT) & hasType(type_Physical, Var_ACT)) &  
(((f_agent(Var_ACT,Var_HUMAN)) & (f_located(Var_ACT,Var_BUILDING))))))))))))))).

fof(axMergeLem463, axiom, 
 ( ! [Var_ROOM] : 
 (hasType(type_Room, Var_ROOM) => 
(( ? [Var_BUILD] : 
 (hasType(type_Building, Var_BUILD) &  
(f_properPart(Var_ROOM,Var_BUILD)))))))).

fof(axMergeLem464, axiom, 
 ( ! [Var_RESIDENCE] : 
 (hasType(type_PermanentResidence, Var_RESIDENCE) => 
(( ? [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) &  
(f_home(Var_PERSON,Var_RESIDENCE)))))))).

fof(axMergeLem465, axiom, 
 ( ! [Var_RESIDENCE] : 
 (hasType(type_TemporaryResidence, Var_RESIDENCE) => 
(( ~ ( ? [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) &  
(f_home(Var_PERSON,Var_RESIDENCE))))))))).

fof(axMergeLem466, axiom, 
 ( ! [Var_CLOTHING] : 
 (hasType(type_Clothing, Var_CLOTHING) => 
(( ? [Var_FABRIC] : 
 (hasType(type_Fabric, Var_FABRIC) &  
(f_part(Var_FABRIC,Var_CLOTHING)))))))).

fof(axMergeLem467, axiom, 
 ( ! [Var_CLOTHING] : 
 ((hasType(type_Clothing, Var_CLOTHING) & hasType(type_Physical, Var_CLOTHING)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Animal, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((f_wears(Var_AGENT,Var_CLOTHING)) => (f_located(Var_CLOTHING,Var_AGENT)))))))))).

fof(axMergeLem468, axiom, 
 ( ! [Var_P] : 
 ((hasType(type_Object, Var_P) & hasType(type_Clothing, Var_P)) => 
(( ! [Var_C] : 
 ((hasType(type_Clothing, Var_C) & hasType(type_Object, Var_C)) => 
(( ! [Var_A] : 
 (hasType(type_Animal, Var_A) => 
(((((f_wears(Var_A,Var_C)) & (f_part(Var_P,Var_C)))) => (f_wears(Var_A,Var_P))))))))))))).

fof(axMergeLem469, axiom, 
 ( ! [Var_TRANSPORT] : 
 (hasType(type_Vehicle, Var_TRANSPORT) => 
(( ! [Var_MOVE] : 
 (hasType(type_Translocation, Var_MOVE) => 
(( ! [Var_FROM] : 
 (hasType(type_Object, Var_FROM) => 
(((((f_instrument(Var_MOVE,Var_TRANSPORT)) & (f_origin(Var_MOVE,Var_FROM)))) => (f_holdsDuring(f_BeginFn(f_WhenFn(Var_MOVE)),located(Var_TRANSPORT,Var_FROM)))))))))))))).

fof(axMergeLem470, axiom, 
 ( ! [Var_TRANSPORT] : 
 (hasType(type_Vehicle, Var_TRANSPORT) => 
(( ! [Var_MOVE] : 
 (hasType(type_Translocation, Var_MOVE) => 
(( ! [Var_TO] : 
 ((hasType(type_Entity, Var_TO) & hasType(type_Object, Var_TO)) => 
(((((f_instrument(Var_MOVE,Var_TRANSPORT)) & (f_destination(Var_MOVE,Var_TO)))) => (f_holdsDuring(f_BeginFn(f_WhenFn(Var_MOVE)),located(Var_TRANSPORT,Var_TO)))))))))))))).

fof(axMergeLem471, axiom, 
 ( ! [Var_DEVICE] : 
 (hasType(type_AttachingDevice, Var_DEVICE) => 
(( ? [Var_ATTACH] : 
 (hasType(type_Attaching, Var_ATTACH) &  
(f_instrument(Var_ATTACH,Var_DEVICE)))))))).

fof(axMergeLem472, axiom, 
 ( ! [Var_COMP] : 
 (hasType(type_EngineeringComponent, Var_COMP) => 
(( ? [Var_DEVICE] : 
 (hasType(type_Device, Var_DEVICE) &  
(f_component(Var_COMP,Var_DEVICE)))))))).

fof(axMergeLem473, axiom, 
 ( ! [Var_MACHINE] : 
 (hasType(type_Machine, Var_MACHINE) => 
(( ? [Var_COMP1] : 
 (hasType(type_EngineeringComponent, Var_COMP1) &  
(( ? [Var_COMP2] : 
 (hasType(type_EngineeringComponent, Var_COMP2) &  
(((Var_COMP1 != Var_COMP2) & (((f_part(Var_COMP1,Var_MACHINE)) & (f_part(Var_COMP2,Var_MACHINE))))))))))))))).

fof(axMergeLem474, axiom, 
 ( ! [Var_COMP2] : 
 (hasType(type_EngineeringComponent, Var_COMP2) => 
(( ! [Var_COMP1] : 
 (hasType(type_EngineeringComponent, Var_COMP1) => 
(((f_connectedEngineeringComponents(Var_COMP1,Var_COMP2)) => (((( ~ (f_engineeringSubcomponent(Var_COMP1,Var_COMP2)))) & (( ~ (f_engineeringSubcomponent(Var_COMP2,Var_COMP1)))))))))))))).

fof(axMergeLem475, axiom, 
 ( ! [Var_CONNECTION] : 
 (hasType(type_EngineeringConnection, Var_CONNECTION) => 
(( ? [Var_COMP2] : 
 (hasType(type_SelfConnectedObject, Var_COMP2) &  
(( ? [Var_COMP1] : 
 (hasType(type_EngineeringComponent, Var_COMP1) &  
(f_connectsEngineeringComponents(Var_CONNECTION,Var_COMP1,Var_COMP2))))))))))).

fof(axMergeLem476, axiom, 
 ( ! [Var_COMP2] : 
 ((hasType(type_EngineeringComponent, Var_COMP2) & hasType(type_SelfConnectedObject, Var_COMP2)) => 
(( ! [Var_COMP1] : 
 (hasType(type_EngineeringComponent, Var_COMP1) => 
(((f_connectedEngineeringComponents(Var_COMP1,Var_COMP2)) <=> (( ? [Var_CONNECTION] : 
 (hasType(type_EngineeringComponent, Var_CONNECTION) &  
(f_connectsEngineeringComponents(Var_CONNECTION,Var_COMP1,Var_COMP2))))))))))))).

fof(axMergeLem477, axiom, 
 ( ! [Var_GROUP] : 
 (hasType(type_AgeGroup, Var_GROUP) => 
(( ! [Var_AGE2] : 
 ((hasType(type_TimeDuration, Var_AGE2) & hasType(type_Entity, Var_AGE2)) => 
(( ! [Var_AGE1] : 
 ((hasType(type_TimeDuration, Var_AGE1) & hasType(type_Entity, Var_AGE1)) => 
(( ! [Var_MEMB2] : 
 ((hasType(type_SelfConnectedObject, Var_MEMB2) & hasType(type_Object, Var_MEMB2)) => 
(( ! [Var_MEMB1] : 
 ((hasType(type_SelfConnectedObject, Var_MEMB1) & hasType(type_Object, Var_MEMB1)) => 
(((((f_member(Var_MEMB1,Var_GROUP)) & (((f_member(Var_MEMB2,Var_GROUP)) & (((f_age(Var_MEMB1,Var_AGE1)) & (f_age(Var_MEMB2,Var_AGE2)))))))) => (Var_AGE1 = Var_AGE2)))))))))))))))))).

fof(axMergeLem478, axiom, 
 ( ! [Var_GROUP] : 
 (hasType(type_FamilyGroup, Var_GROUP) => 
(( ! [Var_MEMB2] : 
 ((hasType(type_SelfConnectedObject, Var_MEMB2) & hasType(type_Organism, Var_MEMB2)) => 
(( ! [Var_MEMB1] : 
 ((hasType(type_SelfConnectedObject, Var_MEMB1) & hasType(type_Organism, Var_MEMB1)) => 
(((((f_member(Var_MEMB1,Var_GROUP)) & (f_member(Var_MEMB2,Var_GROUP)))) => (f_familyRelation(Var_MEMB1,Var_MEMB2))))))))))))).

fof(axMergeLem479, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_SocialUnit, Var_UNIT) => 
(( ! [Var_MEMBER] : 
 ((hasType(type_SelfConnectedObject, Var_MEMBER) & hasType(type_Human, Var_MEMBER)) => 
(( ? [Var_HOME] : 
 (hasType(type_PermanentResidence, Var_HOME) &  
(((f_member(Var_MEMBER,Var_UNIT)) => (f_home(Var_MEMBER,Var_HOME))))))))))))).

fof(axMergeLem480, axiom, 
 ( ! [Var_FAMILY] : 
 ((hasType(type_Entity, Var_FAMILY) & hasType(type_Collection, Var_FAMILY)) => 
(( ! [Var_P] : 
 (hasType(type_Human, Var_P) => 
(((f_ImmediateFamilyFn(Var_P) = Var_FAMILY) => (( ! [Var_MEMBER] : 
 ((hasType(type_SelfConnectedObject, Var_MEMBER) & hasType(type_Organism, Var_MEMBER)) => 
(((f_member(Var_MEMBER,Var_FAMILY)) => (( ? [Var_OTHER] : 
 (hasType(type_Organism, Var_OTHER) &  
(((f_parent(Var_MEMBER,Var_OTHER)) | (f_parent(Var_OTHER,Var_MEMBER)))))))))))))))))))).

fof(axMergeLem481, axiom, 
 ( ! [Var_FAMILY] : 
 ((hasType(type_Entity, Var_FAMILY) & hasType(type_Collection, Var_FAMILY)) => 
(( ! [Var_PERSON] : 
 ((hasType(type_Human, Var_PERSON) & hasType(type_Organism, Var_PERSON)) => 
(((f_ImmediateFamilyFn(Var_PERSON) = Var_FAMILY) => (( ? [Var_MEMBER] : 
 ((hasType(type_SelfConnectedObject, Var_MEMBER) & hasType(type_Organism, Var_MEMBER)) &  
(((f_member(Var_MEMBER,Var_FAMILY)) & (((f_parent(Var_MEMBER,Var_PERSON)) | (f_parent(Var_PERSON,Var_MEMBER))))))))))))))))).

fof(axMergeLem482, axiom, 
 ( ! [Var_A1] : 
 (hasType(type_Organism, Var_A1) => 
(( ! [Var_A2] : 
 (hasType(type_Organism, Var_A2) => 
(( ! [Var_T1] : 
 (hasType(type_TimePosition, Var_T1) => 
(((f_holdsDuring(Var_T1,legalRelation(Var_A1,Var_A2))) => (f_holdsDuring(Var_T1,relative(Var_A1,Var_A2)))))))))))))).

fof(axMergeLem483, axiom, 
 ( ! [Var_ORGANISM2] : 
 (hasType(type_Organism, Var_ORGANISM2) => 
(( ! [Var_ORGANISM1] : 
 (hasType(type_Organism, Var_ORGANISM1) => 
(((f_familyRelation(Var_ORGANISM1,Var_ORGANISM2)) => (( ? [Var_ORGANISM3] : 
 (hasType(type_Organism, Var_ORGANISM3) &  
(((f_ancestor(Var_ORGANISM3,Var_ORGANISM1)) & (f_ancestor(Var_ORGANISM3,Var_ORGANISM2))))))))))))))).

fof(axMergeLem484, axiom, 
 ( ! [Var_PARENT] : 
 ((hasType(type_Organism, Var_PARENT) & hasType(type_Physical, Var_PARENT)) => 
(( ! [Var_CHILD] : 
 ((hasType(type_Organism, Var_CHILD) & hasType(type_Physical, Var_CHILD)) => 
(((f_parent(Var_CHILD,Var_PARENT)) => (f_before(f_BeginFn(f_WhenFn(Var_PARENT)),f_BeginFn(f_WhenFn(Var_CHILD)))))))))))).

fof(axMergeLem485, axiom, 
 ( ! [Var_REP] : 
 (hasType(type_SexualReproduction, Var_REP) => 
(( ! [Var_PARENT] : 
 ((hasType(type_Organism, Var_PARENT) & hasType(type_Agent, Var_PARENT)) => 
(( ! [Var_CHILD] : 
 ((hasType(type_Organism, Var_CHILD) & hasType(type_Entity, Var_CHILD)) => 
(((((f_parent(Var_CHILD,Var_PARENT)) & (((f_agent(Var_REP,Var_PARENT)) & (f_result(Var_REP,Var_CHILD)))))) => (((f_mother(Var_CHILD,Var_PARENT)) | (f_father(Var_CHILD,Var_PARENT))))))))))))))).

fof(axMergeLem486, axiom, 
 ( ! [Var_ORGANISM] : 
 (hasType(type_Organism, Var_ORGANISM) => 
(( ? [Var_PARENT] : 
 (hasType(type_Organism, Var_PARENT) &  
(f_parent(Var_ORGANISM,Var_PARENT)))))))).

fof(axMergeLem487, axiom, 
 ( ! [Var_MOTHER] : 
 ((hasType(type_Organism, Var_MOTHER) & hasType(type_Object, Var_MOTHER)) => 
(( ! [Var_CHILD] : 
 (hasType(type_Organism, Var_CHILD) => 
(((f_mother(Var_CHILD,Var_MOTHER)) => (f_attribute(Var_MOTHER,inst_Female)))))))))).

fof(axMergeLem488, axiom, 
 ( ! [Var_FATHER] : 
 ((hasType(type_Organism, Var_FATHER) & hasType(type_Object, Var_FATHER)) => 
(( ! [Var_CHILD] : 
 (hasType(type_Organism, Var_CHILD) => 
(((f_father(Var_CHILD,Var_FATHER)) => (f_attribute(Var_FATHER,inst_Male)))))))))).

fof(axMergeLem489, axiom, 
 ( ! [Var_PARENT] : 
 (hasType(type_Organism, Var_PARENT) => 
(( ! [Var_CHILD] : 
 ((hasType(type_Organism, Var_CHILD) & hasType(type_Object, Var_CHILD)) => 
(((f_daughter(Var_CHILD,Var_PARENT)) => (f_attribute(Var_CHILD,inst_Female)))))))))).

fof(axMergeLem490, axiom, 
 ( ! [Var_PARENT] : 
 (hasType(type_Organism, Var_PARENT) => 
(( ! [Var_CHILD] : 
 ((hasType(type_Organism, Var_CHILD) & hasType(type_Object, Var_CHILD)) => 
(((f_son(Var_CHILD,Var_PARENT)) => (f_attribute(Var_CHILD,inst_Male)))))))))).

fof(axMergeLem491, axiom, 
 ( ! [Var_PARENT2] : 
 ((hasType(type_Organism, Var_PARENT2) & hasType(type_Entity, Var_PARENT2)) => 
(( ! [Var_ORGANISM2] : 
 ((hasType(type_Organism, Var_ORGANISM2) & hasType(type_Entity, Var_ORGANISM2)) => 
(( ! [Var_PARENT1] : 
 ((hasType(type_Organism, Var_PARENT1) & hasType(type_Entity, Var_PARENT1)) => 
(( ! [Var_ORGANISM1] : 
 ((hasType(type_Organism, Var_ORGANISM1) & hasType(type_Entity, Var_ORGANISM1)) => 
(((((f_parent(Var_ORGANISM1,Var_PARENT1)) & (((f_parent(Var_ORGANISM2,Var_PARENT1)) & (((f_parent(Var_ORGANISM1,Var_PARENT2)) & (((f_parent(Var_ORGANISM2,Var_PARENT2)) & (((Var_ORGANISM1 != Var_ORGANISM2) & (Var_PARENT1 != Var_PARENT2))))))))))) => (f_sibling(Var_ORGANISM1,Var_ORGANISM2)))))))))))))))).

fof(axMergeLem492, axiom, 
 ( ! [Var_PARENT] : 
 (hasType(type_Organism, Var_PARENT) => 
(( ! [Var_ORG2] : 
 (hasType(type_Organism, Var_ORG2) => 
(( ! [Var_ORG1] : 
 (hasType(type_Organism, Var_ORG1) => 
(((((f_sibling(Var_ORG1,Var_ORG2)) & (f_parent(Var_ORG1,Var_PARENT)))) => (f_parent(Var_ORG2,Var_PARENT))))))))))))).

fof(axMergeLem493, axiom, 
 ( ! [Var_PARENT] : 
 ((hasType(type_Organism, Var_PARENT) & hasType(type_Object, Var_PARENT)) => 
(( ! [Var_CHILD] : 
 (hasType(type_Organism, Var_CHILD) => 
(((((f_parent(Var_CHILD,Var_PARENT)) & (f_attribute(Var_PARENT,inst_Male)))) => (f_father(Var_CHILD,Var_PARENT)))))))))).

fof(axMergeLem494, axiom, 
 ( ! [Var_PARENT] : 
 ((hasType(type_Organism, Var_PARENT) & hasType(type_Object, Var_PARENT)) => 
(( ! [Var_CHILD] : 
 (hasType(type_Organism, Var_CHILD) => 
(((((f_parent(Var_CHILD,Var_PARENT)) & (f_attribute(Var_PARENT,inst_Female)))) => (f_mother(Var_CHILD,Var_PARENT)))))))))).

fof(axMergeLem495, axiom, 
 ( ! [Var_POL] : 
 (hasType(type_PoliticalOrganization, Var_POL) => 
(( ? [Var_PROC] : 
 (hasType(type_PoliticalProcess, Var_PROC) &  
(f_agent(Var_PROC,Var_POL)))))))).

fof(axMergeLem496, axiom, 
 ( ! [Var_ORG] : 
 (hasType(type_GovernmentOrganization, Var_ORG) => 
(( ? [Var_GOV] : 
 (hasType(type_Government, Var_GOV) &  
(f_subOrganization(Var_ORG,Var_GOV)))))))).

fof(axMergeLem497, axiom, 
 ( ! [Var_CP] : 
 (hasType(type_ComputerProgramming, Var_CP) => 
(( ? [Var_C] : 
 (hasType(type_ComputerProgram, Var_C) &  
(f_result(Var_CP,Var_C)))))))).

fof(axMergeLem498, axiom, 
 ( ! [Var_PLAN] : 
 (hasType(type_Plan, Var_PLAN) => 
(( ! [Var_OBJ] : 
 (hasType(type_ContentBearingObject, Var_OBJ) => 
(((f_containsInformation(Var_OBJ,Var_PLAN)) => (( ? [Var_PLANNING] : 
 (hasType(type_Planning, Var_PLANNING) &  
(f_result(Var_PLANNING,Var_OBJ))))))))))))).

fof(axMergeLem499, axiom, 
 ( ! [Var_REASON] : 
 (hasType(type_Reasoning, Var_REASON) => 
(( ? [Var_ARGUMENT] : 
 (hasType(type_Argument, Var_ARGUMENT) &  
(f_realization(Var_REASON,Var_ARGUMENT)))))))).

fof(axMergeLem500, axiom, 
 ( ! [Var_ARGUMENT] : 
 (hasType(type_Argument, Var_ARGUMENT) => 
(( ? [Var_CONCLUSION] : 
 (hasType(type_Argument, Var_CONCLUSION) &  
(( ? [Var_PREMISES] : 
 (hasType(type_Entity, Var_PREMISES) &  
(((f_PremisesFn(Var_ARGUMENT) = Var_PREMISES) & (f_conclusion(Var_CONCLUSION,Var_ARGUMENT))))))))))))).

fof(axMergeLem501, axiom, 
 ( ! [Var_ARGUMENT] : 
 (hasType(type_Argument, Var_ARGUMENT) => 
(( ! [Var_PROPOSITION] : 
 (hasType(type_Proposition, Var_PROPOSITION) => 
(( ! [Var_PREMISES] : 
 ((hasType(type_Entity, Var_PREMISES) & hasType(type_Proposition, Var_PREMISES)) => 
(((Var_PREMISES = f_PremisesFn(Var_ARGUMENT)) => (((f_subProposition(Var_PROPOSITION,Var_PREMISES)) <=> (f_premise(Var_ARGUMENT,Var_PROPOSITION))))))))))))))).

fof(axMergeLem502, axiom, 
 ( ! [Var_ATTR1] : 
 ((hasType(type_DirectionalAttribute, Var_ATTR1) & hasType(type_Entity, Var_ATTR1)) => 
(( ! [Var_PROC] : 
 (hasType(type_Process, Var_PROC) => 
(( ! [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) => 
(((f_holdsDuring(Var_TIME,direction(Var_PROC,Var_ATTR1))) => (( ! [Var_ATTR2] : 
 ((hasType(type_DirectionalAttribute, Var_ATTR2) & hasType(type_Entity, Var_ATTR2)) => 
(((f_holdsDuring(Var_TIME,direction(Var_PROC,Var_ATTR2))) => (Var_ATTR2 = Var_ATTR1))))))))))))))))).

fof(axMergeLem503, axiom, 
 ( ! [Var_ATTR1] : 
 ((hasType(type_DirectionalAttribute, Var_ATTR1) & hasType(type_Entity, Var_ATTR1)) => 
(( ! [Var_PROC] : 
 (hasType(type_Object, Var_PROC) => 
(( ! [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) => 
(((f_holdsDuring(Var_TIME,faces(Var_PROC,Var_ATTR1))) => (( ! [Var_ATTR2] : 
 ((hasType(type_DirectionalAttribute, Var_ATTR2) & hasType(type_Entity, Var_ATTR2)) => 
(((f_holdsDuring(Var_TIME,faces(Var_PROC,Var_ATTR2))) => (Var_ATTR2 = Var_ATTR1))))))))))))))))).

fof(axMergeLem504, axiom, 
 ( ! [Var_ATTR1] : 
 (hasType(type_DirectionalAttribute, Var_ATTR1) => 
(( ! [Var_ATTR2] : 
 (hasType(type_DirectionalAttribute, Var_ATTR2) => 
(( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((((f_orientation(Var_OBJ1,Var_OBJ2,Var_ATTR1)) & (Var_ATTR1 != Var_ATTR2))) => (( ~ (f_orientation(Var_OBJ1,Var_OBJ2,Var_ATTR2)))))))))))))))))).

fof(axMergeLem505, axiom, 
 ( ! [Var_DIRECT] : 
 (hasType(type_DirectionalAttribute, Var_DIRECT) => 
(( ! [Var_OBJ3] : 
 (hasType(type_Object, Var_OBJ3) => 
(( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((((f_orientation(Var_OBJ1,Var_OBJ2,Var_DIRECT)) & (f_orientation(Var_OBJ2,Var_OBJ3,Var_DIRECT)))) => (f_between(Var_OBJ1,Var_OBJ2,Var_OBJ3)))))))))))))))).

fof(axMergeLem506, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_North)) <=> (f_orientation(Var_OBJ2,Var_OBJ1,inst_South)))))))))).

fof(axMergeLem507, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_East)) <=> (f_orientation(Var_OBJ2,Var_OBJ1,inst_West)))))))))).

fof(axMergeLem508, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_Vertical)) <=> (f_orientation(Var_OBJ2,Var_OBJ1,inst_Vertical)))))))))).

fof(axMergeLem509, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_Horizontal)) <=> (f_orientation(Var_OBJ2,Var_OBJ1,inst_Horizontal)))))))))).

fof(axMergeLem510, axiom, 
 ( ! [Var_P] : 
 (hasType(type_SymmetricPositionalAttribute, Var_P) => 
(( ! [Var_O2] : 
 (hasType(type_Object, Var_O2) => 
(( ! [Var_O1] : 
 (hasType(type_Object, Var_O1) => 
(((f_orientation(Var_O1,Var_O2,Var_P)) => (f_orientation(Var_O2,Var_O1,Var_P))))))))))))).

fof(axMergeLem511, axiom, 
 ( ! [Var_P] : 
 (hasType(type_AntiSymmetricPositionalAttribute, Var_P) => 
(( ! [Var_O2] : 
 (hasType(type_Object, Var_O2) => 
(( ! [Var_O1] : 
 (hasType(type_Object, Var_O1) => 
(((f_orientation(Var_O1,Var_O2,Var_P)) => (( ~ (f_orientation(Var_O2,Var_O1,Var_P))))))))))))))).

fof(axMergeLem512, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_Above)) => (( ~ (f_connected(Var_OBJ1,Var_OBJ2)))))))))))).

fof(axMergeLem513, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_Below)) <=> (((f_orientation(Var_OBJ2,Var_OBJ1,inst_On)) | (f_orientation(Var_OBJ2,Var_OBJ1,inst_Above)))))))))))).

fof(axMergeLem514, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_Adjacent)) <=> (((f_orientation(Var_OBJ1,Var_OBJ2,inst_Near)) | (f_connected(Var_OBJ1,Var_OBJ2)))))))))))).

fof(axMergeLem515, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_Right)) <=> (f_orientation(Var_OBJ2,Var_OBJ1,inst_Left)))))))))).

fof(axMergeLem516, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_Near)) => (( ~ (f_connected(Var_OBJ1,Var_OBJ2)))))))))))).

fof(axMergeLem517, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_Near)) => (f_orientation(Var_OBJ2,Var_OBJ1,inst_Near)))))))))).

fof(axMergeLem518, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_On)) => (f_connected(Var_OBJ1,Var_OBJ2)))))))))).

fof(axMergeLem519, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 ((hasType(type_Object, Var_OBJ1) & hasType(type_Physical, Var_OBJ1)) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_On)) => (f_located(Var_OBJ1,Var_OBJ2)))))))))).

fof(axMergeLem520, axiom, 
 ( ! [Var_OBJ2] : 
 (hasType(type_Object, Var_OBJ2) => 
(( ! [Var_OBJ1] : 
 (hasType(type_Object, Var_OBJ1) => 
(((f_orientation(Var_OBJ1,Var_OBJ2,inst_On)) => (( ~ (f_orientation(Var_OBJ2,Var_OBJ1,inst_On)))))))))))).

fof(axMergeLem521, axiom, 
 ( ! [Var_TIME2] : 
 (hasType(type_Entity, Var_TIME2) => 
(( ! [Var_TIME1] : 
 ((hasType(type_TimePosition, Var_TIME1) & hasType(type_Quantity, Var_TIME1)) => 
(((f_RelativeTimeFn(Var_TIME1,inst_PacificTimeZone) = Var_TIME2) => (Var_TIME2 = f_AdditionFn(Var_TIME1,8)))))))))).

fof(axMergeLem522, axiom, 
 ( ! [Var_TIME2] : 
 (hasType(type_Entity, Var_TIME2) => 
(( ! [Var_TIME1] : 
 ((hasType(type_TimePosition, Var_TIME1) & hasType(type_Quantity, Var_TIME1)) => 
(((f_RelativeTimeFn(Var_TIME1,inst_MountainTimeZone) = Var_TIME2) => (Var_TIME2 = f_AdditionFn(Var_TIME1,7)))))))))).

fof(axMergeLem523, axiom, 
 ( ! [Var_TIME2] : 
 (hasType(type_Entity, Var_TIME2) => 
(( ! [Var_TIME1] : 
 ((hasType(type_TimePosition, Var_TIME1) & hasType(type_Quantity, Var_TIME1)) => 
(((f_RelativeTimeFn(Var_TIME1,inst_CentralTimeZone) = Var_TIME2) => (Var_TIME2 = f_AdditionFn(Var_TIME1,6)))))))))).

fof(axMergeLem524, axiom, 
 ( ! [Var_TIME2] : 
 (hasType(type_Entity, Var_TIME2) => 
(( ! [Var_TIME1] : 
 ((hasType(type_TimePosition, Var_TIME1) & hasType(type_Quantity, Var_TIME1)) => 
(((f_RelativeTimeFn(Var_TIME1,inst_EasternTimeZone) = Var_TIME2) => (Var_TIME2 = f_AdditionFn(Var_TIME1,5)))))))))).

fof(axMergeLem525, axiom, 
 ( ! [Var_PERSON] : 
 (hasType(type_Human, Var_PERSON) => 
(((( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(( ~ (f_employs(Var_ORG,Var_PERSON))))))) <=> (f_attribute(Var_PERSON,inst_Unemployed))))))).

fof(axMergeLem526, axiom, 
 ( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(( ! [Var_POSITION] : 
 ((hasType(type_Position, Var_POSITION) & hasType(type_Attribute, Var_POSITION)) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Human, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((f_occupiesPosition(Var_AGENT,Var_POSITION,Var_ORG)) => (f_attribute(Var_AGENT,Var_POSITION))))))))))))).

fof(axMergeLem527, axiom, 
 ( ! [Var_PERSON] : 
 ((hasType(type_CognitiveAgent, Var_PERSON) & hasType(type_Human, Var_PERSON)) => 
(( ! [Var_ORG] : 
 (hasType(type_Organization, Var_ORG) => 
(((f_employs(Var_ORG,Var_PERSON)) => (( ? [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) &  
(f_occupiesPosition(Var_PERSON,Var_POSITION,Var_ORG))))))))))))).

fof(axMergeLem528, axiom, 
 ( ! [Var_ORGANIZATION] : 
 ((hasType(type_Organization, Var_ORGANIZATION) & hasType(type_Collection, Var_ORGANIZATION)) => 
(( ! [Var_POSITION] : 
 (hasType(type_Position, Var_POSITION) => 
(( ! [Var_PERSON] : 
 ((hasType(type_Human, Var_PERSON) & hasType(type_SelfConnectedObject, Var_PERSON)) => 
(((f_occupiesPosition(Var_PERSON,Var_POSITION,Var_ORGANIZATION)) => (f_member(Var_PERSON,Var_ORGANIZATION))))))))))))).

fof(axMergeLem529, axiom, 
 ( ! [Var_ATTR] : 
 (hasType(type_ContestAttribute, Var_ATTR) => 
(( ! [Var_THING] : 
 ((hasType(type_Entity, Var_THING) & hasType(type_Agent, Var_THING) & hasType(type_Process, Var_THING)) => 
(((f_property(Var_THING,Var_ATTR)) => (( ? [Var_CONTEST] : 
 (hasType(type_Contest, Var_CONTEST) &  
(((f_agent(Var_CONTEST,Var_THING)) | (((f_patient(Var_CONTEST,Var_THING)) | (f_subProcess(Var_THING,Var_CONTEST))))))))))))))))).

fof(axMergeLem530, axiom, 
 ( ! [Var_OBJ] : 
 (hasType(type_Solution, Var_OBJ) => 
(f_attribute(Var_OBJ,inst_Liquid))))).

fof(axMergeLem531, axiom, 
 ( ! [Var_OBJ] : 
 (hasType(type_Substance, Var_OBJ) => 
(( ? [Var_ATTR] : 
 (hasType(type_PhysicalState, Var_ATTR) &  
(f_attribute(Var_OBJ,Var_ATTR)))))))).

fof(axMergeLem532, axiom, 
 ( ! [Var_PERCEPTION] : 
 (hasType(type_Perception, Var_PERCEPTION) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(((f_patient(Var_PERCEPTION,Var_OBJ)) => (( ? [Var_PROP] : 
 (hasType(type_PerceptualAttribute, Var_PROP) &  
(f_attribute(Var_OBJ,Var_PROP))))))))))))).

fof(axMergeLem533, axiom, 
 ( ! [Var_OBJ] : 
 (hasType(type_Food, Var_OBJ) => 
(( ? [Var_ATTR] : 
 (hasType(type_TasteAttribute, Var_ATTR) &  
(f_attribute(Var_OBJ,Var_ATTR)))))))).

fof(axMergeLem534, axiom, 
 ( ! [Var_COLOR] : 
 (hasType(type_PrimaryColor, Var_COLOR) => 
(( ! [Var_PART] : 
 (hasType(type_Object, Var_PART) => 
(( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(((((f_attribute(Var_OBJ,inst_Monochromatic)) & (((f_superficialPart(Var_PART,Var_OBJ)) & (f_attribute(Var_PART,Var_COLOR)))))) => (( ! [Var_ELEMENT] : 
 (hasType(type_Object, Var_ELEMENT) => 
(((f_superficialPart(Var_ELEMENT,Var_OBJ)) => (f_attribute(Var_ELEMENT,Var_COLOR)))))))))))))))))).

fof(axMergeLem535, axiom, 
 ( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(((f_attribute(Var_OBJ,inst_Monochromatic)) | (f_attribute(Var_OBJ,inst_Polychromatic))))))).

fof(axMergeLem536, axiom, 
 ( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(((f_attribute(Var_OBJ,inst_Polychromatic)) => (( ? [Var_COLOR1] : 
 (hasType(type_ColorAttribute, Var_COLOR1) &  
(( ? [Var_COLOR2] : 
 (hasType(type_ColorAttribute, Var_COLOR2) &  
(( ? [Var_PART2] : 
 (hasType(type_Object, Var_PART2) &  
(( ? [Var_PART1] : 
 (hasType(type_Object, Var_PART1) &  
(((f_superficialPart(Var_PART1,Var_OBJ)) & (((f_superficialPart(Var_PART2,Var_OBJ)) & (((f_attribute(Var_PART1,Var_COLOR1)) & (((f_attribute(Var_PART2,Var_COLOR2)) & (Var_COLOR1 != Var_COLOR2)))))))))))))))))))))))))).

fof(axMergeLem537, axiom, 
 ( ! [Var_ATTRIBUTE] : 
 (hasType(type_ShapeAttribute, Var_ATTRIBUTE) => 
(( ! [Var_SURFACE] : 
 ((hasType(type_SelfConnectedObject, Var_SURFACE) & hasType(type_Object, Var_SURFACE)) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Object, Var_OBJ) & hasType(type_SelfConnectedObject, Var_OBJ)) => 
(((((f_attribute(Var_OBJ,Var_ATTRIBUTE)) & (f_surface(Var_SURFACE,Var_OBJ)))) => (f_attribute(Var_SURFACE,Var_ATTRIBUTE))))))))))))).

fof(axMergeLem538, axiom, 
 ( ! [Var_OBJ] : 
 ((hasType(type_Entity, Var_OBJ) & hasType(type_Object, Var_OBJ)) => 
(((( ? [Var_CHANGE] : 
 (hasType(type_ShapeChange, Var_CHANGE) &  
(f_patient(Var_CHANGE,Var_OBJ))))) => (f_attribute(Var_OBJ,inst_Pliable))))))).

fof(axMergeLem539, axiom, 
 ( ! [Var_ATTRIBUTE] : 
 (hasType(type_TextureAttribute, Var_ATTRIBUTE) => 
(( ! [Var_SURFACE] : 
 ((hasType(type_SelfConnectedObject, Var_SURFACE) & hasType(type_Object, Var_SURFACE)) => 
(( ! [Var_OBJ] : 
 ((hasType(type_Object, Var_OBJ) & hasType(type_SelfConnectedObject, Var_OBJ)) => 
(((((f_attribute(Var_OBJ,Var_ATTRIBUTE)) & (f_surface(Var_SURFACE,Var_OBJ)))) => (f_attribute(Var_SURFACE,Var_ATTRIBUTE))))))))))))).

fof(axMergeLem540, axiom, 
 ( ! [Var_POINT] : 
 ((hasType(type_GeometricPoint, Var_POINT) & hasType(type_GeometricFigure, Var_POINT)) => 
(( ! [Var_FIGURE2] : 
 ((hasType(type_OneDimensionalFigure, Var_FIGURE2) & hasType(type_GeometricFigure, Var_FIGURE2)) => 
(( ! [Var_FIGURE1] : 
 ((hasType(type_OneDimensionalFigure, Var_FIGURE1) & hasType(type_GeometricFigure, Var_FIGURE1)) => 
(((f_pointOfIntersection(Var_FIGURE1,Var_FIGURE2,Var_POINT)) => (((f_pointOfFigure(Var_POINT,Var_FIGURE1)) & (f_pointOfFigure(Var_POINT,Var_FIGURE2))))))))))))))).

fof(axMergeLem541, axiom, 
 ( ! [Var_LINE2] : 
 (hasType(type_OneDimensionalFigure, Var_LINE2) => 
(( ! [Var_LINE1] : 
 (hasType(type_OneDimensionalFigure, Var_LINE1) => 
(((f_parallel(Var_LINE1,Var_LINE2)) => (( ~ ( ? [Var_POINT] : 
 (hasType(type_GeometricPoint, Var_POINT) &  
(f_pointOfIntersection(Var_LINE1,Var_LINE2,Var_POINT)))))))))))))).

fof(axMergeLem542, axiom, 
 ( ! [Var_LENGTH] : 
 (hasType(type_LengthMeasure, Var_LENGTH) => 
(( ! [Var_POINT2] : 
 (hasType(type_GeometricPoint, Var_POINT2) => 
(( ! [Var_POINT1] : 
 (hasType(type_GeometricPoint, Var_POINT1) => 
(((f_geometricDistance(Var_POINT1,Var_POINT2,Var_LENGTH)) => (f_geometricDistance(Var_POINT2,Var_POINT1,Var_LENGTH))))))))))))).

fof(axMergeLem543, axiom, 
 ( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(((f_attribute(Var_OBJ,inst_Dry)) => (( ~ ( ? [Var_SUBOBJ] : 
 (hasType(type_Object, Var_SUBOBJ) &  
(((f_part(Var_SUBOBJ,Var_OBJ)) & (f_attribute(Var_SUBOBJ,inst_Liquid))))))))))))).

fof(axMergeLem544, axiom, 
 ( ! [Var_OBJ] : 
 (hasType(type_Object, Var_OBJ) => 
(((f_attribute(Var_OBJ,inst_Wet)) => (( ! [Var_PART] : 
 (hasType(type_Object, Var_PART) => 
(((f_part(Var_PART,Var_OBJ)) => (( ? [Var_SUBPART] : 
 (hasType(type_Object, Var_SUBPART) &  
(((f_part(Var_SUBPART,Var_PART)) & (f_attribute(Var_SUBPART,inst_Liquid))))))))))))))))).

fof(axMergeLem545, axiom, 
 ( ! [Var_ANIMAL] : 
 (hasType(type_Animal, Var_ANIMAL) => 
(((( ? [Var_MOTION] : 
 (hasType(type_BodyMotion, Var_MOTION) &  
(f_agent(Var_MOTION,Var_ANIMAL))))) | (( ? [Var_ATTR] : 
 (hasType(type_BodyPosition, Var_ATTR) &  
(f_attribute(Var_ANIMAL,Var_ATTR)))))))))).

fof(axMergeLem546, axiom, 
 ( ! [Var_AMBULATE] : 
 (hasType(type_Ambulating, Var_AMBULATE) => 
(( ! [Var_AGENT] : 
 ((hasType(type_Agent, Var_AGENT) & hasType(type_Object, Var_AGENT)) => 
(((f_agent(Var_AMBULATE,Var_AGENT)) => (f_attribute(Var_AGENT,inst_Standing)))))))))).

fof(axMergeLem547, axiom, 
 ( ! [Var_ORGANISM] : 
 (hasType(type_Organism, Var_ORGANISM) => 
(( ! [Var_PROCESS] : 
 ((hasType(type_Process, Var_PROCESS) & hasType(type_Physical, Var_PROCESS)) => 
(((f_agent(Var_PROCESS,Var_ORGANISM)) => (f_holdsDuring(f_WhenFn(Var_PROCESS),attribute(Var_ORGANISM,inst_Living))))))))))).

fof(axMergeLem548, axiom, 
 ( ! [Var_ORG] : 
 (hasType(type_Organism, Var_ORG) => 
(( ? [Var_ATTR] : 
 (hasType(type_AnimacyAttribute, Var_ATTR) &  
(f_attribute(Var_ORG,Var_ATTR)))))))).

fof(axMergeLem549, axiom, 
 ( ! [Var_BODY] : 
 (hasType(type_ReproductiveBody, Var_BODY) => 
(( ! [Var_ORG] : 
 (hasType(type_Organism, Var_ORG) => 
(((f_part(Var_BODY,Var_ORG)) => (f_attribute(Var_ORG,inst_Female)))))))))).

fof(axMergeLem550, axiom, 
 ( ! [Var_ANIMAL] : 
 (hasType(type_Animal, Var_ANIMAL) => 
(( ? [Var_ATTR] : 
 (hasType(type_SexAttribute, Var_ATTR) &  
(f_attribute(Var_ANIMAL,Var_ATTR)))))))).

fof(axMergeLem551, axiom, 
 ( ! [Var_OBJ] : 
 ((hasType(type_Object, Var_OBJ) & hasType(type_Entity, Var_OBJ) & hasType(type_Physical, Var_OBJ)) => 
(((f_attribute(Var_OBJ,inst_FullyFormed)) => (( ? [Var_GROWTH] : 
 (hasType(type_Growth, Var_GROWTH) &  
(((f_experiencer(Var_GROWTH,Var_OBJ)) & (f_holdsDuring(f_BeginFn(f_WhenFn(Var_OBJ)),attribute(Var_OBJ,inst_NonFullyFormed))))))))))))).

fof(axMergeLem552, axiom, 
 ( ! [Var_ORG] : 
 (hasType(type_Organism, Var_ORG) => 
(( ? [Var_ATTR] : 
 (hasType(type_DevelopmentalAttribute, Var_ATTR) &  
(f_attribute(Var_ORG,Var_ATTR)))))))).

fof(axMergeLem553, axiom, 
 ( ! [Var_ORG] : 
 ((hasType(type_Object, Var_ORG) & hasType(type_Physical, Var_ORG)) => 
(((f_attribute(Var_ORG,inst_Embryonic)) => (( ? [Var_BODY] : 
 (hasType(type_ReproductiveBody, Var_BODY) &  
(f_located(Var_ORG,Var_BODY)))))))))).

fof(axMergeLem554, axiom, 
 ( ! [Var_ATTR] : 
 (hasType(type_PsychologicalAttribute, Var_ATTR) => 
(( ! [Var_ORGANISM] : 
 (hasType(type_Object, Var_ORGANISM) => 
(( ! [Var_TIME] : 
 (hasType(type_TimePosition, Var_TIME) => 
(((f_holdsDuring(Var_TIME,attribute(Var_ORGANISM,Var_ATTR))) => (f_holdsDuring(Var_TIME,attribute(Var_ORGANISM,inst_Living)))))))))))))).

fof(axMergeLem555, axiom, 
 ( ! [Var_AGENT] : 
 (hasType(type_SentientAgent, Var_AGENT) => 
(((f_attribute(Var_AGENT,inst_Living)) <=> (( ? [Var_ATTR] : 
 (hasType(type_ConsciousnessAttribute, Var_ATTR) &  
(f_attribute(Var_AGENT,Var_ATTR)))))))))).

fof(axMergeLem556, axiom, 
 ( ! [Var_AGENT] : 
 (hasType(type_Object, Var_AGENT) => 
(((((f_attribute(Var_AGENT,inst_Asleep)) | (f_attribute(Var_AGENT,inst_Awake)))) => (f_attribute(Var_AGENT,inst_Living))))))).

