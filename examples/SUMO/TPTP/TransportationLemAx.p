fof(axTransportationLem0, axiom, 
 ( ! [Var_LENGTH] : 
 ((hasType(type_LengthMeasure, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((((f_totalLengthOfRailwaySystem(Var_AREA,Var_LENGTH)) & (f_greaterThan(Var_LENGTH,0)))) => (( ? [Var_RAILWAY] : 
 (hasType(type_Railway, Var_RAILWAY) &  
(f_located(Var_RAILWAY,Var_AREA))))))))))))).

fof(axTransportationLem1, axiom, 
 ( ! [Var_LENGTH] : 
 ((hasType(type_LengthMeasure, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((((f_lengthOfElectrifiedRailway(Var_AREA,Var_LENGTH)) & (f_greaterThan(Var_LENGTH,0)))) => (( ? [Var_RAILWAY] : 
 (hasType(type_ElectrifiedRailway, Var_RAILWAY) &  
(f_located(Var_RAILWAY,Var_AREA))))))))))))).

fof(axTransportationLem2, axiom, 
 ( ! [Var_LENGTH] : 
 ((hasType(type_LengthMeasure, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((((f_lengthOfMultipleTrackRailway(Var_AREA,Var_LENGTH)) & (f_greaterThan(Var_LENGTH,0)))) => (( ? [Var_RAILWAY] : 
 (hasType(type_MultipleTrackRailway, Var_RAILWAY) &  
(f_located(Var_RAILWAY,Var_AREA))))))))))))).

fof(axTransportationLem3, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfLength, Var_UNIT) => 
(( ! [Var_LENGTH] : 
 ((hasType(type_RealNumber, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((((f_lengthOfBroadGaugeRailway(Var_AREA,f_MeasureFn(Var_LENGTH,Var_UNIT))) & (f_greaterThan(Var_LENGTH,0)))) => (( ? [Var_RAILWAY] : 
 (hasType(type_BroadGaugeRailway, Var_RAILWAY) &  
(f_located(Var_RAILWAY,Var_AREA)))))))))))))))).

fof(axTransportationLem4, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfLength, Var_UNIT) => 
(( ! [Var_LENGTH] : 
 ((hasType(type_RealNumber, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((((f_lengthOfDualGaugeRailway(Var_AREA,f_MeasureFn(Var_LENGTH,Var_UNIT))) & (f_greaterThan(Var_LENGTH,0)))) => (( ? [Var_RAILWAY] : 
 (hasType(type_DualGaugeRailway, Var_RAILWAY) &  
(f_located(Var_RAILWAY,Var_AREA)))))))))))))))).

fof(axTransportationLem5, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfLength, Var_UNIT) => 
(( ! [Var_LENGTH] : 
 ((hasType(type_RealNumber, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((((f_lengthOfNarrowGaugeRailway(Var_AREA,f_MeasureFn(Var_LENGTH,Var_UNIT))) & (f_greaterThan(Var_LENGTH,0)))) => (( ? [Var_RAILWAY] : 
 (hasType(type_NarrowGaugeRailway, Var_RAILWAY) &  
(f_located(Var_RAILWAY,Var_AREA)))))))))))))))).

fof(axTransportationLem6, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfLength, Var_UNIT) => 
(( ! [Var_LENGTH] : 
 ((hasType(type_RealNumber, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((((f_lengthOfStandardGaugeRailway(Var_AREA,f_MeasureFn(Var_LENGTH,Var_UNIT))) & (f_greaterThan(Var_LENGTH,0)))) => (( ? [Var_RAILWAY] : 
 (hasType(type_StandardGaugeRailway, Var_RAILWAY) &  
(f_located(Var_RAILWAY,Var_AREA)))))))))))))))).

fof(axTransportationLem7, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfLength, Var_UNIT) => 
(( ! [Var_LENGTH] : 
 ((hasType(type_RealNumber, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((((f_lengthOfUnclassifiedGaugeRailway(Var_AREA,f_MeasureFn(Var_LENGTH,Var_UNIT))) & (f_greaterThan(Var_LENGTH,0)))) => (( ? [Var_RAILWAY] : 
 (hasType(type_Railway, Var_RAILWAY) &  
(f_located(Var_RAILWAY,Var_AREA)))))))))))))))).

fof(axTransportationLem8, axiom, 
 ( ! [Var_RAIL] : 
 (hasType(type_MultipleTrackRailway, Var_RAIL) => 
(( ? [Var_TRACK1] : 
 (hasType(type_RailroadTrack, Var_TRACK1) &  
(( ? [Var_TRACK2] : 
 (hasType(type_RailroadTrack, Var_TRACK2) &  
(((Var_TRACK1 != Var_TRACK2) & (((f_part(Var_TRACK1,Var_RAIL)) & (f_part(Var_TRACK2,Var_RAIL))))))))))))))).

fof(axTransportationLem9, axiom, 
 ( ! [Var_RR] : 
 (hasType(type_Railway, Var_RR) => 
(( ! [Var_WIDTH] : 
 ((hasType(type_LengthMeasure, Var_WIDTH) & hasType(type_Quantity, Var_WIDTH)) => 
(((((f_property(Var_RR,inst_BroadGauge)) & (f_trackWidth(Var_RR,Var_WIDTH)))) => (f_greaterThan(Var_WIDTH,f_MeasureFn(1.44,inst_Meter))))))))))).

fof(axTransportationLem10, axiom, 
 ( ! [Var_RR] : 
 (hasType(type_Railway, Var_RR) => 
(( ! [Var_WIDTH] : 
 ((hasType(type_LengthMeasure, Var_WIDTH) & hasType(type_Quantity, Var_WIDTH)) => 
(((((f_property(Var_RR,inst_StandardGauge)) & (f_trackWidth(Var_RR,Var_WIDTH)))) => (f_greaterThanOrEqualTo(Var_WIDTH,f_MeasureFn(1.435,inst_Meter))))))))))).

