fof(axMidP0, axiom, 
 f_subsumesContentClass(type_ChristianBible,type_NewTestament)).

fof(axMidP1, axiom, 
 f_subsumesContentClass(type_ChristianBible,type_OldTestament)).

fof(axMidP2, axiom, 
 f_subsumesContentClass(type_NewTestament,type_ChristianGospel)).

fof(axMidP3, axiom, 
 f_BeginFn(inst_BeforeCommonEra) = inst_NegativeInfinity).

fof(axMidP4, axiom, 
 f_EndFn(inst_CommonEra) = inst_PositiveInfinity).

fof(axMidP5, axiom, 
 f_subOrganization(inst_UnitedStatesDepartmentOfState,f_GovernmentFn(inst_UnitedStates))).

fof(axMidP6, axiom, 
 f_subOrganization(inst_UnitedStatesDepartmentOfInterior,f_GovernmentFn(inst_UnitedStates))).

fof(axMidP7, axiom, 
 f_subOrganization(inst_UnitedStatesCongress,f_GovernmentFn(inst_UnitedStates))).

fof(axMidP8, axiom, 
 f_initialPart(type_DigitAppendage,type_Limb)).

fof(axMidP9, axiom, 
 f_MeasureFn(1,inst_MetricTon) = f_MeasureFn(2205,inst_PoundMass)).

fof(axMidP10, axiom, 
 f_MeasureFn(1,inst_SquareMile) = f_PerFn(f_MeasureFn(1,inst_Mile),f_MeasureFn(1,inst_Mile))).

fof(axMidP11, axiom, 
 f_MeasureFn(1,inst_SquareYard) = f_PerFn(f_MeasureFn(1,inst_YardLength),f_MeasureFn(1,inst_YardLength))).

fof(axMidP12, axiom, 
 f_meatOfAnimal(type_Beef,type_Cow)).

fof(axMidP13, axiom, 
 f_meatOfAnimal(type_ChickenMeat,type_Chicken)).

fof(axMidP14, axiom, 
 f_meatOfAnimal(type_Pork,type_Pig)).

fof(axMidP15, axiom, 
 f_meatOfAnimal(type_FishMeat,type_Fish)).

fof(axMidP16, axiom, 
 f_subField(inst_Physiology,inst_Biology)).

fof(axMidP17, axiom, 
 f_subField(inst_MedicalScience,inst_Biology)).

fof(axMidP18, axiom, 
 f_subField(inst_Electronics,inst_Physics)).

fof(axMidP19, axiom, 
 f_subField(inst_Electronics,inst_Engineering)).

fof(axMidP20, axiom, 
 f_initialPart(type_AnimalAnatomicalStructure,type_Animal)).

