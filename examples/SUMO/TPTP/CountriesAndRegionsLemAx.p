fof(axCountriesLem0, axiom, 
 ( ! [Var_STATE] : 
 (hasType(type_AmericanState, Var_STATE) => 
(f_part(Var_STATE,inst_UnitedStates))))).

fof(axCountriesLem1, axiom, 
 ( ! [Var_CITY] : 
 (hasType(type_AmericanCity, Var_CITY) => 
(f_part(Var_CITY,inst_UnitedStates))))).

fof(axCountriesLem2, axiom, 
 ( ! [Var_CITY] : 
 (hasType(type_EuropeanCity, Var_CITY) => 
(f_part(Var_CITY,inst_Europe))))).

fof(axCountriesLem3, axiom, 
 ( ! [Var_CITY] : 
 (hasType(type_City, Var_CITY) => 
(((f_part(Var_CITY,inst_France)) => (f_lessThanOrEqualTo(f_CardinalityFn(f_ResidentFn(Var_CITY)),f_CardinalityFn(f_ResidentFn(inst_Paris))))))))).

fof(axCountriesLem4, axiom, 
 ( ! [Var_CITY] : 
 (hasType(type_AmericanCity, Var_CITY) => 
(((((f_part(Var_CITY,inst_California)) & (Var_CITY != inst_LosAngelesCalifornia))) => (f_greaterThan(f_CardinalityFn(f_ResidentFn(inst_LosAngelesCalifornia)),f_CardinalityFn(f_ResidentFn(Var_CITY))))))))).

fof(axCountriesLem5, axiom, 
 ( ! [Var_STATE] : 
 (hasType(type_AmericanState, Var_STATE) => 
(((Var_STATE != inst_California) => (f_greaterThan(f_CardinalityFn(f_ResidentFn(inst_California)),f_CardinalityFn(f_ResidentFn(Var_STATE))))))))).

fof(axCountriesLem6, axiom, 
 ( ! [Var_CITY] : 
 (hasType(type_AmericanCity, Var_CITY) => 
(f_lessThanOrEqualTo(f_CardinalityFn(f_ResidentFn(Var_CITY)),f_CardinalityFn(f_ResidentFn(inst_NewYorkCityUnitedStates))))))).

fof(axCountriesLem7, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_AreaMeasure, Var_UNIT) => 
(( ! [Var_NUMBER1] : 
 (hasType(type_Entity, Var_NUMBER1) => 
(( ! [Var_STATE] : 
 (hasType(type_AmericanState, Var_STATE) => 
(( ! [Var_NUMBER2] : 
 (hasType(type_Entity, Var_NUMBER2) => 
(((((f_measure(inst_Alaska,f_MeasureFn(Var_NUMBER1,Var_UNIT))) & (((f_measure(Var_STATE,f_MeasureFn(Var_NUMBER2,Var_UNIT))) & (inst_Alaska != Var_STATE))))) => (f_lessThan(Var_NUMBER2,Var_NUMBER1)))))))))))))))).