fof(axTransportationLem11, axiom, 
 ( ! [Var_RR] : 
 (hasType(type_Railway, Var_RR) => 
(( ! [Var_WIDTH] : 
 ((hasType(type_LengthMeasure, Var_WIDTH) & hasType(type_Quantity, Var_WIDTH)) => 
(((((f_property(Var_RR,inst_StandardGauge)) & (f_trackWidth(Var_RR,Var_WIDTH)))) => (f_lessThanOrEqualTo(Var_WIDTH,f_MeasureFn(1.44,inst_Meter))))))))))).

fof(axTransportationLem12, axiom, 
 ( ! [Var_RR] : 
 (hasType(type_Railway, Var_RR) => 
(( ! [Var_WIDTH] : 
 ((hasType(type_LengthMeasure, Var_WIDTH) & hasType(type_Quantity, Var_WIDTH)) => 
(((((f_property(Var_RR,inst_NarrowGauge)) & (f_trackWidth(Var_RR,Var_WIDTH)))) => (f_lessThanOrEqualTo(Var_WIDTH,f_MeasureFn(1.435,inst_Meter))))))))))).

fof(axTransportationLem13, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfLength, Var_UNIT) => 
(( ! [Var_LENGTH] : 
 ((hasType(type_RealNumber, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((((f_totalLengthOfHighwaySystem(Var_AREA,f_MeasureFn(Var_LENGTH,Var_UNIT))) & (f_greaterThan(Var_LENGTH,0)))) => (( ? [Var_HIGHWAY] : 
 (hasType(type_Roadway, Var_HIGHWAY) &  
(f_located(Var_HIGHWAY,Var_AREA)))))))))))))))).

fof(axTransportationLem14, axiom, 
 ( ! [Var_LENGTH2] : 
 ((hasType(type_LengthMeasure, Var_LENGTH2) & hasType(type_Quantity, Var_LENGTH2)) => 
(( ! [Var_LENGTH1] : 
 ((hasType(type_LengthMeasure, Var_LENGTH1) & hasType(type_Quantity, Var_LENGTH1)) => 
(( ! [Var_LENGTH] : 
 ((hasType(type_LengthMeasure, Var_LENGTH) & hasType(type_Entity, Var_LENGTH)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(((((f_totalLengthOfHighwaySystem(Var_AREA,Var_LENGTH)) & (((f_lengthOfPavedHighway(Var_AREA,Var_LENGTH1)) & (f_lengthOfUnpavedHighway(Var_AREA,Var_LENGTH2)))))) => (Var_LENGTH = f_AdditionFn(Var_LENGTH1,Var_LENGTH2)))))))))))))))).

fof(axTransportationLem15, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfLength, Var_UNIT) => 
(( ! [Var_LENGTH2] : 
 ((hasType(type_RealNumber, Var_LENGTH2) & hasType(type_Quantity, Var_LENGTH2)) => 
(( ! [Var_LENGTH1] : 
 ((hasType(type_RealNumber, Var_LENGTH1) & hasType(type_Quantity, Var_LENGTH1)) => 
(( ! [Var_LENGTH] : 
 (hasType(type_RealNumber, Var_LENGTH) => 
(( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(((((f_totalLengthOfHighwaySystem(Var_AREA,f_MeasureFn(Var_LENGTH,Var_UNIT))) & (((f_lengthOfPavedHighway(Var_AREA,f_MeasureFn(Var_LENGTH1,Var_UNIT))) & (f_lengthOfUnpavedHighway(Var_AREA,f_MeasureFn(Var_LENGTH2,Var_UNIT))))))) => (f_totalLengthOfHighwaySystem(Var_AREA,f_MeasureFn(f_AdditionFn(Var_LENGTH1,Var_LENGTH2),Var_UNIT)))))))))))))))))))).

fof(axTransportationLem16, axiom, 
 ( ! [Var_PAVED] : 
 ((hasType(type_LengthMeasure, Var_PAVED) & hasType(type_Quantity, Var_PAVED)) => 
(( ! [Var_TOTAL] : 
 ((hasType(type_LengthMeasure, Var_TOTAL) & hasType(type_Quantity, Var_TOTAL)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(((((f_totalLengthOfHighwaySystem(Var_AREA,Var_TOTAL)) & (f_lengthOfPavedHighway(Var_AREA,Var_PAVED)))) => (f_greaterThanOrEqualTo(Var_TOTAL,Var_PAVED))))))))))))).

fof(axTransportationLem17, axiom, 
 ( ! [Var_UNPAVED] : 
 ((hasType(type_LengthMeasure, Var_UNPAVED) & hasType(type_Quantity, Var_UNPAVED)) => 
(( ! [Var_TOTAL] : 
 ((hasType(type_LengthMeasure, Var_TOTAL) & hasType(type_Quantity, Var_TOTAL)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(((((f_totalLengthOfHighwaySystem(Var_AREA,Var_TOTAL)) & (f_lengthOfUnpavedHighway(Var_AREA,Var_UNPAVED)))) => (f_greaterThanOrEqualTo(Var_TOTAL,Var_UNPAVED))))))))))))).

fof(axTransportationLem18, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfLength, Var_UNIT) => 
(( ! [Var_LENGTH] : 
 ((hasType(type_RealNumber, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((((f_lengthOfPavedHighway(Var_AREA,f_MeasureFn(Var_LENGTH,Var_UNIT))) & (f_greaterThan(Var_LENGTH,0)))) => (( ? [Var_HIGHWAY] : 
 (hasType(type_SurfacedRoadway, Var_HIGHWAY) &  
(f_located(Var_HIGHWAY,Var_AREA)))))))))))))))).

fof(axTransportationLem19, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfLength, Var_UNIT) => 
(( ! [Var_LENGTH] : 
 ((hasType(type_RealNumber, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((((f_lengthOfExpresswaySystem(Var_AREA,f_MeasureFn(Var_LENGTH,Var_UNIT))) & (f_greaterThan(Var_LENGTH,0)))) => (( ? [Var_HIGHWAY] : 
 (hasType(type_Expressway, Var_HIGHWAY) &  
(f_located(Var_HIGHWAY,Var_AREA)))))))))))))))).

fof(axTransportationLem20, axiom, 
 ( ! [Var_LENGTH2] : 
 ((hasType(type_LengthMeasure, Var_LENGTH2) & hasType(type_Quantity, Var_LENGTH2)) => 
(( ! [Var_LENGTH1] : 
 ((hasType(type_LengthMeasure, Var_LENGTH1) & hasType(type_Quantity, Var_LENGTH1)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(((((f_lengthOfExpresswaySystem(Var_AREA,Var_LENGTH1)) & (f_lengthOfPavedHighway(Var_AREA,Var_LENGTH2)))) => (f_greaterThanOrEqualTo(Var_LENGTH2,Var_LENGTH1))))))))))))).

fof(axTransportationLem21, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfLength, Var_UNIT) => 
(( ! [Var_LENGTH] : 
 ((hasType(type_RealNumber, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((((f_lengthOfUnpavedHighway(Var_AREA,f_MeasureFn(Var_LENGTH,Var_UNIT))) & (f_greaterThan(Var_LENGTH,0)))) => (( ? [Var_HIGHWAY] : 
 (hasType(type_UnsurfacedRoadway, Var_HIGHWAY) &  
(f_located(Var_HIGHWAY,Var_AREA)))))))))))))))).

fof(axTransportationLem22, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfLength, Var_UNIT) => 
(( ! [Var_LENGTH] : 
 ((hasType(type_RealNumber, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((((f_totalLengthOfWaterways(Var_AREA,f_MeasureFn(Var_LENGTH,Var_UNIT))) & (f_greaterThan(Var_LENGTH,0)))) => (( ? [Var_WATERWAY] : 
 (hasType(type_Waterway, Var_WATERWAY) &  
(f_located(Var_WATERWAY,Var_AREA)))))))))))))))).

fof(axTransportationLem23, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfLength, Var_UNIT) => 
(( ! [Var_LENGTH] : 
 ((hasType(type_RealNumber, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((((f_totalPipelineInArea(Var_AREA,f_MeasureFn(Var_LENGTH,Var_UNIT))) & (f_greaterThan(Var_LENGTH,0)))) => (( ? [Var_PIPE] : 
 (hasType(type_Pipeline, Var_PIPE) &  
(f_located(Var_PIPE,Var_AREA)))))))))))))))).

fof(axTransportationLem24, axiom, 
 ( ! [Var_AMOUNT2] : 
 ((hasType(type_LengthMeasure, Var_AMOUNT2) & hasType(type_Quantity, Var_AMOUNT2)) => 
(( ! [Var_AMOUNT1] : 
 ((hasType(type_LengthMeasure, Var_AMOUNT1) & hasType(type_Quantity, Var_AMOUNT1)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(((((f_lengthOfCrudeOilPipeline(Var_AREA,Var_AMOUNT1)) & (f_totalPipelineInArea(Var_AREA,Var_AMOUNT2)))) => (f_lessThanOrEqualTo(Var_AMOUNT1,Var_AMOUNT2))))))))))))).

fof(axTransportationLem25, axiom, 
 ( ! [Var_AMOUNT2] : 
 ((hasType(type_LengthMeasure, Var_AMOUNT2) & hasType(type_Quantity, Var_AMOUNT2)) => 
(( ! [Var_AMOUNT1] : 
 ((hasType(type_LengthMeasure, Var_AMOUNT1) & hasType(type_Quantity, Var_AMOUNT1)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(((((f_lengthOfNaturalGasPipeline(Var_AREA,Var_AMOUNT1)) & (f_totalPipelineInArea(Var_AREA,Var_AMOUNT2)))) => (f_lessThanOrEqualTo(Var_AMOUNT1,Var_AMOUNT2))))))))))))).

fof(axTransportationLem26, axiom, 
 ( ! [Var_AMOUNT2] : 
 ((hasType(type_LengthMeasure, Var_AMOUNT2) & hasType(type_Quantity, Var_AMOUNT2)) => 
(( ! [Var_AMOUNT1] : 
 ((hasType(type_LengthMeasure, Var_AMOUNT1) & hasType(type_Quantity, Var_AMOUNT1)) => 
(( ! [Var_AREA] : 
 (hasType(type_GeographicArea, Var_AREA) => 
(((((f_lengthOfPetroleumProductPipeline(Var_AREA,Var_AMOUNT1)) & (f_totalPipelineInArea(Var_AREA,Var_AMOUNT2)))) => (f_lessThanOrEqualTo(Var_AMOUNT1,Var_AMOUNT2))))))))))))).

fof(axTransportationLem27, axiom, 
 ( ! [Var_CITY] : 
 (hasType(type_PortCity, Var_CITY) => 
(( ? [Var_HARBOR] : 
 (hasType(type_Harbor, Var_HARBOR) &  
(f_geographicSubregion(Var_HARBOR,Var_CITY)))))))).

fof(axTransportationLem28, axiom, 
 ( ! [Var_PORT] : 
 (hasType(type_RiverPort, Var_PORT) => 
(( ? [Var_RIVER] : 
 ((hasType(type_River, Var_RIVER) & hasType(type_Waterway, Var_RIVER)) &  
(f_meetsSpatially(Var_PORT,Var_RIVER)))))))).

fof(axTransportationLem29, axiom, 
 ( ! [Var_OBJECT2] : 
 (hasType(type_Object, Var_OBJECT2) => 
(( ! [Var_OBJECT1] : 
 (hasType(type_Object, Var_OBJECT1) => 
(((f_meetsSpatially(Var_OBJECT1,Var_OBJECT2)) => (f_orientation(Var_OBJECT1,Var_OBJECT2,inst_Adjacent)))))))))).

fof(axTransportationLem30, axiom, 
 ( ! [Var_PORT] : 
 (hasType(type_SeaPort, Var_PORT) => 
(( ? [Var_SEA] : 
 ((hasType(type_Sea, Var_SEA) & hasType(type_Ocean, Var_SEA)) &  
(((f_orientation(Var_PORT,Var_SEA,inst_Adjacent)) | (f_orientation(Var_PORT,Var_SEA,inst_Near)))))))))).

fof(axTransportationLem31, axiom, 
 ( ! [Var_PORT] : 
 (hasType(type_DeepDraftPort, Var_PORT) => 
(( ? [Var_HARBOR] : 
 (hasType(type_DeepDraftHarbor, Var_HARBOR) &  
(f_geographicSubregion(Var_HARBOR,Var_PORT)))))))).

fof(axTransportationLem32, axiom, 
 ( ! [Var_HARBOR] : 
 (hasType(type_DeepDraftHarbor, Var_HARBOR) => 
(f_navigableForDraft(Var_HARBOR,f_MeasureFn(13.7,inst_Meter)))))).

fof(axTransportationLem33, axiom, 
 ( ! [Var_HARBOR] : 
 (hasType(type_DeepDraftHarbor, Var_HARBOR) => 
(f_navigableForDraft(Var_HARBOR,f_MeasureFn(45,inst_FootLength)))))).

fof(axTransportationLem34, axiom, 
 ( ! [Var_ANCHOR] : 
 (hasType(type_OffshoreAnchorage, Var_ANCHOR) => 
(( ? [Var_HARBOR] : 
 (hasType(type_Harbor, Var_HARBOR) &  
(f_located(Var_ANCHOR,Var_HARBOR)))))))).

fof(axTransportationLem35, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfMass, Var_UNIT) => 
(( ! [Var_NUMBER] : 
 (hasType(type_RealNumber, Var_NUMBER) => 
(( ! [Var_FLEET] : 
 (hasType(type_Collection, Var_FLEET) => 
(((f_fleetGrossRegisteredTonnage(Var_FLEET,f_MeasureFn(Var_NUMBER,Var_UNIT))) => (Var_UNIT = inst_RegistryTon)))))))))))).

fof(axTransportationLem36, axiom, 
 ( ! [Var_UNIT] : 
 (hasType(type_UnitOfMass, Var_UNIT) => 
(( ! [Var_NUMBER] : 
 (hasType(type_RealNumber, Var_NUMBER) => 
(( ! [Var_FLEET] : 
 (hasType(type_Collection, Var_FLEET) => 
(((f_fleetDeadWeightTonnage(Var_FLEET,f_MeasureFn(Var_NUMBER,Var_UNIT))) => (Var_UNIT = inst_LongTon)))))))))))).

fof(axTransportationLem37, axiom, 
 ( ! [Var_SHIP] : 
 (hasType(type_MerchantMarineShip, Var_SHIP) => 
(( ! [Var_GRT] : 
 ((hasType(type_RealNumber, Var_GRT) & hasType(type_Quantity, Var_GRT)) => 
(((f_measure(Var_SHIP,f_MeasureFn(Var_GRT,inst_RegistryTon))) => (f_greaterThanOrEqualTo(Var_GRT,1000)))))))))).

fof(axTransportationLem38, axiom, 
 ( ! [Var_SHIP] : 
 (hasType(type_PetroleumTankerShip, Var_SHIP) => 
(f_cargoType(Var_SHIP,type_PetroleumProduct))))).

fof(axTransportationLem39, axiom, 
 ( ! [Var_SHIP] : 
 (hasType(type_ChemicalTankerShip, Var_SHIP) => 
(f_cargoType(Var_SHIP,type_ChemicalProduct))))).

fof(axTransportationLem40, axiom, 
 ( ! [Var_SHIP] : 
 (hasType(type_LiquefiedGasTankerShip, Var_SHIP) => 
(f_cargoType(Var_SHIP,type_ChemicalProduct))))).

fof(axTransportationLem41, axiom, 
 ( ! [Var_SHIP] : 
 (hasType(type_LiquefiedGasTankerShip, Var_SHIP) => 
(f_cargoType(Var_SHIP,f_ExtensionFn(inst_Liquid)))))).

fof(axTransportationLem42, axiom, 
 ( ! [Var_SHIP] : 
 (hasType(type_CombinationBulk_OilCarrierShip, Var_SHIP) => 
(f_cargoType(Var_SHIP,type_Object))))).

fof(axTransportationLem43, axiom, 
 ( ! [Var_SHIP] : 
 (hasType(type_CombinationBulk_OilCarrierShip, Var_SHIP) => 
(f_cargoType(Var_SHIP,type_Petroleum))))).

fof(axTransportationLem44, axiom, 
 ( ! [Var_SHIP] : 
 (hasType(type_CombinationOre_OilCarrierShip, Var_SHIP) => 
(f_cargoType(Var_SHIP,type_Mineral))))).

fof(axTransportationLem45, axiom, 
 ( ! [Var_SHIP] : 
 (hasType(type_CombinationOre_OilCarrierShip, Var_SHIP) => 
(f_cargoType(Var_SHIP,type_Petroleum))))).

fof(axTransportationLem46, axiom, 
 ( ! [Var_SHIP] : 
 (hasType(type_GeneralCargoShip, Var_SHIP) => 
(f_cargoType(Var_SHIP,type_Product))))).

fof(axTransportationLem47, axiom, 
 ( ! [Var_SHIP] : 
 (hasType(type_ContainerShip, Var_SHIP) => 
(f_cargoType(Var_SHIP,type_ShipContainer))))).

fof(axTransportationLem48, axiom, 
 ( ! [Var_SHIP] : 
 (hasType(type_VehicleCarrierShip, Var_SHIP) => 
(f_cargoType(Var_SHIP,type_Vehicle))))).

fof(axTransportationLem49, axiom, 
 ( ! [Var_SHIP] : 
 (hasType(type_RailcarCarrierShip, Var_SHIP) => 
(f_cargoType(Var_SHIP,type_RollingStock))))).

fof(axTransportationLem50, axiom, 
 ( ! [Var_SHIP] : 
 (hasType(type_LivestockCarrierShip, Var_SHIP) => 
(f_cargoType(Var_SHIP,type_Livestock))))).

fof(axTransportationLem51, axiom, 
 ( ! [Var_SHIP] : 
 (hasType(type_PassengerShip, Var_SHIP) => 
(f_cargoType(Var_SHIP,type_Human))))).

fof(axTransportationLem52, axiom, 
 ( ! [Var_SHIP] : 
 (hasType(type_SpecializedTankerShip, Var_SHIP) => 
(f_cargoType(Var_SHIP,f_ExtensionFn(inst_Fluid)))))).

fof(axTransportationLem53, axiom, 
 ( ! [Var_REGISTRATION] : 
 (hasType(type_ShipRegistration, Var_REGISTRATION) => 
(( ! [Var_SHIP] : 
 (hasType(type_Ship, Var_SHIP) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((((f_possesses(Var_SHIP,Var_REGISTRATION)) & (f_flagState(Var_SHIP,Var_AREA)))) => (f_subsumesContentInstance(f_ShipRegisterFn(Var_AREA),Var_REGISTRATION))))))))))))).

fof(axTransportationLem54, axiom, 
 ( ! [Var_SHIP] : 
 (hasType(type_Ship, Var_SHIP) => 
(( ! [Var_AREA] : 
 (hasType(type_GeopoliticalArea, Var_AREA) => 
(((f_member(Var_SHIP,f_MerchantMarineFn(Var_AREA))) => (( ? [Var_REGISTRATION] : 
 (hasType(type_ShipRegistration, Var_REGISTRATION) &  
(((f_possesses(Var_SHIP,Var_REGISTRATION)) & (f_subsumesContentInstance(f_ShipRegisterFn(Var_AREA),Var_REGISTRATION))))))))))))))).

fof(axTransportationLem55, axiom, 
 ( ! [Var_AREA] : 
 ((hasType(type_GeopoliticalArea, Var_AREA) & hasType(type_Entity, Var_AREA)) => 
(( ! [Var_COUNT] : 
 (hasType(type_NonnegativeInteger, Var_COUNT) => 
(( ! [Var_HOME] : 
 ((hasType(type_GeopoliticalArea, Var_HOME) & hasType(type_Entity, Var_HOME)) => 
(( ! [Var_MM] : 
 ((hasType(type_MerchantMarine, Var_MM) & hasType(type_Entity, Var_MM)) => 
(((((f_fOCShipsByOrigin(Var_MM,Var_HOME,Var_COUNT)) & (Var_MM = f_MerchantMarineFn(Var_AREA)))) => (Var_HOME != Var_AREA))))))))))))))).

fof(axTransportationLem56, axiom, 
 ( ! [Var_COUNT] : 
 (hasType(type_NonnegativeInteger, Var_COUNT) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((f_totalFacilityTypeInArea(Var_AREA,ExtensionFn(inst_AirportWithPavedRunway),Var_COUNT)) => (( ? [Var_AIRPORT] : 
 (hasType(type_Airport, Var_AIRPORT) &  
(( ? [Var_RUNWAY] : 
 (hasType(type_PavedRunway, Var_RUNWAY) &  
(((f_part(Var_RUNWAY,Var_AIRPORT)) & (f_located(Var_AIRPORT,Var_AREA)))))))))))))))))).

fof(axTransportationLem57, axiom, 
 ( ! [Var_RUNWAY] : 
 (hasType(type_Runway, Var_RUNWAY) => 
(( ? [Var_LENGTH] : 
 (hasType(type_LengthMeasure, Var_LENGTH) &  
(f_length(Var_RUNWAY,Var_LENGTH)))))))).

fof(axTransportationLem58, axiom, 
 ( ! [Var_AIRPORT] : 
 (hasType(type_Airport, Var_AIRPORT) => 
(((f_attribute(Var_AIRPORT,inst_AirportWithPavedRunway)) => (( ? [Var_RUNWAY] : 
 (hasType(type_PavedRunway, Var_RUNWAY) &  
(f_part(Var_RUNWAY,Var_AIRPORT)))))))))).

fof(axTransportationLem59, axiom, 
 ( ! [Var_AIRPORT] : 
 (hasType(type_Airport, Var_AIRPORT) => 
(((f_attribute(Var_AIRPORT,inst_AirportWithUnpavedRunway)) => (( ? [Var_RUNWAY] : 
 (hasType(type_UnpavedRunway, Var_RUNWAY) &  
(f_part(Var_RUNWAY,Var_AIRPORT)))))))))).

fof(axTransportationLem60, axiom, 
 ( ! [Var_AIRPORT] : 
 (hasType(type_Airport, Var_AIRPORT) => 
(((f_attribute(Var_AIRPORT,inst_VeryShortRunwayAirport)) => (( ? [Var_RUNWAY] : 
 (hasType(type_Runway, Var_RUNWAY) &  
(( ? [Var_LENGTH] : 
 ((hasType(type_PhysicalQuantity, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) &  
(((f_part(Var_RUNWAY,Var_AIRPORT)) & (((f_length(Var_RUNWAY,Var_LENGTH)) & (f_lessThan(Var_LENGTH,f_MeasureFn(914,inst_Meter)))))))))))))))))).

fof(axTransportationLem61, axiom, 
 ( ! [Var_AIRPORT] : 
 (hasType(type_Airport, Var_AIRPORT) => 
(((f_attribute(Var_AIRPORT,inst_ShortRunwayAirport)) => (( ? [Var_RUNWAY] : 
 (hasType(type_Runway, Var_RUNWAY) &  
(( ? [Var_LENGTH] : 
 ((hasType(type_PhysicalQuantity, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) &  
(((f_part(Var_RUNWAY,Var_AIRPORT)) & (((f_length(Var_RUNWAY,Var_LENGTH)) & (((f_greaterThanOrEqualTo(Var_LENGTH,f_MeasureFn(914,inst_Meter))) | (f_lessThanOrEqualTo(Var_LENGTH,f_MeasureFn(1523,inst_Meter)))))))))))))))))))).

fof(axTransportationLem62, axiom, 
 ( ! [Var_AIRPORT] : 
 (hasType(type_Airport, Var_AIRPORT) => 
(((f_attribute(Var_AIRPORT,inst_ShortRunwayAirport)) => (( ? [Var_RUNWAY] : 
 (hasType(type_Runway, Var_RUNWAY) &  
(( ? [Var_LENGTH] : 
 ((hasType(type_PhysicalQuantity, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) &  
(((f_part(Var_RUNWAY,Var_AIRPORT)) & (((f_length(Var_RUNWAY,Var_LENGTH)) & (((f_greaterThanOrEqualTo(Var_LENGTH,f_MeasureFn(1524,inst_Meter))) | (f_lessThanOrEqualTo(Var_LENGTH,f_MeasureFn(2437,inst_Meter)))))))))))))))))))).

fof(axTransportationLem63, axiom, 
 ( ! [Var_AIRPORT] : 
 (hasType(type_Airport, Var_AIRPORT) => 
(((f_attribute(Var_AIRPORT,inst_LongRunwayAirport)) => (( ? [Var_RUNWAY] : 
 (hasType(type_Runway, Var_RUNWAY) &  
(( ? [Var_LENGTH] : 
 ((hasType(type_PhysicalQuantity, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) &  
(((f_part(Var_RUNWAY,Var_AIRPORT)) & (((f_length(Var_RUNWAY,Var_LENGTH)) & (((f_greaterThanOrEqualTo(Var_LENGTH,f_MeasureFn(2438,inst_Meter))) | (f_lessThanOrEqualTo(Var_LENGTH,f_MeasureFn(3047,inst_Meter)))))))))))))))))))).

fof(axTransportationLem64, axiom, 
 ( ! [Var_AIRPORT] : 
 (hasType(type_Airport, Var_AIRPORT) => 
(((f_attribute(Var_AIRPORT,inst_VeryLongRunwayAirport)) => (( ? [Var_RUNWAY] : 
 (hasType(type_Runway, Var_RUNWAY) &  
(( ? [Var_LENGTH] : 
 ((hasType(type_PhysicalQuantity, Var_LENGTH) & hasType(type_Quantity, Var_LENGTH)) &  
(((f_part(Var_RUNWAY,Var_AIRPORT)) & (((f_length(Var_RUNWAY,Var_LENGTH)) & (f_greaterThan(Var_LENGTH,f_MeasureFn(3047,inst_Meter)))))))))))))))))).

fof(axTransportationLem65, axiom, 
 ( ! [Var_COUNT] : 
 ((hasType(type_NonnegativeInteger, Var_COUNT) & hasType(type_Quantity, Var_COUNT)) => 
(( ! [Var_AREA] : 
 ((hasType(type_GeographicArea, Var_AREA) & hasType(type_Object, Var_AREA)) => 
(((((f_totalFacilityTypeInArea(Var_AREA,ExtensionFn(inst_AirportWithUnpavedRunway),Var_COUNT)) & (f_greaterThan(Var_COUNT,0)))) => (( ? [Var_AIRPORT] : 
 (hasType(type_Airport, Var_AIRPORT) &  
(( ? [Var_RUNWAY] : 
 (hasType(type_UnpavedRunway, Var_RUNWAY) &  
(((f_part(Var_RUNWAY,Var_AIRPORT)) & (f_located(Var_AIRPORT,Var_AREA)))))))))))))))))).

fof(axTransportationLem66, axiom, 
 ( ! [Var_HELO] : 
 (hasType(type_Heliport, Var_HELO) => 
(f_trafficableForTrafficType(Var_HELO,type_Helicopter))))).

fof(axTransportationLem67, axiom, 
 ( ! [Var_T2] : 
 (hasType(type_TimeDuration, Var_T2) => 
(( ! [Var_L2] : 
 (hasType(type_LengthMeasure, Var_L2) => 
(( ! [Var_SLOWPROB] : 
 ((hasType(type_Entity, Var_SLOWPROB) & hasType(type_Quantity, Var_SLOWPROB)) => 
(( ! [Var_T1] : 
 (hasType(type_TimeDuration, Var_T1) => 
(( ! [Var_L1] : 
 (hasType(type_LengthMeasure, Var_L1) => 
(( ! [Var_FASTPROB] : 
 ((hasType(type_Entity, Var_FASTPROB) & hasType(type_Quantity, Var_FASTPROB)) => 
(( ! [Var_Q] : 
 (hasType(type_FunctionQuantity, Var_Q) => 
(( ! [Var_V] : 
 ((hasType(type_Vehicle, Var_V) & hasType(type_Object, Var_V)) => 
(((((f_topSpeed(Var_V,Var_Q)) & (((Var_FASTPROB = f_ProbabilityFn(measure(Var_V,f_SpeedFn(Var_L1,Var_T1)))) & (((Var_SLOWPROB = f_ProbabilityFn(measure(Var_V,f_SpeedFn(Var_L2,Var_T2)))) & (f_greaterThan(f_SpeedFn(Var_L1,Var_T1),f_SpeedFn(Var_L2,Var_T2))))))))) => (f_greaterThan(Var_SLOWPROB,Var_FASTPROB)))))))))))))))))))))))))))).

fof(axTransportationLem68, axiom, 
 ( ! [Var_TRAIN] : 
 (hasType(type_Train, Var_TRAIN) => 
(( ? [Var_X] : 
 (hasType(type_RollingStock, Var_X) &  
(( ? [Var_Y] : 
 (hasType(type_RollingStock, Var_Y) &  
(Var_X != Var_Y)))))))))).

fof(axTransportationLem69, axiom, 
 ( ! [Var_CRAFT] : 
 (hasType(type_WaterVehicle, Var_CRAFT) => 
(( ! [Var_EVENT] : 
 (hasType(type_Transportation, Var_EVENT) => 
(((f_instrument(Var_EVENT,Var_CRAFT)) => (( ? [Var_WATER] : 
 (hasType(type_WaterArea, Var_WATER) &  
(f_located(Var_EVENT,Var_WATER))))))))))))).

fof(axTransportationLem70, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_LongTon) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,2240),inst_PoundMass))))))).

fof(axTransportationLem71, axiom, 
 ( ! [Var_QUANT] : 
 (hasType(type_Entity, Var_QUANT) => 
(( ! [Var_N3] : 
 ((hasType(type_Quantity, Var_N3) & hasType(type_RealNumber, Var_N3)) => 
(( ! [Var_N2] : 
 ((hasType(type_Quantity, Var_N2) & hasType(type_RealNumber, Var_N2)) => 
(( ! [Var_N1] : 
 ((hasType(type_Quantity, Var_N1) & hasType(type_RealNumber, Var_N1)) => 
(( ! [Var_N4] : 
 ((hasType(type_Entity, Var_N4) & hasType(type_RealNumber, Var_N4)) => 
(((((Var_N4 = f_MultiplicationFn(Var_N1,f_MultiplicationFn(Var_N2,Var_N3))) & (Var_QUANT = f_MultiplicationFn(f_MeasureFn(Var_N1,inst_FootLength),f_MultiplicationFn(f_MeasureFn(Var_N2,inst_FootLength),f_MeasureFn(Var_N3,inst_FootLength)))))) => (Var_QUANT = f_MeasureFn(Var_N4,inst_CubicFoot))))))))))))))))))).

fof(axTransportationLem72, axiom, 
 ( ! [Var_NUMBER] : 
 ((hasType(type_Entity, Var_NUMBER) & hasType(type_RealNumber, Var_NUMBER) & hasType(type_Quantity, Var_NUMBER)) => 
(((Var_NUMBER = f_MultiplicationFn(1,Var_NUMBER)) => (f_MeasureFn(Var_NUMBER,inst_RegistryTon) = f_MeasureFn(f_MultiplicationFn(Var_NUMBER,100),inst_CubicFoot))))))).

fof(axTransportationLem73, axiom, 
 ( ! [Var_DECK] : 
 (hasType(type_ShipDeck, Var_DECK) => 
(( ? [Var_SHIP] : 
 (hasType(type_Ship, Var_SHIP) &  
(f_properPart(Var_DECK,Var_SHIP)))))))).

fof(axTransportationLem74, axiom, 
 ( ! [Var_AIRPORT] : 
 (hasType(type_Airport, Var_AIRPORT) => 
(f_trafficableForTrafficType(Var_AIRPORT,type_Airplane))))).

fof(axTransportationLem75, axiom, 
 ( ! [Var_WATERWAY] : 
 (hasType(type_Waterway, Var_WATERWAY) => 
(( ! [Var_UNIT] : 
 (hasType(type_UnitOfLength, Var_UNIT) => 
(( ! [Var_DRAFT] : 
 ((hasType(type_Quantity, Var_DRAFT) & hasType(type_RealNumber, Var_DRAFT)) => 
(( ! [Var_DEPTH] : 
 ((hasType(type_RealNumber, Var_DEPTH) & hasType(type_Quantity, Var_DEPTH)) => 
(( ! [Var_OBJ] : 
 (hasType(type_Physical, Var_OBJ) => 
(((((f_depth(Var_OBJ,Var_WATERWAY,f_MeasureFn(Var_DEPTH,Var_UNIT))) & (f_lessThan(Var_DRAFT,Var_DEPTH)))) => (f_navigableForDraft(Var_WATERWAY,f_MeasureFn(Var_DRAFT,Var_UNIT)))))))))))))))))))).

fof(axTransportationLem76, axiom, 
 ( ! [Var_SYSTEM] : 
 (hasType(type_TransitSystem, Var_SYSTEM) => 
(( ? [Var_ROUTE] : 
 (hasType(type_Transitway, Var_ROUTE) &  
(f_part(Var_ROUTE,Var_SYSTEM)))))))).

fof(axTransportationLem77, axiom, 
 ( ! [Var_TS] : 
 (hasType(type_TransitSystem, Var_TS) => 
(( ? [Var_G] : 
 (hasType(type_Graph, Var_G) &  
(f_abstractCounterpart(Var_G,Var_TS)))))))).

fof(axTransportationLem78, axiom, 
 ( ! [Var_TS] : 
 (hasType(type_TransitSystem, Var_TS) => 
(( ! [Var_T] : 
 (hasType(type_Transitway, Var_T) => 
(( ! [Var_G] : 
 ((hasType(type_Abstract, Var_G) & hasType(type_Graph, Var_G)) => 
(((((f_abstractCounterpart(Var_G,Var_TS)) & (f_systemPart(Var_T,Var_TS)))) => (( ? [Var_GA] : 
 (hasType(type_GraphArc, Var_GA) &  
(((f_abstractCounterpart(Var_GA,Var_T)) & (f_graphPart(Var_GA,Var_G)))))))))))))))))).

fof(axTransportationLem79, axiom, 
 ( ! [Var_TS] : 
 (hasType(type_TransitSystem, Var_TS) => 
(( ! [Var_TJ] : 
 (hasType(type_TransitwayJunction, Var_TJ) => 
(( ! [Var_G] : 
 ((hasType(type_Abstract, Var_G) & hasType(type_Graph, Var_G)) => 
(((((f_abstractCounterpart(Var_G,Var_TS)) & (f_systemPart(Var_TJ,Var_TS)))) => (( ? [Var_GN] : 
 (hasType(type_GraphNode, Var_GN) &  
(((f_abstractCounterpart(Var_GN,Var_TJ)) & (f_graphPart(Var_GN,Var_G)))))))))))))))))).

fof(axTransportationLem80, axiom, 
 ( ! [Var_ARC] : 
 ((hasType(type_Abstract, Var_ARC) & hasType(type_GraphArc, Var_ARC)) => 
(( ! [Var_N2] : 
 ((hasType(type_Abstract, Var_N2) & hasType(type_GraphNode, Var_N2)) => 
(( ! [Var_N1] : 
 ((hasType(type_Abstract, Var_N1) & hasType(type_GraphNode, Var_N1)) => 
(( ! [Var_NODE2] : 
 ((hasType(type_SelfConnectedObject, Var_NODE2) & hasType(type_Physical, Var_NODE2)) => 
(( ! [Var_NODE1] : 
 ((hasType(type_SelfConnectedObject, Var_NODE1) & hasType(type_Physical, Var_NODE1)) => 
(( ! [Var_A] : 
 ((hasType(type_SelfConnectedObject, Var_A) & hasType(type_Physical, Var_A)) => 
(((((f_connects(Var_A,Var_NODE1,Var_NODE2)) & (((f_abstractCounterpart(Var_N1,Var_NODE1)) & (((f_abstractCounterpart(Var_N2,Var_NODE2)) & (f_abstractCounterpart(Var_ARC,Var_A)))))))) => (f_links(Var_N1,Var_N2,Var_ARC)))))))))))))))))))))).

fof(axTransportationLem81, axiom, 
 ( ! [Var_PATH] : 
 ((hasType(type_Transitway, Var_PATH) & hasType(type_Physical, Var_PATH)) => 
(( ! [Var_DIST] : 
 (hasType(type_ConstantQuantity, Var_DIST) => 
(((f_distanceOnPath(Var_DIST,Var_PATH)) => (( ? [Var_GP] : 
 (hasType(type_GraphPath, Var_GP) &  
(f_abstractCounterpart(Var_GP,Var_PATH))))))))))))).

fof(axTransportationLem82, axiom, 
 ( ! [Var_GRAPH] : 
 ((hasType(type_Abstract, Var_GRAPH) & hasType(type_Graph, Var_GRAPH) & hasType(type_GraphPath, Var_GRAPH)) => 
(( ! [Var_END] : 
 (hasType(type_Region, Var_END) => 
(( ! [Var_START] : 
 ((hasType(type_Region, Var_START) & hasType(type_Physical, Var_START)) => 
(( ! [Var_SYS] : 
 ((hasType(type_TransitSystem, Var_SYS) & hasType(type_Physical, Var_SYS)) => 
(( ! [Var_PATH] : 
 ((hasType(type_Transitway, Var_PATH) & hasType(type_TransitSystem, Var_PATH)) => 
(( ! [Var_DIST] : 
 (hasType(type_ConstantQuantity, Var_DIST) => 
(((((f_distanceOnPath(Var_DIST,Var_PATH)) & (((f_pathInSystem(Var_PATH,Var_SYS)) & (((f_routeStart(Var_START,Var_PATH)) & (((f_routeEnd(Var_END,Var_PATH)) & (f_abstractCounterpart(Var_GRAPH,Var_SYS)))))))))) => (( ? [Var_EN] : 
 ((hasType(type_Entity, Var_EN) & hasType(type_Abstract, Var_EN)) &  
(( ? [Var_BN] : 
 ((hasType(type_Entity, Var_BN) & hasType(type_Abstract, Var_BN)) &  
(( ? [Var_S] : 
 (hasType(type_Graph, Var_S) &  
(((f_subGraph(Var_S,Var_GRAPH)) & (((Var_BN = f_BeginNodeFn(Var_GRAPH)) & (((Var_EN = f_EndNodeFn(Var_GRAPH)) & (((f_abstractCounterpart(Var_BN,Var_START)) & (f_abstractCounterpart(Var_EN,Var_END))))))))))))))))))))))))))))))))))))))).

